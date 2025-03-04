Return-Path: <linux-kernel+bounces-544285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CEA4DFBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DE5189D2A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D311C54AA;
	Tue,  4 Mar 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU8Ayn/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B6201267;
	Tue,  4 Mar 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096252; cv=none; b=Dh8rl2JCog5seH969iAt4ktXnFRw3GhX7b/qvUJdIPEqSPBObuE216Ez+uQ+n1Ri6Rtz1xmD0bvtRt0XFp1yeFndEeZx247GDdswMYM7WSKzknJ4OalLivDmd01/ymZlTaSdcUhNukPFfDq1ZkX8TFfXTuAGOh+fK2BtwfHf1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096252; c=relaxed/simple;
	bh=tOj7AtNPRfQWYBosY3NviNmaypYwZ/wUeMOO2JNyg5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTxw8EuEgy5Bdpf51KykB8pIUvNdKwibQyRX8gG2ZlYHw0J+oPMtDwPnxE7sPvGthCW0W6VyUmmnnCMrdwIGN0/gKqHPXzRXpFAw49UwKaaWgtIHLjmTaaz9S02p6QpgHCF5TpxKGVkRiLQx6l/orpC990i7lY6D/fMrEaXNzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU8Ayn/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF61C4CEE5;
	Tue,  4 Mar 2025 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096252;
	bh=tOj7AtNPRfQWYBosY3NviNmaypYwZ/wUeMOO2JNyg5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fU8Ayn/AKNIlGDHqMSFuAJyIucigEhr73FNjp2lGjmC96/cB6z8BU17dRf1Qn8MLG
	 p5RgVkUge8WNR5eo2jV+2OZFxJpZ6eTADCvl5K3xR6m3PXgWSymazsmkSH4z/Y1zqD
	 ulv8nw36XGkwj9ptRof/bmkNJJEiBVsOXItUrDOCk0egK02VpsoMewq64/rms1BMII
	 UOM5eNG0EYDn662bU/7ZVA13RFg90br60/zw5cr5Ls4taUEyByE4AegS07R/KPZViT
	 w6yG4NEWhgOJlxt0oEiSxDygBNS0/yJ2CfOUAsQ/P9pGsaPTcX/cNKgJDNKrDvwtg0
	 PxZaxEXlK1Gew==
Date: Tue, 4 Mar 2025 07:50:50 -0600
From: Rob Herring <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
Message-ID: <20250304135050.GA2485358-robh@kernel.org>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com>

On Thu, Feb 27, 2025 at 10:07:44PM +1000, James Calligeros wrote:
> TAS2770 can pull down and zero-fill SDOUT when not actively transmitting
> TDM slot data. Zero-fill is useful when there are no other amps on the
> bus. Pulldown is useful when the chip is attached to a shared bus.
> 
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  .../bindings/sound/ti,tas2770.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
> index 8eab98a0f7a25a9c87d2c56fd0635ff8ecee17d0..3eba9bb34a581526f68b6bf2e8437e1f1e03d26f 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
> @@ -57,6 +57,18 @@ properties:
>        - 0 # Rising edge
>        - 1 # Falling edge
>  
> +  ti,sdout-pull-down:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, SDOUT will be pulled low when not
> +      transmitting.
> +
> +  ti,sdout-zero-fill:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, SDOUT will be zero-filled when not
> +      transmitting.

Can't you align this with the other property you added? Or extend the 
existing TDM properties we have.

Rob

