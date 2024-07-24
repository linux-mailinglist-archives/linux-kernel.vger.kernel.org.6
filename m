Return-Path: <linux-kernel+bounces-260979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8D93B133
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB1286C06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2515A868;
	Wed, 24 Jul 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="i6zVSInA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gPN/CgKE"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FA158DC3;
	Wed, 24 Jul 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825963; cv=none; b=sCs/ug0Oa4nQ4il8grSz6t7Ya1GoYizpUA4LHw/UqyY1dgt3aFiT/qt6/UuC3BmPM2919FN9U5K7EEA/zXzfgBuvL7MOjVTifUxWcSOTPS2anxy6XXHkXKzs9i4sxAlpAi8YC/ErMVYtECJ8nK1OZEtAO+AbEwJaNPq3McrAxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825963; c=relaxed/simple;
	bh=uiaAHrZHmNXTWaCfBOoeXKUxOLnmN/y8aFBmf2XJ060=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSpsRlNBc3yi7RreOZqSSHmOQXTd/+y1Tg//ZT7BbVn7ikrvkBYETMHLs6s8uXEuTb/bhRujmSQPxvw2S8tOjysjFDsFlUvIHRhUnzTf5F0YTKlyUaeDeEx16mLoXkWMgfTY6Uaac2m24bOAnDe1YvcDi7hX9pXZth0+sxDYY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=i6zVSInA; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gPN/CgKE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825961; x=1753361961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9RD6RC6QKS9QmqjHo53HhQ1y4km0E2PMfjsLHT1NDM=;
  b=i6zVSInAEVlUHSfIkdyspCSxqKt52SpXUvjir43veVma0YGI+Fzg3DHN
   oczyYR4fLq2qXZO/DyPPCpGOzPa2Uv0bDbwYxktnyMHRVzaPgTiKpXoM5
   bV6EQ8v/NM/5z7XMwvrhNyQ8nLesBj9RU97zrITHzbUDwc+4zjgxdSzBs
   mW+XxQiWh40j4NSSAJAkvKHDTz7vFx5ApRpJ0wtcGZbYjo2I7WOkjwXTW
   4OgD81Tdj/oPpkHzs9omwYPYsoZ9GsDV6tAPooXRLtQoWCXwHP4o6NUdP
   znaPil+SAuMRV8igCRdN22ekFUFMgy9s/19s0qsdFAyStgb3e8blTXSmx
   w==;
X-CSE-ConnectionGUID: 4ZUA6d7wRIi9DQWOYCJqmw==
X-CSE-MsgGUID: rvX0TZWeTZqX1561fMiLVQ==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058826"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:18 +0200
X-CheckPoint: {66A0FAA5-3D-6C016D47-F93F7C64}
X-MAIL-CPID: 82FA8FA3F845691681210406FA0613C0_0
X-Control-Analysis: str=0001.0A782F26.66A0FAA6.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF303167301;
	Wed, 24 Jul 2024 14:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825957; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=B9RD6RC6QKS9QmqjHo53HhQ1y4km0E2PMfjsLHT1NDM=;
	b=gPN/CgKEsqGppQzzhJi2bobfb6z4YrOiU20xSJbTsl6GRl7MmRL0TALVd55Xo7dLTl5s/t
	NMHE2SDObPRmTkpE3PFZPrXwzu32sBPOQ5iF9ipo/nHl8UIJ6NTBR59vGL0M5yGWzeQFZq
	98JlwIPrMv3Khs30vsdvpr32QQLRDyKRcuQCBVsuv4eRhOOlck8nHX8XxlkMshUTDK9cHT
	01dfLHhvGPVoJROEoTit0eg5gN/l+as99FIKgTQXrtA8iuoh01QUzXavMkN2AWUxzDkAFr
	AeP1B7Q610I1fAnyN6yG9ZSaZXcvmVKd5EHlQzOmFxmeqfQHsKe52Cw3QmaaGg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] arm64: dts: freescale: imx93-tqma9352: add eMMC regulators
Date: Wed, 24 Jul 2024 14:58:51 +0200
Message-Id: <20240724125901.1391698-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With PMIC node in place, add the correct regulators for eMMC.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index ddb4f452ba2d..63b02552c55d 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -217,6 +217,8 @@ &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1>;
 	pinctrl-2 = <&pinctrl_usdhc1>;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&buck5>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
-- 
2.34.1


