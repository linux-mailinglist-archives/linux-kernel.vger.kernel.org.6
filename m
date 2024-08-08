Return-Path: <linux-kernel+bounces-278962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABE94B727
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B946C1C2345D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA7187FF1;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VmhVyt8u"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AC186294;
	Thu,  8 Aug 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101108; cv=none; b=nGI5tyy2SzeC8GAbXZkPMUtBfY+tUFlxgSSX3hLSassapwE4AF5C3om7+yQ1xg3In5My8XvEvtJPd2UoYtJVL9mHtIMmE9fHtvgTtzWLroQhIY5PgEg53kILjJkvELN6p6kkmsxBTB3vuSmhi4XsgtFMmVJdclfBkKibtjVxvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101108; c=relaxed/simple;
	bh=FJ9hj+e+qEbkIqB01VGfZPsX6YMerc+yFmPAs6dhD2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9u6+niXm0FMfdug+Ki6ZuiopPGQa6/Xh27x7dy2AAQZGrwo/yyO16iR7J9FWQybkv2cXfZzFiTn8UZUto89hbPbxrTgjnOAuR95DGGvKMGB0sEmFNLs9UmoqGkvq2PDdY+znJE1TEikttuKhcNwy+C8UNVHj++L5s/aUBkevgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VmhVyt8u; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0FA36C000D;
	Thu,  8 Aug 2024 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8PJVZbpZeHvhUUqQp4BvbX25vcoHX3SZ5FqCu0M2s8=;
	b=VmhVyt8u0039WdCueSnb6t9QJSvKEQ1zNn6PhMfJGcNe+ybNPMOeKmmpcvYcimxZ/cSePX
	cydO8tZ7FY/5lPXs8sBbvLmh6PawhTI4mc6F7mUoFYTiGwVOMpLUD7N/uhgwhPlJIhQiuQ
	yDnE2a3kpY3qs3fNfr5TA4T4Bm4LFRgnoT7fEQUvAzfxiHJCzXVjrNs3HFcDxNXg6+B+Rl
	6I+H80vCgxldLI/E8KZAbm53SAdvTupdX6te3yvBNaEj4HtRLF4D3hNAd5jP+ooJE6Gb0S
	pXxQyMxxGUsvFCCzD4UOqrDjj76eERPyMwRNS87+5lvd+nzVZdOHyaXVIPCajA==
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
Subject: [PATCH v2 08/36] soc: fsl: cpm1: tsa: Remove unused registers offset definition
Date: Thu,  8 Aug 2024 09:11:01 +0200
Message-ID: <20240808071132.149251-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
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


