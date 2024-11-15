Return-Path: <linux-kernel+bounces-411318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD4A9CF639
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F515B2E6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1DCA5B;
	Fri, 15 Nov 2024 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsW2616o"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EE1E32B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702738; cv=none; b=Gw8dGjBpq4jSfh8eWPwOOMC8LPHslWnb9hq/BrXuIc/aS73WzWseSnSna4ah4hwZ9xpkVv4YQxtLObmidRz93Xga2I63Ya3TIoqgIrZ6BmzM0iF+kpQmJNIwN9zhiw9nuEtSGfHrMis/EbuVK+XpMbUIBYlezgOKmPZmg8MCp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702738; c=relaxed/simple;
	bh=J8Fypl/nHA6mOU3d05af11z0XoG0PP92s4ikw4P8RT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COHwjpDooPQpO9yptfFi0Zm/+WMmDxWgL6SGY63CWCjylUk18gVJfm94SZIcMTIERyEAA5ziIoEN31WQcBm2zURT0ARL6bvAlSxK7fcSd8oLIID1mwty/xPEKucd9N4T1mbvwC6x8JMH7Gth8YJ4RuySn9BdICjS+qK6/3ZtPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsW2616o; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a745f61654so22525ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731702735; x=1732307535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M7ecWGpU+eDVcuuUaD1x2bJbWrzX8lMZn28D9fpPpM=;
        b=rsW2616o15njWbj3hhotEDVR+CRYcDvhrJ8WWeYbkJImw1K4yabAS6M9d7ebqe+lhN
         cW22kHvKSFrGonn/112V6bWnBBhv2kLdQKz3uSGU356sAse2/UQwa2T8mYDcp2PVzBag
         8LQy9wikv+erSEPVu+gQu5aw7aRi+LJg03/zNrtYusueuueNWK222UFGc6T1XP5hQX8P
         7cPJ4R0Vbd7nf8ixKl3MJfc/b5IR3mlUOfdbdRhcr++1bswhmEU9bwSKz3y0RjXdiA0W
         /3Nw5boxBkegmIgaiyT+64u/LJj8fdsXzfpSookYUBqYoVSXWCtBfmTYp5dUvIylE8DT
         4+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731702735; x=1732307535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4M7ecWGpU+eDVcuuUaD1x2bJbWrzX8lMZn28D9fpPpM=;
        b=d03do2kNeDJUwk8EzeZFhOUzCljMAQjvf9yAgRyscoy4Oc3xgDs7iTUNOgf8p6Mw2k
         012eOxcePiqtPdAvcn/Ubfrj8N5SunYWVVDsjBT/qj13YYsi9D/FaGJ5heSfOObjx/rv
         jD/nIp5SVEGdhsJ82O+BYqLcEUpLpUFmjsz/JTT0NcBAhIxSlp5+uLz8DyaJtngJA4d3
         Iey0aXO0qax2rvtrtbNT6Qa7npI+lcQwhGVY8si2nTmhulFng9XAbnyK8qEmJ1i0aBYz
         clICO4aCAxSggz+l01JKG7tIIYm0Aol3w2AP95CcYtfKtWy6nIs9lQWnjjt1Fjy4GFhr
         1FSA==
X-Forwarded-Encrypted: i=1; AJvYcCXa7TrLZOBc2TtNCqk5rpXY814GKDg4HGrN0WpV+L7q3CCtlMsTgPKM/pAVOmH1ujdQBJw19SpoafgA898=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTuFu7iuJybx03CVnXutAFUsRSaZmaJxB4DK09WhSZXeH/dAA
	IfLOgPJWd6MKPS9hfn0N14TEYo8ycdgZOKK5VvvdHZD7S0kW0NL2DxKQ5DPjQ9/rzn8bLIicLVm
	CuWjQsF7nzVZuZYcKM4gihxjMv7C7Quk+yZ77
X-Gm-Gg: ASbGncsB9CUKH2jHvHAUIb+8sg3z2b55vRMO7A8T5sTuGGJrCjq+8QXPSEI/VUYVhCl
	AnyCPxvmTonQpiM8KrJqclQIqf1dCEQ==
X-Google-Smtp-Source: AGHT+IEJVkL40vr/KwtP72+84+9C2eLd6jMnb993S3m9bvsUDB728wp1kJC/DoxXCVSrzUHKinSx/W6F5kS6U4TI+Ds=
X-Received: by 2002:a92:c561:0:b0:3a7:4f26:bb63 with SMTP id
 e9e14a558f8ab-3a750de887fmr436945ab.9.1731702735384; Fri, 15 Nov 2024
 12:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113133042.702340-1-davydov-max@yandex-team.ru>
 <20241113133042.702340-3-davydov-max@yandex-team.ru> <2813ba0d-7e5d-03d4-26df-d5283b9c0549@amd.com>
