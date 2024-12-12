Return-Path: <linux-kernel+bounces-442611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81299EDF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7930188AEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845B1F12F8;
	Thu, 12 Dec 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="aytIHSjt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFE1E0B8A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984469; cv=none; b=g5Pdv2vlYkbRUaGWpSNfQF9XdsSfyMkydpW+ESl5VZDNWm4qYXz2AMCAT+rhfCymmzUJvBwFEMtL66BoYmV2KNyiVIQGqWjIGJByGndqAnyS6aD0v4x8txR4u0Ivy3tLiYhCzmO1yDcqokCrcQ8PHmjg7sH8q+ldMcdq0p14imY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984469; c=relaxed/simple;
	bh=avKIUroYrZKYj6D1CRyY4d/YTt6CJpUZHVOx7l9FXn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Q+TnNdaYjrI552JWGQ4X8KXJN+62KQLRxgpBIfxIW6CfOiYzd5rU9wQM28VwZicjF8vRdNkJxfuc+6xlaxESQkJbRdGg4bigYcaV7u659g0asb4sR73EQ3lAc1MJv2b2sML/ycAxaI2wF4xYBjyDT0vJ/JBdo47YnIb06ZTMuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=aytIHSjt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162b5d2e1fso481275ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733984466; x=1734589266; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OyTPmfk5nlWT6oblaTqVg0NzyCQ779C0HWVuTXhDcag=;
        b=aytIHSjtD+uxri2kveKBhYyTJqLLF9ngn/x9CN41TV47hJlQfnsjGS0Gj96dL4C8Jp
         USUtaSzvvpxPnXO5VH58ia+FJS5+HF+pGpVwtxQcStZ/6CJBC7GMbKcejfIcym+m96yo
         0InLAXgUgHEmKi5uAAMV3jDwjA1qZsAmhpSiCSHUEVibHiKb7c0c1cS4QekrDOK20gSM
         QieGhUCAo+NBRElgnjjEWcZWTjprupNf26AfdFjL1R9PRSZaDu1EVwpdRQ9Rh5pQ32M+
         m/m1tlDlnEBNioOGTlLxgvWgKGLKsz4zNNev4WYZgSmstEjK6t7CALDmZ09De76blYMa
         icWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733984466; x=1734589266;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyTPmfk5nlWT6oblaTqVg0NzyCQ779C0HWVuTXhDcag=;
        b=mBlJrNUbWdcV9fKjKwUFK3zju2sTSTTo23EOcOkveF3x4clH+dZWTOsvgnIlcQa0jg
         AoJ3796DsWhCPxT0yslKM+kqSJ2Am67UO+zVMvn68I79+alcedwmjtXl7TfHQWv4gcoK
         8La8ykjiPVm/alNIKaLeVeg/lyQn6H6Pi8ry8YmOrM/Rk0YGYfLGp2br6cLYCSSMIUXI
         7lHBkS/rwKypnK64PpBirLH1gBBESOkjnqv9XPi4RV9o8gQ7dadlSUewo2PeexgfBiRt
         CMQzKN5NP/kaBFMiCYT6PbcSXZugE8FrIb8PlEW07tzHHRuqJf3t/ererq7X8myMD9tx
         T97Q==
X-Forwarded-Encrypted: i=1; AJvYcCVscDm1s+f9C8zhmQrvXBvizTqoGm25IeJDY9sQ8VcKGjtaeukKm7lyIf8Um/ZrzwvTfdoOvbZDuV4FfMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26wHwD9epUZaGetxehmX8P3r9RvZLtngLm690Mgfx7KaGJLJd
	0x4POwfDU3amL7bQnrg/vlr04F7UtC/Pkx0AC7Et1uuSbdfaXLUBIuweegpHD/c=
X-Gm-Gg: ASbGncvX1HDbgZwmE4656noHNvElDTNB439jFpQLCIbFVWKOlI09kNETJEA4KHrXrSv
	S7qLYQKf9GvNAxngIeyM9iA9R/QSd50l2m0IfxZff8iJnCkvnPqx1GA7NJVvUQwR1cAF14lAjJ0
	L6zGGFPs0Voj977afF64g/EGEeqJNE5xewNmNAAT16tRby0eV7L9GkVolyj7cz66L8bCPe8aVAe
	EOGjEqxCwFd6QT5J2P9IQ2+3SWK8Su3MShtFCY8ZhLjKx4syvSY/KHpfrgiUKlglFyHtvPW4uRO
	yQzMireMg/8XtVBpszxc
X-Google-Smtp-Source: AGHT+IFTcByLcObOG6og87W+8MmWO127PMV4RjfGUn4gbh7uXS5H+igPgK+lk69avI2I3fCZBkEIxg==
X-Received: by 2002:a17:903:186:b0:215:2bfb:3cd7 with SMTP id d9443c01a7336-21778592996mr34393885ad.10.1733984465748;
        Wed, 11 Dec 2024 22:21:05 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c278668sm83579165ad.81.2024.12.11.22.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:21:05 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	dianders@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v5 3/4] arm64: dts: mediatek: Add extcon node for DP bridge
Date: Thu, 12 Dec 2024 14:20:45 +0800
Message-Id: <20241212062046.22509-4-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add extcon node for DP bridge to make the display work properly.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index cfcc7909dfe6..e324e3fd347e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -424,6 +424,7 @@
 		ovdd-supply = <&mt6366_vsim2_reg>;
 		pwr18-supply = <&pp1800_dpbrdg_dx>;
 		reset-gpios = <&pio 177 GPIO_ACTIVE_LOW>;
+		extcon = <&usbc_extcon>;
 
 		ports {
 			#address-cells = <1>;
@@ -1656,6 +1657,11 @@
 				try-power-role = "source";
 			};
 		};
+
+		usbc_extcon: extcon0 {
+			compatible = "google,extcon-usbc-cros-ec";
+			google,usb-port-id = <0>;
+		};
 	};
 };
 
-- 
2.17.1


