Return-Path: <linux-kernel+bounces-181893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4D8C82EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9530282E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227D1EB26;
	Fri, 17 May 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="yJbKu2bb"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291F1AAA5;
	Fri, 17 May 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936747; cv=none; b=I5C4OFYxtRjkF8rBb0sSXM9iH1UimlSEXV0c+yuzBApxvB3ng2PC2tl7/b95wh8x24h983keDKW2lolSAsc5ecEUOF6HyyEFgnKcOTVewNht4FyQ1du+uQS13XThgjh8Mtri3i8MnvF32TfUPbGP9Nw/JokcIq76ni42RJssS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936747; c=relaxed/simple;
	bh=Cg9MTPT9tWRh/8PAEQ/0bLqgcKcVgIar/eyWrNXcBzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pEchBRsDV5kjm1sEYVtRIkgErr1ZNkPQP88S8hnVLaX6oMEyCWYSSqEOJOOsS5z2QJF8kp6oQkjCqxJk7dLuvRNy/k6Vq1C/agrP/6q0vyUgWskdAUdnuY+P/f61ec93EMTa0DHoYvsBIskx2ZOyrOGQlj8qV3j/cGs3/gIplUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=yJbKu2bb; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BE8889C585F;
	Fri, 17 May 2024 05:05:36 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id OzTJfta_rJ3O; Fri, 17 May 2024 05:05:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 157C59C591E;
	Fri, 17 May 2024 05:05:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 157C59C591E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1715936736; bh=eDu4DXcZYZmRMzTsE23CtiqrrOlfxWxDABDYJj8qWVA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=yJbKu2bbAaZIR1lR4fB9rs8ae78l/ej/Pp4GgndaChfrPjM47VvPNd7mTV47IFukQ
	 X//+44ZJ4DRw9DkSHZQf+v4uy4/XKYtuUAaLvLFOebJCl7icu265xkvxy38LLcQmS7
	 Uyg52oLkXf5YOc/GhiY3eH6K1tqG//Rc45iBqqEkBeuftfDcDzCCis0t5jONcc0Oyu
	 HuRL8xxkCfNNH2TA3XiBbsjIWxvlyZmJi19c0PW2BlDRhMuiH8f3EfoiH8ednXXhWm
	 KV3s2SR/VuND91x4ULBGel4DWWFLJ+utgH1gix+qQFlQ/twAETDwd9o1xrq4N0stDE
	 CWzLmI6/TPfag==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8CeRVN1p2hdp; Fri, 17 May 2024 05:05:35 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B02AA9C585F;
	Fri, 17 May 2024 05:05:35 -0400 (EDT)
Date: Fri, 17 May 2024 05:05:35 -0400 (EDT)
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
Message-ID: <822567441.349330.1715936735603.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com> <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk>
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
Thread-Index: iBqosQBSuRfSSp+1CUZcAzEUlctHMQ==

From: "Mark Brown" <broonie@kernel.org>
Sent: Thursday, 16 May, 2024 14:13:19
> On Wed, May 15, 2024 at 03:54:09PM +0200, Elinor Montmasson wrote:
> 
>> Add an optional DT clock "cpu_sysclk" to get the CPU DAI system-clock
>> frequency when using the generic codec.
>> It is set for both Tx and Rx.
>> The way the frequency value is used is up to the CPU DAI driver
>> implementation.
> 
>> +		struct clk *cpu_sysclk = clk_get(&pdev->dev, "cpu_sysclk");
>> +		if (!IS_ERR(cpu_sysclk)) {
>> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(cpu_sysclk);
>> +			priv->cpu_priv.sysclk_freq[RX] = priv->cpu_priv.sysclk_freq[TX];
>> +			clk_put(cpu_sysclk);
>> +		}
> 
> I don't really understand the goal here - this is just reading whatever
> frequency happens to be set in the hardware when the driver starts up
> which if nothing else seems rather fragile?

The driver allow to set the sysclk frequency
of the CPU DAI through `priv->cpu_priv.sysclk_freq` when calling
`fsl_asoc_card_hw_params()`.
Currently it is hard-coded per use-case in the driver.

My reasoning was that with a generic codec/compatible, there might
be use-cases needing to use this parameter, so I exposed it here via DT.

Is it a bad idea to expose this parameter ? This is not a requirement for the
driver to work, most of the current compatibles do not use this parameter.
It is currently used only for `fsl,imx-audio-cs42888`.
In that case I can remove this commit.

Best regards,
Elinor Montmasson

