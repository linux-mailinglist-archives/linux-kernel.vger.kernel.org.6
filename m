Return-Path: <linux-kernel+bounces-450014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453C9F594E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D867717250E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F11D90A7;
	Tue, 17 Dec 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EDauNmcP"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981031D45FC;
	Tue, 17 Dec 2024 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472975; cv=none; b=GroCjZQiIrAxP3aAcPQlm0/sKxHdAy9QrqTXTaqRuj8iFpcssEmzkhauQEjbnYrFAMQGPBCRpzWWHtGyKEfWJKqhZVDhVj8ogs7eN7QBHHkbASkl0Ktj9H4Wc+KC2xF1gmKdjUVOF57LJvA45P1WkH6YzctsdciH8eflW8iNbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472975; c=relaxed/simple;
	bh=bG8GzNyU8OV2tRULvMNKD/TFcT+BhQkIg7OBoanqriw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EsQ/OcUxkw11PmuyJG0HcZWPfjBohf4wIMXcAycNaFfCSO3+3tXa2rNhGpeQuXyokMJkbENUudxxspx4AtX+vb+sOam1gJAxgAlfgbDVYNXhvRne4kzWJzRI3X6WomqcIqMVMSI9zwJv/o8JVurkfKXM9H/ImeZD9WzW23CgD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EDauNmcP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1734472965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3T0I8Im+xs38OE09Iv+okJqntT08tdxR/DACobP2E3c=;
	b=EDauNmcPkUwwP8lSPH+M30N+OnKv8Q1PSFsSnr+QaUKHSmPphOQzEhH3iTcqTw97igd+0M
	yOThkqJBcPPHlNNOrXOguFiij6PHVVqEUSJ6lpyffeCWgwAOtMSXloLfJYn6NGZ2ewojs4
	YQ9x/hzasx92SPbXhf/2+LvHWRq5GgIv9zh/HMSSlZtVvi6OMYXv5mZY98tdunT1I1TfDM
	N+7IRG9LAUQtXFDdbHfjlOPGXOArB1P+uDOAczKm7qWXI+7Vw8yyg6/Zs6vz6eQtfnA0yG
	wC28LJOoOZLiBpcJFz0fQ/d0YaLpg32/qv2hRv5R7A+eCCkBKNq6tC0lCvVSlw==
Date: Tue, 17 Dec 2024 23:02:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, Roman Beranek
 <me@crly.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and
 PLL_MIPI
In-Reply-To: <20241217211505.7f9c9e4e@minigeek.lan>
References: <20241215053639.738890-1-anarsoul@gmail.com>
 <20241215053639.738890-2-anarsoul@gmail.com>
 <qbtp4jvkx3r5azufe4k3vtapqpfs54dyjiu4cy5v5wkkzumrzx@vy3xzkfplbue>
 <CA+E=qVeQ8uHBCeFtw6_2cY3252-YXc6eWrf5_YdeVgbp5LJo5g@mail.gmail.com>
 <20241217211505.7f9c9e4e@minigeek.lan>
Message-ID: <d0bf0d9cd2df65dc2e17eb203d56eb13@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-12-17 22:15, Andre Przywara wrote:
> On Tue, 17 Dec 2024 10:00:45 -0800
> Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> On Mon, Dec 16, 2024 at 11:33 PM Krzysztof Kozlowski <krzk@kernel.org> 
>> wrote:
>> >
>> > On Sat, Dec 14, 2024 at 09:34:57PM -0800, Vasily Khoruzhick wrote:
>> > > These will be used to explicitly select TCON0 clock parent in dts
>> > >
>> > > Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
>> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> > > ---
>> > >  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
>> > >  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 +
>> 
>> > You cannot combine these changes.
>> 
>> The patch basically moves defines out from ccu-sun50i-a64.h to
>> sun50i-a64-ccu.h. How do I split the change without introducing
>> compilation failure?
> 
> You can just have the binding part first, adding the (same) definition
> to the binding headers. As long as the #define's are not conflicting,
> this is fine.
> Then remove the now redundant definitions in the kernel headers, with a
> subsequent patch.

Yes, that would be a way to make it formally correct, but also much
less readable and understandable later, as part of the source code
repository.  FWIW, I find this to be an example of the form being
more important than the actual function.

>> > Please run scripts/checkpatch.pl and fix reported warnings. Then please
>> > run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
>> > Some warnings can be ignored, especially from --strict run, but the code
>> > here looks like it needs a fix. Feel free to get in touch if the warning
>> > is not clear.
>> 
>> Yeah, it is not clear what do you want me to do, assuming the previous
>> similar change to sun50i-a64-ccu.h did essentially the same, see
>> 71b597ef5d46a326fb0d5cbfc1c6ff1d73cdc7f9

