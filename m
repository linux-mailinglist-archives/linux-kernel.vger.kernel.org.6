Return-Path: <linux-kernel+bounces-257643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05066937CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A47F1F21E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1589F1487D8;
	Fri, 19 Jul 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdjp/qpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1C148316;
	Fri, 19 Jul 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417210; cv=none; b=sg9klwW9EnxsOe16uMHDjMMYxGA/1po/o1qs6NPsusy5fVFnhtyzHctJwgz+EwaeV1xChRh4feB7+dZeZXb3Yi5klvUPFWt9AI2Z0brNtAJewlJPXtNW6+dkbB5yZBTj2KmgJvLoCfEaBAykZ7h3o2QaXe1EWov4zPx2bY6WV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417210; c=relaxed/simple;
	bh=GXID7sUUJz5rZS31UruWZvQ5m2atDnWZSGvi6Hj6dI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Etx6LrqxVxoJozXpWOOuehaU/Zih3+X2ZyFVVgYY2XskCewg/gBl2kYLZHOfP3jNo6lnHZha/onV5qsezjXqaNRm0nsP1K+RkDuXcGOF3Jf2Ez5+iUlcEWeRkMhsLgg7WDuc8khOcjjf7d+u/SlDNmgdy+o6XLIqXHrsMHAs3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdjp/qpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A42C32782;
	Fri, 19 Jul 2024 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721417209;
	bh=GXID7sUUJz5rZS31UruWZvQ5m2atDnWZSGvi6Hj6dI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdjp/qpa9dofertM7AsvUjrc701tNHXdXsMFDwE9mNOsxbAN13Q12T+LxFVeTFZTV
	 Qbq6P4Zs41ZrIFVwVSnzws0QCaqF5VFjKQ4DJcfIJIq3WC7RtDiDlDg2MN4v6YpeD4
	 +GlbeKlvthIPV+WNorij4ShEN/mH5ijRt1T2arwLVKa16TyojThOOX8x2xZlhMXecd
	 dX03BLBPut1V9QVmzEdvto3Uyvbye03VJkRHihzuKTNmaHXA7aWkPqr90PtDvthWTX
	 23qWlxa9l+5PtxZbGJ7CFXcd6eIIKKqwJQfM/WEj2ksvuUdycJuaBrfvD8Xoehzl0d
	 GUjnYP0Pf6rSw==
Date: Fri, 19 Jul 2024 20:26:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
Message-ID: <20240719-abnormal-repulsive-fdefb72bdbe3@spud>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-1-31b7f2f658a3@linaro.org>
 <20240715-scorn-canning-a7f23b9e2039@spud>
 <CAD=FV=U-nOMu-JDQ3T=ZRJ-rZ0BTtyzFVfnzbtCJdbRzAq3YMg@mail.gmail.com>
 <e017259b-bc62-4b57-9276-b834237225e1@kernel.org>
 <CAD=FV=VY5Ug3TfUo1RctiVQrHUjuod15HA8BxAyWdd_0bK8_Dw@mail.gmail.com>
 <20240718-frightful-naturist-a049ea7c0548@spud>
 <CAD=FV=VaGXMf6Srix6v=Me35BUN4B6ZHwebycka4Dbavqa5Vbw@mail.gmail.com>
 <CAD=FV=WyDF8LkPeHXTgsyDA74n+AjuHPQ1896ECDE17aYB9rtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="etBnI+HPKfHkVQk5"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WyDF8LkPeHXTgsyDA74n+AjuHPQ1896ECDE17aYB9rtg@mail.gmail.com>


