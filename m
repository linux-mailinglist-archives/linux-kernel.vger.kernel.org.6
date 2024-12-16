Return-Path: <linux-kernel+bounces-448051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA469F3A69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8536616B843
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021651CDA15;
	Mon, 16 Dec 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXQh/NVl"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D8339A8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379492; cv=none; b=kPtLwK5w0PBAdi1AbjhsCoquVQUf4PZsmfzcInwHLn9GpVBGr/S4Kkaem9x4URqKIvuwRi7EJd7+h0yg0VR0GmNw5kwOf8KimBPe+Ncby5ZIRzmiAFyj+NaypCP4gwknA5I6vgZk9CJsRHb3co8YXuHplF2jKxsBa2FFPadq0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379492; c=relaxed/simple;
	bh=/5ZIMWJqbiQGKSssgkI1chR7dUUmhZA6/QOZ/9gvO14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZOtBU+BJhoni/sCt1+BnWnpMv67m8EN5dWMJtXC/aaPlVCYLUELWofBRw9RuCt1WQONZLBH4fDrCIyT2MzPfsLvOtIdtHk4ifad8Kb+yqF9Cnlevz9xCHypzSngBOWjvhd5MaViRCTL95SrJ40g7VWJRZ5541TgWTcFwFUW3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXQh/NVl; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467abce2ef9so48691cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734379490; x=1734984290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xexP53Lx7tUORX67wL7XY75PZF0aHX6WFTVho6quOos=;
        b=vXQh/NVlNU4OvYez3VOq0Lw/fBLpoKVUD4rCcB3Rn2sbXUaaYHIMy6t/KUSoDCD32M
         90NXZbm8AJ+Eq/2eF8w3uzUVoOLWyvZm8PlS1TOu25O2CmX49CxRKQKgZ3SMVXY60j+J
         93eQGwN4ClNWlWTXCcHJzb4YPVpX4cxntNRNpYc8FmcpJVnqXy/nO0MDlPgmbYFAS1nC
         GmJ032YqQYF2wnUqYZcFWz0/58oraeUHxCZVz0ptKDsmiVFHW3xxJIQQp0Qwhz9XaUZX
         u3elAZSfJrLeZvMLubAI0jEqT6tPo0kyUO2znKPYWUJ8ghYjkBgqMqLUqkeq8GnSbeuN
         /Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379490; x=1734984290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xexP53Lx7tUORX67wL7XY75PZF0aHX6WFTVho6quOos=;
        b=UPNzVCd7cMX+yJ+ulcllOpO4h3I9e+y7CKp4VWN3ZU2WUAkmU3nFl7zDNSDgs2OyE1
         TqtlhDEm58TvPKhVVQQIh/u3tqwtcShjCkRCtFyI1NF5FtfOw11eOGEtsMHXoKGBMAl0
         Vsrmvgnyf/wFltBtTZnsVbYelSi4j4Z47wIea+f/Pe1guaoGiIp2TxZ942McRw2uOUV7
         HudQFewboF8xThDK3S/+7aLKUVg5kDIPt1e7XGN8IWR4n056qThAXNc0jrpxkRyo3jlN
         3lwhFGHwaDKj+fy0UOBWZnXWgJUOHTNBWWv3y5FZnrMDrZuuCxVmg9Y9tBdsrba4r8l7
         nbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7RRnF9BB5c29ux6rzk2zVey7x0dQZvQj5OjW8nlcOUstvyeYFXb3WG08CiUKlJcPmrSvLksX7OfiDNSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRkqnwMhpKRnUnggzssoTWTtSRwM45cxIJDGUoL1b+ve8YGIe
	r8PAHvaBgS/dOXYCUulIW3eb0b6BKkldMp0r+esfT6Qv+MDWg2ckeLVj0NiqxjYYI/9KYN1FqGM
	2/RgGAPat8SqEAbZE/lH9u4xqV5T8IrfXPkdD
X-Gm-Gg: ASbGncuYNbMpWY0L6CMIDNRGauZ2GjzoiBs++6rVp8kwAbO0A7t2LGfhZcWmBUrW4wG
	z6f2gCuro7jnejHwAZPCgt+svavwi3OsD5LBh
