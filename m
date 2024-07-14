Return-Path: <linux-kernel+bounces-251958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D43930C32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A81281547
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3813C3E4;
	Sun, 14 Jul 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoVjL21j"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A428FA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721000724; cv=none; b=KTFy83qpNVwaGklBxsrBGh0bTpDMIUN7r/rbo1EkmRbfjb9q0K+KkjU3ztW9sDOw6iWJIMGSd2K+UtCz4df8GWxQ83oRpDLKMbqJLo+VkDnh2Icg0jax8qSS08tAb1zn1EbvFnl45t9CG7NespqGV04SuJwUwBlHZ0Y2uxfve1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721000724; c=relaxed/simple;
	bh=qbEVLcdNA/ojJObzbhf+UBqp9Yp00nZSE7RfmNrGYrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eid3iByu3oBJ5TqHoyx2cUKSVS5PIMD/8Fu+EOtPZOVuufvSG32CVQqarEvMhm2mqgnQGEZS2bZAbyVQg94RLojRUBVOaeNRhG0syyTiK6XP0xFyqh6wZ1GLeEXsD+YZoVnVGCT29lJIXFZAz2P9au5i8S0C2oXjj4Me43izhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoVjL21j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-75cda3719efso2030679a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721000722; x=1721605522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fisAkwN1BJScZi7vZMFYgCkfLuep5MQCZJRyr7mxhM=;
        b=HoVjL21jPJLPhD1QyFWnxaKmXmYP07QSM2iXalFPApBxnxeoVyj7/mV+Zjd9yshP17
         LDY0NWDQMIBHuBWdpBz422C4OZ/WsAWybGV5Q9llxA2GbELMbGa684ULICYEE0gWeziw
         z4iNFg1N1topFbWdXMFJVfDVsbCbOXftQa+fRuUrwWJWvfTDWICx65MYGktP1BS1fycB
         mzCxRTh1gch1WZvVMnPMaD0twij0yn/sp/2zp4MH3dBVOkBkEXiDVTUZjvEP4gtNr4Z1
         2sGOPKQlU4oJF51yKQXbUVToMBtrlGd9rFdVE+aeZi5Pg2XJblV48ptXmwy3dB0lY8Sj
         9gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721000722; x=1721605522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fisAkwN1BJScZi7vZMFYgCkfLuep5MQCZJRyr7mxhM=;
        b=GZImZCUSF4Xny2Jgw//qac8st/6jM9r4y9eSC5QoJsY0L+B8aZt2v1iDO6EOvq5xrE
         qJTSWFzt+xIfeBHzb9bv3GS2uT8V0EtXrrY7H4JllklUubnDGfQuwlRXK+5atcjjx8I9
         nea7wUen4Q9WVo/sBtiL1Npc18TFdUfl+iy+/cUVMHsaxt3cCjqyEFClS84/K33SlS9O
         xfgELZo7lU9V45R1bxSV3xJoFwaBWu08MXZudThIoVv3+s368TJrW/sfkir+clW87O5Z
         olTqlDnUq6sLTvlxxyrlbQtSkDKDpY8P7AqY04iNQF41kqz4xaXW+ssfkxOAvgGjP0RR
         1xHw==
X-Forwarded-Encrypted: i=1; AJvYcCXn5gx0cEgAvgdZiCVcmZSzK3B7AKw6HgwlH55+Y0ap3g0+9qrnLm4GdZRef1lgd0nLvDHgyhakOPg0Gxh6hXGK5Xv2PDgccEAxLg2R
X-Gm-Message-State: AOJu0Yyut/eiSBDYee5rwELkUHdr9sOnR6cNwATX/uS5LYmsVwtpzWFe
	5KXfY85Dc06+4zzQdekUfsgVhs/rID4+ZuAfK4a5UOp4TO4zvuTl
