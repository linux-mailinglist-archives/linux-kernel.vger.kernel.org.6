Return-Path: <linux-kernel+bounces-551515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE8FA56D86
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC5C3AA21F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DE923BCFE;
	Fri,  7 Mar 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="G7oNfjIz"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1023BCF4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364630; cv=none; b=ZD4YkK0/tSgqezEq/0gLxqFY5g7xif4XeaItxMPuKj847yYaTQXCKOgxRkV/eZgDp3HjSu+pHtDqQMRbQdUfb2qTJ3uFphV+enT1MvH2Qbn5tdfQU/oOYfXoPUkm9YCO2gnBB5QdHY+OIbbbiPt83lm5girF+0ExW/ArCi6bzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364630; c=relaxed/simple;
	bh=yjWhndqBY/p/naYYeyjqW/iXjpCwZxRa8eTsaF7Em3M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HfQ1S1SLBXf/qZYemlBSoElrdzpqfMPfU+kBXC8l1gPOdUspaUp6/H2jE9gp5CUbhF4tP6m6EMrFpVoSK42AxVDMBmCa3h+pbkobA18ZLq4kxuEO0YQR+1KwniK36D9IqnyLuc3dza3SlpMvHwoanPsu2DsQYkSzMbfopCyYEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=G7oNfjIz; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527GNJPW317850
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 08:23:19 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527GNJPW317850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741364600;
	bh=BO+FVZTQ+WFQNezyeYDYypLAuwFFO1XjKGTbH7ev1ns=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G7oNfjIzeUmIkTDDEEykEbYpjV9zClr0FbDoOz2kY6mrEqT5XK2Rcdamb+rWbzMCh
	 a1qOrX4P9I8LLcUUe4eAHwWSHRn26Tfh4rwt0waSHkRX5OpBl61Yni+Ufj4HGv7ETA
	 TcnWuQbjHyJl/HcEoQtwGdzy7PQSAN/9LmVRSCv54R6mheWVwkDF5ev97JC2zFyQOr
	 0v7GiEXbcS6X+j26hJHlkhCxVrEC8DIwEq0ZQEmOD2HSt1iwr6OYZqwWLYx218w/CW
	 u0KqmoZYAjlYXhMdK4DtYVxGG3XLxBGhQKjD63cF5OozoR8sScIbp1WiIrs5+VkSMB
	 RBBPMd0wNWnpw==
Date: Fri, 07 Mar 2025 08:23:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/asm: delete dummy variables in movdir64b()
User-Agent: K-9 Mail for Android
In-Reply-To: <d9d6b9db-dcdb-4024-a14a-bdcbe6afe00a@p183>
References: <20250307061203.3281-1-adobriyan@gmail.com> <20250307061203.3281-3-adobriyan@gmail.com> <Z8rdRljzdRdh9hu6@gmail.com> <d9d6b9db-dcdb-4024-a14a-bdcbe6afe00a@p183>
Message-ID: <686459FE-58F5-4009-AF13-B2BF43CF5550@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 8:15:42 AM PST, Alexey Dobriyan <adobriyan@gmail=2Ecom> wr=
ote:
>On Fri, Mar 07, 2025 at 12:49:26PM +0100, Ingo Molnar wrote:
>>=20
>> * Alexey Dobriyan <adobriyan@gmail=2Ecom> wrote:
>>=20
>> > Cast to pointer-to-array instead=2E
>> >=20
>> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail=2Ecom>
>> > ---
>> >  arch/x86/include/asm/special_insns=2Eh | 9 +++------
>> >  1 file changed, 3 insertions(+), 6 deletions(-)
>> >=20
>> > diff --git a/arch/x86/include/asm/special_insns=2Eh b/arch/x86/includ=
e/asm/special_insns=2Eh
>> > index d349aa0f0a83=2E=2Eb24c6c945c38 100644
>> > --- a/arch/x86/include/asm/special_insns=2Eh
>> > +++ b/arch/x86/include/asm/special_insns=2Eh
>> > @@ -215,13 +215,10 @@ static __always_inline void serialize(void)
>> >  /* The dst parameter must be 64-bytes aligned */
>> >  static inline void movdir64b(void *dst, const void *src)
>> >  {
>> > -	const struct { char _[64]; } *__src =3D src;
>> > -	struct { char _[64]; } *__dst =3D dst;
>> > -
>> >  	/*
>> >  	 * MOVDIR64B %(rdx), rax=2E
>> >  	 *
>> > -	 * Both __src and __dst must be memory constraints in order to tell=
 the
>> > +	 * Both src and dst must be memory constraints in order to tell the
>> >  	 * compiler that no other memory accesses should be reordered aroun=
d
>> >  	 * this one=2E
>> >  	 *
>> > @@ -230,8 +227,8 @@ static inline void movdir64b(void *dst, const voi=
d *src)
>> >  	 * I=2Ee=2E, not the pointers but what they point to, thus the dere=
f'ing '*'=2E
>> >  	 */
>> >  	asm volatile("=2Ebyte 0x66, 0x0f, 0x38, 0xf8, 0x02"
>> > -		     : "+m" (*__dst)
>> > -		     :  "m" (*__src), "a" (__dst), "d" (__src));
>> > +		     : "+m" (*(char(*)[64])dst)
>> > +		     :  "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
>>=20
>> In what world is putting type casts inside asm() statements an=20
>> improvement to the code?
>
>In the same world where creating distracting variable whose only purpose
>is to make a cast is considered not good=2E
>
>Notice the cast is shorter, there is not "struct", so it is positive in
>both vertical and horizontal directions=2E

Stuffing more into a single statement =E2=80=93 and asm statements are inv=
ariably complex =E2=80=93 is not good for clarity=2E Please, no=2E

