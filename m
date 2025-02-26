Return-Path: <linux-kernel+bounces-534470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC3A46782
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B42B17E36D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E36224B16;
	Wed, 26 Feb 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9eEgqRX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8104224AF3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588871; cv=none; b=Jg9ALXkzuFYPVCQNHpMbTcDMf2R9evHej+WTJ2OtPtAM8G+PJM/ssPF7MCfcvi+8JkfvDRgNM2+0U2VQO3ZxeZLN5bSYEurQC4Ls2XKHck0ZTv9H7ELfEEsOi/QZDizLMXIraWXueVJaDeTdOmziLDkvD647VswmO5OZO8bU1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588871; c=relaxed/simple;
	bh=y6WLP7rMdro7X3S5FxjI3YJe3AluXm0ue73PBtIJwZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aaf7lvBu+GSkllsiBrdb4XxaBzHawc0Wo92NHcGdU6PBVbzRobgV9FErJAVGll28TIIHPjfOb1hPuslg1TDc2n6/91CuqBSn4P4Af8tuTFRp94jtqCK6ho+VaGxjfe9irdZSh/hc4AYM7d61Sdy7DTQKt765/WKAY6YQ2euJGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9eEgqRX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso427405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588868; x=1741193668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sq6QQJrbjxptSVsPKB15/DnBsw03jMlmrEEi8aA8tQ=;
        b=c9eEgqRXk/IYcf7pB6fS8f8F/H4S60DpzcXFfmrL2e6Dxehn1+zkXogmIIdtwlitbY
         b9JigAkPxlaXaYQXGLlNkb3IsM45pHD9+3zKEovR8uHT1cGvemtIV36iosJREmw86DcU
         EBNMZmUYDwEFu4+w/xsXwEFSwnuXV2WVmOCl9oDSWELhjg0aICUnM/UdWkbohX7VeX8+
         MzBGJ9rIEcD8ILjWwrtlbKeHDc2RL5TYDkFBJcBhWH4S3833mUHDB0P0VmkFDUjbnJgj
         V4BuDHogqz0ZR8UJ3VVWXrt32NmGZI2nPQBZlwyXDLNgvtJj3HICwvXSZuz75hbcvofb
         57hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588868; x=1741193668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sq6QQJrbjxptSVsPKB15/DnBsw03jMlmrEEi8aA8tQ=;
        b=CfsaeUbcm5ZFVeG/gBecrolIdD3kW1lS46TEBT3kih31V0sta+KIPENiKOO0keXCor
         Hie8uTfOozmQXcOkVeBfN0y9hLFClcrSn19v7XCyFDdULR2V56SU3EDIWHd7GEvR/ASY
         lH2GUlrT+vD8XpY7rpO/C9rtDMrByS78arXp8YkSSF3rTooE/vvaO8Y0h1GTeDZMQE9c
         /Do67O2CKK7exuD6/QLKs1yac1tuUSHOkx1KlysYbRQ9Jv89atQV8KwxoLv14kv47pcM
         hLeW51kjn1tSt9Ekw7oMXyqkwTIOv6amEkaeQOii5Fqb0bRDd8Bf3U3T9EL9+hxTTf92
         yWJw==
X-Forwarded-Encrypted: i=1; AJvYcCV/+qilmwhs1e5k/s9Q9U41PkbTVPFPE2IKocmJlpoeCH6ysAh8MQhqiFP/tL87UgKms7L8KfDogym0rSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlau39kq8fQu8aOsmhT9h7/cmmDYovbQbkic1uQKc/R4oxJTCH
	SqUrVETGCFXb3r/yhQCKm5FweiJTl0W2nd1xz+SpauILIP+pFfRD
X-Gm-Gg: ASbGncup5eM6uCEJ/ul606JHouk/ugwhaQlO0zymPsGFU+RG9XVhVaZ6THY5tSxPKG+
	8nMJAwQG3Y/W13O98edxghJx3N0AcLgQmZQvGmV7xrD+yXOQTtgjgdnoKKv/56OiJQ2StRlRlYi
	XoRvWwgQX7EFjFBPIEpj2xYKIrezrEA5q/gFGFcCtsQWZHG1H2DH63+p+HH9+QtKieO7cMAEQl7
	WrSDOlGMR1TXkMWlTki8ihY8jhxA+kEsjGxq219yQvGV0qwAfwla3dbe08mfEspQeHa/wZD6lUL
	hS1uTHc3ppcXk3aQ7LpwDIrfoq7xqmpdKF4LZbSYJd0vFoD8pIVXWxKPaYmK+EQo
X-Google-Smtp-Source: AGHT+IEXXamHHiDSidMVxG5Ktdrqqy0wdXIkMLj75ieYD7dfdn0/9TUpigpU8mKWwmnghiqB5cWMCA==
X-Received: by 2002:a05:600c:3b8e:b0:439:99ab:6178 with SMTP id 5b1f17b1804b1-43ab0f2883dmr71707325e9.6.1740588868020;
        Wed, 26 Feb 2025 08:54:28 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba587163sm27672515e9.36.2025.02.26.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:54:27 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Date: Wed, 26 Feb 2025 11:53:13 -0500
Message-Id: <20250226165314.34205-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
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
index e0d3b8cba221..3097acb4bd21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
-		aips5: bus@30c00000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x30c00000 0x400000>;
+		aips5: bus@30df0000 {
+			compatible = "fsl,imx8mp-aipstz";
+			reg = <0x30df0000 0x10000>;
+			power-domains = <&pgc_audio>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#access-controller-cells = <0>;
 			ranges;
 
 			spba-bus@30c00000 {
-- 
2.34.1


