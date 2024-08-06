Return-Path: <linux-kernel+bounces-275556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1240E948728
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D421C222E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38CAD5B;
	Tue,  6 Aug 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVamHCWh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED191184D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909704; cv=none; b=OIJV51+ny4bvdeUdnBZg2kR6Fopj56nIT6+Mrqu69s3mQClc+RtXmkCS3W2bHtcu/F7aIgdW0gEgSi2r8HXUZu0M1an6Nsps0JSyGegGaYuISkflIXO88y271P3FGkCLLD8ZcYmBkcJT0aVcdoSlGFU0U7Pmdn8vyAlZMMcogkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909704; c=relaxed/simple;
	bh=yYZvawzGMDPq+ccKvMiG+y0paygheXBb8BODrFmiovc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jt1Ww5WYq+OqEClkuvHJPQ0sOCpu0Z3C5akiZts2YzxWCpYEdU9eWpEG3BDcQxYMEPEWoY+dVtVxnjld4kspLCWy8Aj7jolJD0PoWKvRNKJcubQw4GJn3U82f/CyrbDcO5AIa44Gh3MtUL5PBzljp7uo6AfP0JSNIqntTSL7Elg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVamHCWh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664aa55c690so3677857b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722909702; x=1723514502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrclXbPxc7k+OsvCfqyiA7cTaQluZqiW+2v7tbHuPRY=;
        b=dVamHCWhOxBR2CYb1Pt5HBycKT46EpAt3msGeIXE9bwoojWM/Bk/lAeAB2ZAaVxe5r
         UF5BD+GGlD5uv3aYyTFtuLOTLmh1/1vyOiNW3PeMmljmeYF4tSWg02GERAcOxjEDrlx/
         B0U87Z+lIkoikuq7yshbc1hqN528QqzgwTfq4VtRvK2oBsxbasvsE3a+r5LYHFHxrqlu
         4HAxn+gQj/cZ1g4MwoJ4qi7cDdSI221MFe44S+xgIq9ocEfXnO/a3NScqpg0idj8MdDx
         OkPZpPF0NrgaBXPDAZh5h9QUOI+OrvrJPLDT033aPZ6OgfbqaOuju+S3YoUJ4ygM9GV/
         c8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909702; x=1723514502;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrclXbPxc7k+OsvCfqyiA7cTaQluZqiW+2v7tbHuPRY=;
        b=ML9mLccegcID11Mz7IdEP4VYnH+5UAqn7yA2UdPi4KBcFDXTU7UQfnibe4e5dgFpX3
         hIcdbtkElQNX0PJLKy/k3wNS5aQ3nNn+BYuFhqgHfo48qm7d1aN0zKCuRabSWAmlA9AF
         XSQG4bFBgjd14u3PXvS7sPq5EW9YPEsrt7kmQVObHaGKhnaYr7wQbL8ZpQ6iaFWpsh5F
         vwdBPdYN6+Dm0HiuM/BsnehJNHVyP2V346jCXgkQIhyvaswXF69x+cFHmPJtS0RYdyCR
         qfaQZ/zReMXYGiOgmZEjARdfwHuQivL0+T4Oyt7ROBiSPrORV0qGhEf0ZxqMwAINz7Gg
         zsRA==
X-Forwarded-Encrypted: i=1; AJvYcCVxJBfEqNYZ/fcGuVEcuqegJ0aANliF83tHmHi+eUELUV3764G+J8eXIPhdyQumTx5LON9C8bxmDn9UBLf9MlQebgltOpQ2DpzsE6V8
X-Gm-Message-State: AOJu0YyAGh3I950qR/zcU2z6BCjx2QKws/I1kRmviD35sIrXo3yTvATO
	yMILHDtJSKeW+wtA0dvHDbQDRjgwS0xXXp+J15LIwwhX5+B9oCnGn4xZ9I7iiRnfb8nNkISPiF+
	92MFsnq7/RQ==
