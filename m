Return-Path: <linux-kernel+bounces-342234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B4C988C29
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D1C1C211E8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3818D625;
	Fri, 27 Sep 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pwGSuCWD"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD1176AAE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474380; cv=none; b=BnSCJ0k2OOjohGghSY9m+J/Kgip8U6pVs/vfIckUb7SrljPqbx+GLNwBgc0MpwKqZpo7l0cJPRb3qgSw5+UccJWJNMhB2kQgfkyTehrdXAni4sXPaE9QZY1JX1sPvP4SLiJsiE7ETP+14dTlniRQEcXizA9AhFYexXX+X/SdZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474380; c=relaxed/simple;
	bh=AcBbjKR7+nCFg5lYMNPv5E1ifH/cfMS599U+DMYi2ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abRMb9l4nm8fw9BVb2zBTThlmfEqpYN/yaTtRWPbV1G6yo3K0Ok9dtx1MFpadFMHx4eWM4Y888Lk/uKfgAaZooN9owjbPxnOD1Jc2cmd+pjIYpGTjUh043xoAwS4GQBYIFgnVMWBVs2uBgC/jr7smpCXEO9kcJ9RdmE0ePtV5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pwGSuCWD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37a33e55d01so1870055f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727474374; x=1728079174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujNPrqQuZgqp97PxMRD8wcDc7NXDUgQUUVz7p/Mv7oI=;
        b=pwGSuCWDDMVqvk0M5llBdIRIhnlyj8JS/oWizw46QTylEdgX5vqjAJoswEXf9K+pBG
         IVNB8s8fv1NF2Aa4kmwSE22D8wCjGomjiFzZko7h2KwuDVW6DbCXw9m/YEABxJVB9JC+
         i9QBZ8xU5BSSiRDYjhjy1ScZF0QwFG8SWL3x+jbjo7T8Pr2UA+FJn4Ps9X0FSt5B51zf
         y8xGRoDrFtdqKeThsuOQSBqSUReXnGF04cs4Up0Cksu85Gd98IHc0PWyn3j9lU5Jtp83
         EMd9FMN/QnyFlQd9oIESgiEheGssbSkEUdhyKNK1/Bye54lxpnEZdK0p1yb9ObE94K+s
         qCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727474374; x=1728079174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujNPrqQuZgqp97PxMRD8wcDc7NXDUgQUUVz7p/Mv7oI=;
        b=NOzP+vsSB7yyfuubjoCcNQy4gROCk59d+5+/CRbM7Oo4Q6Q+jxQdhw5hlxuW/4gPjN
         ZDXXk3PPV3HKiFbgE2llZ3v/dj6B1hwIduLrytsxPqcwqs7VJb2rwnB0gaL+ZgG6RWMQ
         yi+Kzy/DIsvlTiaBfT4i34xraSGGdbrNGploBRdpx9y4IEq+x8B7bkaP8McZr5TSCduy
         A4d7zJDcHtUXggaLzpI5dlODz3iY5zzJ2ERufFkCMBEcxfMomSo5YZokeAmL9pfud14R
         XqJ+XaQZu42fbHBqeQ7zlEpqFKdvpI2kl85L+zw8V0UKulKfrHpw8G+q3nYnqmmsscsH
         +O7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW93gfIEYYOHo9g1gHUk8CfEkdlh4ukwjiS4AqfUwkRHHpJfECcivQqRAnSUOKXc5zoLVoGOB+HJuLtGsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBt9A7iURO9PSoNo9YJqpW5WdE6hEJLF+rmXkvBQT21l+mwiA
	/0jfi3XtrsvVrg9rEVAwwtlipBb6XCHVCfigZ+OsWm6IH9/h4BSNvIR6ujIQuTY=
X-Google-Smtp-Source: AGHT+IFsLO/EVXcSJgg4cP/iMSiB3NUfmqxpsVm+M/7ZupVzloZwA2p7GZ03HxD+O+g5ApRpDqWo0Q==
X-Received: by 2002:adf:fc4d:0:b0:37c:ca11:c08d with SMTP id ffacd0b85a97d-37cd5a833c7mr2710110f8f.24.1727474374357;
        Fri, 27 Sep 2024 14:59:34 -0700 (PDT)
