Return-Path: <linux-kernel+bounces-519087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA5A397BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBED1894EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0089230D0A;
	Tue, 18 Feb 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqmhkQo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64022FAFD;
	Tue, 18 Feb 2025 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872554; cv=none; b=nRR25zBr8KSkd/Y8TumVuPZCCbqPoWNnnr1nJgUbVEwgFx/BLR3jtwfhsgbmkXOKbQmjjhgCinh6blEuC7aFTpj2ozHIpCjitaR5qVh3Kvu5lmK82H945tr8vDN45UQC6UW95i7WgjLYQNVoDReEBvHChJbv1hczd0P+A0xiH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872554; c=relaxed/simple;
	bh=rvj0t9+tjvO+0OV9PLc5srj+NlKLO440nNkbXNyfhZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmaA84n4f0qh/pH/7ClCDspjNpp6oznnxQsNSvuQN44rmnd2VfGLMchXKNcaMLUtpuxmiAE/oeviABBzvmkNuiK3Fh7Eb2dggQJ7bpVznyHqKqKRRnpI7uij6v9jMBij6gqICtDQpkGjXnNV7aJwCVq7tfs1utxEY6KAoC8XwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqmhkQo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E337C4CEE4;
	Tue, 18 Feb 2025 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872552;
	bh=rvj0t9+tjvO+0OV9PLc5srj+NlKLO440nNkbXNyfhZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqmhkQo21p/IwHWW1vn6ppeNmvxU5hEUr+tROAL+/McFaDG+sFe50Rj+/GsweYbuB
	 gHc1Qd2npna0pnZlbEdqGy9oZVqyYcxOJz21wdqMdBDwmwcdD/s92xKnORETlpD8dr
	 u5DO1okXMmLpey9ba08Ua9Tu87nuk1H1kptFxzY3xCKA2sYE8uYt7vzFpy6egMcCw4
	 fJqGWmP8vQNKs0fl7mtBmAL6nEi1XTaeuCHgucvpJpyJub97Yyl9CJz9InOUApmYsa
	 ZjUuo1/rYIWGaDejRZLeEIqT4CizQMTrKrZmRJ+i2A7IAwTMtuL53BqCNg2+K7zvyJ
	 D23FMuv2ArjBA==
Date: Tue, 18 Feb 2025 10:55:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, 
	Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
	Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
Message-ID: <20250218-fabulous-agile-corgi-9a5ee0@houat>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="726nfthqf5wfkq3l"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com>


--726nfthqf5wfkq3l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
MIME-Version: 1.0

On Fri, Feb 14, 2025 at 08:26:02AM -0800, Doug Anderson wrote:
> Hi,
>=20
> On Thu, Feb 13, 2025 at 12:44=E2=80=AFPM Anusha Srivatsa <asrivats@redhat=
=2Ecom> wrote:
> >
> > A lot of mipi API are deprecated and have a _multi() variant
> > which is the preferred way forward. This covers  TODO in the
> > gpu Documentation:[1]
> >
> > An incomplete effort was made in the previous version
> > to address this[2]. It removed on the mipi_dsi_dcs_write_seq()
> > and mipi_dsi_generic_write_seq_multi() with the respective
> > replacemts and not the rest of the API.
>=20
> You didn't seem to take most of the suggestions I gave in response to
> your v1 [3]. Specifically:
>=20
> a) I asked that you CC Tejas. I've added him again.
>=20
> b) I asked that you CC me on the whole patch series, which you didn't
> do. I can find them, but I'd find it convenient in this case for them
> to be in my Inbox.
>=20
> The first patch conflicts with what Tejas already landed in
> drm-misc-next. See commit 8025f23728e9 ("drm/panel:
> xinpeng-xpp055c272: transition to mipi_dsi wrapped functions"). The
> second patch _also_ conflicts with what Tejas already landed. See
> commit f4dd4cb79f9e ("drm/panel: visionox-r66451: transition to
> mipi_dsi wrapped functions"). Later patches also also conflict. See
> commit 0d6c9edf9e5b ("drm/panel: ebbg-ft8719: transition to mipi_dsi
> wrapped functions"), commit ce8c69ec90ca ("drm/panel:
> samsung-s6e88a0-ams452ef01: transition to mipi_dsi wrapped
> functions"), and commit 7e3bf00047cd ("drm/panel: sharp-ls060t1sx01:
> transition to mipi_dsi wrapped functions"). Maybe you should sync up
> with drm-misc-next before submitting.

Yes, you should definitely work from drm-misc-next there, and sync with
Tejas.

> I also questioned whether this really made sense to try to do with a
> Coccinelle script and I still don't think so. It looks like Dmitry has
> already reviewed the first few of your patches and has repeated my
> advice. If you want to help with the effort of addressing this TODO
> item then that's great, but I'll stop reviewing (and start silently
> deleting) any future submissions of yours that say that they're done
> entirely with a Coccinelle script unless you address this point and
> convince me that your Coccinelle script is really smart enough to
> handle all the corner cases. I'll also assert that you should review
> Tejas's submissions to see how these conversions are expected to go.

I couldn't find that in your first answer though. What corner cases do
you have in mind, and why do you think coccinelle can't handle them?

Also, why do you think ignoring a contributor after a second mistake is
a reasonable reaction?

Anusha, most of those comments aren't the end of the discussion though.
If you feel like something's not clear enough or ambiguous, feel free to
ask for more details and keep the discussion going.

Maxime

--726nfthqf5wfkq3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7RZIQAKCRAnX84Zoj2+
dnx1AYDvs65FcAkxFl9bq1N9OH/nVRFJIYjxboyBi8+tMU6haF4kZySHcec5o4jC
5PoRUdIBgJqfgW9bYI6cos8FSWZOiPd2kShBBomX9tuNO0LB8BStQui7Vr/uAw9h
kErY8M7ARw==
=Z1aQ
-----END PGP SIGNATURE-----

--726nfthqf5wfkq3l--

