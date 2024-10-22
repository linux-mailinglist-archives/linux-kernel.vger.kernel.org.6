Return-Path: <linux-kernel+bounces-376950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889219AB7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D5283C09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00A1CC89F;
	Tue, 22 Oct 2024 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=net2o.de header.i=@net2o.de header.b="DEMd28qu"
Received: from mail.net2o.de (zhugeliang.net2o.de [45.9.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481831CC16D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.9.62.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630201; cv=none; b=WY56nFRaBeqTOGHFLtQ3DMYkH1xYhuXlpEgKrrLefnHsrEtirF6HO/FvzNe91mMR15unPeQYjMELxY95Fh1u856W2y4ye43+60XvqeDjg5srk6yE2bWjodFudmnge2y6WNxoRyxDrasS5+yPd2ot/9KfbR4iuFdlUUoWsTTZcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630201; c=relaxed/simple;
	bh=5M4abLpd0xs7syfuHSw1RFL0wMXBEYCv4E8WfuBZGbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JFOtpsHj9s/sXh0HzWpfZjEfqzo6IENFPsucBW3OMOxiLNFJYFyfQaPYjLVmLYxXmzl6jhvUjjd0A8fOoCQBKDQrBCqlgF2c/kDHTFd5kxJXLEfH/73IEuAJy3Bn2FOfnOMUejV7NVVdlYUzBM+//w5MdmjSfk/bs+mCf5ns668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=net2o.de; spf=pass smtp.mailfrom=net2o.de; dkim=pass (1024-bit key) header.d=net2o.de header.i=@net2o.de header.b=DEMd28qu; arc=none smtp.client-ip=45.9.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=net2o.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net2o.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=net2o.de; s=mail;
	t=1729630195; bh=NTLM3sx1OrC11VJjx9swqCHf17wnMDUIE9V5n7sfTho=;
	h=From:To:Cc:Subject:Date:From;
	b=DEMd28quPVxWsvM6hjykuoj5qL/Uco2fxypOuBSeqkTHGc6VHDhZSTqOvy05CYcYN
	 aKkKldw+2YZMudUH7q9CIBStJHh46bNsaVMBWtNu+oxGCG+Hn+6QZc99ZbpoBM2SG/
	 iVG9GnXxSX1mJd/MgFu+VfINPnpywW96P8cAFfQU=
Received: from wukong.localnet (p200300f6c71c2c00359ed833503e00b5.dip0.t-ipconnect.de [IPv6:2003:f6:c71c:2c00:359e:d833:503e:b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.net2o.de (Postfix) with ESMTPSA id EA03C8013F;
	Tue, 22 Oct 2024 22:49:54 +0200 (CEST)
From: Bernd Paysan <bernd@net2o.de>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 David Hildenbrand <david@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Yu Zhao <yu.zhao@intel.com>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: [PATCH v23] getrandom() in vDSO (still flawed)
Date: Tue, 22 Oct 2024 22:49:54 +0200
Message-ID: <23483431.vTCxPXJkl2@wukong>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart72177974.0thIPus4bt";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart72177974.0thIPus4bt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Bernd Paysan <bernd@net2o.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v23] getrandom() in vDSO (still flawed)
Date: Tue, 22 Oct 2024 22:49:54 +0200
Message-ID: <23483431.vTCxPXJkl2@wukong>
MIME-Version: 1.0

This recently popped up here (I'm not a Linux kernel developer, but do a=20
secure network protocol (net2o) and also did a hardware CPRNG for cryptech.=
is)=20
after the author of dietlibc had a look at getrandom() in vDSO.  I kindly=20
helped him to review this.  We concluded that he should ATM NOT implement i=
t,=20
in particular, because it is not just the normal easy stuff where you just =
link=20
to the exact same symbol with the same signature in the vDSO lib instead of=
=20
doing a kernel call, but this is putting additional (and fragile!) burden o=
n=20
the libc maintainer of managing an opaque state.

Random numbers are too important, so I subscribed to LKML=E2=80=A6 and jump=
 in with my=20
flame-proof suit on.

CC to everybody who replied to [Patch v22] of this proposal, and the person=
=20
who wrote the glibc patch.

Linus Torvalds wrote:
> In other words, I want to see actual *users* piping up and saying "this i=
s a
> problem, here's my real load that spends 10% of time on getrandom(), and
> this fixes it".

# My usage #

In my net2o crypto stack, I use getrandom() once at the process start, and=
=20
roll my own CPRNG.  Even if Linux kernels had a superfast getrandom(), doin=
g=20
this backward compatible and across OS portable requires to roll my own CPR=
NG=20
for at least the next decade.  I still check if getrandom is actually=20
available, and read /dev/urandom if not.  I feel comfortable generating=20
randomness myself, but I understand that others don't and shouldn't.

# When do you need lots and lots of randomness? #

=46or connection-oriented protocols, you can and should generate the nonces=
 on=20
both sides starting with a shared secret, and not transmit them over the=20
network at all.  Then, there's no per packet kernel getrandom() call involv=
ed,=20
but at most a per-connection call.  Connection oriented protocols that requ=
ire=20
a CPRNG nonce per packet are ill-conceived, but do exist, though.  There's =
no=20
problem to encrypt 1GB/s on a single core, so calling getrandom() per packe=
t=20
would be a clearly noticeable slowdown.  There's sendmmsg/recvmmsg for send=
ing=20
out and receiving multiple packets with one kernel call, and it is necessar=
y.

Leaves connection-less protocols, where you can't avoid generating some ran=
dom=20
stuff per packet; usually ephemeral keys (where you don't send the raw rand=
om=20
numbers over the network).  Those protocols have a higher overhead, as they=
=20
need a per-packet key exchange.  Still >100k/s of such DHEs can be done per=
=20
core with the recent speed improvements of x/ed25519, so the overhead is=20
measurable.

So while I don't need this, I'm not saying it is completely useless.

# There are however some flaws that need to be fixed first #

1. Burden on the libc implementer to allocate the state, re-initialize it o=
n=20
fork() and whatnot.  This is calling for disaster, there's certainly one or=
=20
the other maintainer who gets something wrong, and it's not just glibc, it'=
s=20
also musl, bionic, eglibc, dietlibc, and programs that rather talk to the=20
kernel directly to avoid broken libcs.  It really has to be getrandom(buf,=
=20
size, flags).  That's how the other vDSO entries work, and that's how far I=
=20
trust libc maintainers.  I don't trust them to maintain the state by=20
themselves.

2. There's no documentation.  This would only be ok if it was a 1:1=20
replacement of the syscall that doesn't need documentation.

3. The ChaCha20 (good choice) based implementation requires more state than=
=20
necessary.

So, how much state do you need for a multi-threaded CPRNG, based on ChaCha2=
0?

Answer:
1 *shared* secret key (256 or 512 bits) *per process* (yes, you can share t=
hat=20
secret)
1 64 bit counter and
1 64 bit nonce (essentially pthread_self) *per thread*

The per-thread 128 bits don't have to be secret.  The counter can be shared=
 or=20
per-thread.  This means handing over the burden of allocating state to the=
=20
library maintainer is completely unnecessary.

# In summary: This can be fixed #

But ATM, C library maintainer should not touch it.

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
net2o id: kQusJzA;7*?t=3Duy@X}1GWr!+0qqp_Cn176t4(dQ*
https://net2o.de/

--nextPart72177974.0thIPus4bt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERJ1NDqPQRwYnwBjr9y2Uk5MtoGcFAmcYD/IACgkQ9y2Uk5Mt
oGeFhQ//WLcvngL0j2c7x3kTeTLQWOGZmNY8ijCesy8xCM84JaI8NswAH6lAMGs+
nGAgwbqsObJMZuPUUVmU6g7JoLiy33aEOl9QUu443GTKG2TYHSoPmBElmU6KoDWW
y8qL5O4HHi6n1Zu9kvABRsn6OhD83oNnGmB6ErUDeje1II/+q3rhwTYhyHAel/gV
Up8k46c7IjY+5PJSKR5zP4Bt7Uo+wIXH66EByadUi6ZnC1iQnLIKm5tk+Ku2z4hu
1MhGPaVz9IZoAlExaEkljHWTLl6Qidu2x5l16pBxYpUj/vcDPc3qPo7TpFzYF/5W
nJvJVuqevVs9KLM5Iqnwi/XEbmtaFgn5/QTEnq2jd3VZ/gwkUAoALKd3i5Ow7iTM
UrSpqa86zh1B3kywjSVUHpgV7wfa/jzitwfrTyMNxZyqoukR15ZVeAaV1kwEXOcs
urCD24nKQqlQ0V5bXJl60QISVBrm8NhcFCA05+yLDY2rpupaKGVdaPtDMpVG+X6j
fYs1C3sXhOmDWeMYMyxLnaw5DqUBxrwM0DryH/4lkAiAeONbMsriGs5oEoc2kpQr
mQT2xdBlSpm2/CqMuYIuoRcq1rIm/pH8ACBiq98dyehSejboL5yVDc5Vlx6yyp1F
4MBsM/pY7rGWVOfPBdPzZ/NTwoW3p6STYQwdcsEtyd21k22h9ro=
=iB02
-----END PGP SIGNATURE-----

--nextPart72177974.0thIPus4bt--




