Return-Path: <linux-kernel+bounces-381131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51B9AFAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4201A1C2241F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2831B6CF5;
	Fri, 25 Oct 2024 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TprDS9JZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2B1B2EEB;
	Fri, 25 Oct 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840423; cv=none; b=hgMSfdK+s9kU0ajDn8Kt9ctgu12NwmKuect3lgo/d5kTnAV6vzHPKpIvX86nUJR6XOclcmq4CjiCglCS2Pc3eOMYW9uQfiO3J5hK6MifV8aSSqc8eiC5YDb6gybG0DvvwDGKqkm2DIIAFk443q6wDDJkY67jEd8sXxXq2000Ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840423; c=relaxed/simple;
	bh=9I7uqf8bnaCMpPhdMhio3iWHmE81AvKut74bKlXhVxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAwBnVLQSqUbFRIIvwq6csHEO8MxQH93ZsAKKQ08MMOcqquMk0OIezddctvonGrUFG1dFJpgBKUlCCeGlrvBg9v20nSHxj+qFOnOcDfO5LrtWoXtbA9fWk+u+DdB5oT5SWl/e5WkC1/Dec0IFErRIaSFJwWarD+bZaWX96FOX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TprDS9JZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=enn3t52h/bw7Y5aOBI8X1K/59nvOCKaVHmDjz6Fts18=; b=TprDS9JZ2J1eX7KJTzixaefwPb
	3M//lguL2KfoaPPrfaTrYpY0lcX8faNJRjxv0X7W+S7IoMObLUW098msv9XXVv3EBLe9ZKjxC1mxG
	D+YOTu4urAjRxG0adiMYvBHa69ciArwIOS1PFWl8jCZP083ieHiOfGXUTTUFBquCD46YibrKCihTC
	6o22vekJO8qWu/EpnGAaLFm0lMJfiHMH8Xm0W+q1J0zrdxa9VpkmM+olIBGfhjE9aTqw59mLQB3pm
	nQVh3ApwtjbdlfLCZAsSRfFBMKCsGR0sZdUQclplpTwKd/hgC41wXMaZryWMqU8cpbynul6SwwqN1
	6BufvjWA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t4EVr-0002dv-KD; Fri, 25 Oct 2024 09:13:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 1/3] arm64: dts: rockchip: refactor common Orange Pi 5 board
Date: Fri, 25 Oct 2024 09:13:32 +0200
Message-ID: <172984040935.1798677.17350099060125150020.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024095038.42079-1-cenk.uluisik@googlemail.com>
References: <20241024095038.42079-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 09:50:20 +0000, Cenk Uluisik wrote:
> Unique to the Orange Pi 5 board:
> - M.2 NVMe M-Key PCIe 2.0x1 on combphy0_ps
> - SPI NOR flash
> 
> 

Applied, thanks!

[1/3] arm64: dts: rockchip: refactor common Orange Pi 5 board
      commit: c37393b36c1d2a0f4fafe82d7e32bfb726f660db
[2/3] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 entry
      commit: 3d346d38367bf01e9a3aab7370973844e3808f65
[3/3] arm64: dts: rockchip: Add rk3588-orangepi-5b device tree
      commit: 46fa3fee0b1c027862b04717b51630195c253a30

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

