Return-Path: <linux-kernel+bounces-395869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE39BC42C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24EB1C21087
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631618E030;
	Tue,  5 Nov 2024 04:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLISp5xV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9312746B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779345; cv=none; b=WKtxkdG+t4JGHYH4uMwMr+tIQH9x67KPkhEH6i2Wvhls1w7lHOwBb682a/Yw9TAAFx9uoZnGMCIfpVY4ZBOyIAwqILexhQE4nd5vN4o3ZiYbFqMDDTZVT+B7umP0KBfOJBU4R+2GG6c4OnT8Hyf3WcaWhsIIyzWD6rDZ98/QeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779345; c=relaxed/simple;
	bh=Q2ss3K0zUMNodh6re2TKxKMMxEsGdxBpibUn+uIdaRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mJJEgIV+SCM7EisfN/nYsLuphH+86BzKEwKe8D9KVcjEt/JW+iIg3PZNWAgZKnsmAWZmDC865parlDYJdDLC4cKKHxoCXPWQun2SgY6dBRusJGozjG7YaaLkZi7Wh7h++udrzjVErtGW9xM6cFAbZuR47FO5CzU1kk4LVSLdhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLISp5xV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso8346025276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 20:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730779342; x=1731384142; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgrjmNrE+sRa4HOuh2Xl136a90BP2rGwHQTnSwPDwGg=;
        b=yLISp5xVh10DgW/Um3mq1wUA9ZR0ImO0vuSiEuo32FpZ4xj3evejokqna/B57uFczp
         oEy+N4BKUjjemo+gtk1IQ1ZiWIWMj6vT4CjIIUJTJFSDJh2jRDa6mrQ0tceZmejf2LE/
         61L+80Mv5mZzXEfj6vXYeq+5QHk43roXcw4avuFqgUMQGqPWgFLgLQyeCiXyBveXzTM1
         SBoNhbuaNlf4cHJXhIO9l1MdQuYjCae679NLKqD44HGJaXe9WP9yhS7N32b+wdNSdfyu
         Zpn6oDa1S49Oap1JbJI2D06adnzkvCZWeKjWxs1afGwSkDE8RjfZubThrFvIYp9Fq5N3
         /dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730779342; x=1731384142;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgrjmNrE+sRa4HOuh2Xl136a90BP2rGwHQTnSwPDwGg=;
        b=uRHJAi2pvIn4GO5RwVJXNMm+pUEwmJOxNsr9NoBrWj9B3yxdUFIK4s67xDZ0BrjI67
         EYm4t182dbjFBSeAfw6xef5g2SRefoFC6nm7nO86p+1zz4YAxiJ8C3bX0c0xD7ldmx/y
         CoxbKVspixMefJ4gjrQwC0rO0ijMQK25AbvgS/tFY4lYz3Sp86Fa637XckIQw2V1vu40
         K2hwhDNuuLfVAiusjLpRcYYVl8q5Oque1Gpyus1GwakMCzW55OT1XJz6uAkquyaCwKRf
         4RPPrwqkaBc6krzQAIilFCYMhC0LDsRpOv307DBOX0EDZs26q8FwIclBzuRPMVyBcJoA
         NVAw==
X-Forwarded-Encrypted: i=1; AJvYcCXaRNxN2rQxUOPc0IpWaPNp3fk8yZf/aLG0/EVOdysrDHSVkHvQ90RmCO824eqEm6PAcDyHKTph36Q59W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuY0rl8KMfx4SPkwi15vb7CyG5LPD2tQ5bfdHJa9fbiOqBFxcm
	jaE+UPkFi19RunX+I/BswujbrIUBUI5rHNFxRf2LmPumO2QxTlsaMICgFAK851AwhiM+BpHayJa
	4YA==
X-Google-Smtp-Source: AGHT+IHspGosbXbU/DsEEGHwYchnFt8SVWi/UJ4FV3mIGekpd4lux+5J+U19BVyi5SEyfjeTUHJXXPx5ZQ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:a291:0:b0:e28:e510:6ab1 with SMTP id
 3f1490d57ef6-e33026b3c56mr9958276.8.1730779342553; Mon, 04 Nov 2024 20:02:22
 -0800 (PST)
Date: Mon, 4 Nov 2024 20:02:21 -0800
In-Reply-To: <20241101192114.1810198-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101192114.1810198-1-seanjc@google.com> <20241101192114.1810198-2-seanjc@google.com>
Message-ID: <ZymYzawDv2wGA2c_@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Markku =?utf-8?Q?Ahvenj=C3=A4rvi?=" <mankku@gmail.com>, Janne Karhunen <janne.karhunen@gmail.com>, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 01, 2024, Sean Christopherson wrote:
> Pass the target vCPU to the hwapic_isr_update() vendor hook so that VMX
> can defer the update until after nested VM-Exit if an EOI for L1's vAPIC
> occurs while L2 is active.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/lapic.c            | 11 +++++------
>  arch/x86/kvm/vmx/vmx.c          |  2 +-
>  arch/x86/kvm/vmx/x86_ops.h      |  2 +-
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 70c7ed0ef184..3f3de047cbfd 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1734,7 +1734,7 @@ struct kvm_x86_ops {
>  	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
>  	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
>  	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
> -	void (*hwapic_isr_update)(int isr);
> +	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);

Oh, the hilarity.  Got that one wrong.
 
  d39850f57d21 ("KVM: x86: Drop @vcpu parameter from kvm_x86_ops.hwapic_isr_update()")

Not entirely sure what cleanups were made possible by dropping @vcpu at the time.
I assume the end goal was ce0a58f4756c ("KVM: x86: Move "apicv_active" into "struct
kvm_lapic""), but that should have been possible, if slightly more annoying, without
modifying hwapic_isr_update().  *sigh*

