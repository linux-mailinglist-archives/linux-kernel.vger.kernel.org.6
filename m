Return-Path: <linux-kernel+bounces-174572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5088C10F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D81C217BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063015E5B8;
	Thu,  9 May 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo4h0Fvi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45E15FA83;
	Thu,  9 May 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263628; cv=none; b=RkDwxm2SW0jSq1AR2B/pKjdiuk++WqBTJgr/pz528LJB/VIWbnuRG6WZbICGk4dmzLMj6Dmk9HkDWdEyCdl8BVsB3Sr8/dkqmKeKh9FQKoChqWczFicO8K4p9xeGDLBWn6VC6fGHrlfrh0DlgthV38LQmYCh0L8sI3r9V+YMqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263628; c=relaxed/simple;
	bh=YPpzQcMQfowCq7PrIWevR9zUfJLG7X2QVg6gpF4OREc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX0gJQfPfzEuKrzYblgKpxVS8Zl6k1sck/TXfcK+nO7C2tsfXirAL91gkwqDBzbkwMn3NnCfKJbys4IZzoaJTqfXIs7zFLcC78SNRGxiHXRjBTn5hUoUHklr3xBFb+EqmOHroX4XBQLvciKWjcC2vHtvP8dZEwRAtC1L5iDmUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo4h0Fvi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51ef64d051bso1007363e87.1;
        Thu, 09 May 2024 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263625; x=1715868425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BojjtcE4PW8Jg2RRLDbuh20R8FtUvCT6KeHyvo0GHNo=;
        b=Jo4h0FviTLqfJUSnuP/TjSbQEDkNBorX1ITyzz5gi4Wr3LLbufEmehDdRgqvJWZDR1
         x3JYZK++5Qq6dnwIz2G/NYB1XaU3OCwL9qBQWyEjzjyTbjVR+52lBQa5OubPYBK1MWwm
         wcHb2i9QHensNbG8q7VwD68I4f4rY9frdFub7NlzOeOJBCuGXgODuPugJZ+qYzHERiyM
         PyNjJKSmNwqcE9ylVbEHRf7inrcjLWwlkH8jjGPfsIjkChwL6sWQx17m+IKtbVHqjd6y
         5rhI2mgDrJAPuRSymwyHg2gjaKC1/T7RrapPPGtSe47M0BUZ1O+czQ7Gt2kyTlX2WH6S
         W+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263625; x=1715868425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BojjtcE4PW8Jg2RRLDbuh20R8FtUvCT6KeHyvo0GHNo=;
        b=ZlURm4pPx7qm3zKQaIK9lUNG87OBfxdGDs0p0BhO8XOtXPZhxYXmitssT2gluuWQ0q
         dD4hYOxuyxtLfebGqUBhameURrRjsJ6jygzz4zYkb6EpstApvfJ9nvDe5EswNxpR+prn
         ka1fBlzc9YEuNxHClDeoBj44hLbgDlCEp+iEDW58X2RAurI8jzMbEfQwzQrWSkw4qx5q
         z0G8Iyilbq9vQuI+v84ucN7VLxttzcmU8CWfRqveblWbT1MzU9J7ZPYmQYqCeUb9xLMZ
         lmYbZwTgSU2RFSyqWeW49jeIzlA2Y1Q9x32L0jDwJ/evV8tsHvaNW/Su/RDqw+XXkZvh
         KWBg==
X-Forwarded-Encrypted: i=1; AJvYcCXZuXVwFkoROKWwUb+XV80JQMOfIxbH+5W2yz/06wck+cZNRGGoz9PVQSVdBu45Kgstk+YijdMz0rDOExacqGG2S2mTrNJQHuI6DjSaRMAP6J/gcHJ5GP0I2C1A24EgG+VK2kXTT80+JIRmO8npgT9IMql0bbICZWu5jQOk9X5Joh4afQ==
X-Gm-Message-State: AOJu0Yz+qfekPvW+t6tFHWa6ZEM7EZsKlA/grW3ekJgBKCFcomJrFewH
	vP44w8FyigtR5pV41CUmuOok2iRrQjZI3BPdwOTYAJH1chQPlHg=
X-Google-Smtp-Source: AGHT+IHh+dso5MhBn431TAWM/uD/cNhYOwNyyWPRjGSzNSz1xBMrETqF5hbahKDBfppAyPHSKftcWQ==
X-Received: by 2002:a05:6512:40a:b0:51c:c1a3:a4f9 with SMTP id 2adb3069b0e04-5217cd48861mr3707317e87.64.1715263624613;
        Thu, 09 May 2024 07:07:04 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:07:03 -0700 (PDT)
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
Subject: [PATCH v3 6/7] ARM: dts: rockchip: Add D-PHY for RK3128
Date: Thu,  9 May 2024 16:06:52 +0200
Message-ID: <20240509140653.168591-7-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
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


