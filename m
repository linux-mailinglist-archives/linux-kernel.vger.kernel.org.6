Return-Path: <linux-kernel+bounces-355493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592ED995318
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD29B27006
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682D1E0B68;
	Tue,  8 Oct 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GxhwUoM/"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266191E04B7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400535; cv=none; b=GImj/5nXbWEeUDkcesUTk/vMjaX3hU+u7gXnoOmrQ28Jchrvz8ozmN3Xv5Qjsni/Zc5/zQ4BssOTsz1c1vqZ7qj8cegoa/8rKtOFskXIH8z8Br7Y7qsCFsWdJfociAbTNtCmfCEs/rMtWvaQswlZ/Mpz1MNDOeU+7G3Xgl95Wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400535; c=relaxed/simple;
	bh=C3265iemyrhxIzFF1YJpIsKQaxeFqQxMECIMXfeP3x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsCyUJQViu+gyvOhSF1fibBBHt3bEuKaZHVp2DBGwKPaP+IX6K5v6ywOvLX9mtB+uwAqkSYWP28PgLIT3Yr/Qp0VrmCqwZs4SkQGMYHubiIHnMCnIaxq7Bl8EMxbN9E8+PrJGsceoJ5NYVMwZdP8vcx80i+WADpAZW949COBsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GxhwUoM/; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728400528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daH29qHYE0MCAAnhFtSLBrnxdN20NU+0savZS+vkNn0=;
	b=GxhwUoM/Aihg2UE4wSgb2u693XzfNo/wOd4YUnJNoIbbIvHRUCTBMVdfZlNGInIjYFPJ+a
	zbjYiftrXYoD7iREAAWzZrhXjD/WVXqjvm6jk0aSQsJvYP9BAJwNhmRhAqdW3ha/Deh54F
	DTNIZbzzwXbv18ANLzQuQf7wUwvFvvg=
From: Wen Yang <wen.yang@linux.dev>
To: Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [RESEND PATCH v4 4/5] sysctl: delete mmap_rnd_bits_{min/max} and mmap_rnd_compat_bits_{min/max} to save 16 bytes
Date: Tue,  8 Oct 2024 23:14:07 +0800
Message-Id: <20241008151444.12453-4-wen.yang@linux.dev>
In-Reply-To: <cover.1726907948.git.wen.yang@linux.dev>
References: <cover.1726907948.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By directly encoding CONFIG_ARCH_MMAP_RND_BITS_{MIN/MAX} and
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_{MIN/MAX} into the ctl_table's min/max
field, unnecessary global variables can be removed, saving 16 bytes.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
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
index 6549d0979b28..9d9c4a4f4708 100644
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
index d0dfc85b209b..8ed6f0d31d95 100644
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


