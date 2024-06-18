Return-Path: <linux-kernel+bounces-218933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 175DF90C7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FC91F27739
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A901CCCC6;
	Tue, 18 Jun 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BUJHHirW"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E01156C5E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702683; cv=none; b=dmkfl+ZXnK4ztRxYLQSOnaYlAfCPE6Jpp/jsxoFLKtV4aKnDmqywe6ffBxRTKf8T5krGEfDWcgPys1dCQJcKyUCynwxspcAwb/DTeqxjSIqULQCJiVdGabih5QTXzQ0SNiyvxGkb77KiaMINIHwW4TxdV9gAp27Z9VFr1ayRVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702683; c=relaxed/simple;
	bh=oBJwerAihFYiplkEDzlGI1NDEwEfHJ3sX6U0aolqAv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2TJmReAAyE/f3h3wDlbuT4veo9xnCkoi815IxLaDYAPeYqX9yANajlBhAB+gCTtiTvIxDqOvLAFnlhlqmJj8N/r2+GkP4p05EWW/um6POrjJIoMabwk9iEHJgbZOZXcG6raTx8G1Cy7nRdgPZ/lvh56IC/o+pGWxHGznEMX0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BUJHHirW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VQpx
	P2j7aKgW/u+/PViY3voxvgTT7XjaQRA3NCsZMak=; b=BUJHHirW8eldpUEAnkzk
	klCXLCQye+1K1ywWP+hLzKWoXI/XrCjdGAhMIPL/DSaqOXUZx1ToWed/X+/r4gpD
	TNwgVnYOrcJYLYIWrMAcHxPR7tCuUy2EGjT+muDOsul9cnChE+qEI2LJfGtbusCk
	prDhWgMlnpQ7y7vlijiRemTUgdpv+qjcYXK2TU4/1FuRj9Oeblj1BZQIn9wABoyv
	e8RG5KjJN9xLjrUO+qNsqOi62jkLh/AGFvyidh606Bl/ClX1u+SZzIlXqzdgiJI8
	CsKCOUknnCPb9mNy8A2ABS5DUVh2mKWnOHKidD0OKOXmP2Z6FlLwev/3z11Fs3Hp
	cg==
Received: (qmail 172898 invoked from network); 18 Jun 2024 11:23:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Jun 2024 11:23:07 +0200
X-UD-Smtp-Session: l3s3148p1@FScyoSYb/K8gAwDPXzjQABqqX1QYyOSW
Date: Tue, 18 Jun 2024 11:23:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kent Gibson <warthog618@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v9 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <3h63msxchuuxqa5liufoivss4raqtzjlusjn7ufti5nyjkshcb@pqevlpuvrm5q>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kent Gibson <warthog618@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20240610112700.80819-1-wsa+renesas@sang-engineering.com>
 <20240610112700.80819-2-wsa+renesas@sang-engineering.com>
 <CAMRc=MfZ11U+kAh1+K=DxtJ=QL+cY7Q_sBN4sQDF-RNgjpV0QA@mail.gmail.com>
 <jvnvx7a4pn6evrp5ehfrt4qsiuprq6ogvrue2a3uupwtydmgcm@2rvat7ibvgb4>
 <CAMRc=Mc4__0zzJZG3BPnmbua88SLuEbX=Wk=EZnKH5HQvB+JPg@mail.gmail.com>
 <CACRpkda==5S75Bw6F3ZLUmf7kwgi_JkByiizR=m-61nrMDWuvQ@mail.gmail.com>
 <ce1d8150-c595-44d5-b19a-040920481709@app.fastmail.com>
 <CAMRc=McpRjQO8mUrOA4bU_YqO8Tc9-Ujytfy1fcjGUEgH9NW0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5cmtaneuum5rgbom"
Content-Disposition: inline
In-Reply-To: <CAMRc=McpRjQO8mUrOA4bU_YqO8Tc9-Ujytfy1fcjGUEgH9NW0A@mail.gmail.com>


--5cmtaneuum5rgbom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bart,

> I could see it using configfs instead of DT for configuration and iio
> for presenting the output but - from what Wolfram said - insisting on
> this will simply result in this development being dropped entirely.

How do you assign a GPIO via debugfs? I only found the out-of-tree
pwm-gpio driver[1] which uses a GPIO number. But those are deprecated
these days, or? Any other driver doing this you can point me to?

Thanks and happy hacking,

   Wolfram

[1] https://lore.kernel.org/lkml/1301630392-20793-3-git-send-email-bgat@billgatliff.com/raw

--5cmtaneuum5rgbom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZxUfYACgkQFA3kzBSg
KbY9Gg/+J/laSTd6tafduUFC22pYQqluCmSo74Bd5De8pRLvrN0lFqK9aMOn/o/h
jFuQVn/nGxfyPLo7jgyi29Q69EDcgbl/hPtWCMGvZNseyGWGtkoSyMBq8KzZOkiZ
u1moGsYXsgfu/0CJvSzROWXf+pKTR0olr2+qMOmqINhLpH0tuWBHhhrtqvhDc2/Z
Kdl8YQOjAOKKIDJBaD67pFFaLCPxAlebnzHh4hb5i65GgfCPLaHhT0TW/tM6J346
FdOrNgWjRmXEjxuLQNRLGhU32wHDJKSE3NxWAScyaWxMiT3DtMvCOpjT0Pyqf0oG
Gy2vom6A7C0LDoyRrrTEliKwwZ+IPtKxHXYjdFwkR5VBoj2Ko9RnogWhCdH2qO4g
LF2nSEvBAXWNKFyJe0QdKFweIhyn96VbbwwVgt/QjSdfH06NDv0WcQ6Ny33vABE5
GNngraGwSWmzWFMuz/s5qWy0G7j8Bod7OwJKHsK6Exkac1HcP1a8EPL1bz5MKM1e
DAlffBHQYJo/Gg+tb8HfQPeWZeiAFK7ZpjGhooGgwgSRvP6s5GQHvW1PMeKvjMAf
GjEtSCWVICJZcEWlGtyAOh1YJh5xoPh3TeEUEphHm+18lEZJ6O6Q/tn4bMLoX9A5
U/iHHLHhD9vC2zI43v0EdQG6geQYBkwY3qgN1AjjtpMqlHjh1XE=
=xoXQ
-----END PGP SIGNATURE-----

--5cmtaneuum5rgbom--

