Return-Path: <linux-kernel+bounces-184310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B548CA539
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54CD1C211A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFD1384B1;
	Mon, 20 May 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mIUa6X+L"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526921847;
	Mon, 20 May 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248867; cv=none; b=JC9TojS6w//7MdfSDpQOx19+sM74OH2QsmWact3QapjOEvNJvjR01P+bTbG+EeZ0eqin03DmDafhXrLJVw0QKvQUbPkbBh/DBpuiMOsxuj1nEzy2+dZK6fMy+LnXG5K8ef9cW6Bc9AA9TZVorCDHObJnvFZYKmb4WAJ5PtEjIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248867; c=relaxed/simple;
	bh=4+IgDyg4B7yPfEuQUJAjaTTUe81gU2anEh+MnGPtiHw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZhrVxEwOmuizdqmg4RtXQg/CBVT9gjG9gNGWug/OFpKSn8LIrNakD11Gh1HBTUjrANnLaTOwC60Jy4XZZuWouUKmBbklnAF3kv4X0BKHwvs8vvIywCFY47Ui8pZ6Acn+Z+8HQu0WzPl5o/tlJTAPKQyGCGIE98sWqQrw6UO4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=mIUa6X+L; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716248855;
	bh=ZYBdGVZXsgtnUlETh21xLRTd4U6kYhG6FJAmkGjakT0=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=mIUa6X+LmfwXcoS/EPpABQ7W3oDXcRNGkwfGKvWhXgQOI5WdEhXy439lwCgXzf4bd
	 PZHhyLc47+wcR3WH34AlEN1gyB5jP2yYf//mQ1ZfQ4s/n+mt0b7kqNDicE6GRty60u
	 r/8t9FZLqwc3592okM3VN1r1kZLfufXeYTMH0x9+QtEuZZcaBO3veXaFCrKfPH1Ggr
	 r5SyX1fm2FJ0RaMRhIPlikWrewW/BaIT6sV60jhkRyJz+XyMLbmLXu9dD+ZolWjWs9
	 bp7xPxBWoUjsOnwSMpKH2NQfYfmdZ2rZhX5FXtfWyZFBzaGVwGiA2CDbS8ROR3Rw/t
	 6y07XQ8KszD2A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjvPg3CGCz4wb1;
	Tue, 21 May 2024 09:47:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geoff Levand
 <geoff@infradead.org>, cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: CVE-2023-52665: powerpc/ps3_defconfig: Disable
 PPC64_BIG_ENDIAN_ELF_ABI_V2
In-Reply-To: <2024052016-footnote-smelting-842e@gregkh>
References: <2024051725-CVE-2023-52665-1d6f@gregkh>
 <87zfslufoo.fsf@mail.lhotse>
 <d8c56e37-38c6-454e-81be-a574b42c83be@infradead.org>
 <2024052016-footnote-smelting-842e@gregkh>
Date: Tue, 21 May 2024 09:47:33 +1000
Message-ID: <8734qc3v1m.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Mon, May 20, 2024 at 05:35:32PM +0900, Geoff Levand wrote:
>> On 5/20/24 16:04, Michael Ellerman wrote:
>> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> >> Description
>> >> ===========
>> >>
>> >> In the Linux kernel, the following vulnerability has been resolved:
>> >>
>> >> powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2
>> >>
>> >> Commit 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian
>> >> builds"), merged in Linux-6.5-rc1 changes the calling ABI in a way
>> >> that is incompatible with the current code for the PS3's LV1 hypervisor
>> >> calls.
>> >>
>> >> This change just adds the line '# CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not set'
>> >> to the ps3_defconfig file so that the PPC64_ELF_ABI_V1 is used.
>> >>
>> >> Fixes run time errors like these:
>> >>
>> >>   BUG: Kernel NULL pointer dereference at 0x00000000
>> >>   Faulting instruction address: 0xc000000000047cf0
>> >>   Oops: Kernel access of bad area, sig: 11 [#1]
>> >>   Call Trace:
>> >>   [c0000000023039e0] [c00000000100ebfc] ps3_create_spu+0xc4/0x2b0 (unreliable)
>> >>   [c000000002303ab0] [c00000000100d4c4] create_spu+0xcc/0x3c4
>> >>   [c000000002303b40] [c00000000100eae4] ps3_enumerate_spus+0xa4/0xf8
>> >>
>> >> The Linux kernel CVE team has assigned CVE-2023-52665 to this issue.
>> > 
>> > IMHO this doesn't warrant a CVE. The crash mentioned above happens at
>> > boot, so the system is not vulnerable it's just broken :)
>> 
>> As Greg says, with PPC64_BIG_ENDIAN_ELF_ABI_V2 enabled the system won't
>> boot, so there is no chance of a vulnerability.
>
> The definition of "vulnerability" from CVE.org is:
> 	An instance of one or more weaknesses in a Product that can be
> 	exploited, causing a negative impact to confidentiality, integrity, or
> 	availability; a set of conditions or behaviors that allows the
> 	violation of an explicit or implicit security policy.
>
> Having a system that does not boot is a "negative impact to
> availability", which is why this was selected for a CVE.  I.e. if a new
> kernel update has this problem in it, it would not allow the system to
> boot correctly.

I think the key word above is "exploited", implying some sort of
unauthorised action.

This bug can cause the system to not boot, but only by someone who
builds a new kernel and installs it - and if they have permission to do
that they can just replace the kernel with anything, they don't need a
bug.

> But, if the maintainer of the subsystem thinks this should not be
> assigned a CVE because of this fix, we'll be glad to revoke it.
>
> Michael, still want this revoked?

Yes please.

cheers

