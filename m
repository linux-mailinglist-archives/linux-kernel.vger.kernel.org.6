Return-Path: <linux-kernel+bounces-441120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D769EC9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D536288E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322EC1B21A0;
	Wed, 11 Dec 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwdKOa36"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E4236FA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911412; cv=none; b=RJc2OjDYIa+WfhWgeiLqw1PNRThaX64odV4/TqbAv6rwcHLfK8zBk12hpGIva3DLS7OVexovO1OejdGVd/zDZfXfnAGDDiLZ0R+5DalfKXZO7jwFB08ReKBabD/io/ASWjI1hdmxjIQOb1LZCqIH34r5qriUt1QIptf1dAF0Cb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911412; c=relaxed/simple;
	bh=I7e2UE0n90FPZgbYCqwjYe9I0fH+uvt69aDGJHawIS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvTbsbPb+ReXCEuFJxGBALTsZ6oXOfRok84kCOt5RgPWLkaAYGO6TkS0rH1G6B+iUcNN5yo2kWpzTC3B2/gIC1COr8rjYodzvJ95Tv9UpOfuq/tZSPMHw44UAkSO8gxcqXva+HO89MEh4V096KIpNxzP/vL283rvtO3Xwtdq3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwdKOa36; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so6096102a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733911409; x=1734516209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCeBFQbxDNcGU8eAxUj/y7sI+rg04GZNTgWblO08pkI=;
        b=KwdKOa36k5Ks2vDYj6CA4cS2/4rwFZBTNnyHJByAJTgqtabhGBUEV/vt+hPH5egfBz
         VtHT1LBrPRodyeMfuWSjBJQT+sLBhx7LqbBZY7nz/tDp7ldiZ3I7BRHKwpjNetxXvUAS
         QacrlAZ8Gl3/JVhtpc2pZ7gxqldfzA+wVz28qtGySKDtC/0a5JPxc9pFo91wfJk/eIlr
         Eq3i0O7LcBO9lqxaUzW5iH+ig3hKfcpbnDkXkqOHPKNWcyVi0MQCTwCzRZimm4YujyX4
         IroBwGrDwRGo1HiE7LsNXPDqiuiNLwlE59A76W+C7VTA6lvZ2LOKOGNdex1H7gyZu8sm
         B0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911409; x=1734516209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCeBFQbxDNcGU8eAxUj/y7sI+rg04GZNTgWblO08pkI=;
        b=wHsDCDVQDGINtt/ku2d6NfUgrA8bo7Lc+817XJ9Q6d38+EQOGOQjrATNAHuyo82w9K
         ZIjU26ckuEnn3qWffLeUbk5nUdm6sxYPWRSUi6yOwKTP+HzekfCKVx0dvxFS4SMHDbMa
         VVqGAumP/sZRz16JMsQmyLDkrbFtQ3xTGG0M7QHmrO+hsd/Alyr1Se4ahVIv+iz71bLc
         9A2wfW0yWG9b1pxTgHbKEwWistGAOQLVmibxbLssF68xX5TqfYAsl4xAtW4Q9JpssTc6
         OpKro1Xw/Zs8y1N+kPQinQDXtis4LQhiVLxZVHDDT7N3/9OaOMfzMfkgG94/Ifn0VU/y
         ZGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGnWfqZzBZ4fedhxOSlJ7GRmvE9+AUecXCd4nO2OsT3g9ZiXT0eOkAgVS3QEo2ghJmoMsLqx1PRVeCH5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysyDTsAhI1dYiajDIHS27CzloIz/oAnqImxlmaJN0qUVAUZiLJ
	nlyo9EN4wl5LjVoRPbyeNz/wKpjKuUFyK37s+r3e7SuekNCaj1+nMOhI6ELGdQ==
