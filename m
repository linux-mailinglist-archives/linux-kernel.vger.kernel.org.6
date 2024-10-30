Return-Path: <linux-kernel+bounces-389724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B012E9B7078
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BE91F21E60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8C217643;
	Wed, 30 Oct 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="MFOqAO6X"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E541C461C;
	Wed, 30 Oct 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330901; cv=none; b=HUxR58CoIyWYE8DyIMUOA3f3hmKoL1QVD5a+CS5O8/pndfr+5X1Mcub14gzTKoO6jrIrVXYwEZKl894x5xT1l4y3dgLwYgEgOkpmt32ydklqOcVYk9dA4qzQOHUQj3yhNEyEKcdv2OiOltyHIcTcLql+Jol8mo3YVfkFFix+Mtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330901; c=relaxed/simple;
	bh=j2WxG1gi9sX9Q9XHaunLYPDXuZFPxo2eTPeWaKuZNcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eE+nEDggt5Rvgm509vUie7Zn3gDVTXnSstxiYtoxpXRwGlfG578MSt77cWJoBzxxJ1SK3wiCvoawj83fZ779wDk1Srg6LaVWPlpePrb+mNneeue2EMG9WeN3yL/XgbXdQEXxw/021eZcTDwZfhxriIhBBbqgnrEpXo3tnnf6BEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=MFOqAO6X; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A1dLRRt6Gpz+f3YNGF2cRhz0EDeBb4t+Te4s+RjcUeE=; b=MFOqAO6XqjGyvEm7AbuJN82usY
	sWvcCd1Q6neva+KTQ1AiEfgOtBadaU+TllYnrDqwmsK/nhylFD2DzvtTq1r2ImPIMKs3KOQshyNIh
	28ixTccW9GNKQ9PN5/Imb+fwC6Ct8mxF2136WwQtkRwR2hqOuUXsZ3gsFVibPO+xGcQpH2rte8AK5
	wLPf2UYlPvpI0RqQ94DeuSV6nh5V+M8GxZZ3z8mCykGcHwwpxTtolbCJ0coBHnjlz2NJmWRSPKf8s
	BfS32TcZKku51OVq4cpkYSd3zCi8kRSv1P46WHxKejRqlOnK1shgWMwu5bBRAzP+j0y1LchZFKouF
	6d1xJcvQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 3/3] ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E
Date: Thu, 31 Oct 2024 00:27:46 +0100
Message-Id: <20241030232746.2644502-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030232746.2644502-1-andreas@kemnade.info>
References: <20241030232746.2644502-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable drivers used on Kobo Clara 2E

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 333ef55476a30..0beecdde55f58 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -68,6 +68,7 @@ CONFIG_BT=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_NXPUART=m
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=y
@@ -253,6 +254,7 @@ CONFIG_MFD_ROHM_BD71828=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_BD71815=y
+CONFIG_REGULATOR_BD71828=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
 CONFIG_REGULATOR_DA9063=y
-- 
2.39.5


