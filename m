Return-Path: <linux-kernel+bounces-359503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40504998C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D048E280E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100C1CDA3F;
	Thu, 10 Oct 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Te0gVPet"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDF1CDA35
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575666; cv=none; b=QboMohyjSMocpnJ21vqGnEfhW12Q8RFO19oGhe/nNAnzXGyk2kseB7kcSnRlsGKDKVcVdL/4WHZ4FgGykP0ibH8553obyKOgyKzTp2lWRCP/Tj8xi86I8TmllQqIcm4kXCIydF3oKVBB8SEXDIW8m9Byrz+vuEsyTDW8leKa4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575666; c=relaxed/simple;
	bh=exMIV8Nrlv5VDsW7LyILeqag4PrIbwaBSGqnuHxKDCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oMC0wZSpUJVBiCM0mIIPswR3Zsct4M6J7ormkrxzLa84BOJ9bhPSfTTZ7AXVdhNd7zyCEGBmWRQosVx6Pkl63TkabV71uNJY68mipzkmdDIh3kQG+OZ/sB36x4syiU2h43dGMu1zv1k6CC71bu/ne8/IS8rBMrdoBsulFyBZgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Te0gVPet; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e30fe2a9feso14044817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728575664; x=1729180464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sMwEF0t04Xf03z8JmTNU0su6EV0vlEJErGb+yyXXCE=;
        b=Te0gVPet9qAS4fshTWsr1ipo5NiATG0k2qjPQofocrdund1E03q5LLoQSdBDFsDL9s
         LtsVSmf7OhbTWSwdrWxjHIO/xanP0dcxhH45E51b8F57bWW6UyyoFFO81Iv2Jz+YBCvi
         7SpHhTUKzMwGVTeQKZvihuNroZZCdXqviY8PVNteMC5y9RLLN8XOQ9HSntwLK9KkSZL9
         H3ro0JwZgJ/GX/in8jcrUax9R7Ax//jtoz5JjYHMIrbYFDBDEe+J87n1/0MkkqGrWrTb
         wSJV9fLY/NBHY3gOr/EtsLQAAhc4nCZzUMTW+TOljPh+yz+Dc1MRGzL9SSj/06dCt1sX
         kVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575664; x=1729180464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sMwEF0t04Xf03z8JmTNU0su6EV0vlEJErGb+yyXXCE=;
        b=pZy73NluEMmb7+dozUbrGrBOMmhzgy2mp+jKau3DzzVb/7CPU7V8Nc/UgxauIiCa1n
         En6h/awaOTSZUbcOO5jA9uR00I6VsKYTUsMQ3O647T6AL0i82/W7qu/TVCM9hVCQitL4
         5KfsEmRzPK+gTkJHCuBhCdRQ5ObkBQ3A1izA3TumAIPtbAHhNEPADwhmvbJzTSJZuDcv
         tt2ZB2lM0EfYDmcgvlZ2QZPUQj+UoAcTUn0pqmmgCVkNm0nkJCcAn1btRNjzt3Vm/n10
         bEAvBbW0t8w4bTbZAomZrDd6g6QrjYpJNC1oGHlBleTvddl9JjVXAov6GIpvLOtahagA
         eI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6EMAGPCKOgIxQKLvryB4VPAaRZXSfqVAE3KJ2pLXLIeRfjoUVfKHjjcUzdgpwTKUqPgCMYpfxrU32EWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdwGgfYRJPSQaoBzP8RHmGqbO/ev4TMliDTa8pSsqmTty09N+
	eduUx9oKd9lX3Lnm6ynlCWMpVc916Ry4ed5Q4E4s8GoAnvk3xyUja1CZBOBZy4JPhMugbixKk+Q
	3XQ==
X-Google-Smtp-Source: AGHT+IFaTEQVvJEtWhp3ZxUl43YQFKv0vyHXzstBhIqqSy0TgE8/HNjhOVfOl877/xE21b5MkSaX03T1TNo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:ab51:0:b0:e28:fb8b:9155 with SMTP id
 3f1490d57ef6-e28fe41c747mr57834276.9.1728575663673; Thu, 10 Oct 2024 08:54:23
 -0700 (PDT)
Date: Thu, 10 Oct 2024 08:54:21 -0700
In-Reply-To: <cf2aabe2-7339-740a-6145-17e458302979@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009150455.1057573-1-seanjc@google.com> <20241009150455.1057573-2-seanjc@google.com>
 <cf2aabe2-7339-740a-6145-17e458302979@amd.com>
Message-ID: <Zwf4rfOFBlnMtdLQ@google.com>
Subject: Re: [PATCH 1/6] KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Michal Luczaj <mhal@rbox.co>, Alexander Potapenko <glider@google.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 10, 2024, Pankaj Gupta wrote:
> On 10/9/2024 5:04 PM, Sean Christopherson wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index db567d26f7b9..450dd0444a92 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -969,6 +969,15 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
> >   static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
> >   {
> >   	int num_vcpus = atomic_read(&kvm->online_vcpus);
> > +
> > +	/*
> > +	 * Explicitly verify the target vCPU is online, as the anti-speculation
> > +	 * logic only limits the CPU's ability to speculate, e.g. given a "bad"
> > +	 * index, clamping the index to 0 would return vCPU0, not NULL.
> > +	 */
> > +	if (i >= num_vcpus)
> > +		return NULL;
> 
> Would sev.c needs a NULL check for?
> 
> sev_migrate_from()
> ...
> src_vcpu = kvm_get_vcpu(src_kvm, i);
> src_svm = to_svm(src_vcpu);
> ...

Nope, sev_check_source_vcpus() verifies the source and destination have the same
number of online vCPUs before calling sev_migrate_from(), and it's all done with
both VMs locked.

static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
{
	struct kvm_vcpu *src_vcpu;
	unsigned long i;

	if (!sev_es_guest(src))
		return 0;

	if (atomic_read(&src->online_vcpus) != atomic_read(&dst->online_vcpus))
		return -EINVAL;

	kvm_for_each_vcpu(i, src_vcpu, src) {
		if (!src_vcpu->arch.guest_state_protected)
			return -EINVAL;
	}

	return 0;
}

