Return-Path: <linux-kernel+bounces-400816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DFD9C12BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9834A1F21430
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776681E6DC1;
	Thu,  7 Nov 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TNxsKsbl"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9D1D8E01
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023408; cv=none; b=iqtPBFm0iAkgX8UGiB2EqNKzD7MszENtMsAsXf5Lh9Oil+NY8tIeSTfBTyTxL1kAxGvvYSyNQmYkmJc66rBzgkf039nrhdosiL8QYZ2XPdFUAkK9aKOVy11xtvRg++G4ZULSl9UhjbAong1kDLtTaPjwzDXqaIZIY2WoaLQKOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023408; c=relaxed/simple;
	bh=H3FV3rDslQoSdCp5mi94gpGHIG5Z7OkgG69XqEyk/z0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=csOrF6RkUrbsGXoH14amUeazKc/RHpZZhfuS4jyWR++J0GvHgSgXAPeL+Y12pZmKlWdmAgDr8JaPtW4Xpq0f0/RIkfHSmd9Q/bppvXxKsJG0giXGi33rHYJHJEy5T75YaV7Vx0cShI+4qfU3SKYgUx7smL3qdBArRQgw1lMX9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TNxsKsbl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([92.33.209.142])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A7NnS0K1358141
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 7 Nov 2024 15:49:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A7NnS0K1358141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731023371;
	bh=6/NZdcb+eDKEKjxoHsmpevhdQTab0euX6eRxoZJgkCI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TNxsKsbl2bYJHr8Lp9IHi1/5UQNgm/T2lVslLy6DOky83NacHCRET77qbRl9aMUPZ
	 SaA2rU1flLT0h/O3do1YzwSoTrLaawRvmrK+zAIIxP6a+PCMZzUtHC94oop07hGc30
	 l+BUZrOUcL3whJYklm5hR3IF9JgH9uuoKAql20HpsrcKgDLxBDF7LlvZSuXQ+vBK5D
	 8G+n2rFfWy6Dmmb7BXkjqMAPMFY+xT+OBg/SbpiP6659nsCH0CGFUn8mulFEYYjdZZ
	 2gVvShhGHVXExQat5ymc/mBa8Qi8LiuicGS/F9if8lHG2NzCXl0L3ZmooC+tCatYdP
	 5b72lr9S5QmDQ==
Date: Fri, 08 Nov 2024 00:49:22 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
References: <20241107233000.2742619-1-sohil.mehta@intel.com> <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com> <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
Message-ID: <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 12:44:57 AM GMT+01:00, Sohil Mehta <sohil=2Emehta@intel=
=2Ecom> wrote:
>On 11/7/2024 3:36 PM, Dave Hansen wrote:
>> On 11/7/24 15:30, Sohil Mehta wrote:
>>> Linux defined feature bits X86_FEATURE_P3 and X86_FEATURE_P4 are not
>>> used anywhere, neither are they visible to userspace=2E
>>> commit f31d731e4467 ("x86: use X86_FEATURE_NOPL in alternatives") got
>>> rid of the last usage=2E Remove the related mappings and code=2E
>>=20
>> Hah, not referenced since 2008!  This one seems like a no-brainer=2E
>
>Thankfully, it wasn't referenced anywhere=2E For a couple of minutes I wa=
s
>wondering why all family 6 CPUs are marked as Pentium 3 on 32-bit=2E
>
>> @@ -628,11 +628,6 @@ static void init_intel(struct cpuinfo_x86 *c)
>>  		if (p)
>>  			strcpy(c->x86_model_id, p);
>>  	}
>
>Here=2E=2E
>
>> -	if (c->x86 =3D=3D 6)
>> -		set_cpu_cap(c, X86_FEATURE_P3);
>

Be careful - these bits are used in module strings and so modutils need to=
 understand them=2E

