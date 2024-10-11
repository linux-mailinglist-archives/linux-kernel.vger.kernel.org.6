Return-Path: <linux-kernel+bounces-361356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA499A728
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3E91C21DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7862195B37;
	Fri, 11 Oct 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ3YyXAj"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04ED194C75;
	Fri, 11 Oct 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659158; cv=none; b=ByXFNgV/38KGE2S0NJT1/DW/pcgQsIO0DU6PVu351atezNxNpB4VJv5IHLPsqyFgeMfboKKhhzq107ZHVK8vZlOo7MSFNfbJc4pTdFJS7p6Ut4C+gcLTYyos7nzcnTmL4nZUMnesurjFZXEoQu4bT1NnNcmJhadLAcnlFY8ww3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659158; c=relaxed/simple;
	bh=vr0UmcnaAYhZzZTJilHV3JxY4AJdeK6+5d+Q00WbqBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A2sqJysT6ccjd+YAQjOLB4hI+VU/KbQ+mZgKRkVmdPPb+mHNjoFyFvi0iDwjt8gRn08uQ7N1SP6LXOdPNXmV0qN/nD408j+1Y/gvpWJBihF1gKRocpgAs5tBmRehX9AiRxK8CL8R1QLrIblb4kBiSl4zxzg+J65Gv/g6oJL+ag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ3YyXAj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9952ea05c5so332799266b.2;
        Fri, 11 Oct 2024 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659155; x=1729263955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwFmMBQpvB09DklGuZpIpvbFiWo+i75RNFs8vYOVIHk=;
        b=FQ3YyXAj74Rco7Dpnf8i9Dna2NWjcA+Voo4ltheGTTg6MnNHdA7+6xkDAFJUu/B7Ln
         tzcu73sPv6awYZE6ShddIGCe4w4XSSwNY9u9xL7RmqbSavw+iUG/zLqhP/Gzf+1kpw+M
         zBSrQIpkydZbJ5fV8v/fm78n+VMSTNhZY9nT+KpMD5jf/ytlYPh0eLF+nl9X01Whv7OU
         RsZp76P95XgEBl4C1O9zhTffEd3SDD87NSCYh9p6gklLmIAgz4loCAIXJH06/ZTsUid+
         0VbQNqG0llA4+CeiuiyQc+/oWsq7RCGIihfDfdexeppDYDgqSHoHDtlNtRpxQFzgh4q2
         rbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659155; x=1729263955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwFmMBQpvB09DklGuZpIpvbFiWo+i75RNFs8vYOVIHk=;
        b=BZCb2IRSdvRARuVjKrHVLEHAd5fBJtLUwe248wqT7+JFx19ARqPf6Jah4+G8ZdslRk
         +7RfPM5P6Q0elD8i+JRdwFjH3/ef/SQh/PrapAo3LrsblIIvI834v8zlkMbMECktrNiu
         k76BJ9A4Q/aNJdTKqiQIhdPM71Nq76ZJtKKN06c5Bbu5TxYbvpOJHocDWAl2DBpPFfe8
         q70c7a0dujggm4IhxfxttZlG3w2AxYqYBKiaNUFA1NLFHFneVgCJU55VO3/BCfYBeMLH
         i/c2XcQWFoKAhP8Vv1uSTpgtwgWtBwvnp2RG3veV0lXGB/cvwUveFPmgnJAN32BF3Q41
         Pwlw==
X-Forwarded-Encrypted: i=1; AJvYcCWxsEEKsdvMi8XkPrpqVI0M77OUQTDkZYMWszifuFSRbbSR2awuOogUgMEtiqRX2kSoxIWr4XanY4XOyJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vVvIYQahw0BNCvGrVe1Ens0o0b25lSLGUM99g6yOIi0r2AaF
	pCTxKRtfVfWoZWqArk+H8niQ3mPEBW40/kiOHTCYjOaWbycJPBqX
X-Google-Smtp-Source: AGHT+IFgUEPF+5evxRwSi49X2ukDLzYTC+t6yJMgeOY7nvbeTzeO4nYl+8niLu+yuW1dInB/APU9eA==
X-Received: by 2002:a17:907:e6df:b0:a8a:91d1:5262 with SMTP id a640c23a62f3a-a99b957fdd6mr274182866b.28.1728659154754;
        Fri, 11 Oct 2024 08:05:54 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:05:53 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/6] arm64: dts: imx8qxp-mek: add dsp rproc-related mem regions
Date: Fri, 11 Oct 2024 11:04:36 -0400
Message-Id: <20241011150439.4027-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add missing dsp rproc-related reserved memory regions and
assign them to the 'dsp' node.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac..4c4e71d39bac 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -21,6 +21,24 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		dsp_vdev0vring0: memory@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: memory@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: memory@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -63,7 +81,8 @@ sound-wm8960 {
 };
 
 &dsp {
-	memory-region = <&dsp_reserved>;
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
 	status = "okay";
 };
 
-- 
2.34.1