--etBnI+HPKfHkVQk5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 10:07:29AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Thu, Jul 18, 2024 at 7:59=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Thu, Jul 18, 2024 at 7:56=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Thu, Jul 18, 2024 at 07:45:57AM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Wed, Jul 17, 2024 at 11:19=E2=80=AFPM Krzysztof Kozlowski <krzk@=
kernel.org> wrote:
> > > > >
> > > > > On 18/07/2024 02:21, Doug Anderson wrote:
> > > > > > Conor (and/or) Krzysztof and Rob,
> > > > > >
> > > > > > On Mon, Jul 15, 2024 at 8:31=E2=80=AFAM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > >>
> > > > > >> On Mon, Jul 15, 2024 at 02:15:37PM +0200, Stephan Gerhold wrot=
e:
> > > > > >>> The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has =
backlight
> > > > > >>> control over the DP AUX channel. While it works almost correc=
tly with the
> > > > > >>> generic "edp-panel" compatible, the backlight needs special h=
andling to
> > > > > >>> work correctly. It is similar to the existing ATNA33XC20 pane=
l, just with
> > > > > >>> a larger resolution and size.
> > > > > >>>
> > > > > >>> Add a new "samsung,atna45af01" compatible to describe this pa=
nel in the DT.
> > > > > >>> Use the existing "samsung,atna33xc20" as fallback compatible =
since existing
> > > > > >>> drivers should work as-is, given that resolution and size are=
 discoverable
> > > > > >>> through the eDP link.
> > > > > >>>
> > > > > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > > >>
> > > > > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >
> > > > > > Can you comment on whether you would consider this bindings a "=
Fix"
> > > > > > since it's a dependency for later patches in this series (which=
 are
> > > > > > "Fix"es) to pass dtbs_check? See:
> > > > > >
> > > > > > https://lore.kernel.org/r/4bca316a-2334-425b-87a6-e1bb241d26b5@=
linaro.org
> > > > >
> > > > > The patch itself is not a fix, for sure, but it might be a depend=
ency of
> > > > > a fix (which you wrote above), thus could be pulled to stable as a
> > > > > dependency.
> > > > >
> > > > > I do not care about dtbs_check warnings in stable kernels, mostly
> > > > > because dtbs_check warnings depend heavily on dtschema and dtsche=
ma
> > > > > follows mainline kernel. Basically if you had warnings-free v6.8 =
but try
> > > > > to run dtbs_check now with latest dtschema, your results will dif=
fer.
> > > > >
> > > > > At some point in the future, I could imagine "no new dtbs_check w=
arnings
> > > > > in stable kernels" requirement or at least preference, but so far=
 I
> > > > > don't think there is any benefit.
> > > >
> > > > In this case it's not about whether it makes it to the stable kernel
> > > > but about which main kernel it goes through.
> > > >
> > > > If we land the bindings in drm-misc-next right now then it'll be a
> > > > long time before it makes it into Linus's tree because of the way t=
hat
> > > > drm-misc-next merges. It will make it to Linus's tree at 6.12. You =
can
> > > > see the drm-misc merging strategy at:
> > > >
> > > > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> > > >
> > > > If we land the dts change (a fix) through the Qualcomm tree as a fix
> > > > then it should target 6.11.
> > > >
> > > > This means that the 6.11 tree will have a dtbs_check error because =
it
> > > > has the dts change (a fix) but not the bindings change (not a fix).
> > > >
> > > > One way to resolve this would be to treat this bindings as a "fix" =
and
> > > > land it through "drm-misc-fixes". That would make the bindings and
> > > > device tree change meet up in Linux 6.11.
> > > >
> > > > Did I get that all correct?
> > >
> > > Is not not fairly established that a dependency for a fix can go onto=
 a
> > > fixes branch even if it is not a fix in and of itself?
> >
> > That would certainly be my take on it, but DT folks confirmation was
> > requested by Neil in:
> >
> > https://lore.kernel.org/all/4bca316a-2334-425b-87a6-e1bb241d26b5@linaro=
=2Eorg/
>=20
> FWIW, I'd rather not let this stagnate too long.

I dunno if you were waiting for me (or Krzk/Rob) to reply, but I didn't
cos I figured I'd already pretty much said there was nothing wrong with
the prereq being on -fixes too.

> I'm fairly confident
> in my assertion that this should go into drm-misc-fixes. I'll give it
> until Monday and then I'm just going to land this bindings change in
> drm-misc-fixes. Shout soon if you feel strongly that I shouldn't do
> this. If someone wants to flame me after the fact then so be it.


--etBnI+HPKfHkVQk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpq99AAKCRB4tDGHoIJi
0l0OAQDgDeKH7xkylyak8cTIADfNinnQbAx11DwQn+bi/deCCQEA0wO9wfmFIs+C
NcBqzAwjH7/KD1GefPSzjhaFBOMX9w4=
=DvMW
-----END PGP SIGNATURE-----

--etBnI+HPKfHkVQk5--

