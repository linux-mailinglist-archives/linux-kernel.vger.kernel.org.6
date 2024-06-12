Return-Path: <linux-kernel+bounces-211565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BB9053C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4761E1C2248E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAA17C203;
	Wed, 12 Jun 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Elh4tOzn"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1017BB31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198736; cv=none; b=D2eDw+XhF78ATjGsDb0N+T70JuSStRvEvSIVYYHvmT16R19EA/G5mtE9TYi1Bp4O+bu+ULe1pYf7fAfYYKEwKJiI1cRvhoNWJchNw9OE9yazdBY+6OJOkMwKrJDybEk3uX+m2gtE2HHFo9UekS/yeiFVopAal9SeWP/sElcppjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198736; c=relaxed/simple;
	bh=5r7kTei3l3CsdNg/q8RBiLmWZ032Se1UCEEyvhJU1a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaXzAb1e9ZRSMV0+v2etCqOjN+jwUdZq1B1KSL0o7Ha6zvU3VTNHWU2rcEs3tRpZCio3AgPPSBQ+jEkiHTPcFHAu1vWTbue6JvxDuKvRN4z8l6RoZs7qw3GKZci+2YuAw/vzwpfOTfY/sGWmZue1MJJxB6SMbWbKyuC4gOAZRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Elh4tOzn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-440655e64bdso20763281cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198733; x=1718803533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUSqpmX+ejk/HnC4nbAm5rQmmAITtEvd4QugKxTCvc0=;
        b=Elh4tOzndv4W1vAri7aqt79yRp6FXNOqAXK68wjhMEpH+woCySpjGazEUlJFDG595f
         Uz72NQ7/rUXvefsR/8ZwFyx2J92wK2u1PXP9l3i3WXKuD5L/2b0SzDFDbj5sfkZQp4wQ
         KYAwQ+NmdciSpwUmDL3yO4NqrHpspWOImqNQ54XeXk/48O5hs0BgGTV9G3suHwOyxRpb
         GqDWnuqhk625ozJUldZHN4UhpbzIwwGkqU1rtV3DxT+5EhQNngihJyOMfqVeL7/02+Zb
         6geeSKDVEuyMMOVN+yEQPUtZBaCCptsXK0IQyzv9fGHp+P1TptxtMwigq3/eJT5uWVuF
         jTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198733; x=1718803533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUSqpmX+ejk/HnC4nbAm5rQmmAITtEvd4QugKxTCvc0=;
        b=mcdnwKa8rg5H9QW3xsUNow+zcmQCxceTNsFsZcudbjuuNT/0UFXhb4APLKvPaR0SS6
         pH1mYd1tOMHqNAxyAcNNIZq/wEFkPIDB6vlQyYJOK7P2j6WoI6qeLuvwKG+JluFxLZzn
         NFlKr1hQ7gAliID4W9iQ/Ee0R448j+lOP2/ELDZXxqd01J5GJDFYY48TsEp1LvlAduv6
         G9/39PwxaMhOTXrZamcWUrXr46lQ6mAZ+qTOqc0GU0B6A37ifpr9OBQkCY2sk1CGRaQi
         Qr68EZQyWasVWSJ+JKgXHln6R1glKwTegDSe6Z3hg0eiYvq3aFC19HUik3lsasVWW4+g
         aMkA==
X-Forwarded-Encrypted: i=1; AJvYcCWpCHtc2HwjtJR8rmkEqwrG+oa2HF0Gtq7lMYGOOI2fyNHYp90ZfWdy1PCTg6JuJRsDMhbZNSc8+DzBZX2H3RYS7eQPgFKnWgEQHpIl
X-Gm-Message-State: AOJu0YyKuT597tbkCg1noS1S/HiypNaj34kmLUpSG4ugJ7zPmY4dZ/YC
	t4mAVNOqDJ2qKxm9iJq4HThE0HeFLf+PZvk5mUZR3i3JmI0dA8FvRXK/V/XxDL8=
X-Google-Smtp-Source: AGHT+IEaSleQ5/4nSB1kEi3YoGwZTAao8TntM14Myn/eVd0unCfawvyN6q3ByV4cJt9BsHj66DtLGg==
X-Received: by 2002:ac8:5d92:0:b0:441:37b:cd68 with SMTP id d75a77b69052e-4415abd5a8emr18860231cf.25.1718198733475;
        Wed, 12 Jun 2024 06:25:33 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440542e98f8sm42778781cf.18.2024.06.12.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:25:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNyl-008tWb-7f;
	Wed, 12 Jun 2024 10:25:31 -0300
Date: Wed, 12 Jun 2024 10:25:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
Message-ID: <20240612132531.GV791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>

On Sat, Jun 08, 2024 at 05:58:34PM +0800, Baolu Lu wrote:

> > > +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
> > > +{
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +
> > > +	iommufd_ctx_put(fault->ictx);
> > > +	refcount_dec(&fault->obj.users);
> > > +	return 0;


This is in the wrong order, dec users before ctx_put.

> > hmm this doesn't sound correct. the context and refcount are
> > acquired in iommufd_fault_alloc() but here they are reverted when
> > the fd is closed...
> 
> These two refcounts were requested when the fault object was installed
> to the fault FD.
> 
>        filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
>                                    fault, O_RDWR);
>         if (IS_ERR(filep)) {
>                 rc = PTR_ERR(filep);
>                 goto out_abort;
>         }
> 
>         refcount_inc(&fault->obj.users);
>         iommufd_ctx_get(fault->ictx);
>         fault->filep = filep;
> 
> These refcounts must then be released when the FD is released.

Yes

The ctx refcount is to avoid destroying the ctx FD, which can't work,
while the fault FD has an object pinned. This is also why the above
order is backwards.

Jason

