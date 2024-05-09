Return-Path: <linux-kernel+bounces-174474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D68C0F50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9771EB22E61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2701527BE;
	Thu,  9 May 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX71lo6V"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4114D29A;
	Thu,  9 May 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256450; cv=none; b=AJmV70vngM9BreLVfsfja/zJ1wrCOOQhpjk8tJBCFhr/uQLypWJ4+X9iEc1uTRpC/27DGAcDzl2q9Vd+G/mgLCirWiHQutRTSOi+hWkOvXKfHA6Zt9/WK2yKtV+9v5kOi1YE881MrJHP5ozqH6hp7q2rMZEdDyhjgXIn4G7agHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256450; c=relaxed/simple;
	bh=YPpzQcMQfowCq7PrIWevR9zUfJLG7X2QVg6gpF4OREc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4cXsqYg5wD5VBPXzWuNfjC3kKt4LsHO1wroIL9e3dSlNrljyX50vYYaoXZ2TmGz74EDTlE29HTlwkSOdY8209L9u38wOMsynF4a3Wd94rFwxdS+2o51vJXfhar4UyNXQwAUQajDdI2ac+pAiqyctdqY7Q+uwPSbymoz7gno8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX71lo6V; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so9349111fa.1;
        Thu, 09 May 2024 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256447; x=1715861247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BojjtcE4PW8Jg2RRLDbuh20R8FtUvCT6KeHyvo0GHNo=;
        b=iX71lo6VRtiDvMfWyHTJTV7AG0OO0uYZBZ0IPLTze5XbobEmFzKGxUkQfcn1Sjm49y
         0z6QqL3uoSW7TmBo7Pob7t+qqBALHIDENO0uvhWDFkLLBQ3fpDzNIn49VS5baJxl6vf/
         HRFnqR3dW53RmqfqZaz5qVscG9hLa04siBfNAtRWBrR+EqDogKZ41mOkbBNAOJQAg5lk
         U+0OJUGUHsMqol1lDVo6jwHzvvGfoZBMlTftHRE4XkqQQWb62XQjiD/cCyIqClI94m9N
         4OKMQXZdljJQMBh/o0BlhWniWjh1l3ToYfPD8ksAonawWnqVeEzB1HLgdtTatxoooap1
         g+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256447; x=1715861247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BojjtcE4PW8Jg2RRLDbuh20R8FtUvCT6KeHyvo0GHNo=;
        b=I3NMSC+JUKa4CpPvd8tc92k1nV//Z86bUlOq2DZ3lss/pbP1x3QzJnMfpDpVpUUXQx
         eybJqERneU1zx3SXsm1IyBSO504d6KEd8Jv2ikq34cn+KS1e8BvHNgKWP7Vi/DV7Sn47
         bnNvgXDU3RT14n92rt+cNXQ4FFrdVhvkqnpjIvuqHojugATiZUKG/oae6KpFp/1/+ttT
         CmOIc4l7y4sxzQkjVJrU00xnDfzSRVkNBYBAirmsDCNKx5xvsDJrtUDvfh30wYAvHRKQ
         AisvJ8+4v9kGi7WE1th750rL/TWcaq/lK6Up9oigGIiaXmBkml+Mbs/cRUDlqpicSit7
         udZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMhTpd19WhAI4P5UKXozK04ssS9oi1RaNDWmRJAawkP1B9Fxd1Ja55Di+xzjVecjd8mg8fjmgX5jecv/hJYeoVV++GPn6PjSFsRoikMhYwAj73cXX96vcyk0isxE7wfjmc4CaI0b1sMR6INZwy1IZl+YHkD1V0FADHp+x32jx4ac7RKg==
X-Gm-Message-State: AOJu0Yy39YqWbFwP2PAOIhLJIMXjDoO20t8lSlvJQigAx4lzY7dXK3kM
	yeuMX5STngu8qHpD+KKJXNKUrSjgKeWoeBLO5d8apzZDv12q7EU=
X-Google-Smtp-Source: AGHT+IE4TX6luDFQmraVbsCSCIhJfzYELnpsZujXaSoQ8waQa95ruXUBJvJ/gqlTIZi6yx2evpmhPA==
X-Received: by 2002:a2e:9983:0:b0:2df:c0c7:9046 with SMTP id 38308e7fff4ca-2e4479ba923mr37325681fa.35.1715256446939;
        Thu, 09 May 2024 05:07:26 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:26 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 6/7] ARM: dts: rockchip: Add D-PHY for RK3128
Date: Thu,  9 May 2024 14:07:14 +0200
Message-ID: <20240509120715.86694-7-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The InnoSilicon D-PHY found in RK3128 SoCs supports DSI/LVDS/TTL with a
maximum transfer rate of 1 Gbps per lane. While adding it, also add it's
clocks to RK3128_PD_VIO powerdomain as the phy is part of it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - also added SCLK_MIPI_24M to powerdomain
 - reword commit message

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index fb98873fd94e..fbd95bb08cd3 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -216,6 +216,8 @@ power-domain@RK3128_PD_VIO {
 					 <&cru ACLK_LCDC0>,
 					 <&cru HCLK_LCDC0>,
 					 <&cru PCLK_MIPI>,
+					 <&cru PCLK_MIPIPHY>,
+					 <&cru SCLK_MIPI_24M>,
 					 <&cru ACLK_RGA>,
 					 <&cru HCLK_RGA>,
 					 <&cru ACLK_VIO0>,
@@ -496,6 +498,18 @@ hdmi_out: port@1 {
 		};
 	};
 
+	dphy: phy@20038000 {
+		compatible = "rockchip,rk3128-dsi-dphy";
+		reg = <0x20038000 0x4000>;
+		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPIPHY>;
+		clock-names = "ref", "pclk";
+		resets = <&cru SRST_MIPIPHY_P>;
+		reset-names = "apb";
+		power-domains = <&power RK3128_PD_VIO>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	timer0: timer@20044000 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
-- 
2.43.2


