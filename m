Return-Path: <linux-kernel+bounces-182935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4788C91EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6F1F21787
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D65339B;
	Sat, 18 May 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQu53FAT"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D2BA29
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716057627; cv=none; b=kUXF5s9sDiCqVkQZaGjNCPF2SlgQeAcZbpRH83CiPTe1Pszq0ELLJf9andeDM6fimhxTvqdRSZg+ri2Bfv4sdKU0TO9gyvFg3619qu9SRaDH1rK932UdbWiOL5ECIiwaa+LwimwoQyzEyKA3qMH1WjQwxhP5PazwtjYsGcL/VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716057627; c=relaxed/simple;
	bh=k+ng9wbRlHf17xens6mhVDQOVRgsDX7w2D+5OLnXe/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXAgxwsw71aF0cmnQfWH1VkVQWf68X0mRMn1NfdlDVRArj1sLoCaAr82L1rmfcqxY9gDx2KtysBLDK59KtUeV4/4lpzOxQGumYfkq19l1n6bIBHL8ToWm5qV0yyLBrZePRFBXTDWB+zUx61WU1vERyBOOzYknlUqR0SNzRQqc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YQu53FAT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecd3867556so43142265ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716057626; x=1716662426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9upi3rN8BKzsNW7vROl/Uoxe3wcuLRhsoKYe8pqaKQ=;
        b=YQu53FAT3nLHbcZLWiC3m/fAwmrf8Wit+32eDsYkcNcBnwRsMbog/nHyNiv2e0aUZb
         UeGvtQYeLORL8m8B+9Aev7V23XBaNmK5jLwEnaSpfmGlqrorZDz1bPLAOXO2kThsJI0N
         idvP/Pbt9/xQtz8e0s8Sc4ql6AXEV/jhmsCLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716057626; x=1716662426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9upi3rN8BKzsNW7vROl/Uoxe3wcuLRhsoKYe8pqaKQ=;
        b=m01Hc2tFOdd+Pfk6oZZhnCiLoVvb4K2miewxIABuubHAFxoLW0Oyd1DUdKZxWXiRvb
         G22dL8VKdhpTdA8Z0J7WwN+0f8DGwkc3umwIhg4eDp29f/flJ04RUSWRvccBCTOdc5ca
         9WUOep2eo/uWzsq3hzV9E+1mvsJHOi5iiO1b5+lT2QRsO4jS0/qEHUHKH79LK6tYizmf
         NoBfVVCkj8I3ng1En7DmXprWsnt1EnG32N9N6vJEBcoCh+MB1R1QbO1LdlUWe526O1e3
         KSuOksOhfKv6BrxseIePu6SBxWu8bLe7bWfIpXpFxvm1yvUwb6B9jlY7b+rMV1xpaGOF
         bb8A==
X-Forwarded-Encrypted: i=1; AJvYcCXMgBC4GKu9YkgMjgMkHIrQZVlThswtb4KGMxvXsJPijndveVjSKBMBqL6huyhzLz9RdUkOmB+dXzlM3Aa3mxRoiZG67YEOAiBwmAFk
X-Gm-Message-State: AOJu0Yx/EBLi5230Gmz6I6TADu53Wh3bPdgvPRWew5iBmrnaW9Uvlc+i
	bfAt1QKQ8IMAnK3dpkmgIIL71AHrXh1CNl0G1tNxGHPUVzuilsqD40h0CVH35Q==
X-Google-Smtp-Source: AGHT+IFuxNtBeIlF7fvjXHDHzCSSJToJGKljZAgnFvVNCJ2Abmnr4AI+2HASVt+rdE1qJz+MVF5s6Q==
X-Received: by 2002:a17:902:e848:b0:1f2:f954:d6a3 with SMTP id d9443c01a7336-1f2f954da5bmr324415ad.5.1716057625812;
        Sat, 18 May 2024 11:40:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm177009135ad.68.2024.05.18.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 11:40:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Fix memcmp() test to be amplitude agnostic
Date: Sat, 18 May 2024 11:40:23 -0700
Message-Id: <20240518184020.work.604-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=keescook@chromium.org;
 h=from:subject:message-id; bh=k+ng9wbRlHf17xens6mhVDQOVRgsDX7w2D+5OLnXe/U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSPYXEB4BYO+wu/L5FgksDzyElF61gFBnWFH4h
 6QXCGgfte6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkj2FwAKCRCJcvTf3G3A
 JpOKD/96VbRsJOyJVRopWjNo7ozzJWVXD1VR3R0yQNoWXOBc99IzaAlIBYFPDcXeu29ehMzMfTo
 dukapW35fOP9PyWTfZvafUf+8WdCeseMc+JyWjr4EDT/1/6zl+80FUrxFgIKH0G/SDbhBz1SLAk
 /4m3KeQ2NkycOvtRjcg1Rhd1DsyYPZ63LMgEGLWjUfCspfwDFuCgIwcmQhbufyWCguZB1XeuRzZ
 10P8FnhIw/n3tYhAYSbgO8tBEyxcxWOxFRov5YIvZfAeufbJoVls5lpxO/tAoS7Eo6/jSPEM4yI
 789unphFYixgC3GtAZDLa3HXV39u1OwhysY2KVZeR/rQhKivKf0wqZ/zKI0d+nCMI4RhftIK+9h
 jX4Em1sseHOItcsIziwJDBFlu/MToSAP/3Zh4JeZ29i+uxj4H0HDgo0cfvh/BnKSIgYX/vo8uFD
 IAaNmAB2wersufzlB1ppMY3BBu6G8aQYOU5NR/yHOBMvfXtTtv/Tt3dpoZ7ODCUeNuM30P+8tfA
 FSEKEm7holwG8gSjGuQCQIVWDHe/NMmQ66gLNxbjr/8qSsfFHAZ6IOnjnrm8V5G4EMoZ7qqIecZ
 77QHSfhDFeNQjRSmigMItL/rhcNTjz/YlcO46iDV8A/oH+5D4Fqh64472UacFpuqK1/nd14eYLB
 bKSeLG7 ChI4Bfzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When memcmp() returns a non-zero value, only the signed bit has any
meaning. The actual value may differ between implementations.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2025
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index d2377e00caab..39da5b3bc649 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -990,7 +990,7 @@ static void fortify_test_memcmp(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
 	/* Still in bounds, but no longer matching. */
-	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 1), -32);
+	KUNIT_ASSERT_LT(test, memcmp(one, two, one_len + 1), 0);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
 
 	/* Catch too-large ranges. */
-- 
2.34.1


