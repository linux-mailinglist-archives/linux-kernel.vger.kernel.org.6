Return-Path: <linux-kernel+bounces-417913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023589D5AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94099B230C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDC217DFE4;
	Fri, 22 Nov 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/EABDjz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05418787C;
	Fri, 22 Nov 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262815; cv=none; b=lSFjD7sKNFvWER1lF9wG9anvZWYALjAKDedQMlhpVbWvgzkPQjhDnkbcz9bhxP3mhQHd8F0Nt0Ax7IwWv7z1kHvijTmhXtWYdZFjjRUfyNJCjK14Tj3YqWLLDL3FUxyFRmchnObiKLhMPVPITh8qGXOOZ+1NdSs/sFIM0eLnypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262815; c=relaxed/simple;
	bh=hEvXNFAbKlLA5ycugqwHzMWIE5TPFsHSStNQ7IozSjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4KALscDHlad1VO6ZeaaOKPtm76c2aKXIYrINurcJPTLLRqlyr+0bHbOnG9VqCUhnA7cIpPdQqijFUSNz+UGokiwOxtOSmb8Jpeyo3VS92vbhhPwLtVODTmw1Tq3BI2hmNH+gOVUYfBbKYcD4d4QZjN10Hv47CkmmTiW9YVKIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/EABDjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31842C4CECE;
	Fri, 22 Nov 2024 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732262814;
	bh=hEvXNFAbKlLA5ycugqwHzMWIE5TPFsHSStNQ7IozSjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/EABDjzLiFjpLj+4JnD6M1QszY1n9gOuE/Oi96V2wbiUI5SBsZguKCgTGxZlT97x
	 wLZ9jI808UVyxZyafkDmnkGaBnuq0a8Nild9305CxVDvDa4blb73Zjfsc2sLPAprRL
	 B8DS0f0w+J72kDw+axG5LNTQ9H1w8965eHdFlb/oo2FlCZdmlb1TmdtlacfHTCop7R
	 PSUPaZMJSM1DlhoHH8Dcyt5rKk1pl1F+z8phkk2AdGVn0C6bCMoDC3Zfg4cd4gc3td
	 gamSq+Ehw75+gJ9RqsoR2uH/MZLWUn9Sva3oAesE3JKvam6yhnlROhIe728ebbOJ8c
	 hBJ8XteHU7hHA==
Date: Fri, 22 Nov 2024 09:06:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH 00/37] drm/vc4: Add support for BCM2712 / Pi5 display
 hardware
Message-ID: <20241122-orthodox-mantis-of-reading-2dcdcf@houat>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <CAPY8ntBM=34pTiQ=t-CjtYEE5Ax6D=EtiY-sLT1keUkUMXuLeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="p4qucrakavsqq3j5"
Content-Disposition: inline
In-Reply-To: <CAPY8ntBM=34pTiQ=t-CjtYEE5Ax6D=EtiY-sLT1keUkUMXuLeA@mail.gmail.com>


--p4qucrakavsqq3j5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/37] drm/vc4: Add support for BCM2712 / Pi5 display
 hardware
MIME-Version: 1.0

On Thu, Nov 21, 2024 at 03:37:00PM +0000, Dave Stevenson wrote:
> On Wed, 23 Oct 2024 at 17:50, Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > This series adds the required DRM, clock, and DT changes
> > required to support the display hardware on Pi5.
> > There are a couple of minor fixes first before the main patches.
> >
> > Many of the patches were authored by Maxime whilst working
> > for us, however there have been a number of fixes squashed
> > into his original patches as issues have been found. I also
> > reworked the way UBM allocations are done to avoid double
> > buffering of the handles as they are quite a limited resource.
> >
> > There are 2 variants of the IP. Most Pi5's released to date
> > have used the C1 step of the SoC, whilst the 2GB Pi5 released
> > in August is using the D0 step, as will other boards in future.
> >
> > Due to various reasons the register map got reworked between
> > the steps, so there is extra code to handle the differences.
> > Which step is in use is read out of the hardware, so they
> > share a compatible string.
>=20
> A gentle ping on the patches for clk-raspberrypi (patches 29-33) and
> Broadcom DT (patches 34-36).
>=20
> All the DRM and dtbinding ones are reviewed or acked (thank you!).

If the bindings and DRM patches are all merged, you can merge these at
least.

Maxime

--p4qucrakavsqq3j5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0A7lwAKCRAnX84Zoj2+
doaCAYD4iZV09q1bBU7gjietZumaTJnk/0RYajiLIHHMerpOFe3il/ObO1rzaMBm
mOT0urABgPae6EbuMjtidxyyV0XhCMisWgYstcv23glemnLPC9awB+uSoIJHPW1e
2lHvcCHC6A==
=RgkZ
-----END PGP SIGNATURE-----

--p4qucrakavsqq3j5--

