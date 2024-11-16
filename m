Return-Path: <linux-kernel+bounces-411825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31719D0007
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558051F22677
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4018FDA3;
	Sat, 16 Nov 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TmkP9kmL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1B183CCA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777624; cv=none; b=hwBYSh57QRpZ12HL4oEoLB5OMw4uoUMCooAsP6ANKdopUiHeQVVPzJkwLxd6oDaYbFqEng4wNg3DfqbfRot3Vuia44pRqZae2R0CIBh/n4x8PobWZFKRFhfx9dOlKHd2RwJhz0JWifJUjA4cofjiLz/qbf/e5uwh8wsalP2v6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777624; c=relaxed/simple;
	bh=5w+T7fDiwjH4Q91Rzn299zU03tEpvFIoldlRVMcVLGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk4diY91aw9XK3DctsUxMEID7DkzfUeA6wX7AHE4SCouJjQAMd3sOVc06gJbBKqYuC41fNRV1peLALgcU7VyUAAH7I/3QcbCrFOS/Nttq0JtQQslfukNJVBsod7pTVP/KG5LWBoetzZpcUUsoxP8Oy46wnYvVk+UYAvZ0PuYT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TmkP9kmL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so14845295e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731777619; x=1732382419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/dgzgvFQRnihgmL6uOs2B7Yp3DRZimnSwwaTVovC9Q=;
        b=TmkP9kmLkBSp3Tz7xxzG7Dvg4C9l8nxsfcLmDzk+VSkacU9MLqtgBLHHImxMuAjtj4
         HKn1lvj9cHKfx7aTNQOynzJ5N1tsgf7nRdbvOAwIs0eDkz2HvAX/L64Ion5H2oUATlC/
         mlc5upbbjXZfI9WS5ySIDFXcIc7QxrfMq+i9hHtOHCKX+dRPzlcipCQ/NVKz5YYS0qZX
         XQi3nwy3OcxF7SajhjnlzAjvFLj1rdlRgvhb3LgYWp6CBoey57SM7ND2wQ4fe+j5INj5
         4QmQdv35lkZ+MmLSKl5uyM8OCPeBzx98mGv/VlRQkinnt1P5aYYPcVitVzb9WIUb9pZc
         rMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731777619; x=1732382419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/dgzgvFQRnihgmL6uOs2B7Yp3DRZimnSwwaTVovC9Q=;
        b=QRt02yDoH74qZ8QAyzrFk9j/D5xEXq1HUkQa2fKRtF/wAiwm4TxoNa/1VCrMI1O6ZE
         IAfC6QOHFezHD4bSa6Zly9lTdETZ9tABXVEa9u0StivTMZEG2OBLOjQ+49w8ju2AjFzF
         moa3YPPB9jn2gKfRsEsR7QQxxASSr/6tc62K4THsj6L7PZhMpbLeBnPrUCvkwr/ByPUx
         IMc5iA4ss66/bd/mWjqwtJZkBG6pJAVS/Fjwa6h2EtKTMyRpvuXMg7FCxlXYAkULyw1x
         QzS1UsQdj0Pam3+Rk0DPSahy2Ky/jpU9bKFxB2pG04iPcjn4PbcMrTdBHKoohhlqc9Uy
         8khw==
X-Forwarded-Encrypted: i=1; AJvYcCVIIUPe5uzmr7kEQLAVyBvGkEyhrDZcj4Ap2DuD62d3ZfnVP+mgsyqoixYHTF5gop41nwYmSkJ+M75jfTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nDTBPXArQp4Ad+OqTzw/48Bj8IRSxfTASBFhqr9TVO5qMkkw
	BNAAmPLB4desv5tsN++nyhotZ7bp0x8b98d82eI9pgYWWQsFMSvrZCDuepCF7pk=
