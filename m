Return-Path: <linux-kernel+bounces-532458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD360A44E03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A9B3A8567
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78918A6A8;
	Tue, 25 Feb 2025 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wdwb+MLO"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79418DB20
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516430; cv=none; b=KUZEMLdoCD08Q+LgN66LfsuSSpgCa49o3FEEDQeMM9dcAD2EBfOMYpTjSp0KYJfa929PPEriJfYPQKNv21XuI/j05CdAb10irFzs938I/+5GdOeVuo+LvHtNY69z9W9bVdULvozQDWU5Vpb7bVVwPtPemEaBIEeuqekE9jr90SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516430; c=relaxed/simple;
	bh=gfxL9wTEWZrOay5k0nZAnnPNeXDPhYHavX9Kj7fIazk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gci4g/rGGH+sg1NK+3gXDtlI/L57gSG9eXfGdVQnp4IuCtcRl+4miYTfkNUWv1jfmM2XhsXkazHeL81LbadhRZEav6kSb+gNzHElWoO7diIHs07P+hcb59jzSCqSQLvSs6eBSiEIjnfqpQQovflFLBCTfRG5Iza8OBNbxWaGuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Wdwb+MLO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PKkTeV1426971
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 12:46:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PKkTeV1426971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740516390;
	bh=IJqMiXLFWZPNEHcvMh73vVZtN2o32vvQUt/V/YKmWTs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Wdwb+MLO8ny/HSMikeM9g7XF3Ldz1ppHS7MEWup5hYLZ4IxGAjfTphKU6neslrJFX
	 SU1hW3jl+U+aSpW7sPnw030qGazDWWmEGqOE2c4tLF1XXspG0yZIyjuNg8ZfcA53Nq
	 aFXnYt3cXZJZMGnCXjWajRmdqB4gSwk8QRaZsOFOfkhAOOCJ/2/1yJJkHWmEtgu+N6
	 dnNSVgWuzlmBthQ9+9vaL3Dh6Q3dIpA2G9vUJUq6+ljpj+rVxNSScVznITfA27caIm
	 vQbKCA1Rrw3rNbGok/IibvJp/DhkVd7dNvbNtU7JmuJXF3kFUMh/9x9evFatxkr84n
	 ZRZ+J6ZJ2/Org==
Date: Tue, 25 Feb 2025 12:46:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org,
        bhe@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        kai.huang@intel.com, kirill.shutemov@linux.intel.com, mingo@redhat.com,
        pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, apais@microsoft.com,
        benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
        vdso@hexbites.dev
Subject: Re: [PATCH] x86/reboot: Don't corrupt memory on non-BIOS systems
User-Agent: K-9 Mail for Android
In-Reply-To: <Z74qn-iQDPb3NrXS@gmail.com>
References: <20250109204352.1720337-1-romank@linux.microsoft.com> <Z74nKGVfkhmYppCo@gmail.com> <03D69594-6E5E-47B1-ACF7-B0222F642DE5@zytor.com> <Z74qn-iQDPb3NrXS@gmail.com>
Message-ID: <299DAF93-E190-41DF-B0AA-A1AA9BA3772A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 12:39:59 PM PST, Ingo Molnar <mingo@kernel=2Eorg> wrot=
e:
>
>* H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> On February 25, 2025 12:25:12 PM PST, Ingo Molnar <mingo@kernel=2Eorg> =
wrote:
>> >
>> >* Roman Kisel <romank@linux=2Emicrosoft=2Ecom> wrote:
>> >
>> >> native_machine_emergency_restart() writes unconditionally
>> >> to the physical address of 0x472 to pass the warm reboot
>> >> flags to BIOS=2E The BIOS reads this on booting to bypass memory
>> >> test and do the warm boot=2E On the non-BIOS systems, other
>> >> means have to be employed, and this write is a memory corruption=2E
>> >>=20
>> >> Fix that by moving the offending write into the case where
>> >> the machine is rebooted via BIOS=2E
>> >>=20
>> >> Signed-off-by: Roman Kisel <romank@linux=2Emicrosoft=2Ecom>
>> >> ---
>> >>  arch/x86/kernel/reboot=2Ec | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>=20
>> >> diff --git a/arch/x86/kernel/reboot=2Ec b/arch/x86/kernel/reboot=2Ec
>> >> index 615922838c51=2E=2E6eec8653493f 100644
>> >> --- a/arch/x86/kernel/reboot=2Ec
>> >> +++ b/arch/x86/kernel/reboot=2Ec
>> >> @@ -637,9 +637,8 @@ static void native_machine_emergency_restart(voi=
d)
>> >> =20
>> >>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
>> >> =20
>> >> -	/* Tell the BIOS if we want cold or warm reboot */
>> >> +	/* Tell the firmware if we want cold or warm reboot */
>> >>  	mode =3D reboot_mode =3D=3D REBOOT_WARM ? 0x1234 : 0;
>> >> -	*((unsigned short *)__va(0x472)) =3D mode;
>> >> =20
>> >>  	/*
>> >>  	 * If an EFI capsule has been registered with the firmware then
>> >> @@ -681,6 +680,7 @@ static void native_machine_emergency_restart(voi=
d)
>> >>  			break;
>> >> =20
>> >>  		case BOOT_BIOS:
>> >> +			*((unsigned short *)__va(0x472)) =3D mode;
>> >>  			machine_real_restart(MRR_BIOS);
>> >
>> >If the value of 0x472 is only meaningful in the legacy 'BOOT_BIOS'=20
>> >case, then at minimum the whole block should be moved to that case, no=
t=20
>> >just the setting=2E
>> >
>> >Thanks,
>> >
>> >	Ingo
>>=20
>> Does the memory corruption actually matter, though?
>
>I presume the issue came up by auditing & reviewing host writes to a=20
>barebones non-legacy VM?
>
>I'd argue that we shouldn't be writing random values into random legacy=
=20
>addresses, especially if that special address doesnt seem to be covered=
=20
>by any modern spec? Basic defensive coding practices and such=2E
>
>Thanks,
>
>	Ingo

The ultimate answer to the question is probably WWWD=2E

