Return-Path: <linux-kernel+bounces-439089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B700C9EAAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E644282C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C71231C8B;
	Tue, 10 Dec 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RKwizwo6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D32309A0;
	Tue, 10 Dec 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819307; cv=none; b=AR/ro4hIb/OYiQeBNf3Vhupx0h8gKn8TAmu6SYhHwGrzp04d7wzHxy8bDy3R0ShxcavdfyARqU5zV2vJFDG+6KhNhGQvUYfyuuLTWisbK/1Chc7qaVT7Wzi7OWP3tvi5Tif4hc09LAUURMkQDF8CHmmc/1x6YynX/sDZjJZNYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819307; c=relaxed/simple;
	bh=Sey2FwuqS83CGVYRMIQ83C7Iy3pco/IgbX55pT70R24=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JS0qqoYG1UjIawPJOQtwVgtP8Qqedg/6yz7/inBydyHezfRWr1gUCWOkp2+Z6dnRSc3F+pnEgbfhCrxJpskAaplRaOWp/l69cOldBvH7z2R51x3RPUjNNPO4z96bjJfqrazgk00df3MN0rQ61qfOJ056C405A247Mc0LIYAT+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RKwizwo6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819303;
	bh=Sey2FwuqS83CGVYRMIQ83C7Iy3pco/IgbX55pT70R24=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=RKwizwo6UtMLl0xa7ufRLRuOg5pKrVA6bv4wqSTAquy+BoYe3X9bH0uisFRIhxYQl
	 Mc1hinJArarNrb46J9TEX+KCqazkhlEP8MqUFCKLsucprhZCpaAlPEzzYXWISRIecc
	 pUK28TqsVETz7wD0bLuNdXdx6m39WMPECXAKGKq5y6Ok8Flsmkbuk7jHaeO+Qh+YJi
	 H1al+Tq6aHEkAuv2qxmcN330ARI74YTb0DJIe1dZkjA3qkpDTcK0mxWfm5XAX7B01X
	 68ZUYw9DueStYuqTgTSK6ZHhlE4xbcerSvCygF6zq2RZEozWuesX3p72wDghGb4Zx4
	 90I/13hwXWtkA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F404E17E1541;
	Tue, 10 Dec 2024 09:28:22 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Sean Wang <sean.wang@mediatek.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Wojciech Macek <wmacek@chromium.org>
In-Reply-To: <20241129055720.3328681-1-wmacek@chromium.org>
References: <20241129055720.3328681-1-wmacek@chromium.org>
Subject: Re: [PATCH v4 0/2] Add support for Starmie Chromebooks
Message-Id: <173381930291.18469.3166957495661734495.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 09:28:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 29 Nov 2024 05:57:18 +0000, Wojciech Macek wrote:
> Add an entry for the MT8186 based Starmie Chromebooks, also known as the
> ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> a tablet style chromebook.
> 
> Wojciech Macek (2):
>   dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
>   arm64: dts: mediatek: mt8186: Add Starmie device
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
      commit: c31f6c2f25586557bc586a9b3713bd7473e0cac3
[2/2] arm64: dts: mediatek: mt8186: Add Starmie device
      commit: d926d78bc93b1bfe18bc1cf80e66e1a0e38297ce

Cheers,
Angelo



