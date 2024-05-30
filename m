Return-Path: <linux-kernel+bounces-195545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D548D4E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797FB1C236CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22617D8AA;
	Thu, 30 May 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LXFXSmXE"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE0143C40
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080422; cv=none; b=E43KbQHcaREKRK/doMsKCOBRskUv8mMNvkoZqN4oj9cyvUaUg9KsPpfmu3K4Ym8m1fsgXsKsQcAC8XATv3l98uCqJzkSGsBVniS+ksl2T/X0IBTJcjmyIQjldkPwyJxqJLNHYB5cW7wQTTvVH1GL9xn5pntlE6k+Hb5e5EuPV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080422; c=relaxed/simple;
	bh=gYh5ZeM8RAfRySwrSZmO3AMBCrGHKKvIQY62urO1EUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aX92JuPseA7DMBllYA5Iu4iNDym/JnvzpFWw3piENSrwgNJquDVJtsLVFWWivBToCmz1m/Jodb8Em1cQOtz7dBrzj5qdIUz1lTxBNmnHHlFPUcCLtSxg1bRqobYcG4kKrwYGHzPNrzDmGrmNgemG02qFluI6bFfZycMVROoaEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LXFXSmXE; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Rx1tDglSe0Vnos0b8SgqUc/GQHG/nBapjYKNOpTecRQ=; b=LXFXSmXE2NO6YoJACAG3IMhtgZ
	jreM9kQQmdz5ILPRCxN6w3NCKxwWeiQ6JWn1iTvdIHT6gROBRicQ7hBXZKQIYp+ajIGUWmVzYXLRP
	syzvqX5+DN2HPikkBrfddlUAOXRw/NdT2sIc2IFJeX6AXAiz5VGtC5KWpIeOulB3MY6N6oz1nch73
	rX5i9KQcR9LjMYZbOJp9bNOYEyd5Xnt69hgwSRi/4hSpDhRxX63JQI+Ss3Mng0G+86dkSxx9+ERm4
	LtS+NydUjy+9VO2NYSrsXlbcGxxj4FHsEGSeaUM2/B2d+W6HAdyd+uzSCKBJz1iOjLJptboBtMOvn
	LBsRktjg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sCh3C-000CAk-1m; Thu, 30 May 2024 16:46:42 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sCh3B-000NCM-0q;
	Thu, 30 May 2024 16:46:40 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 30 May 2024 16:46:37 +0200
Subject: [PATCH v3 2/3] powerpc/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-fsl-ifc-config-v3-2-1fd2c3d233dd@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717080399; l=958;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=gYh5ZeM8RAfRySwrSZmO3AMBCrGHKKvIQY62urO1EUw=;
 b=bEJ0aVmdyDT0u7vwaSZCYG6fAyLnvfzCYF/YRQ2PzyReLEUsEQqAiYRgiG0aZcxyjQ+7BA76p
 O+Nhm+tA4POA6cUaW0cQw3HzyLrZ/KPEneXUVUsEnnoTKtdF81zYrIk
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27291/Thu May 30 10:29:52 2024)

With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
selected in defconfigs.

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


