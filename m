Return-Path: <linux-kernel+bounces-318979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B093A96F617
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA181C20ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35B1CF2AD;
	Fri,  6 Sep 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO98gDiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989A1CBE8C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631103; cv=none; b=NvEhQu99kbppynR6xcD3yg/E/nnEkUKZWagMGdXl+GXELKjeiNjUSsClwyZOYn7GQZG3C2aosK1RQ7cjEcKw3vWyA/52wKMva7uP4yPvzo5vJVlxMKMGFtajyrAmxpRwAReHYmD7fUJJW4Cvfw8G89ap833t3CFB603KIScmOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631103; c=relaxed/simple;
	bh=UsOmUVqDQNmD3noisM+j25d0nW4Fec14iHTYBS5IraM=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Z5DQjsR3flD8OCCKdrgDKep+pjaFvMxkPQ05nHgPI1dN7VJ5hHvXPjrtlrBy2TaQfMxoy+1gYlPFAT5QpA1NImGH/DMMCf92PTMLnCV10ak59WYoyUy9hF2uZC9nMgna6PHDHOU0/VWVZ1vSpYibW8qnaF8Yxb5k6zATtx8F+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO98gDiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93B0C4CEC9;
	Fri,  6 Sep 2024 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725631103;
	bh=UsOmUVqDQNmD3noisM+j25d0nW4Fec14iHTYBS5IraM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=mO98gDiIIVIKieMLvIg9azVVIgKdPkXqWCTxrh4Sm10ZUXEw4A7Ahu0oKDeLiNyAP
	 UubQgHFD2/4ol7EN5Cy/BpxcTZdQmQWxHEfMUjTmH9q3pdXmWPYTcIZndVR+H8xWXg
	 /0/kJz5UGK85esOqpgugUD0qPhqJc+Tro3gHRM5Uyuf5P5JAitrvAdr0z8kei/4JNX
	 v1n64WkiEAtKafmBvReoENkhWa+9EaQt4LeDUX7mG/jIJzW+ddLrD+WaOkXWrh/G53
	 /jW1K8XBXGkIOCFdauuXDP0kBtDZABhPtCXPU2pptSaFfOEyoJMpXsNMlB9OrbBhwl
	 GX9GdTNAygp8A==
Content-Type: multipart/signed;
 boundary=55c931de707a8ac28990aa7fc9bea0976aa99ad4829328b51d70b1f9638d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 06 Sep 2024 15:58:18 +0200
Message-Id: <D3Z966PUEDVC.2HJCER9HHLTY7@kernel.org>
Subject: Re: [PATCH 07/20] drm/bridge: tc358775: use regmap instead of open
 coded access functions
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sam Ravnborg"
 <sam@ravnborg.org>, "Vinay Simha BN" <simhavcs@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Daniel Semkowicz" <dse@thaumatec.com>
X-Mailer: aerc 0.16.0
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
 <20240506-tc358775-fix-powerup-v1-7-545dcf00b8dd@kernel.org>
 <CAHgnY3=JKUCRvTtw6NzLvm+hy_GeNigj0tjOmbFupEs+=8f6ZQ@mail.gmail.com>
In-Reply-To: <CAHgnY3=JKUCRvTtw6NzLvm+hy_GeNigj0tjOmbFupEs+=8f6ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--55c931de707a8ac28990aa7fc9bea0976aa99ad4829328b51d70b1f9638d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Daniel,

On Fri Sep 6, 2024 at 3:47 PM CEST, Daniel Semkowicz wrote:
> >         tc->i2c =3D client;
>
> so the assignment above is no longer correct and should
> be also removed. Otherwise, this code will not compile.


Ahh yes. Thanks for noticing. I have a wip patch which I didn't
post, which had this line removed. Will post a new version soon.

Probably also going to split the patches because it seems due to
the controversy in patch 01/20 this whole series is ignored.

-michael

--55c931de707a8ac28990aa7fc9bea0976aa99ad4829328b51d70b1f9638d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZtsKexIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/ipTQF9GUYkBrGWgFmmOGO2Uq3wbAB+Bhm/ksnD
WUfLXwJcGfojX55IOBZCeWf8pdDXdgLEAX9I/tyljsvtI8wAUgcMo9s/WDXEq0Z6
dsAH7yvsQBh8c6L/zZzsKbdTDzAxfZlBycg=
=74xc
-----END PGP SIGNATURE-----

--55c931de707a8ac28990aa7fc9bea0976aa99ad4829328b51d70b1f9638d--

