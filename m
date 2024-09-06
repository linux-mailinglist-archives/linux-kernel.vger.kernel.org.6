Return-Path: <linux-kernel+bounces-319480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C0496FD2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0EF1C22C10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5161158520;
	Fri,  6 Sep 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogfewqEJ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048553376
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657361; cv=none; b=eNbnOscw4HVR+uIA/ncs8JJsHXji52fOKOfnRoAF0A8ckUCYXE+4X6J+hP+7NkS69MdJtMJauN3ptqyXPGhY74As2dIP3aVKOQBkg56p0/F7Queqf/7e+Jdko8u+0xj0j5hT6gYMEEo1xrcRNwUyd04VKv883qQb3ShTYbSZr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657361; c=relaxed/simple;
	bh=eMxGOodtBW2fNQBcV/Vjo5HBI+UPeio/fR7QHQkm+0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQr1EGVzrM86zzo9yW33yxutWONL+BerZIArgyYwz9ZcEqe3cqDJyBdcDn6KStDwTpkzBCahn9aI5dzqZvtrZZWcfTpxinlIuhrQBYsIxWlz0aOuQvf1He9JGHJ9zVgDP0hzFY/LuFr4GMdr2Wt9E8Uz2EiL1LdKHdUXZfKX8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogfewqEJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso5130997276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725657359; x=1726262159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0pikVsuPIymy9mQcsYH9buCVbx4mgvVE8xCp4ufTvM=;
        b=ogfewqEJY2lep2vTK8ylVwsd0cZ7PRTEwzMaDERa9GpKd2iJJbjacssJy0ulKFjMAN
         VIiNIBzznbOSk5TZEHauR3UsOKoqK6TBIM84z0gkurWzAkxZwUNY5Ky5Nza7e0iwRNo4
         ta0b9ap/Gb70Bow9/Lwie70GmBXlsQ/DA7KrxF4O2DVFNA/VDvLI2l6DYnsZAShJuEHW
         R5kKuFjF/V1u8sfok3LM9p3uqVUFmaqfJ3690fMJIhpnwYj5SLR7L1869A7kbwV0x/yX
         9L0we+DfckGA1mhWZD0dpQv5yjb3ZQtcbEMfVlPhvONjhk4BO2CT40KlHdd64IjdMkNh
         8D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657359; x=1726262159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0pikVsuPIymy9mQcsYH9buCVbx4mgvVE8xCp4ufTvM=;
        b=Xyvqfr4DmFUjemWB1BlSPbFbBl+IcG9JAgIMonRhkaQLP+OWGOjcgHLa5TRH1Kg32S
         nAENdohtbbKnVAfVDNEnWwPoiwXdP2WVWTruKvpm7OAntYiONwcEvJ2/mv+sXYYUhQDZ
         CEuhJdR+dV0665lz0YKVA0vec/12TranN1t+qCYzlFJ7QpxqkH2K8lG/N3FAnowIWc7z
         L2N/4k9bG3xu/hyYt16R3TRyr2rF01HR/xrmEUWZ5TvPc+pLmLFYx8+lN+2nezxOXUXu
         Ncbe2xgtQNBtOIo2khIG9wcH9Qq3heWg+W/JBDmk5b7cSRw0R+8q0owt48b9x9mBtQkj
         6GgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhpXCKmNSFqslSCDDLJ1qcSOtDYncfyrvw2pUXGH+AhYDIUcQE56CaHlXSSpRiWxkHspnqXh8kC6Kps24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIibQhSa2lo7p/F2eQ97qmR28vFFGoKvRnuDvGQkltBNoavxj
	FVm1ZQI8xgndiA35bQlxW6PNBdOZ4Ch5t5KUAS+ONl4hSBhk9Ed6iKYDhSnTag/oabvoODkymIV
	kKA==
X-Google-Smtp-Source: AGHT+IEhyXOb6ueTZoO2nNI//nUTPRUCj/uBjHhClAJ2CXjFjvXhugvAh2XP6oo8m69S1gMkq9KL2itwG4s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:81cd:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e1d3485d963mr6031276.2.1725657358725; Fri, 06 Sep 2024 14:15:58
 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:15:57 -0700
In-Reply-To: <y2vqv2k6b3ytwgvxkhl3jlxx2lpfcla6zigccuo426zp63lqgl@zvdztkpwuxed>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902144219.3716974-1-erbse.13@gmx.de> <y2vqv2k6b3ytwgvxkhl3jlxx2lpfcla6zigccuo426zp63lqgl@zvdztkpwuxed>
Message-ID: <ZttxDQ6v-1OAVja9@google.com>
Subject: Re: [PATCH] KVM: x86: Only advertise KVM_CAP_READONLY_MEM when
 supported by VM
From: Sean Christopherson <seanjc@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tom Dohrmann <erbse.13@gmx.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 06, 2024, Shakeel Butt wrote:
> On Mon, Sep 02, 2024 at 02:42:19PM GMT, Tom Dohrmann wrote:
> > Until recently, KVM_CAP_READONLY_MEM was unconditionally supported on
> > x86, but this is no longer the case for SEV-ES and SEV-SNP VMs.
> > 
> > When KVM_CHECK_EXTENSION is invoked on a VM, only advertise
> > KVM_CAP_READONLY_MEM when it's actually supported.
> > 
> > Fixes: 66155de93bcf ("KVM: x86: Disallow read-only memslots for SEV-ES and SEV-SNP (and TDX)")
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
> > ---
> >  arch/x86/kvm/x86.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 70219e406987..9ad7fe279e72 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -4656,7 +4656,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  	case KVM_CAP_ASYNC_PF_INT:
> >  	case KVM_CAP_GET_TSC_KHZ:
> >  	case KVM_CAP_KVMCLOCK_CTRL:
> > -	case KVM_CAP_READONLY_MEM:
> >  	case KVM_CAP_IOAPIC_POLARITY_IGNORED:
> >  	case KVM_CAP_TSC_DEADLINE_TIMER:
> >  	case KVM_CAP_DISABLE_QUIRKS:
> > @@ -4815,6 +4814,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  	case KVM_CAP_VM_TYPES:
> >  		r = kvm_caps.supported_vm_types;
> >  		break;
> > +	case KVM_CAP_READONLY_MEM:
> > +		r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
> 
> Need a break here otherwise -Wimplicit-fallthrough option will warn.

Heh, Nathan beat you to it:

https://lore.kernel.org/all/20240905-kvm-x86-avoid-clang-implicit-fallthrough-v1-1-f2e785f1aa45@kernel.org

