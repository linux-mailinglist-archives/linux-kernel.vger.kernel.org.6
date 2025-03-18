Return-Path: <linux-kernel+bounces-566843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC4A67D36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF3174D26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8051DFDAE;
	Tue, 18 Mar 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oep+1Plb"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6131531E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326877; cv=none; b=ajRvApgKHxvQbzjMSdyO0gLZek/j/UVo/OheU/NiIM+569FnJowgI7TtSh4I6sDXAMzXzAcPHwXqCje9I2cNFChcNWUIQTL2fGArgqmGwFGVJQp8FghdQePB4LqWldmSFacZANHwItsRe8yQ/jovrB1aZmCPeW719Xz4FqI9IvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326877; c=relaxed/simple;
	bh=f4Mr63e+dKxBw1z8KqZhkkxKdMBKYbH8GdlLwzoJ3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jReephAd57f6iOAd1zwhf7a8+f4w+/Vb6n0Cj2ZoYOMAVEF/vSISOYvqjE/ZDgyPHsnHzi8GRd9sQ2iwb4AyzK4Qd1VY6MTcUcUODdEDpV7JnHYFXitOyGp1pqLghOyb2gn9L+pEz3IZlXtrvCj16uPNUzYV/nJYx+iSQTJ+XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oep+1Plb; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 12:40:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742326862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NR2Dj2DPN3F/JuAMDyd3/Po1SaaWRiipA/wuwjQg+vI=;
	b=oep+1Plbv4PtXj/KFEU6POj20mcYFIxJC6aM2OoJMVG1c6i5Yyu1rzfpAFzF3pNTvSUTAu
	gpmVeRqi7AJI/nltKtsdsFJzz6qmTGXNp+pfXcSZ3RAyDfWCYk73LSTb3/GZcykFXtMj/9
	EgjkBH4IyswSiu8r/u4oGO6AYN5ujXA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"shahuang@redhat.com" <shahuang@redhat.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	Uday Dhoke <udhoke@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"sebastianene@google.com" <sebastianene@google.com>,
	"coltonlewis@google.com" <coltonlewis@google.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"gshan@redhat.com" <gshan@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"tabba@google.com" <tabba@google.com>,
	"qperret@google.com" <qperret@google.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/1] KVM: arm64: Allow cacheable stage 2 mapping using
 VMA flags
Message-ID: <Z9nMHW-OqTLEqDRs@linux.dev>
References: <86r033olwv.wl-maz@kernel.org>
 <SA1PR12MB7199500A3683B15A64B663D6B0D12@SA1PR12MB7199.namprd12.prod.outlook.com>
 <87tt7y7j6r.wl-maz@kernel.org>
 <SA1PR12MB7199B320DAE42A8D7038A78EB0D32@SA1PR12MB7199.namprd12.prod.outlook.com>
 <8634fcnh0n.wl-maz@kernel.org>
 <Z9h98RhunemcFhhz@arm.com>
 <86wmcmn0dp.wl-maz@kernel.org>
 <20250318125527.GP9311@nvidia.com>
 <Z9nJH38Em9XEx3U7@arm.com>
 <ed25f5a6-dad6-4b5e-b42b-58e6ced6c7a2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed25f5a6-dad6-4b5e-b42b-58e6ced6c7a2@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 08:35:38PM +0100, David Hildenbrand wrote:
> On 18.03.25 20:27, Catalin Marinas wrote:
> > On Tue, Mar 18, 2025 at 09:55:27AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Mar 18, 2025 at 09:39:30AM +0000, Marc Zyngier wrote:
> > > > The memslot must also be created with a new flag ((2c) in the taxonomy
> > > > above) that carries the "Please map VM_PFNMAP VMAs as cacheable". This
> > > > flag is only allowed if (1) is valid.
> > > > 
> > > > This results in the following behaviours:
> > > > 
> > > > - If the VMM creates the memslot with the cacheable attribute without
> > > >    (1) being advertised, we fail.
> > > > 
> > > > - If the VMM creates the memslot without the cacheable attribute, we
> > > >    map as NC, as it is today.
> > > 
> > > Is that OK though?
> > > 
> > > Now we have the MM page tables mapping this memory as cachable but KVM
> > > and the guest is accessing it as non-cached.
> > 
> > I don't think we should allow this.
> > 
> > > I thought ARM tried hard to avoid creating such mismatches? This is
> > > why the pgprot flags were used to drive this, not an opt-in flag. To
> > > prevent userspace from forcing a mismatch.
> > 
> > We have the vma->vm_page_prot when the memslot is added, so we could use
> > this instead of additional KVM flags.
> 
> I thought we try to avoid messing with the VMA when adding memslots; because
> KVM_CAP_SYNC_MMU allows user space for changing the VMAs afterwards without
> changing the memslot?

Any checks on the VMA at memslot creation is done out of courtesy to
userspace so it 'fails fast'. We repeat checks on the VMA at the time of
fault to handle userspace twiddling VMAs behind our back.

VM_MTE_ALLOWED is an example of this.

Thanks,
Oliver

