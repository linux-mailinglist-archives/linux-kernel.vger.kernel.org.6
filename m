Return-Path: <linux-kernel+bounces-441139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC19ECA37
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59E228346D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B309F204F86;
	Wed, 11 Dec 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n36GJmN+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809F236FA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912520; cv=none; b=F++awoBJJCaAUrJrdvyv+dqf45vZC2jQumittsQOdwMbRbfqYwlWfjI7V4yuzVIQUE2jZFdpNR7Cb3z468FD0HFw2KhgQ6j2t+g/Fumhn7tOc0xeQ60G0J3VIZ0PJSNmxqQZPNvRG8k/GXpTg+AvazhXiIUW8SOEH3+xbC7Re5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912520; c=relaxed/simple;
	bh=UDTVUyfFjVIKkfvVfweWHLUWsyuJZrsbYUs890yBJrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf0VlcZcOKH9neBmWhIXO4hEKpPK7/79YuZCfbVBFM2BH+RgUu5CQAfbp9Gs8Wxbi+JCwhhXdxOrYMn0urgmd+CE2UfbSM/x6ZU1SoTl/fpMgEsJJ9zezQDBs+DW2rXoS1t0YG3x2WUQj6mx7DV91SqNkG7NETJb9Li0v5ns/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n36GJmN+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so28605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733912517; x=1734517317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BeXMj8VvPwXBM+YorP3kB6swE+LJumb2PgH049Y7jrU=;
        b=n36GJmN+RUPTtWGuOmBSqGhjxTwRxHekOdgL8VslwEahPALB+rpfBx8Ga3SVl/XO+J
         kZZzNpT+AKx0bE7RJuMML1dVfKC/iQIGPufM808YXc+l1wYvh72tZu1IBpDs0Fn8lTLp
         557EguePMDkHxs97Kqf7sitkoiSdqs+L9kqvuQmQMBetmYTY12HlI0uft2LAu4N0Ar0q
         1sxRDEpdQ+n7ebOtQwNqfbAatMOSHk1RuA6b5ozILxkCMNw8DOaW0GKLJkhnS+TJxyuD
         duOKgRr2afC1rhsN1oZMY6YGEHUGtBRSo3TxZBcWDaS3rnSggMUV+CcKsZmm1cA3KpZE
         xIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912517; x=1734517317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeXMj8VvPwXBM+YorP3kB6swE+LJumb2PgH049Y7jrU=;
        b=jfqKOOu34JPl5QOAFW1Bm56O9ptpbCS5DQd36HTovm9uIfRy0G9SS6DSyKOyQZPciZ
         TQdznCsH2ZXjE1TAxznlFtOigfPWmN1FB0KVUuJNQr+/A1fV0BEB4MsQ/EiBGb42+cjU
         cYB71w/YluUlfpnkRbRq/4RiHesnle5E591ukFZWjGERDCTQKCn1rGNpgLqCpNfnS6wE
         nSwRwPuV0F4v76xc585z/2Ig5njtBv79mlol0Le1EqPMgv9kUADUryPrAg5laNCahJfp
         feplLNb+SxoyPJYFG8Kbi0ohaUVCA+DyscYn/JSOGgN0+xL6IIOyhrvhYQ6o3dDlFqK6
         YtLg==
X-Forwarded-Encrypted: i=1; AJvYcCVtAFHj3LAkMi/Y5mt9V1WKSEmXhxTEe8vLq/+pBjCOuXjcLzI7AUaOoBnD3L5MaXA5L4kePWFl4sN438M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwywUP6zj3KJ8JMnod9UQDEcLp/2985lq+eWlkUeOYDfRiQr4R+
	UxpprEkmeX01r1IWGhU9u+NwYlzZdAZGtxrxzZ0IxcV/eT5zLpSZxoZnb9wqpxVc9OGeKYE3Cgj
	ARcRYoN0IwNnixQDnAEoerIDAZx/CeUALovtO
X-Gm-Gg: ASbGnctC8rLPAresvMeW+Tg5wQbQ3Gvl6DImEAUoZfhLmL282yX6RApwpDpEiiR3zhW
	lviTCWeWqM7qQ2JCNnmsI0iHICWds/ne8PGemcLWbJpiTUzHYN8je/HEugSe20Ysv
