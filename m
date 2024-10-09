Return-Path: <linux-kernel+bounces-356228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF602995E43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BE81F26176
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A5152E02;
	Wed,  9 Oct 2024 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cRkNNU4A"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48F13BADF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445523; cv=none; b=NmUwxfEAB/3v80jt87eGtiffjj3lZXTOQL9EB45SdOu9SFpCEoFkJwn0uTrh6P1v7YpKvKc1pPT9xcJhhEhgRo/iE+mfCmuEufCbklOgW68HkVsSxW4BpAgeYkRuRNyaXsqT+kY/Hmu5uceXc6zce2ZTvxk4A4N6kmg5zJFSf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445523; c=relaxed/simple;
	bh=obcfYlmfpRGEOwdQKnvQ3FWG6OMvdtTplhrm9CAAs48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kzXzqE1WlrJw4AbDsrtTyCV3EC2SgRGatdgJkRIqzKcGDJYeXktnJ+TxhWX+cFJSrLl/h5RiCQVwavYM+AS2yfmgQWKJQwq4Tpy2Oebhd9XgHJpSTvn/ummf39Wb/5V5+q5RgcGnmHvg8v5puO/0+YHh5iYg4mLLKEkYNT1Aqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cRkNNU4A; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728445516;
	bh=pZuu3o1/QXy3Kpc4hDvCdZCAIADV5doFTEXg/x1Cdbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cRkNNU4AAaf7i2pxNnIvQgJWOUqs5VTwvNgWJ3ecwGcdUc6A1+B8U8K6tE8sP67/x
	 tDg1X3o7yk2YK6779HDVAJK6mDWgf000Q8Sy2zW5Zn+ftAfkmk/In5s6WiGZu/mVaw
	 Ou5fU5tnqcrc3W6eu1zJOlg26kxhIzliWWAFzrsw54GFrBembr7Ets2MLDr3RISkpl
	 OfmiKoBpXk6M3AycrIVZKcrTQh9V47HwMx7P8KjLTBZrAv1tfCsZhUOYL0gJSG4CxQ
	 dlobwTaYZWmguYIfqBr/NdOQEbLE1NYv7fXPwi030OYYgeUHfAX3QQwNx4DbP16HYq
	 BXH34Z3xxc6rQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNf0q6plnz4wnr;
	Wed,  9 Oct 2024 14:45:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Peter Bergner
 <bergner@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/vdso: Should VDSO64 functions be flagged as
 functions like VDSO32 ?
In-Reply-To: <6abb373f-10fc-470e-b52a-05e990ee2961@csgroup.eu>
References: <6fa86f3de610ffc180ae0f5dbd511453e7473b36.1726208058.git.christophe.leroy@csgroup.eu>
 <875xqtr8qw.fsf@mail.lhotse>
 <6abb373f-10fc-470e-b52a-05e990ee2961@csgroup.eu>
Date: Wed, 09 Oct 2024 14:45:15 +1100
Message-ID: <87frp66it0.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Michael,
>
> Le 18/09/2024 =C3=A0 04:33, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> On powerpc64 as shown below by readelf, vDSO functions symbols have
>>> type NOTYPE.
>>>
>>> $ powerpc64-linux-gnu-readelf -a arch/powerpc/kernel/vdso/vdso64.so.dbg
>>> ELF Header:
>>>    Magic:   7f 45 4c 46 02 02 01 00 00 00 00 00 00 00 00 00
>>>    Class:                             ELF64
>>>    Data:                              2's complement, big endian
>>>    Version:                           1 (current)
>>>    OS/ABI:                            UNIX - System V
>>>    ABI Version:                       0
>>>    Type:                              DYN (Shared object file)
>>>    Machine:                           PowerPC64
>>>    Version:                           0x1
>>> ...
>>>
>>> Symbol table '.dynsym' contains 12 entries:
>>>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>>> ...
>>>       1: 0000000000000524    84 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LI=
NUX_2.6.15
>>> ...
>>>       4: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.15
>>>       5: 00000000000006c0    48 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LI=
NUX_2.6.15
>>>
>>> Symbol table '.symtab' contains 56 entries:
>>>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>>> ...
>>>      45: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.15
>>>      46: 00000000000006c0    48 NOTYPE  GLOBAL DEFAULT    8 __kernel_ge=
tcpu
>>>      47: 0000000000000524    84 NOTYPE  GLOBAL DEFAULT    8 __kernel_cl=
ock_getres
>>>
>>> To overcome that, commit ba83b3239e65 ("selftests: vDSO: fix vDSO
>>> symbols lookup for powerpc64") was proposed to make selftests also
>>> look for NOTYPE symbols, but is it the correct fix ?
>>>
>>> VDSO32 functions are flagged as functions, why not VDSO64 functions ?
>>> Is it because VDSO functions are not traditional C functions using
>>> the standard API ?
>>=20
>> Yes. There's some explanation in the original commit:
>>=20
>>      Note that the symbols exposed by the vDSO aren't "normal" function =
symbols, apps
>>      can't be expected to link against them directly, the vDSO's are bot=
h seen
>>      as if they were linked at 0 and the symbols just contain offsets to=
 the
>>      various functions.  This is done on purpose to avoid a relocation s=
tep
>>      (ppc64 functions normally have descriptors with abs addresses in th=
em).
>>      When glibc uses those functions, it's expected to use it's own tram=
polines
>>      that know how to reach them.
>>=20
>>  From https://github.com/mpe/linux-fullhistory/commit/5f2dd691b62da9d9cc=
54b938f8b29c22c93cb805
>>=20
>> The descriptors it's talking about are the OPD function descriptors used
>> on ABI v1 (big endian).
>>=20
>>> But it is exactly the same for VDSO32 functions, allthough they are
>>> flagged as functions.
>>=20=20=20
>> It's not quite the same because of the function descriptors.
>>=20
>> On ppc64/ABIv1 a function pointer for "F" points to an opd, which then
>> points to ".F" which has the actual text. It's the ".F" symbol that has
>> type "function".
>>=20
>>> So lets flag them as functions and revert the selftest change.
>>>
>>> What's your opinion on that ?
>>=20
>> I think it's fine on ppc64le, I worry slightly that it risks breaking
>> glibc or something else on big endian.
>>=20
>> It is more correct for the text symbol to have type function, even if
>> there's no function descriptor for it.
>>=20
>> glibc has a special case already for handling the VDSO symbols which
>> creates a fake opd pointing at the kernel symbol. So changing the VDSO
>> symbol type to function shouldn't affect that AFAICS.
>>=20
>> I think the only cause of breakage would be if something is explicitly
>> looking for NOTYPE symbols, which seems unlikely, but you never know.
>>=20
>> So I think we could attempt to take this change for v6.13, giving it
>> lots of time to get some test coverage in next before going to mainline.
>
> Will you take the RFC as is for 6.13 or would you like me to include the=
=20
> above explainations and repost as non-RFC ?

If you can come up with a consolidated changelog and post a non-RFC
version that would help, thanks.

cheers

