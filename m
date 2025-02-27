Return-Path: <linux-kernel+bounces-535802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F4A47763
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7B116A5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6A2222BC;
	Thu, 27 Feb 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBS9X1Mo"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679D129A78;
	Thu, 27 Feb 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644020; cv=none; b=XFPZ8Idi2cw99v4gSrasCpW/BM0RnPy1MFHzvrVMU3VJc8BhW72RNs3yepnTFuq6Xx4YsNhyGDG4E2tmKalctMs/xs39MK0FpK4jMdArsYTgm1hA5Az49rI5C4kVtSyWVdbYfYBL5nbfZdPJzm71vAw6mr7Sww3e7O9dMh2dfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644020; c=relaxed/simple;
	bh=AmnBVvnh8C67c5l9hxQtWMZ/5qDnilrZyInjSgp51LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt06CKKpExx8izWeWfNCsUkTszrd7hzQO+GPmLjbQPOsY5cKWo6kw+1IE3Kd/LQYmHAJkUAxtgtnJf363bJwdMgsvzWXhRmUKU9ulul1VxX7b2ikuJCfg3ZzfWinFiPLHHc2GJdYuuaK01eYub3C/tqlpUbYKYiYDT/iu0zufqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBS9X1Mo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2230c74c8b6so18313535ad.0;
        Thu, 27 Feb 2025 00:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740644018; x=1741248818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+UdhLX5paXiehBZa/sRHBHLgHngosJoW+1gT+f3EvA=;
        b=EBS9X1MozdyqdnaPgYf5A3yJJpvJCG2LkNUchmfifB6HKdYQ6kEJq4iSbAJaksCcEi
         eunQ48rR/NIudUveCiGPKJj4mxC+FXqYk0pTRDvbK13alF9myQs1C1riTvQ0+dsAMCFt
         BxmwWUvVOVfsBr6QazuCqoKAwT6R/xrGYolOIp58S5+AwIfRqQW8fIDoaXAaWfcRsH+e
         Rzy45rHCLLPokAiQ79uJZad8RaBaVbHHyOlDav+FLewaT/LL3ueEyFZU2RaWpbCJPHSw
         nt0r4ZCxHTOBvD8kG2Am7L03zBKcCDXa8DeG7Q2WZfVgKsvqMftjPcj/qrQ82dtZ5nBR
         /IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740644018; x=1741248818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+UdhLX5paXiehBZa/sRHBHLgHngosJoW+1gT+f3EvA=;
        b=DuMO440kADXi/AY9WD0X6yCrcDCpY3OBxZrpCoupsiY8Noa+Y1l8KjaJsJQCeM5LND
         7NrGrNAYO5hlqJ/vsqskHDighAZ2MVmNvPoeWThdyohw1mQ6iOJi/Am4Cbrwg+k614CS
         jmlYMz+ALoIuDKvVHsiqRiMdZN4njyEpCxv6ie5JjhZlNxyXAYmsUQtD7ngAhLutWU7+
         n9L/IpiNWBHzqX76sMcUE4ygXmQibbsusdAbN8westWNloAdEpGn6BWdfGxFDJ5Ojb14
         F7JiWYowd4IrXY/Nkd866kWf2iDsnCbBtEKOQ3sOcfYN2PylGsZpQvw+qiLuU1yQocba
         cpLA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+VT+9ZK0+xGfvvQlHBE9QvtdUVD2G1UKySovFbLQO/G/QbUElYAKXeLCRxvI04U5i0x0W8bPWbE=@vger.kernel.org, AJvYcCWZrs4vtuTgM6RN1x8ST/ej99Jn4GcIM4+sPaqfRVwDd9ZIlHPNlYP/E1oCRWc+uM/+HEmrsrts1uIcqf/z@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGi/IyWAkL282RZfbMs0r4/m33omRKwiG0kbgYYD+eNYikk4y
	1lhtBXUOlDRzzaD9FQzwQOXzgM2p9+quj7NB+idUCm2+zx3eqLIv
X-Gm-Gg: ASbGncscVd2uzYA5NPFnMDplVwIxYDCMFhFb1jCiuqCpgJ6j97ShEzcUGCIBIgADNNv
	7cHMqfp63LppmtheSU2l1t2tMiUBXafyUWBaD/UFoSTUBu8fOcESS2BdQHcY2nsJ/0dw9/DKD24
	DWJgFRjWjR2G5yq8fgg+Fn7THhdFLMe1r7bvDZZRAfODZFZZRxp6LhgUQnQiqwxoyzcgOVD7wOP
	GgFEgUWLvRzgixAIFddq5NrlDwXBVcGrqdnVNhOkiWB2j9N896uclV2hOMLu6ZizrENImOtpko5
	yU6gBGMq9cuuLr3rk6g9Kau0Sg==
