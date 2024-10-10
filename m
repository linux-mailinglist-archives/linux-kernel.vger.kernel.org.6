Return-Path: <linux-kernel+bounces-359457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD52998BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264432866A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22611CCB50;
	Thu, 10 Oct 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="luh/PgWO"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CE1BFDEB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574372; cv=none; b=AyvXlU7U782sdD8nKTAMkfOI8jLqMOIAx4bFFGGy8MY0PXd9rL+lKA83cAsuOQjOgoZN1YK+XloKvaZZgryNiSesDJysNU49VLVY4ONCWs9LVuziFl6lH/IVdRulBb7nUUdGWciSegv9rJ81VvvBVkVn4FW8ANM1MyK21JSEyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574372; c=relaxed/simple;
	bh=0qRq6GLRROiieAAtLUvv4MImLCc+TYAbMc5Likzwm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUS8oTxxoXxPXPPbPXjgUGskZimdmOKpmfQUAqF5Os4yVUnG2UqOev3OsG5jvMPsRBUb8KXrP/CRiRi9Jo3yxqlsRKF6KbhwJ6xgoPn/RxjdLnljGeHvZiTDLa5UfVxD5w4Kk53ESSPogjCww9SBy6Cq/atLxEOqUMWOg+iZWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=luh/PgWO; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e7ae4c504fso479461eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728574370; x=1729179170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSULaLo7bx82nTcyVbVqGRizSGyTmlxCBPKO2rG1izk=;
        b=luh/PgWOPaEBXlJbjChOjfobtgEouvEePsjxFpAC/kzKO6jAt0XEefUB5XAqlmvqfe
         OYD7z5tMhQJbSsPiGMrMfeZOlFQXtkD2hwETJtV8KhMJG/bhwb9QIp3AoZyS0vba2SUw
         gbl+/n9jfqcRm39nFmPTidlWkBnt5HEOnLQdBd6FCtDNF13icMO/xlLvMxNNbogKZe7p
         lG7/phn7QY5IvC4FhcHIy/WLGDNolFkd5cRksX+iobn89jPzlqvTOOnAapJc2z6JLtoJ
         zus82sqHTN/12ON5RzsGO/rodNjlnl7sBTDFbD9exjDHfvl1Yf8SrvV/h3Ubp0dLApFP
         4qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574370; x=1729179170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSULaLo7bx82nTcyVbVqGRizSGyTmlxCBPKO2rG1izk=;
        b=cliBz3EzDQ0ak1EsbcOProd99ExsnFrw3ZWc+UebQzDMeDIInSiO10F3+sWC2UT9RJ
         a9R0pEGxOz5X6r+XebWCuENd4+NdUs43+W4RXoVzI2SJdEbWQox4ue4TmjNst1psKHJE
         TusO4mJMC3LjNzEYtdjQCVa3pnIomusAF5czNlRHbTZ5tnVl0Sn6v+2IaRjv1h8RWyIj
         pTTNaCTnmabBsuPiSpKZzYOVUDjXkITDMxFGsDf6IYjVY4ElVD+FaiYRYS/fNZ/LFfxq
         NZ7u2o7sEfWqUqBeGQ8TUtNhLIkhm0RAzhhIZ21ewZGN6/prhY10pLsMCHyAZBI4bjKI
         n/4A==
X-Forwarded-Encrypted: i=1; AJvYcCX0K5BFG4IkiFYp/t8nme6UMM6ljgLfzAzCAJTA2Qe+QHe7XhHRV0lTH5tC4B+z3DhxqM12tD13wOnKGZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbF3LTkidi8idwxWaoabpyI6oNKmVkmvue6FN0f5fK8hjidrv6
	2BFF6h5hweggShuh7EeC4thAZiF29O7CCOrsCFl5qM7yNHSP/ihBP3Dm7WtRCPw=