X-Google-Smtp-Source: AGHT+IEB0hznk/RkZ+yT4Pl+hzPRwzWGYNV5mcUvuw8W8sRb2MCoJlceaQQPK4Az5ph2DmbtycxuFw==
X-Received: by 2002:a05:6a21:a343:b0:1bd:2a0a:c183 with SMTP id adf61e73a8af0-1c29820c07dmr16067632637.9.1721000722303;
        Sun, 14 Jul 2024 16:45:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb74c04sm28424205ad.51.2024.07.14.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 16:45:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DF6EA18F12B3B; Mon, 15 Jul 2024 06:45:16 +0700 (WIB)
Date: Mon, 15 Jul 2024 06:45:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: =?utf-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: A new spinlock for multicore (>16) platform
Message-ID: <ZpRjDDKGq1F4cSBr@archie.me>
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G1ItZZWVNAGi4xvW"
Content-Disposition: inline
In-Reply-To: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>


--G1ItZZWVNAGi4xvW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 01:07:40AM +0800, Shi-Wu, Lo=EF=BC=88Gmail=EF=BC=89=
 wrote:
> Dear Linux Contributors,
> I am a Linux enthusiast from Taiwan, and I hope to contribute to the
> Linux kernel. We have developed a new spinlock method that has been
> validated on AMD 64-core and AMD 32-core processors. Compared to
> previous methods, this new method is optimized in the following areas:
>=20
> Motivation and Approaches:
> 1. As the number of cores increases, there is a need for more refined
> optimization of the data transmission paths between cores.
> 2. Data transmission usually involves lock-unlock wrapping.
> 3. Performance improvement can be achieved using a shortest path
> approximation algorithm.
>    A detailed introduction to this method can be found in the following p=
aper:
> https://www.usenix.org/conference/osdi23/presentation/lo
>=20
> Our laboratory is currently developing a system that can apply the
> same optimization strategy to all multi-core processors. Below is our
> plan.
>=20
> The New Method and Its Compatibility with qspinlock:
> 1. The default algorithm in the Linux kernel remains qspinlock.
> 2. A new file is created in /proc/routing_path, where a shortest path
> can be input, for example:
> sudo echo 1,2,3,4,16,17,18,19,5,6,7,8,11,12,13,14 > /proc/routing_path
> 3. After inputting the shortest path, the kernel switches to using the
> RON algorithm.
>=20
> Expected Outcomes:
> According to our measurements on AMD 32-core and AMD 64-core
> processors, Google LevelDB can achieve a 3-4% speed improvement.
>=20
> Comparison with Previous NUMA-aware algorithms:
> Compared to NUMA-aware results, since such systems may contain more
> than two processors, the communication cost between processors is much
> higher than the communication cost between cores (within the same
> processor). Our method focuses on multiple cores within a single
> processor, making it multicore-aware. If a NUMA-aware algorithm is
> used in a multicore environment, it is not as effective as a
> multicore-aware algorithm. (Please refer to the paper,
> https://www.usenix.org/conference/osdi23/presentation/lo)
>=20
> Assistance Needed:
> I would like to understand if the Linux kernel community is interested
> in this new spinlock method. As a teacher, I cannot complete all the
> work by myself. Is anyone willing to collaborate with me on this
> project?
>=20
> Sorry to bother you:
> I apologize for taking up so much of your time with this letter.
> Although I am quite old, this is the first time I feel that my
> research results are good enough to contribute to the Linux community.
> I have read the relevant documentation, and it made me realize that my
> time and abilities are insufficient to write the high-quality code
> required by the Linux community. Therefore, I ask for your guidance.

I can't really say about this topic (as I'm not subject-matter expert here),
so Cc: relevant maintainers.

Thanks!

--=20
An old man doll... just what I always wanted! - Clara

--G1ItZZWVNAGi4xvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZpRjBwAKCRD2uYlJVVFO
o/BUAP0TCznb6SAubPDlDqY++2lNYxUlrvYMaPntlNAtYz5J4QD/Sq+GWTAmxejW
Q5UeVEjqgrNlX/Waq7Td6jl9kV5CFQw=
=FqBX
-----END PGP SIGNATURE-----

--G1ItZZWVNAGi4xvW--

