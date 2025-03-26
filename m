Return-Path: <linux-kernel+bounces-577175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06430A7197D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279C93A79EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C31F1510;
	Wed, 26 Mar 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUaYagLk"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D431DEFD7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000817; cv=none; b=NNmhVnX/Dw7Z2ybZRZn7puSKcf9v3ZuE37mKF/uWrqN2hNJ0C6AC8gaXzD2JXg4XF239CGLk8HzVJN6HmuNbBsWo1WfhSu5A2kANRCL5SQ7VkS474BufIXNMjh74CfuZToTaosKfHkByCx2r7LdNGos4QD+Rdy7drdVNfAgj6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000817; c=relaxed/simple;
	bh=HvlnRUVHhJnFXEc8z9OLK1Cby9u8FTnqQldgxhUGyh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdhjwPfSaIqCmqF+EDa31uRjrLSarhoDxVnIbPxiBEw1MI3pM1vqg8uva7w9M0bG3DdZhHoeUfJvZG2euSyQ07QeiGPnYADV8vxa40mQRFJNF/LBwHElzN+uec33KucjqAzvEGQUs1bT/OkS8DNc0LbGnN8RlpUlutMoAk0FfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUaYagLk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso12129962a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743000815; x=1743605615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYuz+zY+9MTDf5KTG6gl5ifz+I238+i6zAPOdCI3LyY=;
        b=FUaYagLk+yM1CbXdfpBF7UI/0DTGpP1oi44qalFq5nAbrcoV7SfdbR52Ziz9ld/ljz
         28SZrtK1WwaVSe97+Nz+5ZGtMtcmZApytaFf5loqFfSFfWLnS4pUldeHyxFlDDdaFVuW
         SZ0fzx4HmSkH3Qi/aQGqdb37v6BmquSyWQ/cm2VMnbO5a5LordwEsPpMnoVXWWmIZmkp
         vHOErALjW7PJb0WmsXBD16LEAWqnKZ93HZibyui2bzQNIwUPauqnNqROM/Xu6f8ElUiH
         UqKSernSgyUhUAnpNI3okI6zFqUDlHVydz8oNNmmwpLvLAYVPxKMUdJk0WeBPh/Fjkfr
         VrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000815; x=1743605615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYuz+zY+9MTDf5KTG6gl5ifz+I238+i6zAPOdCI3LyY=;
        b=G6Y6ieVqTP3cj7snZFQueTAFsx/+FOI7BiCSkgVKdFMRtJmMvgAwj2r79Qm3/TtCOX
         6OCb0uYwXgXffUQVbwgk0GIHL9NhBMV9+zR3x9VSR7TCKg8xVkcYzZoHE+x6LOoPxlvt
         Fkd4RhI1xPYhwmW8Mfyi5BwSW221OovCuv8ZBeBNRs1xuowAsu9gUVHvxpbiWUIuP4EA
         fC/JeDNSWczrNHvf+PsFLWhu5UzmblvJ0C46x/HMZYEM2zZjiuZzg8POtjJNBARrqjBL
         tFizd3d72jr5pJXxUHivGnfrZUlyVPMoETWLM9wszHyLkKpa9vvwD5LnkpCOZdrMzrd7
         u52g==
X-Forwarded-Encrypted: i=1; AJvYcCX9J2Ti88GeSM/6acrHoBoodc53uPVpluo9UZ3cpNqcvyRmIXl4jrVXHIaLMOZKSduAQSqapO+1RIbd+2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8JEqGe0F9PdxDrbApI8gOnRscWvHR5XfLsufQBkVw8x0dkLK5
	Yi3VqpW5jfoj3CNyxx+Be4nFkQScFi/xsre+/paN2AIe3msukpe7TBEQi5jrx4UfQEHAbmmt0fr
	hLg==
