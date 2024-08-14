Return-Path: <linux-kernel+bounces-286713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E218951E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EE11F235B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF81B3F1C;
	Wed, 14 Aug 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6h+AwkI"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6A1B32A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648089; cv=none; b=c/HVZYN5wZLHQptx4QVDfcy8qeAY8EnRj1EV8YB8kng33vRvlhsygAqeMM1NegHB4H/OPiiGGMXkrNC9EsZ1et+gdousz7uBwhqv1qBgYsbYoFsUIrqblJhL0RF2hjNsD5Pxzn2+jQTgC7WhbTcQZLt7yWqkHd3u9Z5nfUQKzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648089; c=relaxed/simple;
	bh=Oq75bF6b7Xsf6oaRIc8eb6zXZ+JAV3xZdtoY0XlEz1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aNn/r/8YGP2SAZZzKqBaE6Zu1QiFmCFImniX0ws7wL4t1GMgavH/4vU0p0F3Pw0ro5dQxf4xzBm1GohBETDxxHaghUv3zepxdviOEZhy+3UMNo1LLCAgtKRMaeRYy+4fxtkCrKgSUerEpI832TJvIMWUXvnxGce41WVqi7Xuqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6h+AwkI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a28f78c67aso29510a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723648088; x=1724252888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoJQXmjJ2IVbbFRZhVVje/CJkcjIPZibKaR4ShslcHA=;
        b=C6h+AwkI0P/r/ti5DuS3cs6m8ZePqjV+r+EgwJ8k72cNep7Gla20DGmFKb6xLKoV7x
         se89resCetyD1XuYMDYIcZ0eX9DqgDLvI6jGC5sxWOVt4YdH2zn/q8USAqrI+IPVuuug
         0K2NdoOABoFcFaybw+qYuJ6p4K1k79sPKrWjWhji72FVvNEtunXRAmSY99rgdP7XclIm
         S0EUyaSwlizowGxG3pS82wAY9t7V+pIUcFNlw8wBAkuj9a7UV/kS9RRa4Z1IJNgr0PxX
         jhsNgyq/A/cJT2ufBnW/on4LAenIzSLWXt6JfH4Ybo9RRUbK28/P4u6fCR0dVDWC+tu/
         LprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648088; x=1724252888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoJQXmjJ2IVbbFRZhVVje/CJkcjIPZibKaR4ShslcHA=;
        b=m3zHj4RQXSwmYguq+HsrxdMPkLmMscBxiCgV2tqCgKP/fXPiZFUeFJjEOWfZxUJQeB
         ss3Al4MdVmddAL9+3PoSRdESs5TxBKMpYWuhlXYLkAfHBgCVyAhEYzSdWocR7pdqxb7Q
         q3ZzYvbR7c/nmFcIZ9ojOQ8UCEvZx6DHgRN5cBBI0eCYUnQ4GGnpfPYUq7h67KLHXXJP
         BFHOwEfLv1Yfon6JkIvmE9uKBULvUr4LsAbn457O1U9X3M/rZsTh7bYjoHsCDKZ5jAho
         cZlfgFGF0qy+zXry4t1V6DKpQMO8TNYN630ehK3CmqQ9mFlHbHj3dsG6FOdHqlNwaJiF
         uMJg==
X-Forwarded-Encrypted: i=1; AJvYcCXq0DW6zz2cGLkfnz2fm2mMaeepjbT1Shuwf7BplS8oKLC7XqjFjcO+Deh04+RFTqIVmWh5JWYjLbV+2QALzoj3IZ5v6x4enK7TxVLt
X-Gm-Message-State: AOJu0Ywo9+slgiMqlFzB7HURNPcxJuOAn9pZhKbKj1iS4HBX98SyC2OE
	ptOTbFNqerrOsx6cer+8I+wDglHJUhMrehHa6+Keza5QFfjWAYB2Z8/eQt1JabvfjV5HpZy6CBQ
	IYA==
X-Google-Smtp-Source: AGHT+IFSo0qHJU5DQKCgeqRIDwH7U8xGwP62B3Xnf0u1/CK6HYU/5v7+V60gWz2HotfzMrnqap4rQiN4yTs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:155a:0:b0:7a0:d530:86b8 with SMTP id
 41be03b00d2f7-7c6a568e1afmr5246a12.2.1723648087768; Wed, 14 Aug 2024 08:08:07
 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:08:06 -0700
In-Reply-To: <87plqbfq7o.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
 <Zpq2Lqd5nFnA0VO-@google.com> <207a5c75-b6ad-4bfb-b436-07d4a3353003@gmail.com>
 <87a5i05nqj.fsf@redhat.com> <b20eded4-0663-49fb-ba88-5ff002a38a7f@gmail.com> <87plqbfq7o.fsf@redhat.com>
Message-ID: <ZrzIVnkLqcbUKVDZ@google.com>
Subject: Re: [BUG] =?utf-8?Q?arch=2Fx86=2Fkvm=2Fvmx?= =?utf-8?Q?=2Fvmx=5Fonhyperv=2Eh=3A109=3A36=3A_error=3A_dereference_of_NUL?=
 =?utf-8?B?TCDigJgw4oCZ?=
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
> What I meant is something along these lines (untested):
> 
> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
> index eb48153bfd73..e2d8c67d0cad 100644
> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> @@ -104,6 +104,14 @@ static inline void evmcs_load(u64 phys_addr)
>         struct hv_vp_assist_page *vp_ap =
>                 hv_get_vp_assist_page(smp_processor_id());
>  
> +       /*
> +        * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
> +        * and aborts enabling the feature otherwise. CPU onlining path is also checked in
> +        * vmx_hardware_enable(). With this, it is impossible to reach here with vp_ap == NULL
> +        * but compilers may still complain.
> +        */
> +       BUG_ON(!vp_ap);

A full BUG_ON() is overkill, and easily avoided.  If we want to add a sanity
check here and do more than just WARN, then it's easy enough to plumb in @vcpu
and make this a KVM_BUG_ON() so that the VM dies, i.e. so that KVM doesn't risk
corrupting the guest somehow.

> +
>         if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
>                 vp_ap->nested_control.features.directhypercall = 1;
>         vp_ap->current_nested_vmcs = phys_addr;
> 
> the BUG_ON() will silence compiler warning as well as become a sentinel
> for future code changes.
> 
> -- 
> Vitaly
> 

