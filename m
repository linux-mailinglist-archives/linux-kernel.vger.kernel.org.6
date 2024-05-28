Return-Path: <linux-kernel+bounces-192302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EF8D1B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21241B2A6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27916D4E9;
	Tue, 28 May 2024 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UQ9yPSY0"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1916D4E1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899349; cv=none; b=EO0T7WeKu6TPF0uQg+M2pgrbjGi5+oFOCnwrOTMZVwOHIQ1Pq89qnSgZM8RGvPs9KjrZ9UBuEzL1qxY6NoW6HR3VpYfXln3uUwtuu6LJMaKw0uqNhaax813tmCiUNxvlpyCZXtxzILHwFuPhXdESmru2XPuM/1tVAUQSQ/yuvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899349; c=relaxed/simple;
	bh=iKUhFoSSSMrh/cb1S2LQj5ELm2cHsPctZeIgLvA69wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICSGlATD/ftsOy0PpD96hYLaiyKRVKH2afi3s93tvpIiwxNTIscJG3uAPbrBqro29Bg/lybr8YUMqgpAZkVlMR2LctnKqyRfEBo6+v2qlOEd+9skWZPQm6qDo0RSrK2uN+viGmRyyznIPjIXEHML2fWGvukTPpER8Z8TcA4Vp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UQ9yPSY0; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=B+JyFuDIfoWyU83fEPu16Ax2iAw7y4/ySQU7Tr5AVHs=; b=UQ9yPSY0+xZ4W22mwhQYbJvR1s
	qCsqBrSouHS0jViyms/odzKQ20L4VqruYJtzS7RxlVxjnKgkmTHRocWRJaPoBd6HwZXrmgwtrzyJa
	deBKI0ANan3PDDVkXZ/xU+JKvIr5X/DYSqJJumjW8Ugjcr/jZW6vX/g2tP9uTmlGNknyUnLlefAkh
	LnB37nBF5/C6ZSfEo6kp6a3u7oP+p4T03Uf2eAZhpmyDBjgR1cUfTF/19188EsyaXQwDC/BXtSGPC
	750TZqv5a5lOH42ZyvMNb0Bq1KoWW6lAIX5vzWZle8eqgJwTEowfcJWtPsBwVfYqCHvQ8h3j+WAVq
	nF57NIXg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBvwu-000G8z-MP; Tue, 28 May 2024 14:29:04 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBvwt-000CIK-01;
	Tue, 28 May 2024 14:29:03 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 28 May 2024 14:28:53 +0200
Subject: [PATCH v2 2/2] powerpc/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-fsl-ifc-config-v2-2-5fd7be76650d@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716899341; l=963;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=iKUhFoSSSMrh/cb1S2LQj5ELm2cHsPctZeIgLvA69wo=;
 b=8RQGE9EgZX/SGIcrQldXMqMU13oeIlcOwvNVNNpAutnOUf/hrhuSWlbCBqC4Wd+OISRChAkGA
 TPZ4RMCgBSBDQ26tXtYu91XvX/Yyz7zk/0N05SBLuQpWsr4sRyG2OOd
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
selected in config snippets.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 arch/powerpc/configs/85xx-hw.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index 524db76f47b7..8aff83217397 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -24,6 +24,7 @@ CONFIG_FS_ENET=y
 CONFIG_FSL_CORENET_CF=y
 CONFIG_FSL_DMA=y
 CONFIG_FSL_HV_MANAGER=y
+CONFIG_FSL_IFC=y
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_FSL_RIO=y
 CONFIG_FSL_XGMAC_MDIO=y
@@ -58,6 +59,7 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_MARVELL_PHY=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
+CONFIG_MEMORY=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI=y

-- 
2.45.1


