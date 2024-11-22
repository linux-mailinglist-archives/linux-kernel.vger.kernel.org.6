Return-Path: <linux-kernel+bounces-417738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A29D5895
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDD9B228C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB4159583;
	Fri, 22 Nov 2024 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErlnXMI3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949F4D8A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246474; cv=none; b=H/nFn/ne0lZcSgShjxLW+5ITIGP7YqlYCMnFmfy897Ul4os0Vs/zBTFCl9KgdbmdWpXuo8OBkm5aPeYm0PLtEwsOwhTTpFvz53Q9+zjsiSmX6oMYAVcNw5gacUr6cZ2ZB+I83bZ17w2KHn+MC3UQAxLVISAS9QgSB2v0A83ZlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246474; c=relaxed/simple;
	bh=9kkSHX5C/Rzcba5jDJqEPRSjF0ZyIB/tw8lBGgd3K04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRySQ8PMH4mLVvwPaMj1QWLWHWLALYt9H1lfqS/IlUYuFB5XT23XZlwLo7KoeK2Xb9WFI+SuJN4oYfStfAA6WJrSKEmja24rf4PFPMEcTjLbndgIyF7QWxAFNn2AQsxeQTPBmLgWh+UzUOtu+TdpP7JowxRoTtG0/Z1xG5z6ppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErlnXMI3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732246472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5owPybl2A6mPLtXeb0GF8SzCVpIuIgw+HHvE5+2/5T0=;
	b=ErlnXMI39LEHHWPRlh3+6JgkMT8jF6XezjhG4+EvlDDHwIlLLpK0bQ8m3hlofbAeiGwtvt
	sZHc6zk+i4wjmgcUBJ6m84T1BMiEeOd8pguhjRK22AGqhG648xBipepFXCNE+VvvlotqI3
	xjYO2QsAX977c5z8HiQjMGqYbyO0bG4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-u2WqMItwPqSqxlfVf7FB8Q-1; Thu, 21 Nov 2024 22:34:29 -0500
X-MC-Unique: u2WqMItwPqSqxlfVf7FB8Q-1
X-Mimecast-MFC-AGG-ID: u2WqMItwPqSqxlfVf7FB8Q
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b1473a4640so254292585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732246469; x=1732851269;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5owPybl2A6mPLtXeb0GF8SzCVpIuIgw+HHvE5+2/5T0=;
        b=YE2MA/f2JLnLeiHumdNisRcrxkH1vE8q0tz1ukV0oUmvywJhMAIsMfKNXqDUFQ2fom
         OMTdBTsUBDSRORGDjEuQrcL67D1KCvtY/Caw8aFw1HPpbL2tPAICKPkdy5TYQjBl7nsc
         cX9keKH0YI87Hzmm0v3F/u/K7ExGhxZJTjMaSsPDRkmVzZc5f/xNy6oMagDXVKv7SnaX
         62Oos0kmrikoHvsrl+zUNmtfPu1rh1Rj3YXipj1zB1jTwrEYXflgGVhJaY+7h0WI1AFh
         4E/7RYfNw0bqsjFem8LmdRwL96VlIVfZpm1szOmVkx9CGRp3s9t21nKvbxoGZDkIXeyX
         HsLw==
X-Forwarded-Encrypted: i=1; AJvYcCXSFsJqaqjfHJZ+rICdM8GfH3C4XBJhnmjPkZvLi1ZRBSH/GyT6uNXqYHqmPxGzQSCeEGqdC/71ag1VkHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VhPAjZkySj2v5UKMWQxZ2BdmfnRdHbDWSJ98pQj/aXsASsUi
	eazN1VSRzO5fAe0e9VEZUa8KA5Fk1Sf7pMeIXmACks/VnS7zttIspPpTAzEa4TafGXKrItrleXn
	UDDORVWXfwBDv0PGgpC/N/LYaclmvVr0SqL/+9g6JzU9E/09QiNpII2uk7nRSmA==
X-Gm-Gg: ASbGncv2XR10wgHkHo9viSUXSX6O/KIpa6QbFcn9RoVWK4IaVXBNOy8Xp9u5GXJ8Z4H
	Q+a1YJPDd52Tm4JPmrfe5+H1GjEfRw3QINHciYpCtsyMVLDyEJRJGHpi3nn/4MTALC2zOibouBv
	Y70LJLfcPtTynwr1bcs2a0GLmLtoGvT5tzlswSs+TBRzabqcATA9oWsWzdkD6XrAHTK0tQkvET1
	/8ENWo2CSYxRscEFHAIj1BjMAbouFVJNBBMpAdf/eM4Xu/p1w==
