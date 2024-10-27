Return-Path: <linux-kernel+bounces-383516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBD9B1CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715201F21551
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE40C14F104;
	Sun, 27 Oct 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="qIBXSWKP"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C957CB6;
	Sun, 27 Oct 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020868; cv=none; b=TMxfkzhxWKdyb5rq1+u3bSdox2VyA2HjcldR3y71hWgenDlo9YxTiBE/vSZEo6Wlnj799aayEllmwpqM0PMZ4NHJbWkIWM0Hh8KdprrVnXytL5G+thjaLf8aI6Vp9mUPhDxzfJwOJp0BPg9BUYzLjpw74F1JsqcV3ZUo6oGZNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020868; c=relaxed/simple;
	bh=gHD9yVfr2NpwXHx3iGiB9EPI6jKOz7lrwADbR8y8a/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7rhya0Mgbasb5LDsld0RmQRENM6XplD2Byb9oe12lP2VOLyOAqi/ANE1Mv7ehV5K//8B0EXOJItlxYEItHO/DqvSN7On5Ktwyd+pSSnNz6LmBNqIcRRgW3MPTAHUHHG7xMNSVRBcdKicB5xfn7ChKtsIENDSrDYcm3vEtokyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=qIBXSWKP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5988BA0DC8;
	Sun, 27 Oct 2024 10:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=J0TfKIJhJzBxEoeio8uy
	Um+I+RQoIvnhme6u8bHSaZ0=; b=qIBXSWKPRm8AUp8bFyY0gZCHCIew2oBPq9x5
	VWSu8jrr4s4Jr6DYnH+FSDWp/8nlIlGD9BWQ+gbKiDNHSGJ/g2GMy+35pNg8+eE8
	OiVtEfX0zHcAPf2YJ7Opux0QL6+bTcKwsr5M17CTkc6NVCFKqyJMsH344MM/kqlc
	Zrnv+aDnvcT7EVOjOcu0k/hHgmCsoZQq3SlgQGLGFlikUCSkIBn3WTUqRyJJHJsj
	ZqA7lMss5E8mA37hTOIZ5VKmVIUQWyrkUZKFMLyOi9I+c/pbaxcVR7fmjoedmevf
	EFApdsuSRE7bSq7CYQI8BKWuiHZ8hHrLCbBLm+udU+pVYSaJd7hAlrF7WegZAwLl
	mWpL8Zc9wbi4VJV7jtvUldSw2zjBG5S3wTa3vMKsadtce7wlevldB+QQx1Z3HmSa
	FoI98nB8224z5FIeR05meH970c8Zon8Tr8EdqoabxNv3Sgc1W79C4du+T6he1y3O
	sNurIlmu4XzaFsV7lZDWCI8dmfheCMiW73L9+bXoF+ZU9qzoYLSzCVAfW0NV1qUv
	DweMyRd8EeAVZibiFU46bEjGbIQ6XzRDRJrpSb3vikRlBlcavSF6lu90ujMoURjZ
	z/XkTU6IOuS9ub/OO+Fy0AE8mxdq+15qwb5v/pEcWkIdVF1yJoalndhC9egWicCJ
	CkQ93so=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 09/10] ARM: dts: suniv: f1c100s: Add support for Audio Codec
Date: Sun, 27 Oct 2024 10:14:40 +0100
Message-ID: <20241027091440.1913863-9-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027091440.1913863-1-csokas.bence@prolan.hu>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730020862;VERSION=7978;MC=3302600005;ID=156045;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677D65

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Enable it
under device tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased on current master ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
index 290efe026ceb..e4b41bc93852 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
@@ -336,5 +336,19 @@ uart2: serial@1c25800 {
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
+
+		codec: codec@1c23c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,suniv-f1c100s-codec";
+			reg = <0x01c23c00 0x400>;
+			interrupts = <21>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_CODEC>;
+			clock-names = "apb", "codec";
+			dmas = <&dma SUN4I_DMA_NORMAL 12>,
+			       <&dma SUN4I_DMA_NORMAL 12>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_CODEC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1