Received: from localhost (lfbn-nic-1-357-249.w90-116.abo.wanadoo.fr. [90.116.189.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e479sm3435125f8f.37.2024.09.27.14.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 14:59:33 -0700 (PDT)
Date: Fri, 27 Sep 2024 23:59:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Armin Wolf <W_Armin@gmx.de>, Guenter Roeck <linux@roeck-us.net>, 
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Error "ee1004 3-0050: probe with driver ee1004 failed with error
 -5" since 6.11
Message-ID: <sr6p4lwnlznee73t4jof537dcwdl6m6vxriwk3pk4dnlxyaih4@6wv52esrfpyq>
References: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
 <2024092616-showing-fragrance-f70a@gregkh>
 <D4H312REVAZ3.3JWUT4NMWDA7C@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="62okrw7b4etuddhf"
Content-Disposition: inline
In-Reply-To: <D4H312REVAZ3.3JWUT4NMWDA7C@cknow.org>


--62okrw7b4etuddhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Diederik,

On Fri, Sep 27, 2024 at 02:57:30PM +0200, Diederik de Haas wrote:
> On Thu Sep 26, 2024 at 2:44 PM CEST, Greg Kroah-Hartman wrote:
> > On Thu, Sep 26, 2024 at 02:35:05PM +0200, Diederik de Haas wrote:
> > > I updated an amd64 machine to (Debian's) 6.11 kernel and got this err=
or:
> > > ``ee1004 3-0050: probe with driver ee1004 failed with error -5``
> > >=20
> > > which I didn't get with 6.10.9.
> >
> > bisect would be great, thanks!
>=20
> I should've known I'd get this response ;-P
>=20
> $ git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # good: [6150e5e1ae2d8ad72f52217f8f41fe446cae9e27] eeprom: ee1004: Instan=
tiate jc42 devices for DIMMS implementing Rev.1 SPD
> git bisect good 6150e5e1ae2d8ad72f52217f8f41fe446cae9e27
> # status: waiting for bad commit, 1 good commit known
> # bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
> git bisect bad 8400291e289ee6b2bf9779ff1c83a291501f017b
> # good: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
> git bisect good 280e36f0d5b997173d014c07484c03a7f7750668
> # good: [f66b07c56119833b88bffa4ecaf9f983834675de] Merge tag 'vfio-v6.11-=
rc1' of https://github.com/awilliam/linux-vfio
> git bisect good f66b07c56119833b88bffa4ecaf9f983834675de
> # good: [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' =
of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good 2c9b3512402ed192d1f43f4531fb5da947e72bd0
> # good: [6dc2e98d5f1de162d1777aee97e59d75d70d07c5] s390: Remove protvirt =
and kvm config guards for uv code
> git bisect good 6dc2e98d5f1de162d1777aee97e59d75d70d07c5
> # bad: [c2a96b7f187fb6a455836d4a6e113947ff11de97] Merge tag 'driver-core-=
6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-co=
re
> git bisect bad c2a96b7f187fb6a455836d4a6e113947ff11de97
> # good: [786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48] Merge tag 'perf-tools-=
fixes-for-v6.11-2024-07-23' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/perf/perf-tools
> git bisect good 786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48
> # bad: [ad7b0b7b87bb19ea7ee71e165e597f5fbfac76ab] Merge tag 'soundwire-6.=
11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire
> git bisect bad ad7b0b7b87bb19ea7ee71e165e597f5fbfac76ab
> # good: [b8ec9dba02a74797421c52b1226b23a4302362a6] dt-bindings: fsl-qdma:=
 fix interrupts 'if' check logic
> git bisect good b8ec9dba02a74797421c52b1226b23a4302362a6
> # good: [7a3fad30fd8b4b5e370906b3c554f64026f56c2f] Merge tag 'random-6.11=
-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
> git bisect good 7a3fad30fd8b4b5e370906b3c554f64026f56c2f
> # good: [89cc1354d388ba8c8f8b41095736202a83591497] soundwire: amd: simpli=
fy return path in hw_params
> git bisect good 89cc1354d388ba8c8f8b41095736202a83591497
> # good: [13814ed162687be08e34762040cfc2e58831219d] soundwire: intel_ace2x=
: simplify return path in hw_params
> git bisect good 13814ed162687be08e34762040cfc2e58831219d
> # good: [b72d4af98cae2f74dc8061befcc3c0c2a174894f] soundwire: cadence: si=
mplify with cleanup.h
> git bisect good b72d4af98cae2f74dc8061befcc3c0c2a174894f
> # good: [fdd3d14ca3c8c5269174f10d33d6181173cbd0b4] soundwire: debugfs: si=
mplify with cleanup.h
> git bisect good fdd3d14ca3c8c5269174f10d33d6181173cbd0b4
> # bad: [7a46b17d4c00c2547b5bd82eec9489b19128fd65] Merge tag 'dmaengine-6.=
11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
> git bisect bad 7a46b17d4c00c2547b5bd82eec9489b19128fd65
> # first bad commit: [7a46b17d4c00c2547b5bd82eec9489b19128fd65] Merge tag =
'dmaengine-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul=
/dmaengine

The following is completely generic. Note I didn't try to to understand
the problem, just giving some hint how to further improve the bisection
result.

If the first bad commit is a merge that isn't usually very helpful. It
just means that either the merge is broken (I guess that's unlikely) or
one commit on the left side of the merge has a problem with one on the
right side.

To identify the two conflicting commits you can do the following:

	badmerge=3D7a46b17d4c00c2547b5bd82eec9489b19128fd65
	base=3D$(git merge-base ${badmerge}^ ${badmerge}^2)
	git bisect start ${badmerge}^ ${base}

and then to test a commit that git-bisect asks you to judge, do:

	git merge --no-commit ${badmerge}^2
	build_and_test
	git reset --hard
	git bisect $good_or_bad

The resulting bad commit is the problematic on the left side (i.e. in
${base}..${badmerge}^). To then find the problematic on the right side,
start a new bisection:

	git bisect start ${badmerge}^2 ${base}

and to test these do:

	git merge --no-commit ${bad_commit_on_left_side}
	build_and_test
	git reset --hard
	git bisect $good_or_bad

The first bad there is then the conflicting commit on the right side
(i.e. in ${base}..${badmerge}^2).

Also finding the commit that fixes the issue would be possible, for that
I'd suggest

	git bisect start --term-new=3Dfixed --term-old=3Dbroken v6.11-rc1 075dbe9f=
6e3c

and then after testing the suggested commits use either

	git bisect fixed

(if the problem didn't occur); or

	git bisect broken

(if the problem is still unfixed in the commit to test).

Best regards
Uwe

--62okrw7b4etuddhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb3Kr8ACgkQj4D7WH0S
/k4PnQf8DW+aDkMth13RR2spoF6UwskGtg7aZPyYDDtP+mh+tLAqNfUZwzNdDf21
EzdSluyNpak5VnqNCnYY5eVwGWZPnQ7sYzW5qzYe7ySM/6J4xrirmW4En5V+pouj
X21y/P3JByV12oX1PhWlaoiVcQn2DLog10+9zMMTdZr1ewq8kV1lqJpfmyFmdVoA
sDNbUsV1zxCpQ1/x3S0cYE+WDu1Kk7hEQApm3/7gMoH//fnigG0+yEwoJ89vkeJe
C9gb0lMUKcsWtn+YRk8C2Zh7bcipiblHwa1AhIHgw/78sC596pHGANDHHz4ZgdHe
6XcoJ+Lrh6bAXXJUQbv8ZrfMMOEwkw==
=dbde
-----END PGP SIGNATURE-----

--62okrw7b4etuddhf--

