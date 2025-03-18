Return-Path: <linux-kernel+bounces-567026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B729A68007
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532D0179FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A892080CB;
	Tue, 18 Mar 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyKgCIjc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E42063FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338264; cv=none; b=Ya6F90/wFP0lHBbCun5WBMH0MVdPROYEvtgVSnWCMVEzPSXvRcLBnBF9GAj+Bxe2ETkgp/UcGMQhAL9mqg5xFb9UObQlFYZdqAuGzyX62pkMlgQc5viXVHwh0VnY4/qEY/N9VLOIRZ+qRAJ6BR9BM4ODZyL1mRca5W2dVqIK/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338264; c=relaxed/simple;
	bh=5JsY5kzeeVV9IKOJ7hjTitZd3WFgsVSd6JbwqjZi1v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUc91rAplxQahuXr0x5F7ODYF5LrvdXGrLsLO8gb88o/vuajUocKl6zPqkVWraPQu8+yli/X6W4xmqxe3cCsb4rc+U2nhOJdsw2gD+6RvBIgHTl3DXQU8OqsDHlVMIkHHtxGgs9OFWXLK5qQBGR9nd9sGdyRfMgsRsOfKDFiMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyKgCIjc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742338261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsmu6T+1+dv2MCs51ZZF2e4bokv0aMdp33X3M58RRE0=;
	b=GyKgCIjcDCXuIMB7G2M46fUQqzm8Cy63jlRpbXdyd6QQNmIIuyCiJgwsutFKOtM6G1DLhD
	uck1hbJAo2D0Ybb4UsSJLhj/rsTF4MnKMi4MN/EsNEviIP0wDkXg+zDTC2J16gicK3kTzg
	8ddGdNjeeIQnS6IfwX0Q8lADI1XUOIA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-hiRVRlIdP5ORLEwtHRy2Sg-1; Tue, 18 Mar 2025 18:50:59 -0400
X-MC-Unique: hiRVRlIdP5ORLEwtHRy2Sg-1
X-Mimecast-MFC-AGG-ID: hiRVRlIdP5ORLEwtHRy2Sg_1742338258
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30bee135e9cso43259991fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338253; x=1742943053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsmu6T+1+dv2MCs51ZZF2e4bokv0aMdp33X3M58RRE0=;
        b=q9SnZMd2Ma4Yp4Egtyt0CEkzkxfhIjPBJAb791OJXScFJorWbVNoku2t21K56AVUK6
         Db/vDdn4bMhN+5uDthc5st5PzRaQJoQ85f0nHS0+k2+tYFWNGvEPJu0jRyBNLaKtbU8o
         oj+gS29xT1nljW06DVOHQ6IUQcop41UYNdKyka8H9ZGJJhleBkDjtusRNM2FPND8HxET
         3Tr/2n7yS4GD3I9njkMYsO2sViuSFUxqOcfrpiKr6lKpxmiAIPMO+5WJ0gIJE2WWK8pw
         fQYjonuUfOJI2To9GPPI6esubBeZ8b2QO06rPyoElLBCzWhm+RT9U4DgA0DzXJGk/9Ow
         xmPw==
X-Forwarded-Encrypted: i=1; AJvYcCW5xXHf1zllwTSWXNcrqUDPbLpah3toBbPXAjhloLuXcqTrEGpaXsYntP1UkNGwcw0NgzOy/anm++1cPUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZtc54MSF3IKOHFp7TJZcmmWEfjoWlITNdeortrnL00FsLwUD
	DLgNcrrPkl5ec9n6ceXgospnGKl2CrXVCsh4btiAgUWSoQcSOsRWIjy5M5aZHbKL3+b6ztzf/Lm
	YJgE/Ue4vWfwEUVvKAN8CFhn1yyELijp09POj5QWb1v5R5eY6cYLe6NdStNpNriFY9Ib2RURcNZ
	coyChnY3wSCf+1Vqxr05no9n2vG0lObRghDxiE
