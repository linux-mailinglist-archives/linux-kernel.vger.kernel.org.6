Return-Path: <linux-kernel+bounces-265902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC8593F785
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A6E1F226A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C415665D;
	Mon, 29 Jul 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HFG/IGQG"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE4155301;
	Mon, 29 Jul 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262884; cv=none; b=tol9y+C29suuko28bx94ezXGoLikdQPKoo7j7P4GRDWmwOxVMETjHdDnuao8gvxjiWuMkO+ootzNPw10FiuQQMF0Eui7VdhN4CPmzXUEW6drSVF5KBYMr5qhHxLCZBH7t9XX7nn7Qg9hUaPVkqpbD+/fuzPqz0wEDSGac2MeUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262884; c=relaxed/simple;
	bh=FJ9hj+e+qEbkIqB01VGfZPsX6YMerc+yFmPAs6dhD2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxG/I3uVXXXGEH50B7eVuwcCp/+b+qLvWLoU+jGxjNAfD5QT4FbGx3u+C9JPX9hhf9hShAt6TjPelXS5Ok30hNtbl3hDnKrQhn4EJ3XaA+BPXMH9kedeQzDZARvjhUxAnyS9RpvDQwxip/2c2CYzBa/VZLyaS6O//4WhMUK9zOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HFG/IGQG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8D29924000B;
	Mon, 29 Jul 2024 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8PJVZbpZeHvhUUqQp4BvbX25vcoHX3SZ5FqCu0M2s8=;
	b=HFG/IGQG9+9470K1tbqF3g1O2Ds8KvcaXAFZETTbHZJrlMXT9G0jJy67cmsaIJEgr2doA5
	9tCpTaOQYJLv4l4pIWjnL9jlniU/7ORtcsPikVlGK+dwl962vUIAgbzewsqQd5ZWDK5xj5
	NMpSEeWk+IA9UI1QwOIISHQkND42dtPOQyhe+Bt9r5+uLF95e5HMoGQuZJEVCHQ360qp6J
	/oq79rIwH+3Nw/znhzW4o5rzLeSljaeb3/k94oZS0u43NEBztpSrFNFAmHJV0h6Amz20Ht
	IMG1RhJg0cVuHiUdX7x1TiVFCgIaRk9/B2LIry7raoygBr42Ne9xDzWufjizbA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 08/36] soc: fsl: cpm1: tsa: Remove unused registers offset definition
Date: Mon, 29 Jul 2024 16:20:37 +0200
Message-ID: <20240729142107.104574-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

SISTR, SICMR and SIRP registers offset definitions are not used.

In order to avoid unneeded code, remove them.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index a9d35b44489d..244d521d8780 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -66,12 +66,6 @@
 #define   TSA_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x2)
 #define   TSA_SIGMR_RDM_DYN_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x3)
 
-/* SI status register (8 bits) */
-#define TSA_SISTR	0x06
-
-/* SI command register (8 bits) */
-#define TSA_SICMR	0x07
-
 /* SI clock route register (32 bits) */
 #define TSA_SICR	0x0C
 #define   TSA_SICR_SCC2_MASK		GENMASK(15, 8)
@@ -102,9 +96,6 @@
 #define       TSA_SICR_SCC_TXCS_CLK37	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x6)
 #define       TSA_SICR_SCC_TXCS_CLK48	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x7)
 
-/* Serial interface RAM pointer register (32 bits) */
-#define TSA_SIRP	0x10
-
 struct tsa_entries_area {
 	void __iomem *entries_start;
 	void __iomem *entries_next;
-- 
2.45.0


