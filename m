Return-Path: <linux-kernel+bounces-305005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADCF962805
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC63328579F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138E17C98D;
	Wed, 28 Aug 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k2eWTLxn"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8F178CF2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849928; cv=none; b=TckCpbUIWkdfIuLMhiBzT+yaotMAn3G7ezJ1fCdTPkMN0xUZTfH43pHomGJONE9yRwJM4LUFNFXj20U/cwrtbvjWWx7i69qbvDW9bznjtVHahwZfc/B6/8R61SJlNcQNfX53wYvTBVTjxMkXz7s2wJxndIhAQCC/CXInbyIGL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849928; c=relaxed/simple;
	bh=LPHvYEfai0dgHG9lmYYyaID3Fz0cr/0CjGy81AbspjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEoxnjk6HY7/sUcTRDsdWi8kJmeYXDfzJqZAwtidrCosZD0bPS8UUJknVyjgiyBxvhS0TiFfE2E+FrBxZYHUGCqoSFMzTuMt8sXCQ3ePmyCst5kA0kqCMy55gI0mqEF2eP/maMMdkfQr1aPdrSh2MntXSAncyO1Rb94De27GurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k2eWTLxn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KWjiXUmmEV93LF5mPfA43uk7dNEjWIw+zBwu8kWYnKU=;
	t=1724849927; x=1726059527; b=k2eWTLxnwZ3QO/jKyC+rzVscnC0fY6/VbYKh0cyzRJ7Yo7o
	waVj4iQTp/07770TSUeMUe19vdhBXCyywcZeWgOsm4paUye2tpgC/T548u13s7xEYuFp5g/jgSSGy
	MTrTh0Z49nmFdY+KpUdcjIleEM5Y50g+LBZpqgEdSmIgmfEpom3FEuMCrTIg7rxV6Q8Qffg2Yqz/B
	ec4vlNC0QSE2MV2krbJQqwcwa9/nqUkUXBFbTM/U0dZ5JimUrcEIX/M9EbMs4zskUoCaleb0ATYHz
	bXkj2aHuCthsjzdxesm43V301w0wbpnq5Br4QMbKXunUn2cOTUSvxiSOM64YiSFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjIG4-000000079YR-05cK;
	Wed, 28 Aug 2024 14:58:44 +0200
Message-ID: <d66103380179771d0655288a4d0d95e990876132.camel@sipsolutions.net>
Subject: Re: [PATCH] um: make personality(PER_LINUX32) work on x86_64
From: Johannes Berg <johannes@sipsolutions.net>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  linux-um@lists.infradead.org,
 x86@kernel.org
Date: Wed, 28 Aug 2024 14:58:43 +0200
In-Reply-To: <CANP3RGdxrKHsERYG+yW5fpRUrahkBJbHCKD24v182ZNKuJgfwg@mail.gmail.com>
References: <20240813234755.3615697-1-maze@google.com>
	 <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
	 <CANP3RGdxrKHsERYG+yW5fpRUrahkBJbHCKD24v182ZNKuJgfwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-08-19 at 11:46 -0700, Maciej =C5=BBenczykowski wrote:
> On Mon, Aug 19, 2024 at 5:23=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >=20
> > On Tue, 2024-08-13 at 16:47 -0700, Maciej =C5=BBenczykowski wrote:
> > > Without this patch:
> > >   #!/usr/bin/python3
> > >   import ctypes
> > >   import os
> > >   personality =3D ctypes.CDLL(None).personality
> > >   personality.restype =3D ctypes.c_int
> > >   personality.argtypes =3D [ctypes.c_ulong]
> > >   PER_LINUX32=3D8
> > >   personality(PER_LINUX32)
> > >   print(os.uname().machine)
> > > returns:
> > >   x86_64
> > > instead of the desired:
> > >   i686
> > >=20
> >=20
> > But ... why should it work? UML has no 32-bit compat support anyway.
>=20
> Well, that's certainly a fair point.
> On 'native' x86_64 this works even for 64-bit processes though.
> I wonder if that, in itself, is a feature or a bug...
>=20
> In my case I was writing some debug code (to print the environment
> some test code is running in, since I think it was failing due to
> running 32-bit code in PER_LINUX32 on 64-bit arm) and testing (the
> test code) on x86_64 UML.  I was surprised to discover the difference
> in UML vs my host desktop.
>=20

Alright, I have no idea. This doesn't really seem to do anything else,
so I'm not sure what the point is... It _was_ introduced for compat
though, but obviously the binary doesn't suddenly change to a 32-bit
binary when you do this :)

Maybe the x86 maintainers have any other comments?

johannes

