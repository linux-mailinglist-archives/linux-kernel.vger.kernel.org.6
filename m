Return-Path: <linux-kernel+bounces-242026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DC9282C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131651C24408
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CB13BC02;
	Fri,  5 Jul 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=urlichs.de header.i=@urlichs.de header.b="iFbE1P4E"
Received: from netz.smurf.noris.de (mail.smurf.noris.de [213.95.149.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA831F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.149.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164811; cv=none; b=JXGAODZ3t7kWWz2QrHuRoHmX+uFeclb2usER0SDXFPlR2jndgUN3fGDk6AUcBEM8VTbjhOvrzE87TYArOg2O46py8URsb+uFXxqk58Dk2zx2H3jQimgRO8GS9VnKIn8/wrmbbWl5nStkbX0tnDFp//iowMV69gWNkuHHXEAW84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164811; c=relaxed/simple;
	bh=EzPNAvGewXW9DjYDdECfaV8LSJBOak9UT+X47Faku2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJQnYNuLiDNE/0SMXu3gbOdcw91ke3QUzhv6f8t3FOJuIjIeyaCH07dP4o6X9mAvGTAJM9SYWgvGjDXjpZXjTxy5XNm2jZyNULEl5IMNQ8M4vp+nLHPkXjXI9fcHAdjPISkcOvTDJcPZPhDPL5r9U8Cwg8gjs3641clH6GCCthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=urlichs.de; spf=pass smtp.mailfrom=urlichs.de; dkim=pass (4096-bit key) header.d=urlichs.de header.i=@urlichs.de header.b=iFbE1P4E; arc=none smtp.client-ip=213.95.149.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=urlichs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=urlichs.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urlichs.de;
	s=20160512; h=From:Date:Message-ID;
	bh=vo5K66e5bTLNqjd+YMUtqMoPneVLCAQYDXESuJ4z/AA=; b=iFbE1P4EZ8d2VCG2uyfLDXyK0m
	PZ3ZMWCmALdq+C/Gq/cHJs6KLvt9VcOn+CRaGzqHVyMhLXIefWNzkTs5382Dp/TWEgQf5YellSoPf
	VJrha7YDuJsJTWBC/P3TX1DvnpeJW9WWdAetatwjY+tpiZadh46AidlO7OskeVXnk9IaWlcfU6S5G
	EFj2LEjGCUhFD704jtGSA7eeTN/0bwRg8IyppeFxPXZ7WNHc0qxY4fGgiYrfvFbPh6Af9HhkT6sL8
	5VWHpbw7i87OfwHgQyKXJ1MlF5ZqNsZZxP1Sv7DdLGoo0UNDHFvEnqILkU31rl3Hk5Zhm04KWcajJ
	/SQbZt4dGU+Au/SpH6Cv2R4RDsyvT0qmvtiLzQq6QG0nHawdzMsFdchNFAkPRad9wVrnq74OnZ6wH
	xE/qY7/HYHs5rLhNVUeSAfQCCNdhik8rB9676sujbYyS+4Z+NdbnRhsWLFSew4QNOmwupc8TghpCe
	2EMGaSi1CuATMvrm35vV5bX+zcPz8T6HossGqRwKAOIT1o/tAr7bvXKc7qRJcFP9I2DcGoFyIz6IJ
	zm+G6dmaCBo5iei3cjwBqTVQZDNOpqZodNQ7do0fwsWZ5zuEwTI5K0ZeR9KbMzJVQjFwBN+hAv7UF
	Zlmwx6ctelK07u8xtEu/iYlpAzlEgdHJxOV2PAlLI=;
Received: from asi.s.smurf.noris.de ([2001:780:107:200::a])
	by mail.vm.smurf.noris.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.97-RC1)
	(envelope-from <matthias@urlichs.de>)
	id 1sPcxA-00000000Cbz-1Mxx;
	Fri, 05 Jul 2024 09:01:56 +0200
Message-ID: <a8cc875a-8e93-46b9-a6a7-094072c9a1b5@urlichs.de>
Date: Fri, 5 Jul 2024 09:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deconflicting new syscall numbers for 6.11
To: Willy Tarreau <w@1wt.eu>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, jolsa@kernel.org,
 mhiramat@kernel.org, cgzones@googlemail.com, brauner@kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com>
 <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <Zobtia2Zsaamh9KQ@1wt.eu>
Content-Language: en-US
From: Matthias Urlichs <matthias@urlichs.de>
In-Reply-To: <Zobtia2Zsaamh9KQ@1wt.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DRO4M2V2rAyK8O6cf0Zml5Ib"
X-Smurf-Spam-Score: -1.0 (-)

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DRO4M2V2rAyK8O6cf0Zml5Ib
Content-Type: multipart/mixed; boundary="------------oTUaFac8ZQGy7ZPTOzvYl0Wg";
 protected-headers="v1"
From: Matthias Urlichs <matthias@urlichs.de>
To: Willy Tarreau <w@1wt.eu>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, jolsa@kernel.org,
 mhiramat@kernel.org, cgzones@googlemail.com, brauner@kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de
Message-ID: <a8cc875a-8e93-46b9-a6a7-094072c9a1b5@urlichs.de>
Subject: Re: deconflicting new syscall numbers for 6.11
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com>
 <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <Zobtia2Zsaamh9KQ@1wt.eu>
In-Reply-To: <Zobtia2Zsaamh9KQ@1wt.eu>

--------------oTUaFac8ZQGy7ZPTOzvYl0Wg
Content-Type: multipart/alternative;
 boundary="------------zt95k4iwemyGPuUcTSc4rrSN"

--------------zt95k4iwemyGPuUcTSc4rrSN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDcuMjQgMjA6NDQsIFdpbGx5IFRhcnJlYXUgd3JvdGU6DQo+IEJVVCBJJ3ZlIGdv
dCBjb21wbGFpbnMgaW4gdGhlIHBhc3QgZnJvbQ0KPiBzb21lIHVzZXJzIGdlbmVyYXRpbmcg
VVVJRHMgZm9yIGVhY2ggZm9yd2FyZGVkIHJlcXVlc3QgdGhhdCB0aGV5IHdlcmUNCj4gc2Vl
aW5nIGR1cGxpY2F0ZXMgaW4gdGhlaXIgbG9ncyBkdWUgdG8gdGhlIGxhY2sgb2YgdGhyZWFk
IHNhZmV0eSBvbg0KPiByYW5kb20oKSwgd2hpY2ggbWFkZSBtZSB3b3JrIG9uIGFuIGFsdGVy
bmF0aXZlLiBUaHVzIEkgY2FuIGVhc2lseQ0KPiBpbWFnaW5lIHRoYXQgZXF1aXZhbGVudCBh
cHBsaWNhdGlvbnMgdGhhdCBqdXN0IHdhbnQgdG8gYXNzaWduIGEgdW5pcXVlDQo+IElEIHRv
IGFuIGV2ZW50IHRoYXQgZW5kcyB1cCBpbiBhIGxvZywgYW5kIHdoZW4gc3VjaCBhcHBsaWNh
dGlvbnMgc3VmZmVyDQo+IGEgVk0gbWlncmF0aW9uIGNvdWxkIGZhY2UgYSBzaW1pbGFyIHBy
b2JsZW0gdGhhdCBpcyBub3QgZWFzeSB0byBhZGRyZXNzDQo+IGluIHVzZXJsYW5kLg0KDQpJ
J2QgbGlrZSB0byBzZWNvbmQgdGhhdC4NCg0KSSBzb21ldGltZXMgbmVlZCB0byBkdXBsaWNh
dGUgYSBydW5uaW5nIFZNLCBtb3N0bHkgaW4gb3JkZXIgdG8gZGVidWcgDQpzdHVmZi4gTm93
IGJvdGggVk1zIHJ1biB0aGUgc2FtZSBjb2RlIHdpdGggdGhlIHNhbWUgcHNldWRvLVJORywg
DQpnZW5lcmF0aW5nIHRoZSBzYW1lIG1lc3NhZ2UgSURzIHdoZW4gdGhleSBsb2cgc29tZXRo
aW5nLiBJJ3ZlIHNlZW4gDQpyZWplY3RzIG9uIGxvZ3MgZnJvbSB0aGUgcmVhbCBWTSBiZWNh
dXNlIHRoZSBkdXBlIGdvdCB0aGVyZSBmaXJzdC4NCg0KT3djaC4NCg0KQSB1c2Vyc3BhY2Ug
Uk5HIHdpdGggYSB6YXBwZWQgVk1fRFJPUFBBQkxFIHBhZ2UgdGhhdCByZS1pbml0aWFsaXpl
cyANCml0c2VsZiBmcm9tIHRoZSBrZXJuZWwgUk5HIHdvdWxkIHNvbHZlIHRoaXMgcHJvYmxl
bSAoYW5kIG90aGVycykuDQoNClRodXMgYSByZWFzb25hYmxlIGltcGxlbWVudGF0aW9uIHNl
ZW1zIHRvIGJlDQoNCiogaW1wbGVtZW50IFZNX0RST1BQQUJMRSAod2hpY2ggSSdkIGxpa2Ug
dG8gdXNlIGZvciB1c2Vyc3BhY2UgY2FjaGluZyANCmFueXdheSkNCg0KKiB0ZWFjaCBWTSBj
bG9uZXJzLCB0YXNrIG1pZ3JhdG9ycyBhbmQgd2hhdG5vdCBub3QgdG8gY29weSBwYWdlcyBt
YXJrZWQgdGh1cw0KDQoqIGFkZCBhIFJORyBnZW5lcmF0aW9uIGNvdW50ZXIgdG8gdGhlIFZE
U08NCg0KKiB0ZWFjaCBsaWJjJ3MgZ2V0cmFuZG9tKCkgdG8gdXNlIHRoZXNlDQoNClllcyB0
aGlzIGRvZXNuJ3QgdXNlIHRoZSBleGFjdCBzYW1lIGltcGxlbWVudGF0aW9uIG9mIHJhbmRv
bS5jIHRoYXQncyBpbiANCnRoZSBrZXJuZWwsIGJ1dCBmcmFua2x5IEkgZG9uJ3QgY2FyZSBh
Ym91dCB0aGF0Lg0KDQotLSANCi0tIHJlZ2FyZHMNCi0tIA0KLS0gTWF0dGhpYXMgVXJsaWNo
cw0KDQo=
--------------zt95k4iwemyGPuUcTSc4rrSN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 04.07.24 20:44, Willy Tarreau wrote=
:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:Zobtia2Zsaamh9KQ@1wt.eu">
      <pre>BUT I've got complains in the past from
some users generating UUIDs for each forwarded request that they were
seeing duplicates in their logs due to the lack of thread safety on
random(), which made me work on an alternative. Thus I can easily
imagine that equivalent applications that just want to assign a unique
ID to an event that ends up in a log, and when such applications suffer
a VM migration could face a similar problem that is not easy to address
in userland.</pre>
    </blockquote>
    <p>I'd like to second that.</p>
    <p>I sometimes need to duplicate a running VM, mostly in order to
      debug stuff. Now both VMs run the same code with the same
      pseudo-RNG, generating the same message IDs when they log
      something. I've seen rejects on logs from the real VM because the
      dupe got there first.<br>
    </p>
    <p>Owch.</p>
    A userspace RNG with a zapped VM_DROPPABLE page that re-initializes
    itself from the kernel RNG would solve this problem (and others).
    <p>Thus a reasonable implementation seems to be</p>
    <p>* implement VM_DROPPABLE (which I'd like to use for userspace
      caching anyway)<br>
    </p>
    <p>* teach VM cloners, task migrators and whatnot not to copy pages
      marked thus</p>
    <p>* add a RNG generation counter to the VDSO</p>
    <p>* teach libc's getrandom() to use these</p>
    <p>Yes this doesn't use the exact same implementation of random.c
      that's in the kernel, but frankly I don't care about that.<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
-- regards
--=20
-- Matthias Urlichs</pre>
  </body>
</html>

--------------zt95k4iwemyGPuUcTSc4rrSN--

--------------oTUaFac8ZQGy7ZPTOzvYl0Wg--

--------------DRO4M2V2rAyK8O6cf0Zml5Ib
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEr9eXgvO67AILKKGfcs+OXiW0wpMFAmaHmksFAwAAAAAACgkQcs+OXiW0wpOQ
TQ//c7x3Tsdngrpom96dS5f9LgsUMQaqafhjEmZxZqbNt1fDi9R1I5R8UGy5mQTOSN4YNhunfEeE
GcPZwLsBa7MVpcTRuBjXcXBAHGJ6jYPXT5IaA5Uua7uZjSM02Ix0uYEC4kLjGYY7WLsv/YES6SML
QPNZ/aOHjfexG3tBXh+5y733uRaONPazAcEmE3FRO2eV6ThxY0vEkoGUk6lHY/QYVmFVjITimz+I
lY1wUpebuCPZijkw5Tvv5D/VMgVNBqqdJ7vRx5b7ds51+I050AhKKEIqEI+VeO2BnGH/EVbQRPL1
qFMnm5OeOAd6hDWwSba9khWbGx9bY4klnQ/XM1LwKJdXomOJnxvl5RWpVVwx3Fg9U232l5kw6Pzh
pUpZxROatm0NDZPkFEJezbpUOkYdCutxvUarvgW8/k1/lQQKvsfrchtIG5jei4bPtLXMXcrg4kWb
b91z6H5tmLMVpGqEaf8vyJ83gzoExGnifsnSUjQDGZJYTsVFSXKeN3sYCL8zb03UYQCFXpLzUnCX
SBDF8Q0FAK5Lnp6zf1eGbUBseLZ7zcqGt28sqwMyhqvYen0G25CRFaIM9eMqPrVLCXZnS1lR6raV
iTRjkwtydLDkmaqb4Gh14W+saqmhZ1OqkTLIRT4Jy8feNQ/B9dbrciTNyYj3Qi12ws7eTqk7H5wa
avk=
=z8Cr
-----END PGP SIGNATURE-----

--------------DRO4M2V2rAyK8O6cf0Zml5Ib--

