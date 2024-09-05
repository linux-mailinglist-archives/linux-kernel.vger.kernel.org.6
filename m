Return-Path: <linux-kernel+bounces-317169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34796DA52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFDF1C23BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857319D090;
	Thu,  5 Sep 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="HPa/VX+6"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129119D071;
	Thu,  5 Sep 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542980; cv=none; b=pawE87ocdTRoQrJKFl9lZKfqSN+IbN+Lyq8iwWQmz4tLdLR2UbijSIOfGtLzbWkh1XTtN4bed1j6wFqzH00qCIJC5GP+orHdmgIoVXRYppx18EwQDobKao8Y3a9PRJiOgNEdA5c/VH+V8VVs7mraLVP6nEMaX2zAvUthboSIL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542980; c=relaxed/simple;
	bh=nAJEZl5O5HMkGChBesBIUXkkrxjC8ZCN9hQwnaV/sIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ4ZUI8V2naYcch0104d2kaxOhByytdw+LenwPGSoMBItmKQ/gW7b5LD3yBgmQXZCIvq2jFl7ZVqA4dbqjH/RxGLuszfN7DWH243AoLo9vuW8+N1XAOpaKSEAK+dzGqbbjGd3ltG5/kZeK3sDALRh9fPw4IcnqeErOxjvtAJlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=HPa/VX+6; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1725542931; x=1726147731; i=christian@heusel.eu;
	bh=ltEfOBgyjmfFU+sjw4qaKjqJ7Vpk4OnL6zQfxu27USI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HPa/VX+6kD8FvWLNjz/73BBZbqiQe20s0K5ZxnwuF1aNb8mZyTZKB3Zoidu+EjXo
	 0VZBTWShDHxoiBbLWx2A7g5R/QJFtdywh6IQmGZgU3T4hMmeyubjqgHsH8Ts1xvcn
	 XNTnR1Q7emYm9b89dZIEzxKezE+02S58eBmArKF0HSy3oASiHol9Cn5Ls5K2+mpBg
	 Sm18nyWWpOOcB7pln/56AE9hO3ePx425Ddy3b66Vhjk7l+WUCUKQCCOnLpZQOY9qh
	 z6t9e/+xxQvGfeMw44xXFanXJbsOZYTQuGc+RRVrV/kqHG+NOnkG3euTj/ZFI4iPW
	 GscnkMYKcCU79U0swg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.138.43]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlNgz-1sKGr946yj-00f0Eb; Thu, 05 Sep 2024 15:28:51 +0200
Date: Thu, 5 Sep 2024 15:28:47 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob <rob@durendal.co.uk>, Borislav Petkov <bp@alien8.de>, 
	regressions@lists.linux.dev, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, 
	Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
Message-ID: <d9cbe524-ad83-4c48-b6f4-3376ff3172d4@heusel.eu>
References: <87a5i4whoz.ffs@tglx>
 <ZqQSmw51ihns03ob@vendhya2>
 <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx>
 <ZqTufKvJKvotC-o_@vendhya2>
 <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx>
 <ZqZ3Kp2NVctgstxs@vendhya2>
 <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu>
 <87jzgpubxj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bfqpdzedzbu2pe7h"
Content-Disposition: inline
In-Reply-To: <87jzgpubxj.ffs@tglx>
X-Provags-ID: V03:K1:jo84XfmlfhbhtUDby/o7e8Otrjh/iw2fuZCImL0pcrvoM9Kt8KQ
 PrblHavKOARyEUFGQYtRg3U9XuRELba933ipz1uU4vh8QoMg7HhWrtiLtv4GsFQttMUtL9V
 uPa808RVxJJ/xvrful2NZWBlFZeEiCUee6PAH7J6EPXJnUNSHzP4xhg4DETsR/1Fmecsd7u
 odqmJGeYNUzjy/Kjmy3EQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LzV54rweJ6Q=;qLjdUFVmjk16SpszX5FVB6MoFLM
 XY7mwW2TBndiZWuTUg1t7GscOvcXYLswTmCf/tY/mDEa9VllkGXoMgE9H+JY+lMgYxOapOGuf
 nwt/bsOAwL5KmV7r08po0Be4d4jUKosSXp9ifL6C9/rTAW/iqUL00aIU13cby34m7XMaIayhN
 gF47sA837AnIfFa8goxhFdICjO2RInWyBuMUCWuzge//haMZVRWF5EhpJP43Y1RGB0XzZOZua
 Q3OEJZ5E0JE8/ePGjFpwVxmWGVrSmtwoh24U3KpMFQnsMIFNh3p5mtOkRkldZwFeNX9/XHOqA
 AmHJDleBL+guNYvHAnAXNAGZIMQgdzjav3It8LCpMrS+t/IDkYXIIwSnMJDhvs6IxAb4KL0L+
 ughLTMcea+UZDtVXZ7snJNuPOnBfM78V7xT4SpY15K6S+OSNh//Kx8vxo8/vgxEcamJwkjk5r
 Zuw1iUKaOpW4T3yr14E40BhpyAF0DLWJx0vryeh5qU4tiN7yfrD3yCyW9faspjG1z6CikO4us
 E28mXrIpaHj6Fo4Xp4QlJ8/8KsSt4DAUDP4PdGlHIVMQwWC1v7Rc+nncwBw3hLHzgl8oFw6Ku
 FY/lH+S5kwEpngt1G080FdNdrQQZ6uQwZikfFrAiLNWsL4K4JDig4VhEURYCcnFHgf0Pdq30r
 GtHo9pZGyvRGH1kw7+EXcvmOB3/u8hQSRfoietNZ3GCsOF9oEI/XOpS9eGKZ8V4BaMSUinc1R
 kwG9yuXc31WKuJ6KKpoR+hMKnXc4Np6GQ==


