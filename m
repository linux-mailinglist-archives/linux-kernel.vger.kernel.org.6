Return-Path: <linux-kernel+bounces-209162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC992902E10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA428342C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83269475;
	Tue, 11 Jun 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Id1FNBKs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C1AD21
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070479; cv=none; b=HjZ5fugnzBBVGZf/CNhZ31p0BHHbbxKIfaydto8THYgCBQAT/ZIg5MgmImtKEn4DKWNCnIW+C8fAVuqZBqdCMneYcjrxZsnkx9EiJcuH/g8JSicUNHXYNoSu9VfyHvFv9zUhYcA9UOYGh0ZVg+RSo3Z5pDdaefqWHtvS7oVms/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070479; c=relaxed/simple;
	bh=xSn9LKd1fH6i9tslU6Ro3+h5y20uAOynniftnLBoTGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoLxYFreEtnK0Dzr4Hvn19UIALdUNn6F88hNT/AQyibgjvcp/8oKNnTUCkN3/GBpHEMXpq+6bPY5HMEB8CnGvtAGvdql+jlHISMOs7p5HGcRzEjDLTjer4G+I6FqS8g3DMblp+a2RdJLCaJa08lBtATeSVVwkKUsdmCTNvTtJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Id1FNBKs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a08273919so76612447b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718070476; x=1718675276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDJo9SRFc1aS20uBMFMyPVgSvPmQ3yACc/Ngh8xI8Rw=;
        b=Id1FNBKs5jO2T04T3aIZl7OyP818i28P+I3R8+k8GOYlNn8ySeUOzNaqxMXpopfOYk
         Bvzt8jMi7/Xd9Z9Py7iv+falr6X9ut6uxFyBV+7wIhwHSJ+lCg2SRUV8wJJCn7J8Nts0
         hHgzjY7YTh267GH63fVvHPkBcZNiT0b7s+bYa889xqJAtiOuQ37rrbBeWWz/HuC7cATu
         B9aINzeDX4Atc4ww/zcvSys1pGqSuhTjEtngTDaLH9EBORFZGLed/NKhWhodiaWwqvTV
         lUiCNCw8V+ytn/BpdaGyLM/JxAv/kdzj1nUoR4hhqJGYxmXhC7//uVp4/VLrvBopdV5t
         pj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718070476; x=1718675276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDJo9SRFc1aS20uBMFMyPVgSvPmQ3yACc/Ngh8xI8Rw=;
        b=lHlPCBhMNNVmDCM7JyKKK3Fr4UUEp/Rlwvjn6O3vJwYL/wP+k8m/hgv9seVPPTtjpy
         KBUchtgdyJekFINnyDdpKmniR/7tpc7F4tM9IiOjuyZDvMSKho2YHfoxdoASkuPXXdeF
         9ztDWc/KEzAcI9UiD4DTSm6wxj33en+9C1bTK2ihs+0CJ9J8yP1BG7dS8OPZs7fbUehJ
         Y40kFNasZvlP7DVDROBgekjoywHKNuIRQk6dOHmrJsV4UQFRYwD5ae7BwblAsJRjwBOV
         Ku2BrcdF/5/gulBlYd+y7pptBPhY+x0Qw/MgCs2DaqRdU8d21zMQaxGDy76gpLnSqWmo
         MUOg==
X-Forwarded-Encrypted: i=1; AJvYcCXWQ8XIhAzdNSM1MnvrgB+oQgM2pQiKJl8Xeee+ULygWkqKWRcYFOr0J7EF4uQVfMJqsizurisAdgKZCCK2LN5hkFjjf4GlLL2bJpnO
X-Gm-Message-State: AOJu0YyqeGUQoM43BRdTKVIa0O1w3hf8nB003LRPR585q8yXEmOuXbOK
	aeDudeJH8oal8PpnjoL6DWad5xB763nskIRl4guO/QIzNMeVrO4VldYdmm1MrWQFwr32Hzos/vo
	bDA==
X-Google-Smtp-Source: AGHT+IGbJpvEmPzc59vYofKj8M6dT7mk+QleIgsooCPhhNQ1VMVn0kw9mff0x4+8jm7TY0avKpFpofd27fg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:dfb:335:427f with SMTP id
 3f1490d57ef6-dfb0335481emr803052276.4.1718070476598; Mon, 10 Jun 2024
 18:47:56 -0700 (PDT)
Date: Mon, 10 Jun 2024 18:47:55 -0700
In-Reply-To: <ZmerKzEHlIwne5ka@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605224527.2907272-1-seanjc@google.com> <20240605224527.2907272-2-seanjc@google.com>
 <ZmerKzEHlIwne5ka@yzhao56-desk.sh.intel.com>
Message-ID: <ZmesywdpFG3qDIkZ@google.com>
Subject: Re: [PATCH 1/2] nVMX: Ensure host's PAT is loaded at the end of all
 VMX tests
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	Xiangfei Ma <xiangfeix.ma@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 11, 2024, Yan Zhao wrote:
> On Wed, Jun 05, 2024 at 03:45:26PM -0700, Sean Christopherson wrote:
> > @@ -7274,6 +7275,8 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
> >  					error = 0;
> >  
> >  				test_vmx_vmlaunch(error);
> > +				wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
> > +
> >  				report_prefix_pop();
> >  
> >  			} else {	// GUEST_PAT
> 
> Is it possible that ENT_LOAD_PAT of GUEST_PAT is tested when there's no support of
> EXI_LOAD_PAT of HOST_PAT?
> Then
> 	wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
> is also required in this case?

Heh, in theory, yeah, a nested setup could create such a monstrosity.  It's easy
enough to handle, so I guess why not?  Though I'm tempted to assert instead,
because practically speaking this code will never be hit, and thus never validated.

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 2063ee90..ffe7064c 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -7288,6 +7288,9 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
                                error = (i == 0x2 || i == 0x3 || i >= 0x8);
                                test_guest_state("ENT_LOAD_PAT enabled", !!error,
                                                 val, "GUEST_PAT");
+
+                               if (!(ctrl_exit_rev.clr & EXI_LOAD_PAT))
+                                       wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
                        }
 
                }

