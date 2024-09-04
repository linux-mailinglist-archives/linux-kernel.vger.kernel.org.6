Return-Path: <linux-kernel+bounces-315799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C069196C723
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FF283BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12791E2025;
	Wed,  4 Sep 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="M+j9RdEr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41B1E008F;
	Wed,  4 Sep 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476843; cv=none; b=Nllw4/N7U/w3Ph+qNc+Io/8Eun8saD08TLJo6GIj9tAAcEINdnjgYmzrvEpCDs+WpIb5kJPxF6ajHh6FRPLlvFuLGkh0SUlBoSXAfvqOCdrWtEOHJ9usxNWKuekMw/Qnuc1riNlwpwvruk+ZAa9MUX9PHFQbTgUVUc458z+glMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476843; c=relaxed/simple;
	bh=luzrVO1iofQvdwjgoUZTBVQ2AAEs7vbBwEvkVKvSlUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCF/+kQxXTpxt10b9niZmigohF3vEDrSKrHDGmLH0+2EMCpvEfOUETVXett2yP18lvpz5R6BpnmS/PoLdfsnQUnna413bd26/ShePqzw56LRcMkGEZYHOF5BCU02Ricvy6BcLQPac/iVdKua5hY0TqlG2t3oQQE2cFT6b1v6GrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=M+j9RdEr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4XezWaCV84WdKJFB+54y5YGzywF1p0XJ2FAk+PMsynk=; b=M+j9RdErBG3+5j3xb/cG8Szesi
	bghsNLbbwd6+UU7dQX84aozxznnxKSCCkQYZaFj2AQYdjeBjAJqezwJyAGcuQhC2/PNr59x7jsa7t
	Hg5vPHdRvikMmW/2es2oXSQ6wqaVtfy+a5M8SmHfKprTnLKrGHeoklO/QGMH2XS7tL4FUrktT7pFn
	AMyD5wFgumc2dxhzaCR9zYG8Aer1160aZGBHdEggBWf7W7PNNcMO0CfzSgciKtFSBZJh8xOuDh3fB
	QQa57erRpGpr/kzvRvCmND+Q1UeEATjM8jbpq7z5cZP0ue3SKRwwTI+YM4eOOIRMu528zALaXMdVX
	TTzGEXZA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slvLX-0002Po-T1; Wed, 04 Sep 2024 21:07:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Dongjin Kim <tobetter@gmail.com>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add Hardkernel ODROID-M2
Date: Wed,  4 Sep 2024 21:07:00 +0200
Message-ID: <172547678274.2721598.7278836830235171235.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240901112020.3224704-1-jonas@kwiboo.se>
References: <20240901112020.3224704-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 1 Sep 2024 11:20:13 +0000, Jonas Karlman wrote:
> This series add initial support for the Hardkernel ODROID-M2 board.
> 
> The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
> RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.
> 
> Schematics for ODROID-M2 can be found at:
> https://wiki.odroid.com/_media/odroid-m2/hardware/m2_main_rev1.0_240611.pdf
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M2
      commit: f1f348158813f64cd772d6ff4a3df0704285c14c
[2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M2
      commit: ce48b8c976ce439c336def6e06bf8224a8ff9125

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

