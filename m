Return-Path: <linux-kernel+bounces-177329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D218C3CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330C41F21F16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3DB1474B7;
	Mon, 13 May 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkHc7GBm"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866021474AE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588021; cv=none; b=kNpywk1J6kpn+qdGwHY9r927T8OvwldawWiwJfMT/mNWyohjRKWAULdCTXwHE9puAO87S2f3I1IcMjzvOWebwGXV4HbXJNB7KZP4r6hCeI5XXoADuZznZNYgKHQVopJKz0dArfbOkqc/TZaFHgbGk+I0sa+DZDaCjz6AghtPQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588021; c=relaxed/simple;
	bh=YIQKqIOZYXmscTuG37vONw4ucUlU9ivu87HdRIb+1TM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lBQmr7xWtoJseLj9v1CfFVuZsOKiW54jPFFd+9JcuYH/2JZ3Hi+zGOWB27/iCQcFgaXIryLAP44lWaqNtbrefwvhCGMbtbNb1K24Z1S3JdF2AwKTL+auDIzmWaNEcrJGWuWnlGAdylIRdlZATWT2dLSq5/HqNepYTMhn70WCIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkHc7GBm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso5496146e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715588018; x=1716192818; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=assM+6XN9OQmcsW1smWfiABOlVkB0BksIxd+LRgeZNE=;
        b=VkHc7GBmD0M0WlMh1q8o3yi8S43nmRrND1r81DMs9pfH2U4n61VQ2GpYpiQZRatkBJ
         nRLDwJRRx5qRvzWMfMXyDuQ5171nvECLWOuuA6+DmruNgLlq0a9NfLnDqG/M064/RVa4
         7zwpq2J4UgiLXaOW2SFE0XKMMMUc8I9Kg8/in1+Gs0i6n5RM18nozUHWGAUAfTtWepvK
         AJQqMFjuzSNtSGAg3eQ4Gs7ChFi1OIJcxRR1ZjKQHDMxIl6/nEeIYaVbYC7osLr9oGFV
         UWAIEs8K7EElHHlHb6lw7HvDVepn8qu4LxPPpgpEE2HtPF86gJNPHHf/z7eYxt1JVBHE
         vP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588018; x=1716192818;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=assM+6XN9OQmcsW1smWfiABOlVkB0BksIxd+LRgeZNE=;
        b=SaASTzFUoLowrQ8xfEpSoRcXaHP399b5DnDD0uwNyiEDUUwGsmKdTiO4Avk/w2Jkco
         FC+Sp8spUv4+eNQg7mwqQq0RE+LkeX4vq7e3JY5jNoVAyZ89MPxPGLK+0elad8xBQ9zJ
         MMuaWZQK3YwKLA9Ls8S8KhV23KM2xg81hrXaUlzxtbCxyGiCd99GzGKvGuh8m8p9rq8q
         mDZUHLirEVCtjLf132j2+QLusoxz4V27SH7oVjq0fH053J5OTTpcZoRIjq63SpUAfusr
         4AdI+SFzXjypkwaXcRYw8UMXACj8aYWZqHj55gUr9cUpUDtIXicHwQS3I3tXJXZQ677w
         wICQ==
X-Gm-Message-State: AOJu0YxyflKg5kqGia3O4Tlog+0WOYuK3G5qWgrDt8mGJqjrKPiNHyZH
	PQ/Ka6V60Ams2QwyO4AuTaYR4NizWPrOnXYsMeha3qih/1uG4+D4
X-Google-Smtp-Source: AGHT+IFl65cs5IvrAeaP5LZlyKJA5ypbRuCysspOAhX1ptFvIebw8PC/avGl8sidACTxn2zXL8hywg==
X-Received: by 2002:a05:6512:3b07:b0:51b:de3a:33ac with SMTP id 2adb3069b0e04-5221058453amr7105231e87.59.1715588017228;
        Mon, 13 May 2024 01:13:37 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322be7sm5978831a12.80.2024.05.13.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:13:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 10:13:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/shstk change for v6.10
Message-ID: <ZkHLrqO1HdfQb71Z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/shstk Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-shstk-2024-05-13

   # HEAD: 2883f01ec37dd8668e7222dfdb5980c86fdfe277 x86/shstk: Enable shadow stacks for x32

Enable shadow stacks for x32.

While we normally don't do such feature-enabling on 32-bit
kernels anymore, this change is small, straightforward & tested on
upstream glibc.

 Thanks,

	Ingo

------------------>
H.J. Lu (1):
      x86/shstk: Enable shadow stacks for x32


 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 arch/x86/kernel/shstk.c                | 4 ++--
 arch/x86/kernel/signal_64.c            | 6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..cc78226ffc35 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -374,7 +374,7 @@
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
-453	64	map_shadow_stack	sys_map_shadow_stack
+453	common	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd8d0f8..6f1e9883f074 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -163,8 +163,8 @@ static int shstk_setup(void)
 	if (features_enabled(ARCH_SHSTK_SHSTK))
 		return 0;
 
-	/* Also not supported for 32 bit and x32 */
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
+	/* Also not supported for 32 bit */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_ia32_syscall())
 		return -EOPNOTSUPP;
 
 	size = adjust_shstk_size(0);
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 23d8aaf8d9fd..8a94053c5444 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -315,6 +315,9 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -377,6 +380,9 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 