X-Google-Smtp-Source: AGHT+IF/62n7MmUIT5nHTEc7MOcCiCtg4Z/YJ0aXtpjLcLtyvf/33uf+qNWgBwZaEOcS1tr7UAGK4Q==
X-Received: by 2002:a17:903:2f88:b0:21f:3abc:b9e8 with SMTP id d9443c01a7336-22307e70152mr175240135ad.43.1740644018153;
        Thu, 27 Feb 2025 00:13:38 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2888sm8835445ad.40.2025.02.27.00.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:13:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1C38741296D8; Thu, 27 Feb 2025 15:13:32 +0700 (WIB)
Date: Thu, 27 Feb 2025 15:13:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jelle van der Waa <jvanderw@redhat.com>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James Addison <jay@jp-hosting.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [v2 1/1] docs: Disambiguate a pair of rST labels
Message-ID: <Z8Aeqxnpznvvt_LM@archie.me>
References: <CALDQ5NyCpKKgoaphoV+aM+s6U7Y=iA-umO9LfuUXAM0oi=x5XA@mail.gmail.com>
 <20250226203516.334067-2-jvanderw@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C6GxSTn/Hq4CKA7k"
Content-Disposition: inline
In-Reply-To: <20250226203516.334067-2-jvanderw@redhat.com>


--C6GxSTn/Hq4CKA7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc'ing Thorsten and Jon]

On Wed, Feb 26, 2025 at 09:34:51PM +0100, Jelle van der Waa wrote:
> From: James Addison <jay@jp-hosting.net>
>=20
> According to the reStructuredText documentation, internal hyperlink
> targets[1] are intended to resolve within the current document.
>=20
> Sphinx has a bug that causes internal hyperlinks declared with
> duplicate names to resolve nondeterministically, producing incorrect
> documentation. Sphinx does not yet emit a warning when these
> duplicate target names are declared.
>=20
> To improve the reproducibility and correctness of the HTML
> documentation, disambiguate two labels both previously titled
> "submit_improvements".

On docs.kernel.org, I click "described above" link on quickly build kernel
guide [1] which takes me to bisection guide instead [2]. Now with this
patch, the same link now points to suggestions and improvements on the
same page.

[1]: https://docs.kernel.org/admin-guide/quickly-build-trimmed-linux.html
[2]: https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions=
=2Ehtml#submit-improvements

>=20
> [1] - https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#=
hyperlink-targets
>=20
> Link: https://github.com/sphinx-doc/sphinx/issues/13383
> Signed-off-by: James Addison <jay@jp-hosting.net>
>=20
> ---
> V1 -> V2: re-send using different email client
> ---
>  Documentation/admin-guide/quickly-build-trimmed-linux.rst     | 4 ++--
>  .../admin-guide/verify-bugs-and-bisect-regressions.rst        | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/quickly-build-trimmed-linux.rst b/=
Documentation/admin-guide/quickly-build-trimmed-linux.rst
> index 07cfd8863b46..2d1b6f7504c1 100644
> --- a/Documentation/admin-guide/quickly-build-trimmed-linux.rst
> +++ b/Documentation/admin-guide/quickly-build-trimmed-linux.rst
> @@ -347,7 +347,7 @@ again.
> =20
>     [:ref:`details<uninstall>`]
> =20
> -.. _submit_improvements:
> +.. _submit_trimmed_build_improvements:
> =20
>  Did you run into trouble following any of the above steps that is not cl=
eared up
>  by the reference section below? Or do you have ideas how to improve the =
text?
> @@ -1070,7 +1070,7 @@ complicated, and harder to follow.
> =20
>  That being said: this of course is a balancing act. Hence, if you think =
an
>  additional use-case is worth describing, suggest it to the maintainers o=
f this
> -document, as :ref:`described above <submit_improvements>`.
> +document, as :ref:`described above <submit_trimmed_build_improvements>`.
> =20
> =20
>  ..
> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions=
=2Erst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> index 03c55151346c..1b246d8a8afb 100644
> --- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> @@ -267,7 +267,7 @@ culprit might be known already. For further details o=
n what actually qualifies
>  as a regression check out Documentation/admin-guide/reporting-regression=
s.rst.
> =20
>  If you run into any problems while following this guide or have ideas ho=
w to
> -improve it, :ref:`please let the kernel developers know <submit_improvem=
ents>`.
> +improve it, :ref:`please let the kernel developers know <submit_regressi=
on_tracing_improvements>`.
> =20
>  .. _introprep_bissbs:
> =20
> @@ -1055,7 +1055,7 @@ follow these instructions.
> =20
>  [:ref:`details <introoptional_bisref>`]
> =20
> -.. _submit_improvements:
> +.. _submit_regression_tracing_improvements:
> =20
>  Conclusion
>  ----------

The patch itself looks good.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--C6GxSTn/Hq4CKA7k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ8AeqwAKCRD2uYlJVVFO
o32tAP4pCbQDdCa/o+CYcFm5dWmlmImW8BlewiKtrpwzT0dbewD/Ur/y2vj8wc/7
LFfgl8SPy2qG6MB5zWwyAbatcaMb4g4=
=MgTn
-----END PGP SIGNATURE-----

--C6GxSTn/Hq4CKA7k--