X-Google-Smtp-Source: AGHT+IFVyQGN4z12IAVH+p7jnaVWp/Emc818EHEeeiX5g2mVHI0oTfp6EnyTQ6L3zVZpWN1ojVrhtzHHhEUTqg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:fd1:b0:691:55ea:85be with SMTP
 id 00721157ae682-69155eac781mr5317037b3.4.1722909701960; Mon, 05 Aug 2024
 19:01:41 -0700 (PDT)
Date: Tue,  6 Aug 2024 10:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806020136.3481593-1-davidgow@google.com>
Subject: [PATCH] kunit: Fix kunit_kstrdup_const() with modules
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Nico Pache <npache@redhat.com>
Cc: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In commit 7d3c33b290b1 ("kunit: Device wrappers should also manage driver name"),
the kunit_kstrdup_const() and kunit_kfree_const() were introduced as an
optimisation of kunit_kstrdup(), which only copy/free strings from the
kernel rodata.

However, these are inline functions, and is_kernel_rodata() only works
for built-in code. This causes problems in two cases:
- If kunit is built as a module, __{start,end}_rodata is not defined.
- If a kunit test using these functions is built as a module, it will
  suffer the same fate.

Restrict the is_kernel_rodata() case to when KUnit is built as a module,
which fixes the first case, at the cost of losing the optimisation.

Also, make kunit_{kstrdup,kfree}_const non-inline, so that other modules
using them will not accidentally depend on is_kernel_rodata(). If KUnit
is built-in, they'll benefit from the optimisation, if KUnit is not,
they won't, but the string will be properly duplicated.

(And fix a couple of typos in the doc comment, too.)

Reported-by: Nico Pache <npache@redhat.com>
Closes: https://lore.kernel.org/all/CAA1CXcDKht4vOL-acxrARbm6JhGna8_k8wjYJ-vHONink8aZ=w@mail.gmail.com/
Fixes: 7d3c33b290b1 ("kunit: Device wrappers should also manage driver name")
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 16 +++-------------
 lib/kunit/test.c     | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index da9e84de14c0..5ac237c949a0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -489,11 +489,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
  * Calls kunit_kfree() only if @x is not in .rodata section.
  * See kunit_kstrdup_const() for more information.
  */
-static inline void kunit_kfree_const(struct kunit *test, const void *x)
-{
-	if (!is_kernel_rodata((unsigned long)x))
-		kunit_kfree(test, x);
-}
+void kunit_kfree_const(struct kunit *test, const void *x);
 
 /**
  * kunit_kstrdup() - Duplicates a string into a test managed allocation.
@@ -527,16 +523,10 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
  * @gfp: flags passed to underlying kmalloc().
  *
  * Calls kunit_kstrdup() only if @str is not in the rodata section. Must be freed with
- * kunit_free_const() -- not kunit_free().
+ * kunit_kfree_const() -- not kunit_kfree().
  * See kstrdup_const() and kunit_kmalloc_array() for more information.
  */
-static inline const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
-{
-	if (is_kernel_rodata((unsigned long)str))
-		return str;
-
-	return kunit_kstrdup(test, str, gfp);
-}
+const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
 
 /**
  * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e8b1b52a19ab..089c832e3cdb 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -874,6 +874,25 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
+void kunit_kfree_const(struct kunit *test, const void *x)
+{
+#if !IS_MODULE(CONFIG_KUNIT)
+	if (!is_kernel_rodata((unsigned long)x))
+#endif
+		kunit_kfree(test, x);
+}
+EXPORT_SYMBOL_GPL(kunit_kfree_const);
+
+const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
+{
+#if !IS_MODULE(CONFIG_KUNIT)
+	if (is_kernel_rodata((unsigned long)str))
+		return str;
+#endif
+	return kunit_kstrdup(test, str, gfp);
+}
+EXPORT_SYMBOL_GPL(kunit_kstrdup_const);
+
 void kunit_cleanup(struct kunit *test)
 {
 	struct kunit_resource *res;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


