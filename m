Return-Path: <linux-kernel+bounces-516431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D99A37159
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351F216FB83
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514381FCCE1;
	Sat, 15 Feb 2025 23:42:53 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D11A840E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662972; cv=none; b=mJX4Uz8vm5EzwMALPHobfF6FNMuitEkcz0pIFLgjRuEYq0DQdX1DS6gSRy36w9EXbmDn3aIStxIOxvKiB2q8JhvgN0muAw0aFlDspZqNPDgDR2/ZejbsluW0XWmk/nykTFFDSsI7YHMFJON4G5Wr1GGGO5hbKCk7Z0+mle4sADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662972; c=relaxed/simple;
	bh=cObdMpMUQPwEBleYCvz83wWf/COd3IWERsv4lStGwN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqC+xzmpVioxD25yFiQxroCAYHq+cInB32OErZwjl9Li4Q4AvFI50afd5uQ0xuKYmDUg2B/YROLMeFSMEBZvqoxXUghnu9GI4G4LH8VZaHFJ6EuE4dZKuN6x4cHaSmQQysOrVf1yf7yjTGUdU961BopbypUlFLp1eZKzStNNWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.159])
	by sina.com (10.185.250.24) with ESMTP
	id 67B125E20000360A; Sat, 16 Feb 2025 07:40:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 33953410748404
X-SMAIL-UIID: EFD174A50DF446E1B783603F10E6E3BF-20250216-074020-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] BUG: corrupted list in loop_process_work
Date: Sun, 16 Feb 2025 07:40:07 +0800
Message-ID: <20250215234008.2328-1-hdanton@sina.com>
In-Reply-To: <67afa060.050a0220.21dd3.0051.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Feb 2025 11:58:24 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    c674aa7c289e Add linux-next specific files for 20250212
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e18aa4580000

#syz test

--- x/drivers/block/loop.c
+++ y/drivers/block/loop.c
@@ -1974,7 +1974,8 @@ static void loop_process_work(struct loo
 	 */
 	if (worker && !work_pending(&worker->work)) {
 		worker->last_ran_at = jiffies;
-		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
+		if (list_empty(&worker->idle_list))
+			list_add_tail(&worker->idle_list, &lo->idle_worker_list);
 		loop_set_timer(lo);
 	}
 	spin_unlock_irq(&lo->lo_work_lock);
--

