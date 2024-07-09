Return-Path: <linux-kernel+bounces-246563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7E92C393
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DE61C229D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2A18003C;
	Tue,  9 Jul 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Onux/iuN"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B31B86E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551648; cv=none; b=PfgRJbLqzHVKc2vjhB23lnaRR1UK9o6qSrFnuZhJYipznv422vMcuj20kgP+s4aL0pugMA6ri2TOOLson5KdtFuIAi+ujo4golGnd3UN/kAVnjGM8Mr2wUeNGBi1jM+zwlpPxDloIXRS+ycsnReEnrlWsUv1IhZFxdwZYAD5Vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551648; c=relaxed/simple;
	bh=KgHlg08ugzoAyJafomNsXB6uLitcla3YPdA6liNY/6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgXeiv5lXtpxg/vC2D/cuyeSMQREq4b5o+sz4pR+RVaRwQNry+Uvv2/n5dpAmGR/imy1BCew0ClLTmAPQIx+RyEO0SQbQSuNpf0CC1J5tT3fWcGi++1YdwW7pSBF0xrkpLR9kbU8dUgamVUGc0AtYtF4zS25r/tOk38Zyt2L8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Onux/iuN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7278c31e2acso3617487a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720551647; x=1721156447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5ktds/3luYVxWenh7ZKPzZUqTBRwd2YZfHo67RxJG4=;
        b=Onux/iuNQAezqo8S9MU4adxgPBN2jG2Rp0qXHdQWDXktrxBpWX6Pe08Tpl05YgKLLQ
         r/o4v/MpmR+66SJvXqKDbhTIBlt9kBt8TVG2tVulYsXDOKJEenMR0SL/Pz6TY0yPplI2
         1bEaAPcw6KmZ6wU5N7zywhjb1uty0SWNDYVbK1FUyXcmo25TOqNm1sSEb6eQio1D2fRz
         2p2qXVgWzLjme4//lmMgMjcCCA6dcv0yHW2uu28Cim8cyHmmEbq6xg8oeLFPYCktNAAe
         RHtQhkGLcLP0PEMkdPBUYfhaEqBS5/vRiQd38TbKrsEbnWoVDlGI1Ir4tgoh2fvLndiU
         LORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551647; x=1721156447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5ktds/3luYVxWenh7ZKPzZUqTBRwd2YZfHo67RxJG4=;
        b=oZ4YK/4cXLOZA8g+d+GGUFiuCz83dwhjoQ4cS0cX0fZwmPhu8N0eWt2CmobVZ+fCV/
         8d0rM1PIf2fyktpi1bVxoN3GmRvnJwxR0chXxs/0q+cFdISTQst2FEWpxM23KXbCvcVB
         62Ll+xet45JIcqoxuukducqD7Tb6jsK0CCQdM5eKPDKnj/U89dRrkl3+rVsb/sakL6oj
         X/T43oDtof1jZIBn9KgfaXSidojJJ6NdYFqqux5tqdF6F4TbdGV67BLEz0tIEU1MdTIz
         7vooHegS6POZkqkM/zFCfThMHNRaTLq4xXEYBMUqmJF6kxkg38OX5lv+Y3jj3oa4WuMT
         EMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7G9fk0lw/LNI4GcsCnRKieQlhwwT8GwrtZ+j2HcsjQgRG8ACWtykE3X2JVrJOM28vCC1zPSo4z/aSMb0q36TNzCXXf3qackIlZ/Bw
X-Gm-Message-State: AOJu0Yy7jQhBOQ1QmgKGDd8jNELG7RhFvgvePTJCrbh7qmJj7mRfUFNL
	8MSEwnNsxHm+2E8F0EfWwS54M5ehH0STG9tP/v59OiqW7DZxfmwKQuEp0rbiGZ7tSp/x2zrhcrT
	aKQ==
X-Google-Smtp-Source: AGHT+IE3UNnwa6dMa0FwlUP5/4LrbcE8x0+b9LXSVdxKQ7jzCU3+gDYotGIrWaDhvj7SxN5jBJcinb7pt18=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:fd1:b0:6e8:bccc:a78a with SMTP id
 41be03b00d2f7-77dbe517f0bmr7012a12.12.1720551645769; Tue, 09 Jul 2024
 12:00:45 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:00:44 -0700
In-Reply-To: <5b747a9dacb0ead3d16c71192df8a61e8545d0e6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-30-seanjc@google.com>
 <5b747a9dacb0ead3d16c71192df8a61e8545d0e6.camel@redhat.com>
Message-ID: <Zo2I3FChU58bX7qH@google.com>
Subject: Re: [PATCH v2 29/49] KVM: x86: Remove unnecessary caching of KVM's PV
 CPUID base
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
> > Now that KVM only searches for KVM's PV CPUID base when userspace sets
> > guest CPUID, drop the cache and simply do the search every time.
> > 
> > Practically speaking, this is a nop except for situations where userspace
> > sets CPUID _after_ running the vCPU, which is anything but a hot path,
> > e.g. QEMU does so only when hotplugging a vCPU.  And on the flip side,
> > caching guest CPUID information, especially information that is used to
> > query/modify _other_ CPUID state, is inherently dangerous as it's all too
> > easy to use stale information, i.e. KVM should only cache CPUID state when
> > the performance and/or programming benefits justify it.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---

...

> > @@ -491,13 +479,6 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
> >  	 * whether the supplied CPUID data is equal to what's already set.
> >  	 */
> >  	if (kvm_vcpu_has_run(vcpu)) {
> > -		/*
> > -		 * Note, runtime CPUID updates may consume other CPUID-driven
> > -		 * vCPU state, e.g. KVM or Xen CPUID bases.  Updating runtime
> > -		 * state before full CPUID processing is functionally correct
> > -		 * only because any change in CPUID is disallowed, i.e. using
> > -		 * stale data is ok because KVM will reject the change.
> > -		 */
> Hi,
> 
> Any reason why this comment was removed?

Because after this patch, runtime CPUID updates no longer consume other vCPU
state that is derived from guest CPUID.

> As I said earlier in the review.  It might make sense to replace this comment
> with a comment reflecting on why we need to call kvm_update_cpuid_runtime,
> that is solely to allow old == new compare to succeed.

Ya, I'll figure out a location and patch to document why KVM applies runtime
and quirks to the CPUID before checking.

> 
> >  		kvm_update_cpuid_runtime(vcpu);
> >  		kvm_apply_cpuid_pv_features_quirk(vcpu);

