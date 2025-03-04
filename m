Return-Path: <linux-kernel+bounces-544453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD82A4E1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CC5880CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D186264618;
	Tue,  4 Mar 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KTdCEV/z"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6020A5C1;
	Tue,  4 Mar 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098889; cv=none; b=didiwaKlSP8O3eHJBszwkTEMBYVuo2UR9tEgQSy4QtUtU5dWygKb/WV717ISOWS2BnoyITC6uFBeNOzFqwQN/sv6ii7M+1AG1bm6QB/53aXoMGN0fAPErKB6pFthDc4rchwg5wi8q39+Ojd2uiiGWDjp37Z3l3rCY+yYiEbxh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098889; c=relaxed/simple;
	bh=lHCP7UG5o883B54j8Ri/yU9SpSbtzNptQnMdgCOoXo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6hEEAHoesl4MC/nt9+gQTJlrEY1MBzzv9ipratB/21mSeF9C2V1bcbEcphFfK8Kfv2cKyhO4EzAw6CYG0Eya9kijssELXJl280mWwmf0llro6i5pgGRifM1ix/mX8B9TbkVj1g90DHjGJUmpw4Av0HpZ5HBrzj/wIr37553/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KTdCEV/z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Gqyom2Qw8VXFf3AYIpGbjCuS8c9RY7yiAyJBWvJUfc=; b=KTdCEV/zTusAeUlTIrBuBAb6SW
	QOPuOTIm7BL/bYx2YPLJAYBFDF28jitg9fxcPZ6HfAEBuQ/bthkTDwK5mTWRX18uOq1FNvKIvh7J6
	nTZB1nFXW3Y9YXExh4df+JzoAmiG3am5R5qRJ7iGejoN6o5z8ZsxZtlZXjVud8XaTZOA/wZPmNnTU
	gyqZTRpr2ewIXAoPpKPAfT8rwGqDQ6/IUPt7HnGhQrwTp9dhdUv2IhbA+BD94/tn+iAIwwDt931X8
	61QfDmBDGVaoGcaaRbJJCC8q/qOP13pFtoMMx9v14XgF/L+KL4Bq5OYk1nh6j816lZCTw6sCXW70X
	Ucn1A1wQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpTM2-0003uT-SQ; Tue, 04 Mar 2025 15:34:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3399 ROC PC PLUS
Date: Tue,  4 Mar 2025 15:34:40 +0100
Message-ID: <174109881585.132749.2987468837584062976.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
References: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Mar 2025 11:41:59 +0100, Krzysztof Kozlowski wrote:
> Devicetree bindings for ES8388 audio codec expect the device to be
> marked as compatible with ES8328.
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3399 ROC PC PLUS
      commit: d83f6c32d70f96037cb187e63785e7a58f9e751b
[2/2] arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3588 boards
      commit: ced36c336d241eafbc812fed27e6a52908d249bb

Thanks for the heads up Krzysztof, about the asoc patches getting accepted
for 6.15.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

