Return-Path: <linux-kernel+bounces-186433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC88CC420
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDEC28434F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958E7D08F;
	Wed, 22 May 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4NYcg31O"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDA140E2E;
	Wed, 22 May 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391922; cv=none; b=BcbCXSmXLI93hxh5jG+Cib5R97DS0Xztu+0CC4JqFaXRMqXlb3UDtV69thufhDIuIUrpTtO4eknj/m/g8gswgqEH+23Maqqhr4ADU1/rwKaL9xpOVEI05Zneqxw0Cg4svAHH9zKyX5xpnKKmdqos2IQL5YWwmfsZeiX3huhsabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391922; c=relaxed/simple;
	bh=kUTVaEv+CluhtL7Oa3Hy8QzRC+vL3NJAb+fI1CqZcJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aibmRU6szesldt02LEBeQVXevZkbwEAqEyC73aynS1kabF/MxwYFYhXwCUn4wOQlY2P/RDBAutDDPJtFkjQghzZFcClWadgQx2/50pW1E/om2/vSsDDRKp4xM64maynweoK/DcALqp3mbgU9J3iz4PkWw3IEYI8LTUY02ShedYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4NYcg31O; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716391918;
	bh=kUTVaEv+CluhtL7Oa3Hy8QzRC+vL3NJAb+fI1CqZcJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4NYcg31OsYHSC+HF3tIyiUc8hndE22wxc7pw+Q//fSm65c4ZbKpBNGiXNEakYxEKh
	 kFWIaK4OWeKsH84HGAYssMKq5MBRpgzAoN1s03GfYY7LGjcjXBPiiVrMAD8HqMxS7q
	 viLAhoCr/Nz8JNU7TxFJ0vq2SkqG3bLvrrb+seTGVSE3CRBVotdfU6equ9jLzrF5Bn
	 Am5+q5tl0byg9K2Sn+vTLN20ze4856ucuQbsxGdS5+X56VQmtzLdUY1hg6YUGAzqjo
	 ozxWLSPJUKpRuDwxk24x483I5nOEfa9oUMRoUr7AZ006YwG2xkAqMZMkJO6GKoV9Ja
	 /GxF7YCrLeABQ==
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE6243782170;
	Wed, 22 May 2024 15:31:55 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Date: Wed, 22 May 2024 11:31:36 -0400
Message-ID: <3334403.5fSG56mABF@arisu>
Organization: Collabora
In-Reply-To: <20240521-silver-exciting-bb3725dc495d@spud>
References:
 <20240514152328.21415-1-detlev.casanova@collabora.com>
 <13628421.uLZWGnKmhe@arisu> <20240521-silver-exciting-bb3725dc495d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6053228.MhkbZ0Pkbq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6053228.MhkbZ0Pkbq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Conor Dooley <conor@kernel.org>
Date: Wed, 22 May 2024 11:31:36 -0400
Message-ID: <3334403.5fSG56mABF@arisu>
Organization: Collabora
In-Reply-To: <20240521-silver-exciting-bb3725dc495d@spud>
MIME-Version: 1.0

On Tuesday, May 21, 2024 2:31:51 P.M. EDT Conor Dooley wrote:
> On Tue, May 21, 2024 at 01:15:46PM -0400, Detlev Casanova wrote:
> > On Wednesday, May 15, 2024 12:33:22 P.M. EDT Heiko St=FCbner wrote:
> > > Am Mittwoch, 15. Mai 2024, 18:19:29 CEST schrieb Conor Dooley:
> > > > On Tue, May 14, 2024 at 11:19:47AM -0400, Detlev Casanova wrote:
> > > > > Add the documentation for VOP2 video ports reset clocks.
> > > > > One reset can be set per video port.
> > > > >=20
> > > > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > >=20
> > > > Are these resets valid for all VOPs or just the one on 3588?
> > >=20
> > > Not in that form.
> > > I.e. rk3588 has 4 video-ports (0-3), while rk3568 has 3 (0-2).
> > >=20
> > > So the binding should take into account that rk3568 also has the
> > > SRST_VOP0 ... SRST_VOP2.
> >=20
> > That is what is set in the example and the reason why I set minItems to=
 3
> > in the main bindings.
> > Then, the rk3588 specific part sets it to 4.
> >=20
> > Isn't that enough ?
>=20
> Not quite - you need to restrict maxItems to 3 for the other devices if
> the clocks are not valid. What you've got says that 4 clocks are
> possible but not needed on !rk3588.
>=20
> Cheers,
> Conor.

I don't understand what "properties: resets: minItems: 3" means then. I=20
thought it means that all devices should have at least 3 resets. Then the=20
allOf below specifies the special case of rk3588 which has a minimum of 4=20
resets.

Do I need to add=20
        resets:
          minItems: 3
        reset-names:
          minItems: 3
in the "else:" ?

So in that case, I can remove "properties: resets: minItems: 3" above ?

Also, what do you mean "If the clocks are not valid" ?

Detlev.


--nextPart6053228.MhkbZ0Pkbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmZOD9gACgkQ5EFKUk4x
7bY7TQf+JupJtDv/HvUIX8L38oBOIr0TEHcquMrWumq4ACE/y2HjwxHAhYw7NufO
qC1OuNVis+e3pQ5kqoy5z9iNiyvA8weC2Uu2Ig0UgtdLPwhf88oj9IxHr9OtzY0J
Z1019PaHyov5yb3copVh66aW8rtadOKfNCio2F+zSNITxfwzdFJJ3pbk5JqHf4de
06zd16nvuYlQ6IUoony8xKi+NfJICvmo8XvR/UR5EEtlYPto8SnLPhqRw+vbRe4U
Bia87NTBM9o7bkq8kk00EOyO+PDEYlg3AU5mGLnnf0ES5kZPa10EDHJQZ1SHeM8k
sUP3VPs8I/S9Jk1QMusS6foYdtbshQ==
=vt+N
-----END PGP SIGNATURE-----

--nextPart6053228.MhkbZ0Pkbq--




