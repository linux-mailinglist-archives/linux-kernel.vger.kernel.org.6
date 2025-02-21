Return-Path: <linux-kernel+bounces-526507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C3A3FFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0569270066C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D9253B7F;
	Fri, 21 Feb 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzK/BNkE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC093253B40;
	Fri, 21 Feb 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165599; cv=none; b=JIxBir9xJ5OLvWGV0h9kPz7x2/GRioa6pKSCmA98TxwaVCOA+5F5fmNAubJ3osm27f6EHMO2HYRq/k/Higx/COLZ5HNG3dtpo0eWqmiGZDwSPPCSXHXh4aLor8FXe8uesG1Hcy3mglQ7EIKT+WmnHcKaVlRVLryttd5Qh2HTqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165599; c=relaxed/simple;
	bh=wMVxyLYxdUH+NfOdC4YAZCVPaLUE6SupMeq+EC0HtRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmtzUWbb1Vi2NyY8EeTPfpkaPQLAUVlw3DHe5TCj+4TLPLT/UjUDAmbSoIgaat1iymLbjqnsH5fBAUVZStj0fAGbMhjW1pJkfoj2vy66woiO88i7j6LhQgW7VxYIxba8JSYedpvmzUS9eIiKdFB7PhRPnGPcpEiTEa/vYWsMLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzK/BNkE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso383506566b.0;
        Fri, 21 Feb 2025 11:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165596; x=1740770396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TKxWTtkSqxwzx6dDc4iUz9ohfHIlpkY7Ca7ccTsz/A=;
        b=DzK/BNkEvcQBTAmld8L7NQWOjI4gt76/HUK2+oR5O2H6rpckuexmiU/mjqnfKtEyid
         vOq+aQY2PgXDUHiMG+VovidsY1vobMOYtbd0NZ2UGkENmeJqpil+UGtWsqTPxEbw2iQ5
         YzXIvC8ehMGQJQl7ApwxaE6kx4X+rmbuQqrYFVn+gW9Mn8ujh/cl0AI+aPyeH//gw6xZ
         k51o44GmE6XdxHXSkrwJd7PsnTP1M53ZV43AvblbkXG3qmDolAA53p/OBo975gq8pIHj
         PTFbZ0piUoDqalMZ6h09fHstWYxxvjPOY36c37m2xPFQoymm6THWM/bCdnpSMXK15pMl
         tGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165596; x=1740770396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TKxWTtkSqxwzx6dDc4iUz9ohfHIlpkY7Ca7ccTsz/A=;
        b=soXu5Gz1VnzqnNqxi+j4gX/KiGBwyWsrOIenr/x/tz3vYTDmGCb+9+DKPeM6jnj6+7
         MhTHPhNwkI/CnesyBztjDB2XSCrxk8iZp0aqPDp26vkgXRL6mmTgMArbcaZ+p+2MD296
         WAguzpX7nxN1kK9AV0jNsUQWWA1npIOUP0SgmskrKfwDsBIMsPKZqRnT5Ffqe1yZ6Rym
         yWZ/FxABa2Q4oFgkAJtdEAi7LQ3KJFloWXsNsTaHbm0qPplid87ix/sd2GcAKko32r+G
         bsIpiGas2hxH6zbb8KVXR4JWqvbab2wVqsVaLkm2ls2PDaVw/nEHJ2CjYKB/MMytrfkS
         1JZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqRz4eH50x06nnmEFBLSGjDYiMWdeTFGPO0m0+JsNcbHCh+IKIHAlcaTU5fJFcQytTyMHj0PD9ygr@vger.kernel.org, AJvYcCXcVG9OlDWYLhMJO5XZZmwKmrxETh/KFgSnTFDI99pFDji5Q5kevVaHAd9WgpgyK67b35XRB9cAkeKiVw6x@vger.kernel.org
X-Gm-Message-State: AOJu0YzJn1SJjjFX1uFIC5xTok1fKaGEqZnsbahl+VMkWcjGgu0r0jBt
	YIgd50K5dggXCGdARpoAqdKGeXNXJaz+BFHz+U5T9f0OmdC6zwHG
X-Gm-Gg: ASbGnct6eqjQ2/FTtu894fLFR8Gv44Te/+hE3AZzIj7OsJQIAIFYT8f3SlQGknwAfof
	+4b1yl0vgztoXTL+B+pjTLJtkIFJt7qhUaVPeqgDRcYevog3PmCOWWmosO/fxqWg4lzfaam0bvW
	SbZ0X4/uBIDfK0/m0q9hlnhsGef3qG1aJue4SDFm3t1r1mcPtHrArue2OTzR11DdSlD9m2xVbsa
	x2yclTN9EBq2Z8D436MvMsJx2AH22X2WY1EpXxC6inqKDfNftT+PnO0X+Wm8m0HwxbVHg30kHOr
	QhV04uD9T+aMbcnlazEfoHcSIoXGusAr/fg6WIco1ur/4461mADzbPHnXEY=
X-Google-Smtp-Source: AGHT+IFDfbIPVZIMARA0RdhZrJ6UuY0dVTRO1/KxreNJ+xkg/EYBzXyrYM3lqR01Fe4RA0v/JrznqQ==
X-Received: by 2002:a17:907:2d08:b0:ab7:def3:ca1d with SMTP id a640c23a62f3a-abc09e44f67mr482288866b.49.1740165595692;
        Fri, 21 Feb 2025 11:19:55 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm995276266b.129.2025.02.21.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:19:55 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Date: Fri, 21 Feb 2025 14:19:08 -0500
Message-Id: <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

AIPS5 is actually AIPSTZ5 as it offers some security-related
configurations. Since these configurations need to be applied before
accessing any of the peripherals on the bus, it's better to make AIPSTZ5
be their parent instead of keeping AIPS5 and adding a child node for
AIPSTZ5. Also, because of the security configurations, the address space
of the bus has to be changed to that of the configuration registers.

Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
missing 'power-domains' property. The domain needs to be powered on before
attempting to configure the security-related registers.

The DT node name is not changed to avoid potential issues with DTs in
which this node is referenced.

Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..a1d9b834d2da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
-		aips5: bus@30c00000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x30c00000 0x400000>;
+		aips5: bus@30df0000 {
+			compatible = "fsl,imx8mp-aipstz", "simple-bus";
+			reg = <0x30df0000 0x10000>;
+			power-domains = <&pgc_audio>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#access-controller-cells = <0>;
 			ranges;
 
 			spba-bus@30c00000 {
-- 
2.34.1