X-Google-Smtp-Source: AGHT+IGPrpiwwvYCz+WWZ7w684+SywIWzla7gQ5qa/QXLMORFBVUuxFDT5sUvlxxHeTi9VQig72ryQ==
X-Received: by 2002:a05:600c:3b0a:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-432df78b065mr53563615e9.20.1731777619087;
        Sat, 16 Nov 2024 09:20:19 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:941:29cc:578f:b591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm96583395e9.35.2024.11.16.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:20:18 -0800 (PST)
Date: Sat, 16 Nov 2024 18:20:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Gomez <d+samsung@kruces.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux@leemhuis.info, 
	vv@tuxedocomputers.com, cs@tuxedo.de
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
Message-ID: <wnfqe7q2aby76zokkh77jhlwc2dbr243kycmejc4wj5wflywgi@6sox742ip22g>
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
 <20241115185253.1299264-3-wse@tuxedocomputers.com>
 <D5NGCPSP7EO8.28YI337NY203X@kruces.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtg7bk2c5czsktwc"
Content-Disposition: inline
In-Reply-To: <D5NGCPSP7EO8.28YI337NY203X@kruces.com>


--mtg7bk2c5czsktwc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
MIME-Version: 1.0

On Sat, Nov 16, 2024 at 09:15:55AM +0100, Daniel Gomez wrote:
> On Fri Nov 15, 2024 at 7:50 PM CET, Werner Sembach wrote:
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> >
> > TUXEDO has not yet relicensed a module for GPLv2+ as a reply from former
> > contributers the committed code under GPLv3+ is awaited.
>=20
> FYI, the SPDX identifier GPL-2.0+ is deprecated as of 2.0rc2 [1]. I think=
 you'd
> need to use GPL-2.0-or-later [2] instead. And when using the SPDX identif=
ier,
> you don't need to include the full text boilerplate in the source of ever=
y file
> as long as you include a LICENSE file or COPYRIGHT file with a copy of the
> license. One example upstream here [3] commit 1a59d1b8e05ea ("treewide: R=
eplace
> GPLv2 boilerplate/reference with SPDX - rule 156").
>=20
> [1] https://spdx.org/licenses/GPL-2.0+.html
> [2] https://spdx.org/licenses/GPL-2.0-or-later.html
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?h=3Dv6.12-rc7&id=3D1a59d1b8e05ea

If you're convinced that "GPL-2.0-or-later" is the right string to use
(and the following somewhat agrees with you:

	linux$ git rev-parse next/master
	744cf71b8bdfcdd77aaf58395e068b7457634b2c

	linux$ git grep -l -F 'SPDX-License-Identifier: GPL-2.0+' next/master | wc=
 -l
	3640

	linux$ git grep -l -F 'SPDX-License-Identifier: GPL-2.0-or-later' next/mas=
ter | wc -l
	9005
)

you can consider patching Documentation/process/license-rules.rst which
currently reads:

   License identifiers for licenses like [L]GPL with the 'or later' option
   are constructed by using a "+" for indicating the 'or later' option.::

      // SPDX-License-Identifier: GPL-2.0+
      // SPDX-License-Identifier: LGPL-2.1+

Best regards
Uwe

--mtg7bk2c5czsktwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc41E0ACgkQj4D7WH0S
/k5+SwgAubHUymAvKTccESpnV+7u3Yc/hqVAPKF4P2jEMd5yAHKSi2ekL0Sae1Jz
mNT7gnv+ytCDflbgLThPeSkjdfAgFyjPQjsZlC29RZ54MsTHIcEiMVvHMueV9UUD
KqVWhvH/8zQMM5U7FCZpU8scDHxKQuKHnBAhwr1cUHPO4ecNpv1uk5dkDVjzFi1c
VcZTIzLJz4pf69xaChiHjZRszpkbjhci3lTGPF15WL25E7zs41ix401Z4ReYvJhP
EYnSgH15fQjy/Wxzcg3rI5a/hwZQYVyk6SMZ4Ddwcof4TzpLdHfdmB4nxSjVdE2G
nrnK/IbIb+wHs7pTTe/FalQWLn4chA==
=Dtig
-----END PGP SIGNATURE-----

--mtg7bk2c5czsktwc--

