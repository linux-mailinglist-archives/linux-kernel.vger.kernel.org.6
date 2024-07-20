Return-Path: <linux-kernel+bounces-258075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FB938318
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 01:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F511F21622
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE082C7E;
	Sat, 20 Jul 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBakCKIv"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B822A1D7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721516494; cv=none; b=oK8GZrMkfd0x/Y9ZqUtY78oevKNI4H9tVV5EqFKQCLHdM6zidpr8p56w20eEQzNnAaglau67PhRIfW/EeVpXTUN2ru8IUy05G0ZQV73yDvCv+MpjJtGhmyhv6ML8ojh9OzWXUebtmVnjQchgCw+6xlAGJA6ITSTd3/w8m3a1Vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721516494; c=relaxed/simple;
	bh=sW8cA1Y2AswpOex5BsGQ7XtnXVNEH5CLPZCPm2L8UzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyhyZTDHegOu/PsOGwwMrfcAxNU0X55mdz/L7Ux3qeZCD1r9RFptlQmc2CizlR13eaw6cNeHE1X50nMiI0qbxD68bMtsvnkQerDoalPC1iDUrt5OAPTPbiCJlkcFE8ThheTXij+YwKC3gNc2YUHqHhorU3b3YENCxvM7gubDGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBakCKIv; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-261112c303bso1065518fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721516492; x=1722121292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sW8cA1Y2AswpOex5BsGQ7XtnXVNEH5CLPZCPm2L8UzQ=;
        b=RBakCKIv/mFB37Iq2Tfzag1pUR3FzDb54gbCjVnCLhrP3zBso61hrBKZVb1q4unL65
         P60A85zy27utC4XVrVbV6kVYmwCII3K8GxSM1/TQaZ7RhkTDKYV7fBLrv0T+jo5aPTWM
         C7GfnV1gJR9BibV1i7wzSpefuGEz4MsbrmLe76Es3nPonp7EqAmPUnVcjjdEoLLnE1ah
         MDp2OwltMzOMNEWj45Or+Wgz6QlH2fC9sqfZpUERxnm33RnMP2U7BbqelFcBtYCTo9zN
         e/eLU4qVWqkNWGME+Tm8PtxAWWIxoTRqO4ZQIkts5RoI5Zm0vom9YitQSm6CLWbghL24
         aP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721516492; x=1722121292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW8cA1Y2AswpOex5BsGQ7XtnXVNEH5CLPZCPm2L8UzQ=;
        b=oQMeORKHs/jOlUqFKFRz0kcIq4+oAdVAwArSRnh4pW1F3+CFuKTHRe6q4LgUpU4VBV
         MUez7+lFtZl8e05ccrMICxaZTewe/K0/yDP0/BUIL2RbqJFnwZ/PvATXN1/fxE4aR4Is
         c+46fjIDDmAru9zL1s3XK4fnl2+7iikzcJ7bB3bke1OlIUzadUBNV8XsSgC+4eDn108m
         Siy08p2g+Pxo3k4E/LK3K769XzQzv+BHNe3Pozs9l3dpZHenVh3BAf9V2ljxW4TFfQ3a
         mnFTpVON9MFEtIUVaAByNLJxPttqcLYUCWXK2XZ0uiXW8kbhl/QdvrGgzOx2hHa4cBY+
         gsSQ==
X-Gm-Message-State: AOJu0Yw4K1HehxQg155B4BxfHo93NeWbeS+t6XHU4Vgk0Zy2gAU7Xafa
	dvlqIKR10KidGSNqh2kxMklw4puj61A3UPMtKzkA9fz57qI6DYLh
X-Google-Smtp-Source: AGHT+IFO87UaKcdvo4U2vY59A01OmERYbxU3/U8gsqzAIk3n9HXm9uYp5EOULVxiPC7GFn4BJO+89w==
X-Received: by 2002:a05:6870:41c8:b0:254:affe:5a05 with SMTP id 586e51a60fabf-261213de6dcmr3826948fac.21.1721516491922;
        Sat, 20 Jul 2024 16:01:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1e4ac7a4sm144093b3a.136.2024.07.20.16.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 16:01:30 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1DB704A0EB82; Sat, 20 Jul 2024 14:08:59 +0700 (WIB)
Date: Sat, 20 Jul 2024 14:08:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: =?utf-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: A new spinlock for multicore (>16) platform
Message-ID: <ZptiivWvB97Nhyw2@archie.me>
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
 <ZpRjDDKGq1F4cSBr@archie.me>
 <20240715095411.GY27299@noisy.programming.kicks-ass.net>
 <CAOpXEOzisJO2kN+qwVRcT5z+jQdSAtL2mpzyH1Q+PcXYvFQDJQ@mail.gmail.com>
 <CAOpXEOyC4WyOuCbGpoVoqtEMG4emR+wSXDKODqULYN0EpLEKdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qsz7RiTh3MwRehOY"
Content-Disposition: inline
In-Reply-To: <CAOpXEOyC4WyOuCbGpoVoqtEMG4emR+wSXDKODqULYN0EpLEKdw@mail.gmail.com>


--Qsz7RiTh3MwRehOY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 02:10:59AM +0800, Shi-Wu, Lo=EF=BC=88Gmail=EF=BC=89=
 wrote:
> Dear Linux Contributors,
> Yesterday, I did not inform you that I added the mailing list of the
> Operating Systems Laboratory at National Chung Cheng University,
> Taiwan, to this discussion. I apologize for this discourtesy. The
> mailing list has since been removed.
>=20
> Could you please give me more advice? For example, should we implement
> RON in the kernel under the current circumstances? Or should we
> conduct more research before implementing RON in the kernel?
> Additionally, is the current approach (where the superuser sets the
> routing table) feasible?

Show us the actual code (send the actual patch series). For information
on how to submit patches, see Documentation/process/submitting-patches.rst
in the kernel sources.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--Qsz7RiTh3MwRehOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZptihwAKCRD2uYlJVVFO
o5HXAP9iInlrCxjBh/BQPMHyCE/ovaYwluui3DWpPGYBpyLWPwEAtpqmQ/vzew6O
MzKyA5RmdFTKQZv6Z9jOxQ+2ZbKdFQk=
=MQlr
-----END PGP SIGNATURE-----

--Qsz7RiTh3MwRehOY--

