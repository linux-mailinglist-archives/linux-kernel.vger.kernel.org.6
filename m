Return-Path: <linux-kernel+bounces-235525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D391D632
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E721C21106
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB34BA34;
	Mon,  1 Jul 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PJBJN1dX"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E23D62
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801341; cv=none; b=ri89Ek+FU6N+J93G6jp4laopXVdnNYyvKq5xCK0GmBu8mVSdPs0+VPWHMVKWCpnTx0XpH9MsD74IiY1f48vGaUFB4rKO3V7Lgxu0Llvjhm5+D6iqiGyVhJIJ/1RzZ7IYW6jO/tYB4+UEdY3JD/TIYXE9zl1d5g/hNbr9iH3dvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801341; c=relaxed/simple;
	bh=d1+VWaUFpOBQ11E6Gh9j1B5RYenIsw9Asmx7hUZ+n2I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G/E35RqiytyWL6OneyZ55w7sTnzTRsH23w+1MgUTmEK3nZvHWvVylU6YTjZrKBOWT1HaqTZyD/ZpGyk4xJCHYPs3W0Xs34VPxtMysLxtqJHEQgBOUSse+J84R7BiwMWH2IHQV42dekma1+bpw29b8BSeZFlgTMPkR8XT7NKQXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PJBJN1dX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4612Ygvk4109406
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 30 Jun 2024 19:34:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4612Ygvk4109406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719801283;
	bh=5zaZ0rMbI0vc60EUJ0k72DGGTwG2PT2JwMw/3fJVX8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PJBJN1dXYIZ1MNUwPPbzm6GJdFYI+foFQhWv9fvKU1zLvHdQAsvifkoj6/LAA136f
	 Pt7yqfIjMCjkvXEBZ0efUIncbLsQ9aZFPcmtLw6/tv+mMNTS2x5cPgfrqR6IikJ2kw
	 i7iwy8yq/bo0RRkE4WDKMbP3hef8VbGXYfbOD27JSjTGMPpEca4N5YvWMWeQPWNnCD
	 pKqjebAkoUtTCl2ztOJ8AcdCjXuwb061CDMANmbLtZLreIhgXlfMyjHPlpl8aDVE2O
	 YbHq2qoAePMubvyCfF3dpHshBJQe85CXdusPzQfS6pUkzOBJXcFus7KKNKoJ3MhZbx
	 wMDasvjLa9DQA==
Date: Sun, 30 Jun 2024 19:34:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Xin Li <xin3.li@intel.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/5=5D_x86/gsseg=3A_use_the_LKGS_?=
 =?US-ASCII?Q?instruction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com> <20230112072032.35626-6-xin3.li@intel.com> <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local>
Message-ID: <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 30, 2024 9:04:48 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Wed, Jan 11, 2023 at 11:20:32PM -0800, Xin Li wrote:
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>=20
>> The LKGS instruction atomically loads a segment descriptor into the
>> %gs descriptor registers, *except* that %gs=2Ebase is unchanged, and th=
e
>> base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
>> what we want this function to do=2E
>>=20
>> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>> ---
>>=20
>> Changes since v5:
>> * Remove reviewers' SOBs (Borislav Petkov)=2E
>>=20
>> Changes since v4:
>> * Clear the LKGS feature from Xen PV guests (Juergen Gross)=2E
>>=20
>> Changes since v3:
>> * We want less ASM not more, thus keep local_irq_{save,restore}() insid=
e
>>   native_load_gs_index() (Thomas Gleixner)=2E
>> * For paravirt enabled kernels, initialize pv_ops=2Ecpu=2Eload_gs_index=
 to
>>   native_lkgs (Thomas Gleixner)=2E
>>=20
>> Changes since v2:
>> * Mark DI as input and output (+D) as in v1, since the exception handle=
r
>>   modifies it (Brian Gerst)=2E
>>=20
>> Changes since v1:
>> * Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete =2Efixup c=
ode
>>   section (Peter Zijlstra)=2E
>> * Add a comment that states the LKGS_DI macro will be replaced with "lk=
gs %di"
>>   once the binutils support the LKGS instruction (Peter Zijlstra)=2E
>> ---
>>  arch/x86/include/asm/gsseg=2Eh | 33 +++++++++++++++++++++++++++++----
>>  arch/x86/kernel/cpu/common=2Ec |  1 +
>>  arch/x86/xen/enlighten_pv=2Ec  |  1 +
>>  3 files changed, 31 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/gsseg=2Eh b/arch/x86/include/asm/gsse=
g=2Eh
>> index d15577c39e8d=2E=2Eab6a595cea70 100644
>> --- a/arch/x86/include/asm/gsseg=2Eh
>> +++ b/arch/x86/include/asm/gsseg=2Eh
>> @@ -14,17 +14,42 @@
>> =20
>>  extern asmlinkage void asm_load_gs_index(u16 selector);
>> =20
>> +/* Replace with "lkgs %di" once binutils support LKGS instruction */
>> +#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
>
>Right, so this is %di only and not %edi=2E
>
>FRED spec says:
>
>"LKGS takes a single 16-bit operand (in a register or memory) and uses it=
 to
>load a descriptor from the GDT or an LDT=2E"
>
>However, latest objdump (GNU objdump (GNU Binutils) 2=2E42=2E50=2E2024063=
0) says
>
>ffffffff81026dfb:       f2 0f 00 f7             lkgs   %edi
>
>objdump needs fixing, I'd say=2E=2E=2E
>

It is much like "movl %edi,%ds"=2E=2E=2E

