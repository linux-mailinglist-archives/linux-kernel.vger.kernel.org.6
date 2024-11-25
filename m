Return-Path: <linux-kernel+bounces-420807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498C9D8332
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047F816213E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE31922E7;
	Mon, 25 Nov 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecXyt2kI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890A156962;
	Mon, 25 Nov 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529608; cv=none; b=i4MXb17wRlJKTNfoK0iIQqOB0Dl5ItiAmgz5/CfYvzRpMy+ZQHxHFjeCJ392oqdE8ukYB2t/AXE5ZnN3wfLCWBizmtFXxmSHiQXJDE1dN6f/6rO+Ae0pDbjQI79Hx25eXDbkfdUUR6nf3aYkYb7O9ZHmvwIXLejj8i7mCl94Tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529608; c=relaxed/simple;
	bh=hUO3cLlT3vdLxWhuhdutCmu0MQDfhoRgoCbEY54Csm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpTHXvJkxEv8gCkxqdLEMyDdwOYOBbWhUqM/+ZxtSwvOTAUuyQgDiCfBqwYFVYfKlyTPzhPj7Ngev6NeO8ZLqKgn1+wl7AwnG8YOcQ8VO1dpqO9Q8HtV9lSGipcx0p4HYzyMFOy64f8pTieV0UxNjVZFYCQKVpyR4JhgdG4RJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecXyt2kI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0524C4CECE;
	Mon, 25 Nov 2024 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732529608;
	bh=hUO3cLlT3vdLxWhuhdutCmu0MQDfhoRgoCbEY54Csm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecXyt2kIURgzHaGqA6Om1ND2ZukCSUbhfaBgrTVsLdakQL+39aWUtBY8cVoSZlqdT
	 dRUwWGz50dH5iV7nF6vRMvqpQpO6xflP3jTA2CWkLuo0/tSXMMPT9IZk533d3ETFFZ
	 PUrlqfbTHHr6GC/Q7Nh/2CsDVLIG2Y9KTCtiw2GQvO1agESZR/y+t5VRVptpwuv4r6
	 KCzDOe8VEYuNOTyeoKKxYb/vgGlz1h66d2Z4vRgBj17djGa0JjdWrWo7OwLQu3ud03
	 SJMORycZfj959fobpZojpgvxp5bui2gfQ8cguN6GQ/nt9w6oroCQLb1zr3MpNrU5bt
	 TD5FIj632msXg==
Date: Mon, 25 Nov 2024 11:13:25 +0100
From: Maxime Ripard <mripard@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Message-ID: <20241125-spirited-industrious-roadrunner-e8154d@houat>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
 <20241122-cobra-of-authentic-discourse-e2c5b6@houat>
 <03b5a671-e0c0-4d18-a103-e7f0ab18e20e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="h3ivafm5bqasam2u"
Content-Disposition: inline
In-Reply-To: <03b5a671-e0c0-4d18-a103-e7f0ab18e20e@collabora.com>


--h3ivafm5bqasam2u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
MIME-Version: 1.0

On Mon, Nov 25, 2024 at 10:40:22AM +0100, AngeloGioacchino Del Regno wrote:
> Il 22/11/24 10:20, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Wed, Nov 20, 2024 at 01:45:12PM +0100, AngeloGioacchino Del Regno wr=
ote:
> > > Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
> > > found in MediaTek's MT8195, MT8188 SoC and their variants, and
> > > including support for display modes up to 4k60 and for HDMI
> > > Audio, as per the HDMI 2.0 spec.
> > >=20
> > > HDCP and CEC functionalities are also supported by this hardware,
> > > but are not included in this commit.
> > >=20
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> >=20
> > Just a heads-up, you should really be using the new HDMI helpers, it'll
> > remove a lot of boilerplate and potential bugs.
>
> Hmm... the state helper you mean? Or the inflight series from Dmitry?

Ideally both, but targetting only the former would be great already :)

> In any case... yeah, you're right, let me check which helpers I can
> use: that's going to be done for v2 :-)

I think the scrambler support would be great to add there, there's a lot
of bugs in most drivers. If you feel like it :)

Maxime

--h3ivafm5bqasam2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0RNvwAKCRAnX84Zoj2+
du1BAYCjKyk+nF1tolybBaGVQDKxzLMP0aXHCAkIJNAu09aAHat9Y0MhN/kPIBXf
tfkB+7MBfjQt2wnl1ouI79g9WFI8G9PRbpuZNHwGd7TOzG9Ro+rG6xY9J8nMPV8N
WxjwIWRu/g==
=mo8X
-----END PGP SIGNATURE-----

--h3ivafm5bqasam2u--

