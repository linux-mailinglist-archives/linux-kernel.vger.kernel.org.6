Return-Path: <linux-kernel+bounces-410606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A09CDDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408161F20FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D01B85CC;
	Fri, 15 Nov 2024 11:59:51 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3127192D8B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671991; cv=none; b=Gab5Dz1okXVlyM+FKTHxccHKqGVWzktKq10J5/+SmE5KrNCUgf/HMQvmfjvZu8Dg9b85N6DZvraUBxQNNy0z2uux6kq7EV3Gdk/wbAQSHtnDsQBvG89eIdMaWK4qs/CkfOEUYyyMTjWn0CcXCwMa8cgvAGlGrZdjrMNT2FuaVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671991; c=relaxed/simple;
	bh=XddeauN3/ObPYt2c5xEOf8RevQ8sUh5W0rxnOkgJToU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuyaMcTy/OKw8T9QFUsF6sOgolGF/DL1t9BeW18Inwf/o3IcZ+tw0kSROfVVGx3QL3VBAMxF9eloUR8iM2hyCpp9vgDkBJRnKaxxfLx0d8A6MU/qS+fAuXwgNZP3ZIxoBnRTBwnwOasU57/tQ1ZtlYbrmwxPn2Vf2NTStnq+EEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.6])
	by sina.com (10.185.250.21) with ESMTP
	id 6737365F00006C0B; Fri, 15 Nov 2024 19:54:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5570963408370
X-SMAIL-UIID: CED635E2AC664741BA0D9E98966E66C5-20241115-195413-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
Date: Fri, 15 Nov 2024 19:54:01 +0800
Message-Id: <20241115115401.3701-1-hdanton@sina.com>
In-Reply-To: <ZzYqE-L-9Ga3Fe7n@localhost.localdomain>
References: <673549c6.050a0220.1324f8.008c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Nov 2024 17:49:23 +0100 Frederic Weisbecker <frederic@kernel.org>
Le Wed, Nov 13, 2024 at 04:52:22PM -0800
> > syzbot found the following issue on:
> > 
> > HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f714e8580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
> > dashboard link: https://syzkaller.appspot.com/bug?extid=852e935b899bde73626e
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f714e8580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1657b0c0580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5854 at kernel/signal.c:2008
> > posixtimer_send_sigqueue+0x9da/0xbc0 kernel/signal.c:2008
> 
> That's because prepare_signal() does not only return false when the signal is
> ignored but also when the task group is exiting. It's possible that the task
> enters in do_exit() with pending signal and then the timer is reset and a new
> signal is queued before the sighand dies.
> 
> This should fix it:
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index cbf70c808969..10b464b9d91f 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2003,9 +2003,15 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
>  	if (!prepare_signal(sig, t, false)) {
>  		result = TRACE_SIGNAL_IGNORED;
>  
> -		/* Paranoia check. Try to survive. */
> -		if (WARN_ON_ONCE(!list_empty(&q->list)))
> +		if (!list_empty(&q->list)) {
> +			/*
> +			 * If task group is exiting with the signal already pending,
> +			 * wait for __exit_signal() to do its job. Otherwise if
> +			 * ignored, it's not supposed to be queued. Try to survive.
> +			 */
> +			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
>  			goto out;
> +		}
>  
>  		/* Periodic timers with SIG_IGN are queued on the ignored list */
>  		if (tmr->it_sig_periodic) {
> 
Test Frederic's patch on top of the next tree.

#syz test

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2004,9 +2004,15 @@ void posixtimer_send_sigqueue(struct k_i
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

