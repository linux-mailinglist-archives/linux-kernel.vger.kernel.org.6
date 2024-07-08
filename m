Return-Path: <linux-kernel+bounces-244638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03392A737
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92B21F20F65
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF3D146A98;
	Mon,  8 Jul 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Drq9qjIX"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BB146A77
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455779; cv=none; b=p29GGVLCbTWvuP6ZSRsCvN5ptygacZBMJinbxquRa3nz+hmXM9e14kPkeNORfc9t7U6WIJfIt/52/QPQaDTjrUt9iyZZDbqsf+4KUk1c4qrfopvBpegg7hLPJLPceQNLPFY3PPAyhyrOTg8ycaDPSnG2kKiO9vEPKNhHrN+R2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455779; c=relaxed/simple;
	bh=39Ok3aZtiGyAkg4DskALCfPqlmoQpaapP1QZtS597l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/kKHYB7cvvWXJb0Pzhdy86KzorlNZZnGnrST2u9PePbL2mHdoBXR02m990ZzTsUOipgeu27N47300hpG+C7QMXVzSPM0CIRN93m4q1HXtHDHZXY3RbuEvKTOjBGsTlz1wproTnVIBSCzHtbRJUizI91LCHcD+ceVMrH2XuxYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Drq9qjIX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79ef7edb08cso190620685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720455776; x=1721060576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka0gK+6TRBkr1g04M4X3WeamKoRpIybVWjVNgzYyEOk=;
        b=Drq9qjIXmnmZFqs2u6lziVhfe8RyTyIVZEOdewael6nwBMS9rOGF63YJInSvac78Lb
         V+sHN/vTkGBTzDhxxffdeUq+vydtCBxJj7Z9NIHn6mst7YZDwWNqIeix9sL8wx6VCpbk
         ZMAGexKlla+MY45b+t8MIxsAS/3+m8kT7LNf3ooNV/o9f3b+HV9XWz+TCazwrfN9qjOy
         eUMFH0sLIX/9SE67tnow4503etT0dpdLBexUQcNVATAwn8SlESud70vO+nuoJUjwMvmE
         I/UfJTfiveZe7hXFghIrOaFNWXzd0e/DNzNbLl+P1K9ol8cSVCD1kx7CoKjM+uMsPN95
         f8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455776; x=1721060576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka0gK+6TRBkr1g04M4X3WeamKoRpIybVWjVNgzYyEOk=;
        b=Z9TxJ/cFSfSFePgS8pR0RKOL84DNc6kMOmwiVgHRJTmbXoKcwkwGe8z2hnvlhCIiOM
         Aow19TcIkmAZjo0c8k7uAk67qbFXXaWHhAhDqGlQ+daAYSAqbDLI3FaP6Jv5BQoZ2mjk
         BNQXm0+i/YRxMV5q+6UCcfef7SnXItGYZbhhpOOPDlN251S7gaSHHMexDjRip6lQwECj
         PSjR/Wp9V36kGfRGiq7OmiOd6rB9ygaV/wyxa4RNokIb4QXybXnjq8vu3zAGoxUNbq/Z
         A6p0ryTAWI3u6+nkYhe1hsvwgdDIvIrXSKwFvZz8ZPqEsn58lDx6UaKkgKz/X0dD5X5p
         jMGg==
X-Forwarded-Encrypted: i=1; AJvYcCXWl7jVxQNh/oD67YS8Qxn7ao2yta9m0b/3GGN+pVkTnxB6tHeRBrQ8/o26yfjUjL42FuqA003E0uFXVsIDsPGKYuAnh3AmxWJTQGBu
X-Gm-Message-State: AOJu0Yyj0U3HGJNOI4Zv1L39rqPFYH6Xqpbr67pPJjPn5FLBbURjENZX
	/S1HLpLsWzcEmtXdXvdcTDlkfZq6FcH3vtMoLksBk6PaPGS2aYspeiKpj/9BSJA=
X-Google-Smtp-Source: AGHT+IEWk4zyOjmKegu6Ou87+AD0hzX/bn+Dtu9fsIyTz6kLGJ/J3j+Jl6yX9VsoZO3luJTYUeKCCA==
X-Received: by 2002:a05:620a:1b:b0:79f:1731:ae24 with SMTP id af79cd13be357-79f19a65363mr2034085a.32.1720455776575;
        Mon, 08 Jul 2024 09:22:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b4c57sm5520685a.132.2024.07.08.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:22:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQr8h-000S83-1x;
	Mon, 08 Jul 2024 13:22:55 -0300
Date: Mon, 8 Jul 2024 13:22:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240708162255.GA14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
 <Zoct3LVVHhDNbPBT@Asurada-Nvidia>
 <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jul 05, 2024 at 12:49:10AM +0000, Tian, Kevin wrote:

> > > > > > > +enum iommu_fault_type {
> > > > > > > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > > > > > > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > > > > > > +};
> > > > > > >
> > > > > > >    struct iommu_fault_alloc {
> > > > > > >        __u32 size;
> > > > > > >        __u32 flags;
> > > > > > > +     __u32 type;  /* enum iommu_fault_type */
> > > > > > >        __u32 out_fault_id;
> > > > > > >        __u32 out_fault_fd;
> > > > and need a new reserved field for alignment.
> > 
> > Hmm, what's the reason for enforcing a 64-bit alignment to an
> > all-u32 struct though? I thought we need a reserved field only
> > for padding. The struct iommu_ioas_alloc has three u32 members
> > for example?
> 
> yeah please ignore this comment.

Sometimes I encourage it so that people notice the if the structure is
changed later. Almost all structs here are 8 byte aligned. It is OK
like this too.

Jason

