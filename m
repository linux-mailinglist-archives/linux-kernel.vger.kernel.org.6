Return-Path: <linux-kernel+bounces-195546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661648D4E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0768B22EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369417D8AB;
	Thu, 30 May 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NFkC4yAB"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806917C22D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080422; cv=none; b=XO+VyY8Em0FKlav1hGisW7Dir+eXVZppc9whhYeaTrUIwqO/oLRSVdectWZrWQPQuPayq3Y5naSTl+63ey1A6p/9nab6Gzie1B9JHncdLbYfvaQ+k1XQ9UgX5c9WWhJixFwMnDrtEExVN6i3cWm/3Sq4x2N3sDsBgsHkMub5C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080422; c=relaxed/simple;
	bh=lSsBHROKQmgg5+ha1ztlFWTe4EVHhL1T/vXqe+WJJUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ae0gw2N9fs+766ld+zwnRH+x03OUID8xGt/a4b4xiLLGwA2VjpnfoJ6QNKv49tgscYq0GQ51ROKu9IVcHsw0M8JEFSWG8O6zShphFaX7w3o0vYwd3GqkL6MOpyxO0ITmFzqUD6DcsInHcKKupjJ1k18qfQI4E2x4R6ddBLRGhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NFkC4yAB; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DR+biPGlYSGpZ+eEYjKOY4OeXDd2KnIrfa/0OCmMW9E=; b=NFkC4yABayuL0SL1hIBI8W1du+
	T3MZqaBFNXMYIdsiFGnY4t4vN9zt4JV+Jc59ebpDaVe/2p6AYg24lNsQOe6P3bFtHhviXITU/3Jym
	h0bqtqnit8ThM/AaX/+wIdYRH4WABYTpkpAorGlNwwjhS5rZIbG8nOLkExJfN3TUTec98kaHV8Im/
	uKOdSsStbBiLacIkvQklyxZSCcSuGdksCBKkmxNR/H5RwwFnWQY6TVIyOWoKkyaR7QRtf7XBScKTa
	Bb32PLsKgUVTsFxQlMR6OrkICUSsA2BHc1xFmTBlfrkDGAILcz1HtwnGkaWZQQlsWUG06eINLP69a
	E17EGdGw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sCh3B-000CAe-KS; Thu, 30 May 2024 16:46:41 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sCh3A-000N8Q-2m;
	Thu, 30 May 2024 16:46:40 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 30 May 2024 16:46:36 +0200
Subject: [PATCH v3 1/3] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-fsl-ifc-config-v3-1-1fd2c3d233dd@geanix.com>
References: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
In-Reply-To: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717080399; l=1542;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=lSsBHROKQmgg5+ha1ztlFWTe4EVHhL1T/vXqe+WJJUE=;
 b=Rw8YFVh+YnzoP3xy0ZD/Bc+ulic0bj3eu4xdUcK3o3H1+HBhui0PwPmFajMBmrtRx9Eht24PV
 +fUCrwijTW9Cduj9aWfNCo5qv2Rc5g5IJfiSRFY0iLWhM9mmcc4Alna
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27291/Thu May 30 10:29:52 2024)

While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
be selectable for platforms using fsl_ifc with NOR flash.

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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


