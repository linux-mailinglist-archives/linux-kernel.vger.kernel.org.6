Return-Path: <linux-kernel+bounces-448733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452049F44CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303DE1618AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36316EB7C;
	Tue, 17 Dec 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhEJSAO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73FA653;
	Tue, 17 Dec 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419262; cv=none; b=mcprLTk+BAKUZQXgguxRHRlapgoKMuEvLK+HkWSf2nj/XIITTaYC4HfzHMMjvWUzKfvsEQYxlrCBLtZTi3Xjpx/BqtLKrmGoY0epXAUp/fAMtC6LbdstFnJtVyTOvWM4xIWt4V3bQFwz18H/rBXtzq9zYlXcrVNG4ursyyVoaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419262; c=relaxed/simple;
	bh=5pNv1T3alykB+CBmVUBDGGead9uQSVHWIwqxJDAEdLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H74p138l5uYL442K6g0L43ayHVFjKKgiWn1tnLLsxCGBGZU6UREWB0RyVQu5arftGp4RKvYnN1uinP6gg9PL1jABMS8+zci8ZitAnbacbcZ/BHHlj4B4Whc9B1NCNRgAP5P6OizGMjtHptF4EuOpawnrxrpgPLx7teYfgMu+P04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhEJSAO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A640C4CED3;
	Tue, 17 Dec 2024 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734419262;
	bh=5pNv1T3alykB+CBmVUBDGGead9uQSVHWIwqxJDAEdLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhEJSAO0xDkczEnGSQrwYr7gbOUFKz1QFvbhU76Go4rxPIe041b/qSWNgT1X9JSqO
	 PM8N+tB3axhHT9yiVuY5pMhI5cPypp1z+8ttpGvyJt/rczfRQdNo+zA50tGMUZ0X+6
	 0mN/HCFStdqOYetFZzIHcrX4X024iwAOp/zEra9xq6Ll+zjVqnEWz/8HqNv3yIzrfW
	 bTYQVdEt23cxKHM+YYw/VpQv0Wld8VsgtYzYrqAP8ZZJFPm32yJA7ZOcysL7Cc/JPZ
	 K+pWKdUbbIxRE3YeXwWqr9DAEfBW0S+d6UPGbvW10OfxN98r9BWQds/1uLnav6XRCD
	 As3upYwGDgnjA==
Date: Tue, 17 Dec 2024 08:07:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Jaroslav Kysela <perex@perex.cz>, Frank Li <Frank.li@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: audio-graph-card2: add widgets
 and hp-det-gpios support
Message-ID: <nxcoukgiwtcsowi2uxytxa32mdp5dhl4tvnetpd2spti7oiiu3@mpqbv43ivznc>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
 <20241216145039.3074-4-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216145039.3074-4-laurentiumihalcea111@gmail.com>

On Mon, Dec 16, 2024 at 09:50:37AM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Introduce the 'widgets' property, allowing the creation of widgets from
> 4 template widgets: Microphone, Line, Headphone, and Speaker. Also
> introduce the 'hp-det-gpios' property, which allows using headphone
> detection using the specified GPIO.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/sound/audio-graph-card2.yaml          | 4 ++++

I have impression you are duplicating audio graph properties instead of
referencing proper schema, but considering that the bindings
audio-graph-card and audio-graph-card2 differ only by number "2" without
any description, not sure what is correct here.

Best regards,
Krzysztof


