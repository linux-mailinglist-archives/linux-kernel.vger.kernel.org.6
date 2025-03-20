Return-Path: <linux-kernel+bounces-569529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1646FA6A438
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99618A24B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91D224B0B;
	Thu, 20 Mar 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="B2s5qqMm"
Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85559223719;
	Thu, 20 Mar 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468102; cv=none; b=GdenyzozTP+0SQMWVz0+GS1QIB4/E5uJ3hvP+1D3obab4JXmtqWmN3CoaD//CXSORek9/9vV8FX2ZvTngxqI/RiWEBGTxsmqmBq5eFYaoP7Rgxb4oxlZN8k0g74AbIZnkjuffOidl6/6/L4YaG2UdGjEjdFsPcEm9piQOeCjEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468102; c=relaxed/simple;
	bh=3hrFC8akR20pQMYn01FDGTaAf1FudakKyQp4tQR7was=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWj9/7tbR7tyIS95juF6YyTGntAEvL1Q1NDBlWwAP8arBW7QWLl2gQthCSoua7moIOd6c8vdJ5q3fnY9iKm5aukXNBQDqRcMvdkZzQhBvt3losRYFUU61HXk96//iWA+3cMyFWtVdsRnX5dRCuwKHOPGi7pyFmALjm08ZERwoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=B2s5qqMm; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=881; q=dns/txt;
  s=NAESA-Selector1; t=1742468100; x=1774004100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hrFC8akR20pQMYn01FDGTaAf1FudakKyQp4tQR7was=;
  b=B2s5qqMmzi22EIYh7sEm2RDJVvUSCZOyHDZifdQljab9/SVnLcls7VgJ
   a/Ubyl1g5v6j0DoqM4XesWMK+NXU5wZqb3tmNzI3rSAZWr4K80XgrM9kQ
   eO76W9dcNty6XPQJG8kAMQNMvI6rzo6aaagf7ZXHPvddehYNDW+4JBMWH
   dtcPz1tQXy3SYonx4qaR2eWCj44FB7vYWeLZht49Q23y9QM/GZInVDIgm
   eGUUAbLQ2X81CelccygAKwhPGK1V49XyK8lnQqgbWeJb+KQO1TbfLjMS4
   9FyZlQluuebCTAGOisduzCiAE9OKxlmUU8vCxDM2dwD/gmCuWPquzGXDy
   A==;
X-CSE-ConnectionGUID: hLR3sdGvTguvukKeoAa/Zg==
X-CSE-MsgGUID: emXY6L/jQNqK62IbdFS41A==
X-IronPort-AV: E=Sophos;i="6.14,261,1736838000"; 
   d="scan'208";a="80263115"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 20 Mar 2025 04:54:59 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 20 Mar 2025 16:24:49 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] cache: sifive_ccache: Add ESWIN EIC7700 support
Date: Thu, 20 Mar 2025 16:24:45 +0530
Message-Id: <20250320105449.2094192-7-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2025 10:54:49.0975 (UTC) FILETIME=[80992870:01DB9986]

This adds support for the ESWIN EIC7700 SoC which also features this
SiFive composable cache controller.

Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 drivers/cache/sifive_ccache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 6874b72ec59d..e1a283805ea7 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -118,6 +118,8 @@ static void ccache_config_read(void)
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
+	{ .compatible = "eswin,eic7700-l3-cache",
+	  .data = (void *)(QUIRK_NONSTANDARD_CACHE_OPS) },
 	{ .compatible = "sifive,fu540-c000-ccache" },
 	{ .compatible = "sifive,fu740-c000-ccache" },
 	{ .compatible = "starfive,jh7100-ccache",
-- 
2.25.1


