Return-Path: <linux-kernel+bounces-351804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59AB991641
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481561F23135
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0413DBA0;
	Sat,  5 Oct 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="YocYNISv"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B78BE4F
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728126082; cv=none; b=n0+ZG73PmmNnI8DSVrsGApj3x1H4GjIqCAl2p378QopcxraVuCcmS3cqVjNMzPcFf77wZKxlW5+9sp2FHXjkGlIkn6YPOoYY26VVPgyC4sTYY9Ruzj+o1+sbK8X6Ta50I0FDbfXwga6i/VPxIc2YL4hPuwmBFNDGKYzfYsmH4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728126082; c=relaxed/simple;
	bh=rheZfz4AdS3k30pqW8IEpEZG1dsWY6agajpSmXU2uIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKnrGqesrN3f4LxQnszu0vlUv0lV69wh6dyaS6/cLOetBT8n3rzbAjVNwHKiK7Qr+1o3S4R85D9qNDm2CgQffLJARMCdspaX8wX+cHyKbBBlrt82ttbVl2XRjjYsZcfgbvadkuYzO2wX5JZaeU0SntQiv1AgsDjuKRT4vCWGvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=YocYNISv; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ceab75c27so179082039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1728126080; x=1728730880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bREgugSagESVp9ALwvpjSU06NzrhpdO98bPNU3cl6FM=;
        b=YocYNISv1SCK+5jhgm6vaNuUKSBmS1ieXQW+dkTwzDUBII22RRs9UTLKeg+07gZKoU
         oBXYokMtiyu0dh+7rP1H+aWuJ9BOvw8AvBV8XotoP1rCR/2B46RSslrOUUNv3ayvune+
         47mQ4XHX3bK3x3rwXfYlV1EOoSopdX9gro9FJHHk6zXOrkJWucsYVuMMMsIJVzViB55N
         J4hDC/juCelj/lE032tnEf5tL4xVSLJ85+xiSaWeq9HFUIuKa+P2qBFn6NgybTzMG3MS
         NtPF/xeYSz5NmS0UAHKfmr20sMV3owtbYbOReAvHMNaHL4Z+9g78x3/RfQtWHi9lHV3T
         iJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728126080; x=1728730880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bREgugSagESVp9ALwvpjSU06NzrhpdO98bPNU3cl6FM=;
        b=g0FooVpNgrePUn30E8ED+jIkqD638xttNqFUyTqe1n+p91ZH9gFUoWf4fqNAD9SIHU
         WZbtlVrmCnD+rzWK88cT0SisY7/Hlzt5uWBp9+E8oGQMR76cvC5nq7sH6IXThBW36U8D
         J0QeMyk0ZwxOl/QdREIHkXhyqdXLLhoCpXFdt0yOg5baksGV8fEfc09sAoj2Vsrq6V7/
         X1pLnzixnSgZ0gxMhQ8xHfIPXVe2KgX0AzCQkPJttLmntxPGktsi9KuS5R5b0IuZGqqN
         Xgn5jKDjVBM6ss7sGMQt7v6iAqFtGaYNtpidLEtYaahD5Uu2zVfm8/w2cyzeiTMAt5rD
         1k9Q==
X-Gm-Message-State: AOJu0YxWqD5s5AFj/iQ1qCULdLlKCxMvCa/F5MV7hoBNUKMMMaRhE9n1
	wrrkNQXGJOhvX88CBTyVgizMSV7iFyFqtppp9d+90GYmDubhfjOMVAL3WWuPMUb/3lzwmAJyX5G
	QEw0OQgnA0aYqeU6dZoj2J+XEgaGI+IIE1+IKYw==
X-Google-Smtp-Source: AGHT+IEHaB88aGwn9Zv7UXlV41DcjW2zCnzlTE+Pa5BQQ2v5u3y5Ca4EvtdkpG4NwHwh0bWWM7OzuV8hzj+pENEIUfI=
X-Received: by 2002:a92:c564:0:b0:3a0:92b1:ec4c with SMTP id
 e9e14a558f8ab-3a375bb7860mr47293525ab.23.1728126079657; Sat, 05 Oct 2024
 04:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy05BXUZu6BNUoDWoEVd_YiM0Dpqg=t5WYUX7+cacnO2Hg@mail.gmail.com>
 <mhng-1e3d83bb-a7f4-4fa7-8cfa-2550835026de@palmer-ri-x1c9>
