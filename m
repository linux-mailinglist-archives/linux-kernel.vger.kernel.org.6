Return-Path: <linux-kernel+bounces-397140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C309C9BD73E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878FC2848D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA89215C51;
	Tue,  5 Nov 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XDaSO/HM"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E263D81
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839929; cv=none; b=V+L8GNoPB8bh0+bA47ol3Kfo/+7pzCyuEywvl3n3vg7GD1iNNLRF+x9+TXAUWPFMvFEu65VTu/Fh0mp4QSs9+QzSRAnHCDgBvU7pMnKv7mwxdkfuVbqIcIc7JW9/2xsO0QNNCAvGy/zIz1Frx02yVmyeUHyEXzfgy/rFcWKc7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839929; c=relaxed/simple;
	bh=ixwACA4CP2QvZwHQk7BOsKWdozEfHRYZScctyBHfj+o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a7hmAXOqmWiDhkcktdetzGf/3Bg+ddDBrhI9S55FQ6BFCa/V3pyzcmX/Wxv41PKk37XYtD0R2cwIs1RNha7K+YQKId4s0GFgMFhAqWkVtxmS0Ug/uvyS/fB0Ot479EXHshlGKomTBwpXk97c/q4/P75TYNto67xpkq6UTp0euKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XDaSO/HM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.208.84])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5Kp2Qo377876
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 12:51:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5Kp2Qo377876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730839864;
	bh=ixwACA4CP2QvZwHQk7BOsKWdozEfHRYZScctyBHfj+o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XDaSO/HMBm3U0TE4NJUZ+zaGhgQv1Xs/9PLIwBjmwCp1S6gVvBUwpUV3P3YoGFSUq
	 ViiWkLb0+lTwuLP4joqmsc6SGTIMziFl6TC1YOvGhK4IoMB7Qpne06EO8X8gcm0U9v
	 Ryo0OZrb+qKBimxiXsLdS67QWOWFU5dLBRBzgIMJuFdnWnfNgUU4+0eu7LPYU4l598
	 i8LDKl7ZlP4i/Uf6qlYxH6tdSG22Qf3Hjah2MUHjvfLHGCZ7+8ZujqhIfwaa8NmhKC
	 fbCX9vCROqU5qtqE2sLFxAtGAoEBDgNLhnSPxuhi7h/4WD+2SOk4flyXJcdJHJF2Bz
	 9dJB51Q3HVDfw==
Date: Tue, 05 Nov 2024 12:50:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_6/7=5D_x86/kexec=3A_Debuggi?=
 =?US-ASCII?Q?ng_support=3A_Dump_registers_on_exception?=
User-Agent: K-9 Mail for Android
In-Reply-To: <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
References: <20241103054019.3795299-1-dwmw2@infradead.org> <20241103054019.3795299-7-dwmw2@infradead.org> <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
Message-ID: <66DC35BB-A9E5-45E4-AAAD-051C22943F51@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 5, 2024 12:38:10 PM PST, "Woodhouse, David" <dwmw@amazon=2Eco=
=2Euk> wrote:
>On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
>>=20
>> +
>> +/* Print the byte in %bl, clobber %rax */
>> +SYM_CODE_START_LOCAL_NOALIGN(pr_byte)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0movb=C2=A0=C2=A0=C2=A0=C2=A0=
%bl, %al
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nop
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0andb=C2=A0=C2=A0=C2=A0=C2=A0=
$0x0f, %al
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0addb=C2=A0=C2=A0=C2=A0=C2=A0=
$0x30, %al
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmpb=C2=A0=C2=A0=C2=A0=C2=A0=
$0x3a, %al
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A01f
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0addb=C2=A0=C2=A0=C2=A0=C2=A0=
$('a' - '0' - 10), %al
>> +1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_char
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ANNOTATE_UNRET_SAFE
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret
>> +SYM_CODE_END(pr_byte)
>> +
>
>Obviously that function name (and comment) are wrong; fixed in my tree=2E
>at
>https://git=2Einfradead=2Eorg/users/dwmw2/linux=2Egit/shortlog/refs/heads=
/kexec-debug
>
>This function (and also pr_qword) are also what objtool is complaining
>about:
>
>vmlinux=2Eo: warning: objtool: relocate_range+0x2f6: unreachable instruct=
ion
>vmlinux=2Eo: warning: objtool: relocate_range+0x305: unreachable instruct=
ion
>
>I don't quite see why, because pr_qword() quite blatantly calls
>pr_nyblle(), as it's now named=2E And exc_handler() repeatedly calls
>pr_qword()=2E
>
>But most of the objtool annotations I've added here were just to make
>it shut up and build, without much though=2E Peter, Josh, any chance you
>can help me fix it up please?
>
>It would also be really useful if objtool would let me have data inside
>a "code" segment, without complaining that it can't decode it as
>instructions =E2=80=94 and without also failing to decode the first instr=
uction
>of the *subsequent* function=2E I've put the GDT at the end to work
>around that, but it's a bit nasty=2E

code in the data *section* or *segment*? Either is nasty, though=2E That's=
 what =2Erodata is for=2E