X-Google-Smtp-Source: AGHT+IGdAegS44TMEDlVdgvzE+gKy2ozwm3TkkcQ7rpYSyvhwicVZQRotOml5HMNIrItY+DK9IjWorBpSsLKxTL7rAM=
X-Received: by 2002:a05:600c:490a:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-4361c0e320bmr1000685e9.2.1733912516699; Wed, 11 Dec 2024
 02:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-17-qperret@google.com>
 <CA+EHjTw_e_q5TFkgxvVDKxwj-C5S0Hd1OfVO4_FitrB8_J2Rpw@mail.gmail.com> <Z1ljbPFsUdUC8AD3@google.com>
In-Reply-To: <Z1ljbPFsUdUC8AD3@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 11 Dec 2024 10:21:20 +0000
Message-ID: <CA+EHjTwnZ8S4LUgmJ40g8juHh5OneWUWtJDDCnn03Xw0MvQ-=A@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Wed, 11 Dec 2024 at 10:03, Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 10 Dec 2024 at 15:23:02 (+0000), Fuad Tabba wrote:
> > Hi Quentin,
> >
> > On Tue, 3 Dec 2024 at 10:38, Quentin Perret <qperret@google.com> wrote:
> > >
> > > Introduce a new hypercall to flush the TLBs of non-protected guests. The
> > > host kernel will be responsible for issuing this hypercall after changing
> > > stage-2 permissions using the __pkvm_host_relax_guest_perms() or
> > > __pkvm_host_wrprotect_guest() paths. This is left under the host's
> > > responsibility for performance reasons.
> > >
> > > Note however that the TLB maintenance for all *unmap* operations still
> > > remains entirely under the hypervisor's responsibility for security
> > > reasons -- an unmapped page may be donated to another entity, so a stale
> > > TLB entry could be used to leak private data.
> > >
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_asm.h   |  1 +
> > >  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 17 +++++++++++++++++
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > > index 6178e12a0dbc..df6237d0459c 100644
> > > --- a/arch/arm64/include/asm/kvm_asm.h
> > > +++ b/arch/arm64/include/asm/kvm_asm.h
> > > @@ -87,6 +87,7 @@ enum __kvm_host_smccc_func {
> > >         __KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
> > >         __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
> > >         __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
> > > +       __KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
> > >  };
> > >
> > >  #define DECLARE_KVM_VHE_SYM(sym)       extern char sym[]
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > > index de0012a75827..219d7fb850ec 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > > @@ -398,6 +398,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
> > >         __kvm_tlb_flush_vmid(kern_hyp_va(mmu));
> > >  }
> > >
> > > +static void handle___pkvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
> > > +{
> > > +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> > > +       struct pkvm_hyp_vm *hyp_vm;
> > > +
> > > +       if (!is_protected_kvm_enabled())
> > > +               return;
> > > +
> > > +       hyp_vm = get_pkvm_hyp_vm(handle);
> > > +       if (!hyp_vm)
> > > +               return;
> > > +
> > > +       __kvm_tlb_flush_vmid(&hyp_vm->kvm.arch.mmu);
> > > +       put_pkvm_hyp_vm(hyp_vm);
> > > +}
> >
> > Since this is practically the same as kvm_tlb_flush_vmid(), does it
> > make sense to modify that instead (handle___kvm_tlb_flush_vmid()) to
> > do the right thing depending on whether pkvm is enabled? Thinking as
> > well for the future in case we want to support the rest of the
> > kvm_tlb_flush_vmid_*().
>
> I considered it, but the two implementations want different arguments --
> pkvm wants the handle while standard KVM uses the kvm struct address
> directly. I had an implementation at some point that multiplexed the
> implementations on a single HVC (we'd interpret the arguments
> differently depending on pKVM being enabled or not) but that felt more
> error prone than simply having two HVCs.
>
> Happy to reconsider if we can find a good way to make it work though.

I don't have a strong opinion about this. I think that for now, since
it's only this function, it's probably fine. That said, the
multiplexing is (as of patch 18, which I haven't reviewed yet) is just
lifted higher up to the host kernel, albeit with fewer parameters to
wiggle around.

To summarize, I think we can worry about it if/once we need the other
tlb_flush_* variants.

Cheers,
/fuad

