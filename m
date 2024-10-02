Return-Path: <linux-kernel+bounces-347281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939E98D075
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B11F22231
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F5B1E4118;
	Wed,  2 Oct 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FZbP5cry"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AC1E201E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862742; cv=none; b=Q0FH54kgj7mimhr2HX9PvkkdfQX65akpoeg/EBQ3D+5GeAOKf/0SEYMVY90BFp/Vk2gYH3nGbnncVAv1/X/0Z88dZW/UUKDG/0+6jP3ZsPTuy6WnkzAHsOLZJ9Uw6rUEMdPIm0eYr0BarYA4VNmguNI34Sdb7/QOhhchHTpymFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862742; c=relaxed/simple;
	bh=KywBnJ6zPTZmJYG3G3wLfX8yMpxHMr3g+ZUm5jRHVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4GzEl8KWhMGtgqG7SZOjsLip6FjyIeJI9ZU3or7pXoTy7caRGw5OxH+/vtygR30SASOXQIEzZXKb62ajSak+AgW7K0Ypl/js7KzNkxbsbmFdhaCC43Qfe5N1/Zj/g9inLjVNd5vvLHf6Bw4vbFSDdTHrx37IJ9Mb/23dVCpQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FZbP5cry; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so53409405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862739; x=1728467539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=FZbP5cryMgdoQ74AHTZadGTg9mdTvxLW5j/yQ1DB8+vboeIJkhAhKGQ2R/9EqxcwEo
         fjlVJe3P4SUOTxB/XkCXbBFCtb7f1OENputwUWgrx6+oynBe61ysnw29ghbNlQEqUY+7
         E/MMzMHdNejJ6tdFbMfCMsoO96Pvl+z3d1WCZPzbzpV4Zmwo1G0XbTsCCYno/0gZIkN0
         ZcC/MQb0ns6BKhEM9tNaka5vWu+hGf39aJobslWLutIrDZRmdDNaFEZQmATI6Ll0bpOA
         rX92qLGu6k/YSGW9+Mbu34WLtuLMOaf+0uN7P36sAUvofF3cA51cNCpaPv9zETF63vDp
         2A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862739; x=1728467539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=HP3y4eW9x8XzkcguwgHN++o7C/YrLXqFtCaN9KbWDQvUuk+rohocEBZToXopeW+t/v
         zFdY90EmYAB8skir6plDvZr0EG0l2i7c3hvFY4qtE66VlRPYgZTxGpmfItqR8xHRN1VS
         q8UXSMJDht7fB+by8Qf8Qt9eh7jsd9kLbtlYI781cSowaoheQW2/UQRAYpI/Zerrwa8H
         wThLkIfJxzfyMyWir7CezCbbXvORD90+8UrDKfh4kX63NeBmLVtORoahy8aACGRHuS73
         i4m5Oy43ewNQa3SLt91G3r1AN8Q/72eUhw/U8NHCKPA+VopqGO7ujptU3cX8S4lEZwlS
         aiOw==
X-Forwarded-Encrypted: i=1; AJvYcCUAPIcj8vxMmWLH8Be//XramT6n3VLnr3WZwSFSTpsSbeudbQOl6V5VD25B4FgH1/qwR8gnLU1NA+QKkwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jzOrQyFs0RwV5E2VfE6+ccL+zZhwrNZL1bAj6SAd7DOIXDjS
	NAVFyd0nX71JuENp+V/9Ai+s8seSV9bnf2/M6nfx83UkYsegP+tFNEDoOK2UQSU=
X-Google-Smtp-Source: AGHT+IEtxW+6e5yR3qudzxwRb6e5rbZ4V9oNrG5A3udsg6SdizIn6cb+g8RzQmY3TRju5odI23NwuQ==
X-Received: by 2002:adf:ab0c:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-37cfb8c6b44mr1484463f8f.23.1727862738663;
        Wed, 02 Oct 2024 02:52:18 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:52:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 19/37] arm: gic-v3-its: Rename objects
Date: Wed,  2 Oct 2024 11:47:10 +0200
Message-ID: <20241002094832.24933-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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


