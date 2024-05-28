Return-Path: <linux-kernel+bounces-192304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210938D1B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2B12832BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8E16D9B7;
	Tue, 28 May 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="gqr1fttq"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAA16D4F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899350; cv=none; b=J7GjrJIUz89dHc5z88i7izmlDYocg0H4QDDUdrOrcqVHf3wmrs7PFqZ4S1Yzc1vuRd4IgW9ONPFOEMeSaQsa85J3RtCnPG9BY2/pjNCNeoXhFZN7ippz/g5ub4/5YWsQHY4E/Caip7bABHBfGkJ2HQYt/VGZqvL5Zx08JRqYdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899350; c=relaxed/simple;
	bh=MLywZj2H9KXhqq9F76X1wtPZ9zD+O5VDL3g1/wyM9YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eh8FH8zy2ww8XSGpThBGlCw+9e8gcwqU2qdi7QteuDkkvvHkAbEnvV67NIfvNuLWadOQOqDh/FGKTSzhgRW0wW22SeYVks14pD0jVT2QM38g3WdBIUdBKRXU3VBJ6vXpP61eM29Ogllg4aIwEJ/aK9imKv/Vy/z2T38JUdtr9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=gqr1fttq; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OgHle4voOTcsNO799IluUuijexopfWQRdp/vDqkrVbY=; b=gqr1fttqJZ63HiQnfzTpfV4XCO
	deKSMqIL+UTXE4dF7bs8W4Xoy/It+A45ccx3vwOArRoYzRKP7GwtSPAP+TyNJfaswptIAdz70rmCN
	7Jp+hO/y7/AGg2EfUgqixS7jUJSzcDuWDf7eMqattNQXn54cpY03Io4zV6nL13VAlfW6YdTl1CHHu
	DVs+k6xzDDobNShedE2pGccxW7slgnn5KEQqPNKjE027KbWi1c0hl+v5ccJHiRmbnw5dWYQF3uwL4
	ysaky7PPKq7GMG66LGwldyRzWNkAJdrzqbOdV8x4x+kZxQpeZNM9q0NgIpISuzkPzcjoPt9GlKdSn
	ftnpRAWw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBvwu-000G8t-6a; Tue, 28 May 2024 14:29:04 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBvws-000CDS-1k;
	Tue, 28 May 2024 14:29:02 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 28 May 2024 14:28:52 +0200
Subject: [PATCH v2 1/2] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-fsl-ifc-config-v2-1-5fd7be76650d@geanix.com>
References: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
In-Reply-To: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716899341; l=1486;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=MLywZj2H9KXhqq9F76X1wtPZ9zD+O5VDL3g1/wyM9YA=;
 b=I7byAcSPyjt1Yv3MJjCzMfUm/OXKpRSUKge+5wxo1ctSS0kaRtrGCDC1dq08LiL3koIJiCw+R
 K/vDfoCbrwPDp5waJAuFD4pEeMpeFAlW+NO79jK2B1sdOF00u9ZfePc
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
be selectable for platforms using fsl_ifc with NOR flash.

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/memory/Kconfig       | 2 +-
 drivers/mtd/nand/raw/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8efdd1f97139..c82d8d8a16ea 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -167,7 +167,7 @@ config FSL_CORENET_CF
 	  represents a coherency violation.
 
 config FSL_IFC
-	bool "Freescale IFC driver" if COMPILE_TEST
+	bool "Freescale IFC driver"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST
 	depends on HAS_IOMEM
 
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index cbf8ae85e1ae..614257308516 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -234,8 +234,7 @@ config MTD_NAND_FSL_IFC
 	tristate "Freescale IFC NAND controller"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST
 	depends on HAS_IOMEM
-	select FSL_IFC
-	select MEMORY
+	depends on FSL_IFC
 	help
 	  Various Freescale chips e.g P1010, include a NAND Flash machine
 	  with built-in hardware ECC capabilities.

-- 
2.45.1


