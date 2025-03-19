Return-Path: <linux-kernel+bounces-568280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE5A69323
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B44807AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2F1CB332;
	Wed, 19 Mar 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqnOA9PD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FF158538;
	Wed, 19 Mar 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397181; cv=none; b=fFO7mNdd9bqR5UJJMl+qJwBQOEiJ1j61hSZwLvCsCb69cB1tty0LdyNxOlVf+ym+EhbWePrWnb5Rjkf8eBczKo4fH66o3et3fO8racEYhgW8QQYEC9IB+eZbNZF2TeDiEVtxqlmLLyqo+vexf6tUUAvO+DOK+1Km3TOZ26WSpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397181; c=relaxed/simple;
	bh=8IfaDe4xKcoOkHQwrRAE6sFu1oSNcpTNrvncQFG5gQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7U7/HtjbSGM0ydA9+ZD/v/siRxbtdVUGJtTs8s+M20XhExSERJPYGndAkkLQiJLw3bmUUEnQi1u1ZT5Y3XxN8pDnoOAG7748PLZMRnM4VtmG0LMFYgmLsQa8pfNiJjLZ0Iot1AokLCIYNovG32I/B0upFfVWCZ0B+1H4AhRXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqnOA9PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C41C4CEE8;
	Wed, 19 Mar 2025 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742397180;
	bh=8IfaDe4xKcoOkHQwrRAE6sFu1oSNcpTNrvncQFG5gQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqnOA9PDEvfe7zwQApj0dCUmZA2HHyyMWVQ1R+CithbrSPG3dwXF9pAZG8EDKgGab
	 5ac8iyzqqd00xKNrWOZq+SJj3y6UbskBGOwzk8QsYNVm3oHrPdMTUjbry5PtnoMFNs
	 yIYDrYFyHiK6qNO6L7JAxlDcqlO5tREcYaFOqGCqc43k26MVdDUY9QgzYfZjA2P+iS
	 PWV4bIft1td+RsvtvEws8TInOTnH+Q2p0m5HrebIi/+sF3jAzpJoHVeXvbDeBv19ZX
	 mM2BMVKJnUfPLdtSmswZBtWrItd7JVt3tFtYt7F7FglYnYe4gJZJBdDdrFgsbD7waK
	 E0DqDLzztq6sg==
Date: Wed, 19 Mar 2025 15:12:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, shenghao-ding@ti.com, kevin-lu@ti.com,
	baojun.xu@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 13/15] ASoC: ops: Factor out common code from get
 callbacks
Message-ID: <1d6d7537-1dcf-4bbe-a16b-902705efa860@sirena.org.uk>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
 <20250318171459.3203730-14-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YBZ3Yf/fJ5tvbHXq"
Content-Disposition: inline
In-Reply-To: <20250318171459.3203730-14-ckeepax@opensource.cirrus.com>
X-Cookie: Old mail has arrived.


--YBZ3Yf/fJ5tvbHXq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 05:14:57PM +0000, Charles Keepax wrote:
> There are only two differences between snd_soc_get_volsw() and
> snd_soc_get_volsw_sx(). The maximum field is handled differently, and
> snd_soc_get_volsw() supports double controls with both values in the
> same register.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/soc-ops.c: In function =E2=80=98snd_soc_get_vo=
lsw_sx=E2=80=99:
/build/stage/linux/sound/soc/soc-ops.c:374:22: error: unused variable =E2=
=80=98reg2=E2=80=99 [-W
error=3Dunused-variable]
  374 |         unsigned int reg2 =3D mc->rreg;
      |                      ^~~~
/build/stage/linux/sound/soc/soc-ops.c:373:22: error: unused variable =E2=
=80=98reg=E2=80=99 [-We
rror=3Dunused-variable]
  373 |         unsigned int reg =3D mc->reg;
      |                      ^~~
cc1: all warnings being treated as errors

Please ensure your serieses are bisectable.

--YBZ3Yf/fJ5tvbHXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfa3vcACgkQJNaLcl1U
h9DkHAf7B9b/cQM8ZriJDru5YQx4Ngs2Pp8A6M6PxFkTd/KNclskMHKIYoicbwWQ
LLt6+jisWhEgLUOrYu+MMzvHzPZbIIduj2k6oWuKH8/vO7HILUrzA/d2ow+KAaxk
PmbCjFmsS4np48eMPGwZWFcWaAItLxEVrWxxWq5ukANPWqhKvsnJbnJuxl5OjYlM
B/hnlFj9LFk/HELUAhIcKy0qRN7NQpdAwyFP2N+LDo5j3QV8SRzirPdkLUy2SkhD
vSZeingmKoxFVdjuHgxcprQgeeQzlM53Uwwwe3Hd5txnnh9kxSFsXDzRDqpEcuvM
CF1hqfkkmYMN4A3/4sdEWZ4+K5MOyg==
=zb4x
-----END PGP SIGNATURE-----

--YBZ3Yf/fJ5tvbHXq--

