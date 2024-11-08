Return-Path: <linux-kernel+bounces-402261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454E9C2590
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9B91F239FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189B1C1F1D;
	Fri,  8 Nov 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UfmSEFF5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909251AA1C1;
	Fri,  8 Nov 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094163; cv=none; b=Ertx6IGQO5kdLxPtnCCOFP4VHenJUXLUZznVTaNAcm+r6B9Fb9mdPFuX1ndKqv8uPSmYTDSQedJ9KJ+FU0b18h+8pJTpjZtCQyZPElEf3TSWU0GbpVQnGVY2rChkxtDvMoJg37CXatQF6qd8nRdHBcktu6S6zkLyW6VWxonu888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094163; c=relaxed/simple;
	bh=XyZ4ZGRN+Py46R/0cjYeN0vqeqyTjSVAKF/G+KnROCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FU8Ojd5mV0+2MGdIgKA/956hYrOg44gbMU9ZRzN6y4nXdE7wusOjkV7470sih0j7IdN2u8xq0RiK/7vH/wjX9cocPDhVqS6e3tWymTvMwDaJANRLXIYv8A+EO9yYkoIPdipcTVL0LcggNJf5rlpnHFaE3tNeF6PMwL+Y/wbgn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UfmSEFF5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0F63C42C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731094155; bh=P0P5GPcQkcecjTf1uOnWpmVXIS/NJ6iYMMu4Zo1O3yY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UfmSEFF5VGnFVadDgo9jI0cdfetpsZtxdYhv8gTFXD02CwG2yC7npdXZHEFuKGQsb
	 NuUE9FgL7h8VTbNvo9S4Q/lgxpWIUkcdcw3f7D7HdFR5IhL9ovsB9+rGYOoNhJXv01
	 eT2srmyU+jX+X4PwHSnF4kvk/isjKgIkiMaO3epzphcGongE3vru305qHZ5zosyzcd
	 BR5bKjki+csMGoeKmZFLIBHxysZIRWSRtizTdsngaqAbAIH0jEG12oYlbK7EQqkKKh
	 /4KQ1PkmlXr//Mc2YiEk2hvwhAKREGQ2BR7eJhcoExdtI9EKAZYhpuZ25GVI2ErA0O
	 iHzKdPjwUaCSg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0F63C42C17;
	Fri,  8 Nov 2024 19:29:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH V2] ALSA: machine: update documentation
In-Reply-To: <20241108192413.10751-1-yesanishhere@gmail.com>
References: <20241108192413.10751-1-yesanishhere@gmail.com>
Date: Fri, 08 Nov 2024 12:29:14 -0700
Message-ID: <87y11twmlx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

anish kumar <yesanishhere@gmail.com> writes:

> 1. Added clocking details.
> 2. Updated ways to register the dai's
> 3. Bit more detail about card registration details.
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
> V2:
>   took care of comments from bagas related to underline
>   and making macro as literal code block
>
>  Documentation/sound/soc/machine.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/so=
c/machine.rst
> index 515c9444deaf..9c8e006b1e50 100644
> --- a/Documentation/sound/soc/machine.rst
> +++ b/Documentation/sound/soc/machine.rst
> @@ -71,6 +71,18 @@ struct snd_soc_dai_link is used to set up each DAI in =
your machine. e.g.
>  	.ops =3D &corgi_ops,
>    };
>=20=20
> +In the above struct, dai=E2=80=99s are registered using names but you ca=
n pass
> +either dai name or device tree node but not both. Also, names used here
> +for cpu/codec/platform dais should be globally unique.
> +
> +Additionaly below example macro can be used to register cpu, codec and
> +platform dai::
> +
> +SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
> +	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
> +

This will not give you the literal block you were hoping for.  Please
actually build the docs after making changes and look at the results.

Thanks,

jon

