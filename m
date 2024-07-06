Return-Path: <linux-kernel+bounces-243289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDE92940F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C3A282D76
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4713665B;
	Sat,  6 Jul 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CH71998s"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51026AC2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720276471; cv=none; b=JIQM3ctmZK1FQ/iZ7ZHBa08Ni2GRUg5l9nzhuP2slHlphJoqV9L2/m739RG6g0/xGbbOwDjPqMKyhkQc3YLDgmiZUhSUiwabCpugGOdFaBa9R3T9cYrAXDvP0V3XF78Rr0nqtO3DeXjHfboqH2Tac6lVbrOaakRuG8IfdnBsH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720276471; c=relaxed/simple;
	bh=0aFkKjeQR7yItr5YT5HS0t3s6OuI7El9Wwi8jRk7mbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjHIbwyBbdlfu8NTcxA/WSVHwPhJKTDw6VDdmSyaX+6lD0QpCLS/vgdkCRqpj3CngQ9zn8TUAfhfHNLP4bzNyuk7sC8ckWWPDUvG3caC+o6eghMjuhgx3H/sbmOsyoGwEjSNmzCapEUOkv7/IUF7fczS5E661viTadzkKvHzGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CH71998s; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=prJo
	DUW6lJpKM04RsYU/Ivzc814a5QLaNaF57qPoxNI=; b=CH71998s3J8GAM1vxT1E
	cEDufy/HqjzkZuTWqXxsVCW85k59D1Yy4rTiFINn6oorRzNU3TuSJoTSAvZx+gIQ
	ayUPO6BgiVD0AeCGKdb/zY3O5m3wlfw/i7JrMzl5Q0SPWQ2R5O2dsFhW+J9rEt9Y
	jd/TdflsxPus2zQlQtAzefzvhu5CC7/kl7MA3f0aWlRDFMDGdgmMd+xmrg/fJSYc
	m49ThRRyd8RIaoQlrCvmsYpatKVszd95ttXbTPu1FnNiDwPdB/hFD1jKCKNUrWjN
	HzXGdfnp3G6L+VG+izMdUkRIdSaTubnn65Dlw2zgOuW9iB3CV1oNnLsMXpp7O/9k
	Zw==
Received: (qmail 3848381 invoked from network); 6 Jul 2024 16:34:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 16:34:27 +0200
X-UD-Smtp-Session: l3s3148p1@udy5E5UcQJdQT+F6
Date: Sat, 6 Jul 2024 16:34:26 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: ks7010: Remove unneeded check in
 ks_wlan_get_range()
Message-ID: <ZolV8vtD4KKo-gg3@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
References: <20240705204434.10541-1-amishin@t-argos.ru>
 <ZolRoeaPETSmJMGJ@shikoro>
 <bf57e119-d957-484b-be23-ea43811f30e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HLurbxx7uv6xj442"
Content-Disposition: inline
In-Reply-To: <bf57e119-d957-484b-be23-ea43811f30e3@gmail.com>


--HLurbxx7uv6xj442
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Philipp,

> no the driver is not removed yet. Planned to do this on the next cycle. I

Ah, this is good to know!

> did remove two others and wanted to wait some time to see if any complains
> arise. I am a bit scared.

No worries, it is okay to be rather a tad too cautios than too careless
IMO.

> Please always consider: If you do not use the driver, it does not mean that
> anybody else is also not using it.

I am very well aware of that. However, hardware is super-rare (it was
even some years ago) and it doesn't support network encryptions we
really want users to use. Risk is low. And even in the unlikely case of
someone complaining, we can revert, right?

> But may be you are right. I am a bit slow and to hesitant.

I don't think removing it next cycle is "slow". But it is good, of
course, to let people know of your plans. Like a reply to my mail saying
"OK, let's remove it next cycle" would keep me in the loop. But no harm
done, I can also ask what the status is. Like I did now. All good.

> I plan to send deletion in 3 weeks.

Perfect. You can already add my

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you and happy hacking,

   Wolfram


--HLurbxx7uv6xj442
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaJVfIACgkQFA3kzBSg
KbYIzg//VWYJpFhB8j2a4YEBptlF5VgMeDqheO80Ox8M6wTD+4BYUgSSEVBP+0iO
bQtKP8VoQq7VqR/waLw26qhI8rwF9vHI4z2/fskDVjK8fh0GZdr3rHcRfCwCsNK3
qIGZX2Lc3ptEdOEjZqKsJRqYZUwFzD8HqR5VggtBIbn43x0G2SP9pXfb2RGGPW49
dGDzzbxz7/Sm2/NW07dhPXjq6zz1n75nPInvJZcLkHIKqnQLtdIBKUK0gtNNkuNj
Tepo8n7q7u+rzGJ9zT+jZJC6twH8kiuzbslQDKAd4KMRo3IdlnoCyoVTL+vdRnQi
7hiiWxRLqnj1hKHCKlWca/wjS3MVoM+bZ3+VISAj6rqW1zuwQqrWfSo3bA3FLIRw
Fd4HyDqZDcPuULF+tzGLwcIyCAfbq15kkn1cNypJsZkexxX6gcyhRe1zJ0hW3hmE
TKeOac5d41+ftVPhVTh4+fNQvfYa59V9WxylgEo0C+N/L+FfattWfiwc9zGzEvVS
hS2zzhbRXa4ywlwdjoyPP7nm9EMnpkartgxrzW811i6Z1LzwCnmXwb8EUUbUVYyI
cDh+QCC/YRgvWO803xg4OBsSAH04qd6bPdllPJd7SyQYyJ0Kjjm6L7I5QmaHABnq
2FCD4PTJtEvb40hcbjvcnjp58vz6x/zYMMqQKFey3rbrpNxo9Mw=
=Svpi
-----END PGP SIGNATURE-----

--HLurbxx7uv6xj442--

