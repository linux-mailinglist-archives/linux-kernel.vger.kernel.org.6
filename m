Return-Path: <linux-kernel+bounces-246999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC792C9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5631C21F19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8417482CD;
	Wed, 10 Jul 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWK+uMRc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63863BBED
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584916; cv=none; b=B2Yj9Y2T3yG/YBpnbqFBSduDKLmvuSMA9UfOHBxum5SZUIgdJBDHC0x9wD/la13UWpT3u+lMxgSR16kqRnVayyAj9SviadQ0N14TEyobtbJgol2RhuCiSB/On+jF6UL1O5Sotd9U4+WwyMPweRqpOqAEbiK2RyrEPNIkXfMZyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584916; c=relaxed/simple;
	bh=EP3XP2RqyMjR1bWF8+EZeFVP9tQdMpkOo9LFrIYymVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6w/oBV27UxPqGGuaBBO5sw93wOSu/3G4sKYg5PznCAv+L5/niYkLQtaNZn7rxvqxDmsAzs0sPO8cJ4E4grJZ6WJ9uh3JOw4ZN7ZNAlip0Sbp0tUg6hiUY4Pir93OFEDGo6qH5DlagRrr+0WihhY7c/9Ph2LDz71w4qXcjiYHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWK+uMRc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb10519ae3so74225ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 21:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720584914; x=1721189714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBMZIwaTbFdPQIwOn4ejrolH99aL4wDqE56DF4mxNfc=;
        b=EWK+uMRc8Yq5oc3F78V+41w3eKPXsNDIsXfAneGPHpNe6GX/GkQ83//8Pck7L9ss0o
         OCwOkQGTrY6+M1OrGmZVos2HQKWBuOWNG2uAdnLzeDqDmavMnn0H0WOBL2mmUW0e0J4K
         w39WQYfWGfgj1AJpwFIZAgeUAEw5DXDxb6eZwf6/LGMbWNrfGTt5gr1VF4Vcq5XdvAXo
         7/IgQ/dNt2iZMx3n0Xux9/XCtIbKu3EFXRa70HmODC9lMsu/ff+7ol6ImwH5Hiuz/gl3
         lFrfnAO/qWf9mA4ibqA6MBEbIg/Rh7zd58wU1N4j4WuHBRi9Wud3XtQPI3IJL6HWhnfJ
         0PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584914; x=1721189714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBMZIwaTbFdPQIwOn4ejrolH99aL4wDqE56DF4mxNfc=;
        b=d0LcP0FuRSvIGHvLByoLnWO+KoGCvl2PFbqUu8jh17lVfC6HXCv8n4Ca6rT7WhtSdf
         G2FPN6H7K65rPjScW9Fpn6qXxjKDIMPCxeU10iVDs4xt3HgtKByzWhu9hr3PvYP/TcqF
         A+F5avC/1/RGeyVeWlNNHobho1I72e/ZkltCaABFHXtCjs4IJ/nGhlWdc7+VH1peKodD
         86Xxdbd4n7FZTUcxiwEPsFUx4VYFZWxOeBHQw5KRktdOzTth79Qkc0a817t6QpD+IaXD
         cvm0QzpR67rObNxJPngP8emOuTvsgD2UMjXRzUBq+O5eX+vRLkoZI1NQsBv6+HLfuZ6o
         r7hw==
X-Forwarded-Encrypted: i=1; AJvYcCUw+WfZUe5dGn/SZpmMbvEJMn27oZP14WsNgeS6+iiJU4qobQaGxNLtpYQdpexRzsdCekG63Ry537pRS7WG0K9k5nk9BTFHyK7yYqLO
X-Gm-Message-State: AOJu0Yx55QAobCAtjAtK5x8yyGeljC8BrCjCDCKmU41GGWXMgzI4C66F
	WKHp2KboLToGie1TbsVzEm91X6/vTO2JB6Znnq4MCfFsrCYtr9Yx3tu5OxxIu3Ht1CI0x2+nx2b
	TeKpEVop0Qkn8M6T/7uACqPISRyqlXeeDjxh2