X-Google-Smtp-Source: AGHT+IFXDBt/j1JROjzWset6I1rAZRjVktzvmNLlqSdxVj7Lr0GyCEGur4tk3TBmNyasuCEi2g+JnqclC9EkYDDtKyg=
X-Received: by 2002:a05:622a:1312:b0:466:7926:c69 with SMTP id
 d75a77b69052e-468f979b7ddmr409811cf.20.1734379489466; Mon, 16 Dec 2024
 12:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211013302.1347853-1-seanjc@google.com>
In-Reply-To: <20241211013302.1347853-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 16 Dec 2024 12:04:28 -0800
Message-ID: <CALMp9eQaqYG4F6f9gm0_a9v+6A_1jXBxX5Wy3J-pDBk8iar1YA@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: x86: Address xstate_required_size() perf regression
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:33=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a hilarious/revolting performance regression (relative to older CPU
> generations) in xstate_required_size() that pops up due to CPUID _in the
> host_ taking 3x-4x longer on Emerald Rapids than Skylake.
>
> The issue rears its head on nested virtualization transitions, as KVM
> (unnecessarily) performs runtime CPUID updates, including XSAVE sizes,
> multiple times per transition.  And calculating XSAVE sizes, especially
> for vCPUs with a decent number of supported XSAVE features and compacted
> format support, can add up to thousands of cycles.
>
> To fix the immediate issue, cache the CPUID output at kvm.ko load.  The
> information is static for a given CPU, i.e. doesn't need to be re-read
> from hardware every time.  That's patch 1, and eliminates pretty much all
> of the meaningful overhead.
>
> Patch 2 is a minor cleanup to try and make the code easier to read.
>
> Patch 3 fixes a wart in CPUID emulation where KVM does a moderately
> expensive (though cheap compared to CPUID, lol) MSR lookup that is likely
> unnecessary for the vast majority of VMs.
>
> Patches 4 and 5 address the problem of KVM doing runtime CPUID updates
> multiple times for each nested VM-Enter and VM-Exit, at least half of
> which are completely unnecessary (CPUID is a mandatory intercept on both
> Intel and AMD, so ensuring dynamic CPUID bits are up-to-date while runnin=
g
> L2 is pointless).  The idea is fairly simple: lazily do the CPUID updates
> by deferring them until something might actually consume guest the releva=
nt
> bits.
>
> This applies on the cpu_caps overhaul[*], as patches 3-5 would otherwise
> conflict, and I didn't want to think about how safe patch 5 is without
> the rework.
>
> That said, patch 1, which is the most important and tagged for stable,
> applies cleanly on 6.1, 6.6, and 6.12 (and the backport for 5.15 and
> earlier shouldn't be too horrific).
>
> Side topic, I can't help but wonder if the CPUID latency on EMR is a CPU
> or ucode bug.  For a number of leaves, KVM can emulate CPUID faster than
> the CPUID can execute the instruction.  I.e. the entire VM-Exit =3D> emul=
ate
> =3D> VM-Enter sequence takes less time than executing CPUID on bare metal=
.
> Which seems absolutely insane.  But, it shouldn't impact guest performanc=
e,
> so that's someone else's problem, at least for now.

Virtualization aside, perhaps Linux should set
MSR_FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0[bit 0] on EMR, and emulate
the CPUID instruction in the kernel?  :)

> [*] https://lore.kernel.org/all/20241128013424.4096668-1-seanjc@google.co=
m
>
> Sean Christopherson (5):
>   KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init
>   KVM: x86: Use for-loop to iterate over XSTATE size entries
>   KVM: x86: Apply TSX_CTRL_CPUID_CLEAR if and only if the vCPU has RTM
>     or HLE
>   KVM: x86: Query X86_FEATURE_MWAIT iff userspace owns the CPUID feature
>     bit
>   KVM: x86: Defer runtime updates of dynamic CPUID bits until CPUID
>     emulation
>
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/cpuid.c            | 63 ++++++++++++++++++++++++---------
>  arch/x86/kvm/cpuid.h            | 10 +++++-
>  arch/x86/kvm/lapic.c            |  2 +-
>  arch/x86/kvm/smm.c              |  2 +-
>  arch/x86/kvm/svm/sev.c          |  2 +-
>  arch/x86/kvm/svm/svm.c          |  2 +-
>  arch/x86/kvm/vmx/vmx.c          |  2 +-
>  arch/x86/kvm/x86.c              | 22 +++++++++---
>  9 files changed, 78 insertions(+), 28 deletions(-)
>
>
> base-commit: 06a4919e729761be751366716c00fb8c3f51d37e
> --
> 2.47.0.338.g60cca15819-goog
>

