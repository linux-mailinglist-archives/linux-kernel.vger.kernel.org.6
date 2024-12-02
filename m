Return-Path: <linux-kernel+bounces-428193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71999E0B44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C32164758
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D311DE2A7;
	Mon,  2 Dec 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMTD3JLK"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967047E0E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165079; cv=none; b=VitB8Ux0hdt6sraFua4VUo0lZIqa2HwSi1fKoTOwKvZzxPtVp5nQ0khgSZXUrOWuTtxO8HjU1x356h/erFqncbWV/7nZq/Y0jkMCU1kTBMLdZgQipBr4k9S1ujqAaAf9delEKQpg512v6QojoXBJlEL7MIjYKJ+MhWRpMt0hgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165079; c=relaxed/simple;
	bh=XMiiPXZTYZeEpJBk8U9EnSPpjw/bdDBl+/T3JKR0A3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWaAxwgWOzbtuxhFb4WRXmUr7L8pdz1rYYMwBt6SoSrK4uYQKHx2w+RDlIyvLim5gFYAC9b6J4kEuXqAxqtk/qb9OQ1elkHomh7sAkLlYOPdXf53Wj0pD0IQ2CkbsMEGy3qZQ39+NIkgiKIevK1vyaycUUyLOEcb5qLJNYyAYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMTD3JLK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef7c67ee52so20835787b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733165076; x=1733769876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvvKZTjXnx9iZrBeE4PJ9zcvpwtrkWJI0eWnaDHr26c=;
        b=uMTD3JLKzC6D89WAvu+vzZhO/NmYdWxmy++MHdi/DlmWk1XgprK89Slp2Si0542Ctl
         7RjfFy67Xw+ud2rAbO5f/My8cqc7kOavPExxmNBW2aD+eXNl8r62yNvSWvGk+ZsdFXlH
         K+0JWRUeNjetQEdlI0eE0Fiix+YIf5Y6O4dDJ48Pl4zfRq0YzbVQdiiOUp5wz65KDHex
         PFkcVGw1knBlxViwH32p525GG1pAZZSkFjKrhC2S55U4NbMVDV6yp7F6ODMcQm7uo2vZ
         rl1dEtmbWD7tq7M4bwH5WGOWIhbVgE1GUhv3PcfsJ2wbd3kC4kEiyo29CmI+aboTEVCt
         zulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733165076; x=1733769876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvvKZTjXnx9iZrBeE4PJ9zcvpwtrkWJI0eWnaDHr26c=;
        b=Zc6lbEloNMPmy1QaoZ0dEiM0xNTPG+T0cD2fFMlhCMURnANE+/TDnmGWvGVDJAhKFH
         bUXVd95/DJiK0M9Txw5JZyMTWv6WehvS0A7xxp+KD/h1sHUhIudapvBvHlQk5yhjpkhY
         RvDX8QUJeqHN3F+7K/mctmwZ0VKxYO0YSi/nBYdrN9zEbpncdcvPf8m/xSyQ+/1z/D5K
         B/cQzGRDnuk9q3ByYKApGIsDe2mEmJ3mVTnVBIzaQGgUQYIttDUrdlzJvsYkA7Hd4W/y
         KCTpMIWPWkhvnj9/CdHRZEosLNpQkf+yKHfvJD0MP0Q90sNtexjZ37R+kteRLiwdZMY3
         9Bgw==
X-Forwarded-Encrypted: i=1; AJvYcCUtUsoIUqIx3/rubatcJ3qkBXJ5m2uW86v+dmvXCkNgNtXJnH4nLhdoLsayISk2+nIB+qD+JRcsibR9Fkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/0sSbpMBdlNKT9QaPVnTQfn5+xXelAgnDU8max01ptJH26OM
	xm9FZ2rH8+HPtgEYSHhFx4a1pTQUbSiHKaqnL110e+xlDDuTj4BNB5nQqkKaO+8ix6hfrwaDr4e
	tXw==
X-Google-Smtp-Source: AGHT+IGY/pWE/JvM1zeCaiXWWtmArKkTSnFTXrJ8bYSxAS/RlH7PaacfBmlD9LvJsCAXHrFgB51idE3WnAQ=
X-Received: from pjbli9.prod.google.com ([2002:a17:90b:48c9:b0:2e9:38ea:ca0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:388b:b0:2ee:f80c:6884
 with SMTP id 98e67ed59e1d1-2eef80c6ae0mr1153622a91.33.1733165066275; Mon, 02
 Dec 2024 10:44:26 -0800 (PST)
Date: Mon, 2 Dec 2024 10:44:24 -0800
In-Reply-To: <ce45a9cb-44a4-4a3d-bc81-608a0871ae6d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com> <20241128004344.4072099-6-seanjc@google.com>
 <ce45a9cb-44a4-4a3d-bc81-608a0871ae6d@intel.com>
Message-ID: <Z04ACJSrBSPlyqY4@google.com>
Subject: Re: [PATCH v4 5/6] KVM: x86: Always complete hypercall via function callback
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 28, 2024, Xiaoyao Li wrote:
> On 11/28/2024 8:43 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 11434752b467..39be2a891ab4 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9982,10 +9982,11 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
> >   	return kvm_skip_emulated_instruction(vcpu);
> >   }
> > -unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> > -				      unsigned long a0, unsigned long a1,
> > -				      unsigned long a2, unsigned long a3,
> > -				      int op_64_bit, int cpl)
> > +int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> > +			    unsigned long a0, unsigned long a1,
> > +			    unsigned long a2, unsigned long a3,
> > +			    int op_64_bit, int cpl,
> > +			    int (*complete_hypercall)(struct kvm_vcpu *))
> >   {
> >   	unsigned long ret;
> > @@ -10061,7 +10062,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> >   			vcpu->run->hypercall.flags |= KVM_EXIT_HYPERCALL_LONG_MODE;
> >   		WARN_ON_ONCE(vcpu->run->hypercall.flags & KVM_EXIT_HYPERCALL_MBZ);
> > -		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
> > +		vcpu->arch.complete_userspace_io = complete_hypercall;
> >   		/* stat is incremented on completion. */
> >   		return 0;
> >   	}
> > @@ -10071,13 +10072,15 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> >   	}
> >   out:
> > -	return ret;
> > +	vcpu->run->hypercall.ret = ret;
> > +	complete_hypercall(vcpu);
> > +	return 1;
> 
> shouldn't it be
> 
> 	return complete_hypercall(vcpu);
> 
> ?

Ouch.  Yes, it most definitely should be.

> Originally, kvm_emulate_hypercall() returns kvm_skip_emulated_instruction().
> Now it becomes
> 
> 	kvm_skip_emulated_instruction();
> 	return 1;
> 
> I don't go deep to see if kvm_skip_emulated_instruction() always return 1
> for this case.

It doesn't.  KVM needs to exit to userspace if userspace is single-stepping, or
in the extremely unlikely scenario that KVM can't skip the emulated instruction
(which can very theoretically happen on older AMD CPUs).

