Return-Path: <linux-kernel+bounces-387998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51619B5903
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1971F24079
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502E13774B;
	Wed, 30 Oct 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+SQ0k33"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D64D8A7;
	Wed, 30 Oct 2024 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251083; cv=none; b=DyBSB/dH23Aa9rJpq2ssGO5aDqbKL7On2SDwmbgAAQCtTGEXlHaOSsNoNHsVDTGI7DikplyKod58psw2NViPSogar9ZYBieeuJr5kIYyBD/KonFWnTdxiEcAiX1sZ80TvF/6WqHHwo3z4oWQ6rfKac8uuW1pHoNQ3dOkzXXWHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251083; c=relaxed/simple;
	bh=VQlsyBu2m+OQ4SIuZU1uLVhiMXfETFlqfCNEIOs9+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e04VIjQR2zVKTJzQl2qRy88TwWVqF2XNlkNrj/WVCkfVPQg8H6nv40Rl47HlMZhUP54LGrm7qQ5oIsvj2OnefwBBBp0X/mhtB1dawmIp+z6q0vWxnGvfPMV+P1xGZ8hBScJH+u2cdJezCGGL15emhWOv9rLu5yZ4uskyF8cjuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+SQ0k33; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8b557f91so57621075ad.2;
        Tue, 29 Oct 2024 18:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730251081; x=1730855881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQlsyBu2m+OQ4SIuZU1uLVhiMXfETFlqfCNEIOs9+Ck=;
        b=F+SQ0k33BuAxwdXR4UY8rqKbK5UwEeyMEKV1quGyJMkOYT2KLq1vJ6ZOo6KPeZ1Xca
         pMLQz+1LsT4mvUl2p6I5Rzd6xWJEk+rYWWcGceYPn/ITt1zqsY05bwMAyKcHid9lFuHz
         xd+eYyv/UEEXSa+lIKVJLi7QHUTyg+2cKBcIiiz6Kps+1uNgvh6Xhd+cWFNVGnvzl9M3
         41qas4gho/AALCJ71jwLXB3gqujKlTBEna993lA6xq8MW6HnOgyVFNHDhCqbYDwlnPG6
         j5smXl89KiI426AIjBkmV9Xo9ZeAgcKr3B/EWUPwy7p+1JRAAMI8iaiRwd56pPg+JSfJ
         +vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730251081; x=1730855881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQlsyBu2m+OQ4SIuZU1uLVhiMXfETFlqfCNEIOs9+Ck=;
        b=UhPpLzcSxloeyUy90F4+vQGuz6uEad631eKlkhrwNJ/7G8+th4kWD+MROT1pNXr/26
         mLLJcybAhLVp20epXMQK6Ga9kXcdP+TYxpCscxGdgzxl4qWgLdGU7dJWdDMRuFzZbs58
         xDYD1yj3SAahmzYd2F4D1pewlmE5f3vm2Qrk9dbI3kdB+6obIbD0F58I36EUMvAix/p/
         tgbbJbtXS5Ke77qnj1V/QVM+vPkzUrNv4P/YoVzBjR9jiVY5lgK3gWglDsFTRelBwNe+
         u56UWFRhsluT1X7Hr+n417hJeUAPMzE9SoT9xZOm3YhQppQ1nSM9EVKAkp8mxOt8L/Eq
         tN0w==
X-Forwarded-Encrypted: i=1; AJvYcCVIkc30XphJvKqjEljm2UhSzPAJKSYAXVhwxaI7lqQfB55KplW3DjpotWkvlLfqWeSbmpXglO6Rn4xOP57z@vger.kernel.org, AJvYcCXR57UF8PHTn+WjR2J2AnAf5H93ogTO1+NgPr8tve1KPEwkdkOxE7wvlcwSR8jm986qusCBObzv4o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FgBUELCvvmKsGNqiFBgYBavXF1tPKZj7WLJC7vXcDgAkp6L2
	AzesQuR4sN5QiBFHncCgF7/NxQS5Rfw4cO+54TliZTWsyuJi+B+epvxhZw==
X-Google-Smtp-Source: AGHT+IGKTRSqsJ0MiMYMBIJKygewuzcUiHJ6sNuL9T8wb1im6iB1GVygXcK6NmkF7n7qUXrbMjFp9g==
X-Received: by 2002:a17:903:189:b0:20f:c225:f28c with SMTP id d9443c01a7336-210c6c9417amr169037735ad.52.1730251081108;
        Tue, 29 Oct 2024 18:18:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210f7ee5e1asm3767575ad.306.2024.10.29.18.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:18:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8498549270BF; Wed, 30 Oct 2024 08:17:57 +0700 (WIB)
Date: Wed, 30 Oct 2024 08:17:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>
Cc: jassisinghbrar@gmail.com, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mailbox: Documentation: add the latest documentation
Message-ID: <ZyGJRaymzim0KoyE@archie.me>
References: <20241019195534.79603-1-yesanishhere@gmail.com>
 <20241019195534.79603-2-yesanishhere@gmail.com>
 <ZxsSvbXXiwNAHCWX@archie.me>
 <CABCoZhB62CKhCnZTCgTAhEh27td4Gw6XjJ-uYQJRqJuN9NPqmw@mail.gmail.com>
 <CABCoZhDUajW-L6LdbwDHcHcNcQGSRbzO=bqyOZfMwjoeCb+p2w@mail.gmail.com>
 <83df1d71-dfbc-49c9-a6e6-05454cac2ca7@gmail.com>
 <CABCoZhBvcqgqaky1YyrLKHBQDFNc4F6-PJwZQOuCoLiD-D4gBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxhadpv9Oj3Jf94v"
Content-Disposition: inline
In-Reply-To: <CABCoZhBvcqgqaky1YyrLKHBQDFNc4F6-PJwZQOuCoLiD-D4gBA@mail.gmail.com>


--uxhadpv9Oj3Jf94v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 05:42:32PM -0700, anish kumar wrote:
> On Tue, Oct 29, 2024 at 4:51=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > On 10/30/24 01:06, anish kumar wrote:
> > > Hello Jassi,
> > >
> > > Gentle reminder for the review.
> > >
> >
> > Reroll.
>=20
> Waiting for him to provide any additional comments otherwise
> I will have to upload a new rev after that.
> >

IMO you can reroll anyway with my review suggestions applied.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--uxhadpv9Oj3Jf94v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyGJQQAKCRD2uYlJVVFO
o7z/AQC+jgvRMI14c7I++uUp5yXxIMAKhgv1m0IOMwj4X63bOQD8DTRJnoPEGCNc
qWmrlo1ZOOdTPxQegerScjpCJ/09mgY=
=ZdR+
-----END PGP SIGNATURE-----

--uxhadpv9Oj3Jf94v--

