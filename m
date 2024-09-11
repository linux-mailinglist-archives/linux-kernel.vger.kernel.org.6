Return-Path: <linux-kernel+bounces-324259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0E974A60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C72B23DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A111304B0;
	Wed, 11 Sep 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FNjkBKKz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EE7DA87
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035956; cv=none; b=Xx620GNuUcgtC4GeWqNq6l50wqn79l0qUVpTO/vehm+4ssGw5L+OZNenuPA+Aw1Fic1SC40w+6C0x+5BK7D1qeck7shKXwlIxI7u/+ajIpffsHdxlZ4kraBKOXTe4CVhw2blB9/BUsbcIj/mLE1uu/Ad7b7zL7SWWt2hZ/0EphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035956; c=relaxed/simple;
	bh=XEbOKrrTtcMGH/Rr3msMWTX3UmkU/X6rqN59ulxjz0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSHa9Dqa4XJG8/Ae0McrrQnyfAU/04BwBlakLprD9ZD6tKVvDR8HCSUiDseh5hhJ9goo59g5pfN8CQzNP3Zgd5nVoxijOqkJzonQeWO6z5ZPDx4bVGnQp3gaL4G0nfw5PGdndkDZVJQ/u+STo1zL0EbAWMoQQ+0gd0uMYAq6umw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FNjkBKKz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so554144566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726035953; x=1726640753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hm7LrTly1tAv8aPJqqBuCMQJqT1IHe+3vu9BeDpSK0=;
        b=FNjkBKKzOFevM32bDhi96QvST2sY5fYFMef+8fK/DYGtPRbntfaiwI/Kfw26RV+Drj
         BsQj9uPDyOUgjy4sDpfKh4Mhpm9dHVSgslv1wmzZ/eVxmEVFM1AmhCA7zJHKqR4Hl7Fm
         MCeXgrRn4ppo7kvjhh0S7e6oLC+fkby7hNE2Co4OtaRF8gmM+X6eHY7XsXPzc6M5BzKu
         RPtbcdscLgRmjYSLZtWd7XoHlmruWagyXqiZLPGu3R5/qIPJRfrtY1/PQUaIMZ5TSzrV
         sVfnNY9z75jkJq6PtQxZLTSV/ns6ozaT4Qxk1N4FJFs4KBJaZSA6b36JlMR8cRZRE+vv
         vRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726035953; x=1726640753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Hm7LrTly1tAv8aPJqqBuCMQJqT1IHe+3vu9BeDpSK0=;
        b=K5jtw0VWfHk5IRnu4N2VhinFuIk7hxKAl2HBEWkS6NyPUcdQzWwS8KZ5HR7iOUn/Z3
         QGft9AWC2RSKFeZdkbODMEdDIm3WhTZMg82kWv1fds+A5sJVrToW1+dWS5tR7L6caiUW
         puy5NASIqtp1HphCDtJ8uuXcs8qehuVbd7MHLjRxJX7ovmblKvZTP37MbQdKsLgdkgUx
         TGgY25bXwdihi9dXbw83zmzmUTrtlnOYeZeAym8gnyRIC5fMUtOpWjKaaqX3o8BMtk0P
         Wj7PWGPSphXyQzK7PNHvcI9UJTu8L3oV9Zto/AHyQEa7FaC3k0GDIXhvl969kZ7CbCnf
         +M4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhMNviMuRIhmYJogOBbNjnjawp+qufhbmUfDNSP+34DHePod9CJ4GfMhMyZR/F4rMN32t0DkhnT795qLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq7ivxFyubuX1GPv8HBuxguTudZ7nkd00dDX5XoRkKdMd0B6D
	so0K8PXxh6VN8FwDwbeS3pckptRtTy5lz/2unGX7c5DEyKJ1pwvtHw5fbYW5wrk=
X-Google-Smtp-Source: AGHT+IHekzG/N5TP0q0u/z5z3pNc1VboWjN3XD9wYi1N2ZXDKYDmS0yDDzYdDqdzV5c8Gv6rRGhtjA==
X-Received: by 2002:a17:907:3d92:b0:a8d:4e24:5314 with SMTP id a640c23a62f3a-a8ffab47a36mr318373766b.24.1726035953079;
        Tue, 10 Sep 2024 23:25:53 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:25:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 19/30] arm: gic-v3-its: Rename objects
Date: Wed, 11 Sep 2024 08:24:09 +0200
Message-ID: <20240911062511.494855-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
2.46.0


