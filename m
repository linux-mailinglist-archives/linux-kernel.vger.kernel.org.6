Return-Path: <linux-kernel+bounces-369701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B09A2157
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C2328934C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A591DC734;
	Thu, 17 Oct 2024 11:42:00 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5951922CF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165320; cv=none; b=dNArrd+2+eGPsuH1bwPw07ag3eztruSCFn754i0c/zMReoat3Tfdi/lo0pNPzBtZM3ACuL68xSTypGrrHz2m/mwm3HdnLo7+aFHyQBn8MAU6LU8yYwpnP5c2vdCRCLBsg2lcrRbnPa4YT6XehDkIZhzLalyRyEUWQjgig57G3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165320; c=relaxed/simple;
	bh=pkwjYMKa+senztZoorF8i0tIDopMMjUbI6qPxsoTdn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmBSwDWjSEeYjesG3KJDq5VM0RN6OPoLa32WQhxu78Aku72Ahz7tPXrvk9R0yPNyKGmSWN1GBtf/wojZ0xEL573eFhZB0SV+tJko+owQMv2Gx62TIB4gK3KhWrVyMseNHgX6FrlrTmyaTEXLGmWEXUDIsnKj8K03BHi6ir/Fy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.59])
	by sina.com (10.185.250.23) with ESMTP
	id 6710F76A000026F3; Thu, 17 Oct 2024 19:39:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2332768913489
X-SMAIL-UIID: E9B7D3588EE7445DB8884F9B7DF6829E-20241017-193926-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c4cf28ed38d86d6b549d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in seq_read_iter (2)
Date: Thu, 17 Oct 2024 19:39:15 +0800
Message-Id: <20241017113915.2052-1-hdanton@sina.com>
In-Reply-To: <670fe136.050a0220.d9b66.016f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 08:52:22 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9e4c6c1ad9a1 Merge tag 'io_uring-6.12-20241011' of git://g..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161bf840580000

#syz test

--- x/virt/kvm/kvm_main.c
+++ y/virt/kvm/kvm_main.c
@@ -6387,7 +6387,7 @@ static void kvm_sched_out(struct preempt
 
 	WRITE_ONCE(vcpu->scheduled_out, true);
 
-	if (current->on_rq && vcpu->wants_to_run) {
+	if (current->on_rq && !current->se.sched_delayed && vcpu->wants_to_run) {
 		WRITE_ONCE(vcpu->preempted, true);
 		WRITE_ONCE(vcpu->ready, true);
 	}
--

