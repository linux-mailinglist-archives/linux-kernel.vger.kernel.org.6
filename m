Return-Path: <linux-kernel+bounces-272604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A7945EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CF0282BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829411E484F;
	Fri,  2 Aug 2024 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiOm2omP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wk4aHbl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3414B09F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605359; cv=none; b=pZvM6roT6TD4EhOkt8e4CBZKjk17x7Istr9ZgHGCklIYDa/R839qHZVIxHEV/vjSFSPx/lX6hwetoz3kF5dOJlnFmWKG0RbjG0chOxRLgsUANuHehKlS9KGA7YTM4ootU+toFeetJMs0XF5dWA6VsxLb2yNJYWnUQ3PNbSDK7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605359; c=relaxed/simple;
	bh=s53MeyiPgJX97qUt0ITejeCAESuw8gJAGABdZqBlsLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1reOPJClu80LAbG705DbzTBQAcX+BOYBAgtacgxYJwlfbyRCAQfvhdEy0+DakmnhY/wSwkuduk09pYDCXowKkLlCk3jhla7nw5K/dWlyymprkMywLJbIwrpZNyugutH/R4u5joFGrDVJC9sAxceYtLLlXTjMEQ2mtwr0W3d8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiOm2omP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wk4aHbl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722605356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGzg2GI52aMVT+D2Uiqc+6QeQHTjRhsZ/Zs1cCBOQtE=;
	b=SiOm2omP/tgfjELJXSOEYlM8oF68VQ0LL30cTKg6qUSPSHf8TIJ2NgjXa5CvcKwpB76uGX
	gcGPx+l9GbUZ5c57Myn+S0vARRsJC3aAv2NFgTLjR0heoWxtnPQ2c14YXaI/rEb3TTYalU
	OaLDwVzpMb+FuELeGkUCbkRlL/uhBr/ApOEiNlvFuTj5fyNRbrhs9oZCIX0NSCyP95DQou
	GdH0dXWJLsh9+RHry7Eh8u2OA1N/9PsUMqyVn0Z0ikRFNHy/uoWXqRbcwcq7dc4UXYv0ha
	kw27E8rw2aDTgeGx+oY2nQQVQjOLK05lqq5THKWk9zBtzde2ovXJZHxFllOM7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722605356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGzg2GI52aMVT+D2Uiqc+6QeQHTjRhsZ/Zs1cCBOQtE=;
	b=3wk4aHblZYZP+DV3l2Bg1qTrEEEdZEIg+aR9vzhFn9qF3Dg5Vg8WZhUjovKl81TtSo6blo
	6DmekKP/L43SC0CQ==
To: Nikolay Borisov <nik.borisov@suse.com>, Alexey Dobriyan
 <adobriyan@gmail.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross
 <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/3] x86/cpu: fix unbootable VMs by inlining memcmp in
 hypervisor_cpuid_base
In-Reply-To: <824e522d-c9e2-4e24-8ce6-aca6573db06a@suse.com>
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
 <304592cf-e4a7-4ba1-baa6-4941c60f0e3c@p183>
 <824e522d-c9e2-4e24-8ce6-aca6573db06a@suse.com>
Date: Fri, 02 Aug 2024 15:29:16 +0200
Message-ID: <877ccz12ab.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02 2024 at 16:25, Nikolay Borisov wrote:
> On 2.08.24 =D0=B3. 11:50 =D1=87., Alexey Dobriyan wrote:
>> If this memcmp() is not inlined then PVH early boot code can call
>> into KASAN-instrumented memcmp() which results in unbootable VMs:
>>=20
>> 	pvh_start_xen
>> 	xen_prepare_pvh
>> 	xen_cpuid_base
>> 	hypervisor_cpuid_base
>> 	memcmp
>>=20
>> Ubuntu's gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04) inlines
>> memcmp with patch and the bug is partially fixed.
>>=20
>> Leave FIXME just in case someone cares enough to compare 3 pairs of
>> integers like 3 pairs of integers.
>>=20
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> ---
>>=20
>>   arch/x86/include/asm/cpuid.h | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
>> index 6b122a31da06..3eca7824430e 100644
>> --- a/arch/x86/include/asm/cpuid.h
>> +++ b/arch/x86/include/asm/cpuid.h
>> @@ -196,7 +196,20 @@ static inline uint32_t hypervisor_cpuid_base(const =
char *sig, uint32_t leaves)
>>   	for_each_possible_hypervisor_cpuid_base(base) {
>>   		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
>>=20=20=20
>> -		if (!memcmp(sig, signature, 12) &&
>> +		/*
>> +		 * FIXME rewrite cpuid comparators to accept uint32_t[3].
>> +		 *
>> +		 * This memcmp()
>> +		 * a) is called from PVH early boot code
>> +		 *    before instrumentation is set up,
>> +		 * b) may be compiled to "call memcmp" (not inlined),
>> +		 * c) memcmp() itself may be instrumented.
>> +		 *
>> +		 * Any combination of 2 is fine, but all 3 aren't.
>> +		 *
>> +		 * Force inline this function call.
>> +		 */
>> +		if (!__builtin_memcmp(sig, signature, 12) &&
>
> Instead of putting this giant FIXME, why not simply do the comparison as=
=20
> ints, i.e ((uint32_t)&sig[0]) =3D=3D signature1 && ((uitn32_t)&sig[4]) =
=3D=3D=20
> signature2 && ((uint32_t)&sig[8] =3D=3D signature_3  and be done with it?

Because a smart compiler might turn it into a memcmp() :

