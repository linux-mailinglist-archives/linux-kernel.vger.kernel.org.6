Return-Path: <linux-kernel+bounces-373583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D89A5912
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9153E1C211BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202E1CF2B9;
	Mon, 21 Oct 2024 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="DksPLE62"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D01CEABF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479721; cv=none; b=VGoM/tujnbWzAR/lVQfnvn1QfUuzF27K1m0OIa+FdyVprDjjC3Rlm7yC18hdF2XK+gNLZ59iB/6QigPueLsCzFWxg4BVLScUZkVG4C6BWJo9VjW0Mlw8fe4HnQ5qMLmteZH5FoOfoHGBANwLkIVcn40D6gBQRjWcOhFpaNWIhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479721; c=relaxed/simple;
	bh=03Qb5hxKK7rAKMhBjn9jT6mqUqatJTsr8tb5L6OSVI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SgHnkqwiKdic/RGPbq8vR20otkpNY3mFKV+qYGS1p53+YjDitFqxPGgDpvDgdAaFGoL5vs0WOK8WnON+1zhW7NKa2X+Ce//f4LqjlNyjIb4ZIxiSm1yJT8tGFFR4La7xVC161TRyBZkQF9u81NtIXgutWTvlUo28w3wSVSqlMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=DksPLE62; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c7b9087c4so2920235ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729479718; x=1730084518; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=DksPLE62CfJHvPyX8FHwKa1tnZlFQ2bdJTvdaUJXkRUO2wW7+NKBtBzgbZ7gOwN9Xl
         gLZY/qCb0RiwYAuIyeUhsntCjF7qNvebjU00kfin8MNM1+QzVMUfkMy+dyLOz+SpypWQ
         Le5nIDZUdX8OhWNTfSdCHUdBJBguTBof24hcRHNWjwI3KDnDRtgqeI2F8hWtnAAa4WGa
         aYuWuTChMNPtxyvGFAX9HzhQF1TshIoOOqlxeTC9Osp023XU2To0mJ2pe9WjAf4LM1VV
         Vrp4GoIqKyjblKptgZa2jIAb+EaEkV3uYx2mzkhBaoMD6bdb4nSm45o6loaS9F7RP33O
         jF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729479718; x=1730084518;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=CaETg8IH5IRCSs4Pe939YgzrCNJe+ucRL4e2R+H0E5YCj0ZgCb4uqqU0JgUkuFvcFB
         O9EEXg/kUZZl/LcHiPm2d6EjmvQmYF6Z1aOGY80Gjw69TG9YQJUTGFsvlw/0aBZ6IRND
         +2a3QfyPQNg6DOuISpBvv7IZyJOhhMZt2XDeqZOQqWDO5GnA9lhgVoKvLeK3OlUt4Mhw
         msJeh5m/YzJNvG5p+5ibjl7i9Nm3//H5m9mo+0dbmJCJHWKDaZwl4BjAiaiLEVaenRqU
         dDd9LX+qqEmFnyptPTIkTSV5vnQG8AAJW0oI5HBbTW1AXY+NDZKTcGFxpGEpwEr0Q41R
         axog==
X-Forwarded-Encrypted: i=1; AJvYcCWKWDTNQDIVc2+M5hytMUc+dxlfSCJr7fe408O78bogUbp3u+X6xtI7uPlO/SfMPLQUM+uUllz7/nRnA5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89N36ahax0VP6e92ANeljYRqYusyO4KhZac6CAdQwuhXqcNhI
	jeFTGnYLnQw2bW+VWGZC8ut3csLS87Pk+ZtxR0c/x1jWnblrXxTXMWQnTxrS06w=
X-Google-Smtp-Source: AGHT+IF2l3fvw7cZnTVlJG1e6ibKKbfgh+RtTSulFnAnUTynhu5L+2rzXIOyMTwakDpVOl1YUTgIEA==
X-Received: by 2002:a05:6a20:4311:b0:1cf:4c3a:162a with SMTP id adf61e73a8af0-1d92c4ef619mr6775462637.5.1729479718621;
        Sun, 20 Oct 2024 20:01:58 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313fb5sm1815601b3a.7.2024.10.20.20.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 20:01:58 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: devicetree@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 3/4] arm64: dts: mediatek: Add exton node for DP bridge
Date: Mon, 21 Oct 2024 10:59:37 +0800
Message-Id: <20241021025938.676-4-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add exton node for DP bridge to make the display work properly.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 682c6ad2574d..943837f20377 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -424,6 +424,7 @@
 		ovdd-supply = <&mt6366_vsim2_reg>;
 		pwr18-supply = <&pp1800_dpbrdg_dx>;
 		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
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


