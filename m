Return-Path: <linux-kernel+bounces-244911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46C92AB5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8718B2112F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF2714D718;
	Mon,  8 Jul 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHIXglAE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2B1EB44
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474663; cv=none; b=Upvrn5QtKVV/+vZyIr/jzjGBFCoAS4uGNDOwD+rgRtVVBJi2IFjGFj0+GNePrUgL6qE3N8qL5AuoK92/y+ci7vi4uQJfyh3MOp2aVIyI9MMa7NC0VBWBcaX3CNrBiJyKQ4KrBk0EgjTYQQQwRd6OTjzqa8H64TCN/XEtiqgGioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474663; c=relaxed/simple;
	bh=rnKDQudiRYboIXIxW3KZilr/F8Ck6nastO1izzGWj/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HC1qSI7yeiutmARAIzMxYDc+xAXuG2rm54QjSlhcQ2xs/jhAsIJWJ6Dwm3Bu5xfAZlzZVxY8DGb1H+6e9fAnJwAPwj4kIm8B9OjB1OPzIfQUf9VCxym/Kssf3cAezg3UHv9y4IjlYRGu0slUT6RESDXqvwWUrHt8UeuaOZ5lghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHIXglAE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso8107466276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720474661; x=1721079461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJZVptd3IywbKFK+zEIhadT/eRgCc6sBTUUHcoA5IF8=;
        b=gHIXglAE0PyjP2VCsUOxxnr4yTeYLTzy6xZ9S6jAITr32vArbNeHHLciO9f4D767jZ
         PVkvoDHHjB5QiSRqmz7kKtGAHNL4zIdi7o/sf9iwj5gRriib5TE6iNsnCfJeJM300/g+
         FAEV+gGEMsEt+zzIGyFmtaKCelOQBqgSkE+XcjTdaJDr67tZQTaMWw3mw7v2x2NX2S8F
         hzNcqxTtvcJAc8ZHcjait6ji5+y2Z8PIFU4xt/m06Y4vAIYgm4cDA+1mQtfO38v9CewQ
         qia7l8bqB+xPKxb8tJon6Jc0HidrX16iIUel6s05PYcEq9b8if5R3qoBawp20eS0xw/m
         e8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474661; x=1721079461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJZVptd3IywbKFK+zEIhadT/eRgCc6sBTUUHcoA5IF8=;
        b=WlWfIDtAkBZFRQh0dqSeJKHToLfzjhZKtOfQ40WXMr79uA7+nHWAUe6COibKXEorCr
         cC4Jaza9ZDve8OhkxcEGLFY/yqU59Yxny27pN8WcCH/HP/A9bE0pDeI8yLMyP21XKdHZ
         VpzYTeouob8eX2gtUkfP6YQrnS1mTpuCHb081PkX1ROogTm0pS0EkocpMVRibmBXqd4a
         SwkUloPPECHhqFXtWneTctEIdyl+MOW7OFX8JpylxUdhSjhFAE0oeMQl0Pl9He2Qaqri
         uTuhspYxWRqRbItHt5wthtf62kOOT8mpMlywVDeIomy2jWtYogfZ8NMcyKPOP5AbFq/D
         BOdA==
X-Forwarded-Encrypted: i=1; AJvYcCUIFRRutCm5okGKAEwxNC8BMVX/UrH4XnwmaRGJAivgpNUxPnSywMSWV/EbPRqyFILZx6+B6aMC9KDF353uM7ugaV0GCwmRLym47KkS
X-Gm-Message-State: AOJu0YwilTBQCk7foMIyLIgQwlCtASNclrnKsvn7qOSvmZsNQ89IpLw2
	EdYQ9Pubdcq7i0bfOHVNZHULryAcotzKpMwxVQDTnRZo9I+PSRA9dRBoZOF2L4lTxzeFkBdZfXu
	heA==
X-Google-Smtp-Source: AGHT+IHpHAbji4+XsjpJzrAKQm1/NN0P8TYfGMGYe8qxwfqywzn3eDHBR7+4BIezFnN3h8T5PCxdcbjKowM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1706:b0:e03:a875:f827 with SMTP id
 3f1490d57ef6-e041b143389mr2036276.13.1720474661535; Mon, 08 Jul 2024 14:37:41
 -0700 (PDT)
Date: Mon, 8 Jul 2024 14:37:40 -0700
In-Reply-To: <376d0c37d0cf4d578fe13be6f2b3599a694040af.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-28-seanjc@google.com>
 <376d0c37d0cf4d578fe13be6f2b3599a694040af.camel@redhat.com>
Message-ID: <ZoxcJP6AA5sUZBjs@google.com>
Subject: Re: [PATCH v2 27/49] KVM: x86: Swap incoming guest CPUID into vCPU
 before massaging in KVM_SET_CPUID2
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > @@ -529,7 +533,14 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
> >  #endif
> >  	kvm_vcpu_after_set_cpuid(vcpu);
> >  
> > +success:
> > +	kvfree(e2);
> >  	return 0;
> > +
> > +err:
> > +	swap(vcpu->arch.cpuid_entries, e2);
> > +	swap(vcpu->arch.cpuid_nent, nent);
> > +	return r;
> >  }
> >  
> >  /* when an old userspace process fills a new kernel module */
> 
> Hi,
> 
> This IMHO is a good idea. You might consider moving this patch to the
> beginning of the patch series though, it will make more sense with the rest
> of the patches there.

I'll double check, but IIRC, there were dependencies that prevented moving this
patch earlier.

