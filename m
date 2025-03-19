Return-Path: <linux-kernel+bounces-568208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A08A69361
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE6D1887FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52291C5F25;
	Wed, 19 Mar 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bxZ340Ct"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404701A841C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395712; cv=none; b=LCYDJm5ccx1urQ1UwUN1Q8R7NYKA2vNGrHUNC4WNoFNmByLZ0cg8SZGSb/afCyXAl4nmrRQmQmKnHSWElIMYwgVUPZCPQ2xJVMv/9cxl87BWDvXmJPayH1JxuHgYlqR9WsIzyJdYdvSMWIt6KFFc/yOymMQLU384kT4hdpjZ1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395712; c=relaxed/simple;
	bh=c7v3mxoqWdwT0k/m2IYcuau8vrujmXPRETjgPMXJ9T0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ajesh+875fVn/Bk75CmvWiqw1egrTDc9FJXym5Kr8cokdINZ0OD98sYV+TV84o5YHGykoyxsgGI3++nuolZf4HL1h+Atpwu7+hgLSGH6lc/PJMojOfq1vfVgxnv9Zk8rw8wWiy779fjch5M9+bwhvNscgCyi9d9V7e/k6u0eP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bxZ340Ct; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52JElqhh1575716
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 19 Mar 2025 07:47:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52JElqhh1575716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742395673;
	bh=hzGATQF/l9ODdjCNYOMijC4R1djYt0XFE3qrA8/SXj4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bxZ340CtsdcOXXpxaAdodT2jBIwfiDdh1P4SeBgFjd7Am9sj9sYUvdO3hIrhqMijX
	 H4rq30KRZiCnfUgNPl3MM1jcQ2jLwEulAoQHkhH5xzQ6jaB4i9tOw7TV7fS+K4SnYO
	 hKGRXaVstAR+11XZciOSEVI4xUQQMV9oSt3OSsIgjy8MeE0gQsPGmoodIv53BbZEfQ
	 c3rmR46lwXBQmh6/sbl9LvwA90cEeBaWN7UQB3lvPDZLU7jHkfbI6Imu555am49sSh
	 hB0kXioUE1OaH3vaaJfF6lDVlBanp0G06U8qad2r+iJvL4hZfoaId7ONJpQKhkI3lT
	 AX3DH65MKAimg==
Date: Wed, 19 Mar 2025 07:47:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Borislav Petkov <bp@alien8.de>
CC: Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
        x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_01/29=5D_x86=3A_treewide=3A?=
 =?US-ASCII?Q?_Introduce_x86=5Fvendor=5Famd=5For=5Fhygon=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z9lUB2t0eZ8bz4vW@lx-t490>
References: <20250317164745.4754-1-darwi@linutronix.de> <20250317164745.4754-2-darwi@linutronix.de> <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local> <Z9lUB2t0eZ8bz4vW@lx-t490>
Message-ID: <14F10A4B-A274-40B2-9609-669E09981812@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 18, 2025 4:07:51 AM PDT, "Ahmed S=2E Darwish" <darwi@linutronix=2E=
de> wrote:
>Hi,
>
>On Mon, 17 Mar 2025, Borislav Petkov wrote:
>>
>> On Mon, Mar 17, 2025, Ahmed S=2E Darwish wrote:
>> > The pattern to check if an x86 vendor is AMD or HYGON (or not both) i=
s
>> > pretty common=2E  Introduce x86_vendor_amd_or_hygon() at <asm/process=
or=2Eh>
>>
>> So if we need to check "intel too", we do
>>
>> x86_vendor_amd_or_hygon_or_intel?
>>
>> Nah, this is silly=2E
>>
>
>I needed this while refactoring the cacheinfo=2Ec leaf 0x8000001d code at
>patch 11/29 ("x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d
>calls") as the combined check was done multiple times=2E
>
>Then I found that there are 28 other cases in the x86 tree where the
>AMD/Hygon CPU vendor check is also combined=2E  So I did that macro and i=
t
>also made a number the affected sites more succinct; e=2Eg=2E:
>
>|  diff --git a/arch/x86/xen/enlighten=2Ec b/arch/x86/xen/enlighten=2Ec
>|  index 43dcd8c7badc=2E=2E13df4917d7d8 100644
>|  --- a/arch/x86/xen/enlighten=2Ec
>|  +++ b/arch/x86/xen/enlighten=2Ec
>|  @@ -82,11 +82,9 @@ void xen_hypercall_setfunc(void)
>|   	if (static_call_query(xen_hypercall) !=3D xen_hypercall_hvm)
>|   		return;
>|
>|  -	if ((boot_cpu_data=2Ex86_vendor =3D=3D X86_VENDOR_AMD ||
>|  -	     boot_cpu_data=2Ex86_vendor =3D=3D X86_VENDOR_HYGON))
>|  -		static_call_update(xen_hypercall, xen_hypercall_amd);
>|  -	else
>|  -		static_call_update(xen_hypercall, xen_hypercall_intel);
>|  +	static_call_update(xen_hypercall,
>|  +			   x86_vendor_amd_or_hygon(boot_cpu_data=2Ex86_vendor) ?
>|  +			   xen_hypercall_amd : xen_hypercall_intel);
>|   }
>|
>|   /*
>|  @@ -118,11 +116,8 @@ noinstr void *__xen_hypercall_setfunc(void)
>|   	if (!boot_cpu_has(X86_FEATURE_CPUID))
>|   		xen_get_vendor();
>|
>|  -	if ((boot_cpu_data=2Ex86_vendor =3D=3D X86_VENDOR_AMD ||
>|  -	     boot_cpu_data=2Ex86_vendor =3D=3D X86_VENDOR_HYGON))
>|  -		func =3D xen_hypercall_amd;
>|  -	else
>|  -		func =3D xen_hypercall_intel;
>|  +	func =3D x86_vendor_amd_or_hygon(boot_cpu_data=2Ex86_vendor) ?
>|  +		xen_hypercall_amd : xen_hypercall_intel;
>|
>|   	static_call_update_early(xen_hypercall, func);
>
>Nonetheless, I've seen your other emails in the thread, and I'll drop the
>patch=2E
>
>Thanks!
>
>--
>Ahmed S=2E Darwish
>Linutronix GmbH

I would agree that abstracting this into something higher level makes sens=
e, but have you considered whether or not it is actually necessary to do th=
is in the first place? In the case of level 0x8000001d for example, that sh=
ould be handled by the end bracket from leaf 0x80000000=2E

In general, VFMS checks are not a good thing=2E

