Return-Path: <linux-kernel+bounces-446313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3059F2276
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 08:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752B7165D87
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B71946B;
	Sun, 15 Dec 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Okojbzrd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F812F5E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734247194; cv=none; b=kGJjmP56yyXUa4jH3NVQJmX4JFaWZ2UFNtIBiLYIE0ybMyw/orcL9F7mU93TpNeierFMt8be/GhptIh4ROO5LDkPasVlY0jHxZ8gi7QGU4d+leQwEsjJy8Nzi94GIyrcOe3JzIB6FolBJvHY2nCECmDHFAZF1Nib05VmlBZjFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734247194; c=relaxed/simple;
	bh=GmeB2Nnt0p/0wasYv284RQ20U5wr2dFwZ1HyXbGq3cw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AWUk7CEOZfOvtfzz0KUSOOTpsCJnDe1nAV0MzxVi/TKyfPbwvzag2Fq1Uc8RtKR3avkzcA184WtiMG74AlUzpf1pjhc5mHArkwZiQzDXpB2rAkgt6Qv4l6E7fC11fS6A5RydxJ/Yz/zaD22Yh2Gofp6Rc1BAL9ITMnE/rJ8dIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Okojbzrd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bWKhjWo4ZcyICulU1Fa0XHjSXwdydYn+lbDyutrgMcM=; b=Okojbzrd8P4Inemojyydw3prVP
	+rd3xmGU1YXobqoWpgYQu3LrVqbr0eS6LwGVpRZihpDCaU+ZrUn0JlDjl4gBKNHo+t2+ZdPpF3TJh
	f/nIA5y9VJk3vK6/qjaAKjILUACrVfAPcsZ1DNSuuzUmEiqojPHOi+cptxuE3551vhuEnbEnh4jU1
	liNcQqQ8GNCIOl70jIhA13wXzfyLDdB/ZbZb4lfvSk+4HOHa5ya4r6EYzph1dCzRK2b4gYG7Bj3Qx
	blo6iTRBut7bIpG1Y+W7U6NlGUty2D6cOiuT7fv2Dr6xFCBnGfjGNUb/YPom+Cw4sVKlszJZXD+Z7
	8+wGPJsQ==;
Received: from [2001:8b0:10b:5:17ff:680f:f1d1:5aaa] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMiuU-00000004djX-3AvV;
	Sun, 15 Dec 2024 07:19:29 +0000
Date: Sun, 15 Dec 2024 07:19:29 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
CC: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_07/20=5D_x86/kexec=3A_Invoke_copy_?=
 =?US-ASCII?Q?of_relocate=5Fkernel=28=29_instead_of_the_original?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241214230818.GA677337@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org> <20241205153343.3275139-8-dwmw2@infradead.org> <20241214230818.GA677337@ax162>
Message-ID: <9F682018-58B5-4018-9D39-29AD07153A13@infradead.org>
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

