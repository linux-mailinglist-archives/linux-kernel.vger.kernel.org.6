Return-Path: <linux-kernel+bounces-389572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6209B6E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F202B282D83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5650B2170B3;
	Wed, 30 Oct 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX0NOvRK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821422144D2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322827; cv=none; b=aRxm9KZlrhCHfp80D24KOUPrdX3BFrrxGdFuE6+5VSxAdY6GQhn6RFa5lNrI15pG8AlV7aYN3ExXg3VFbgeQv/PiTl5B+Omre1OxmZMkN004wCI+5eiJA9iq0FGBp2xxlZlpQYEux2qwjZXE48mNrM8yY1/WN0KQdUpO3cPUFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322827; c=relaxed/simple;
	bh=BWPAV0AmvW2ZBcdVAybIi1cao96HLaitAZnCfdTAFYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0bAmS/LRQqbVygzpFGAkJbZFDtNwPTQiRixU8AzkppD2XQTuNn1Xlqi9cOsehBa6qhv0A8j+IeD7x722wUQXlg3QaeT3Ue/haoi/J4ciJW8Oh8kSTtzZLxLaEURet007/hkuapgU360nFnRds504Px0QPkX/R0AqE8fmQgIyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WX0NOvRK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730322820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhtWFShgVxLqWJ12SCRLNP9JkXqu4UbH38bSGoLla+g=;
	b=WX0NOvRKbEF7iS2H+ys7rnmEM05x/xc/+CkS1jPqO9jdqLFP+i8xQ5od4B965jqqXCPTZY
	X6sQzJF+mlbONh26AJL+xWozIboc/7B4zdtUIdbViPLbsrhrgF2yiJRG16KBZDAuBFIlgo
	UCGxOic0oTnJZiaOkkIeFG9q9iuXe7Y=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-qA-A9DhoNV-GohlflJwx-g-1; Wed, 30 Oct 2024 17:13:39 -0400
X-MC-Unique: qA-A9DhoNV-GohlflJwx-g-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-84937f5859bso46114241.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322818; x=1730927618;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhtWFShgVxLqWJ12SCRLNP9JkXqu4UbH38bSGoLla+g=;
        b=YQs9pP5+J49UUwr9LNH6afCXoaK7BJvVyJNksC/9NbtuXpcr2WwRnJiYnhxjnnuLcf
         r1YF7GY+yjIxY7jIx+WubH/fx5fHB8vFr5pv460zxvHrJr2q8pmVsBXXiC1oQyCXbATo
         bunJqGbWfrRyhnBCpjDzYPtgR/xZPQ2rce8o8nCwEp+Vl1mmfqnfOY5FPOmaEshDrxfK
         7wrW6++6/jg1YJNracVzgHv5g/VvF1FhOk7UlGES+K1bdz2TMahDXPL098vJZW3RML04
         WzrvFN1+eULf5V2sGIWjnS7FQxctsMkFhh2+VPr/jpMrMT+0hY4cBrnbNfh9c99/iV9K
         /VFw==
X-Forwarded-Encrypted: i=1; AJvYcCXJfNi7wTMX4KqhTVv86d65ghpqYLX71wSLFB/zOGJB0wSaZboHgGyglYcNMAGblEU6Rdva5O9vW4ISLrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bbxvlVHS1vdptCCIpxzhTiqm0TaHZb/b4KEyQTclokRvvniO
	MTz+wl6KMo/Z3UGsErj/hE/LY3vyiq1AUs2XNOkrQjTlPG49+TPlj6Ss/rFyLVvc8qCYLi+ishN
	F+BdphfKUAWlQWmZ3J1Sln5n/MsqgZAIyYkiO/f9xaRKWDmK4W4OunAEEunsA1w==
X-Received: by 2002:a05:6102:5488:b0:4a5:6f41:2143 with SMTP id ada2fe7eead31-4a8cfb42ee1mr16266000137.4.1730322818486;
        Wed, 30 Oct 2024 14:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVMwzTfHk1fhhCuy6E0m1w3eznD1Yt7W0LGKpIBTmxz1cA9r+3mMGyzl7M9m8UEjlP6p4BpA==
X-Received: by 2002:a05:6102:5488:b0:4a5:6f41:2143 with SMTP id ada2fe7eead31-4a8cfb42ee1mr16265990137.4.1730322818212;
        Wed, 30 Oct 2024 14:13:38 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0a10a0sm471701cf.22.2024.10.30.14.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:13:37 -0700 (PDT)
Message-ID: <ab6183a931e7edb30e169bcd944981a7cf484ac7.camel@redhat.com>
Subject: Re: [PATCH v4 4/4] KVM: x86: Use '0' for guest RIP if PMI
 encounters protected guest state
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2024 17:13:37 -0400
In-Reply-To: <20241009175002.1118178-5-seanjc@google.com>
References: <20241009175002.1118178-1-seanjc@google.com>
	 <20241009175002.1118178-5-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-10-09 at 10:50 -0700, Sean Christopherson wrote:
> Explicitly return '0' for guest RIP when handling a PMI VM-Exit for a vCPU
> with protected guest state, i.e. when KVM can't read the real RIP.  While
> there is no "right" value, and profiling a protect guest is rather futile,
> returning the last known RIP is worse than returning obviously "bad" data.
> E.g. for SEV-ES+, the last known RIP will often point somewhere in the
> guest's boot flow.
> 
> Opportunistically add WARNs to effectively assert that the in_kernel() and
> get_ip() callbacks are restricted to the common PMI handler, as the return
> values for the protected guest state case are largely arbitrary, i.e. only
> make any sense whatsoever for PMIs, where the returned values have no
> functional impact and thus don't truly matter.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 830073294640..516cf6c71567 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13213,6 +13213,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  
>  bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
>  {
> +	WARN_ON_ONCE(!kvm_arch_pmi_in_guest(vcpu));
> +
>  	if (vcpu->arch.guest_state_protected)
>  		return true;
>  
> @@ -13221,6 +13223,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
>  
>  unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
>  {
> +	WARN_ON_ONCE(!kvm_arch_pmi_in_guest(vcpu));
> +
> +	if (vcpu->arch.guest_state_protected)
> +		return 0;
> +
>  	return kvm_rip_read(vcpu);
>  }
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


