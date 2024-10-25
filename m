Return-Path: <linux-kernel+bounces-382194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA79B0A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C988D1C212C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017171FB89E;
	Fri, 25 Oct 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CXIUNykN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011218C915
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876413; cv=none; b=Fcq4IdY+iDb8H5uN4VB7DJHTB18QM5HPZ+j0+8q2o5xkx+zAR13a6SXXUgxSDV2DBFjLurB7asWhrG1H/RAftvC1fy6PybPFOlRBGz9sdq1nmf8Xnot+cxu4Abdt9yeBJnb/587W4jVZz4GIxTNYIkRC0peApMVKBXmGC02nesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876413; c=relaxed/simple;
	bh=K1t3uPGvsw4NA/OFXB3zfrWTMideA/6UQLKOLynjvLE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bEk82pYKwVX0A5/BDRfQWhQy3rtmoXabWHkasCQvgmbHFFfSNu//niZ08l1+phuwwnI0uBZCxJH4dEwZllHr/nSn80W1dFjQv/O8JFzVmG9LmapLspCLhrYyrj6fYFHG4RjOxKbEq3MMzkGYxC08GKLLPSZixpLWYpEuze4pt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CXIUNykN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49PHCxfF2356392
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 25 Oct 2024 10:13:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49PHCxfF2356392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729876380;
	bh=TQ1DYqNwBtcHgct2/QBjjV5Y8S/AuYm1Yds1VBY+b9w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CXIUNykNH2KIgTFbBaxIBLh+DljitgpbewTWVVCmlhCs3iZNPTfTTMN2obdwUbKPA
	 /DaO9qKDnyFdf8bFBsMWLNT86Mar/bhVpdLFAivx4WgS+ysw+18efejgITrb/RCI+F
	 Q3U/vnTjsuDHHGTcg4BSvCEGjNJisbTp2mwexZsYO6la71nwGW2WFrTsl/HvNfOHov
	 5HkaL601rR6EEmVUAkhpimtJbUnda2GEDaesCDNoJOdcTtYNMFHAq/AwlRc0Cd8mj4
	 /uArdO+Sfutp++yyF7qwBBZtvtuLDR/M/SutjnASNbnxFA1uhTD01o+Yaid5/5Zm4G
	 Eo/KtWdXsRG0Q==
Date: Fri, 25 Oct 2024 10:12:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, Dave Hansen <dave.hansen@intel.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com>
References: <20241007083345.47215-1-ubizjak@gmail.com> <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com> <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com>
Message-ID: <12E72F30-EF1D-4A1B-9D71-3A7FD5AF343C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 24, 2024 9:20:01 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote=
:
>On Thu, Oct 24, 2024 at 5:21=E2=80=AFPM Dave Hansen <dave=2Ehansen@intel=
=2Ecom> wrote:
>>
>> On 10/7/24 01:33, Uros Bizjak wrote:
>> > Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
>> > to use optimized implementation and ease register pressure around
>> > the primitive for targets that implement optimized variant=2E
>>
>> Ease register pressure at the end of a syscall?
>>
>> I'll accept that we're doing this just as a matter of hygiene=2E  But i=
t's
>> a stretch to say there are any performance concerns whatsoever at the
>> end of the ioperm() syscall=2E
>>
>> So what is the real reason for this patch?
>
>Please see code dumps for i386, a target that implements atomic64_inc_ret=
urn():
>
> 1a9:    8d 04 95 04 00 00 00     lea    0x4(,%edx,4),%eax
> 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
>            1b1: R_386_32    =2Ebss
> 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
> 1b8:    31 d2                    xor    %edx,%edx
> 1ba:    b8 01 00 00 00           mov    $0x1,%eax
> 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
>            1c0: R_386_PC32    atomic64_add_return_cx8
> 1c4:    89 03                    mov    %eax,(%ebx)
> 1c6:    89 53 04                 mov    %edx,0x4(%ebx)
>
>vs=2E improved:
>
> 1a9:    8d 04 95 04 00 00 00     lea    0x4(,%edx,4),%eax
> 1b0:    be 00 00 00 00           mov    $0x0,%esi
>            1b1: R_386_32    =2Ebss
> 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
> 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
>            1b9: R_386_PC32    atomic64_inc_return_cx8
> 1bd:    89 03                    mov    %eax,(%ebx)
> 1bf:    89 53 04                 mov    %edx,0x4(%ebx)
>
>There is no need to initialize %eax/%edx register pair before the
>"call" to atomic64_inc_return() function=2E The "call" is not an ABI
>function call, but an asm volatile (which BTW lacks
>ASM_CALL_CONSTRAINT), so there is no ABI guarantees which register is
>call-preserved and which call-clobbered=2E
>
>Oh, this is the "return" variant -  the function indeed returns the
>new value in %eax/%edx pair, so the difference is only in the
>redundant register initialization=2E I can reword the commit message for
>this case to mention that an initialization of register pair is spared
>before the call=2E
>
>Uros=2E
>

What does ASM_CALL_CONSTRAINT actually do *in the kernel*, *for x86*? Ther=
e isn't a redzone in the kernel, and there *can't* be, because asynchronous=
 events can clobber data below the stack pointer at any time=2E=20

With FRED that is no longer true and we could use the redzone in the kerne=
l, but such a kernel would not be able to boot on a legacy CPU/VMM, and is =
only applicable for 64 bits=2E

This by itself is a good enough reason to be good about this, to be sure, =
but one of the reasons I'm asking is because of older versions of gcc where=
 "asm goto" is incompatible with output constraints=2E

