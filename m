Return-Path: <linux-kernel+bounces-564908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC42A65CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F093BAD2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1EC1F4170;
	Mon, 17 Mar 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oIhIyey4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC71DDC16
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236481; cv=none; b=Kcsi1NObgI8u6xFo/ybeDD45mxAXODCh4dcnN25/t/mzKMsrl0V3bP2QBhk5UmmHHAD6poflB3Df+vHcNpVDUAMhZzWRl/dOd8+zC8S4NqShR6u8JAD10XBbTv8mP9STx4zHg1UaR8WjdO74pVmplk6I8ZWh9awrT8991MTEgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236481; c=relaxed/simple;
	bh=WPvFh0iTwaqlqrtPgeJtgbfDX2prTYQSc37gvTNIaFI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Rm8clMrx4iVxCOsE4neXAsvn6eTQ6I4KFYkUEzZjr1FcuE9N3PbZowSdosx+5hcvpZre1G9Fmk/MAZRzANwD3LEWOQWtfaAXDPQ2bMFn5gjNjK7wW8cyGYrDhNg1U3BE6HVrYslS3IpPFzvHjzbZvauZQ+j8b7zXnyhVBynzxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=oIhIyey4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52HIYEpx662912
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 11:34:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52HIYEpx662912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742236455;
	bh=gTyUfoKni7BCQJ49qIT4dxeTpJNfoERL9pZV1Bp47vg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oIhIyey4n7dEWOgxW9LGIfHeSLP0j6WVRXf/W5+pszTbLpp0p9AlzvAEgyFRjqZqn
	 WWCQgvKTY1Nm9LeDkUp+MDXUymJwAaURPjLMkAAFqixnD55Ny3bpKweoq5xXkJu0BE
	 5M2nV0zMcLIBzwbppzczuCpEVaKOMIb2+kKMXlGSz9WIpvsaW9DWV1T/vPrPeSxtkh
	 yJMnb/fakcpDZ+yVLOnlVTDdZk1NOiwX8O5RVl5sIOeEcQnf9d7xRvjTuym/SNgsZs
	 CBsttdjKCkaGD+dEHqv5+cW2UuO38dxdHxdtqGTvWcLPqMnfQ9YcYpc+gFanejRKk9
	 8LAiErH6jukig==
Date: Mon, 17 Mar 2025 11:34:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/asm=3A_Use_asm=5Finline=28=29?=
 =?US-ASCII?Q?_instead_of_asm=28=29_in_=5F=5Funtagged=5Faddr=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z9fk2NMBRHB9Eu5h@gmail.com>
References: <20250314093111.654359-1-ubizjak@gmail.com> <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local> <Z9fk2NMBRHB9Eu5h@gmail.com>
Message-ID: <E54655B6-6E91-492E-A4DA-1A6378CC03A1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 2:01:12 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* Borislav Petkov <bp@alien8=2Ede> wrote:
>
>> On Fri, Mar 14, 2025 at 10:30:55AM +0100, Uros Bizjak wrote:
>> > Use asm_inline() to instruct the compiler that the size of asm()
>> > is the minimum size of one instruction, ignoring how many instruction=
s
>> > the compiler thinks it is=2E ALTERNATIVE macro that expands to severa=
l
>> > pseudo directives causes instruction length estimate to count
>> > more than 20 instructions=2E
>> >=20
>> > bloat-o-meter reports minimal code size increase
>>=20
>> If you see an increase and *no* *other* *palpable* improvement, you=20
>> don't send it=2E It is that simple=2E
>
>Sorry, but you wouldn't be saying that eliminating function calls is=20
>not a 'palpable improvement', had you ever profiled a recent kernel on=20
>a real system, on modern CPUs =2E=2E=2E :-/
>
>The sad reality is that the top profile is dominated by function call +=
=20
>return overhead due to CPU bug mitigation workarounds that create per=20
>function call overhead:
>
> Overhead  Shared Object               Symbol
>   4=2E57%  [kernel]                    [k] retbleed_return_thunk <=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D !!!!!!!!
>   4=2E40%  [kernel]                    [k] unmap_page_range
>   4=2E31%  [kernel]                    [k] _copy_to_iter
>   2=2E46%  [kernel]                    [k] memset_orig
>   2=2E31%  libc=2Eso=2E6                   [=2E] __cxa_finalize
>
>That retbleed_return_thunk overhead gets avoided every time we inline a=
=20
>simple enough function=2E
>
>But GCC cannot always do proper inlining decisions due to our=20
>complicated ALTERNATIVE macro constructs confusing the GCC inliner:
>
>  > > ALTERNATIVE macro that expands to several pseudo directives causes=
=20
>  > > instruction length estimate to count more than 20 instructions=2E
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>Note how the asm_inline() compiler feature was added by GCC at the=20
>kernel community's request to address such issues=2E (!)
>
>So for those reasons, in my book, eliminating a function call for=20
>really simple single instruction inlines is an unconditional=20
>improvement that doesn't require futile performance measurements - it=20
>'only' requires assembly level code generation analysis in the=20
>changelog=2E
>
>The reason is that requiring measurable effects for really small=20
>inlining changes is pretty much impossible in practice=2E I know, because=
=20
>I tried, and I'm good at measuring such things and I have the hardware=20
>to do it=2E Yet the per function call overhead demonstrated above in the=
=20
>profile is very much real and should not be handwaved away=2E
>
>Note that this policy doesn't apply to other inlining decisions, only=20
>to single-instruction inline functions=2E
>
>Also, having said all that, for this particular patch I'd still like to=
=20
>see a bit more GCC code generation analysis in this particular=20
>changelog: could you please cite a single relevant, representative=20
>example before/after assembly code section that demonstrates the=20
>effects of the inlined asm versus function call version, including the=20
>function that gets called?
>
>I'm asking for that because sometimes single instructions can still=20
>have a halo of half a dozen of instructions that set them up or=20
>transform their results, so sometimes having a function call is the=20
>better option=2E Not all single-instruction asm() statements are 'simple'=
=20
>in praxis - but looking at the code generation will very much tell us=20
>whether it is=2E
>
>Thanks,
>
>	Ingo

I would like to repeat that I would like to see us at least try to #define=
 asm __asm__ __inline__ tree-wide (with a possible opt-out) and run a bench=
mark on it=2E Since this is a central knob, we could even make it a Kconfig=
 option that architectures can opt in or out of, or be overridden for speci=
fic compilers should it ever be necessary=2E

It is simply much closer to how we actually use asm() in the Linux kernel,=
 *and* what performance characteristics we tend to care about=2E More often=
 than not if we have a large hunk of assembly source it is because of metad=
ata and/or directives=2E

It doesn't hurt that inline duplicating kernel code can occasionally bring=
 about huge improvements in terms of branch eliminations because often (but=
 far from always, of course) the difference in call context allows the comp=
iler to eliminate dead paths=2E=20

    -hpa

