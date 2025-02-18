Return-Path: <linux-kernel+bounces-518856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98925A39543
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307AD7A05A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79869211499;
	Tue, 18 Feb 2025 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3r4LZVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0221A841B;
	Tue, 18 Feb 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867150; cv=none; b=IAkuEcpiAFAYhzb2LcNfGL+YCvbTedjcocrxGrZDPIKVk3TDLsX7wdKMtbC+C27qkDTGjTIJaIMSebqXyKH+0oz27bVxHgxAWmHqhlVY8NumCMvQiViVVYPQAp/GE7HVrE2tDuXUg+snsVe4k7GLRfD2EvRfpQo4IvcqN2M3M4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867150; c=relaxed/simple;
	bh=EvID7D86PKXTeqELs9veszakyXMUP1t20zGjfOD7Rt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1l1FDXY72pPhwogVPO8gG67DNI4NezrgPDvGteJVIGnw3dJZI/vxPJ7rHP96ux4VCqtmlaJ2i4E0g2iqU8SFhrmLAmXpToGXhEXnNb+OEPCCcvhFJbx7+mWbYuyaV7FgPxzzPCTg0Uut0Eiv2koMiwp4nTKAtNfRaqpJpFBpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3r4LZVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A8C4CEE2;
	Tue, 18 Feb 2025 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739867150;
	bh=EvID7D86PKXTeqELs9veszakyXMUP1t20zGjfOD7Rt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3r4LZVwnWLy/POh9hH3tZRQxKLNC1XClRyAHPbp2o1mm4xMHA4MRjgdRBRszn8tX
	 y7VJKFLeiz+p+r2UUM82Nptn726NNgkG/JuPjxcYYDTQIRneYDE/hKbRtXngp00Fph
	 g68+Z3QiTUgGQfW6oOOEGwZmsYRwJLkvJ8xXh0IItNPlFBaBjArVl8TDhPv76WXnuD
	 xxv2EdFS64ShgdI6qiezKwfEqLbBNmWw98LM9ys50zz9t3GqWgDmXWlOIV4jB5WlkT
	 GASt9J1eAtYDKfm+/6e9gfIP5l47Q3ERmlNZx4TuosVJPnKlT/9byu1o0WovsunJJK
	 ExYJsVmS1wKEQ==
Date: Tue, 18 Feb 2025 09:25:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, jian.xu@amlogic.com, 
	shuai.li@amlogic.com, zhe.wang@amlogic.com
Subject: Re: [PATCH v2 2/5] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Message-ID: <20250218-opalescent-teal-of-patience-82cecb@krzk-bin>
References: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
 <20250214-audio_drvier-v2-2-37881fa37c9e@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214-audio_drvier-v2-2-37881fa37c9e@amlogic.com>

On Fri, Feb 14, 2025 at 10:13:41AM +0800, jiebing chen wrote:
> add the s4 tocodec compatible

1. Please write full sentences.
2. We see that from the diff. Say something about hardware instead.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
> index 23f82bb89750898d20c866015bc2e1a4b0554846..ea669f4359bc81b0f45bc2105c832fc2b11d8441 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - amlogic,sm1-toacodec
> +              - amlogic,s4-toacodec

Keep alphabetical order.

Best regards,
Krzysztof


