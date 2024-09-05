Return-Path: <linux-kernel+bounces-316353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79096CE5F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDB31C21C99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC95156676;
	Thu,  5 Sep 2024 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ptDyapNv"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16883156237
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513530; cv=none; b=ImXMneMsjl1cwJ1s41SFK1ixQERdtherAetye/YyJkoL/a8PSUbqRPQ9WKO8v9wqXL60IeMlBfF1JQCDaC3bxYIJZop88iv/vbSqJRWg5yEcuZwm0N7EBTsHj/rCnZzWycuFSQINhA76cFK0P8k+YjmwcgYQ3sMaMgFjdJVOQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513530; c=relaxed/simple;
	bh=N8TaDWiMh8vdTmRBqyiTQI7AagHYAdXHkUiBX323RtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7t8WNpcsLB/UaNystO6RSmbdd/cPOVv6wfWsYZXxk2PkvHPSxYJzPuv51IWYZhgH9tU8+68tkRUaYPYgxgGxaXSJFFL3lTb5EB1ynQbfH7zwodm/aepyLAzbZxMryWcyU06peGEgUs9ND93x3343fdktagGojo3ZNW+DBBPAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ptDyapNv; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a20593ec1so14155039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1725513528; x=1726118328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgy+KzMNuhYLUyLUNPHVh2erq8NnTHGx1LflMF38P4o=;
        b=ptDyapNvNGC6ILlm+T3H0UTORuua5CB5HJUsI5Chg3QxSPBW1GRa31iaUIO8WLSBpD
         Mv40SWRc24en1D4ZBfJqcaP7xowveXR5FWaMzm8GLJQD6pJ4SgpwCChFHDERduXSUlF4
         Yf8rNxdLY2v8GUHr/mrShUM8C9f+VZm9F1L4UmeVeJUV3CG5ZmBakq1ZPeM1jcUijz0K
         rcc9O9pnElNRmn6q62BkeYg+jMVWSvXeIh5ucA0ph0CURcy21yX8/GUU0WwLv20aTqfe
         6oFLiWQppxEXcHnkd9O4dlg0VFCnmc/B8xY0BNnG0wZhi6l8XWwmFesxdfKLnLHykxcB
         lPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725513528; x=1726118328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgy+KzMNuhYLUyLUNPHVh2erq8NnTHGx1LflMF38P4o=;
        b=NJsSfWJDrBowm9aef0uksfMe9a36PPRVAM/JiEmbChzhiA8ygT+nFvAtzD57i0Fx7l
         1KaSMOnd0vbwsO+rPPmn4Vw7V51rrxx1x8pot7mYMJgtmjPDfHEB1IyyjV2bN863Sijj
         0uZhTeeVEDDO6UteMtKPs0FpXWDHUFf67FsHkaWJ7uzlt5HN/K77V2yojystKwroq74K
         A9eXRYDV+fyOor1rh5sWOgBj1MOBJliS+rm4fOQis8CVXcjLJyS/X/sSEG4HCx7Y2z5A
         c4jrv/ra4UKsKgWqtoqkAfCm2L7KTATu4Y4ZMng/Qxs/FP39BR2kYvKmnluoVwM4dVNm
         5r6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGGQNCSD2xC6HtL4jZBVEXdMnbdMp3YCAQKpvR7tCW1baIhyc/Tg75Y38qyM97nmobr5ieq+/7xWKbfRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQB4wpT5wsrluS4ljHoKfDL3+EW2kWAZ0536sHUo6wEdu3qEN
	nOA05gj7rQwIF/BmygY5iNqQi4Q3fPtikbs3lVd/ML2TxOalS1aeJV7zFOp9hrcGCwJY7QeeVYc
	ItsmEgfZ0enqq3I7I9s5FvUHWyOpCovYFR04rNw==