On 14 December 2024 23:08:18 GMT, Nathan Chancellor <nathan@kernel=2Eorg> w=
rote:
>Hi David,
>
>On Thu, Dec 05, 2024 at 03:05:13PM +0000, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> This currently calls set_memory_x() from machine_kexec_prepare() just
>> like the 32-bit version does=2E That's actually a bit earlier than I'd
>> like, as it leaves the page RWX all the time the image is even *loaded*=
=2E
>>=20
>> Subsequent commits will eliminate all the writes to the page between th=
e
>> point it's marked executable in machine_kexec_prepare() the time that
>> relocate_kernel() is running and has switched to the identmap %cr3, so
>> that it can be ROX=2E But that can't happen until it's moved to the =2E=
data
>> section of the kernel, and *that* can't happen until we start executing
>> the copy instead of executing it in place in the kernel =2Etext=2E So b=
reak
>> the circular dependency in those commits by letting it be RWX for now=
=2E
>>=20
>> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> ---
>>  arch/x86/kernel/machine_kexec_64=2Ec   | 30 ++++++++++++++++++++++----=
--
>>  arch/x86/kernel/relocate_kernel_64=2ES |  5 ++++-
>>  2 files changed, 28 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/machine_kexec_64=2Ec b/arch/x86/kernel/mac=
hine_kexec_64=2Ec
>> index 3a4cbac1a0c6=2E=2E9567347f7a9b 100644
>> --- a/arch/x86/kernel/machine_kexec_64=2Ec
>> +++ b/arch/x86/kernel/machine_kexec_64=2Ec
>=2E=2E=2E
>>  void machine_kexec(struct kimage *image)
>>  {
>> +	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
>> +					     unsigned long page_list,
>> +					     unsigned long start_address,
>> +					     unsigned int preserve_context,
>> +					     unsigned int host_mem_enc_active);
>>  	unsigned long page_list[PAGES_NR];
>>  	unsigned int host_mem_enc_active;
>>  	int save_ftrace_enabled;
>> @@ -371,6 +387,8 @@ void machine_kexec(struct kimage *image)
>>  		page_list[PA_SWAP_PAGE] =3D (page_to_pfn(image->swap_page)
>>  						<< PAGE_SHIFT);
>> =20
>> +	relocate_kernel_ptr =3D control_page;
>> +
>
>Because of this change=2E=2E=2E
>
>>  	/*
>>  	 * The segment registers are funny things, they have both a
>>  	 * visible and an invisible part=2E  Whenever the visible part is
>> @@ -390,11 +408,11 @@ void machine_kexec(struct kimage *image)
>>  	native_gdt_invalidate();
>> =20
>>  	/* now call it */
>> -	image->start =3D relocate_kernel((unsigned long)image->head,
>> -				       (unsigned long)page_list,
>> -				       image->start,
>> -				       image->preserve_context,
>> -				       host_mem_enc_active);
>> +	image->start =3D relocate_kernel_ptr((unsigned long)image->head,
>> +					   (unsigned long)page_list,
>> +					   image->start,
>> +					   image->preserve_context,
>> +					   host_mem_enc_active);
>
>kexec-ing on a CONFIG_CFI_CLANG kernel crashes and burns:
>
>RAX=3D0000000000000018 RBX=3Dff408cf982596000 RCX=3D0000000000000000 RDX=
=3D000000047fffb280
>RSI=3Dff6c99a785943d20 RDI=3D000000011e145002 RBP=3Dff6c99a785943d70 RSP=
=3Dff6c99a785943d10
>R8 =3D0000000000000000 R9 =3D0000000000000000 R10=3D00000000ab150dc6 R11=
=3Dff408cf99e139000
>R12=3D0000000028121969 R13=3D00000000fee1dead R14=3D0000000000000000 R15=
=3D0000000000000001
>RIP=3Dffffffff84c9c510 RFL=3D00010086 [--S--P-] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
>ES =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
>CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
>SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
>DS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
>FS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
>GS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
>LDT=3D0000 0000000000000000 ffffffff 00c00000
>TR =3D0040 fffffe441f360000 00004087 00008b00 DPL=3D0 TSS64-busy
>GDT=3D     0000000000000000 00000000
>IDT=3D     0000000000000000 00000000
>CR0=3D80050033 CR2=3D00007ffde71dbfc0 CR3=3D00000001140b0002 CR4=3D00771e=
f0
>DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
>DR6=3D00000000fffe0ff0 DR7=3D0000000000000400
>EFER=3D0000000000000d01
>Code=3D83 e1 01 48 8d 74 24 10 41 ba c6 0d 15 ab 45 03 53 f1 74 02 <0f> 0=
b 41 ff d3 0f 1f 00 48 89 43 18 f6 83 78 02 00 00 02 74 05 e8 16 06 da 00 4=
4 89 3d 17
>
>     a0c: 83 e1 01                      andl    $0x1, %ecx
>     a0f: 48 8d 74 24 10                leaq    0x10(%rsp), %rsi
>;   image->start =3D relocate_kernel_ptr((unsigned long)image->head,
>     a14: 41 ba 67 a6 7c e6             movl    $0xe67ca667, %r10d      #=
 imm =3D 0xE67CA667
>     a1a: 45 03 53 f1                   addl    -0xf(%r11), %r10d
>     a1e: 74 02                         je  0xa22 <machine_kexec+0x1c2>
>     a20: 0f 0b                         ud2
>     a22: 2e e8 00 00 00 00             callq   0xa28 <machine_kexec+0x1c=
8>
>     a28: 48 89 43 18                   movq    %rax, 0x18(%rbx)
>
>I guess this seems somewhat unavoidable because control_page is just a
>'void *', perhaps machine_kexec() should just be marked as __nocfi? This
>diff resolves that issue for me=2E
>
>Cheers,
>Nathan
>
>diff --git a/arch/x86/kernel/machine_kexec_64=2Ec b/arch/x86/kernel/machi=
ne_kexec_64=2Ec
>index 9567347f7a9b=2E=2Ee77110c4bb91 100644
>--- a/arch/x86/kernel/machine_kexec_64=2Ec
>+++ b/arch/x86/kernel/machine_kexec_64=2Ec
>@@ -334,7 +334,7 @@ void machine_kexec_cleanup(struct kimage *image)
>  * Do not allocate memory (or fail in any way) in machine_kexec()=2E
>  * We are past the point of no return, committed to rebooting now=2E
>  */
>-void machine_kexec(struct kimage *image)
>+void __nocfi machine_kexec(struct kimage *image)
> {
> 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
> 					     unsigned long page_list,

Thanks=2E Could I have that with a SoB please? I can craft a commit messag=
e if you need=2E I'll round it up with a couple of other fixups I already h=
ave in my tree, and send them on=2E