X-Google-Smtp-Source: AGHT+IHVU+TN9kjlCemo9tNjMiVG/tGpBwU7pEuQb4ZMMbfYRfUmUXxSOBuTHhWOXzajakxNTBbnItO9Nyg=
X-Received: from pfblk16.prod.google.com ([2002:a05:6a00:7210:b0:736:47b8:9b88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1885:b0:736:362a:6fc8
 with SMTP id d2e1a72fcca58-73905a3b306mr29041774b3a.15.1743000815485; Wed, 26
 Mar 2025 07:53:35 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:53:34 -0700
In-Reply-To: <SA1PR12MB7199C7BD48EB39F536DD34DBB0A62@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <86wmcmn0dp.wl-maz@kernel.org> <20250318125527.GP9311@nvidia.com>
 <Z9nJ42PllG8a7AY7@linux.dev> <20250318230909.GD9311@nvidia.com>
 <Z9pryQwy2iwa2bpJ@linux.dev> <20250319170429.GK9311@nvidia.com>
 <Z9sItt8BIgvbBY8M@arm.com> <20250319192246.GQ9311@nvidia.com>
 <Z9s7r2JocpoM_t-m@arm.com> <SA1PR12MB7199C7BD48EB39F536DD34DBB0A62@SA1PR12MB7199.namprd12.prod.outlook.com>
Message-ID: <Z-QU7qJOf8sEA5R8@google.com>
Subject: Re: [PATCH v3 1/1] KVM: arm64: Allow cacheable stage 2 mapping using
 VMA flags
From: Sean Christopherson <seanjc@google.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "will@kernel.org" <will@kernel.org>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "shahuang@redhat.com" <shahuang@redhat.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "david@redhat.com" <david@redhat.com>, 
	Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, 
	Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>, 
	Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, 
	Dheeraj Nigam <dnigam@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, 
	"sebastianene@google.com" <sebastianene@google.com>, "coltonlewis@google.com" <coltonlewis@google.com>, 
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
	"ardb@kernel.org" <ardb@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"gshan@redhat.com" <gshan@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"ddutile@redhat.com" <ddutile@redhat.com>, "tabba@google.com" <tabba@google.com>, 
	"qperret@google.com" <qperret@google.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 26, 2025, Ankit Agrawal wrote:
> > On Wed, Mar 19, 2025 at 04:22:46PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Mar 19, 2025 at 06:11:02PM +0000, Catalin Marinas wrote:
> > > > On Wed, Mar 19, 2025 at 02:04:29PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Mar 19, 2025 at 12:01:29AM -0700, Oliver Upton wrote:
> > > > > > You have a very good point that KVM is broken for cacheable PFNMAP'd
> > > > > > crap since we demote to something non-cacheable, and maybe that
> > > > > > deserves fixing first. Hopefully nobody notices that we've taken away
> > > > > > the toys...
> > > > >
> > > > > Fixing it is either faulting all access attempts or mapping it
> > > > > cachable to the S2 (as this series is trying to do)..
> > > >
> > > > As I replied earlier, it might be worth doing both - fault on !FWB
> > > > hardware (or rather reject the memslot creation), cacheable S2
> > > > otherwise.
> > >
> > > I have no objection, Ankit are you able to make a failure patch?
> >
> > I'd wait until the KVM maintainers have their say.
> > 
> 
> Maz, Oliver any thoughts on this? Can we conclude to create this failure
> patch in memslot creation?

That's not sufficient.  As pointed out multiple times in this thread, any checks
done at memslot creation are best effort "courtesies" provided to userspace to
avoid terminating running VMs when the memory is faulted in.

I.e. checking at memslot creation is optional, checking at fault-in/mapping is
not.

With that in place, I don't see any need for a memslot flag.  IIUC, without FWB,
cacheable pfn-mapped memory is broken and needs to be disallowed.  But with FWB,
KVM can simply honor the cacheability based on the VMA.  Neither of those requires
a memslot flag.  A KVM capability to enumerate FWB support would be nice though,
e.g. so userspace can assert and bail early without ever hitting an ioctl error.

If we want to support existing setups that happen to work by dumb luck or careful
configuration, then that should probably be an admin decision to support the
"unsafe" behavior, i.e. an off-by-default KVM module param, not a memslot flag.