X-Google-Smtp-Source: AGHT+IGMheT/srAt3s2XkzVYtm3aEDxZFo3U+lheMX2wU2sVF6qxeowfxxPsZKdkBwAEbIY9wvFX5yQrdy3W1RU2gFw=
X-Received: by 2002:a05:6e02:12e4:b0:39d:2524:ece6 with SMTP id
 e9e14a558f8ab-39f3783810emr305003055ab.17.1725513528004; Wed, 04 Sep 2024
 22:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-10-samuel.holland@sifive.com> <CAK9=C2WjraWjuQCeU2Y4Jhr-gKkOcP42Sza7wVp0FgeGaD923g@mail.gmail.com>
 <b6de8769-7e4e-4a19-b239-a39fd424e0c8@sifive.com> <CAAhSdy08SoDoZCii9R--BK7_NKLnRciW7V3mo2aQRKW1dbOgNg@mail.gmail.com>
 <20ab0fa2-d5dd-446d-9fff-a3ef82e8db35@sifive.com> <CAAhSdy1pZcEfajg3OZUCaFf9JMYcMzpRVogCT5VL2FHx__vDdA@mail.gmail.com>
 <4c010cb1-b57c-427e-a241-1dd3ab15f2ce@sifive.com>
In-Reply-To: <4c010cb1-b57c-427e-a241-1dd3ab15f2ce@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 5 Sep 2024 10:48:36 +0530
Message-ID: <CAAhSdy0kYUdgX8NUKuOdQa-69ET=cscduJvyz3z31kVeB-JaNw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions
 for guests
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:25=E2=80=AFPM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> On 2024-09-04 10:20 AM, Anup Patel wrote:
> > On Wed, Sep 4, 2024 at 8:27=E2=80=AFPM Samuel Holland <samuel.holland@s=
ifive.com> wrote:
> >>
> >> Hi Anup,
> >>
> >> On 2024-09-04 9:45 AM, Anup Patel wrote:
> >>> On Wed, Sep 4, 2024 at 8:01=E2=80=AFPM Samuel Holland <samuel.holland=
@sifive.com> wrote:
> >>>> On 2024-09-04 7:17 AM, Anup Patel wrote:
> >>>>> On Thu, Aug 29, 2024 at 6:32=E2=80=AFAM Samuel Holland
> >>>>> <samuel.holland@sifive.com> wrote:
> >>>>>>
> >>>>>> The interface for controlling pointer masking in VS-mode is henvcf=
g.PMM,
> >>>>>> which is part of the Ssnpm extension, even though pointer masking =
in
> >>>>>> HS-mode is provided by the Smnpm extension. As a result, emulating=
 Smnpm