X-Gm-Gg: ASbGncsrjdhV6r5K0t9TqSHON5sfV4Sgb/IDfgF1/tBtI1MJxBlLQwHVJxIv6ewftGU
	byE1nVXz6fSsSn7xx3BJgrSAJG2QqLaLZq/IaqtzD8b4L6oKBX8MFSOQpb7+KNkVpNnydfmFgGq
	ISxfXWWw2+NxrIk7bkOtiTxt9N10MTSg==
X-Received: by 2002:a05:651c:1a0a:b0:30c:2da4:85fb with SMTP id 38308e7fff4ca-30d6a3e4c23mr1875481fa.12.1742338253112;
        Tue, 18 Mar 2025 15:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEklV7KyD3W8eqYoLqeUIVwGxuMduE4ZIUtuAAz9A3+uINO4GoCJdHvwwuWuyZJxvrTgDacoyqyrfMNPbA+f10=
X-Received: by 2002:a05:651c:1a0a:b0:30c:2da4:85fb with SMTP id
 38308e7fff4ca-30d6a3e4c23mr1875371fa.12.1742338252689; Tue, 18 Mar 2025
 15:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314175309.2263997-1-herton@redhat.com> <20250314175309.2263997-2-herton@redhat.com>
 <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
 <CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
 <Z9au20vtMSXCbdXu@gmail.com> <Z9axe9Ac5biyJjCC@gmail.com> <20250318215926.0a7fd34e@pumpkin>
In-Reply-To: <20250318215926.0a7fd34e@pumpkin>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Tue, 18 Mar 2025 19:50:41 -0300
X-Gm-Features: AQ5f1JpgMsDHI_xRkb6D-oPNHzXD6LcgF4_GTRfqdm1wyWHx4Dx6OVfM6BKLEMA
Message-ID: <CAJmZWFGOc_HR2xrD_L9PADmfWP=Sg9v3-yeDRdiw=mhD_BSwww@mail.gmail.com>
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8 bytes
 in copy_user_generic()
To: David Laight <david.laight.linux@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	olichtne@redhat.com, atomasov@redhat.com, aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:59=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 16 Mar 2025 12:09:47 +0100
> Ingo Molnar <mingo@kernel.org> wrote:
>
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > > > It does look good in my testing here, I built same kernel I was
> > > > using for testing the original patch (based on 6.14-rc6), this is
> > > > one of the results I got in one of the runs testing on the same
> > > > machine:
> > > >
> > > >              CPU      RATE          SYS          TIME     sender-re=
ceiver
> > > > Server bind   19: 20.8Gbits/sec 14.832313000 20.863476111 75.4%-89.=
2%
> > > > Server bind   21: 18.0Gbits/sec 18.705221000 23.996913032 80.8%-89.=
7%
> > > > Server bind   23: 20.1Gbits/sec 15.331761000 21.536657212 75.0%-89.=
7%
> > > > Server bind none: 24.1Gbits/sec 14.164226000 18.043132731 82.3%-87.=
1%
> > > >
> > > > There are still some variations between runs, which is expected as
> > > > was the same when I tested my patch or in the not aligned case, but
> > > > it's consistently better/higher than the no align case. Looks
> > > > really it's sufficient to align for the higher than or equal 64
> > > > bytes copy case.
> > >
> > > Mind sending a v2 patch with a changelog and these benchmark numbers
> > > added in, and perhaps a Co-developed-by tag with Linus or so?
> >
> > BTW., if you have a test system available, it would be nice to test a
> > server CPU in the Intel spectrum as well. (For completeness mostly, I'd
> > not expect there to be as much alignment sensitivity.)
> >
> > The CPU you tested, AMD Epyc 7742 was launched ~6 years ago so it's
> > still within the window of microarchitectures we care about. An Intel
> > test would be nice from a similar timeframe as well. Older is probably
> > better in this case, but not too old. :-)
>
> Is that loop doing aligned 'rep movsq' ?
>
> Pretty much all the Intel (non-atom) cpu have some variant of FRSM.
> For FRSM you get double the throughput if the destination is 32byte align=
ed.
> No other alignment makes any difference.
> The cycle cost is per 16/32 byte block and different families have
> different costs for the first few blocks, after than you get 1 block/cloc=
k.
> That goes all the way back to Sandy Bridge and Ivy Bridge.
> I don't think anyone has tried doing that alignment.