--bfqpdzedzbu2pe7h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/09 02:18PM, Thomas Gleixner wrote:
> On Fri, Aug 09 2024 at 11:37, Christian Heusel wrote:
> > On 24/07/28 05:51PM, Rob wrote:
> >> * Thomas Gleixner (tglx@linutronix.de) wrote:
> >> > As the number of CPUs keeps increasing, logical destination mode bec=
omes a
> >> > less used code path so there is no real good reason to keep it aroun=
d.
> >> >=20
> >> > Therefore remove logical destination mode support for 64-bit and def=
ault to
> >> > physical destination mode.
> >>=20
> >> Thanks Chris for applying the patch for me.
> >>=20
> >> Thomas - The patched kernel boots successfully.  I held off updating t=
he
> >> BIOS so there can be no ambiguity.
> >>=20
> >> Thanks,
> >>=20
> >> Rob
> >
> > As far as I can tell this patch did not get applied anywhere so far,
> > right? Or did I miss anything?
>=20
> I forgot about it. Let me find it again and stick it into the tip tree.

I think the patch did not make it past the tip tree after that if I
checked correctly.

Now since it's summer people are maybe on vacation and I hope it got
stuck there because of cocktails on the beach and so on =F0=9F=98=86=F0=9F=
=8D=B9

In any case I wanted to send a reminder about it ..

Cheers,
Chris

--bfqpdzedzbu2pe7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmbZsg8ACgkQwEfU8yi1
JYXclg/+OIRJcNL46KOCd4XEnmkRWWby4BYwKDybZRvvJ/ZiVWx9O4fk94dyU5ul
jwGDKM9pAparUHHpVrhewXX6W3fJH8sJI0ahRDVxZCNZ2v6p3zyqRdu7MdI3O1XN
hPucXItzNQCEaXqDZRfxkskf+4qHG/I46CVx+wn1exh/OQ+OsRO0vJZV7suxJSRy
7GIk0rBKHV5wLhDMYAdM2Yhp2EO7249HwbVmfkJI+pW8jE7CIrSrdN60aJPHJjij
IxIY5r1n1WqLDTHckLlvRk0xUIkeZVrSRLvzif9JmUz2E5b8jbcbPr6VUPBgM2z8
8foVPh5NiDXrOhaqjcsEY4rBFNvG07xMXFgvknGx5yh22HaG/hDAm3qTRnvcaYTw
yHnLS48hZVdcw7B16K3HfF/w4vRVj2IL200o2snmdtIPURKHrnhos/3LYocg3WeV
Z34Phf9HTJH9JrIOsn5HvnTnzoxflkh+rxlF+L4avGSLzQ1Ph+nSdFLzfDDji1Gv
JKKKSPxDovXpSiP27Ru5UnzOiXIoF6uBiSmKilbEk/AcJIFIcG7AagAujFiGNgSZ
P8N0JUnSDm8/tB6vb/gs7l05NCg7WzAumE8b4opw+Cqip4Oau+EdLMhDXCDBl+bh
Dk5JzoSJu2/RHJcllczc58QbY0eH9hnncffy5WvCCm3/Izd1L+0=
=Qoy9
-----END PGP SIGNATURE-----

--bfqpdzedzbu2pe7h--

