Return-Path: <linux-kernel+bounces-173887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05D8C073B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408F21C21385
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4713328D;
	Wed,  8 May 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtAdvgx/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86923133285
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206481; cv=none; b=ABFpKF88ifkXep/dOKtTFk6XMEIUgJCFqp7sRxGVkXCFlXhM3/B+N14gwarGfyT7+0yKDg7PwtZRowHqDU/Oq80/YC85jhzC8d7YnYoOdL3dg+9pAtbSvJzwhDcqfEHGFG3PbRwYaypsWFKZP1KOPf4iLq4Y8+Iy/BB5vzWJTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206481; c=relaxed/simple;
	bh=+Ao4yAI4mBjlM1cqgglOXt+RF11lFCvP7EpPBkwdEWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbKCccWLhqUBwQXp++dXteU/thzvR5FiCdYRMhpwtCIunB5+fp5wNUDwTndY8rTlTVVDv2yP7pQz2A0fbnOD+75WGhOb7vziMEmxjiOwMuUsQhcTE6GyF3rCwvFhSU6mmgjYbPFk+bQNcikamh23QfIcxKeywcR96QxEqynWeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtAdvgx/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715206478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3G13vP2j90cJ9q1iIJXsqeuLSqXZ2uwWRDCL6P8CGI=;
	b=UtAdvgx/8QfwJtZsTvX/xBbjLyT/lJP3y8zVksjMdMJ2BxD3+j20uazsFYymYoixvkFBZr
	axfca7cwjknxQDa7AmaO0rCXllbsjdG2B/Mb1K6aHp0Ry23Bxn0+uRtmalx9oku726dqgv
	eLHirCVOZj+Afbepvp3RTmVidii+gKE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-PLFNIiUgNUmE8-iG2GE1UQ-1; Wed, 08 May 2024 18:14:37 -0400
X-MC-Unique: PLFNIiUgNUmE8-iG2GE1UQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b265d41949so243002a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206476; x=1715811276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3G13vP2j90cJ9q1iIJXsqeuLSqXZ2uwWRDCL6P8CGI=;
        b=QS7NJBTtrCSUrKW66a7DrSMy2CQs/QrdUbsG7lhruPsjX/ylmm8HIs2jOBQOoOoSMi
         alEycSUTIZHmQ7h5Sany8Ks7u3Znl/tRuJWSMN4t6b6KRLt6qarDQqo1MBohi3RMD5y4
         yMvMEL0iRqLm9DEQk5L/h26354hBw3W9RjhVbor8lVw1reCGpIBst5WSeZy7pXgv7AgY
         6/K5f5SQoQ8jWbV6lE/W1NFkbvPcgvpB8ZzWUnGtieareU/qqMyX7eRDkSadTrRh8+vX
         7If7vhnB92s5RvcJwm9oBK6DNbdvpPGDHCfZn8KSqp0RjOyrNssw9sc913Dcju8v2M0+
         V3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNz2gadA/Fz7NBTmXNt89il7r3XPBnLcwgu3ceZsy2H/h2KgGX2PauaiHdALWMeajzvwi2zN6cvbVHjAt0/4eYz0ym6rdwIpYVnkLk
X-Gm-Message-State: AOJu0YyF9zoBgWh1SRYhmmtcJNfquN8GOAqAFoRqJnx30vpGJRKSIZNV
	Tisl6BjZ0c5rrtxXlkL3RuJ7rT9WTYa+8GNqV+dqUuG4DWfhCgkevj7c7ODyd7JJm09/OPGWrRg
	5GrhyF7OUvN5fp2Ee/sYP2t80mdFReE+wsNG7jX8yxf1T9CuU7Pzfnc9NkpEZIw==
X-Received: by 2002:a17:90b:212:b0:2b3:28be:df00 with SMTP id 98e67ed59e1d1-2b61649c518mr3754972a91.4.1715206476119;
        Wed, 08 May 2024 15:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqekJWhaOCFpDvgUHfEsURtD8vvaEirNcpayRV4i36jyg3fF3di+TgBruB/JIdNfVDBYiP1w==
