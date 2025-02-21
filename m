Return-Path: <linux-kernel+bounces-525362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0979A3EF08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C3816EA30
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17133200BA3;
	Fri, 21 Feb 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/5Nbaq+"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2120125F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127699; cv=none; b=a8D+doSVw6l3/2Hxea4N+RAoQd5VGQdJmZbAA81dVm5M9B77xAqxFsIwzJXNTA1zj8LIYDcnIXbpaYI2OgvPINJj7eRCDIojgQIYavui17Ipn8EYhMugWkBuHL4oebfg9lIArnclXC5xnuyNGlzWU9g4BLyqVd5Opkc4hWtMQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127699; c=relaxed/simple;
	bh=m1tPChqnSc/+I1COgrBLsjmH17qUE9x8fPTlWTD6JUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsFw9dHnXcDLOqEAzMTUiQhEyFrEh6Q+F64ow5l8ilI8ZNlyZiKMvPSfFW3o+aM/VYR5hCbE9/iYC/U2hzRZUqnnbF51QPhRzd+eRH03UyJ9QDWsMjbw5XWkjLu8w1ck6gaKW70rVkgXK7S3kGyJ5rmBa2pj/rUZwaM/0f+NfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/5Nbaq+; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-220ec47991aso24426795ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740127697; x=1740732497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOcOfoHtBK2E3+rgegkUkhTDtgbD6buh77xCtXURBzc=;
        b=D/5Nbaq+WpE5ytr57TO7JKHn4gfIS9WAypJ6W1Sx5HRbT30S8kJhvo9qJ4fVXE8B+K
         ID1UZEUPK0kVU0v50bCGtcsZv+4xI7HOzTkQd4Os7FOHMXtAIIhp7uTj5h4ly5G7+jXU
         x1UPjRXDQAOBPkC80ebCcFjbfB7f/GAH4UgeIHkEmWyxb6b/VqvxVLRUKRo5/Atm8a0z
         Aksz65gNOZrFIjqZ9fs/oY2lcAxDrLjriO2zMrCFCe/mCBCmY+W+4Gr5bS7/+xGsTURU
         M6TMTvuTzZ3k9KV6aIOtweW0FWBloMGAKJ3K2YxhEFcS+GhSO0AGGmjvOwQ48vrqBTCl
         t9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127697; x=1740732497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOcOfoHtBK2E3+rgegkUkhTDtgbD6buh77xCtXURBzc=;
        b=w5c/UWxRWrNigApR1k8Mh1lEQwArAZglRpHAuuOnRKbsvpx03sP3mBhf1qLRPtmhVF
         4cApyL7C4cMxxZCZfyWj5yztbhnYw30VE1VAYFSah/r0e8qC/pxamJsMLvqHMfuFIjur
         vEBvIjTBQPtkhBMYAbCmpnKs2Niho5SbPyExeY6FNgZpfaE8RJnjgOdbqMJfyBCHUQnM
         mwy+zfZtmGXpdBiTmD7uqKtc9EmVykPnh1RAQXz9MGWSDAOfk6RXPsXvXgp4qfCXbcKF
         aXvOvPnAEp9m9MUvF0MV9t4b5DrgNWB9TbvS778tWaTok9mserXVnl2Phw4a/3ERgsM4
         xEVw==
X-Forwarded-Encrypted: i=1; AJvYcCVIgLxWPZtmeovkU5+HpuXweQY7L/HNtqwlT7WzSzJPPkxvb/gRRl4buQrd1D1Zm1S2jhoXuklWrI0MUq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwFBy/CvjkauNpbgHtSQxrPTNj5ft5LZ3XmKH0Fs8cn6GN3DA
	9hNpqKm7MyEtrSt1T1gpUhb1Xn6NuMb3x1itHfQpn0zcwmOFSrNR
X-Gm-Gg: ASbGncs+jNhgQEFC9Q/hA7BGqSLKv6x+3pJLwwEit8HP9sZB3B7Dq1JifmRo7KRGAl5
	RmG6jcLKgZSvMHWijOy/3RSIwD5xSH1+JX7ec9ROY1L2IT7Qk+80op9m7km8l/G7uZpH7MpgXpz
	jwv39d1faAkCK4eRFZ5iXzbfqRxLGNKfCcV2uuj95/knaaJhOQhuN73WCCs1JjycOjjA3eXrvld
	ZNSYTEKtsSSt2uvTP72MKoe27oGOsf4Adng4ZytHGcWYKYQVMjeJs4HNur0ockLt5fyJaOcIIkH
	6nK5RC9+DqSX8csgSeBBCb5XU+OzfLKWlJjqjVNptm8P/EhQewwbCc4=
X-Google-Smtp-Source: AGHT+IFPee9g5cWnsjvKUxnUcKxA6+Epp9DDGURxcVQbl61BabtRng+KCZkiXe9RJW1yYEwy6AILLA==
X-Received: by 2002:a17:902:db08:b0:220:cab1:810e with SMTP id d9443c01a7336-2219ff2a633mr35546445ad.6.1740127697156;
        Fri, 21 Feb 2025 00:48:17 -0800 (PST)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:2:6253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364676sm133197955ad.82.2025.02.21.00.48.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 00:48:16 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
To: 15645113830zzh@gmail.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH V1 1/4] sched: Add kconfig of predict load.
Date: Fri, 21 Feb 2025 16:47:45 +0800
Message-Id: <20250221084744.31803-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250221084437.31284-1-15645113830zzh@gmail.com>
References: <20250221084437.31284-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using predict load will make the scheduler logic more complex and take
up more resources. When we are not sure whether to use it, we should be
able to close it.

Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
---
 init/Kconfig      | 10 ++++++++++
 lib/Kconfig.debug | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..83cff5d63ce2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -573,6 +573,16 @@ config HAVE_SCHED_AVG_IRQ
 	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
 	depends on SMP
 
+config SCHED_PREDICT_LOAD
+	bool "Predict the load of se"
+	depends on SMP
+	help
+	  Select this option to enable the load prediction, the load at the
+	  time of dequeue will be predicted according the load at the time
+	  of enqueue.
+
+	  Say N if unsure.
+
 config SCHED_HW_PRESSURE
 	bool
 	default y if ARM && ARM_CPU_TOPOLOGY
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..01b23677d003 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1310,6 +1310,18 @@ config SCHED_DEBUG
 	  that can help debug the scheduler. The runtime overhead of this
 	  option is minimal.
 
+config SCHED_PREDICT_LOAD_DEBUG
+	bool "Debug for SCHED_PREDICT_LOAD"
+	depends on SMP && SCHED_PREDICT_LOAD && SCHED_DEBUG
+	default y
+	help
+	  If you say Y here, the /proc/$pid/predict_load file will be provided
+	  the information of task se that can help debug the SCHED_PREDICT_LOAD.
+	  The /sys/kernel/debug/sched/debug file can also see the information
+	  of group se, but compared with task se, there is less information.
+
+	  Say N if unsure.
+
 config SCHED_INFO
 	bool
 	default n
-- 
2.33.0