> >>>>>> in the guest requires (only) Ssnpm on the host.
> >>>>>>
> >>>>>> Since the guest configures Smnpm through the SBI Firmware Features
> >>>>>> interface, the extension can be disabled by failing the SBI call. =
Ssnpm
> >>>>>> cannot be disabled without intercepting writes to the senvcfg CSR.
> >>>>>>
> >>>>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >>>>>> ---
> >>>>>>
> >>>>>> (no changes since v2)
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>>  - New patch for v2
> >>>>>>
> >>>>>>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
> >>>>>>  arch/riscv/kvm/vcpu_onereg.c      | 3 +++
> >>>>>>  2 files changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/includ=
e/uapi/asm/kvm.h
> >>>>>> index e97db3296456..4f24201376b1 100644
> >>>>>> --- a/arch/riscv/include/uapi/asm/kvm.h
> >>>>>> +++ b/arch/riscv/include/uapi/asm/kvm.h
> >>>>>> @@ -175,6 +175,8 @@ enum KVM_RISCV_ISA_EXT_ID {
> >>>>>>         KVM_RISCV_ISA_EXT_ZCF,
> >>>>>>         KVM_RISCV_ISA_EXT_ZCMOP,
> >>>>>>         KVM_RISCV_ISA_EXT_ZAWRS,
> >>>>>> +       KVM_RISCV_ISA_EXT_SMNPM,
> >>>>>> +       KVM_RISCV_ISA_EXT_SSNPM,
> >>>>>>         KVM_RISCV_ISA_EXT_MAX,
> >>>>>>  };
> >>>>>>
> >>>>>> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_on=
ereg.c
> >>>>>> index b319c4c13c54..6f833ec2344a 100644
> >>>>>> --- a/arch/riscv/kvm/vcpu_onereg.c
> >>>>>> +++ b/arch/riscv/kvm/vcpu_onereg.c
> >>>>>> @@ -34,9 +34,11 @@ static const unsigned long kvm_isa_ext_arr[] =
=3D {
> >>>>>>         [KVM_RISCV_ISA_EXT_M] =3D RISCV_ISA_EXT_m,
> >>>>>>         [KVM_RISCV_ISA_EXT_V] =3D RISCV_ISA_EXT_v,
> >>>>>>         /* Multi letter extensions (alphabetically sorted) */
> >>>>>> +       [KVM_RISCV_ISA_EXT_SMNPM] =3D RISCV_ISA_EXT_SSNPM,
> >>>>>
> >>>>> Why not use KVM_ISA_EXT_ARR() macro here ?
> >>>>
> >>>> Because the extension name in the host does not match the extension =
name in the
> >>>> guest. Pointer masking for HS mode is provided by Smnpm. Pointer mas=
king for VS
> >>>> mode is provided by Ssnpm at the hardware level, but this needs to a=
ppear to the
> >>>> guest as if Smnpm was implemented, since the guest thinks it is runn=
ing on bare
> >>>> metal.
> >>>
> >>> Okay, makes sense.
> >>>
> >>>>
> >>>>>>         KVM_ISA_EXT_ARR(SMSTATEEN),
> >>>>>>         KVM_ISA_EXT_ARR(SSAIA),
> >>>>>>         KVM_ISA_EXT_ARR(SSCOFPMF),
> >>>>>> +       KVM_ISA_EXT_ARR(SSNPM),
> >>>>>>         KVM_ISA_EXT_ARR(SSTC),
> >>>>>>         KVM_ISA_EXT_ARR(SVINVAL),
> >>>>>>         KVM_ISA_EXT_ARR(SVNAPOT),
> >>>>>> @@ -129,6 +131,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed=
(unsigned long ext)
> >>>>>>         case KVM_RISCV_ISA_EXT_M:
> >>>>>>         /* There is not architectural config bit to disable sscofp=
mf completely */
> >>>>>>         case KVM_RISCV_ISA_EXT_SSCOFPMF:
> >>>>>> +       case KVM_RISCV_ISA_EXT_SSNPM:
> >>>>>
> >>>>> Why not add KVM_RISCV_ISA_EXT_SMNPM here ?
> >>>>>
> >>>>> Disabling Smnpm from KVM user space is very different from
> >>>>> disabling Smnpm from Guest using SBI FWFT extension.
> >>>>
> >>>> Until a successful SBI FWFT call to KVM to enable pointer masking fo=
r VS mode,
> >>>> the existence of Smnpm has no visible effect on the guest. So failin=
g the SBI
> >>>> call is sufficient to pretend that the hardware does not support Smn=
pm.
> >>>>
> >>>>> The KVM user space should always add Smnpm in the
> >>>>> Guest ISA string whenever the Host ISA string has it.
> >>>>
> >>>> I disagree. Allowing userspace to disable extensions is useful for t=
esting and
> >>>> to support migration to hosts which do not support those extensions.=
 So I would
> >>>> only add extensions to this list if there is no possible way to disa=
ble them.
> >>>
> >>> I am not saying to disallow KVM user space disabling Smnpm.
> >>
> >> Then I'm confused. This is the "return false;" switch case inside
> >> kvm_riscv_vcpu_isa_disable_allowed(). If I add KVM_RISCV_ISA_EXT_SMNPM=
 here,
> >> then (unless I am misreading the code) I am disallowing KVM userspace =
from
> >> disabling Smnpm in the guest (i.e. preventing KVM userspace from remov=
ing Smnpm
> >> from the guest ISA string). If that is not desired, then why do you su=
ggest I
> >> add KVM_RISCV_ISA_EXT_SMNPM here?
> >
> > Yes, adding KVM_RISCV_ISA_EXT_SMNPM here means KVM
> > user space can't disable it using ONE_REG interface but KVM user
> > space can certainly not add it in the Guest ISA string.
>
> Is there a problem with allowing KVM userspace to disable the ISA extensi=
on with
> the ONE_REG interface?
>
> If KVM userspace removes Smnpm from the ISA string without the host kerne=
l's
> knowledge, that doesn't actually prevent the guest from successfully call=
ing
> sbi_fwft_set(POINTER_MASKING_PMLEN, ...), so it doesn't guarantee that th=
e VM
> can be migrated to a host without pointer masking support. So the ONE_REG
> interface still has value. (And that's my answer to your original questio=
n "Why
> not add KVM_RISCV_ISA_EXT_SMNPM here ?")

Currently, disabling KVM_RISCV_ISA_EXT_SMNPM via ONE_REG
will only clear the corresponding bit in VCPU isa bitmap. Basically, the
KVM user space disabling KVM_RISCV_ISA_EXT_SMNPM for Guest
changes nothing for the Guest/VM.

On other hand, disabling KVM_RISCV_ISA_EXT_SVPBMT via
ONE_REG will not only clear it from VCPU isa bitmap but also
disable Svpmbt from henvcfg CSR for the Guest/VM.

In other words, if disabling an ISA extension is allowed by the
kvm_riscv_vcpu_isa_disable_allowed() then the Guest/VM must
see a different behaviour when the ISA extension is disabled by
KVM user space.

>
> >>> The presence of Smnpm in ISA only means that it is present in HW
> >>> but it needs to be explicitly configured/enabled using SBI FWFT.
> >>>
> >>> KVM user space can certainly disable extensions by not adding it to
> >>> ISA string based on the KVMTOOL/QEMU-KVM command line option.
> >>> Additionally, when SBI FWFT is added to KVM RISC-V. It will have its
> >>> own way to explicitly disable firmware features from KVM user space.
> >>
> >> I think we agree on this, but your explanation here appears to conflic=
t with
> >> your suggested code change. Apologies if I'm missing something.
> >
> > I think the confusion is about what does it mean when Smnpm is present
> > in the ISA string. We have two approaches:
> >
> > 1) Presence of Smnpm in ISA string only means it is present in HW but
> >     says nothing about its enable/disable state. To configure/enable
> >     Smnpm, the supervisor must use SBI FWFT.
> >
> > 2) Presence of Smnpm in ISA string means it is present in HW and
> >     enabled at boot-time. To re-configure/disable Smnpm, the supervisor
> >     must use SBI FWFT.
> >
> > I am suggesting approach #1 but I am guessing you are leaning towards
> > approach #2 ?
> >
> > For approach #2, additional hencfg.PMM configuration is required in
> > this patch based on the state of KVM_RISCV_ISA_EXT_SMNPM.
>
> No, I am definitely suggesting only approach #1. My proposal for adding p=
ointer
> masking to the SBI FWFT extension[1] specifies the feature as disabled by
> default, and this would apply both inside and ouside a VM.
>
> But I am also suggesting that the ONE_REG interface is a useful way to
> completely hide the extension from the guest, like we do for other extens=
ions
> such as Svpbmt. The only difference between something like Svpbmt and Smn=
pm is
> that instead of clearing a bit in henvcfg to hide the extension from the =
guest,
> we reject calls to sbi_fwft_set(POINTER_MASKING_PMLEN, ...) when the ISA
> extension is hidden from the guest.

I think we are converging towards the same thing.

How about this ?

For this series, lets add KVM_RISCV_ISA_EXT_SMNPM to
kvm_riscv_vcpu_isa_disable_allowed() so that for the time
being KVM user space can't disable Smnpm.

In the future, a separate series which adds SBI FWFT to
KVM RISC-V will remove KVM_RISCV_ISA_EXT_SMNPM
from the kvm_riscv_vcpu_isa_disable_allowed() because
disabling Smnpm from KVM user space would mean that
the POINTER_MASKING_PMLEN firmware feature is
not available to the Guest/VM.

This means in the future (after SBI FWFT is implemented in
KVM RISC-V), Guest with Smnpm disabled can be migrated
to a host without pointer masking.

Regards,
Anup

