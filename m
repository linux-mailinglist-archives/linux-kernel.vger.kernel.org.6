Return-Path: <linux-kernel+bounces-175833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBB8C25E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6998428589D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F812C481;
	Fri, 10 May 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fzwuEG1z"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD62127E0D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348310; cv=none; b=Is/o+yoEK7CbvDGRjqRkUU+5shvYv2CMFNoLUQe0Mu3BFZ6lr0USGGzgZXxM08NDbGwcBTAjH2Q37iaADpLhenS0dLzNSI3lzOa5YAhWdB1tt+e4MRZ5sUNa9uAJdVew+NEzS7Awlst4toHzwnRFK1Ba7ewh7SJcHtx7eYbbo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348310; c=relaxed/simple;
	bh=GuvcFxhdmtaNUDGSQDu70t55Wy23Cyg3MTeGcgF4JWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKoiaRC9804NFQgB5OLObhfe5v1fU6ak4H3NZ93aemrKi6Kz+oBv+5C6PpE2lUzyKLsGnenvTJi8amQmqK48wbFH3TAlZN6/n3Gq4vCHLyt0oQseVdw9yXlxC++xNKNZ9v0pvH+U2gknd4FGwbqa9CMTUagERVg0Fmdm/IFRa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fzwuEG1z; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b8d989e8so147756985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715348306; x=1715953106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2TPwUYTwQy180L7Bu2zvSbEuQFm58Caq7Z0JSBbXKk=;
        b=fzwuEG1zhOP0LPR9iuP61ba6IhVeJrBHs18z9ebPqH3GxqRwf6mAvTf2px/TF4qQxe
         3kfwxeL6OLmxITVlqulEAxaRdgQzLAQOeAfa+jCaE8beYvvnuy3WiVnWEcvJN2u4U9uo
         wbzGM2XEVhOqyTEb3uW7do/R9N5mfJtHN2jSRxUc47nP1uSiftsKdWYmoVpspCrf09SP
         Ko4VF6Wm2MSFMT+36HywGvGCK7N2a8zyYL9FOJxUmzmoK3mIzxK4L2GPTpcy4v+e8Q4r
         RLt7PLI1Stn5O3p0GSD+HObCgipM3NKs59wGz0kVLY6Dn9ljP8RW1HjntI/QpVHISClv
         BOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348306; x=1715953106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2TPwUYTwQy180L7Bu2zvSbEuQFm58Caq7Z0JSBbXKk=;
        b=oP96yvS+PEp8briFVdnrZxjJXnTwv/v3DDEley9ChRw+4UAwuFImfy8i6HapRNjfER
         Nuu2VX9sIy+4BgsCqtctkwJHtt59pyQ944odmKdKRp+v8eS+8CtrZN6kjp3139isS+48
         COK0bDPca7xe/JkDn6jvtUNFI3nWiILvaf2Pp+mU1qwiGBg6EFTu6lJFOlg0XswgQjXU
         x4g0ucMbS6U4c922e931dI3BsI/u3/RO1N5DI628XsDSXcQ7YAZ3RIQ/xAPVG5KwTffQ
         3aGMX7MgzsFtiDG6ZoVC3We5n4oR+tYVaZs+Gg7c8Pfz7aR58cR8spl0NhPtWwsSKZ3y
         gbiw==
X-Forwarded-Encrypted: i=1; AJvYcCX0NESgZWMBvIirxJuETid5KB36tKrjiRt/iqOjGYWsvD2AgubPqsUC7MrE+wymiRVRCej1GoJjfv8c5N+jwwO4aQkEXIQQai+gnAk2
X-Gm-Message-State: AOJu0YzFDB1HS5D9Wh/I9ZQ7THO/JtXOvd5tI53QAtTrISsftZ23+j8G
	pvQoR07g325MB1aYmDZuwpdatHCYCEMR+fLTt2/nUA0mZ4u/5Y94Flwb/WXmK/A=
X-Google-Smtp-Source: AGHT+IH5GaGqzPheLxeZXdVies/UvcsF26XJUeHy3VXdO06NNUavLRZ+kOijshY6CSz7b+YpPsI2ug==
X-Received: by 2002:a05:620a:201c:b0:790:c67c:f53b with SMTP id af79cd13be357-792c6c59cacmr450700085a.18.1715348306561;
        Fri, 10 May 2024 06:38:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310848sm180141585a.110.2024.05.10.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:38:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5QS8-006Co1-94;
	Fri, 10 May 2024 10:38:24 -0300
Date: Fri, 10 May 2024 10:38:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240510133824.GW4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>

On Fri, May 10, 2024 at 11:14:20AM +0800, Baolu Lu wrote:
> On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
> > > @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> > >   	if (group == &abort_group)
> > >   		goto err_abort;
> > > -	group->domain = get_domain_for_iopf(dev, fault);
> > > -	if (!group->domain)
> > > +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
> > > +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
> > > +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
> > That seems a bit weird looking?
> 
> Agreed.
> 
> > get_attach_handle_for_iopf(dev,
> >     (fault->prm.flags &
> >     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
> >     group);
> 
> The logic here is that it tries the PASID domain and if it doesn't
> exist, then tries the RID domain as well. I explained this in the commit
> message:
> 
> "
> ... if the pasid table of a device is wholly managed by user space,
> there is no domain attached to the PASID of the device ...
> "

Okay, it needs a comment in the code, and the RID fallback should be
based aroudn checking for a NESTING domain type which includes the
PASID table. (ie ARM and AMD not Intel)

We shouldn't just elevate a random PASID to the RID if it isn't
approprite..

Jason

