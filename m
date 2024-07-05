Return-Path: <linux-kernel+bounces-242610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B19928A69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985971F2195B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926DD16849C;
	Fri,  5 Jul 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYc8dwE1"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD714A62E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188746; cv=none; b=FEt3v148ULv/E24ta5qrO5cUcHHqQrK6ZMpnOxe7H5wMvgFAUqpYwcYvyujY/4TixEUSwUuGnplzwZKKQkX+ri5IrLVhBq0817UIb+pRj1sok66smc9XE943lOpQj5sjq6gGIo70ucsx9zMMJaBYSIEayEIUDQUIyaAvGG6rMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188746; c=relaxed/simple;
	bh=WrBpKZUzM/PuF25bkJRwyRZ6byq5uI6ZLz1IMtJ2s3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQKUp20pcKxmyJEl6Acsl9L8ywa1ktmnwhlEfSt5ugKNmj/ko90QGSolBeaRIqGl2oG32YCWYNXIk0V2hyWR4Ay2BvdqEJNI3qJ3KeYXtr7zmk8wMbu2qi8KTtuHmPhsLS/wOzBsFv9MMk7FRxwLlRdpK9pUFnIuFJ1cb6ZQspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYc8dwE1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b9776123a3so754265eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720188743; x=1720793543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=erzT8JVj8YvnAg4Qc+LLheapFug5xGemKR1FDnv/obg=;
        b=aYc8dwE1H5PgSoNVjp01sZfyzhMkTr20xDhfJWleWcL3bObCWgLrau19siUFmhx/tR
         lJkbFCVSpVnZ4T3DdjygbSPhgvqx8eOpRbUp6c4kWZHknDiJatHEVPWh2ZUnSYgxx8Zj
         LK3MIRy9oww9ID09OIf8/aaIeyybk1rwQiPB6klm0AOdSTh6+0WVK5HU9OaZXQNZgA/u
         Z5V32x7TO+rone+tpyWqLVsRugMzE3ikbwqwv+/jFw/ZBegYDNtbYSgg8CT+rtXjrY8d
         nbQWh8EWXq5UwWDH6hxTREE10KQapTLh/038TYSQihGDid63GaKoYfm04bBtxc/NnbCo
         51kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188743; x=1720793543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erzT8JVj8YvnAg4Qc+LLheapFug5xGemKR1FDnv/obg=;
        b=sfhoiUV4ZLNPp5HioaQdG/erp6WROM0fZW1nmWEBbNMdnsGe4A3HtpRkwLISIfWQNX
         EFBL35xjTVwmgKLsbe++FOfohNs3E43p3+4NUyqYtJWC9nOK0gUyNXDpXqXUngT1gm8f
         ptTKy8ek0dg1xoj+Y1fHvOibAVQ4IJf26cD5QHsD4On4lW5FSAbY3u8CG7++N62CVO9L
         V2lz8UbtXOIIjd0ZjwkUNJuIehuRmkMlAjhszPon7oEXz2M4kLggBetIuaI2AbomkVuE
         jAp9viOJTCIT9VD/K9PjxaNWO7msTwfa73njSFyl6Khzv0XZXqoNOfDBtSzDjdlZGlOF
         FusA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Kv+aW6cugB7237fI48fqfh9/MHi1w7LfMcSHhYIvOwcx99/X/4uWbOTsA0Iv7fR19rlUywSUeHq918Ja2aC7bXf4dPbOi/LSK7yD
X-Gm-Message-State: AOJu0YxbDg0PptBqb8sJITxZFieaN5vBg1BP8KoQ+dKQerjN5MJXZGBS
	35NeJgHXgXxWj/NJtZju5IOEhn+xEn2S1TWIdNluH3pnz8NsAJfK
X-Google-Smtp-Source: AGHT+IFqVB0AACA1ug7lMJROoBflELsykp5Zjo7q0CHatZVr9KWYNEZbahxWrSP4rJl+BcMLoFXXdw==
X-Received: by 2002:a05:6358:9494:b0:1a6:b005:2acb with SMTP id e5c5f4694b2df-1aa98a2f940mr416594155d.0.1720188743106;
        Fri, 05 Jul 2024 07:12:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044adb16sm14518482b3a.171.2024.07.05.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:12:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 89C6A185D7BCC; Fri, 05 Jul 2024 21:12:19 +0700 (WIB)
Date: Fri, 5 Jul 2024 21:12:19 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, David Polakovic <email@dpolakovic.space>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: proposition for fixing Y292B bug
Message-ID: <Zof_Q27WLYu-b1Sc@archie.me>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
 <ZoJx5GaBDHg7nayw@archie.me>
 <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
 <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
 <20240704174917.GB973460@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovKb/ULBbS7EEMhq"
Content-Disposition: inline
In-Reply-To: <20240704174917.GB973460@mit.edu>


--ovKb/ULBbS7EEMhq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:49:17PM -0400, Theodore Ts'o wrote:
> On Wed, Jul 03, 2024 at 05:29:58PM +0200, David Polakovic wrote:
> >=20
> > I am not sure if I don't understand your solution, but extending the
> > memory designation from 64 to 128 bits, is another temporary
> > solution, which will again overflow one day.
> >=20
> > The sole reason why I was proposing the new "BigInt" type was to
> > store each digit of the time_c as separate element of array, which
> > could be resized (added one digit) as needed. The only limit would
> > then be the physical amount of memory in the machine.
>=20
> You state that you're not experienced enough to be able to send "a
> merge request".  Fair enough; you also apparently don't know that
> github merges is not how kernel patches are submitted, reviewed, and
> integrated.

tl;dr: Documentation/process/submitting-patches.rst.

>=20
> What you apparently don't appreciate it is that performance is
> something that is critically important for the Linux kernel, and using
> multiple precision integers is not really compatible with the best and
> highest performance.  Computer Science is an engineering discipline,
> and it's all about tradeoffs.  You could enginere a plane that can
> travel faster than the speed of sound, but if that compromises fuel
> efficiency and annoying people who are below its flight path, pursuing
> speed at all costs is not going to lead to commercial success.
> (Exhibit 1: The Concorde).
>=20
> Similarly, trying to make sure that software will work in the year 292
> Billion AD might not be all something that most people would consider
> high priority.  After all, it's.... unlikely... that the x86_64
> architecture will still be what we will be using 290 billion years
> from now.  So if we need recompile the kernel sometime in the next 100
> billion years for some new CPU architecture, and if it's unlikely that
> hard drives brought brand new are likely to be still in operation a
> decade or two from now --- there is plenty of time to evolve the
> on-disk format before a billion years go by, let alone 100 billion or
> 200 billion years.

That was what I thought when I first read this thread (good CS principle
but questionable from engineering perspective).

>=20
> Finally, kernel development is driven by people who are willing to do
> the work.  If you want to demonstrate that it's possible to use MP
> integer mathematicswithout horribly comprmising performance, then you
> need to do the work.  (BTW, if you don't know what the term "cache
> line" means, then I encourage that you understand that first.)  But
> dropping a pointer to a blog post and expecting that people to do your
> homework for you is not really realistic.

Oh, I missed that "DIY" nature.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ovKb/ULBbS7EEMhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZof/PQAKCRD2uYlJVVFO
oweCAQDSCmO1EUVhziDTENqeEGG2pF68icNKgbnPJN3lUgMaHwD7BmTIaFbTvVLC
2PKAuvz/rKMPekVqomoV9Xu2M3zAMgY=
=2LFz
-----END PGP SIGNATURE-----

--ovKb/ULBbS7EEMhq--

