Return-Path: <linux-kernel+bounces-411090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED669CF40F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A73B3A465
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AA1D5AB7;
	Fri, 15 Nov 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OF4TyBHW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD51D5AAD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691369; cv=none; b=Q3bYvw9iYwQQl05Ac3a6KTXe9fL97+hf9c2TCJQlNj9CyyuWTWkm4bh/ty0BwactJ+UHH4KsR5V3cR3Epgo2Z92TZcoW4S3zpz0aw3qj72b9+vROfX7T6++UTPZFTJ+DTBmbdcMBg9ljsec/K4Cr/Ig8kmJs7G+QWIsk/JcxCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691369; c=relaxed/simple;
	bh=xv6EhGIjp0yNQhtdD5CT3ixx8ib+7RX5OoUHS2SRIGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zhy5+Y9LUdNjIVvfmzq08CsHITvKGe4Pf2CtFAM2X3P6SE9MiZ9hVb8YovGtLKt9YOFlTgxajhb6ixaXTzA5eCpVGhfRxlBvmw58ClzXSUddFvEv+qhpDjzMqbQXkE2A8NqfdER5tet/ufJUUWxhR59noATaKvz7Nbf9qHAf3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OF4TyBHW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3313b47a95so3762861276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731691367; x=1732296167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BsyG1LXRA/7W+KV3OjFnPglA0evpVqXbyPXRpQQ0nGw=;
        b=OF4TyBHWZGXYgTpTg9CQivL/MUGaG/q546anjfFwVzoMU5n4dTXmhjDyvtqS4g2yOq
         wk9hvebZnlTFCek0af74CrkluLfpKt4CV6JDzPTgDHRSUVU+fQa2gFt3rIxTT68kzgNz
         /OJtK2uCjsAcMOE3GP22dKLaUvRSz8ewx8IhFqtYYkgchHa3qh+/sLvIBokgKOuzwyM+
         WEl4kurSnKW2kCfPSj1tQPnimhqm8wscQUvdU3jleSIrbwCAjEJK//1dIZqI4AtPFkWA
         /r+3GcMw8fNcVTO1kGQaqf60KwW5cJCoZS+waIvJ2gTudevfqflM7cva151XxGjX6Wxt
         Ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731691367; x=1732296167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsyG1LXRA/7W+KV3OjFnPglA0evpVqXbyPXRpQQ0nGw=;
        b=mI/ia9LHPlbfii9Mf/mbdqZ4PedSSbOompaH1WRYUUjwFUGt/7FydMsSAkD7f5pqAB
         uXATBzt+CIQgW5WwOgvce9BaQGYMtHs2dIsFRltLluPJcIYmSCcwdXDgY8+VcwRZeSR6
         bOjB4L+yqaRD7Tn4aumjWY9vvo/I/rSyME1/2P2fmWqAaeZ9EYf6A4t2uhN/AQXj25Gf
         x54PVHAqGmFG3oRuSr4kGuXWVOW1ZC5GUAkRqm4i1FrEgiqXdJ2t7qMKkdfe6Vww6YPd
         A6y1T0HpxT+lwA3BaNawgUQ8b10T6QUSLRmN0OlKU3VJXQr3pcmPzR2ptNkT/7wGyiwo
         o4XQ==
X-Gm-Message-State: AOJu0YzM5A1p1g0N7O5wqhwOmW88wTVGNV1UWakv/ouuU1Ov+5MmkY/S
	2UItm2XSTd6G8qPkGzFWdCU/jo/HdlQlgm9Phw7pK3wAQ+00pTSbMCvJ5QITuuJsn30cSinnH+c
	KlqDjas9PRFHT2HTyDyTzfDC3olft8ltfwNZGFO5wCXpPzNLUw4kfrOTgiN4nKoLyF5pOetiVwq
	uFNwSM+rrBFcIiXcSIKARYmv0E6gaE0DiR8MThMu4R5Ad52njD4B0=
X-Google-Smtp-Source: AGHT+IGsNFjwDx3jzS5qgLurnITHUTNl+C7edx5Hcxb5uU5DHpf+5tuu5L5h4bcVjOQnEwH2ggCQphITmYa6kA==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:660d:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3826395ad4mr76341276.6.1731691366807; Fri, 15 Nov 2024 09:22:46
 -0800 (PST)
Date: Fri, 15 Nov 2024 17:22:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115172235.1493328-1-smostafa@google.com>
Subject: [PATCH] drivers/io-pgtable-arm: Fix stage concatenation with 16K
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

According to the Arm spec DDI0487 K.a, in:
"Table D8-9 Implications of the effective minimum T0SZ value on the
initial stage 2 lookup level"

Some combinations of granule and input size with stage-2 would
require to use initial lookup levels that can only be achieved
with concatenated PGDs.

There was one missing case in the current implementation for 16K,
which is 40-bits.

Cc: Daniel Mentz <danielmentz@google.com>

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0e67f1721a3d..9a57874a5cb8 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1044,10 +1044,18 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/*
-	 * Concatenate PGDs at level 1 if possible in order to reduce
-	 * the depth of the stage-2 walk.
+	 * Some cases where concatenation is mandatory after de-ciphering RSRKBC
+	 * in the Arm DDI0487 (K.a):
+	 * - 40 bits with 4K: use 2 table at level 1 instead of level 0
+	 * - 40 bits with 16K: use 16 tables at level 2 instead of level 1
+	 * - 42 bits with 4K: use 8 tabels at level 1 instead of level 0
+	 * - 48 bits with 16K: use 2 tabels at level 1 instead of level 0
+	 * Looking at the possible valid input size, that concludes to always
+	 * use level 1 with concatentation if possible or at level 2 only
+	 * with 16K.
 	 */
-	if (data->start_level == 0) {
+	if ((data->start_level == 0) ||
+	    ((data->start_level == 1) && (ARM_LPAE_GRANULE(data) == SZ_16K))) {
 		unsigned long pgd_pages;
 
 		pgd_pages = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
-- 
2.47.0.338.g60cca15819-goog


