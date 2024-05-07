Return-Path: <linux-kernel+bounces-171288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3638BE23D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FBD1F263BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABD1509BE;
	Tue,  7 May 2024 12:35:37 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9215E1FF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085336; cv=none; b=hsW7eU7b7K2gPTbwxtSfNsjcXp1n+nb0IJd3O5zJeka20ncZ0Gf0niwNMKA3dpLf40gaOlFMaJ0U7STFOAUOhWuDudf1Wu63UmFSmoDjjBm2BIUL1LFyxzuBNRXBZ45s6607GBiFMVO0jlKNdo+/lnhEE0LbUNsF5zBhg9wpWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085336; c=relaxed/simple;
	bh=BOeaLKmGCdfjfOTRkm62sxCYIza5IMMDDnYsPVUQFiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ft5tIlIhVVXgh082HFU8pdpeDfVN6aVWXmk/pW/wCxZF6xAP4E9AjKmFq7rIxxJ7s7j0ovmMtLaYhQs/ghvE1FgRDCERhCXGPREcq48GHM4Ymwjf+h8TxY5y5aPvur0J2HFgbdOQLJccQdd8FrrYkim9vKj35vQyyw+1K0Tsctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.2])
	by sina.com (172.16.235.24) with ESMTP
	id 663A1FFB0000689F; Tue, 7 May 2024 20:35:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 22048545089433
X-SMAIL-UIID: DE8FC96376674BA5A6F6EF6B0A1AD192-20240507-203509-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2b5fbaaa4280010beda7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in sock_write_iter (3)
Date: Tue,  7 May 2024 20:34:56 +0800
Message-Id: <20240507123456.2204-1-hdanton@sina.com>
In-Reply-To: <0000000000000612fa0617dc20f6@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 05:14:17 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1379d9df180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  7367539ad4b0

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -980,7 +980,9 @@ first_run:
 	rcu_assign_pointer(q->current_entry, next);
 	spin_unlock(&q->current_entry_lock);
 
-	hrtimer_set_expires(&q->advance_timer, end_time);
+	hrtimer_set_expires(&q->advance_timer,
+				ktime_add(timer->base->get_time(),
+					  ns_to_ktime(NSEC_PER_USEC *200)));
 
 	rcu_read_lock();
 	__netif_schedule(sch);
--

