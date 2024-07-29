Return-Path: <linux-kernel+bounces-266033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7399F93F991
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE828331E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8D15A4B5;
	Mon, 29 Jul 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imN75jyn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F66158A30
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267299; cv=none; b=bVJ4kQ9XSW3M2pCqnC2Vp8QHdTvzkiElWcs6cI4MDw4OmLM+6/oIP9Go6xGUEz7RH9o4O2XUCE5tdzvqvPN0EjxvKpi0G/ivMI7Z8dRUW7uzRtBhQzf5FP55/iWra3lcZCrFs5Y3oNPm88wncbDXr9XTOZ/HY9K2Ci5OAUbZzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267299; c=relaxed/simple;
	bh=St2oF3CEhrw25LU2LpX/lf+cvRv7TUHNtWwkHL5vmIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kHz81aWaXMg8R0MOhXYm5NQ6DAwBxJ3ekGuzetxapltHy7JpJ2LFhvT1pQ4Num2SZHjGA1vo/iT50jGjbADvu0Ve8fteOnAgCa097UedB76GbCLgkpCxk3A++rbmPjHdtFMOJP1dq/dS3noB7Q2b4ly75iNQYu3hSCtlH7GZ9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imN75jyn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19dd3so64394587b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722267297; x=1722872097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5BO85kKfrP3kPw9rl6zi5w//RZnq6rehhthruUWfX8=;
        b=imN75jynXgiAfBZkddT5zvTOcnFaXG7xuErJuhRJi04wvvk0lfCB/2PYfdrcXjC6jL
         P25sAC4CoBn/aT+HnDa1AdcEVfSuTjyMmJrB6b4TdfJwqDJXWxyk0qwYH1up3fM35Ps7
         vJoUtxwSVvKVqKsHaCKna51H7kMsYEvUUs2FVF8kyweR3L+dfX97xAKhjPGPXBAOpq78
         YNPg7VL8ysu2ejAUr1elmYzNPwEMXV01DQbAMeVyR15uZ04pnxOdcA8jwnBfUgpLT9M1
         C/5eExUBi2EpWl7nxSAbiQkf5cyRM60eSq+3w09uBhsahQFIYt5Bc7TcdELyKUkF28uN
         cgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267297; x=1722872097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5BO85kKfrP3kPw9rl6zi5w//RZnq6rehhthruUWfX8=;
        b=fAE3nhhEnY7wHVz/OvJ+tyaXmq4iNuyt9dqROR1oL92pBdhfVqYvvpTaon719OumoP
         I3F/wIdLsKiAkdXOcJGAJ+/39N4Imlir3NbmQvUy+lzmNPEv8F89M/V3Lkva0PlPhOMr
         48fCMDM24tV1zDu6pswPZJr88qCbYTIIHncSiZ6U3SwGG8/+b2e1zlEjSzaYQGcPvNTP
         U5OtIH16DKbYNXA9PMoH5+fesgzy9444nqM85fgLlUEc3XHmI05mCvrQoWW7mWedZUSx
         mORNGT99Kt1SpNoF8jKxY9ATVUS/rU2Y34YT2rsErInVzoRCtpahLkGlZlPBkHieF+hv
         /lcg==
X-Forwarded-Encrypted: i=1; AJvYcCXlDV82Cx41gJNM7SpkLfphbzMAf54GmC2ePy3q9xaKZb48UwVIn/cpqRw8Vg7EemdGdCbeh2Ju5VYB1EZf6LOAj5d/J7oTJnzf1hTY
X-Gm-Message-State: AOJu0YwVDImvtcVmojUl6j4FWp4z97AnSOHVS4p/udgpqRwKUfD6vIEe
	by8a0GHHoo9/sdd4dOeK7Ces9RaRvXme5I2rMhduFKhjjiPJ3kG/tZPvZCwpFZ5F6fXFFP4gZjq
	zgA==
X-Google-Smtp-Source: AGHT+IGGp7Xu/kWdEKL3yO6fLEKcGo5tqaTPTzr2R/VUyXOa/WPokijfHNwntnFNTXLNUiGFfxA29lz41fc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:14:b0:622:cd7d:fec4 with SMTP id
 00721157ae682-67a0a5185c6mr1924627b3.9.1722267297035; Mon, 29 Jul 2024
 08:34:57 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:34:55 -0700
In-Reply-To: <f9b2f9e949a982e07c9ea5ead316ab3809e40543.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-41-seanjc@google.com>
 <030c973172dcf3a24256ddc8ddc5e9ef57ecabcb.camel@redhat.com>
 <Zox_4OoDmGDHOaSA@google.com> <f9b2f9e949a982e07c9ea5ead316ab3809e40543.camel@redhat.com>
Message-ID: <Zqe2n4e4HtdgUWgm@google.com>
Subject: Re: [PATCH v2 40/49] KVM: x86: Initialize guest cpu_caps based on KVM support
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 24, 2024, Maxim Levitsky wrote:
> On Mon, 2024-07-08 at 17:10 -0700, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 0e64a6332052..dbc3f6ce9203 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -448,7 +448,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >                 if (!entry)
> >                         continue;
> >  
> > -               cpuid_func_emulated(&emulated, cpuid.function);
> > +               cpuid_func_emulated(&emulated, cpuid.function, false);
> >  
> >                 /*
> >                  * A vCPU has a feature if it's supported by KVM and is enabled
> > @@ -1034,7 +1034,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
> >         return entry;
> >  }
> >  
> > -static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func)
> > +static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
> > +                              bool only_advertised)
> 
> I'll say, lets call this boolean, 'include_partially_emulated', 
> (basically features that kvm emulates but only partially,
> and thus doesn't advertise, aka mwait)
> 
> and then it doesn't look that bad, assuming that comes with a comment.

Works for me.  I was trying to figure out a way to say "emulated_on_ud", but I
can't get the polarity right, at least not without ridiculous verbosity.  E.g.
include_not_emulated_on_ud is awful.

