Return-Path: <linux-kernel+bounces-360026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667999939E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBBC1C22F45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DE11DFD93;
	Thu, 10 Oct 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AOUaztwu"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14818C03D;
	Thu, 10 Oct 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591881; cv=none; b=c+LVa8QdRZOkWr5Aze0/56rn7uah7NZVNmIb5EO8ArH0hv1VOirbvq1Kcq2ZHZGVU1E/M8qhYBLe8Ma11f1fEoMhgyfsLGc5+LvGHaVtJqBvpJsvi0pHKDv9a6YHY3FykSvzc+N8Y9Ja9tSUc88E8/MYTFTZdjqHCO+MmCZYpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591881; c=relaxed/simple;
	bh=EZCATSrTvloVjbkKMEbSDOTA4ZTCzNep57DiW3EoUj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcs5biDt1EaYbqqnT7AO2JefA+kbm1zFfs7iA/8iXxJ4HtzXhlnQwblsiuu56HGNPM+dVB3P9j0ngdGpr7za9eZVvBUvoqLJFgUMF5Gu9TIxsEotUoeKJ3oINGzsyp0eYXh3z6X/x61+h95vHO+HlOB2ebXHuS2313Yt9WJXIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AOUaztwu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EZCATSrTvloVjbkKMEbSDOTA4ZTCzNep57DiW3EoUj0=; b=AOUaztwu1VEPoPcFH3OF+obr4I
	3rkGPKWH+65SmtkocxtLd28D+UvXgrz3qssJf5si5mqGBrjU5SoUm5suDb7jZzZh9Ou7eAWX3IAVj
	gO6Q8Hze4QhYOfqXxnDcUEIi7ALpwm+oBt+/0QMgLtrXTJtCQ857F4nBr+25PMiUIZUw8PwVd0HGO
	WNBLuNC+Eu7UzMEdfHmbDnt8WMZTl6jlSx6goVonxi8OO/HhTi/h+a9xstLmG/y8LXljrhY71B3SK
	AJY7txpv+tDIW1CH3k9SQhMohB7/XQa2G9KyxTlXcAGjT81g+ATDPNN0cDdT2KM0lUDeuGtXvSypu
	wyyzlRfw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1syzi6-0000k3-G9; Thu, 10 Oct 2024 22:24:34 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Add dtsi file for RK3399S SoC variant
Date: Thu, 10 Oct 2024 22:24:33 +0200
Message-ID: <46729153.fMDQidcC6G@diego>
In-Reply-To:
 <59c524a9a12465c21e01b779b42749fae148c41d.1728482151.git.dsimic@manjaro.org>
References:
 <59c524a9a12465c21e01b779b42749fae148c41d.1728482151.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dragan,

Am Mittwoch, 9. Oktober 2024, 16:06:00 CEST schrieb Dragan Simic:
> The way the introduced RK3399S SoC variant dtsi file (rk3399s.dtsi) is named
> diverges from the way the two already present RK3399 SoC variant dtsi files
> (rk3399-op1.dtsi and rk3399-t.dtsi) are named, but that simply follows the
> commonly used and/or the official RK3399 SoC variant names.

This is my only gripe with this ;-) .

I.e. looking through simple google, the rk3399t also seems to be written
without "-" most of the time.

Though for me it would make the most sense to just go with "rk3399-s"
here for some sort of clear style between -s -t and -op1


Heiko




