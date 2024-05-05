Return-Path: <linux-kernel+bounces-168871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667E8BBF17
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B786A1C20B42
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2C17FF;
	Sun,  5 May 2024 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FWcJWm9/"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9F17C2
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714878980; cv=none; b=T1aWtDZOx0LgcOSza1VEtx0LC7+zaj3OkNUYE/xFaw/AsYeFMMELg4034F4aXLcLapWzv6oGCGserbftO5a/kMFz5pLCg33s7yPZxrdSH57O099U3gzuk2dVMWQAMqCHWrrKsSqm9D7evMRR8GwryT470o5sN7XscCiht9fGVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714878980; c=relaxed/simple;
	bh=0FaIzfgtCynjRGiKPeK4J+THmJukbDVzWk4Yo3aSyvc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ch+7XUxd8blSsajvQi8JEYGt187norXu82Bytgc1qrPnwpc3XWahi5g2ZHGZR0oN13lA4XCuwW0taoCj0UXxdfwRHapruSYo/IX5FS/m+3k+pj9VKVdhUzi+HlWvG6uMHTE+5hk0saOatAKPZtSKNu9uNh9KH0uePVi+Vz8GpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FWcJWm9/; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714878970; bh=BKltoZxEW3Fhd/7Y3AbGUBFMuBU8P+YdCfL37diK5+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWcJWm9/U4IWK3LPlrdrZcnSeh8laS1HsG1RPRSoxpvk9x32fNaVBBFtQiLkOQHNA
	 LJHvZ+8UAsnynT0zXKzK124e7mjo/zAirCB5DAAFzFuj7HC7zSP3xm6gB6A3us8LwJ
	 Y+2w592mujMGy/qK2wcyRtg+usu5BMFVL1VFLpvs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 1F42EE70; Sun, 05 May 2024 11:07:52 +0800
X-QQ-mid: xmsmtpt1714878472t4num8ufv
Message-ID: <tencent_7040976837B44ADE740F760F669A3C493609@qq.com>
X-QQ-XMAILINFO: NuUrzLQkNC6XlnxoPTX3MTt9s5V4hgz87wKCWShZ0y20xnkIpEctfCKRvi9142
	 YcvR5bI33QFVOub6yScW/gRYtdd7ATC0hl3sATI3jY4oHOnRfs6gyNLaYAtGLEySTMZipyBF8S+H
	 DvbzJ3O67jwotC9gtrqsJtzrv01Uw64oGFtlzRTwFLNGi8FwBaB4D58P99tM1chnw9k4UzQC+RzY
	 EB/Iu7MwrY9pmbajh0g1sviVe5tsIq18Z1jV2+OG2vCnEPlrXOQlWrJ+e33uxdrozPdv82/3GLEz
	 PahplKjfqTQ4r6j1WSIuKxNyqFYMSPv4IncetV+jywNcW0Xrp5tynwzpxEEQtfKNWQrhab0155lE
	 Eoh16Jz7HjlkILkHsTty2kZvn1lVtTVd2IDHlnPeUAJ+pu/cVlo9Il4CicV8ksQvU/nffW4Z+KRP
	 3chFUuQ9hEBDz5jKTM9VdpzjWTbXiwb0BYYl4QJ58AJZkSMm9X5af5pYqUu5F1z1OKG96EGutIDA
	 qJnIJnbks47aF3B07CPFMs65WMbOpYGxnvvo64/s0VUSE8ygoANOd8TXASDqBcuhZk62jFE//klc
	 Y3567MoxS+LS258M3XItzLEmS9cXCrAjgXsopJlsyLdoeV59kX7o7ueVu8gQ/vfbexs23h9kRZ9Y
	 P7SGh8/5heJUMSqSgr+WiAK+xCskMviN4ZO3/QtVkIXh1zxjIZ4yk+wK7oyUPku0A61t1eDHgFwx
	 Ju7QL/DPIe0hALCBR9AwkEhr9UtoocGuav4zpPh37Tg01MKHIOczfS4cj6I7FrwqLZBe/sHjuUWt
	 5fg1CfaB41M07zeuyQKGFDatEcF8Wgpd4n+CON+QjcI5k5ECJqdOp6diCo+AnFhjztBeKPRQ8ETw
	 Q0uuDl6Jj3M+Qkx+2EY6/Nis5Fd470IhGsi4WWf1+zSVqPe8ulynQ9wJ8G+vMRdg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
Date: Sun,  5 May 2024 11:07:48 +0800
X-OQ-MSGID: <20240505030747.1267535-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in vhost_task_fn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git bb7a2467e6be

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b315b21fb28c..02582017759a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 48c289947b99..8800f5acc007 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -61,8 +61,8 @@ static int vhost_task_fn(void *data)
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
 		vtsk->handle_sigkill(vtsk->data);
 	}
-	complete(&vtsk->exited);
 	mutex_unlock(&vtsk->exit_mutex);
+	complete(&vtsk->exited);
 
 	do_exit(0);
 }


