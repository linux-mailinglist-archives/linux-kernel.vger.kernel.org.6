Return-Path: <linux-kernel+bounces-421335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65C9D89C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13084280299
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2841B3930;
	Mon, 25 Nov 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="UBjsckh9"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346044C94;
	Mon, 25 Nov 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550113; cv=none; b=eKdcVKAsfJyRk/LHaZDf7KTeLox/8KEUP61m3haM9/0TdNh3iuiGeoszu3tdvaj3PN7BJw/35yDBFlhLLxOXGXwfxrcFoT19wayuI8cowIdcMnmmgHN0ngm1QygxKUhcvB9AhG6umOLVI4yDgpWygOqGCbpijV8wqIccRQSRlgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550113; c=relaxed/simple;
	bh=Nbi7jGHMHqCOiVJdgNk+yM5Aex5D7yPTPOFZz9QtO4Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ezESWFEBRnS9bUAoNQq/hlzsoFDD6TXNSFdt9KowBn/RXrsAIrPis4fJt+2/wriw8/f+OQ/qh0b9yGRnoV/3yEHrmBpmONbkSyyR1aWZElpvq8E9fUb5zVJa2T/S49/Lo+FFnwjPvpyS82baQWHFr/tCyAe6v3FhShZUmpIcxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=UBjsckh9; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id BF2F541A48;
	Mon, 25 Nov 2024 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1732550109; bh=Nbi7jGHMHqCOiVJdgNk+yM5Aex5D7yPTPOFZz9QtO4Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=UBjsckh9mezNpgAv1OBbxdguxzVBpMiV456rgWaUT13XQgWO+iA7HihREOcrTh7Cf
	 9MMScOaAT2AXHeLQdaF+BpipbD6nkUaH7cwmcjECCORCcJBQ+d/g/9+1irOEhFY5Fv
	 gpvDptEQ4r4BhTuWaHZRyt/V9sa/cSnUhu16TzQsLPcpTa3LwOkxb0O5jy6TdZ56q/
	 vukcqHwux/0UYuDXEuRQr/ckvDjB1yI0mwVygvHum2kOYQJvsQdaNhMi5E+VPUej/t
	 6NBI0BP2Nb/Ipwd//qkRFHAv0YZic4IykczXrOODGeKKJHxJFlfd4Gj9FoqNddkXU9
	 Tap+AiIiLaxKg==
Date: Mon, 25 Nov 2024 16:55:04 +0100
From: Hector Martin <marcan@marcan.st>
To: Maxime Ripard <mripard@kernel.org>
CC: Sasha Finkelstein <fnkl.kernel@gmail.com>, neil.armstrong@linaro.org,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
User-Agent: K-9 Mail for Android
In-Reply-To: <20241125-gabby-furry-rooster-cf28a9@houat>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com> <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com> <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org> <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com> <cc71021e-b53d-4eda-bad8-abb4df13575f@marcan.st> <20241125-gabby-furry-rooster-cf28a9@houat>
Message-ID: <891D03B0-1A2C-4C38-85F2-F8CBBAC1A5CC@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 25, 2024 4:28:00 PM GMT+01:00, Maxime Ripard <mripard@kernel=2E=
org> wrote:
>On Mon, Nov 25, 2024 at 11:24:25PM +0900, Hector Martin wrote:
>>=20
>>=20
>> On 2024/11/25 20:24, Sasha Finkelstein wrote:
>> > On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil=2Earmstrong@linaro=
=2Eorg> wrote:
>> >>
>> >> So this controller only supports a single mode ???????
>> >>
>> > Most likely=2E On all devices it is connected to a single built-in di=
splay=2E
>>=20
>> More specifically, the controller obviously supports multiple modes but
>> it is pre-initialized by the bootloader for the single hardwired
>> display's only mode=2E So as far as the driver is concerned, there is a
>> single possible mode, and there's no point in trying to be more generic
>> if there is no hardware that would use that=2E
>
>It's not only about being generic, it's also about fitting nicely in the
>usual abstractions=2E You could also always register a single panel, with
>a single timing set, and the driver would never see anything else=2E And
>still fall within the usual pattern=2E
>
>> In general, it is not possible/practical to be generic for reverse
>> engineered hardware with no specs documenting how to drive it
>> generically=2E You just can't know how to implement the options that ar=
e
>> never used in practice=2E I spent a lot of time on exceptions to this
>> rule for the GPIO and SPI controllers, and that's not going to happen
>> for more complex hardware like MIPI DSI=2E
>
>How is GPIO or SPI even remotely related to that discussion? We are
>different maintainers, with different concerns, and different things to
>care about=2E
>
>Also, "My way or the highway" is never a great discussion opener=2E

This was not an attempt to push back on the review feedback at all=2E I wa=
s just trying to add context about *why* the controller will never be used =
with nor support more than a single mode, not argue about how that should b=
e implemented=2E Sorry if it came across as otherwise=2E

GPIO and SPI are relevant not because of anything related to the kernel, b=
ut because I was able to reverse engineer the generic features of those con=
trollers quite comprehensively by literally probing a GPIO routed to an ext=
ernal USB-C port with a custom test bench and an oscilloscope (for GPIO) an=
d by using the GPIO registers along with a bespoke bare-metal test platform=
 as a "software" logic analyzer to inspect the signals generated as I twidd=
led register bits (for SPI)=2E I'd love to have all hardware comprehensivel=
y documented like that (I did GPIO and SPI because I wanted to, not because=
 any maintainer asked for it), but as you might imagine, this kind of deep =
hardware RE doesn't scale and isn't practical for anything more complex, an=
d I was just trying to convey that fact=2E

(Sending from mobile, apologies for the likely dodgy line wrap)


-- Hector

