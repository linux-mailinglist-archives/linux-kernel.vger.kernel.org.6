Return-Path: <linux-kernel+bounces-519778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA9A3A1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB4B7A51B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886F26E17A;
	Tue, 18 Feb 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/Bfy9y9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFA26E14F;
	Tue, 18 Feb 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893976; cv=none; b=SW1s9H7QSY8DGLp8JWysCrTKLEFHC0M4sr/9Re63Xx9n7ry3uEv/7lfBcR2fu2dIKGxe2HmpdMAwAbA0KFn7OqkmLv1hzdQC9zGUGUR7Q8fLQZq+vs+RNJ1FZfBKQgLfET/egB759rebYco9hOh0YfP4xhYVRMImgTWvG/rn8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893976; c=relaxed/simple;
	bh=Lfy3wqOCBbjxg5nNsnZbpi/kGngbJgptpe7heB+ZnUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnoN090mLzRwjnheAGrVyIoArtXT8pqG67WXDDmlkcZqsVHDiLutIJzUd5Ch7RfZd0pe/0t19R3FzIG3NKFJSOamCuZHY6zm5LaYxssfgdfyHAFbHeca71ebYWuHdmISWwmV+RrBi/DLPnVRqDqZ5qZd3jsNAYooSrU1YRQdSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/Bfy9y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E116BC4CEE7;
	Tue, 18 Feb 2025 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893976;
	bh=Lfy3wqOCBbjxg5nNsnZbpi/kGngbJgptpe7heB+ZnUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/Bfy9y9GvvUCCcinsoy9LUwBfEUgAY7EsZTD9cvt7fqLwcGpXMHwq4sY1UkKTiHA
	 IOt9JnV9XpERQg1rywCHuIE/vKBfkunfNpS2djpqLBoeaWRBh82U2QDKTxMXc5B3mW
	 Q7oy9UqlgveAwOrkGE7vXiyle+mv0YX9s6/N09vGh7dV3Jl/AWWMHMqnJR/ahHeUYh
	 9j65F3nRQ+eXHK0PEvPrVMs4kxW3alnNZmbi8qYdZ4e3nfzVCHwWX4+dvGPppnO1Pg
	 MGHv+gjZMUjMjMXQHR+80vhf+4tJgvipE+ZYMIIwE5TWaglnES8eB/VpltrIsFNI+p
	 NRSYrXILM7zqg==
Date: Tue, 18 Feb 2025 16:52:53 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, 
	Anusha Srivatsa <asrivats@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
	Javier Martinez Canillas <javierm@redhat.com>, Jianhua Lu <lujianhua000@gmail.com>, 
	Robert Chiras <robert.chiras@nxp.com>, Artur Weber <aweber.kernel@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Tejas Vipin <tejasvipin76@gmail.com>
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
Message-ID: <20250218-primitive-kickass-seagull-008bf2@houat>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com>
 <20250218-fabulous-agile-corgi-9a5ee0@houat>
 <ynmxaimdwkwfiryz5le5vpnfh5fzh5se4ebyqzkbnq355me76x@yxtyan3niivb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="fpteilqt6emhj7js"
Content-Disposition: inline
In-Reply-To: <ynmxaimdwkwfiryz5le5vpnfh5fzh5se4ebyqzkbnq355me76x@yxtyan3niivb>


--fpteilqt6emhj7js
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 02:14:43PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 18, 2025 at 10:55:49AM +0100, Maxime Ripard wrote:
> > On Fri, Feb 14, 2025 at 08:26:02AM -0800, Doug Anderson wrote:
> > > Hi,
> > >=20
> > > On Thu, Feb 13, 2025 at 12:44=E2=80=AFPM Anusha Srivatsa <asrivats@re=
dhat.com> wrote:
> > > >
> > > > A lot of mipi API are deprecated and have a _multi() variant
> > > > which is the preferred way forward. This covers  TODO in the
> > > > gpu Documentation:[1]
> > > >
> > > > An incomplete effort was made in the previous version
> > > > to address this[2]. It removed on the mipi_dsi_dcs_write_seq()
> > > > and mipi_dsi_generic_write_seq_multi() with the respective
> > > > replacemts and not the rest of the API.
> > >=20
> > > You didn't seem to take most of the suggestions I gave in response to
> > > your v1 [3]. Specifically:
> > >=20
> > > a) I asked that you CC Tejas. I've added him again.
> > >=20
> > > b) I asked that you CC me on the whole patch series, which you didn't
> > > do. I can find them, but I'd find it convenient in this case for them
> > > to be in my Inbox.
> > >=20
> > > The first patch conflicts with what Tejas already landed in
> > > drm-misc-next. See commit 8025f23728e9 ("drm/panel:
> > > xinpeng-xpp055c272: transition to mipi_dsi wrapped functions"). The
> > > second patch _also_ conflicts with what Tejas already landed. See
> > > commit f4dd4cb79f9e ("drm/panel: visionox-r66451: transition to
> > > mipi_dsi wrapped functions"). Later patches also also conflict. See
> > > commit 0d6c9edf9e5b ("drm/panel: ebbg-ft8719: transition to mipi_dsi
> > > wrapped functions"), commit ce8c69ec90ca ("drm/panel:
> > > samsung-s6e88a0-ams452ef01: transition to mipi_dsi wrapped
> > > functions"), and commit 7e3bf00047cd ("drm/panel: sharp-ls060t1sx01:
> > > transition to mipi_dsi wrapped functions"). Maybe you should sync up
> > > with drm-misc-next before submitting.
> >=20
> > Yes, you should definitely work from drm-misc-next there, and sync with
> > Tejas.
> >=20
> > > I also questioned whether this really made sense to try to do with a
> > > Coccinelle script and I still don't think so. It looks like Dmitry has
> > > already reviewed the first few of your patches and has repeated my
> > > advice. If you want to help with the effort of addressing this TODO
> > > item then that's great, but I'll stop reviewing (and start silently
> > > deleting) any future submissions of yours that say that they're done
> > > entirely with a Coccinelle script unless you address this point and
> > > convince me that your Coccinelle script is really smart enough to
> > > handle all the corner cases. I'll also assert that you should review
> > > Tejas's submissions to see how these conversions are expected to go.
> >=20
> > I couldn't find that in your first answer though. What corner cases do
> > you have in mind, and why do you think coccinelle can't handle them?
>=20
> As can be seen from the reviews:
>=20
> - sleeps between DSI calls
> - properly propagating the error at the end of the function

These two are legitimate feedback, but I don't see how coccinelle cannot
deal with them.

> - making decision whether to create the context at the caller or the
>   callee side. E.g. in patch 8 it is better to allocate context in
>   hx8394_enable() and pass it to .init_sequence() instead of keeping
>   some of error handling.

Yeah, that one is definitely subjective, and is going to need manual
review.

Maxime

--fpteilqt6emhj7js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7Ss0QAKCRAnX84Zoj2+
dukDAYDXcF39vpxiWmY6ypqgL/3oHzXWyDI/hPJjKLqlSm/RBJvFdXWqH7cTvsJF
BGl9h0kBgJTBJ0vvu/UwpgZ/UyHD1S710s4lhY5YyyHuho6JwZzsb+tXPmRgz5E1
/h560Q3h1w==
=9vo/
-----END PGP SIGNATURE-----

--fpteilqt6emhj7js--

