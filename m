Return-Path: <linux-kernel+bounces-211548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FD905387
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E4E1F23A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F817C20B;
	Wed, 12 Jun 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="guiVtRnV"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A617B516
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198392; cv=none; b=CJ0tNGpR+W6D5gHrr0yrXsYDVcpSTrKcVOEYjylY8vrp/trkiUdhGdSsQHMlwtANCbwPYmcZcLAUOlyoWiUo/sagLB1iZ7avaSzqv/8WsvyRCYJkywTGJ5Y4ovnhN1hjS/M0hjX3fYVGs444m3N6l5jb5Lk2BoDpDFxScnhrNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198392; c=relaxed/simple;
	bh=30kMMEM/0RGIoM4AKwXZ6d0eDjEm1u/8hrr3qBtEMls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK4xyM7JdD+GJY8JbdgvvFDtz2fkw8a42f/XdXHKxrg4HEpA5KHkhv+DKQai1MLNGQT2H4ui0W5r3iSe5ad+9nJT04hXctKiNi6W/jIQyOr2jQHw1hrGynuh7kl0lIkpXaOgaqU8nwS1dNUbDOjeYciMWoB8zeZ9yTiD7P79ZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=guiVtRnV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-797e2834c4eso75160085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198389; x=1718803189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIK4gueTNICdj2uOTyUO46d7/vRhcgixUddDleOmgKI=;
        b=guiVtRnVSn6bUbVH16VIPBwinN0PCLLuTXxV/M1lGR4ZyNy8vPZW2+zW3QIVqsOZh6
         ht8jtUOzYpk4ISPr4uDrg4ahf/fPL/9ikXqiNu490m4+VjsLlcCo51vVSUF0n56+tjHH
         m0FAoz82fS96tjsvZWaH67KvkDzu2zlJqcUNalHOOZPrLjB+MGPdKIjtPoXeuV0KznSr
         3ofL0tydzmelNKtEU+bQY3gAef6sPfxuyXlSXghpH1f0eSs6L3tSs/YqsNp1UxawVx8B
         C3JJ4BT1WZPh/kWy58v+8odUIZ/Hpcc3j5JBMElT7nd4OhaUp+DSmFsDiJU4/84LzTCD
         DkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198389; x=1718803189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIK4gueTNICdj2uOTyUO46d7/vRhcgixUddDleOmgKI=;
        b=px3ll5k/Eca5NmpqQxW/VKuy8bxUJurknJeO0ftSRmkq4KV3Z6/KX9qjk+syX4qlPE
         Q2tnF2W2Yv+0SRJuTzHoel2tijm7AWGwzSfhh1qiQEd524+kvzhOlPnPPFkTjV+sQU18
         oBIzz2cOsyt7ZfDi+u0XhO8L6seDSEf5EecWBghcKtanPMlAyddpNvWdGjEfWNY3dVqX
         qsvyNiDcdRtoTRPVeoWdcZ55E8Bx9w5bvHe0VAovtfDRJjsuao1Y4X5Igu/pYfQRxX2S
         eEtQm6KjcmsHBCDlInlW6Qij6bhDWTyHlc92ny0yiSmL4UBvtD+Z01SUJEe6E5Gntv2J
         EYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULIWyqDrlkjCZwAZZs1qQgzozv5uR3YcaLcOAw26QNWRsXP3WpQiFTL5mNaX3Pk6001z8ng1bQufg5yy+a9tcyvJLXBK+apHcJgdQZ
X-Gm-Message-State: AOJu0Yy45xTl80EvW84YvJqKpyzx3QRMMmgrH+YxT/dL70F4aAhczMEO
	6I5hBjn9PLsoRRH0aLHAVTrWXV6Xli42a1/3Rm+4zmdAHClhlhZgbvejaAj6Sis=
X-Google-Smtp-Source: AGHT+IHIr3wVyaXMObF0gIHRTDzfj+r/v0k7L3AOz0PBBlBNpukbYjT9PBJBIvgFmfGPvox7DSPLxQ==
X-Received: by 2002:a05:620a:3184:b0:795:4e3d:2a55 with SMTP id af79cd13be357-797c2dd5e40mr960856185a.28.1718198389310;
        Wed, 12 Jun 2024 06:19:49 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955bffcb4esm344068285a.131.2024.06.12.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:19:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNtC-008rr0-Eu;
	Wed, 12 Jun 2024 10:19:46 -0300
Date: Wed, 12 Jun 2024 10:19:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612131946.GT791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:38:38AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, June 6, 2024 2:28 PM
> > 
> > On 6/5/24 4:28 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Monday, May 27, 2024 12:05 PM
> > >>
> > >> +
> > >> +/**
> > >> + * struct iommu_hwpt_page_response - IOMMU page fault response
> > >> + * @size: sizeof(struct iommu_hwpt_page_response)
> > >> + * @flags: Must be set to 0
> > >> + * @dev_id: device ID of target device for the response
> > >> + * @pasid: Process Address Space ID
> > >> + * @grpid: Page Request Group Index
> > >> + * @code: One of response code in enum
> > iommufd_page_response_code.
> > >> + * @cookie: The kernel-managed cookie reported in the fault message.
> > >> + */
> > >> +struct iommu_hwpt_page_response {
> > >> +	__u32 size;
> > >> +	__u32 flags;
> > >> +	__u32 dev_id;
> > >> +	__u32 pasid;
> > >> +	__u32 grpid;
> > >> +	__u32 code;
> > >> +	__u32 cookie;
> > >> +	__u32 reserved;
> > >> +};
> > >
> > > with the response queue per fault object we don't need all fields here,
> > > e.g. dev_id, pasid, etc. Cookie is sufficient.

Wait, why did we make it per object? The fault FD is supposed to be
sharable across HWPTs.

> > I prefer not to mess the definition of user API data and the kernel
> > driver implementation. The kernel driver may change in the future, but
> > the user API will remain stable for a long time.
> 
> sure it remains stable for reasonable reason. Here we defined some
> fields but they are even not used and checked in the kernel. IMHO it
> suggests redundant definition. If there is value to keep them, do we
> need to at least verify them same as the completion record?

They are not here for the kernel, they are here for userspace.

A single HWPT and a single fault queue can be attached to multiple
devices we need to return the dev_id so that userspace can know which
device initiated the PRI. Same with PASID.

The only way we could remove them is if we are sure that no vIOMMU
requires RID or PASID in the virtual fault queue PRI fault message.. I
don't think that is true?

Cookie is not a replacement, cookie is an opaque value for the kernel
to use to match a response to a request.

Jason