In-Reply-To: <2813ba0d-7e5d-03d4-26df-d5283b9c0549@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 15 Nov 2024 12:32:04 -0800
Message-ID: <CALMp9eT2RMe9ej_UbbeoKb+1hqWypxWswqg2aGodZHC0Vgoc=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: KVM: Advertise AMD's speculation control features
To: babu.moger@amd.com
Cc: Maksim Davydov <davydov-max@yandex-team.ru>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, seanjc@google.com, 
	sandipan.das@amd.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:13=E2=80=AFPM Moger, Babu <bmoger@amd.com> wrote=
:
>
> Hi Maksim,
>
>
> On 11/13/2024 7:30 AM, Maksim Davydov wrote:
> > It seems helpful to expose to userspace some speculation control featur=
es
> > from 0x80000008_EBX function:
> > * 16 bit. IBRS always on. Indicates whether processor prefers that
> >    IBRS is always on. It simplifies speculation managing.
>
> Spec say bit 16 is reserved.
>
> 16 Reserved
>
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/prog=
rammer-references/57238.zip

The APM volume 3 ( 24594=E2=80=94Rev. 3.36=E2=80=94March 2024) declares thi=
s bit as
"Processor prefers that STIBP be left on." Once a bit has been
documented like that, you have to assume that software has been
written that expects those semantics. AMD does not have the option of
undocumenting the bit.  You can deprecate it, but it now has the
originally documented semantics until the end of time.

> > * 18 bit. IBRS is preferred over software solution. Indicates that
> >    software mitigations can be replaced with more performant IBRS.
> > * 19 bit. IBRS provides Same Mode Protection. Indicates that when IBRS
> >    is set indirect branch predictions are not influenced by any prior
> >    indirect branches.
> > * 29 bit. BTC_NO. Indicates that processor isn't affected by branch typ=
e
> >    confusion. It's used during mitigations setting up.
> > * 30 bit. IBPB clears return address predictor. It's used during
> >    mitigations setting up.
> >
> > Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> > ---
> >   arch/x86/include/asm/cpufeatures.h | 3 +++
> >   arch/x86/kvm/cpuid.c               | 5 +++--
> >   2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index 2f8a858325a4..f5491bba75fc 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -340,7 +340,10 @@
> >   #define X86_FEATURE_AMD_IBPB                (13*32+12) /* Indirect Br=
anch Prediction Barrier */
> >   #define X86_FEATURE_AMD_IBRS                (13*32+14) /* Indirect Br=
anch Restricted Speculation */
> >   #define X86_FEATURE_AMD_STIBP               (13*32+15) /* Single Thre=
ad Indirect Branch Predictors */
> > +#define X86_FEATURE_AMD_IBRS_ALWAYS_ON       (13*32+16) /* Indirect Br=
anch Restricted Speculation always-on preferred */
>
> You might have to remove this.

No; it's fine. The bit can never be used for anything else.

> >   #define X86_FEATURE_AMD_STIBP_ALWAYS_ON     (13*32+17) /* Single Thre=
ad Indirect Branch Predictors always-on preferred */
> > +#define X86_FEATURE_AMD_IBRS_PREFERRED       (13*32+18) /* Indirect Br=
anch Restricted Speculation is preferred over SW solution */
> > +#define X86_FEATURE_AMD_IBRS_SMP     (13*32+19) /* Indirect Branch Res=
tricted Speculation provides Same Mode Protection */
> >   #define X86_FEATURE_AMD_PPIN                (13*32+23) /* "amd_ppin" =
Protected Processor Inventory Number */
> >   #define X86_FEATURE_AMD_SSBD                (13*32+24) /* Speculative=
 Store Bypass Disable */
> >   #define X86_FEATURE_VIRT_SSBD               (13*32+25) /* "virt_ssbd"=
 Virtualized Speculative Store Bypass Disable */
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 30ce1bcfc47f..5b2d52913b18 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -754,8 +754,9 @@ void kvm_set_cpu_caps(void)
> >       kvm_cpu_cap_mask(CPUID_8000_0008_EBX,
> >               F(CLZERO) | F(XSAVEERPTR) |
> >               F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F=
(VIRT_SSBD) |
> > -             F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
> > -             F(AMD_PSFD)
> > +             F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_IBRS_ALWAYS_ON) |
> > +             F(AMD_STIBP_ALWAYS_ON) | F(AMD_IBRS_PREFERRED) |
> > +             F(AMD_IBRS_SMP) | F(AMD_PSFD) | F(BTC_NO) | F(AMD_IBPB_RE=
T)
> >       );
> >
> >       /*
>
> --
> - Babu Moger
>

