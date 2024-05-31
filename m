Return-Path: <linux-kernel+bounces-196816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B538D6214
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F32BB215B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0AC158849;
	Fri, 31 May 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="oYkuGcIQ"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AC74404;
	Fri, 31 May 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159628; cv=none; b=QB6+xVvONA1VxpYuzEeE7nRDLVsRsPNhUns/tEX606yVhiPmaipmNozlbIe+InvYM8b4DR6OmyQ1ZQYpx4NAGWUf1L2X7FfEAt9NcC8ghtTvhKckl64HVjE+0zHsTQdLfMYv1tLvy2F3TL6U59kX/LcsuUbdipwYF1g8twQ0CH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159628; c=relaxed/simple;
	bh=abiFUaW/IoT5wwmTdvZKLXT6azQhCAp2fplhjmPNpmY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eW1XPJkY5Mrp/3UwO+5sHpIQKa71GNrBrBijrKTL2EP+eFa4Kcn3LocLSiOb4uZeQHOP3OwBCZU6KMKhTWFNhEpKADKp1Viw0oyaxoB1Kn9gOtme9ERQk7HId8tssDp1VN7xCqk0jHMMHYXl/T4BHT0DTEEWrFtMtGs0NO/xbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=oYkuGcIQ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E8E739C096E;
	Fri, 31 May 2024 08:46:56 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id N0Q0BSSbY1Ew; Fri, 31 May 2024 08:46:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1E8009C57BB;
	Fri, 31 May 2024 08:46:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1E8009C57BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717159616; bh=WZsGaXJZZy+fsZIWjtMJ5qii2e1R2StcjqgwWGh4rzM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=oYkuGcIQvuwxk6I666pfXOLWp7nkCgMUkaYIr2KQrs3bgmDsBR79pRVbnu0NEuXK8
	 q1B2ZWcMdTjnepT9d9fsPLgYpVOCHaqsGy83oO81cewL2M1hDBv8Szy8h8yXPcm7YC
	 tBsNPGu3J/wl3rmLcBWP4TTDRJcIzomA8ding+1cAd+wrKQ1eBEEtlt1EeRHwOQLIz
	 sZEKu33lVdIXMbswKBJn+98Sajqt753aE8OXfOeEbtctkIkgY1i19mb+x0kyVAssjK
	 D+vEcjxO1i116xIA3wQZodBgXfjI3joArFzWteHEidTw5afIbLsxqY/5izO0Sv7F56
	 C1tukavT0XWFg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Dx2jCPthSXWX; Fri, 31 May 2024 08:46:55 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D57F99C096E;
	Fri, 31 May 2024 08:46:55 -0400 (EDT)
Date: Fri, 31 May 2024 08:46:55 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1660761484.701255.1717159615755.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <da74d276-b028-448b-bb28-295de49dbcda@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com> <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk> <822567441.349330.1715936735603.JavaMail.zimbra@savoirfairelinux.com> <da74d276-b028-448b-bb28-295de49dbcda@sirena.org.uk>
Subject: Re: [PATCHv4 7/9] ASoC: fsl-asoc-card: add DT clock "cpu_sysclk"
 with generic codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: fsl-asoc-card: add DT clock "cpu_sysclk" with generic codec
Thread-Index: fcftgDhNt5MliZw6sGsrnH7v0rWaiA==

From: "Mark Brown" <broonie@kernel.org>
Sent: Friday, 17 May, 2024 13:17:20
> On Fri, May 17, 2024 at 05:05:35AM -0400, Elinor Montmasson wrote:
>> From: "Mark Brown" <broonie@kernel.org>
>> > On Wed, May 15, 2024 at 03:54:09PM +0200, Elinor Montmasson wrote:
> 
>> >> +		struct clk *cpu_sysclk = clk_get(&pdev->dev, "cpu_sysclk");
>> >> +		if (!IS_ERR(cpu_sysclk)) {
>> >> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(cpu_sysclk);
>> >> +			priv->cpu_priv.sysclk_freq[RX] = priv->cpu_priv.sysclk_freq[TX];
>> >> +			clk_put(cpu_sysclk);
>> >> +		}
> 
>> > I don't really understand the goal here - this is just reading whatever
>> > frequency happens to be set in the hardware when the driver starts up
>> > which if nothing else seems rather fragile?
> 
>> The driver allow to set the sysclk frequency
>> of the CPU DAI through `priv->cpu_priv.sysclk_freq` when calling
>> `fsl_asoc_card_hw_params()`.
>> Currently it is hard-coded per use-case in the driver.
> 
>> My reasoning was that with a generic codec/compatible, there might
>> be use-cases needing to use this parameter, so I exposed it here via DT.
> 
>> Is it a bad idea to expose this parameter ? This is not a requirement for the
>> driver to work, most of the current compatibles do not use this parameter.
>> It is currently used only for `fsl,imx-audio-cs42888`.
>> In that case I can remove this commit.
> 
> I'm having a hard time connecting your reply here with my comment.  This
> isn't as far as I can see allowing the frequency to be explicitly
> configured, it's just using whatever value happens to be programmed in
> the clock when the driver starts.

In v3 I used parameters `cpu-sysclk-freq-rx/tx` to explicitly
set the frequency.
In its review Rob Herring said that the clock bindings should
be used, so that's why I changed it to use this `cpu_sysclk` clock.

