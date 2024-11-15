Return-Path: <linux-kernel+bounces-411501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95139CFB28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E565286003
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9A19FA92;
	Fri, 15 Nov 2024 23:27:04 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7719D8BE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713224; cv=none; b=MuKx9kyhLwSuSW087NfFtz1YLY/4tXdhJYQ4hBoxnoJZR/+ldCNnMohI5S2ICpuijwngZvoJOkfAkYZx9DhtK09R4NRyqU75GpQzy7VZb9BfIdjXeWOndzZYUG7Vp3ikGAPSJYlLG74ekVofHPoKDJPQbTof5hF666sdRl663Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713224; c=relaxed/simple;
	bh=9b/nKRfcLtMCUN0gJQ0e38f20hplnEuZIXCoyT3NHN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1dtZIvYKaMlnyfaN757q3tPsOFHwhDfMKcHloHGvOuvxWghSqoSomjsOrGlCBpnxJAB+PMyNChK1pmKfS0URXOoqJomDOPgpWAFqPzqeG9HZ+FZGGqZKRc6wFug+XGin3HtSPXzCCT3ITLbHoC8PWU22lXzTu4vJycN+MA7tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.152])
	by sina.com (10.185.250.24) with ESMTP
	id 6737D773000055A6; Fri, 16 Nov 2024 07:21:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 97472110748361
X-SMAIL-UIID: 63209B83991B4FF29F828580A467543A-20241116-072128-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
Date: Sat, 16 Nov 2024 07:21:17 +0800
Message-Id: <20241115232117.3774-1-hdanton@sina.com>
In-Reply-To: <Zze1Jj4_pzOL1bzp@pavilion.home>
References: <20241115115401.3701-1-hdanton@sina.com> <673738b2.050a0220.1324f8.00ac.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Nov 2024 21:55:02 +0100 Frederic Weisbecker <frederic@kernel.org>
> 
> Can you test on git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> timers/core instead?

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core

--- x/kernel/signal.c
+++ y/kernel/signal.c
@@ -2003,9 +2003,15 @@ void posixtimer_send_sigqueue(struct k_i
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
 
-		/* Paranoia check. Try to survive. */
-		if (WARN_ON_ONCE(!list_empty(&q->list)))
+		if (!list_empty(&q->list)) {
+			/*
+			 * If task group is exiting with the signal already pending,
+			 * wait for __exit_signal() to do its job. Otherwise if
+			 * ignored, it's not supposed to be queued. Try to survive.
+			 */
+			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
 			goto out;
+		}
 
 		/* Periodic timers with SIG_IGN are queued on the ignored list */
 		if (tmr->it_sig_periodic) {
--

