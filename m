Return-Path: <linux-kernel+bounces-551031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76964A5672C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D0F189921A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7C2185A3;
	Fri,  7 Mar 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bUe8XiT8"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F95218592
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348508; cv=none; b=PIT4IQu9L6zPW6GhqkslgL5x5wB+maHjA9X+wJ8M3EZtocWsKNz4pHTJfZSjiPkQWg5uNHJtAw01vyUjcsg80XT4nLz7KLaIR+/aAVZxss27TGQiekRe5oxmdyLNzXtTavqvK0b5OulUpSSUxYHWopAKtdXooafx/YGgiAtuRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348508; c=relaxed/simple;
	bh=F3bzVq3uuUGE6VJ8eZD9EAXFsCCnIJCII9gl8Mge+us=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eCCd0znkL3OYCkI2uDZOdDQYgrsgM2/SYarHbhJmM1ZjW68kCBYOIJ8N3FlRnKG/SLSl7mImSQwXKHyYzaVAKLC+DLSJCkaMpChQ2hdYIbC5hY/rRe9wLOZixzg5XdbZTTBP/iIr4C1L9+t4kl4eETdjq5zCTR27bfrIJwlugTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bUe8XiT8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527Bscd0208202
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 03:54:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527Bscd0208202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741348479;
	bh=vIGaWTvDjMqnsrI2F0a11ITXzEjo5ZOfuoQjSiOlq8Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bUe8XiT8pjSev3imJ1+VrFIu0sjdCn9Q8JJWz48mQDWZLzVZTA1TBEznd+DsD0EyE
	 sufkeL8cuu57n5UJnkDvy+Z3hwiAXdkqx9exz2W+2bZqI4Avzt7hXuofBluzehjKcB
	 IoNeyiZDVw3SFOu7pkmAQOZLQRoBSvH/IEzLiuquhHl1mUjtChB7kZRD+94KS5fKKp
	 xirvrbfO1JRNaMRAk7iXz8VLVd+t+7m5eK4Ho1j4zlRPeNGsg8aVrObyjB7iCC7VuX
	 LdaZ8DCvd1lU4sncuQD8a1bWKbkGCXgQ5ngBFQXv2ACLVr/h9fex5mVN61OvDGIufT
	 8fUJ56L+036pw==
Date: Fri, 07 Mar 2025 03:54:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/asm: delete dummy variables in movdir64b()
User-Agent: K-9 Mail for Android
In-Reply-To: <Z8rdRljzdRdh9hu6@gmail.com>
References: <20250307061203.3281-1-adobriyan@gmail.com> <20250307061203.3281-3-adobriyan@gmail.com> <Z8rdRljzdRdh9hu6@gmail.com>
Message-ID: <253E93DC-CC61-4AD5-AA87-81674B55C25A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 3:49:26 AM PST, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* Alexey Dobriyan <adobriyan@gmail=2Ecom> wrote:
>
>> Cast to pointer-to-array instead=2E
>>=20
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail=2Ecom>
>> ---
>>  arch/x86/include/asm/special_insns=2Eh | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/special_insns=2Eh b/arch/x86/include/=
asm/special_insns=2Eh
>> index d349aa0f0a83=2E=2Eb24c6c945c38 100644
>> --- a/arch/x86/include/asm/special_insns=2Eh
>> +++ b/arch/x86/include/asm/special_insns=2Eh
>> @@ -215,13 +215,10 @@ static __always_inline void serialize(void)
>>  /* The dst parameter must be 64-bytes aligned */
>>  static inline void movdir64b(void *dst, const void *src)
>>  {
>> -	const struct { char _[64]; } *__src =3D src;
>> -	struct { char _[64]; } *__dst =3D dst;
>> -
>>  	/*
>>  	 * MOVDIR64B %(rdx), rax=2E
>>  	 *
>> -	 * Both __src and __dst must be memory constraints in order to tell t=
he
>> +	 * Both src and dst must be memory constraints in order to tell the
>>  	 * compiler that no other memory accesses should be reordered around
>>  	 * this one=2E
>>  	 *
>> @@ -230,8 +227,8 @@ static inline void movdir64b(void *dst, const void =
*src)
>>  	 * I=2Ee=2E, not the pointers but what they point to, thus the deref'=
ing '*'=2E
>>  	 */
>>  	asm volatile("=2Ebyte 0x66, 0x0f, 0x38, 0xf8, 0x02"
>> -		     : "+m" (*__dst)
>> -		     :  "m" (*__src), "a" (__dst), "d" (__src));
>> +		     : "+m" (*(char(*)[64])dst)
>> +		     :  "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
>
>In what world is putting type casts inside asm() statements an=20
>improvement to the code?
>
>Thanks,
>
>	Ingo

I second that sentiment=2E This is a net negative=2E

