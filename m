Return-Path: <linux-kernel+bounces-387588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8D9B5348
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572801F23E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9D207A39;
	Tue, 29 Oct 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aVYBws5k"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E3207A12
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233250; cv=none; b=mWSqhOMmIM8S2p4YM4lYpCVOREmkWvOcESuD+iOW5oZjegWO9jyDM+9PEZCoJFGPbYobBqoldXQCHJ+NN7AlExTiXiuHQnNaH/zFMcKsV4J54OyHgNcp4/oRAzppaZC3CThopMVXGY5qf2W9iMjfbv02WuR/mPtlQ13Hegh+yf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233250; c=relaxed/simple;
	bh=RZBBsApnlgF1Ci2nfqhR3Jj7bCjvEKsJcrRAsuJZmfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLHrbMIS8z+YXFumf+bEhM38FrxvRHD5a9FbdqBxuZ9FGcnX3W7t7/rtS1YD655KPq9qgN7g4A9X9VWw1iycf7ywhuO9u8EaiJIfrnBbWiUI+ezz6jMyCQt+EJLWSafF0J9dmQ0sQ7kwcds5ZHhjPHhLNohdu62+dOQxn1s2Jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aVYBws5k; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbd005d0f9so36029986d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233248; x=1730838048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy7XVkWRraFdetQ8jpQD3fWOiMh3kGBraLt2py6f48c=;
        b=aVYBws5kDWUytiHAI2dH2ovhlS/HgdZ8EQjGQ58KqRu3dc/hOe9LocgdZQVFjjvds/
         KkboSCYSqTx5U9kxtp6+Mqiuf4fAec7JWOOrprn0ia33gI1u9rspy5EcIaxARy55dgBY
         b1lcM4xPyRvrh5yYqbwj8TAEtZ98lrB2I2PTS0xKHLatNJNwYLaVY9sDDF8cROTq8KMS
         PJLS0PtHYXUFG+rOVWr9td56V6dEgypEIkgOTCbA4HOcDL4b81jznFQA6emOsXyiWhsN
         dfzVlWIWKqQ4EyZHtOUAfuI9IJUSmuNVg6wxdQYD+Yrs+yKOJypc5NGZAld2QSm6XXZx
         /ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233248; x=1730838048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy7XVkWRraFdetQ8jpQD3fWOiMh3kGBraLt2py6f48c=;
        b=IByZzh9Q5YAqNytp9qpLzR6QOi78dS7wEexPo9ddzCKn3JFYa3P62schn2vHUeTjJ8
         JjUzymgGt9SwcJUBUI0MC1ZXPz95FW9YV9VAep+PWEGzn+qcg7juLOdXS010cmeGcGSL
         47pgkFHppBSOCXmM1ZB7xD8WrI/W1dcgjw4tLtfUuIFvhGyamheTVlE0mBx4jt0voHby
         +B1vmYUgcCRhOEw8Mw0nDTlmvUTiM+2l9X1ThfPj+YrywFe7SfasPgZIFB/QUte33KF4
         wXpnxxQmeH3SzphkNcUzwEblQRyP/N4/7e1Gnu6xF2UXLkntrvzuKpjqWFdXnN0yZ0hO
         906g==
X-Forwarded-Encrypted: i=1; AJvYcCXyOrL7IQnxcz6GAWazSsvKFx4k6lFc6Re0O8+hv13reqkGzkyryYY5NWJbREcb9uNtKhDUu/DpTvqGV2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG38E9282lHvm8U4u+A00UONbiNZsdaoNOaNaZ6Wasn+otFMDN
	lek/Ce1tnWxHuxaQtIorW3PcqkS/zv/z2rX+jH7Celsygt8TdTB8NxMM2oD1pzM=
X-Google-Smtp-Source: AGHT+IG8wR2VNJGr8w4nEF8K7TLnCCm88h4+MvvrazJR7tXK1WVS/iZtDKaRFV9lJM5ZTXQsS64Xjw==
X-Received: by 2002:a0c:f40c:0:b0:6d1:7434:55a4 with SMTP id 6a1803df08f44-6d1856c7483mr158035446d6.19.1730233247766;
        Tue, 29 Oct 2024 13:20:47 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:47 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v4 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Tue, 29 Oct 2024 16:20:41 -0400
Message-ID: <20241029202041.25334-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029202041.25334-1-gourry@gourry.net>
References: <20241029202041.25334-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/srat.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..a24aff38c465 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -338,12 +339,26 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 {
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
-	u64 start, end;
+	u64 start, end, align, size;
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
-	end = cfmws->base_hpa + cfmws->window_size;
+	size = cfmws->window_size;
+	end = cfmws->base_hpa + size;
+
+	/* Align memblock size to CFMW regions if possible */
+	for (align = SZ_64T; align >= SZ_256M; align >>= 1) {
+		if (IS_ALIGNED(start, align) && IS_ALIGNED(size, align))
+			break;
+	}
+
+	if (align >= SZ_256M) {
+		if (memory_block_advise_max_size(align) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+	} else {
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+	}
 
 	/*
 	 * The SRAT may have already described NUMA details for all,
-- 
2.43.0


