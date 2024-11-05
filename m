Return-Path: <linux-kernel+bounces-397232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D809BD82A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E404CB2251B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4FB216209;
	Tue,  5 Nov 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gsDCBzTM"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC721441D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844547; cv=none; b=KvWBjeAZRdMOmJJjidlK4dzVII4kC1Ob5Z0jvGtVPkp3nwRKh4QXa6obULvnw742Bk9Oh5C1daM4kC63Kqh3NTrXJO580KhRpxRIz7RjeF92ZSjkt/R70A2dGK7lFtCOHeZLWt1E/n7EvDXWKnKJfcf16Q4OzKmf+sISNNHHpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844547; c=relaxed/simple;
	bh=xEQJl61nQgL9Mc2J5Xlg5+cKjUWmOQVy7uKugjfcPH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gFRkZn+QjzujhwjhTLgItv4TH8OT0iVSCi/zWOxQ2z2mySpsdEn4ddSZefMMWjz+Aev1h1JvoCBOePb2fDYfAptcEcG5+EjnAHmSyoXWRYUMx4M2U8sOkRytGqNfqoMNkHL591tpdT42z7/0Ylt/6npB3c1mqo9yINDOLKiQUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gsDCBzTM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5M8Z5R406734
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 14:08:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5M8Z5R406734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730844516;
	bh=xEQJl61nQgL9Mc2J5Xlg5+cKjUWmOQVy7uKugjfcPH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gsDCBzTMgLM7pK5+rpvw5GMtcFOp95L+gGRAU7IPWJy1jVgM8q4g6wgstxxx5T8Ht
	 uZXhIj34EdJwHof4hiA9vcW1fD53lbFbG79emWuan9T2No50Qgj6JsrahCFakItwwU
	 +W/Q6AgQBRfLznb2T+TYMCSQE5WTizdbOG4MNCsaHNfhhz4KYPb6jKDpdLu+f5EBF2
	 moHWtjVkPk9mgYBpwVwY4OF/pDrJgmQuqmq4wj846VFZa+7wFjs6imOd8FaKrJZox9
	 rTa/tD96J9LLtK9Knavdj6kCViVhQXeBs73fQtDJTIGSXvRixW6ZUwNhFxCPpK0hZY
	 PlKt3OD2W2XLQ==
Date: Tue, 05 Nov 2024 14:08:35 -0800
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
Subject: =?US-ASCII?Q?Re=3A__=5BRFC_PATCH_6/7=5D_x86/kexec=3A_Debuggi?=
 =?US-ASCII?Q?ng_support=3A_Dump_registers_on_exception?=
User-Agent: K-9 Mail for Android
In-Reply-To: <07117fe234cb1396a59bdb815ada26a90e02b394.camel@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org> <20241103054019.3795299-7-dwmw2@infradead.org> <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk> <66DC35BB-A9E5-45E4-AAAD-051C22943F51@zytor.com> <07117fe234cb1396a59bdb815ada26a90e02b394.camel@infradead.org>
Message-ID: <3008CD3D-FF34-4FD1-83EB-DD74398685A5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 5, 2024 1:29:54 PM PST, David Woodhouse <dwmw2@infradead=2Eorg>=
 wrote:
>On Tue, 2024-11-05 at 12:50 -0800, H=2E Peter Anvin wrote:
>> On November 5, 2024 12:38:10 PM PST, "Woodhouse, David" <dwmw@amazon=2E=
co=2Euk> wrote:
>> > On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
>> > >=20
>> > > +
>> > > +/* Print the byte in %bl, clobber %rax */
>> > > +SYM_CODE_START_LOCAL_NOALIGN(pr_byte)
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 movb=C2=A0=C2=A0=C2=A0 %bl, %=
al
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nop
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 andb=C2=A0=C2=A0=C2=A0 $0x0f,=
 %al
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addb=C2=A0=C2=A0=C2=A0 $0x30,=
 %al
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmpb=C2=A0=C2=A0=C2=A0 $0x3a,=
 %al
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1f
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addb=C2=A0=C2=A0=C2=A0 $('a' =
- '0' - 10), %al
>> > > +1:=C2=A0=C2=A0=C2=A0=C2=A0 pr_char
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ANNOTATE_UNRET_SAFE
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret
>> > > +SYM_CODE_END(pr_byte)
>> > > +
>> >=20
>> > Obviously that function name (and comment) are wrong; fixed in my tre=
e=2E
>> > at
>> > https://git=2Einfradead=2Eorg/users/dwmw2/linux=2Egit/shortlog/refs/h=
eads/kexec-debug
>> >=20
>> > This function (and also pr_qword) are also what objtool is complainin=
g
>> > about:
>> >=20
>> > vmlinux=2Eo: warning: objtool: relocate_range+0x2f6: unreachable inst=
ruction
>> > vmlinux=2Eo: warning: objtool: relocate_range+0x305: unreachable inst=
ruction
>> >=20
>> > I don't quite see why, because pr_qword() quite blatantly calls
>> > pr_nyblle(), as it's now named=2E And exc_handler() repeatedly calls
>> > pr_qword()=2E
>> >=20
>> > But most of the objtool annotations I've added here were just to make
>> > it shut up and build, without much though=2E Peter, Josh, any chance =
you
>> > can help me fix it up please?
>> >=20
>> > It would also be really useful if objtool would let me have data insi=
de
>> > a "code" segment, without complaining that it can't decode it as
>> > instructions =E2=80=94 and without also failing to decode the first i=
nstruction
>> > of the *subsequent* function=2E I've put the GDT at the end to work
>> > around that, but it's a bit nasty=2E
>>=20
>> code in the data *section* or *segment*? Either is nasty, though=2E Tha=
t's what =2Erodata is for=2E
>
>This is the relocate_kernel() function in
>arch/x86/kernel/relocate_kernel_64=2ES
>
>It's copied into a separate page, called (in its original location) as
>a simple function from the kernel, changes %cr3 to set of identity-
>mapped page tables and jumps to its *identity-mapped* address, then
>copies all the right pages for kexec and jumps into the new kernel=2E
>
>So it's all in a single page, and currently it plays nasty tricks to
>store data after the code=2E Perhaps it *should* have its own code and
>data sections and a linker script to keep them together=2E=2E=2E

Yes, it should=2E