X-Google-Smtp-Source: AGHT+IF3IDIWCCec2RfUCakatsKWIBdPZYyjUa04VMhwWsKCwFvt9Gq8ZOW9ZSS2kEbadxTnfJfd0lsqX/PUHkm1qNk=
X-Received: by 2002:a17:903:2003:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-1fbce1391d4mr1250165ad.5.1720584913703; Tue, 09 Jul 2024
 21:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429060643.211-1-ravi.bangoria@amd.com> <20240429060643.211-4-ravi.bangoria@amd.com>
 <Zl5jqwWO4FyawPHG@google.com> <e1c29dd4-2eb9-44fe-abf2-f5ca0e84e2a6@amd.com>
 <ZmB_hl7coZ_8KA8Q@google.com> <59381f4f-94de-4933-9dbd-f0fbdc5d5e4a@amd.com>
 <Zmj88z40oVlqKh7r@google.com> <0b74d069-51ed-4e5e-9d76-6b1a60e689df@amd.com>
In-Reply-To: <0b74d069-51ed-4e5e-9d76-6b1a60e689df@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 9 Jul 2024 21:15:02 -0700
Message-ID: <CALMp9eRet6+v8Y1Q-i6mqPm4hUow_kJNhmVHfOV8tMfuSS=tVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM SVM: Add Bus Lock Detect support
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	hpa@zytor.com, rmk+kernel@armlinux.org.uk, peterz@infradead.org, 
	james.morse@arm.com, lukas.bulwahn@gmail.com, arjan@linux.intel.com, 
	j.granados@samsung.com, sibs@chinatelecom.cn, nik.borisov@suse.com, 
	michael.roth@amd.com, nikunj.dadhania@amd.com, babu.moger@amd.com, 
	x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com, 
	manali.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:25=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> Sean,
>
> Apologies for the delay. I was waiting for Bus Lock Threshold patches to =
be
> posted upstream:
>
>   https://lore.kernel.org/r/20240709175145.9986-1-manali.shukla@amd.com
>
> On 12-Jun-24 7:12 AM, Sean Christopherson wrote:
> > On Wed, Jun 05, 2024, Ravi Bangoria wrote:
> >> On 6/5/2024 8:38 PM, Sean Christopherson wrote:
> >>> Some of the problems on Intel were due to the awful FMS-based feature=
 detection,
> >>> but those weren't the only hiccups.  E.g. IIRC, we never sorted out w=
hat should
> >>> happen if both the host and guest want bus-lock #DBs.
> >>
> >> I've to check about vcpu->guest_debug part, but keeping that aside, ho=
st and
> >> guest can use Bus Lock Detect in parallel because, DEBUG_CTL MSR and D=
R6
> >> register are save/restored in VMCB, hardware cause a VMEXIT_EXCEPTION_=
1 for
> >> guest #DB(when intercepted) and hardware raises #DB on host when it's =
for the
> >> host.
> >
> > I'm talking about the case where the host wants to do something in resp=
onse to
> > bus locks that occurred in the guest.  E.g. if the host is taking punit=
ive action,
> > say by stalling the vCPU, then the guest kernel could bypass that behav=
ior by
> > enabling bus lock detect itself.
> >
> > Maybe it's moot point in practice, since it sounds like Bus Lock Thresh=
old will
> > be available at the same time.
> >
> > Ugh, and if we wanted to let the host handle guest-induced #DBs, we'd n=
eed code
> > to keep Bus Lock Detect enabled in the guest since it resides in DEBUG_=
CTL.  Bah.
> >
> > So I guess if the vcpu->guest_debug part is fairly straightforward, it =
probably
> > makes to virtualize Bus Lock Detect because the only reason not to virt=
ualize it
> > would actually require more work/code in KVM.
>
> KVM forwards #DB to Qemu when vcpu->guest_debug is set and it's Qemu's
> responsibility to re-inject exception when Bus Lock Trap is enabled
> inside the guest. I realized that it is broken so I've prepared a
> Qemu patch, embedding it at the end.
>
> > I'd still love to see Bus Lock Threshold support sooner than later thou=
gh :-)
>
> With Bus Lock Threshold enabled, I assume the changes introduced by this
> patch plus Qemu fix are sufficient to support Bus Lock Trap inside the
> guest?

