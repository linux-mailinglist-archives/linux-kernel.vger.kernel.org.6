Return-Path: <linux-kernel+bounces-528481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E6A41819
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14937A3363
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC595244196;
	Mon, 24 Feb 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Lyo6wIGS"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031D1C8605;
	Mon, 24 Feb 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387948; cv=none; b=Iim4aP+b6brVPcyDoUB8yJnKfb6uwm9LgaYRmK3Yog+NeQyIlqJTwoQ/9uHpGaRXFi++4boz8nS6RQas1ekQ5O+7gK4CqbRSBciXzdJzzVuqNTc3MAyQ1DnW74DJ2nZYBje+BExRvIYMW9XsBC9BbVzE3X2+GyvD2KGPdZrOA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387948; c=relaxed/simple;
	bh=G2T+5jx2T46OXT+t+hE9ysgeOpZNVNsNKxFpRbqXoa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJdQg41bA849AL6/oRitfUYGW4sQsUS9Ee3CcwqpJh+T+BJgP2kXcxLlf0mHA/U4/8/a2TDJceabG4AziGkA7tg5k1Okrd9Nnwm3zgruguUoZeFvblgUjL3fTs2V57oKlkrDncPQr06QWDyp9CjE+bPTFH9aCg7gZCeXCNq2KLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Lyo6wIGS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rkbvCWKWFbcG3pKLozXS5DJoywVzuOsRiaQ4nyhFRLo=; b=Lyo6wIGSbY/t2pPYdG119NxFo9
	jgXiEoRaMKSwyG5QqIKvPl+sbotacyhcv41fpqXMsawCPvSP150BlMPWpy5oQBCAGO6QDPir1LDkk
	MZJ08PqZRVjdYQnLgtL2n6QYLg8yioK0JccWRGSsTcT5qq7gi7LfEIsAaYHBV77iSRzTDJi/vEeFB
	f696Y+rAoZtcPw9yJCUvAUsaNOrJHSoUVsHXMpLhAQ5t+fH5eh8quSB674NDWn7oHKvVtJxDUGEkG
	RC1gyr0f7ATUW6EXlHraLe8vDkkxcOxFb2671ouru+ZhxS2J9d0fDu119nBR2r8TgajBv4fxgi+Kv
	YYNbJXPw==;
Received: from i53875a0d.versanet.de ([83.135.90.13] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tmUP0-0006rE-Mm; Mon, 24 Feb 2025 10:05:26 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add rk3562 cru bindings
Date: Mon, 24 Feb 2025 10:05:25 +0100
Message-ID: <3234236.fEcJ0Lxnt5@diego>
In-Reply-To: <23c84fd5-83f4-46b3-a247-56e4a2c06d1d@rock-chips.com>
References:
 <20241224092310.3814460-1-kever.yang@rock-chips.com>
 <krrqtjllx6akrurefbtuhgxw6bwmkiro5rtvdexoevjyufm2uz@r5biw7kbttyr>
 <23c84fd5-83f4-46b3-a247-56e4a2c06d1d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Montag, 24. Februar 2025, 09:52:12 MEZ schrieb Kever Yang:
> Hi Krzysztof,
> 
> On 2024/12/27 16:25, Krzysztof Kozlowski wrote:
> > On Tue, Dec 24, 2024 at 05:23:08PM +0800, Kever Yang wrote:
> >> Document the device tree bindings of the rockchip rk3562 SoC
> >> clock and reset unit.
> >>
> >> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >> ---
> > A nit, subject: drop second/last, redundant "bindings". The
> > "dt-bindings" prefix is already stating that these are bindings.
> > See also:
> > https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> >
> >
> > s/rk3562/Rocchip RK3562/
> > or whatever your proper name is (and use proper capitalized parts of
> > products)
> Will update.
> >
> >> +properties:
> >> +  compatible:
> >> +    const: rockchip,rk3562-cru
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  "#clock-cells":
> >> +    const: 1
> >> +
> >> +  "#reset-cells":
> >> +    const: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 2
> >
> > Why clocks are not required?
> The cru is the clock-controller, which is always on module in SoC,
> so we don't need to enable "clock" for this clock-controller.

hmm, shouldn't clocks be

  clocks:
    minItems: 1
    maxItems: 2

The CRU _needs_ the xin24m because that is the main oscillator
supplying everything, but _can_ work work without xin32k .

Sidenote: itseems we're doing this wrong on rk3588

Heiko