The code under copy_user_generic() has mainly two paths, first is FSRM
case where rep movsb is used right away. Otherwise rep_movs_alternative
is used: with 8 bytes or less byte by byte copy is used, between 8-64 bytes
word/8byte copy is used, and for greater or equal than 64 bytes either
rep movsb is used for cpus with ERMS or rep movsq is used when without.
The last case is what Linus' patch touches. And the last case also falls ba=
ck
to byte by byte copy for the tail of the copy/remaining bytes if any.

For Intel, I was looking and looks like after Sandy Bridge based CPUs
most/almost all have ERMS, and FSRM is something only newer ones have.
So the way back to Ivy Bridge is ERMS and not FSRM.

The patch as expected does not affect newer/last decade Intel CPUs,
since they have ERMS, and will use rep movsb for large copies. The
only Intel CPU I found that runs the code for the alignment case (which
is the last rep movsq case) is a Sandy Bridge based system here
which does not have either erms/fsrm, I tested on one today and saw
no difference at least in my iperf3 benchmark I'm using, so far only the
AMD I tested seems to benefit from the alignment in the case I tested
in practice, and the others I tested don't regress/get worse but no
benefits either.

I also tried the 32 byte write alignment on the same Sandy Bridge based
CPU, I hope to have got the code correct:

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index fc9fb5d06174..75bf7e9e9318 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -74,6 +74,36 @@ SYM_FUNC_START(rep_movs_alternative)
        _ASM_EXTABLE_UA( 0b, 1b)

 .Llarge_movsq:
+       /* Do the first possibly unaligned word */
+0:     movq (%rsi),%rax
+1:     movq %rax,(%rdi)
+2:     movq 8(%rsi),%rax
+3:     movq %rax,8(%rdi)
+4:     movq 16(%rsi),%rax
+5:     movq %rax,16(%rdi)
+6:     movq 24(%rsi),%rax
+7:     movq %rax,24(%rdi)
+
+       _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 2b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 4b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 5b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 6b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 7b, .Lcopy_user_tail)
+
+       /* What would be the offset to the aligned destination? */
+       leaq 32(%rdi),%rax
+       andq $-32,%rax
+       subq %rdi,%rax
+
+       /* .. and update pointers and count to match */
+       addq %rax,%rdi
+       addq %rax,%rsi
+       subq %rax,%rcx
+
+       /* make %rcx contain the number of words, %rax the remainder */
        movq %rcx,%rax
        shrq $3,%rcx
        andl $7,%eax

But the code above doesn't perform better than the 8byte only
alignment on the Intel CPU (it's Xeon E5-2667).

I also tested the Linus' patch on other Intel CPU with ERMS (Xeon(R)
Platinum 8280) and there is no difference with/without the patch
as expected. However, I'll try to do a test with alignment before the
rep movsb (erms) in the large case, to see if there is any difference, but
I think the result will be the same as Sandy Bridge.

It takes some time to do all the testing/setup, thus I'm almost settling on
the 8 byte only alignment that was sent by Linus and I validated
already, since I'm so far unable to get better results with other
approaches/trials
If you have any patch you want to be tested let me know and I can apply and
run against my iperf3 test case.

>
> I'm sure I've measured misaligned 64bit writes and got no significant cos=
t.
> It might be one extra clock for writes than cross cache line boundaries.
> Misaligned reads are pretty much 'cost free' - just about measurable
> on the ip-checksum code loop (and IIRC even running a three reads every
> two clocks algorithm).
>
> I don't have access to a similar range of amd chips.
>
>         David
>
> >
> > ( Note that the Intel test is not required to apply the fix IMO - we
> >   did change alignment patterns ~2 years ago in a5624566431d which
> >   regressed. )
> >
> > Thanks,
> >
> >       Ingo
> >
>