X-Google-Smtp-Source: AGHT+IEo+4uPxrqwFzTBdQMNuBXazTiZjFczZi3xfkmJGwDNGM0oEJ3Dpqs7IWLoU8PX7kF2Wo4uAg==
X-Received: by 2002:a05:6358:e4a2:b0:1aa:a01a:23dc with SMTP id e5c5f4694b2df-1c30811ae44mr195185455d.15.1728574369566;
        Thu, 10 Oct 2024 08:32:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe862fe87sm6186216d6.106.2024.10.10.08.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:32:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syv9k-000zwn-5N;
	Thu, 10 Oct 2024 12:32:48 -0300
Date: Thu, 10 Oct 2024 12:32:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"maz@kernel.org" <maz@kernel.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241010153248.GH762027@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
 <e458d48a797043b7efc853fc65b9c4d043b12ed4.camel@infradead.org>
 <1d331c55a299d414e49ba5eb6f46dccb525bf788.camel@amazon.com>
 <20241007150138.GM2456194@ziepe.ca>
 <b76aa005c0fb75199cbb1fa0790858b9c808c90a.camel@amazon.com>
 <20241009122830.GF762027@ziepe.ca>
 <673df8a09723d3398ca9e9c638893547b0b0ec63.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673df8a09723d3398ca9e9c638893547b0b0ec63.camel@amazon.com>

On Thu, Oct 10, 2024 at 03:12:09PM +0000, Gowans, James wrote:
> > If this little issue already scares you then I don't think I want to
> > see you serialize anything more complex, there are endless scenarios
> > for compatibility problems :\
> 
> The things that scare me is some subtle page table difference which
> causes silent data corruption... This is one of the reasons I liked re-
> using the existing tables, there is no way for this sort of subtle bug
> to happen.

> > > If we say that to be safe/correct in the general case then it is
> > > necessary for the translations to be *exactly* the same before and after
> > > kexec, is there any benefit to building new translation tables and
> > > switching to them? We may as well continue to use the exact same page
> > > tables and construct iommufd objects (IOAS, etc) to match.
> > 
> > The benifit is principally that you did all the machinery to get up to
> > that point, including re-pinning and so forth all the memory, instead
> > of trying to magically recover that additional state.
> > 
> > This is the philosophy that you replay instead of de-serialize, so you
> > have to replay into a page table at some level to make that work.
> 
> We could have some "skip_pgtable_update" flag which the replay machinery
> sets, allowing IOMMUFD to create fresh objects internally and leave the
> page tables alone?

The point made before was that iommufd hard depends on the content of
the iommu_domain for correctness since it uses it as the storage for
the PFNs.

Making an assumption that the prior kernle domain matches what iommufd
requires opens up the easy possibility of hypervisor kernel
corruption.

I think this is a bad direction..

You have to at least validate that userspace has set things up in a
way that is consistent with the prior domain before adopting it.

It would be easier to understand this if the performance costs of
doing such a validation was more understood. Perhaps it can be
optimized somehow.

> > > then it would be useful to avoid rebuilding identical tables. Maybe it
> > > ends up being in the "warm" path - the VM can start running but will
> > > sleep if taking a page fault before IOMMUFD is re-initalised...
> > 
> > I didn't think you'd support page faults? There are bigger issues here
> > if you expect to have a vIOMMU in the guest.
> 
> vIOMMU is one case, but another is memory oversubscription. With PRI/ATS
> we can oversubscribe memory which is DMA mapped. In that case a page
> fault would be a blocking operation until IOMMUFD is all set up and
> ready to go. I suspect there will be benefit in getting this fast, but
> as long as we have a path to optimise it in future I'm totally fine to
> start with re-creating everything.

Yes, this is true, but if you intend to do this kind of manipulation
of the page table then it really should be in the exact format the new
kernel is tested to understand. Expecting the new kernel to interwork
with the old kernel's page table is likely to be OK, but also along
the same lines of your fear there could be differences :\

Still, PRI/ATS for backing guests storage is a pretty advanced
concept, we don't have support for that yet.

Jason

