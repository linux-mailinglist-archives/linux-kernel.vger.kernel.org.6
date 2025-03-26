Return-Path: <linux-kernel+bounces-577340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C2A71BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65273189DE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984691F791E;
	Wed, 26 Mar 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="oe34fiHG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020701F791C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006236; cv=none; b=Lo3vtHiuyRSJgxftnSKfV+uFivPiObXECHvv5591UpZ9KEEuBkq08eB+35HjIIFgaTS+B0oQ+Jl45POvWjXxX7hugheOr1KzkUfkxSvsdyqHf+hhVh8pOOaxhO00RfuctIGEzsySU88ZkweDeseiONf89xXMOvHLBoUaFGwvyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006236; c=relaxed/simple;
	bh=sbUdINhLsUhhAyV0mvnO02l63FQfC+wlrb8lw8RlunI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOi3HILD/Cyu+jid3zMuR7htQIGRuywTjt2NAbZdb7jGNFDJdRBin9neza6sKUm6CDjRz2T0s6Cvev99ouFvtUqmW+idlKrD14J8bNeS+UUx9pITIfFlvVLmpc697f2xn/mIzVdiwXCiLb5JZo3Il/c+OsXtMmyaVuDSiF9mJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=oe34fiHG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac34257295dso1434035766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006233; x=1743611033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLyts1UbCS80soWAIK/VLH5pGMtL6M9HaPrhO/pX88s=;
        b=oe34fiHG3kkHN9Y77t8+woUpON5Tf3n0OYlG6JrkYsP69+LDaujhzmXyUbXOdt6xFI
         xVODB/v5msQ3nmXC/Jsc5bx3gFVWYX4YZi2VCVrYRyypbNCg1VqEAu2x2+Gw9DmTRVzW
         bByApbbVQ6DK/Clcx5h5ESF3ngQDYjsSfDm9bO8C3Js+rNFpTa/QisPfZ0gXizbgtan0
         cwfNgKaGaCEBM1LjT4EQ9kHzoXS1b11/EgC/8TskzwNr/1bsZ1Ud0O90gHlNfUBLzF8p
         ExMu9LBpO/zJYQdmvrE72v4ySnPiJOuNfwQqozNkZFuqHglvqS1A5lbmlw4HA2rEfbmZ
         2KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006233; x=1743611033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLyts1UbCS80soWAIK/VLH5pGMtL6M9HaPrhO/pX88s=;
        b=QQtaHy+0cUhYJYUxfbeLTnX1VSd+MvHdYxINof8Mv9gSkGZwQSR8Bb3+uudS0zdBBp
         Uw+rqtaJDAh94J0ThOAJbFQFeF7LMoIRCJrFj8NGfovCkUaIIhZn0EcbJrPI4PS3mkR7
         MOZ9prbuOe6SNO9XAW/A7I+hklOt+6Evwg5dadKQgD3nmQvA2yb1mehMLB/GIcl2bh4B
         ho9OEHRckL35YBjEyNXX3K9WaMgLUU0vvsf+gJ/hJDt3RYq47GxFOMZm5dDN52iUJLbp
         klxAfINlfNz2AJ3fYZqD2rWqasazxvooAeJcdsy32kAwx1o1wd4GfUNc5WmAT0cZ38WO
         fDmg==
X-Forwarded-Encrypted: i=1; AJvYcCXfnQluJ6aghczm03Shs1JftIpcj14aMxAPaVYzS/4gxzEG5/KrkD9D2gTogr22sAVInZAh1UfRAskQeYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2nE699qfcjJo/lffbISWPTiaFBO/xiJNW18RwOWGD3AtrDSq
	jlFcil/GqZfeyplTzX4/YQZU6XvI2KNQd4kJq9yEXFleA9qnlFILGdJAOXXekYQ=
X-Gm-Gg: ASbGncsVIm5KSiKhJQcLQtTeo2LFEexwyFz9yUEuZeErb6Q6JsMCZazRZhaloOHZ+oE
	52L6Nfl28le/c2tN685lAGwVdtFwHkL2Uy8FNthOciMpWmTPeRke3s6xK8+nc761d8GURA+n6fY
	SEDYWm1H6lm9BIE8yoPWXUYVASLdisiBhctYmdRjVDY05Wzer11KIF24u96P32s65gt6PgO8YOJ
	S31hHaXE2dobgz1ent8it6vEcO6yRM9C32H7uVMcdfO95yE6T4HHTDB7vDFml3LgxaGrLoZwtnT
	xeDtmKji54Q3GbV22OCWcbnStNgTggYzaR8/9xyYRWIA+VP8DoYcPYuqMA==
X-Google-Smtp-Source: AGHT+IGuL6Nt4ApMHrsVVJxTN8kmsE+fO+syqOdRHUYnjFPTrq5knLFF6NaAbaKnyWcocuiQ/Tst8w==
X-Received: by 2002:a17:906:4fd4:b0:ac6:b639:5a1c with SMTP id a640c23a62f3a-ac6faefef90mr4899766b.22.1743006233086;
        Wed, 26 Mar 2025 09:23:53 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:52 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Wed, 26 Mar 2025 17:22:59 +0100
Subject: [PATCH 4/5] arm64: dts: rockchip: disable unrouted USB controllers
 and PHY on RK3399 Puma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-onboard_usb_dev-v1-4-a4b0a5d1b32c@thaumatec.com>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
In-Reply-To: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de
X-Mailer: b4 0.13.0

From: Quentin Schulz <quentin.schulz@cherry.de>

The u2phy1_host port is the part of the USB PHY1 (namely the
HOST1_DP/DM lanes) which routes directly to the USB2.0 HOST
controller[1]. The other lanes of the PHY are routed to the USB3.0 OTG
controller (dwc3), which we do use.

The HOST1_DP/DM lanes aren't routed on RK3399 Puma so let's simply
disable the USB2.0 controllers and associated part in USB2.0 PHY.

No intended functional change.

[1] https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf
    Chapter 2 USB2.0 PHY
Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 3a9049372e12..d0d867374b3f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -579,10 +579,6 @@ &u2phy1 {
 	u2phy1_otg: otg-port {
 		status = "okay";
 	};
-
-	u2phy1_host: host-port {
-		status = "okay";
-	};
 };
 
 &usbdrd3_1 {
@@ -611,11 +607,3 @@ hub_3_0: hub@2 {
 		reset-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 };
-
-&usb_host1_ehci {
-	status = "okay";
-};
-
-&usb_host1_ohci {
-	status = "okay";
-};

-- 
2.43.0


