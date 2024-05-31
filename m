Return-Path: <linux-kernel+bounces-197018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB758D6507
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF7B28C4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8CE73464;
	Fri, 31 May 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmMz+4zs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA857C8E;
	Fri, 31 May 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167512; cv=none; b=gYUJF51MlU7l4E50eyBZuX8nwEHbFdJOFIYYWitU2vb24FKNt9BET8xjHVFbnnDs4Qrb28C7x6yJbktilmPJPvO/AHCEB5tFnLTdia8YpyRXAabdp7sKZcbMOngfHhHLeSPzWlKU8AH/KpYKyxrAJLGppAZAHU5/EYcM/Bf9VFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167512; c=relaxed/simple;
	bh=g1eGXHdN0kkF++pfgnz1WIShz96T3A5ZcHkmqtw/Loc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Eg2Of1gcta+eUb3DNvk14KOk/vXp0RyJe90oHAWoRsT69ea6QRk8Mywv3ALm3guugFk60bp+vkEqcB+0VQQqtI23F+f/EOxt3zeOJvb50G64IHqzCyHAjfIEkE1gt5/Gz8ks9D/+0ZaK/2VjlfI894apRiD/4B80T1sk4Iv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmMz+4zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50720C116B1;
	Fri, 31 May 2024 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167511;
	bh=g1eGXHdN0kkF++pfgnz1WIShz96T3A5ZcHkmqtw/Loc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmMz+4zslnz3CoeqQnw4R6MTFsDQPLnEs6swHFG8QQF9SYpF/35igdu+dIagmM9yN
	 4A2Vkpnbrn+D8A9ONTwmM/yxSAtY+fB3+4wYewAn2xHme9a+bWLxYIb9ICJC7X+Q6s
	 g/hBxxws2HElAZ5XTmy93gd0tFHDbycLSa4KrBHw7AUDGnLsGelmqYvdICYQyGkT0w
	 UHtXY3hwlsppDvSryW6PhXu0rMyPGWmoOhnLjgboATs4lqNqACr2u9nMU+NTzMyzhS
	 80r0loHtgrlHoxZbJ2b4co1qT7uj27CurSX70Lf/7mds00sRKp3Hv2BHX0n6CWe0nh
	 i9ikqd5rw7bBA==
Date: Fri, 31 May 2024 15:58:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: clock: mediatek: Add mt8173 mfgtop
Message-ID: <20240531-rubbing-gala-4104e3051425@spud>
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-2-wenst@chromium.org>
 <20240530-revisit-profanity-889f1bcae21a@spud>
 <CAGXv+5F=AEE7t=YQ0hNGtV9rbVBm75D=ftJdZKwD_JmUW9gQWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ys2BwcK/uLhX00G4"
Content-Disposition: inline
In-Reply-To: <CAGXv+5F=AEE7t=YQ0hNGtV9rbVBm75D=ftJdZKwD_JmUW9gQWQ@mail.gmail.com>


--Ys2BwcK/uLhX00G4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 03:29:06PM +0800, Chen-Yu Tsai wrote:
> On Thu, May 30, 2024 at 11:43=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, May 30, 2024 at 04:35:00PM +0800, Chen-Yu Tsai wrote:
> > > +        #include <dt-bindings/clock/mt8173-clk.h>
> > > +        #include <dt-bindings/power/mt8173-power.h>
> > > +
> > > +        mfgtop: clock-controller@13fff000 {
> >
> > The label here is used, so drop it.
>=20
> Assume you mean _not_ used. Dropping. :D

Correct :D

--Ys2BwcK/uLhX00G4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlnlkQAKCRB4tDGHoIJi
0giRAP94G90Cq94R7lpitEm0sZWkvKgob2eHruL8ul6FkP4EuwEAnm88tB8IKALh
7teTfUoOYj4sOcrhC/d5sE1XgPb58g8=
=BRoX
-----END PGP SIGNATURE-----

--Ys2BwcK/uLhX00G4--

