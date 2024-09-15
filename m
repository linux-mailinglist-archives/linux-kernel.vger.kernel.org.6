Return-Path: <linux-kernel+bounces-329870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B39796DC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F08A28146A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9521C7B61;
	Sun, 15 Sep 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="irSaAWca"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAF12CDBE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408173; cv=none; b=kNNuqYi6atrEaTK71hPgyVX5qJFRaOW4O9s5VL9ZF6ljbyX2eS83tqfxUoNw20af9yBNAKKs5OeLer2hSJCGmsQKOd5A+sH/6+xLc+PXvcqESsMEEM9fVtIDHULn+fh+ksY5C1nyX8royUAQriF/ZsAFmJAuMmjxS8PWmoMdZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408173; c=relaxed/simple;
	bh=rhHSv45EQIjmqKG+v5smUwofVqEGAHE2syWw8NKSku0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK9XSI/gNl1nDHYDZrJhGg3wHI4C3oMjPGnhBB8QAmbIzrZiNugBJmtdL+g5yEpc6aGHwOnl74cpk+cwJzSvcPFRSYq7swix7cJWpUvQTtfJKCZDRulHW2QPB1WAUztu6hOeXyEDQ7h9lix/ih2RR//WikVU6oK4BSHsn7X6cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=irSaAWca; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c352bcb569so18465676d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726408169; x=1727012969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQSY+HxRYKjtmeSVzczlvhSFfHMIgoo6GYpKTUSvR44=;
        b=irSaAWcanbYEeYi1sYh+tp7ZAJFQPpdpOznznIEiS/+ALdsl7rzjIHE1iNKEfAFBEN
         /+jA7tTdfETPf93tjjLyYX5Gxnkk5poD5LjLR/C7d3cR9xblaL6ItGVHZodoFyX8KwXb
         x9asZa76f31Mjyv0DmBFQRxAAD6F/y5qRVM0azzrbAzBj8G/rZXj+BEOOowqTwBY20Sn
         1GKxn5DglYbXazVyfTTqfy98CCA4FPf+L937Yb45rONv3itB5bd1ynaQtfY+RzPEyjDh
         emjofpBJec2ZiRhvuyovPPIgxS5rbW5hfyoavUE2T+3KsS7YyKvUN+OB+2XMzhyTTCBY
         fKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726408169; x=1727012969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQSY+HxRYKjtmeSVzczlvhSFfHMIgoo6GYpKTUSvR44=;
        b=d7Zm67pBXSxjHP7krdVbaRDlPqf3vzuilK00Vm4X9jcQlF3QdTHU2/uTjsXuQWONau
         00Ri9x98JRSzRJxvNNCpp4f5HC0HTpSmrZkWR16zNOyZn9z5Rjbkq3l5ezKjBwO7ytjV
         Z+ZTp3rKmkbkwwgb3EP5dukhn64wn26T+iznQYvmdXKSLATaQZ1ov7YbHd7nVyH3fxVF
         6JUBBB6PiJIr8IC8QUDQUbjVFiONOQCf+FVhp0MI9Yralowzy+zyh9Yyu2nM99mgxgEs
         3OpjGV4jl9howFipYI7Ik62BFqUjqsHMRko8HKKg/Y0w74R0HLxj4GfXzVk2X+y8RTPY
         Ue+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfQqTjoVUfh2oOrtao5KGYPPDe7jHCobLCf24KXWwLFkXEfQ/pQf2yQj7PpB/Q8mFCjtmtRr5gjf/0rZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsxageiTjUjmXH4gil9S6F/Dmkj26EdUbDJLhp051ctm5dKi1
	+iQrP7t+9Fpcl9kG7h+kc8QXjWXWpPDlU8SFa8s4EJg2LxzR90LLmwmZ40+KS50=
X-Google-Smtp-Source: AGHT+IEXGpaCl/mQNXW/CoMuFa734dsgdykEt4UauT0ExIPSiflRLIVu7EdfH4PeIuQg+qc3WKiStA==
X-Received: by 2002:ad4:4f34:0:b0:6c5:52cb:eb77 with SMTP id 6a1803df08f44-6c57354767bmr150622686d6.2.1726408169525;
        Sun, 15 Sep 2024 06:49:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7aee43sm15811046d6.111.2024.09.15.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:49:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppd2-007dBf-EY;
	Sun, 15 Sep 2024 10:49:28 -0300
Date: Sun, 15 Sep 2024 10:49:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <20240915134928.GD869260@ziepe.ca>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>

On Sat, Sep 14, 2024 at 01:49:44PM +0800, Baolu Lu wrote:
> On 2024/9/14 10:53, Tian, Kevin wrote:
> > > From: Baolu Lu<baolu.lu@linux.intel.com>
> > > Sent: Saturday, September 14, 2024 9:18 AM
> > > 
> > > On 9/14/24 8:52 AM, Tian, Kevin wrote:
> > > > > From: Joel Granados via B4 Relay
> > > > > <devnull+j.granados.samsung.com@kernel.org>
> > > > > 
> > > > > From: Joel Granados<j.granados@samsung.com>
> > > > > 
> > > > > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
> > > > > Move
> > > > > all Page Request Queue (PRQ) functions that handle prq events to a new
> > > > > file in drivers/iommu/intel/prq.c. The page_req_des struct is now
> > > > > declared in drivers/iommu/intel/prq.c.
> > > > > 
> > > > > No functional changes are intended. This is a preparation patch to
> > > > > enable the use of IO page faults outside the SVM/PASID use cases.
> > > > Do we want to guard it under a new config option e.g.
> > > > CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
> > > > for the majority usages which don't require IOPF.
> > > > 
> > > > Baolu?
> > > The OS builder doesn't know if Linux will run on a platform with PRI-
> > > capable devices. They'll probably always enable this option if we
> > > provide it.
> > hmm then why do we need a SVM option? In reality I haven't seen
> > a platform which supports IOPF but no pasid/SVM. so the reason
> > for whether to have an option should be same between IOPF/SVM.
> > 
> > IMHO the point of options is to allow reducing footprint of the kernel
> > image and many options are probably always enabled in distributions...
> 
> To be honest, I would hope to remove the SVM option some day. It's
> nothing special except listening to an external notification and
> synchronize the caches when the page table is updated. It's common to
> all cases where a page table is shared between the IOMMU and another
> component.
> 
> As for CONFIG_INTEL_IOMMU_IOPF, my suggestion is that we don't need to
> add any unnecessary options unless we see a real need.

You could possibly bundle the SVA and IOPF options together

I called the new option on the ARM side CONFIG_ARM_SMMU_V3_IOMMUFD
which seems like a reasonable cut point against embedded vs server.

Jason

