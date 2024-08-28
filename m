Return-Path: <linux-kernel+bounces-305206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4D962B03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8C71C23450
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CEC19FA94;
	Wed, 28 Aug 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6tBH1FF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FA186619;
	Wed, 28 Aug 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857398; cv=none; b=T4mPwepyr/3yab0YqKRxfDcoeLFURpOBugNl1vPnwXfULxe9OdvUhaZFQT2bS/1+aMtPcHv4IZGgmzV7zDkKsrS732p/DRp0aXIMSdHZ7NeglNa6w7Tq2T2XVL8wnIXdwaXxr/hX8JnhbLR+CGvQQ95YIaJbzshyx/yUn598QM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857398; c=relaxed/simple;
	bh=Q/FWYBfhq0EfW/PW3pTyaVMwo1NEzGyWM8q4CMuLmmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdRJimn94cfDr5770DBEOhdy9kPQQwa3Dsdb6Qcyl7a+33GQG6hYa5oAiJ4TUEKoFJMeSo3+wpi3gmO4nmd2DKYLy5Psts2cliW1VQYKsm7pOw7q3L54iNzk6qtZmZikV32zHPCyp+ditJNXZ2Ikbhu0IYCtGNHO7/NuZInzG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6tBH1FF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C16C4CEC2;
	Wed, 28 Aug 2024 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724857397;
	bh=Q/FWYBfhq0EfW/PW3pTyaVMwo1NEzGyWM8q4CMuLmmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6tBH1FFTxkGbyppAXiq3i3jb1A3bP52++rMmbcUB3aCvNcgdndawIqNWY2QAVDLf
	 gs21BbcbPtkPUsphg1ZK4FoZOeueWhmZMJ4Gf3MgNfj8rIQYM6p8BZGR5SPjyn4ZLh
	 n+rWR2BYesFeHSrqo1bewKrLLkKlse67VDaFJuRRzwGQnkvXH4ioG2ttb3TBgBV4lw
	 CLd3ogYNZCI7SYOnjmBOrIzeZhC1H2giUZVN9rPSVq4K95SyOGSrfKFXut+9mgz9aM
	 FliJmZ3gzTZwlXty8Z7v4w26porBNOo/CwCxDCYZ5aJSdNYQ/FcbxAV3P87amqofM/
	 vTIHuWPDTElmw==
Date: Wed, 28 Aug 2024 16:03:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ASoC: dt-bindings: amlogic-sound-cards: document
 clocks property
Message-ID: <20240828-brittle-swapping-8b04379725c8@spud>
References: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m2irlymd8u+CRXoQ"
Content-Disposition: inline
In-Reply-To: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>


--m2irlymd8u+CRXoQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 03:53:53PM +0200, Neil Armstrong wrote:
> Following an off-list discution with Jerome about fixing the following
> DTBs check errors:
>     sound: Unevaluated properties are not allowed ('assigned-clock-parent=
s', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-=
sound-card.yaml#
>     sound: Unevaluated properties are not allowed ('assigned-clock-parent=
s', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-s=
ound-card.yaml#
>     sound: 'anyOf' conditional failed, one must be fixed:
>         'clocks' is a required property
>         '#clock-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
>=20
> It has been agreed documenting the clock in the sound card is a better so=
lution
> than moving them to a random clock controller or consumer node which is n=
ot
> related to the actual meaning of those root frequencies.
>=20
> The patchset adds the clocks proprty to the bindings and finally adds the
> properties to the DT files.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--m2irlymd8u+CRXoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs88MAAKCRB4tDGHoIJi
0mjhAQDnSlMChubzH0189CmvK9fFj4PZMmpTw44594t+DOABhQD/RjBwMvnhYOXP
VRtcQF5BBGyx6BDxa1eaamYHy44Vewo=
=lI7+
-----END PGP SIGNATURE-----

--m2irlymd8u+CRXoQ--

