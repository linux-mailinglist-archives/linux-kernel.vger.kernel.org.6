Return-Path: <linux-kernel+bounces-181148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841AF8C783C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A232282C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C5714884E;
	Thu, 16 May 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yba0bHa5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055E1487F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868427; cv=none; b=YKDBNtOKvfZM73kQYAt6QDdjRW75zS0AvH+iV1aOgvjErSmx6vjmFAgGysq6AYC/UrwUrMxIIqRnHAtvlbNO5J5saConioCVRS2+5yrI2wyLuzz95RUl7IEgvAcq+GNXjqjymYVbrxWM7WaK0sQpqT7prlK2t+aGJ/79SJOEvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868427; c=relaxed/simple;
	bh=tWr3SDz/keT0AUPlOI26qivjzXaj1FzjL66/DGqh04E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHSkbw8Mv6tWy27SXVjROawPuyHEk9MXgl84Iu2ei06cfJYJC70qxyTrCvtgFtOYmmUM828+HWDbQRFWaGxAnBljgpkBZocOR2FFzT5xmg+xTx3q6V5X3QcZZj+CtoL80yDacIUeuBRNRPr/86+gJtu2akeokpU19HNRTkfctts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yba0bHa5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso12123994276.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715868425; x=1716473225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgdQVmJ7EdgxAUQ+Mn5lPrLPnO4lZEwTEM15imrbXrA=;
        b=yba0bHa5am5fP5V616/M+WbhxwcDMo+NtPMCOrVpRyrspilC/XFfDk4xBrZvLGsWd+
         fsxpgKIcffW6Gt3Eo52MpCteadFDr7YZ3Q7sZqCpw4sUc605ou7ETGWTxMSoIAP1AslZ
         FvB+OlrpSnE5PkXRhtEqTa5ainnu7RCqjXxVI+2ncqAd+N8utOOPk+90WBqpE9rK7hYs
         yxdZ4tG/qSTcYOU6n7qe7X+B9q/ew69wpqg9Q2yq2LJsYdgy+ImoyqBWayGqN2pLUu60
         pZfjHeZk3b9xVolnkRdvc2wDlkB62L2wXXPtnDxJhX2PAfw7YfCG3POePFGjKaNhVNqp
         z41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868425; x=1716473225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgdQVmJ7EdgxAUQ+Mn5lPrLPnO4lZEwTEM15imrbXrA=;
        b=u4lX/g6bqT2CbdE5KP/ui146VS7XAPrslhBCC7Vp9e+4Nbre1LPo2RiVkwmBhVwsj7
         2NEgF2wX6+nkI7yJ0u9vWXVT6oJsEbMt60qOGXYOwqZHQXDqO5RTg1S3b89w6o+x7D2c
         3bjcECMtzU8ZynA4xBkTFOOko1gHlg0B1v7gP6rMm2I7xNpKSdEqLV81Kv0CfiyLFRPC
         pw3X1jmj2IKz9YsEEw8rjwVIt49yqUsfWOXHnBZ55637w+BAn3XBaQ0HimcAlKVpCRgG
         Le1nCKp/Ey6ed6kbPtD21SbBb830wSnQj9DdyCG6OwsfhPYgvzbB0nxnDMAKADbqWQud
         Bf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWfT5omDIqKjDbV0OvN6YMM2fTIRTJWByXFx1xhGsMe2aNSzJKOvQe0KDx6xVmCZCMNvtTVqOgmfrg6LJCZLyS17zCFm3mlofn4JqK
X-Gm-Message-State: AOJu0YwHhqq9T7VUZ0ApLFMG7BIOlcGH0lzYAn9Svl5hD5sN92vPbSLv
	GjPvVRn9lXloMKJFnaxJmCe1G66JNQ9m+2E9285K2pFN3RZBrzxmBKkcQ+vvcZEGBRm4L8aaAzO
	fCQ==