X-Received: by 2002:a05:620a:601c:b0:7b1:21c9:d1ad with SMTP id af79cd13be357-7b50c1bbea5mr922167885a.23.1732246469281;
        Thu, 21 Nov 2024 19:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF40kkpOkNoCUj7UXHDVNMT6f685l0ht7e59S+qcPkVWqYBRtbkkFc+AKlw7dYgnr5xBZD8Ig==
X-Received: by 2002:a05:620a:601c:b0:7b1:21c9:d1ad with SMTP id af79cd13be357-7b50c1bbea5mr922166285a.23.1732246468905;
        Thu, 21 Nov 2024 19:34:28 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a837bbsm4922046d6.23.2024.11.21.19.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:34:28 -0800 (PST)
Message-ID: <8d7e0d0391df4efc7cb28557297eb2ec9904f1e5.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>,  "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>,  Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Nov 2024 22:34:27 -0500
In-Reply-To: <Zxf2ZK7HS7jL7TQk@google.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
	 <ZRsYNnYEEaY1gMo5@google.com>
	 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
	 <Zxb4D_JCC-L7OQDT@google.com> <Zxf2ZK7HS7jL7TQk@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-10-22 at 12:00 -0700, Sean Christopherson wrote:
> On Mon, Oct 21, 2024, Sean Christopherson wrote:
> > On Wed, Oct 04, 2023, Maxim Levitsky wrote:
> > > About the added 'vcpu->loaded' variable, I added it also because it is
> > > something that is long overdue to be added, I remember that in IPIv code
> > > there was also a need for this, and probalby more places in KVM can be
> > > refactored to take advantage of it, instead of various hacks.
> > 
> > I don't view using the information from the Physical ID table as a hack.  It very
> > explicitly uses the ir_list_lock to ensure that the pCPU that's programmed into
> > the IRTE is the pCPU on which the vCPU is loaded, and provides rather strict
> > ordering between task migration and device assignment.  It's not a super hot path,
> > so I don't think lockless programming is justified.

If you strongly prefer this I won't argue. KVM does read back its SPTE entries,
which is also something I can't say that I like that much.

> > 
> > I also think we should keep IsRunning=1 when the vCPU is unloaded.  That approach
> > won't run afoul of your concern with signaling the wrong pCPU, because KVM can
> > still keep the ID up-to-date, e.g. if the task is migrated when a pCPU is being
> > offlined.
> > 
> > The motiviation for keeping IsRunning=1 is to avoid unnecessary VM-Exits and GA
> > log IRQs.  E.g. if a vCPU exits to userspace, there's zero reason to force IPI
> > senders to exit, because KVM can't/won't notify userspace, and the pending virtual
> > interrupt will be processed on the next VMRUN.
> 
> My only hesitation to keeping IsRunning=1 is that there could, in theory, be a
> noisy neighbor problem.  E.g. if there is meaningful overhead when the CPU responds
> to the doorbell. 

I once measured this by bombarding a regular CPU, which is not running any guests,
with AVIC doorbells. It was like 60% reduction of its performance if I remember correctly.

So physical id table entries of a VM can't point to a CPU which doesn't run the VM's vCPU thread, because
only in this case this doesn't pose a DOS risk.

Same with IOMMU (malicious guest can in theory make an assigned device generate an interrupt
storm, and then this storm can get redirected to a doorbell of a CPU which doesn't belong to a VM).


Best regards,
	Maxim Levitsky



>  Hrm, and if another vCPU is scheduled in on the same pCPU, that
> vCPU could end up processing a virtual interrupt in response to a doorbell intended
> for a different vCPU.
> 
> The counter-argument to both concerns is that APICv Posted Interrupts have had a
> _worse_ version of that behavior for years, and no one has complained.  KVM sets
> PID.SN only when a vCPU is _preempted_, and so devices (and now virtual IPIs) will
> send notification IRQs to pCPUs that aren't actively running the vCPU, or are
> running a different vCPU.
> 
> The counter-counter-argument is that (a) IPI virtualization is a recent addition,
> and device posted interrupts are unlikely to be used in a CPU oversubscribed setup,
> and (b) Posted Interrupts are effectively rate-limited to a single "spurious"
> notification per vCPU, as notification IRQs are sent if and only if PID.ON=0.
> 
> That said, while I'm somewhat less confident that keeping IsRunning=1 is desirable
> for all use cases than I was yesterday, I still think we should avoid tightly
> coupling it to whether or not the vCPU is loaded, because there are undoubtedly
> setups where it _is_ desirable, e.g. if vCPUs are pinned 1:1 to pCPUs.
> 



