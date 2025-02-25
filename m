Return-Path: <linux-kernel+bounces-532428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75000A44DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B533B86AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC122068A;
	Tue, 25 Feb 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DN+X6rYX"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AC21D59A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515341; cv=none; b=sjTWbG/5XWCAd0KDwxl20rY5pwHI1Y24Ym86RbGLu7A51X/QiJsTDJw9uOrlJVtDcfIVIXb9t711FInBxPGdmrpeUq9AMrLzK7IFAUR5+ihvy3cRgy9FbUgewwaBH6KxoZK+zUZDG3cidmu+rkzLgTSgXELl8QOiGCJiQkttySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515341; c=relaxed/simple;
	bh=yyZuZadugZiicITjO3adHOD88kdwCwG7zmDBlIchuAg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MjEursSs0pSdDo75teJ6vzWiix+ftL20PyexRdqSLbm2qUuvy2ZU/gBr7mQO3+N4hXdlp3DVT+FAfO5Mh1BXHHTAiafpWAKqwlP0dIeSUi2S3w7pKR6xrMRzSiq82LOV5m7CBvFCfffvTjLa3WMA4GJnjLcw92y+YNUs5utIcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DN+X6rYX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PKSE4L1421505
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 12:28:14 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PKSE4L1421505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740515295;
	bh=rdHfh9AxujwJzalS2rDGmEEUZ5IMDtoYikFEYCxgjUI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DN+X6rYXqDAmWJ0ZOAgQlakKli6GT4/rZjwh2SZwCDX4Csp8SW+k7kBLucoqkiIfL
	 vnqJKD0diBUdUcbMjJxr1z09gTFmYfsekMd+vQ4ZROPUxmVaneS8cBW+fBAvb5jak1
	 6ZeKUxFjiK3aIej4/D04EF8WYbk9jHX3k1EZfw5Zbz2gbJhiT8G/hzHa9jrqCm5H6v
	 F2oQLuElG8t2XkF+xj3Aj7QCWsaqOTXXHHwBCS9BY17WZfp3qiLciBlXzLikCTCnoo
	 7DX2bJWlOUepQl3Q5dRvHJxH4e7eESO3fPSAO+7V7mZ9NHddaVcOxg7KH6tc99qznu
	 g/WQstWRk1MEQ==
Date: Tue, 25 Feb 2025 12:28:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
CC: akpm@linux-foundation.org, bhe@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, kai.huang@intel.com,
        kirill.shutemov@linux.intel.com, mingo@redhat.com, pbonzini@redhat.com,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
        sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH] x86/reboot: Don't corrupt memory on non-BIOS systems
User-Agent: K-9 Mail for Android
In-Reply-To: <Z74nKGVfkhmYppCo@gmail.com>
References: <20250109204352.1720337-1-romank@linux.microsoft.com> <Z74nKGVfkhmYppCo@gmail.com>
Message-ID: <03D69594-6E5E-47B1-ACF7-B0222F642DE5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 12:25:12 PM PST, Ingo Molnar <mingo@kernel=2Eorg> wrot=
e:
>
>* Roman Kisel <romank@linux=2Emicrosoft=2Ecom> wrote:
>
>> native_machine_emergency_restart() writes unconditionally
>> to the physical address of 0x472 to pass the warm reboot
>> flags to BIOS=2E The BIOS reads this on booting to bypass memory
>> test and do the warm boot=2E On the non-BIOS systems, other
>> means have to be employed, and this write is a memory corruption=2E
>>=20
>> Fix that by moving the offending write into the case where
>> the machine is rebooted via BIOS=2E
>>=20
>> Signed-off-by: Roman Kisel <romank@linux=2Emicrosoft=2Ecom>
>> ---
>>  arch/x86/kernel/reboot=2Ec | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/reboot=2Ec b/arch/x86/kernel/reboot=2Ec
>> index 615922838c51=2E=2E6eec8653493f 100644
>> --- a/arch/x86/kernel/reboot=2Ec
>> +++ b/arch/x86/kernel/reboot=2Ec
>> @@ -637,9 +637,8 @@ static void native_machine_emergency_restart(void)
>> =20
>>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
>> =20
>> -	/* Tell the BIOS if we want cold or warm reboot */
>> +	/* Tell the firmware if we want cold or warm reboot */
>>  	mode =3D reboot_mode =3D=3D REBOOT_WARM ? 0x1234 : 0;
>> -	*((unsigned short *)__va(0x472)) =3D mode;
>> =20
>>  	/*
>>  	 * If an EFI capsule has been registered with the firmware then
>> @@ -681,6 +680,7 @@ static void native_machine_emergency_restart(void)
>>  			break;
>> =20
>>  		case BOOT_BIOS:
>> +			*((unsigned short *)__va(0x472)) =3D mode;
>>  			machine_real_restart(MRR_BIOS);
>
>If the value of 0x472 is only meaningful in the legacy 'BOOT_BIOS'=20
>case, then at minimum the whole block should be moved to that case, not=
=20
>just the setting=2E
>
>Thanks,
>
>	Ingo

Does the memory corruption actually matter, though?

