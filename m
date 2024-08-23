Return-Path: <linux-kernel+bounces-298752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AAE95CB18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6391F21AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75503187342;
	Fri, 23 Aug 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m94urmNB"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D613D510;
	Fri, 23 Aug 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410638; cv=none; b=Vag8RcTzE6ruNdqOkznduRTJlGbCy2t2FtG2pUqxEGKUS8e65+XzOjUI3O5NtdUrPRDstweVgFP8aVB07U/aM0BrZeygt3wEpuB0w9GGapaXOJvJJ3EBbB1c6rirC2SS8ibKSn3BjLb9yNUd7dTONkom4PrKOYlN9kGY6eAjSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410638; c=relaxed/simple;
	bh=AFJ+PbAOlW5+cX2RPo8IOxs940SEAmEO+VHf0XucI94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5/REVDmLVlc1clf4t9bW33F2ZKggptam9ONClekN4s2HMVic5mzOg+AeAL1iYEJ79D9mA6Vsgxzoq+yeeF9XpnGQSQXZurJhbnFC5xqEZagDoESSKo9kMlRWTiHd2eOcOQsx1TNUN6SHP4DUemOc0BKPH+x791Mn7jD5ScBhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m94urmNB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso1322214a91.3;
        Fri, 23 Aug 2024 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724410637; x=1725015437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFJ+PbAOlW5+cX2RPo8IOxs940SEAmEO+VHf0XucI94=;
        b=m94urmNBck7tusVmhonJ4sVxI7okKZGnVNlRIqr411vow1h2lbx2wp+3N230HEvDpp
         SB312Us1U1M9UvKtEnbXA+AZ5s9L/Wb8lJvwaHxKSrUTmVeA1TB+Enl/Ltu4VE7MoAtF
         y/5SZ901pxqJmxLAgIFjnBWCu1ivffNNiuMhZAtpsgrbSMjK7aBN1NBljxUnThHu7PyA
         tLvIHwgg6rH+0xdylXhEX9dbrXo8aRsJr5JUxVVVDmgVogGs62EgjQ7hRdAuXsWqWYjJ
         zwXtsXW89SoGsArMDpQEkDB1XiyiSddnblpy0EG/hOr2ZPH0Iob3ZiXk9UBycIIEIfcv
         36dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410637; x=1725015437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFJ+PbAOlW5+cX2RPo8IOxs940SEAmEO+VHf0XucI94=;
        b=DvcbHJQteyauwSCwBDMwiAGugTiQ1B/w5rAhE+TMJCRdWjGQ2K9vsnB5Yp6UGYmgaT
         //QXfaJ77I6cQ3yfmSZASjlDMiMj8W4LYieaLIqKsxrGXzgjHW4gd7NGBxbxfj9TnkGq
         4p624hsOPEIJjkq8Zgd4LHNI8Md65ru4YWLzmIOhrLkHnNRHF2OFLgIiNHt8b6EZeRU6
         8oA6Fae0wkBKiAOXtiFiQHWnRkQb4y+eb//ZwW6rJ7lVibhYd1f9AVgL3PXsS+uQDlEX
         RWrdjo5vR6brMPf8L9BDzquYS6Ixucyb7zzMK0mHlamvVyNCdZBIZeMlJ51crehtVqgr
         tdYg==
X-Forwarded-Encrypted: i=1; AJvYcCW3tFKA2Jr7pSfoNUjE8YiquPZdZjetFCZhrjU4LQrxYHGSGgl/YUABU4cDJawYFqUFd7k2D7EMYzJ+tg8i@vger.kernel.org, AJvYcCWJlhN7HnpZZQXS/KoN/N3zC+rQfod0laHUsuDjm20EPiMRQGffkLJXBHi/KIJErY9hoHJtvRrfmJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMpBX0T3qdVwgdqBYP1OIOehOvTTwuU0NbOmEZpoCI1vJ/Ile
	FF0aT7jFjSlao+dcQ23pICWoOXvV1x6b4hxJFiM4qXUrOSlv/mpmzBcXlg==
X-Google-Smtp-Source: AGHT+IGl3wePyS9+OGGikNHLu/p+1yRw5d9LmfWZ14mZ/z74l1e5tcdEPyQb61VsUV86TxopAd1iaA==
X-Received: by 2002:a17:90a:be09:b0:2c9:6514:39ff with SMTP id 98e67ed59e1d1-2d646ceaf36mr1690163a91.33.1724410636480;
        Fri, 23 Aug 2024 03:57:16 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb007csm6002277a91.44.2024.08.23.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:57:15 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2E3FC4A97F1B; Fri, 23 Aug 2024 17:57:13 +0700 (WIB)
Date: Fri, 23 Aug 2024 17:57:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v3] docs: bug-bisect: rewrite to better match the other
 bisecting text
Message-ID: <ZshrCGhRc_GNTGQv@archie.me>
References: <74dc0137dcc3e2c05648e885a7bc31ffd39a0890.1724312119.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnGmfupdkIm6l7Y9"
Content-Disposition: inline
In-Reply-To: <74dc0137dcc3e2c05648e885a7bc31ffd39a0890.1724312119.git.linux@leemhuis.info>


--SnGmfupdkIm6l7Y9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 09:35:33AM +0200, Thorsten Leemhuis wrote:
> Rewrite the short document on bisecting kernel bugs. The new text
> improves .config handling, brings a mention of 'git bisect skip', and
> explains what to do after the bisection finished -- including trying a
> revert to verify the result. The rewrite at the same time removes the
> unrelated and outdated section on 'Devices not appearing' and replaces
> some sentences about bug reporting with a pointer to the document
> covering that topic in detail.
>=20
> This overall brings the approach close to the one in the recently added
> text Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
> As those two texts serve a similar purpose for different audiences,
> mention that document in the head of this one and outline when the
> other might be the better one to follow.

LGTM, thanks!

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--SnGmfupdkIm6l7Y9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZshrAgAKCRD2uYlJVVFO
o3SVAQCI9VX9gg2/YKIYtO6+SQ9ElGYMdtUeUmulCdxAWqkHpAD+NWWRsV7ZAOks
7IsyHJEzDeLWOXacfkwDebAK1d8ypgU=
=CPYs
-----END PGP SIGNATURE-----

--SnGmfupdkIm6l7Y9--

