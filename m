Return-Path: <linux-kernel+bounces-555581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA4A5B9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95697A8ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04440222596;
	Tue, 11 Mar 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="hRQtnZDv"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C842222CE;
	Tue, 11 Mar 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678486; cv=none; b=TNBNdL2UFf3wdYgH23z1vngi1zlJvaXZ20ko2dMj7U6FL6aVK1YPy0T2FymYlYju2oMqvv/x6oIqe9cexu0UCYnGSva5FGXg1ipuwvZ0L17TRFRFBqYcGWabXG16x8gsSJ4SlANztN81XoR8xvF8rl+Vpw/4Jp+/8f1HZSwaFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678486; c=relaxed/simple;
	bh=3hrFC8akR20pQMYn01FDGTaAf1FudakKyQp4tQR7was=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjooYki671vBJFh2bu77nhzB3IYhIP3rTspIysahCmgQ5NekzfHRUMkv8Qc52DMowNkt50uVPkgWN81m+vhOtWhNzrxVv7wnv2wOCmtOr3BPtgBqDc3CXDpcG/MZ1brV0t//rJC0SP+XaNfcMUUBB1DJ8e0v6C4MfSoD66aPfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=hRQtnZDv; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=881; q=dns/txt;
  s=NAESA-Selector1; t=1741678484; x=1773214484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hrFC8akR20pQMYn01FDGTaAf1FudakKyQp4tQR7was=;
  b=hRQtnZDv91c20ARrwXt8PzgrIGL2D2aQG+95besuKhWX2gm6cyEz2nzC
   b/7rwyYFWzafNo3BfUmsHw0pc8n9NwQLwHFZ2c1lP0QnJoLSng0EsfitR
   HPFjLlE11FmI5ma+X7k5rlCevB7d+nWq26glJOU3BCffvV7oPRmXRZKWB
   9jOstv0MuGPeajAywC/pYSDaxYO+a0IPaGz4uBOumr1KHqxWTHT5q/Kwd
   93E0+hJsN8BAyhaVt2RCpSUmu3BYjnkcXL322UyNWj2cffH4qbl6kHqur
   yMLiWLA6ip5vzTSLUGvveoLNGv7rta2nxf+xAICflItPvg91+5wJeJzm/
   w==;
X-CSE-ConnectionGUID: f0bM0WMnRl2RZ4csouz/9w==
X-CSE-MsgGUID: Q5F2m52QQCSqIHzr75EAOQ==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386400"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:42 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:33 +0530
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
Subject: [PATCH 06/10] cache: sifive_ccache: Add ESWIN EIC7700 support
Date: Tue, 11 Mar 2025 13:04:28 +0530
Message-Id: <20250311073432.4068512-7-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:33.0098 (UTC) FILETIME=[08437EA0:01DB9258]

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


