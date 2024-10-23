Return-Path: <linux-kernel+bounces-378088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1359ACB33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748F4B229A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9E1B85C0;
	Wed, 23 Oct 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="QYOAeb7G"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07261AD9C3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690148; cv=none; b=X7XPLRJPWs4GSaxfGVAKKdNdoZdorwG4g7cIE+vcMHB3znuBq7GKGAo971Wlxx7GfE3KnN48dDtoavqbG6bDAxPrEssl+llmhyotVqUw3WeZaB+w2NLCNoYoZOpIxrYCgi+dpRPBvCnvMPByf83yfr5ipdNhC3z4W7iRRyM8XYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690148; c=relaxed/simple;
	bh=KywBnJ6zPTZmJYG3G3wLfX8yMpxHMr3g+ZUm5jRHVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2mfnCWmROPUN1EzI5rjBFDTFYSHJkG62J1jvABBmx1rvQeJiMIcmtiY49dVUO2xIOs8pPyHtwZiwa28tBdW9VUB7u5g8AyAxJXNvvCRdbjs32RJHPoAuYDaKBr3bx3U9LEWozyWneTMkxejSHTdAz6ZZP9toNNcMAHVOCmMMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=QYOAeb7G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431616c23b5so6487535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690145; x=1730294945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=QYOAeb7GZVT86nlEnaEh98me916WgG5FEn6YOlb8ojvnBsp+rgXCGp0Fnt6KJTnZuz
         jHRukmGBD47UX6dpzgpCdm6oP51uNBf8VlfwVmbeJwbILwsljP2snWFFpjPkgUfrBAuR
         yXNrR57SJx07UQjpM7IecW9qdQfG6V7KrOrD0h1GuViZ1jLfx0DfPB+tH+nvYu9qJRq3
         pHYCz2ffkwgTSi5SjpZlS8nNDT41isg4gRGAtvjQjVQGdAh2DL8K5og9UfP/kqtDJt58
         8Haang0qawwGvNImZxYyj2MSsTPbOCpY4JWCuoqbmaz3TgGX85iuJQdz7mLC0f2HbBQ9
         3Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690145; x=1730294945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=IBJGd6ssfZ9hWxQ33Ri4Mv86/263g0HpiuSCTaIYsarLlFc3KJ9kAJ6KD2KsUVfzSH
         KUOLmXJ4OeHUTx+7DBAXkoUEgY7pAtLFoRRQtB4McUzSfGkesMqTrtG9joM7Shi+3WPn
         Y7WcgkbfYxKz0DnQVPTqqjx1j+sLLDpUsrZWt7YJPUihBu9D72SNxBjhU0o1JAF2fDLz
         hebeJejteSrBC1jRE8R58RjfWtTz4erJaTRY0yJDLZ1KB/4W0l6XWaxILHwTJsyWUFX5
         GHspc2WXjnjwd2y76V4HnYF6rmsW8j+qvH6lzNJm5WxNMId5bxbR8GXeryvD8wZXK9YX
         Y4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV/U/nuNgGhQspm8saPRcIUG/9TCR5dewOFlQWfUFtkgbSe1xzBYmJOfvsoEwo/gZkDxUrzUoTqPZ5WVE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWOSDtX/M4hh/ATZRMMGiN6BFK53nnq3jzMJLmLkch2Zi9Ehr6
	kLwe+RddkMSDwgBdW4q8w4rkBp/vbNUGom2p++P+5I6cEXDKERR8Nk7clm5k4FbvBEu81OvZhwk
	L
X-Google-Smtp-Source: AGHT+IFRsLCac7qRAy15MMsxz4Dz9HGk8uc62bVXrXo4pUYW8ZB/4MmPI63er7CCScIuvsEmfkowAw==
X-Received: by 2002:a05:600c:3150:b0:431:4e25:fe31 with SMTP id 5b1f17b1804b1-4317be9cea6mr42411255e9.12.1729690144818;
        Wed, 23 Oct 2024 06:29:04 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 19/37] arm: gic-v3-its: Rename objects
Date: Wed, 23 Oct 2024 15:20:02 +0200
Message-ID: <20241023132116.970117-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code accesses the gic-v3 node, but not the gic-v3-its node,
thus rename the objects to clarify which node it operates on.

The following commit will make use of the gic-v3-its node for real.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 2cc0a32f9d..22fa46a341 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_IRQ,
-					  DM_DRIVER_GET(arm_gic_v3_its), &dev);
+					  DM_DRIVER_GET(arm_gic_v3), &dev);
 	if (ret) {
 		pr_err("%s: failed to get %s irq device\n", __func__,
-		       DM_DRIVER_GET(arm_gic_v3_its)->name);
+		       DM_DRIVER_GET(arm_gic_v3)->name);
 		return ret;
 	}
 
@@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	return 0;
 }
 
-static const struct udevice_id gic_v3_its_ids[] = {
+static const struct udevice_id gic_v3_ids[] = {
 	{ .compatible = "arm,gic-v3" },
 	{}
 };
 
-U_BOOT_DRIVER(arm_gic_v3_its) = {
+U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
-	.of_match	= gic_v3_its_ids,
+	.of_match	= gic_v3_ids,
 };
-- 
2.46.2


