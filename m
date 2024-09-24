Return-Path: <linux-kernel+bounces-337112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5B98457F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47EC282F83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BA1A7255;
	Tue, 24 Sep 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcGRmoAT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980D1A7070;
	Tue, 24 Sep 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179564; cv=none; b=IPkL2Af7wlDsLikK7GtGLTh3U0uVWy3rPb/nyuQuc+oud1WR20zt8MIwhgiavYLyWBEuG4qfejo8I3WsKKXSk6WsKEhk8KZqaznoYTcpbv7aWrHKFEFnHVp9EVj95IqpyCtMZ6x7bZ17JAYdxO/sbBJYOYSevCrWSp9zrIUrZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179564; c=relaxed/simple;
	bh=LBRldiJIOcrY+GP5MEjXsrQ804qeSK1W9On1aa+/+XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVudwi3Zcd5QTcIXP2IAOS8a6TdrH9kV4cOXb2XsQHs2UH1ZN15oQpXOZF7e2n8n97ghUQ5ISZDuZrpINqtDXsS8oEUSTFDDsQlBLx8wzcemBMlEODSgtcibeKvpxbE7S3pgqy+s4rcD/6cIW60p6WyKY0hJOfo9wMREK5zx/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcGRmoAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BE8C4CEC7;
	Tue, 24 Sep 2024 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727179564;
	bh=LBRldiJIOcrY+GP5MEjXsrQ804qeSK1W9On1aa+/+XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcGRmoAT3CedDgrL64QYhquF/99N1h92a+oStk9s0T2+NNXKo6BZnLwFGc13qEC4Q
	 rHQH3XbvSShxU5vtNX2N4AEm9f0JsubU1MhmNjuNlixrJ0tOQhv+0Uq3keNhWuD2C1
	 mmmg17yYGxBibA61PpACNoT0StTkba8LnfUN61C11G9ziw2f6xsb5Ij5PnJmHXrBgd
	 e7NyOZLvtS5ji2RIrufma7BAACZuiH94pJw4KdogK/p6uvXpNczfqfX//lxuPTQZcM
	 R6st9Wz+3GXpC7skvwHakXVL1zQMP+8bAI1DEagcJu2MelwCnR2Ea265NEnhz8C5ld
	 NNijYSPdL4/Pw==
Date: Tue, 24 Sep 2024 14:05:59 +0200
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: amergnat@baylibre.com, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH v8 1/5] ASoC: codecs: add MT6357 support
Message-ID: <ZvKrJx0sMXIxCfBZ@finisterre.sirena.org.uk>
References: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
 <20240226-audio-i350-v8-1-e80a57d026ce@baylibre.com>
 <CAMuHMdXtm+jGbbLXnCjPZZu_ZwpR-tCRuwbz0iQxUPkXG=g09A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="09XdXeePKsAeqisk"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXtm+jGbbLXnCjPZZu_ZwpR-tCRuwbz0iQxUPkXG=g09A@mail.gmail.com>
X-Cookie: Editing is a rewording activity.


--09XdXeePKsAeqisk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 01:44:05PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 5, 2024 at 11:08=E2=80=AFAM <amergnat@baylibre.com> wrote:

> > +config SND_SOC_MT6357
> > +       tristate "MediaTek MT6357 Codec"

> Does this need dependencies?  The driver uses regmap, but it's not
> immediately clear to me what is the backend (SPI?).

It's a MFD so it'll be whatever the MFD for the device is.

--09XdXeePKsAeqisk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbyqxkACgkQJNaLcl1U
h9Aeegf+JlTmfotEapBhCwzCkHyhP4vzPARCPqemBP0WpYEFPPpC/tpJ+APyZYKd
YLrBxlIJuHmEv9wDQiP7Yimltm2/e7iEV5ktOKbMtRtai5ELWUu10HBbuyVFhExm
dERrGNUi+7PDaO58V30yMlwb1jg/1cq4UcvsAYyNWLTfgyJpD/0LvOuy/Hdxu1SL
CZoS/ED1dSbObIAlLSDbHtwyljTJpMitkhSaqID293jpeg4XDbpy8VUpj+Hkg3wH
cE06JgnWqwMjIw+Ft6GaCvrrIHMSoIQAfJasq1K8LPU/KLm7Uw6QpdZadU7exPiG
pKxXuXApL4U03KfdsV9J9a7VAdzwkQ==
=NlQ4
-----END PGP SIGNATURE-----

--09XdXeePKsAeqisk--

