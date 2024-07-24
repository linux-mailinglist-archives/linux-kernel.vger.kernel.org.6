Return-Path: <linux-kernel+bounces-260977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8B193B12D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A652868EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C93158DCA;
	Wed, 24 Jul 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Wm3K6FTY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AFy3ibBt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D8158D61;
	Wed, 24 Jul 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825960; cv=none; b=AtJL5XQ3Rl4GeDUlPP1CDKYQeZWL6zpqiPLlDaCkPI9mvq1dy/COH9qJb0pO70s+935YLVjFX1ACij4rs0ZVsUHBiyA41+1ja++YGIMoxRvw8PrJ52F+yKVYsr+R0mLxpoc/haGH8iHKoULNB6WYBNkd8QM6debGhbwKoAe4SZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825960; c=relaxed/simple;
	bh=vSAyqclaYxQL6eCH630sIRll4sNmJc0dKMf/A2e/E0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4UyQ8Jv3yX+USX1+Ac3GtO/m1NRayfhotdVn1PL/dWB2fudfd4IHy1s3YJVhVMU2Rt8bYoxuB66FLS0NLq/et+RdY8qDKB28rXcJXkm2wlct5FTb9G2zJOEL3pCcvYQMs+H+SHUweb2+hFLOUTRveKpmlxQJlGB6vH+vFvWCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Wm3K6FTY; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AFy3ibBt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825959; x=1753361959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqCNFajQDQd+zXZXqz/8Ixz3vyweij8AFvjzAkiEM0s=;
  b=Wm3K6FTYV/B+22IJMnGF6TjTuhkUBgilm3SxUi4wOS+1wPmIiCLuOGHm
   4hazV8qpRiK/JGkTABMEHWvkKP+E9aXtZ10cC4GugD1f2oGpDQF/FwrN9
   1sd8hms2TrXoM7/imS8hsCp0BkxOwosfHTRCnqpkRm5pw9E4Jwz1tEK5R
   PJaruD6ef9B+DU+JUSGeg5Pf9ugJtuxgSfSetCMqJvP8/CzXzLTF5idRe
   DK5UuR01Ov46jyENh4XXDIuhWwBrCNBMUgltuQrYJN1ezFzq9rJbtg9Sp
   Nv1MmdR6FF7rLLPvoafegEI5/yBXJFXUuyU37HT5Fyvs+rGr4zZ9vqoKu
   g==;
X-CSE-ConnectionGUID: ZkwaJkfEQmWIKXEZzpsGSQ==
X-CSE-MsgGUID: LQL069RmSQCsr7AWyIxShg==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058821"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:11 +0200
X-CheckPoint: {66A0FA9F-13-CA1431AC-CF855369}
X-MAIL-CPID: 86E2DF9262DCADA7F5A9205211DC4679_1
X-Control-Analysis: str=0001.0A782F17.66A0FA9F.00E6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E61D316380A;
	Wed, 24 Jul 2024 14:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825949; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yqCNFajQDQd+zXZXqz/8Ixz3vyweij8AFvjzAkiEM0s=;
	b=AFy3ibBt6PVeNv2PBKSdtU9GnmaAUSg0tOyVJd/uc0byTT8E0AaYdzk6Ft8hIbmVgnI0DY
	uucGcGiH05jjzcq2WlsJpFdbZ3uVEwL2rAkBvFr4yOAKKhqtgPiqwxrm1sFMRVDgKifvf4
	+NHT/C4VDmfkjGYCkvwDps8HwDCd3SPDxugoOPhwuves1tvIxgFHe95b5tJ9DU9GE6TFa9
	WFRa+rvM4TlbhtCw+awzCGgOjUPX2sQhKLQHdEnnRC1FS0eZFcvWqjqOIOaLfoz3LSTzMU
	E89P0s68Gjz4PRfeyN55cu/ah26AHsT032h2+Xha9h2A00jDW+LWNmaawC0lZQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] arm64: dts: freescale: imx93-tqma9352: fix CMA alloc-ranges
Date: Wed, 24 Jul 2024 14:58:48 +0200
Message-Id: <20240724125901.1391698-2-alexander.stein@ew.tq-group.com>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

DRAM starts at 0x80000000.

Fixes: c982ecfa7992 ("arm64: dts: freescale: add initial device tree for MBa93xxLA SBC board")
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index edbd8cad35bc..17ccf38ebd56 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -19,7 +19,7 @@ reserved-memory {
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-			alloc-ranges = <0 0x60000000 0 0x40000000>;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
 			size = <0 0x10000000>;
 			linux,cma-default;
 		};
-- 
2.34.1