X-Google-Smtp-Source: AGHT+IEDBtrDbkovNrhAV/lyqKo9e3I9oLyUsaLll6pFh8+GoJQSddiJzF1Cv5ysvpR9u6J0VFHg196pMTA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1025:b0:de5:3003:4b83 with SMTP id
 3f1490d57ef6-dee4f4fbce6mr1659030276.8.1715868424907; Thu, 16 May 2024
 07:07:04 -0700 (PDT)
Date: Thu, 16 May 2024 07:07:03 -0700
In-Reply-To: <BN9PR11MB527614E72C1DF467FF3F4C948CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507061802.20184-1-yan.y.zhao@intel.com> <20240507061924.20251-1-yan.y.zhao@intel.com>
 <BN9PR11MB5276DA8F389AAE7237C7F48E8CE42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZjnwiKcmdpDAjMQ5@yzhao56-desk.sh.intel.com> <BN9PR11MB527614E72C1DF467FF3F4C948CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <ZkYTByuHu_IptChR@google.com>
Subject: Re: [PATCH 1/5] x86/pat: Let pat_pfn_immune_to_uc_mtrr() check MTRR
 for untracked PAT range
From: Sean Christopherson <seanjc@google.com>
To: Kevin Tian <kevin.tian@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, Yi L Liu <yi.l.liu@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

+Tom

On Thu, May 16, 2024, Kevin Tian wrote:
> > From: Zhao, Yan Y <yan.y.zhao@intel.com>
> > Sent: Tuesday, May 7, 2024 5:13 PM
> > 
> > On Tue, May 07, 2024 at 04:26:37PM +0800, Tian, Kevin wrote:
> > > > From: Zhao, Yan Y <yan.y.zhao@intel.com>
> > > > Sent: Tuesday, May 7, 2024 2:19 PM
> > > >
> > > > @@ -705,7 +705,17 @@ static enum page_cache_mode
> > > > lookup_memtype(u64 paddr)
> > > >   */
> > > >  bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
> > > >  {
> > > > -	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
> > > > +	u64 paddr = PFN_PHYS(pfn);
> > > > +	enum page_cache_mode cm;
> > > > +
> > > > +	/*
> > > > +	 * Check MTRR type for untracked pat range since lookup_memtype()
> > > > always
> > > > +	 * returns WB for this range.
> > > > +	 */
> > > > +	if (x86_platform.is_untracked_pat_range(paddr, paddr + PAGE_SIZE))
> > > > +		cm = pat_x_mtrr_type(paddr, paddr + PAGE_SIZE,
> > > > _PAGE_CACHE_MODE_WB);
> > >
> > > doing so violates the name of this function. The PAT of the untracked
> > > range is still WB and not immune to UC MTRR.
> > Right.
> > Do you think we can rename this function to something like
> > pfn_of_uncachable_effective_memory_type() and make it work under
> > !pat_enabled() too?
> 
> let's hear from x86/kvm maintainers for their opinions.
> 
> My gut-feeling is that kvm_is_mmio_pfn() might be moved into the
> x86 core as the logic there has nothing specific to kvm itself. Also
> naming-wise it doesn't really matter whether the pfn is mmio. The
> real point is to find the uncacheble memtype in the primary mmu
> and then follow it in KVM.

Yeaaaah, we've got an existing problem there.  When AMD's SME is enabled, KVM
uses kvm_is_mmio_pfn() to determine whether or not to map memory into the guest
as encrypted or plain text.  I.e. KVM really does try to use this helper to
detect MMIO vs. RAM.  I highly doubt that actually works in all setups.

For SME, it seems like the best approach would be grab the C-Bit from the host
page tables, similar to how KVM uses host_pfn_mapping_level().

SME aside, I don't have objection to moving kvm_is_mmio_pfn() out of KVM.

> from that point probably a pfn_memtype_uncacheable() reads clearer.

or even just pfn_is_memtype_uc()?

