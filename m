Return-Path: <linux-kernel+bounces-386483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F689B4408
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103CA1F23194
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7E2036E0;
	Tue, 29 Oct 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUEeVpVJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34539202F64
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190002; cv=none; b=H9TVuavUx03BBShsATL/mkLvyLPlx24oO3EBL+7OlEfZ8oBu+hrGmMJvIuORDkaSz6loBrech0+yYj3ZHfTky5br2TlGFjipZqM8/yaAaClROc6KRqNQUCpfZFAefyk2OgzcNxZdCyo3vC5pjHnprgKcD26OJRo7LJIQUPEHf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190002; c=relaxed/simple;
	bh=ZpyPq8nnPbgYC0We4+6ik9wif9GBkXt+1UhF018rgHU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n2g5RqFqmKxLsMk9wNtbcOwjX/GHbMWvK+CIKTkSNFhVGGXoyGvFu4yy7Cachq1yteGLAKjluXug7ezmQzu0JNUw38xroEvd6gbAIpZb8ZaCAfJJxg6PI/BG6iy+ht7j8RkoEUV7llYNIvUur1DqTRZ7w7H7RzYLsFe6hAE72y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--locc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUEeVpVJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--locc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so8537474276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730189999; x=1730794799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKZ8uksHUkYhd/wNFB35K9oWSKS5HIyaB23ZVfHBsJQ=;
        b=IUEeVpVJtPPqlDroNAXykh+D+qV/aFZABkCkNSZMbX66EoGnbQEbFGiYMKaiEXBmrc
         ogeFtRRR8Npo0l+eh7P5slpDq7luspkMdW2CHVwB0ZOlM0uAPTeyvmV1W1brTiePNJQV
         W6rsXGfT4Qo8Vsy3yAas09gkgBQqjmkEU+MKW+KonAyDRpgcFL1mwVe7WxkdS14NCe4l
         3SBSaE5DJzF4z9/BG5EJJZcdhgUJ77EBTu+siYlUc3ecEOTDpbljH4jUsWVWOT6CVd8h
         rVBU+a3yJdnLnUMU8e2f3Frc4QerNS946geLUVDdLo15xTXxSUnboRLLMbi1jUJ9+EEj
         O1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189999; x=1730794799;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKZ8uksHUkYhd/wNFB35K9oWSKS5HIyaB23ZVfHBsJQ=;
        b=Npjlm3Joqa4iATBAzJzDJPnhchpBFMRS1t1I3C5IDgs36viz00j5FyVL+F7GWMhTZe
         02LTPlt9JSQsNpbBGl7pN6JtcJ6i9P7rrugDgGVqOdpsS7vYvPd36a2CDk9sh5p8AsX3
         /dD3Si2kldrTqMaR7t17dG8l3d8qwLRkIqggix15TzsTyCKVJznUsTlsIJ48OQziW4gj
         ezSBUunK90En67EYzYtFLhIpPbedbgESNZes1H5MAkd695vuHPNf4gxSGwAJd0pklfyD
         7y0MP7TiNADfXEZWewm/EyPBpVNQq/6QTgZPxf4yOCnUH7jWuZ2Ku8F0HWyL2kzE99ZJ
         MSEQ==
X-Gm-Message-State: AOJu0YwHH9h5zuvf4DlOdVqxLLMjJ0odzIoplL1Anisn4di706/cWE1u
	PfpcwPETXjkqg5MgXBOE7c81fF0WS6f2SdZPmwWChL6EyZ9h6BhwFCFDNQ5NRiDLlnTWJw==
X-Google-Smtp-Source: AGHT+IFbJhZX1w6rKtpH2+UtJ38dc/8iceQX1U8Cx2t6n6NlYYtd3t4yo4IE0B9qoy4cwbRQ07XFVcQT
X-Received: from locc-p620.tpe.corp.google.com ([2401:fa00:1:15:c262:55f7:42f9:dc22])
 (user=locc job=sendgmr) by 2002:a05:6902:529:b0:e30:c741:ab06 with SMTP id
 3f1490d57ef6-e30c741b11bmr435276.5.1730189998980; Tue, 29 Oct 2024 01:19:58
 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029081941.3264566-1-locc@google.com>
Subject: [PATCH] regmap: kunit: Fix repeated test param
From: Cheng-Cheng Lo <locc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Cheng-Cheng Lo <locc@google.com>
Content-Type: text/plain; charset="UTF-8"

There're duplicated elements in the test param real_cache_types_list. The
second one shoulde have cache type REGCACHE_MAPLE.

Signed-off-by: Cheng-Cheng Lo <locc@google.com>
---
 drivers/base/regmap/regmap-kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 4bf3f1e59ed7..3add2aa6d6d8 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -126,7 +126,7 @@ static const struct regmap_test_param real_cache_types_list[] = {
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2003 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2004 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0 },
-	{ .cache = REGCACHE_RBTREE, .from_reg = 0, .fast_io = true },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2001 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2002 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2003 },
-- 
2.47.0.163.g1226f6d8fa-goog


