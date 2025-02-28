Return-Path: <linux-kernel+bounces-539119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA8A4A11A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8123B11F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4B26F44B;
	Fri, 28 Feb 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eDwVDg0P"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D81F0994;
	Fri, 28 Feb 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765922; cv=none; b=ns+MBfx9LQcnR1ae9uWBakBfRA80jOdJXyt+nLCotIacdXmh8cslU1OmzVCLXDhTC7G/2YE7dDHpAKYgy+r+6QrkFzjaiLyQIn+VeDNTC+Y1M/zkNqD7CvnAA7wV4HamizvmJSz4YjRiCTmIJTCGeF39qvRLubnGc0KjRELi7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765922; c=relaxed/simple;
	bh=yMTMjx/KoDlP1RVq0AuEN0lZ1UnoF9941tNr72ZHNAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZ8SLfsIQrh8kNR/ivs2/Bg0+DQrCeZV0856rFyXc1D6Jnx8K/87OiTAXxEujxML7rBC2JRKpre3qRWw3kY/h9NfLAm8BxJtTYg5raHvxkhiNuyLSJox/rW9mY/i4mtiNF6nhonwhYccn/vRrwjxWTI1CkkKOmHST20HjlfUnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eDwVDg0P; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hKcLFlYKbjpxYMs8Fklx2IH1FNht5aVxvzEZPs0pdpU=; b=eDwVDg0PXmNAFwj5aQqKLJfeBh
	LNSxwiOXLviLdeOJVmeb8g+yT0h3Ho5IJDnx7a6/EI2zYRVlLrQGscJZtu8NF9YikoESnU6y+Gcza
	G+O6yTGIbF4XG7n6y6//uQwe/cENsIZvSniq2lbFvrOikWTKE3fYjb7e+iAxTcoJi5wOgrlqw3+Dz
	1/XBLjtNb+ZfPnf7xpZSdcLPJ/971tvo6IskOgeSiaPRfJSOqCF3+8FBwMcd6hZr47oHgwhwvqKvm
	N2M35to+WgdsAdSE1BGrnKismvuHsXZ6LdpMeoJFNU2cffB/I6s+z9LS+tToeHzPpo4XAz0HKhDjp
	ac0jwPOA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to4jP-0002Tv-IM; Fri, 28 Feb 2025 19:05:03 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Wenhao Cui <lasstp5011@gmail.com>, Yuteng Zhong <zonyitoo@gmail.com>,
 Yao Zi <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Remove undocumented sdmmc property from
 lubancat-1
Date: Fri, 28 Feb 2025 19:05:02 +0100
Message-ID: <5186166.e8TTKsaY2g@diego>
In-Reply-To: <Z8H5jjE24cZb4IBQ@pie.lan>
References:
 <20250228163117.47318-2-ziyao@disroot.org>
 <D848JET5TDL6.2L4ZQR0YHYQU6@cknow.org> <Z8H5jjE24cZb4IBQ@pie.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

Am Freitag, 28. Februar 2025, 18:59:42 MEZ schrieb Yao Zi:
> On Fri, Feb 28, 2025 at 05:55:47PM +0100, Diederik de Haas wrote:
> > On Fri Feb 28, 2025 at 5:31 PM CET, Yao Zi wrote:
> > > Property "supports-cd" isn't documented anywhere and is unnecessary for
> > 
> > s/supports-cd/supports-sd/ ?
> 
> Oops, yes, it's a typo.
> 
> As it's a trival patch, could it be fixed on merging? Or should I send
> another version?

I can change that when applying.


Heiko