X-Received: by 2002:a17:90b:212:b0:2b3:28be:df00 with SMTP id 98e67ed59e1d1-2b61649c518mr3754803a91.4.1715206469754;
        Wed, 08 May 2024 15:14:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6ae7sm1941595a91.51.2024.05.08.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:14:29 -0700 (PDT)
Date: Wed, 8 May 2024 16:14:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
 <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
 <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/5] x86/pat: Let pat_pfn_immune_to_uc_mtrr() check MTRR
 for untracked PAT range
Message-ID: <20240508161424.5bf4bdfc.alex.williamson@redhat.com>
In-Reply-To: <ZjnwiKcmdpDAjMQ5@yzhao56-desk.sh.intel.com>
References: <20240507061802.20184-1-yan.y.zhao@intel.com>
	<20240507061924.20251-1-yan.y.zhao@intel.com>
	<BN9PR11MB5276DA8F389AAE7237C7F48E8CE42@BN9PR11MB5276.namprd11.prod.outlook.com>
	<ZjnwiKcmdpDAjMQ5@yzhao56-desk.sh.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 17:12:40 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Tue, May 07, 2024 at 04:26:37PM +0800, Tian, Kevin wrote:
> > > From: Zhao, Yan Y <yan.y.zhao@intel.com>
> > > Sent: Tuesday, May 7, 2024 2:19 PM
> > > 
> > > However, lookup_memtype() defaults to returning WB for PFNs within the
> > > untracked PAT range, regardless of their actual MTRR type. This behavior
> > > could lead KVM to misclassify the PFN as non-MMIO, permitting cacheable
> > > guest access. Such access might result in MCE on certain platforms, (e.g.
> > > clflush on VGA range (0xA0000-0xBFFFF) triggers MCE on some platforms).  
> > 
> > the VGA range is not exposed to any guest today. So is it just trying to
> > fix a theoretical problem?  
> 
> Yes. Not sure if VGA range is allowed to be exposed to guest in future, given
> we have VFIO variant drivers.

include/uapi/linux/vfio.h:
        /*
         * Expose VGA regions defined for PCI base class 03, subclass 00.
         * This includes I/O port ranges 0x3b0 to 0x3bb and 0x3c0 to 0x3df
         * as well as the MMIO range 0xa0000 to 0xbffff.  Each implemented
         * range is found at it's identity mapped offset from the region
         * offset, for example 0x3b0 is region_info.offset + 0x3b0.  Areas
         * between described ranges are unimplemented.
         */
        VFIO_PCI_VGA_REGION_INDEX,

We don't currently support mmap for this region though, so I think we
still don't technically require this, but I guess an mmap through KVM
is theoretically possible.  Thanks,

Alex

> > > @@ -705,7 +705,17 @@ static enum page_cache_mode
> > > lookup_memtype(u64 paddr)
> > >   */
> > >  bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
> > >  {
> > > -	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
> > > +	u64 paddr = PFN_PHYS(pfn);
> > > +	enum page_cache_mode cm;
> > > +
> > > +	/*
> > > +	 * Check MTRR type for untracked pat range since lookup_memtype()
> > > always
> > > +	 * returns WB for this range.
> > > +	 */
> > > +	if (x86_platform.is_untracked_pat_range(paddr, paddr + PAGE_SIZE))
> > > +		cm = pat_x_mtrr_type(paddr, paddr + PAGE_SIZE,
> > > _PAGE_CACHE_MODE_WB);  
> > 
> > doing so violates the name of this function. The PAT of the untracked
> > range is still WB and not immune to UC MTRR.  
> Right.
> Do you think we can rename this function to something like
> pfn_of_uncachable_effective_memory_type() and make it work under !pat_enabled()
> too?
> 
> >   
> > > +	else
> > > +		cm = lookup_memtype(paddr);
> > > 
> > >  	return cm == _PAGE_CACHE_MODE_UC ||
> > >  	       cm == _PAGE_CACHE_MODE_UC_MINUS ||  
> >   
> 


