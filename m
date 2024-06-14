Return-Path: <linux-kernel+bounces-214346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C3908320
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F08B22DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB591474B5;
	Fri, 14 Jun 2024 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSDsRTdp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37D12D760
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341263; cv=none; b=B02KXY4rYVNfV+GvqwMeWIR2I90Hrzu36ISia1CZFhIaUCJmskTkPJCzsBpSA7cBD2ivo9Z2VqTjMl+H0uoTnky/+MWXZsWIC4b9eCCGS7DRUvEfOIUSofAiBdL/XB+g8oig7W28F8ZoKOmaceKTM7ZU2NHXz6THCCz5kFzsM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341263; c=relaxed/simple;
	bh=unI3L0rqP6h/sPw8j/2gQP67uQSqdIefSCxe/Ukecx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1EVv1AthIMh4+t/6ypnV10qa+kBccG3t2veaaLDKJUbXDSyy0i4lM95OGBkhNdvrkPJiJM8cEubOWZVdRGReEP63mjOWDfDHzAFvrg2aDz0ANo33lCZ2RcXvqBIHg/tCFM5+V8frxa4WQmxQf9P4y7sXxv0Y7sBl1BmaISXaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RSDsRTdp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso17656325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718341260; x=1718946060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0HUgUlG9vEDCQkG97tpkj3YnGaT01iQTHtx0RmuTwc=;
        b=RSDsRTdpraAHdlblduBVTZ3l5XTrk+dkZzw4Hbep7eEcs7bo0VWeMM11YK2pIo31No
         B87c/Nr4dReiOGGnz7/mWZbZdF7jWuGbKS4Q/L0FcTqpx3kAioCp6CEYu9UJTkM1iTJp
         uED3KbETZMsn2f0QkItVuAf3aa+n46p5UYkSlg4tJYPziKXgKR6HMmWY8abVsZ9bjhvK
         HbB7ckrA1AdxJMndCA0hVVyDt9cxRMTEUbC7mRdASNOWC+oFF9Eex8BsASZSkyhERBCo
         MV8oBY4rYWaa8qDaw5ZTAV9KW6/wZ8G71lzGHZpQ8jCNIl1Cd2VtR2FnQSlKLd65Vqmq
         KZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718341260; x=1718946060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0HUgUlG9vEDCQkG97tpkj3YnGaT01iQTHtx0RmuTwc=;
        b=SY1WeV+Td2jq04+mqB8jrEiLzVmpgPr8B8z47z6plHNeBBq/5/ntk5sI3bXlQVf04h
         a9TnsYv7DA9qB+1loEcJtuESwg4zNMcB1llR3iTZ0zHcns6jdFcX6JO9exbfh+TxMhaR
         4dSidNY54DM9lZ8QcQHHXFSzFftSVsVCSGp+G0bXzdT71UXRHLptzMDJtophASySfWKk
         mUVWa+DPyb7LfgUED6VFIbykbOOtzG2ZpBrZF8n2g1G5U2t+OwFumttqJGdUFQhf6PjA
         vUj05Xb38UO06Vmr34/cQuwO08dpG4pIIypyTVfyERWQ6q8NvY9d3/y+arbSj5QidyJa
         oh2A==
X-Forwarded-Encrypted: i=1; AJvYcCXomJlpFwaPVdO6hhHcfUdkxsvihpAfXNZfRxSa6y+6IHchyVGH47Qfkdy4NawNtdDSZd9fpQOtNkJLr4Z+atW4UTUrqCe4Lm9m82Cp
X-Gm-Message-State: AOJu0YzFLgqYRYx0pduo3Bss1gN1Aa6rKdxno2l9NeNzndhS8fTGKaDR
	WWo4aIeVKqMTCXpoInsjvvUW3bDochzcjJ7tKvGqp7z271mC2YyWxkkHHkVcTCc=
X-Google-Smtp-Source: AGHT+IGPB1MGLUnBZL8a7B9fGtRl0d/bVZarsDuhFdm934/bCtuNxQOG73AJASrw6TwdGPdoAQ405A==
X-Received: by 2002:a5d:6e10:0:b0:360:728d:8439 with SMTP id ffacd0b85a97d-3607a4c864fmr1464554f8f.2.1718341260141;
        Thu, 13 Jun 2024 22:01:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104954sm3274027f8f.99.2024.06.13.22.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:00:59 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:00:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Yi Wang <foxywang@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: fix an error code in kvm_create_vm()
Message-ID: <29ed61a4-5f06-4c27-aed4-5ac3de3f45ae@moroto.mountain>
References: <02051e0a-09d8-49a2-917f-7c2f278a1ba1@moroto.mountain>
 <ZmuF2PsVot33fS1x@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmuF2PsVot33fS1x@google.com>

On Thu, Jun 13, 2024 at 04:50:48PM -0700, Sean Christopherson wrote:
> On Thu, Jun 13, 2024, Dan Carpenter wrote:
> > This error path used to return -ENOMEM from the where r is initialized
> > at the top of the function.  But a new "r = kvm_init_irq_routing(kvm);"
> > was introduced in the middle of the function so now the error code is
> > not set and it eventually leads to a NULL dereference.  Set the error
> > code back to -ENOMEM.
> > 
> > Fixes: fbe4a7e881d4 ("KVM: Setup empty IRQ routing when creating a VM")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  virt/kvm/kvm_main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 07ec9b67a202..ea7e32d722c9 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1212,8 +1212,10 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
> >  	for (i = 0; i < KVM_NR_BUSES; i++) {
> >  		rcu_assign_pointer(kvm->buses[i],
> >  			kzalloc(sizeof(struct kvm_io_bus), GFP_KERNEL_ACCOUNT));
> > -		if (!kvm->buses[i])
> > +		if (!kvm->buses[i]) {
> > +			r = -ENOMEM;
> >  			goto out_err_no_arch_destroy_vm;
> > +		}
> >  	}
> 
> Drat.  Any objection to tweaking this slightly to guard against similar bugs in
> the future?  If not, I'll apply+push the below.

No objections from me.  :)

regards,
dan carpenter


