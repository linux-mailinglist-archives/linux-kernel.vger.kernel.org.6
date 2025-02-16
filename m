Return-Path: <linux-kernel+bounces-516852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FDFA3783E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960CE1891230
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54B189F39;
	Sun, 16 Feb 2025 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="CUE+6UHG"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79892C2EF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739746876; cv=none; b=Gp5cw2U834JEQe11pI53PINyWCqoO6KULcdb4j7iVxRcW4n2aGZ2DM9rcatHTsJq2hPCLyqbacpvi4PddBu8EsG/VdekygDIHxRbiR/4Eh5I98rGzDW1X4ATGJZcQ/XVKFlZ4ASCjCDFh5AOqAH0LLfvk9FkAZEzGXPq1WtuMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739746876; c=relaxed/simple;
	bh=/QPxp9iW5sVKgrwmAN+kKd17iJ7dX0TGVJ6fRmukTfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgJPWt+YMzXUrp/jmS3BIjcfI0iH7sUqii2h1GOK6bb9sT33j8y16emaO9S2UttNZJfcqGG+XBUm4p+H+qLX4HRGJ5OEAFjvsfCgKeFnef0++jDDsya4LBR04jca/fMXAeO0AMdQRha52m3A3Zpe+niPmANeLXM/2HI55dQ94ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=CUE+6UHG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 16 Feb 2025 18:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739746872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQf+77h2a5SzWLmKNfSzhlh5D3kXN0JjyYVL7ts12+s=;
	b=CUE+6UHGOEU0U97gKHiN7D6HkFuvGjNG9gJuRfKHIYyx4jd3+csmxaKEvaV9ekzXBQiFZ5
	HRYZEE6WwmgeBtVfEzm7vIHOMDVEogtyhAh8z1oFai1L17YnbzyH0ItkXVMbBBYlih9dv0
	i60rdcz80DuTujwuMccKSLcxO3NFDjoykMoaEsT8N4qT6EROnc9/3KR4jsTHcQzUTD3Lzm
	erHQsw2iUMsb/msu1xOBtJBqxfd9F5BXn3qPLFzZGUbDX690Nv1BT4nlxn1XZeDjpMF9YJ
	Claacl9wWGPJJcchSOqmq4dHZlJQv4XD0z7c/617bIN4tyZkn4xW8HVsyCcvlQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH 09/27] ASoC: tas2764: Apply Apple quirks
Message-ID: <Z7JuMq2_cUNajFe8@blossom>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-9-723569b21b19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215-apple-codec-changes-v1-9-723569b21b19@gmail.com>
X-Migadu-Flow: FLOW_OUT

> +#define TRANSITION(new, old) ((new) << 8 | (old))
> +	switch (TRANSITION(target, curr)) {
> +	case TRANSITION(TAS2764_PWR_CTRL_SHUTDOWN, TAS2764_PWR_CTRL_MUTE):
> +	case TRANSITION(TAS2764_PWR_CTRL_SHUTDOWN, TAS2764_PWR_CTRL_ACTIVE):
> +		ret = regmap_multi_reg_write(tas2764->regmap, tas2764_pre_shutdown_seq,
> +					     ARRAY_SIZE(tas2764_pre_shutdown_seq));
> +		if (ret < 0)
> +			break;
> +
> +		ret = snd_soc_component_update_bits(tas2764->component,
> +						    TAS2764_PWR_CTRL,
> +						    TAS2764_PWR_CTRL_MASK,
> +						    TAS2764_PWR_CTRL_SHUTDOWN);
> +		if (ret > 0)
> +			break;
> +
> +		ret = regmap_multi_reg_write(tas2764->regmap, tas2764_post_shutdown_seq,
> +					     ARRAY_SIZE(tas2764_post_shutdown_seq));
> +		fallthrough;
> +	default:
> +		ret = snd_soc_component_update_bits(tas2764->component, TAS2764_PWR_CTRL,
> +						    TAS2764_PWR_CTRL_MASK, target);
> +	}
> +#undef TRANSITION

Not a fan of this one-off macro, any reason not to do the obvious
if-else instead?

