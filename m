Return-Path: <linux-kernel+bounces-261334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9F093B5FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2886D1F24C02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866CF15EFCA;
	Wed, 24 Jul 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXrnQfAN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F341757E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842229; cv=none; b=K1zMOonHugOpgUcGhc/vqo1f9GqTckJbWqssNHbZDu2A6UXeZtKvF0ADNP85JBJc3/Uev0QCqQYr2t5E7yEwjPB4U4bypYvf2euYPRwP4QttItsACp73qH5DM6NL2QQbKUSsyjIfeD6LiR/kvFYw5V+9c45LueLAa3vJrblFgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842229; c=relaxed/simple;
	bh=tsPCi2L3qSxeelwjKZkBqG9a02Hi5u0iYpjphTj0ids=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBcfNL36Hv89b/39hb3k8YqRoL9zKEnxkNfeY/PArDTIyTddbuSkistRfmKtRcOm+79NYQXLi8e01qsKrFSndQMp/iMFYdkZyO6iQ4cSRuSm27FZnzuuMb9uOtTZwPaFAhIkpyGB7BuR2/zPNUkBiXB2qgjQ2Xd0rRnc2LjysYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXrnQfAN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721842226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMDCLFO3EloUla0zlTAIGGkjZf6G2W40HmQno6SR3TQ=;
	b=bXrnQfANToHiCqpTkl9/Vetjf6+SrCalv/SHtae8tr15UVxgYp6ZvFjiCF4+RwnXrOHLSL
	BITzY7XES7TSTQPf477uuIafQnX3aNIhsT7AqPCJJHIOeZQEct7aR85N6RIEaTy6Vb6qF3
	CzwC7yQMhm/l57t1cIKGA8VJX78IU4Q=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-HuDl5XW0PgeWH12Y3FivwQ-1; Wed, 24 Jul 2024 13:30:25 -0400
X-MC-Unique: HuDl5XW0PgeWH12Y3FivwQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4929e47ae28so5242137.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721842224; x=1722447024;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMDCLFO3EloUla0zlTAIGGkjZf6G2W40HmQno6SR3TQ=;
        b=SRrtVUokhirRAl+R4a+RRvFgHqrdg5dKIsAx1G6Wj3j4aR3zkoM6eazVn/vmd0ZNg7
         OgDFjBKI5L5r7zzj1GSf0q4sP89ybaU5oz18JkusMbfhUEjXrjF9NLAsj7BPCznermsp
         4d3oSxUQmmlvDN1abAW4slufSXLEHSPukmxez7YPpMQF7nh3QvuL5jo5YQghM8YlkgiJ
         7HnRCqHtWxclfwBuF2WqNdy4MHMg35lPXKQ7PlFd2+l2L9e0DpKlQeI/KVAFxXeaSSgI
         EgltCtsPCIeM0BncFsxhi5Hv9UvOBVl5NiNwgwohXCwmmRlKcvmmz4fOM0XaHxnSX6pe
         N2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV8cAQdsH9Rf8dgEtarAMwvGz76MtG/IQhQl9583MDDAG7Azl2ccw3kPWNot18pz8Mo2cfGG8mai8DIlrgLYpbPQPIbJlFcMA9XBaIF
X-Gm-Message-State: AOJu0YxLI6D1Hr3U+Eaf491ryVnTyK9h9pTAjOwzMzqYjnqD3Ky7DXIk
	QIrluj9VcqTMMyOI6vD+vXRCP3C3cWQXRghQKNH1i7uU6KzQfRzJra5bXp4KCaKmo0oHWRlvhuV
	GM4xuDtN1tFeng2vVWbjwEfWdHt1jSq/bFG8uD2yOEduPNHQl0bKosYPUNwg0jg==
X-Received: by 2002:a05:6102:3c88:b0:48f:c2dd:3520 with SMTP id ada2fe7eead31-493d6461976mr446983137.11.1721842224415;
        Wed, 24 Jul 2024 10:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcmZ7mYC4SkAnQ3ys5NfQquMWHnqJRbJ/cE9fSDgz+ltmTsyGj/NjhY3A8OWt5JJj/eXONHA==
X-Received: by 2002:a05:6102:3c88:b0:48f:c2dd:3520 with SMTP id ada2fe7eead31-493d6461976mr446907137.11.1721842224002;
        Wed, 24 Jul 2024 10:30:24 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d64194aasm3025485a.52.2024.07.24.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:30:23 -0700 (PDT)
Message-ID: <da3c92a68d3f60942f07dcf1a63b25e6bf3d3e6e.camel@redhat.com>
Subject: Re: [PATCH v2 10/49] KVM: x86: Drop now-redundant MAXPHYADDR and
 GPA rsvd bits from vCPU creation
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:30:22 -0400
In-Reply-To: <ZoxDqKdh37qpm-HQ@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-11-seanjc@google.com>
	 <ccbed564392478b3a5bb51b650a102ca474ba7e0.camel@redhat.com>
	 <ZoxDqKdh37qpm-HQ@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 12:53 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > > Drop the manual initialization of maxphyaddr and reserved_gpa_bits during
> > > vCPU creation now that kvm_arch_vcpu_create() unconditionally invokes
> > > kvm_vcpu_after_set_cpuid(), which handles all such CPUID caching.
> > > 
> > > None of the helpers between the existing code in kvm_arch_vcpu_create()
> > > and the call to kvm_vcpu_after_set_cpuid() consume maxphyaddr or
> > > reserved_gpa_bits (though auditing vmx_vcpu_create() and svm_vcpu_create()
> > > isn't exactly easy).  And even if that weren't the case, KVM _must_
> > > refresh any affected state during kvm_vcpu_after_set_cpuid(), e.g. to
> > > correctly handle KVM_SET_CPUID2.  In other words, this can't introduce a
> > > new bug, only expose an existing bug (of which there don't appear to be
> > > any).
> > 
> > IMHO the change is not as bulletproof as claimed:
> > 
> > If some code does access the uninitialized state (e.g vcpu->arch.maxphyaddr
> > which will be zero, I assume), in between these calls, then even though later
> > the correct CPUID will be set and should override the incorrect state set
> > earlier, the problem *is* that the mentioned code will have to deal with non
> > architecturally possible value (e.g maxphyaddr == 0) which might cause a bug
> > in it.
> > 
> > Of course such code currently doesn't exist, so it works but it can fail in
> > the future.
> 
> Similar to not consuming a null cpuid_entries, any such future bug should never
> escape developer testing since this is a very fixed sequence.  And practically
> speaking, completely closing these holes isn't feasible because it's impossible
> to initialize everything simultaneously, i.e. some amount of code will always
> need to execute with zero-initialized vCPU state.
> 
> > How about we move the call to kvm_vcpu_after_set_cpuid upward?
> 
> A drop-in replacement was my preference too, but it doesn't work.  :-/
> kvm_vcpu_after_set_cpuid() needs to be called after vcpu_load(), e.g. VMX's
> hook will do VMWRITE.
> 

Let it be then, but let's at least drop the part of the commit message after
'And even if that weren't the case', just not to confuse future reader,
because as I explained, this is not 100% bulletproof.

Best regards,
	Maxim Levitsky


