Return-Path: <linux-kernel+bounces-527683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C3BA40E2B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACDF1892649
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9C204F98;
	Sun, 23 Feb 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DV9mKRv5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F72036FE
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308032; cv=none; b=jRX2MZ81E+Y0giu1Py8uBrpnn2gLwULYEfRSNdjV534TJXpxw+gIq1MB85ViA9YuqnNWlYc6on+2TGnlbK8rzQfTPJF9wxvCl0N3HR9p2GzME2+6NRm0WBI21TWqK0QuiSMvSJd985V2F0qzK4UUr61hIKujoKQ9R+W5Xk081oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308032; c=relaxed/simple;
	bh=WP3mKiwjOkLg3LvrHM5nXZSGmd6NRXCoOMhqD1L5h+I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bQ4Rp+wOhhtWB1BeUt34eU+Pb/ygPOsr4x2hx3qaQQSmfcGkKhH9uG9gvdgd5vmEPkEwnRswpXM/QzeDLOBmkIVJTnZp2PilpJ15O7mhMhsAaHJUZsnBcAJjKAZZs7Ae8XqB9Ua0sjznqOuZ0ix3GPznhGKHWYVkrGfOTCl56kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DV9mKRv5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WgMF9vswv8p5CFXANTrRWBxbIQfBtJPu0XjamfklNUs=; b=DV9mKRv5Se2cXBOZNCGq+ewZ98
	evVs7kGrm30iMBt3dRDimYsnU0/QHuTXjgtmXbwX1hTwT6A6YpAeGDceCrPL1UNH+5MGH580eJTIR
	dvGDcjoaZ6rxsZnTAJSYAr8QL07LfpWu3IosdKct2caF0moW6JeRt50y5YLAmthKNffqOhhPxKOq5
	OhU8ZbIOw7njmmQ4/yBiEmTZXhSDOFtJ98v6BafRnLFIh5m0ZQiSCVT4hYoRYsi2hZeSzas6NDgZs
	OjpD4NHitKSSMMWD/gG6Q2zIyf9kWL/KasL1Fp7UHfP5+VhWz5ELB2Us5CID/Ni6RP9daSBW1/lnF
	X6cWFGvg==;
Received: from [2a00:23ee:10f8:4733:9bf1:8420:b19d:105e] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tm9bo-000000030Fj-0oJm;
	Sun, 23 Feb 2025 10:53:17 +0000
Date: Sun, 23 Feb 2025 10:53:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
CC: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: Re: [PATCH v6 2/7] x86/kexec: Debugging support: load a GDT
User-Agent: K-9 Mail for Android
In-Reply-To: <Z7rwA-qVauX7lY8G@gmail.com>
References: <20250115191423.587774-1-dwmw2@infradead.org> <20250115191423.587774-3-dwmw2@infradead.org> <Z7rwA-qVauX7lY8G@gmail.com>
Message-ID: <738CB14B-6494-4049-86C9-9A7EBBD08A74@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 23 February 2025 09:53:07 GMT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> There are some failure modes which lead to triple-faults in the
>> relocate_kernel function, which is fairly much undebuggable for normal
>> mortals=2E
>>=20
>> Adding a GDT in the relocate_kernel environment is step 1 towards being
>> able to catch faults and do something more useful=2E
>>=20
>> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> ---
>>  arch/x86/kernel/relocate_kernel_64=2ES | 27 ++++++++++++++++++++++++++=
+
>>  1 file changed, 27 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/relocate_kernel_64=2ES b/arch/x86/kernel/r=
elocate_kernel_64=2ES
>> index af2cd06ff318=2E=2Ec62f03808f18 100644
>> --- a/arch/x86/kernel/relocate_kernel_64=2ES
>> +++ b/arch/x86/kernel/relocate_kernel_64=2ES
>> @@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, =2Equad 0)
>>  SYM_DATA(kexec_pa_swap_page, =2Equad 0)
>>  SYM_DATA_LOCAL(pa_backup_pages_map, =2Equad 0)
>> =20
>> +#ifdef CONFIG_KEXEC_DEBUG
>> +	=2Ebalign 16
>> +SYM_DATA_START_LOCAL(kexec_debug_gdt)
>> +	=2Eword   kexec_debug_gdt_end - kexec_debug_gdt - 1
>> +	=2Elong   0
>> +	=2Eword   0
>> +	=2Equad   0x00cf9a000000ffff      /* __KERNEL32_CS */
>> +	=2Equad   0x00af9a000000ffff      /* __KERNEL_CS */
>> +	=2Equad   0x00cf92000000ffff      /* __KERNEL_DS */
>> +SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
>> +#endif /* CONFIG_KEXEC_DEBUG */
>
>Yeah, so is there any reason (other than paranoia) why the early-early=20
>GDT and IDT shouldn't be unconditional? There's many ways for such an=20
>approach to bitrot, it's much better to not hide it behind a=20
>default-disabled debug option=2E=2E=2E
>
>Some of the other bits, like the hard-coded serial debugging=20
>assumptions, probably need to be behind the debug option - but much of=20
>the new debug mechanism looks safe and generic and can be always-on,=20
>IMHO=2E
>
>This would also throw regressions back into the face of whoever manages=
=20
>to introduce them, ideally=2E ;-)
>
>Thanks,
>
>	Ingo

Makes sense to me=2E I was just trying to be as unobtrusive as possible=2E=
 In a test branch where I was trying to fix up the objtool vs=2E CFI pain, =
I did move the IDT/GDT setup entirely into the ASM code and remove the C co=
de which clears them (before the call into relocate_kernel() which might no=
w trap if we remove the __nocfi hack)=2E I never did get objtool to tolerat=
e both clang and GCC builds though=2E

I think even the serial output (tied as it is to earlyprintk setup) could =
reasonably be enabled by default too=2E

