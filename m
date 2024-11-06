Return-Path: <linux-kernel+bounces-397543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EFD9BDD2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429551F21356
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6515818FC7E;
	Wed,  6 Nov 2024 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f7HjKbfG"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DD18A92C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861314; cv=none; b=GIo6MaFZ2hZKjUECiaJpoUuH67itE+iotYZAIvxHtpRL0L3qjaCYgy5BpVMGrxe/7FyxXsWlbz5IEqbsu3nPat5UdaiK4UrrFsFgRpsa2y4vw+ZUaKR2WtqC2wJ+X81epe0uyDbW6GsLTNsVpsN626rjbnCp0UXKFtDFevBYleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861314; c=relaxed/simple;
	bh=pD3c1qN+3qwiiELhWPCeBpM9P+/1hDsGwN0sbnawkAw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QWh0MIkESPdn9TOC0SQdpHESyq/UeQYcij4fqXt0jNWpKz2w0/tuBHDAp3i2a1aWKuwJnwBeEgd8FYEHyLJpHf1BiV0t9k2gW81LWCj9mIzl6w1Uoi86q1q7jc47xn+lqfs+69GU9TE5UYgWilAE5M8AG9Anv5lnfxgb5oQCrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=f7HjKbfG; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A62lG2M501413
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 18:47:16 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A62lG2M501413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730861237;
	bh=pD3c1qN+3qwiiELhWPCeBpM9P+/1hDsGwN0sbnawkAw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=f7HjKbfGwKWB76QznpZbHstUDYwAQ7sHXv1EsCbVKJDvpo1EtgkY4z03HzpuJoefy
	 r/7O3Fz6/IPdl94CLHyLJLjWiftppLkqToC5Bv4aU+1FCp/UkaSL6jiXVqaOdYvLhw
	 jnahoLwkZnCx3v8bUpKLehbKtSXulSnUtRVTLwwOQQ7grW/c8BuKet+6tmfiY4wkRa
	 /zVEMY/iFxBRJIQlWis4cwSx//5246n7jnfi84EbQ6xWOUyCRfhjfpvWendsQs3dY3
	 jtT/JrtiBjeqMPpWmJ4Rhrzkba57F21PCSaEbPK1LRvRk4OTd+qfyZZR4asqt/NBzL
	 XpEgMGbxNJW/w==
Date: Tue, 05 Nov 2024 18:47:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Woodhouse <dwmw2@infradead.org>,
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
In-Reply-To: <10f2dec7afbbff6570007495185ce1c4144e446b.camel@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org> <20241103054019.3795299-7-dwmw2@infradead.org> <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk> <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com> <10f2dec7afbbff6570007495185ce1c4144e446b.camel@infradead.org>
Message-ID: <B4EBAF27-5E42-4088-9857-DBCD0D19305C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 5, 2024 6:43:44 PM PST, David Woodhouse <dwmw2@infradead=2Eorg>=
 wrote:
>On Tue, 2024-11-05 at 13:37 -0800, H=2E Peter Anvin wrote:
>>=20
>> Looking at your code, you have a much bigger problem here:
>>=20
>> +/*
>> + * This allows other types of serial ports to be used=2E
>> + *=C2=A0 - %al: Character to be printed (no clobber %rax)
>> + *=C2=A0 - %rdx: MMIO address or port=2E
>> + */
>> +=2Emacro pr_char
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outb=C2=A0=C2=A0=C2=A0 %al, %dx
>> +=2Eendm
>> +
>>=20
>> This will overflow your UART buffer very quickly since you are now=20
>> dumping a whole bunch of data=2E The URT buffer -- if you even have one
>> and it is enabled -- is only 16 bytes in a standard 16550A UART=2E In=
=20
>> older UARTs (or emulated older UARTs) you might not have a buffer at=20
>> all=2E To print more than a handful of bytes, you need to poll for the=
=20
>> THRE bit=3D1 (bit 5 of register 5)=2E
>
>Emulated UARTs are generally fine because they don't really emulate the
>buffer at all=2E And when I originally wrote this it was purely a hack to
>debug an issue for myself, and used a different type of logging device
>altogether=2E
>
>But yeah, if this were to be used on bare metal 16550A it would indeed
>need to wait for space in the FIFO/THR=2E
>
>> What is the point of writing this code in assembly in the first place? =
A=20
>> much more logical thing to do is to just push the registers you haven't=
=20
>> pushed already onto the stack and call a C function to do the actual=20
>> dumping? It isn't like it is in any shape, way or form performance crit=
ical=2E
>
>If we fix it up to use a proper linker script, that's slightly more
>feasible=2E=C2=A0As things stand, it's only really possible to do it in t=
he
>existing asm file=2E=20
>
>And it's only the core of the exception handler "function" which could
>be moved out to C; it didn't seem particularly worth bothering=2E Would
>be nice to have the IDT generated from C code *before* calling
>relocate_kernel() instead of inside relocate_kernel itself, perhaps,
>but I was also trying to keep the #define DEBUG version of the code
>fairly self-contained=2E
>
>

Yes, the linker script needs to happen=2E=20

This is a case of doing it right vs doing it quickly=2E