X-Gm-Gg: ASbGnctHYhZCX2ECymG6L0N95DoQQqYJhiV/R/6IHtEhxlPJdnvEZmmef31Bdyi7hNd
	fE7O6NV958F/SNABEx9HPorrD5RxdCwhko3j1Fc3ZTeOtK7BXVZ+9cX4sldlB3IMwrBpQWwjl/B
	QiFL7GxDQ39vE1vVGObAM5oXt0uOinxx8bjvpAhtaLIvnhyfxIh+mZKJXnJHYI9uB2ooP1TOqeA
	fhsN6lSbU6kJxOBzN38BCk1Zoq2ScaugFc2aAVtgH7Gij+AziRe3qtTcipbmksuMx58Vki57eQy
	GHL8fHppeNNu
X-Google-Smtp-Source: AGHT+IFlnlrpokPXa68KO5qLY5+q1kB5CE8QSEZpGK7a+vw6fuvmt14yba9TOC/UESn8Ss3rIxUq4w==
X-Received: by 2002:a17:906:30d1:b0:aa6:6e41:ea55 with SMTP id a640c23a62f3a-aa6b112c3c6mr209577866b.7.1733911408899;
        Wed, 11 Dec 2024 02:03:28 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68880b3f7sm433504366b.92.2024.12.11.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:03:28 -0800 (PST)
Date: Wed, 11 Dec 2024 10:03:24 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
Message-ID: <Z1ljbPFsUdUC8AD3@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-17-qperret@google.com>
 <CA+EHjTw_e_q5TFkgxvVDKxwj-C5S0Hd1OfVO4_FitrB8_J2Rpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw_e_q5TFkgxvVDKxwj-C5S0Hd1OfVO4_FitrB8_J2Rpw@mail.gmail.com>

On Tuesday 10 Dec 2024 at 15:23:02 (+0000), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Tue, 3 Dec 2024 at 10:38, Quentin Perret <qperret@google.com> wrote:
> >
> > Introduce a new hypercall to flush the TLBs of non-protected guests. The
> > host kernel will be responsible for issuing this hypercall after changing
> > stage-2 permissions using the __pkvm_host_relax_guest_perms() or
> > __pkvm_host_wrprotect_guest() paths. This is left under the host's
> > responsibility for performance reasons.
> >
> > Note however that the TLB maintenance for all *unmap* operations still
> > remains entirely under the hypervisor's responsibility for security
> > reasons -- an unmapped page may be donated to another entity, so a stale
> > TLB entry could be used to leak private data.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h   |  1 +
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 6178e12a0dbc..df6237d0459c 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -87,6 +87,7 @@ enum __kvm_host_smccc_func {
> >         __KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
> > +       __KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
> >  };
> >
> >  #define DECLARE_KVM_VHE_SYM(sym)       extern char sym[]
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index de0012a75827..219d7fb850ec 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -398,6 +398,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
> >         __kvm_tlb_flush_vmid(kern_hyp_va(mmu));
> >  }
> >
> > +static void handle___pkvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
> > +{
> > +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> > +       struct pkvm_hyp_vm *hyp_vm;
> > +
> > +       if (!is_protected_kvm_enabled())
> > +               return;
> > +
> > +       hyp_vm = get_pkvm_hyp_vm(handle);
> > +       if (!hyp_vm)
> > +               return;
> > +
> > +       __kvm_tlb_flush_vmid(&hyp_vm->kvm.arch.mmu);
> > +       put_pkvm_hyp_vm(hyp_vm);
> > +}
> 
> Since this is practically the same as kvm_tlb_flush_vmid(), does it
> make sense to modify that instead (handle___kvm_tlb_flush_vmid()) to
> do the right thing depending on whether pkvm is enabled? Thinking as
> well for the future in case we want to support the rest of the
> kvm_tlb_flush_vmid_*().

I considered it, but the two implementations want different arguments --
pkvm wants the handle while standard KVM uses the kvm struct address
directly. I had an implementation at some point that multiplexed the
implementations on a single HVC (we'd interpret the arguments
differently depending on pKVM being enabled or not) but that felt more
error prone than simply having two HVCs.

Happy to reconsider if we can find a good way to make it work though.

