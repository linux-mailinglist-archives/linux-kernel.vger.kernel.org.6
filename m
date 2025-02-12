Return-Path: <linux-kernel+bounces-511999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE87A33291
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E53A8329
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425B204590;
	Wed, 12 Feb 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lTQYg2xD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992A202F67;
	Wed, 12 Feb 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399332; cv=none; b=Ou+60DXA71iobxq7YNClui6vnhNXSOHopUZJJPXF+79go6Q3ZOngd//lO8nJ7/YlhUoX6vMuH/H9di357nyuKzg1xDCdG0MUB5UfGOw94tsEWw4S7LbC5vF9DZnvvTxqx3pg9kwtVwpxYMuWlu0pMk7H2pzTYQKlORLqNrU2qkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399332; c=relaxed/simple;
	bh=vq9TuKNUGrbPDyIUmiBUAEAAfn3LO4Or1ApNxZIwK0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/ezR6ZM9+vhUCBFXawk2XyzxTHnATyYQu21PtRldYE8/1NEkF4haiS5CBVAcxOYM0e6h4tHLklDYHJdio192Fqk1N8JIKqt4zbWVzch5l/wWCDorb6KOqx1oadiE1+LqT/yVc6WIeJ4wDhuqhivoRuzuH29xT0k7WcVLyHuEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lTQYg2xD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pgP2P2s0bKk8vLZ5KHTO+UkvCszavZHV8wdbaiCNwEM=; b=lTQYg2xD/RhTQBHrmhLorBk+zx
	KkDrZA3NEtGLhYqBUeWV2ZiZfmN4u4q6Q8XeSz0a/TNL2UJbAalDpnsd7uUtwI/C44GlQpGPUoi5e
	nMp4Vq18UTEkhKfk8ZX/MCi5jptNd0JI33e9uDxpSKfZCALgAXwNSUuNV2VT3iwdKj0rkvaPtCg4P
	akufR2hyWaKU9Yy+4hetOlWnKyWmzJ1BQXIJPIJ7amHh6EXUoncRefpPBDSNzuw66eYVV+XRc186+
	iXBjSa1/7uL1CpdG33vdwqVcB3t87cSaLyPyhM8F3i/TGH3/NjT7GH5Jopv75MYK49O+VNp6/VvBH
	BNXvLOCw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tiLDh-0001kz-0K; Wed, 12 Feb 2025 23:28:37 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Stephen Chen <stephen@radxa.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>,
 Alexey Charkov <alchark@gmail.com>, Elon Zhang <zhangzj@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 0/1] Add Radxa Rock 4D support
Date: Wed, 12 Feb 2025 23:28:35 +0100
Message-ID: <3934037.fEcJ0Lxnt5@diego>
In-Reply-To: <20250212220236.116383-1-detlev.casanova@collabora.com>
References: <20250212220236.116383-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Detlev,

Am Mittwoch, 12. Februar 2025, 22:56:48 MEZ schrieb Detlev Casanova:
> Add the basic support for the board. (Not officially released yet)
> It is based on the Rockchip rk3576 SoC, so I haven't added the
> following devices yet:
>  - VOP/HDMI
>  - UFS
> as the support for those has not been merged yet, but are close to be
> and I already validated that they work.
> It will come with another patch set.
> 
> The following devices are supported and working:
>  - UART
>  - SD Card
>  - Ethernet
>  - USB
>  - RTC
> 
> Stephen Chen (1):
>   arm64: dts: rockchip: Add Radxa ROCK 4D device tree
> 
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      | 649 ++++++++++++++++++

it seems you're missing a separate patch adding an entry to
Documentation/devicetree/bindings/arm/rockchip.yaml

Heiko