In-Reply-To: <mhng-1e3d83bb-a7f4-4fa7-8cfa-2550835026de@palmer-ri-x1c9>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 5 Oct 2024 16:31:07 +0530
Message-ID: <CAAhSdy32s91ijfachfynzmQ1+weeBjLKaDLiCBT2gq-oTYSgDw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Add Svade and Svadu Extensions Support
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, yongxuan.wang@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Fri, Sep 20, 2024 at 1:53=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> On Wed, 21 Aug 2024 07:43:20 PDT (-0700), anup@brainfault.org wrote:
> > Hi Palmer,
> >
> > On Fri, Jul 26, 2024 at 2:19=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@s=
ifive.com> wrote:
> >>
> >> Svade and Svadu extensions represent two schemes for managing the PTE =
A/D
> >> bit. When the PTE A/D bits need to be set, Svade extension intdicates =
that
> >> a related page fault will be raised. In contrast, the Svadu extension
> >> supports hardware updating of PTE A/D bits. This series enables Svade =
and
> >> Svadu extensions for both host and guest OS.
> >>
> >> Regrading the mailing thread[1], we have 4 possible combinations of
> >> these extensions in the device tree, the default hardware behavior for
> >> these possibilities are:
> >> 1) Neither Svade nor Svadu present in DT =3D> It is technically
> >>    unknown whether the platform uses Svade or Svadu. Supervisor
> >>    software should be prepared to handle either hardware updating
> >>    of the PTE A/D bits or page faults when they need updated.
> >> 2) Only Svade present in DT =3D> Supervisor must assume Svade to be
> >>    always enabled.
> >> 3) Only Svadu present in DT =3D> Supervisor must assume Svadu to be
> >>    always enabled.
> >> 4) Both Svade and Svadu present in DT =3D> Supervisor must assume
> >>    Svadu turned-off at boot time. To use Svadu, supervisor must
> >>    explicitly enable it using the SBI FWFT extension.
> >>
> >> The Svade extension is mandatory and the Svadu extension is optional i=
n
> >> RVA23 profile. Platforms want to take the advantage of Svadu can choos=
e
> >> 3. Those are aware of the profile can choose 4, and Linux won't get th=
e
> >> benefit of svadu until the SBI FWFT extension is available.
> >>
> >> [1] https://lore.kernel.org/linux-kernel/20240527-e9845c06619bca5cd285=
098c@orel/T/#m29644eb88e241ec282df4ccd5199514e913b06ee
> >>
> >> ---
> >> v8:
> >> - fix typo in PATCH1 (Samuel)
> >> - use the new extension validating API in PATCH1 (Cl=C3=A9ment)
> >> - update the dtbinding in PATCH2 (Samuel, Conor)
> >> - add PATCH4 to fix compile error in get-reg-list test.
> >>
> >> v7:
> >> - fix alignment in PATCH1
> >> - update the dtbinding in PATCH2 (Conor, Jessica)
> >>
> >> v6:
> >> - reflect the platform's behavior by riscv_isa_extension_available() a=
nd
> >>   update the the arch_has_hw_pte_young() in PATCH1 (Conor, Andrew)
> >> - update the dtbinding in PATCH2 (Alexandre, Andrew, Anup, Conor)
> >> - update the henvcfg condition in PATCH3 (Andrew)
> >> - check if Svade is allowed to disabled based on arch_has_hw_pte_young=
()
> >>   in PATCH3
> >>
> >> v5:
> >> - remove all Acked-by and Reviewed-by (Conor, Andrew)
> >> - add Svade support
> >> - update the arch_has_hw_pte_young() in PATCH1
> >> - update the dtbinding in PATCH2 (Alexandre, Andrew)
> >> - check the availibility of Svadu for Guest/VM based on
> >>   arch_has_hw_pte_young() in PATCH3
> >>
> >> v4:
> >> - fix 32bit kernel build error in PATCH1 (Conor)
> >> - update the status of Svadu extension to ratified in PATCH2
> >> - add the PATCH4 to suporrt SBI_FWFT_PTE_AD_HW_UPDATING for guest OS
> >> - update the PATCH1 and PATCH3 to integrate with FWFT extension
> >> - rebase PATCH5 on the lastest get-reg-list test (Andrew)
> >>
> >> v3:
> >> - fix the control bit name to ADUE in PATCH1 and PATCH3
> >> - update get-reg-list in PATCH4
> >>
> >> v2:
> >> - add Co-developed-by: in PATCH1
> >> - use riscv_has_extension_unlikely() to runtime patch the branch in PA=
TCH1
> >> - update dt-binding
> >>
> >> Yong-Xuan Wang (5):
> >>   RISC-V: Add Svade and Svadu Extensions Support
> >>   dt-bindings: riscv: Add Svade and Svadu Entries
> >>   RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
> >>   KVM: riscv: selftests: Fix compile error
> >>   KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list
> >>     test
> >>
> >>  .../devicetree/bindings/riscv/extensions.yaml | 28 ++++++++++++++++++=
+
> >>  arch/riscv/Kconfig                            |  1 +
> >>  arch/riscv/include/asm/csr.h                  |  1 +
> >>  arch/riscv/include/asm/hwcap.h                |  2 ++
> >>  arch/riscv/include/asm/pgtable.h              | 13 ++++++++-
> >>  arch/riscv/include/uapi/asm/kvm.h             |  2 ++
> >>  arch/riscv/kernel/cpufeature.c                | 12 ++++++++
> >>  arch/riscv/kvm/vcpu.c                         |  4 +++
> >>  arch/riscv/kvm/vcpu_onereg.c                  | 15 ++++++++++
> >>  .../selftests/kvm/riscv/get-reg-list.c        | 16 ++++++++---
> >>  10 files changed, 89 insertions(+), 5 deletions(-)
> >>
> >> --
> >> 2.17.1
> >>
> >>
> >
> > Let me know if this series can be taken through the KVM RISC-V tree.
> > I can provide you with a shared tag as well.
>
> I think the patchwork bot got confused by patch 4 going to fixes?  It
> says this was merged.
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> if you still want to take it, otherwise just LMK and I'll pick it up.
>

I have queued this series for Linux-6.13

Thanks,
Anup

