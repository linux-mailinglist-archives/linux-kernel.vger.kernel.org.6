Return-Path: <linux-kernel+bounces-382131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0259B09DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C834A282DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C1188580;
	Fri, 25 Oct 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOGdQdRn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDB186298
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873500; cv=none; b=WHB+lcORt1+e6k67etPXllotq9ZtL33GGAWKhiePnQJNmca3Bm0JJlf3/FW8rEJVwjx+veC6aDSHm4/FvGlVxl2al1dOvjNQLoPP9EYWlUTBiM77Bne5qOVOJvi3JELHNmHulUIWWtAb8eod3isDq7KZyW4+sVPHEUsDoz1swDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873500; c=relaxed/simple;
	bh=XgDCe2FzCv3NjECyDVpu5cUfCR7Pkr1wv3DWyvlb9UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5O6Zs9A6x2LU5i+rdalhlqB5/0GStpKgd53Y9WbcXNSyMU5M9PK2T7wyM28qThzuuq08VGaR8RWFgfvRP0GD9QHpx+RaFwtn/fcQZPgeLhGR8QpO9IuRFzpwtEphG2B2fWKxOSF8MrzWznXbYdETXO3+UXp/2eGWbyzb/dS4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOGdQdRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729873497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMJwOiLeyrbvYc47fai8JP23knQFGL00VF9LXPmJglc=;
	b=HOGdQdRnfbqoC9ZAbSvrBF47rXiUFjQZmYIeqG0YAjhluZj/pblW1AGim+W9uxBoOT92lL
	MGiYw3FCqyIWBGsX7FWmn0k2BZ+aZaB0jX7m3Ykf+jbKHI1DE9/1VH2Jc2RcEJCMv+qHRU
	mWLDR6qQn1oelq5L/3istKaUsPqWkc8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-vbHhY91bMhWV3JC-5e1qlQ-1; Fri,
 25 Oct 2024 12:24:51 -0400
X-MC-Unique: vbHhY91bMhWV3JC-5e1qlQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FA3A1955EE6;
	Fri, 25 Oct 2024 16:24:49 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA26619560A2;
	Fri, 25 Oct 2024 16:24:48 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 77854400DFC88; Fri, 25 Oct 2024 13:24:29 -0300 (-03)
Date: Fri, 25 Oct 2024 13:24:29 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org,
	pbonzini@redhat.com, Sean Christopherson <seanjc@google.com>,
	chao.gao@intel.com, rick.p.edgecombe@intel.com,
	yan.y.zhao@intel.com, linux-kernel@vger.kernel.org,
	isaku.yamahata@gmail.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 0/2] KVM: kvm-coco-queue: Support protected TSC
Message-ID: <ZxvGPZDQmqmoT0Sj@tpad>
References: <cover.1728719037.git.isaku.yamahata@intel.com>
 <c4df36dc-9924-e166-ec8b-ee48e4f6833e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4df36dc-9924-e166-ec8b-ee48e4f6833e@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 14, 2024 at 08:17:19PM +0530, Nikunj A. Dadhania wrote:
> Hi Isaku,
> 
> On 10/12/2024 1:25 PM, Isaku Yamahata wrote:
> > This patch series is for the kvm-coco-queue branch.  The change for TDX KVM is
> > included at the last.  The test is done by create TDX vCPU and run, get TSC
> > offset via vCPU device attributes and compare it with the TDX TSC OFFSET
> > metadata.  Because the test requires the TDX KVM and TDX KVM kselftests, don't
> > include it in this patch series.
> > 
> > 
> > Background
> > ----------
> > X86 confidential computing technology defines protected guest TSC so that the
> > VMM can't change the TSC offset/multiplier once vCPU is initialized and the
> > guest can trust TSC.  The SEV-SNP defines Secure TSC as optional.  TDX mandates
> > it.  The TDX module determines the TSC offset/multiplier.  The VMM has to
> > retrieve them.
> > 
> > On the other hand, the x86 KVM common logic tries to guess or adjust the TSC
> > offset/multiplier for better guest TSC and TSC interrupt latency at KVM vCPU
> > creation (kvm_arch_vcpu_postcreate()), vCPU migration over pCPU
> > (kvm_arch_vcpu_load()), vCPU TSC device attributes (kvm_arch_tsc_set_attr()) and
> > guest/host writing to TSC or TSC adjust MSR (kvm_set_msr_common()).
> > 
> > 
> > Problem
> > -------
> > The current x86 KVM implementation conflicts with protected TSC because the
> > VMM can't change the TSC offset/multiplier.  Disable or ignore the KVM
> > logic to change/adjust the TSC offset/multiplier somehow.
> > 
> > Because KVM emulates the TSC timer or the TSC deadline timer with the TSC
> > offset/multiplier, the TSC timer interrupts are injected to the guest at the
> > wrong time if the KVM TSC offset is different from what the TDX module
> > determined.
> > 
> > Originally the issue was found by cyclic test of rt-test [1] as the latency in
> > TDX case is worse than VMX value + TDX SEAMCALL overhead.  It turned out that
> > the KVM TSC offset is different from what the TDX module determines.
> 
> Can you provide what is the exact command line to reproduce this problem ? 

Nikunj,

Run cyclictest, on an isolated CPU, in a VM. For the maximum latency
metric, rather than 50us, one gets 500us at times.

> Any links to this reported issue ?

This was not posted publically. But its not hard to reproduce.

> > Solution
> > --------
> > The solution is to keep the KVM TSC offset/multiplier the same as the value of
> > the TDX module somehow.  Possible solutions are as follows.
> > - Skip the logic
> >   Ignore (or don't call related functions) the request to change the TSC
> >   offset/multiplier.
> >   Pros
> >   - Logically clean.  This is similar to the guest_protected case.
> >   Cons
> >   - Needs to identify the call sites.
> > 
> > - Revert the change at the hooks after TSC adjustment
> >   x86 KVM defines the vendor hooks when the TSC offset/multiplier are
> >   changed.  The callback can revert the change.
> >   Pros
> >   - We don't need to care about the logic to change the TSC offset/multiplier.
> >   Cons:
> >   - Hacky to revert the KVM x86 common code logic.
> > 
> > Choose the first one.  With this patch series, SEV-SNP secure TSC can be
> > supported.
> 
> I am not sure how will this help SNP Secure TSC, as the GUEST_TSC_OFFSET and 
> GUEST_TSC_SCALE are only available to the guest.

Nikunj,

FYI:

SEV-SNP processors (at least the one below) do not seem affected by this problem.

At least this one:

vendor_id	: AuthenticAMD
cpu family	: 25
model		: 17
model name	: AMD EPYC 9124 16-Core Processor