In any case, it seems that commit 76ea438b4afc ("KVM: X86: Expose bus
lock debug exception to guest") prematurely advertised the presence of
X86_FEATURE_BUS_LOCK to userspace on non-Intel platforms. We should
probably either accept these changes or fix up that commit. Either
way, something should be done for all active branches back to v5.15.

> Thanks,
> Ravi
>
> ---><---
> From 0b01859f99c4c5e18323e3f4ac19d1f3e5ad4aee Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Thu, 4 Jul 2024 06:48:24 +0000
> Subject: [PATCH] target/i386: Add Bus Lock Detect support
>
> Upcoming AMD uarch will support Bus Lock Detect (called Bus Lock Trap
> in AMD docs). Bus Lock Detect is enumerated with cpuid Fn0000_0007_ECX_x0
> bit [24 / BUSLOCKTRAP]. It can be enabled through MSR_IA32_DEBUGCTLMSR.
> When enabled, hardware clears DR6[11] and raises a #DB exception on
> occurrence of Bus Lock if CPL > 0. More detail about the feature can be
> found in AMD APM[1].
>
> Qemu supports remote debugging through host gdb (the "gdbstub" facility)
> where some of the remote debugging features like instruction and data
> breakpoints relies on the same hardware infrastructure (#DB, DR6 etc.)
> that Bus Lock Detect also uses. Instead of handling internally, KVM
> forwards #DB to Qemu when remote debugging is ON and #DB is being
> intercepted. It's Qemu's responsibility to re-inject the exception to
> guest when some of the exception source bits (in DR6) are not being
> handled by Qemu remote debug handler. Bus Lock Detect is one such case.
>
> [1]: AMD64 Architecture Programmer's Manual Pub. 40332, Rev. 4.07 - June
>      2023, Vol 2, 13.1.3.6 Bus Lock Trap
>      https://bugzilla.kernel.org/attachment.cgi?id=3D304653
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  target/i386/cpu.h     | 1 +
>  target/i386/kvm/kvm.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c64ef0c1a2..89bcff2fa3 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -271,6 +271,7 @@ typedef enum X86Seg {
>                  | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS=
_MASK \
>                  | CR4_LAM_SUP_MASK))
>
> +#define DR6_BLD         (1 << 11)
>  #define DR6_BD          (1 << 13)
>  #define DR6_BS          (1 << 14)
>  #define DR6_BT          (1 << 15)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 6c864e4611..d128d4e5ca 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5141,14 +5141,14 @@ static int kvm_handle_debug(X86CPU *cpu,
>      } else if (kvm_find_sw_breakpoint(cs, arch_info->pc)) {
>          ret =3D EXCP_DEBUG;
>      }
> -    if (ret =3D=3D 0) {
> +    if (ret =3D=3D 0 || !(arch_info->dr6 & DR6_BLD)) {
>          cpu_synchronize_state(cs);
>          assert(env->exception_nr =3D=3D -1);
>
>          /* pass to guest */
>          kvm_queue_exception(env, arch_info->exception,
>                              arch_info->exception =3D=3D EXCP01_DB,
> -                            arch_info->dr6);
> +                            ret =3D=3D 0 ? arch_info->dr6 ^ DR6_BLD : DR=
6_BLD);
>          env->has_error_code =3D 0;
>      }
>
> --
> 2.34.1
>

