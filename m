Return-Path: <linux-kernel+bounces-367339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E89A0122
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D001F24B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697218CBF2;
	Wed, 16 Oct 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Tqe0FnrB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7918C33A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059193; cv=none; b=rgzzwLYV50ZI6NKE8Wk3yDmhrNWLZcMA3K0pY0vOZ5bZ4UnLMbikQJ/gPuCmhQOu+CAF7WUkjDKkm4U6NnOB1D6H/ISinH5qzssAVC+fW7CGahtCdRPvDs3ifVnkYoqSfcVGh/3ExDw3bdfjqnBGuGQt6Y7gdknprg8SiWujrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059193; c=relaxed/simple;
	bh=KywBnJ6zPTZmJYG3G3wLfX8yMpxHMr3g+ZUm5jRHVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McNYjaPPXA9yqt4QDgxsvEY1Zo8IQ2fofI5HVyWLveE+t8A6bgkEHod6Gqg5cut/uqkC9kp1FVfdF5rhbPpvA8l+CJuWQwVc1XM7VOmMdoMDbta0QhgpgrZBRYQzFsO0fzII5uHZsYndfZq4CC0OsTd8ATYlfxuuRONoxSGqCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Tqe0FnrB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so32095366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059190; x=1729663990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=Tqe0FnrBtDQZxFrqJFT1EQp4u03wOi34holJ5IqYUbrn2WFaAKjGgHRUEeP5Rwy3iZ
         7aqazrL4yg2nvNaPzDElkM84mZLV8nFUWBkGNcxgYvZuaUfvSQd3zeUyQUFfWlzYFpVG
         PYxmpkJurKGFngeLb3m6PHIy2nT/lIqqJTmreKHm3xavaLDNF0jxQHLZYlMdHuN9q9Gi
         lPbPoydnJqPK/m2mR7QC3m1qeVHy0q2wEmACb+s9vSVmANky6J5VSZc4+vAWcLdJBQ6w
         +eCG9ACRoSZ6POEga+5g/s8vvM9xeWzeOw+bhgfLRboxDS9+hkoXsIdMmdypMLsSLgfl
         z6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059190; x=1729663990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=vslP0LDV0t6/21g3+F7ArIpn8egI2dfnzMNnfuqM6VBv7J/PtcebcK6Z8Yoip7XleG
         GbRd86Y3RnkKE6gO3JofROYPzg89auRGGuVatD1YwGB1pge9GcCleN9itAf1knmDmO6E
         g63qYmAxClSx+8qNRsRyoDSQK7icGflAhxPiNEzC9WHDPQWSBnS47RTWDFjbbRlFS7qx
         BUBamrNVJZTFP6g6Joz82VcRVldF6lIjwza6Ph7rRwqGNZ7/+keT25twcaU8Jaj/xEHt
         OIgQYX2tWb5aOLyMGtJO7WyBMAT2dUeqa48LBoi36YFXGZ894uKGpLUDCkv2zMagAhKt
         FfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4IeTCpnhshcE9rPGRbNwBvQJhcQt6mCSb6bNmlj2LdO32Ag4ZFC4EFK96Ph23t93T4D7B/pyK3FcB1+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWM8+ZEWjwlWdVe0yQJR1MIqk81G3J7rZlLETG1hNSr2Pl9ktm
	TvB9yooPeYPmlZAmYNoOByuS0tzuYofxankAvguuaV3Ctupb619CUhzaA6lm4XmZEWT7sTY1MqR
	n
X-Google-Smtp-Source: AGHT+IG2NpelhH4v4HTQLWiJ5/W6ThQ01CMfaPPeKP0GgiWZ3F0R8evbiVt/jDL9gbMyPpo35R3zNg==
X-Received: by 2002:a17:907:7296:b0:a91:158f:6693 with SMTP id a640c23a62f3a-a99e39cfc56mr1323651166b.9.1729059189698;
        Tue, 15 Oct 2024 23:13:09 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:09 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 19/37] arm: gic-v3-its: Rename objects
Date: Wed, 16 Oct 2024 08:04:05 +0200
Message-ID: <20241016060523.888804-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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


