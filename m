Return-Path: <linux-kernel+bounces-212322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3FC905E78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F101A1C226C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB312C53B;
	Wed, 12 Jun 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=the-space.agency header.i=@the-space.agency header.b="X9IpTEM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJyenuAF"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4612C486;
	Wed, 12 Jun 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231117; cv=none; b=atPbEX44ulaUMIUkhgEgb1iKT/ugQvK/xd4q2nGK9N7s6TSNf3uYpNCE+P5Sa+wLx5STpKX8hJERYu0fcy07wW5jm+BnXfmjhQekx6Zq8DHxHcpfWZE+bzUdH7HQ2Z/9MaIX1Ik/tIYwNbemCsrv2cstmbTRjis6a+dWlwgZuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231117; c=relaxed/simple;
	bh=dZdcb35V5sFDGJXrUKYquPsxoYaWO6Wc6vlqHshC2OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR8KmKr4lVSnvBhEeg2409SbLzH2BqUSbg+NHKU1actvPifs9vOYn6E5r7YvNFOjSrHjy3u8jcBQe0Tgm9PK5ywScWIysPZVP1elD8iISbGGfhsWVn8LruPHZk0d+sFngdf5A3w9Bj2muqFxaA2xAi9vo8V+FZyepOSkktr3Xwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-space.agency; spf=pass smtp.mailfrom=the-space.agency; dkim=pass (2048-bit key) header.d=the-space.agency header.i=@the-space.agency header.b=X9IpTEM2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJyenuAF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-space.agency
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-space.agency
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id AD5C61380171;
	Wed, 12 Jun 2024 18:25:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Jun 2024 18:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	the-space.agency; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1718231114; x=1718317514; bh=O6LgGsmjjGx/r/VemAsov
	TvYFktWVkA0a+80L+R5FD4=; b=X9IpTEM2bLNYi5NEtZUPnnBXDdYIIo9sOKdTn
	xQDkM263Otof1FCyTwGsl7ZrrEhKAuKQllOq8ktSWNxeCAIglf1lJ+VZywWIBndD
	rBPSQz8MuBEQ9I66hvZPkFT+eXV6MSr1ajF2w4gyhOVjMZX326itYK/uOyYW+wrG
	nRKsa8EuLD30WzlQiAbxXneE3KEOssIKi0CbWR+E686bqNlMRo3LpxQS90k3kWPR
	STF0DwnH2DaGJA6E1+AkbW1YOMypza0bN6704qsUGnMTPFhGjLi3rZXLZeppmzss
	MK18gKV7oGKeV+MKpyz8/ON+vLN8cGe6rzSYlAj3YEI2XIXLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718231114; x=
	1718317514; bh=O6LgGsmjjGx/r/VemAsovTvYFktWVkA0a+80L+R5FD4=; b=c
	JyenuAFf55VnDFGZycNxFnTjqIfRw94YTCnhMHqmbGi5G/tQG7dhxPL/OBM0Y+nG
	tMVFLCzpQtfua+erSBPUKxAPmaxtNAuIlujciEdEJdsfGG/+i8yrUK0jtQquGSMS
	cT4InZ79cMRSma4TfUjFuoFr0S+jPYR1HSljJ3tCjdfgyTT5OgSd87oT+a/x7sON
	6vURfnwduW8+uhSLoK17OCu99RM/dF3zKW4e1VURUq8Kp60bWBTdGYhk8ldngt7G
	o/87/YwuS7v8CWkpUKCWqH2gM1y5Vgph/XQgYq1D0pjfUXFIrQtak89y7sNjLPhv
	73OQKPgC22rSN8QiayhFA==
X-ME-Sender: <xms:SSBqZoVb6T4f_cIlE6WIWFAD9DZXTRBL9PbjAuwD9taAyMYc3CyXrw>
    <xme:SSBqZsmRJ26oZwSRM3NRm8j_hUeZU5X7XN47A74koRNu_s3SXis_cjYFyLz5PVPnn
    yBGuV9NsL60UeJZPA>
X-ME-Received: <xmr:SSBqZsYAgB7iy_Dj-LKi4Co44dc3fDALBg575vjVQpmLm16mbreeHaNfD5U8nrXqYhufbQ7Qra0BPenA86kfLpMVryH4_FR2h9yM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduhedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpehmvges
    thhhvgdqshhprggtvgdrrghgvghntgihnecuggftrfgrthhtvghrnhepgeegkeelvdeive
    duiefgffevveekueeigedtheekkeefudeugfduteetveekiedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehthhgvqdhsphgrtggvrd
    grghgvnhgthi
X-ME-Proxy: <xmx:SiBqZnWknayaUw9jc5_dLO5iESc6ZRw0EWA6bXuEnM8cyYm2qJQhDA>
    <xmx:SiBqZino_25NbisCcnLfYSgy4jg0Qa9tfZcPS7DlqJE1iCvEIKmFqw>
    <xmx:SiBqZsdLPUKikYMiWETnX71LR1x2D_H9tUFJEDIILF2IRnSWRYFdOA>
    <xmx:SiBqZkGfPybnT3BI08kwLshnVgfgj_ToslGvEYGka9n5RIwR05UnoA>
    <xmx:SiBqZkfe6YCDVtu78vURrb7Jhfo-lE8-OzwcZQ_Q_EfqargZ7D0ydp3j>
Feedback-ID: i2f914587:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 18:25:12 -0400 (EDT)
Message-ID: <57506a95-4667-495d-80c5-d9fa0f6be215@the-space.agency>
Date: Thu, 13 Jun 2024 00:25:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS
 board
To: Sebastian Kropatsch <seb-dev@mail.de>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240609222428.134977-1-seb-dev@mail.de>
 <20240609222428.134977-3-seb-dev@mail.de>
Content-Language: en-US
From: me@the-space.agency
In-Reply-To: <20240609222428.134977-3-seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.2024 00:20, Sebastian Kropatsch wrote:
> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
> To reflect the hardware setup, add device tree sources for the SoM and
> the NAS daughter board as separate files.
> 
> Hardware features:
>      - Rockchip RK3588 SoC
>      - 4GB/8GB/16GB LPDDR4x RAM
>      - 64GB eMMC
>      - MicroSD card slot
>      - 1x RTL8125B 2.5G Ethernet
>      - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
>      - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
>      - 1x USB 3.0 Type-C with DP AltMode support
>      - 2x HDMI 2.1 out, 1x HDMI in
>      - MIPI-CSI Connector, MIPI-DSI Connector
>      - 40-pin GPIO header
>      - 4 buttons: power, reset, recovery, MASK, user button
>      - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>      - 5V Fan connector, PWM buzzer, IR receiver, RTC battery connector
> 
> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x1
> speed. Data lane mapping in the DT is done like described in commit
> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
> 
> This device tree includes support for eMMC, SD card, ethernet, all USB2
> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging as
> well as the buttons and LEDs.
> The GPIOs are labeled according to the schematics.
> 
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../rk3588-friendlyelec-cm3588-nas.dts        | 759 ++++++++++++++++++
>   .../rockchip/rk3588-friendlyelec-cm3588.dtsi  | 655 +++++++++++++++
>   3 files changed, 1415 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi


Reviewed-by: Space Meyer <git@the-space.agency>

Confirmed v3 fixed the usb-c port. I only tested with a single USB 2 
device, as I'm not home at the moment and don't have many options to 
test things here.

Cheers,
Space

