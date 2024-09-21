Return-Path: <linux-kernel+bounces-334807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7597DC64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9CD1C2113F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B927155A2F;
	Sat, 21 Sep 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GfOM9E+6"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E16D1B9
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911044; cv=none; b=uS6rhEoGC9L8E3XiVWlTGBAQGISYaSlLfms56CCd5q2Mdoih7P2SNwsc0dt5um07qYIh7PyRVFkVfGd8r2cd5JM2bTMg0dV0D+QJaUw7x4S4LBoezhWcv6Szg56MhjPHZXANNnAXmQ1E8FYc+sjjbmKod6IcwE7YmNQY3U6LMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911044; c=relaxed/simple;
	bh=n5Vk/PreYILiin5QAwkgphv/7jk50vHBmmmY4tsIfCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0PVyCkifJ+ugXbO9FIYxu5kDGsva4ADsQC5RFv/GeSnWEFnW9HSQf0ZcH4BkLpQiU7QnZahTFpce9y4hc/zMo6LeIkwHEILTk7+j6pI5FoIthwCp9XDDZq58iAeKQDrVQqTd+TpfCQf0+50oi76+qFuUdtFr90kJz+Foi1anhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GfOM9E+6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726911040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPVId7sEVW66QbA2u8IGY8vlBSHfd+6xCgbL1e+6EAE=;
	b=GfOM9E+6rIvw3QfiVp5SXDvPrUrf+SJ0zyPbfZll9ZvVMCO0S7sSDKNSnx8tzwuK0KxWsI
	qLWfuFQD4qJvjFoOtpY+gq03Jt5BoaFJywfGcC2RtYJROVm1ueu3gAS9o4pNIclK5uqVWz
	aNOOi9FH7j/w4ANRzPJu90fNRDg18aE=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 4/5] sysctl: delete mmap_rnd_bits_{min/max} and mmap_rnd_compat_bits_{min/max} to save 16 bytes
Date: Sat, 21 Sep 2024 17:29:03 +0800
Message-Id: <5f753895a5f31cac65ddeb56b58fc17553785163.1726910671.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726910671.git.wen.yang@linux.dev>
References: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By directly encoding CONFIG_ARCH_MMAP_RND_BITS_{MIN/MAX} and
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_{MIN/MAX} into the ctl_table's min/max
field, unnecessary global variables can be removed, saving 16 bytes.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Thomas Weißschuh <thomas@t-8ch.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mm.h |  4 ----
 kernel/sysctl.c    | 12 ++++++------
 mm/mmap.c          |  4 ----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 344541f8cba0..e74726059401 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -87,13 +87,9 @@ extern int sysctl_legacy_va_layout;
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
-extern const int mmap_rnd_bits_min;
-extern int mmap_rnd_bits_max __ro_after_init;
 extern int mmap_rnd_bits __read_mostly;
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
-extern const int mmap_rnd_compat_bits_min;
-extern const int mmap_rnd_compat_bits_max;
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 86de15638e31..05197d46007d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2196,10 +2196,10 @@ static struct ctl_table vm_table[] = {
 		.procname	= "mmap_rnd_bits",
 		.data		= &mmap_rnd_bits,
 		.maxlen		= sizeof(mmap_rnd_bits),
-		.mode		= 0600,
+		.mode		= 0600 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&mmap_rnd_bits_min,
-		.extra2		= (void *)&mmap_rnd_bits_max,
+		.min		= CONFIG_ARCH_MMAP_RND_BITS_MIN,
+		.max		= CONFIG_ARCH_MMAP_RND_BITS_MAX,
 	},
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
@@ -2207,10 +2207,10 @@ static struct ctl_table vm_table[] = {
 		.procname	= "mmap_rnd_compat_bits",
 		.data		= &mmap_rnd_compat_bits,
 		.maxlen		= sizeof(mmap_rnd_compat_bits),
-		.mode		= 0600,
+		.mode		= 0600 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&mmap_rnd_compat_bits_min,
-		.extra2		= (void *)&mmap_rnd_compat_bits_max,
+		.min		= CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN,
+		.max		= CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX,
 	},
 #endif
 };
diff --git a/mm/mmap.c b/mm/mmap.c
index ee8f91eaadb9..b5f8949af4a0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -63,13 +63,9 @@
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
-const int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
-int mmap_rnd_bits_max __ro_after_init = CONFIG_ARCH_MMAP_RND_BITS_MAX;
 int mmap_rnd_bits __read_mostly = CONFIG_ARCH_MMAP_RND_BITS;
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
-const int mmap_rnd_compat_bits_min = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN;
-const int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
 int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 #endif
 
-- 
2.25.1


