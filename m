Return-Path: <linux-kernel+bounces-364112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7321499CB47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFF1C2225E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04611AC423;
	Mon, 14 Oct 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ZIsbh2PH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC91ABEA9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911563; cv=none; b=oRq/ZZhTBCaQoEwMJgjn8Ca8FhR8f3C5hhTooKnXjR6dNBzl97nrjNQkB1an3OGDSYLmGoJhY71kAm2pxZRsg0tCph1x9njasxRGlIdfjNAuvHX/UyWxBV+JeIjMz7y0KF6dOLOHypgg3/KJ7Lq5WbaXxypDv0ZmCgJtQ1wJ1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911563; c=relaxed/simple;
	bh=KywBnJ6zPTZmJYG3G3wLfX8yMpxHMr3g+ZUm5jRHVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6K7c1DqAGJjojVjBnKls6Q2zCLIcfPaK3V2p81fsMDPESwskQMX3JB7xvu2b3b0jos6C2HQGwLdfn1i0rt187T1qSWb1UgFzTzz4uzhLnofHavwTH+E/AIyWiad53YAsc8HknYVxUiPbQQYHl5Lfhi9JwG/GCitK2ntE+K+Uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ZIsbh2PH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43123368ea9so19307575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911559; x=1729516359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=ZIsbh2PHDrAle0/GsfFZ1n5Ug0qxRNrL39BxI/AgGGHbQfJstOK0ocpF5V+PVhrQ8c
         +CHkzgIYuQiV/mQlYaIsbh90fJQ1HzbZMLG3+5x5Go+dg0Ewq5Y3xprwLhirwQTkv0Kg
         4ysE7znpjrn8MHLIVi0OPL16wXwzHdd8sy7hN64AqCFmVnMiZ9aVKxfNJDNbM+dLHr0F
         7F/qLKzvUkvXvrMcDQS/ca5R48RGC4q5K7T2QKlgMOXPE/z3/Dg0vdf8xILYwYpc8FTp
         foA4OrWsUOZJ8URydNvnurkhI7OUz+JnDkz1FwWF5MziDk1mF9t9aW4yULpKE00/EMEN
         aM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911559; x=1729516359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=wWqqh2+VJJFYJKUeWWqjWipn1d2lrNeHUlP5dpDgxWXmnUv7vyecF1+6BilC24caZ6
         J28A9QX5V8E4+Tsvg52fG2D8PfaPEwBgIUe66OC8euyPro/A6s71j3r7TruZ3gznGJZ4
         jsZrdIace5zXEIXKUVHFZD36WOOn7y0UkmjBbk2VbkBVxeh6Ugp/7ni9Cqok6xPTkXz/
         KTcSNmruWzNQwjvf3Z7f64EUKk7rhpiITBpkfjkcNsJMpHVMsqUr89EbekGXusztam0s
         2OJYobgvTRRBErOybCy9CknyHv8pboTFEzlfPjrB8w8YxrgK26Is5kxC0jIElmlNJRmX
         QdeA==
X-Forwarded-Encrypted: i=1; AJvYcCXh6QYRUGUuJmvnXNt/UEfT0hGMfoRn3ioRo5rm2GbKeaIn+i0BXbx84ubw7xWTj9Q5rKKsaMcyG4Vk2NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcsvJLOi7kCNJAHkmyiriIBWGuraGk55/eXoZYPnJrRa+OZ47
	NrYday1fTmz5fHqCR+oeow/g1SU7nfmRR+MpHOORb1hiA/UChHZDTLqFcZclEjY=
X-Google-Smtp-Source: AGHT+IGj0MwCKR2MeiqrDaVvTrocU1E8krT8EDVu8ew13wXZJYAh/affenkYThVKylu0LkiXjBZsHQ==
X-Received: by 2002:a05:600c:3584:b0:42c:cd88:d0f7 with SMTP id 5b1f17b1804b1-431255dc85cmr71851285e9.10.1728911559521;
        Mon, 14 Oct 2024 06:12:39 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:12:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 19/37] arm: gic-v3-its: Rename objects
Date: Mon, 14 Oct 2024 15:10:35 +0200
Message-ID: <20241014131152.267405-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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


