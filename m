Return-Path: <linux-kernel+bounces-427662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59249E06D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880B6B645C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299B204F69;
	Mon,  2 Dec 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2h23Gae"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7492040A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148391; cv=none; b=kfjyHGplkSlApcDHV3Q7biYZaVW4w5WUZFyUPQm86JEd4GOB4hw1fGbAK4pWoc20MqOrJu8uH80FetS2BnNfguLMw2PTteP2xK7hoOlAXJyLke0yyUuYQklWFVVPmuSOgELbiNw+GGu/iPVZRrqHAVDU2ZQ4SMy1XodMQTND0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148391; c=relaxed/simple;
	bh=H6HuRlIoB3My5PVxP/KBNeg71dHg7w+qkVYr6BSpMHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h8BYeY2D0cGFWuQNKLkci7bOEMS4yzIyC8arrY+VEEm9gGhS7ZZlPcOAhX/p9fY1epK99UWm4uddDcGOH323CcMyvxtZA7pGBUT/+nZe4S6+glPlE6L25Ye14ib7nOk/1+/apfMFEmOGHt8kYEQgqcFAZX10bFjY6+yJ9GmGfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2h23Gae; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349f32c9a6so35072545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733148388; x=1733753188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKxSUej1+l/0VRK8dY/i8qKE5HDYtkSoqmdKS10eGJE=;
        b=Z2h23GaeHKzZXmABTJENCsjzt0yfhtjeA6jjZHl2BlTn1MpR/fMV9vMUBo6ff5V0aD
         OlUK0O9jcyKJBJ9HrKEfVrHG9y+mj5qOmw1wqYqVQT/vCrmNY/7KYSWBX3EL7m3isbIc
         glxWa0Xctd5gjQK06OiDYWmnrTy6XfJh5NmiImZxq0TmWqf7LgYAQO+LXvS/ZJObLxgJ
         PyzRmbEN8yM9N0aUSiydzSDtDRn6gTeCwL2wEAHPdnsmyvX5z34OzeD3Uy4qkWWp3kso
         uaqFx36pHCpWh3GhgLcDXp/FbPgKtmq7S7btcMVv4NCz+7hDbusqeCFgSOZGC4/Ia5S6
         MorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148388; x=1733753188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKxSUej1+l/0VRK8dY/i8qKE5HDYtkSoqmdKS10eGJE=;
        b=o7TXRY60PFW+igg8mTpDrX9LKKpru68QcoObDzKetNggSGAClLTdz+2Z6iJ1hRLtwp
         5Yg+ET64MctIqpagHtaFeScmNQOjfySwcBl1h4zdcQ+9TTa90hatd55uESaFv1IgKHwu
         CGCiQoQjwPGJQOPO/4RDmuNVkhtpjGsSL8vCPpoXXChpOik4+OM6mexkyW3SlijMUgp9
         XE17M7ejzkJymrxMltZftQOE15VSWMRf4Uv+p+Trah1gOo23i7FUhcB5/mRSP5Vlzb4y
         doFsS7L0NOM53xd8s2Tx8Ei8cRRcRUH5cjP8UsP3duGW6hBseEzJekYgYe/MDMEuP+ch
         YNHQ==
X-Gm-Message-State: AOJu0Yxl7Tb0D2xSLFKfc/zfmNdlQ+c78h8lATzDEYWSFIU3MExw2QuW
	TTVKIDsvcboQdZpipFtfwwsWHei/Ul8X5VDH9HEqCgnXQYxAFIof2OFVYafz+yHHeD/phGNwLD0
	NVjLr62TxihQHHChKBCMyomAApt0E/3oYbyMRpUQy5KJHrZ4jTqjVg6Z6LFMZDLmuEeFXuBMhBG
	JOEXcYnwvBjXUGlWd8Zi3vPi0uVBXdNRhQI6pI7siRO9rs7ZcgH9s=
X-Google-Smtp-Source: AGHT+IGb9GFF+XeRLxQAr2q/gzezFVIRuu1iuJqUMG9tGhoRGftP6XM2BbzyeGE4do1mNb0+j1Ui/wgaLGW65g==
X-Received: from wmqg12.prod.google.com ([2002:a05:600c:4ecc:b0:434:a172:6127])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f56:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-434a9dc1401mr242319915e9.10.1733148388003;
 Mon, 02 Dec 2024 06:06:28 -0800 (PST)
Date: Mon,  2 Dec 2024 14:06:04 +0000
In-Reply-To: <20241202140604.422235-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202140604.422235-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202140604.422235-3-smostafa@google.com>
Subject: [PATCH v2 2/2] iommu/io-pgtable-arm: Add coverage for different OAS
 in selftest
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Run selftests with different OAS values intead of hardcoding it to 48
bits.

We always keep OAS >= IAS to make the config valid for stage-2.

This can be further improved, if we split IAS/OAS configuration for
stage-1 and stage-2 (to use input sizes compatible with VA_BITS as
SMMUv3 does, or IAS > OAS which is valid for stage-1).

However, that adds more complexity, and the current change improves
coverage and makes it possible to test all concatenation cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0055876b3527..62015fdd6c6a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1385,15 +1385,14 @@ static int __init arm_lpae_do_selftests(void)
 		SZ_64K | SZ_512M,
 	};
 
-	static const unsigned int ias[] __initconst = {
+	static const unsigned int address_size[] __initconst = {
 		32, 36, 40, 42, 44, 48,
 	};
 
-	int i, j, pass = 0, fail = 0;
+	int i, j, k, pass = 0, fail = 0;
 	struct device dev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
-		.oas = 48,
 		.coherent_walk = true,
 		.iommu_dev = &dev,
 	};
@@ -1402,15 +1401,19 @@ static int __init arm_lpae_do_selftests(void)
 	set_dev_node(&dev, NUMA_NO_NODE);
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
-		for (j = 0; j < ARRAY_SIZE(ias); ++j) {
-			cfg.pgsize_bitmap = pgsize[i];
-			cfg.ias = ias[j];
-			pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u\n",
-				pgsize[i], ias[j]);
-			if (arm_lpae_run_tests(&cfg))
-				fail++;
-			else
-				pass++;
+		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
+			/* Don't use ias > oas as it is not valid for stage-2. */
+			for (k = 0; k <= j; ++k) {
+				cfg.pgsize_bitmap = pgsize[i];
+				cfg.ias = address_size[k];
+				cfg.oas = address_size[j];
+				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(&cfg))
+					fail++;
+				else
+					pass++;
+			}
 		}
 	}
 
-- 
2.47.0.338.g60cca15819-goog


