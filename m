Return-Path: <linux-kernel+bounces-574027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB2A6DFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FD1893928
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296126461F;
	Mon, 24 Mar 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQQ28Lc0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50126460A;
	Mon, 24 Mar 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833820; cv=none; b=XOxr5dO51XYZtAKqVAs55tmNPuxWTAYY3sC9+cb3AXBaAevmBl69fnG6eYvx6upKloAdYa0y2R5YS8gBjCZNZ5RCcCYR7nu+D6olfpdHjR70qDX1FWLsAuabQwKTH8NZKKK2sWvpTmADZgBplPgh5DiMlBWmthMRyzlpXy2lfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833820; c=relaxed/simple;
	bh=ERndhZd7uvmOxp7VBKjvNKNvE9RMcex1A2puj1YAGhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOJvTxf+PDGESfnbHmM0ygGWdsPjedbx+luvltGP+q3GdAhlJXcv/WnCP3q4MBCC5wc/AOC6ThrFc+dp7YqhgDjRXlUe/aMb5WpgWbUmgLuJwRDFF5RomqG2Fj0VPrU4nsycXZ4VU7UctepoSENaB5nvn9++TMlUR2pyehP7+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQQ28Lc0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so28100475e9.2;
        Mon, 24 Mar 2025 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833817; x=1743438617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXT10w3JwIzjDNmgL5a3o8h4+fjE6CRvvk0IUCmWmyY=;
        b=NQQ28Lc00w31qt1qX2V3yfXy70qfxQOpPybHCVRYqy6ZnEJpP/AkDNZH8J0FN11FV8
         pJh1/14hm+gtkXopAZDXqzLDyIHLY4d/wvKIqfR0Y+VaATk5wBwAipmPKDI914Y6V2fT
         YLgH0o8pxWZ+uAEuuApeHpIX0EJAIgch5CQdQTwaAQQTmUHJvX+FoijKqUGSSsbSAQZx
         bFisndxZSHUIqjXdEfwGLz03gcYiFHYZvPu8Ahdt+ycb74iMOvwCQI7WGvQzHzGQlgem
         r26SyzOZ9LV+AeKLS60Q53PQ2NfyM8ktiDXypmtkmQZHP8Q/EjB+bSo9FwXF7lnmG7Pf
         +lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833817; x=1743438617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXT10w3JwIzjDNmgL5a3o8h4+fjE6CRvvk0IUCmWmyY=;
        b=Hmh1ykpUtwQlLbtoniGyL1Cu71XmxzznZ6oIKzaLmRRk0YF8BsuuSGIEiDOT8mA4Cp
         eqFMb74BiSDv2CAXl8df8vQs8kNGM1UKnfBd3XCeQCEOaTb+N1uHiA6bxEsbo4hLuVjk
         hGKiR/wKToHEZRyOOWJRno6jOau0qmJDqTeBISFTpufVKaeThpkJOPv6j+VwWoa3X5cn
         buCVZyeeMLZIaenJjpXtRJ1N36A7xdZzDjZcFd3rc+pHt+yxhoQ8lkZz6wppZIWrqTE+
         QqyK3XHq6TKX6mHzA58hQimw80jHjbguEKrjbkJQoL00iBReRPmsHKVDwUXVm1sQQK7V
         jr2A==
X-Forwarded-Encrypted: i=1; AJvYcCU5aJSBlUtm6A5NRhQZfvpQBF5gSsUtIj59SAm/SzbXLZNuj3pcbX6xyxh0EIa5eLbRYASLY9TEHgHW@vger.kernel.org, AJvYcCW8ZIWBmFeqZklfz8HVEN0gMyXHQL514kTUEYTwmj8bDkxfdKBvMqB68NCM0UPqYpZr+WudsiWaY0I0b4qX@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcVtI03tYpjuPZnRWnNlb1wbOfV9fNGO/NIIazKmwiinl3seP
	cD5dNIHI55lYB4wtrRCQji95blJNy7XxWWUF57T06FoSVO+XglGSKlQKLAB9
X-Gm-Gg: ASbGncsp9fUGew/acjvIXtBvau3p3dA2FOA+ePE6jIlzcI3AB5DKZRsAK19UwD3oGXe
	OoD3Ait/v+bmW1DLXUz8dYDmNJI/fJKoDQ7DGerBizSN439O37ef1z85oVC7CZYHA2rt1+a5+Ei
	WDMpbdfbBtcWsssK42k4RTjxmfKFGU3vQ/bxXemfZ0aALoIwu9I1896eVoLE4cnaOl7hnWodCHN
	8J4zKmaS1pz2bVr0CNa9fqKXZl2Eeh1Ru8TeF2okaJi7ove2WPmaf6PSPdHuyFzzyJfsPav13GR
	gUVW5xKXmbi6LBbmYU/bkCeS8d441i98x3/GVWbRqTpmOsp3CQxSJGofn9OV9x/2FfGidyQ1I6o
	PhgtZCqs=
X-Google-Smtp-Source: AGHT+IFx9LdNvoxcmfurF69vi4WC8lka5DNxoYeKcQFuNnicURHcUqXEChK3XzKRjFR0RH0cV+xM3Q==
X-Received: by 2002:a05:600c:1546:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43d50a524a8mr131049695e9.31.1742833816586;
        Mon, 24 Mar 2025 09:30:16 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm124106765e9.34.2025.03.24.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:30:16 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Date: Mon, 24 Mar 2025 12:25:55 -0400
Message-Id: <20250324162556.30972-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ce6793b2d57e..ce9f6da1e257 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1400,10 +1400,13 @@ eqos: ethernet@30bf0000 {
 		};
 
 		aips5: bus@30c00000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x30c00000 0x400000>;
+			compatible = "fsl,imx8mp-aipstz";
+			reg = <0x30c00000 0x400000>, <0x30df0000 0x10000>;
+			reg-names = "bus", "ac";
+			power-domains = <&pgc_audio>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#access-controller-cells = <0>;
 			ranges;
 
 			spba-bus@30c00000 {
-- 
2.34.1


