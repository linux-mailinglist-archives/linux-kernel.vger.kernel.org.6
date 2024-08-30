Return-Path: <linux-kernel+bounces-309451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B8966ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167981F219FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C21C1740;
	Fri, 30 Aug 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XsLRjzgJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7701BF7E8;
	Fri, 30 Aug 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050319; cv=none; b=epygisUS67ITvgzqrknbjz684Erfs61l6z0jx8vakI1UU0z0qruDnArNnz3p/rFnjeVUup1Zy/SrfGP+DsEIZYVZI+eAuYaoNYckCxWZXNi8wQVDZsjhi93LsN7VA2v48nvRtafrFa3rd9msCT+fsRWw+Cyexq8yNomNSCVsi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050319; c=relaxed/simple;
	bh=Ef607E2g0tU8wvWvFaFSKsAoh5Nt4fV2ak2rt+miEbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0sWQUzKS2RTFIacHK0OgXxnvTyuez7iUI8DL6SyTcubnMe4HclbsNuVw1CNKQ7ZmRuYKJ9ncnxlma1a1hqQiiljYU5OQzGEvQ9ReSHNLqXEbNZedNEydzJHmpNIKqdy5JGnOYGYU61e9wmAerYx/pP+w/UjAlM6E9CImv4ia+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XsLRjzgJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8DvzeP3tqcbLB2wXKxIBy3jnG0TMddl3cDp0QaYPiaA=; b=XsLRjzgJGXMEb/+z2CZiqfDC5s
	ZVXzq9qA2vSVzHcgB35kYMMblQTLASvgw24SRLagmYMRxwazFCeZ4b6jIW6UH0dtKpkHfVFsl1PvZ
	ncyW8Yrqc1AJ9C/4TJ6b1bURrfmh+1akLneCEpkteUQDSwHRLnd2wzzQpJFdQ9D5btqQZWMK8+cxq
	J6DOipQCQ4jn5175KFC7D+bfPNB4m43x8G8hJlPX/GEwJz2N/z5PADoK4lweC1+okbiPTlLtfOVzZ
	hGFL762NNbl/erFmtDYphDRkhqvxWUCKNqqcl5aAyHpRVFQS4MtRyZvrCDH9NV4iIfkLR65SLJBVf
	F2ECCFlA==;
Received: from i5e861921.versanet.de ([94.134.25.33] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sk8OB-0006ey-6A; Fri, 30 Aug 2024 22:38:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	marcin.juszkiewicz@linaro.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: rockchip: drop hp-pin-name property from audio card on nanopc-t6
Date: Fri, 30 Aug 2024 22:38:19 +0200
Message-ID: <20240830203819.1972536-4-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830203819.1972536-1-heiko@sntech.de>
References: <20240830203819.1972536-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The audio-card contains a hp-pin-name property that is not part of the
binding, and its contents also are just a "Headphones" string.

So that property also does not fullfill any specific use, therefore
just drop it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index d035a44e5b20..fc131789b4c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -76,7 +76,6 @@ sound {
 		simple-audio-card,mclk-fs = <256>;
 
 		simple-audio-card,hp-det-gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_LOW>;
-		simple-audio-card,hp-pin-name = "Headphones";
 
 		simple-audio-card,widgets =
 			"Headphone", "Headphones",
-- 
2.43.0


