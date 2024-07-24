Return-Path: <linux-kernel+bounces-261358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531693B652
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D50C282A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368815F41F;
	Wed, 24 Jul 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqWyjj1d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D861FCA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843949; cv=none; b=CWsV1MoRsdECS7+05wXOx1m3UayOd9kAUXpTpKbCTt1CwPaSmXivovWg+BCQ/y3TAwU8H1df1dDWzFMvH5/seqh5lEQV6gLD5bd7Re4Ag1sSflccoLL1p10+DWWn8zf8a2KgRn5tsykzD3V2rXtiOBhF7rLTSRS6GDRiGm/RiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843949; c=relaxed/simple;
	bh=vToUSFfuBxFDwHHbmDpLt129lVI02pWGZoeP06wz/Ts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CC1PIMqyXagOGnXZJbTjRhpZ4mHTNRsApc1i5JeG18gk801E2DFJM/vQduv0m0+jbKZ7Met+ak8SgIxp3CCZvtLiXiAtyaZNtgpwfMhBBnFjRONW3oDx7qie3Y9Efgaa/PUbLiffi88jmB2UnstVNBkE4L1sjJ9PDFliR9SjM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqWyjj1d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721843946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrO4J8+RYRKw88kJ7TpCWAFl9RA8wwB8eC8PuzRLyzw=;
	b=WqWyjj1d9/sm3arvQENcmYGnoRt2ZdUJDaq5z3zsuMQcJeCW8+f5w5WX8N+Eu2pM/Vxu8r
	D/cwJRADWyr/IXe20TZr4HBmLx0xSFV4mdtY2h3uJhKyHUTQvg598RTkhu5iiJsK03aXkE
	vVYqx3b7IXIowpA88Khx5wNb5ji1xfY=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-0db7F-80NoqJOUudRrzMLw-1; Wed, 24 Jul 2024 13:59:04 -0400
X-MC-Unique: 0db7F-80NoqJOUudRrzMLw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4f5175725acso39266e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843943; x=1722448743;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrO4J8+RYRKw88kJ7TpCWAFl9RA8wwB8eC8PuzRLyzw=;
        b=vKYJUKcekkECZNQpzeoLNHnpG1FvRJtT5dgsx0M/IsU1AveTcOQWkqJAK/K+HBmfbB
         2lFCDKee67fkzl7c73P/Rc7rhW51gwirI1D55o/r9GE2WGU3Byo3xUy38v6RFlB+BD/M
         uxQ9IT3DlLN/oQgT+7ZWov1E/+psWYCJKgXoVJaf+yjoQJV7zgWmbAN6OgBhOvbR1iwJ
         IaBG8SGoCJVWsmA2J465cJ+2x6COdwS/HQME55wZMfdJ/9h1QS9PhuiF2IWXxAfLeNN9
         v1Kw/gPD9ub4hVBnLpEF/u3Rfjdigaq52/Uxd9o+G1yfxz9EHvWO5lbUWRmjF5UC+kRr
         QSig==
X-Forwarded-Encrypted: i=1; AJvYcCUOdU7jbk//kwlXilChIo8P5NMMjET8/4UYedGwwGrdFpUuTjPXYqOa+7gSnxCDQuBUzo6Q/kOwspmHp5hd6vY3IHlB5St+ln+LkGt3
X-Gm-Message-State: AOJu0YyS1lAxe/Hs2rQ5i4nwFaneQr6fJE4Z6g+/TJ3LZw7jHyNKlrKv
	p1h1NxIuHCMEKP5mM8tw28V9Qk1E0cnoqrQOUuUOptw7wovHzNH4QgDUwYAxWAhRGIPo9WMI8V6
	bCMl57DIi0bLPdh2oSCTpdPxbFBiLztMG3/1zxJrFCM4rs46DrnNxkTbOeQxo9nKYpAMpsQ==
X-Received: by 2002:a05:6122:2a13:b0:4ef:65b6:f3b5 with SMTP id 71dfb90a1353d-4f6c5c56b42mr708088e0c.10.1721843943519;
        Wed, 24 Jul 2024 10:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv2KFdtV00Z6o3UF9MC26wgwcqFFNRmS00b7jyX/7uEhsN3NmY4g0QuJUpa0SgnKPSCmbH1Q==
X-Received: by 2002:a05:6122:2a13:b0:4ef:65b6:f3b5 with SMTP id 71dfb90a1353d-4f6c5c56b42mr708069e0c.10.1721843943219;
        Wed, 24 Jul 2024 10:59:03 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdd4a6bsm55296631cf.97.2024.07.24.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:59:02 -0700 (PDT)
Message-ID: <f04b682df8f424184fc3b43ce7c8c319924b50d5.camel@redhat.com>
Subject: Re: [PATCH v2 29/49] KVM: x86: Remove unnecessary caching of KVM's
 PV CPUID base
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:59:01 -0400
In-Reply-To: <Zo2I3FChU58bX7qH@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-30-seanjc@google.com>
	 <5b747a9dacb0ead3d16c71192df8a61e8545d0e6.camel@redhat.com>
	 <Zo2I3FChU58bX7qH@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-09 at 12:00 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > Now that KVM only searches for KVM's PV CPUID base when userspace sets
> > > guest CPUID, drop the cache and simply do the search every time.
> > > 
> > > Practically speaking, this is a nop except for situations where userspace
> > > sets CPUID _after_ running the vCPU, which is anything but a hot path,
> > > e.g. QEMU does so only when hotplugging a vCPU.  And on the flip side,
> > > caching guest CPUID information, especially information that is used to
> > > query/modify _other_ CPUID state, is inherently dangerous as it's all too
> > > easy to use stale information, i.e. KVM should only cache CPUID state when
> > > the performance and/or programming benefits justify it.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> 
> ...
> 
> > > @@ -491,13 +479,6 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
> > >  	 * whether the supplied CPUID data is equal to what's already set.
> > >  	 */
> > >  	if (kvm_vcpu_has_run(vcpu)) {
> > > -		/*
> > > -		 * Note, runtime CPUID updates may consume other CPUID-driven
> > > -		 * vCPU state, e.g. KVM or Xen CPUID bases.  Updating runtime
> > > -		 * state before full CPUID processing is functionally correct
> > > -		 * only because any change in CPUID is disallowed, i.e. using
> > > -		 * stale data is ok because KVM will reject the change.
> > > -		 */
> > Hi,
> > 
> > Any reason why this comment was removed?
> 
> Because after this patch, runtime CPUID updates no longer consume other vCPU
> state that is derived from guest CPUID.
> 
> > As I said earlier in the review.  It might make sense to replace this comment
> > with a comment reflecting on why we need to call kvm_update_cpuid_runtime,
> > that is solely to allow old == new compare to succeed.
> 
> Ya, I'll figure out a location and patch to document why KVM applies runtime
> and quirks to the CPUID before checking.
> 
> > >  		kvm_update_cpuid_runtime(vcpu);
> > >  		kvm_apply_cpuid_pv_features_quirk(vcpu);


Makes sense, thanks!

Best regards,
	Maxim Levitsky



