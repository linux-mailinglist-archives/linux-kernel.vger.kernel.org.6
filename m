Return-Path: <linux-kernel+bounces-211553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1249053AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12001C24217
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661117B408;
	Wed, 12 Jun 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JfN5Ekz3"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B515153BFA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198643; cv=none; b=VyRGpYrnKIS0GFaU0x1VNwY0C3mbhN3pecUKyZSsgI/ioPdyfKputylJYsvhSqu0oZp4Dv17R/snyzCkNBRoSn1FzDupmgsWjLPItwI2C5yFb74hIs7ANqk26BRB2qCXNcyU/z4X9uXUnzekIbhwD/WCsqioZzZCqO7iDqPdHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198643; c=relaxed/simple;
	bh=ZzY3qCMPDQaQOhhG+Cblq6ulH8qDjUPPFb/f9zNHOOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSLyX2PuNozKzpmpSKz28EIFeR+tNVQDUN84t6GacIO1T8KvU2tMteCwFbzxB9iB2N2GkEFHVyICf+inMTvt2FS7WMTMwtLSgU8QhADIZXe39KolC5/pmMG6w4VhLKEcVUfmx+IJS5qBXa+6SMz///JoGtEZTZBE1fJE1QFWzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JfN5Ekz3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43fdb797ee2so37800371cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198641; x=1718803441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXrU57CQXz06V3OC089KtN6n0lzdkX95OHg+FjYAde0=;
        b=JfN5Ekz32g650MDYjctULe7RyUWADsPOYQiYWb5dhj3lgAHoNUmsi1KZkFey+fcDrI
         4U2JJ/eNAApS0reFtyBj6h/VWhjL+bfGac051oj9KfIcuda9bJg7Fv9nz/vfTrqhA3Bo
         7SqISveEYag8gLUh6sXNSpQry9+seUeBmnzwyeRT32vv6wMA2qSBPrhnkvLLtMr2r+vi
         FjPvBUQgShh5/9xcmsBtW6/j5gq/HfAlPgiRPIgWRbjv7RxjqdiA3//cWdLDslDEG0FA
         qdrSaoKH0cPRkcTFGFkXl2IKYkeJDj3NaoEresOiP2ZNYZgmF0MJoL/ZDYaNrQjhBa+F
         1AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198641; x=1718803441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXrU57CQXz06V3OC089KtN6n0lzdkX95OHg+FjYAde0=;
        b=ovBRjpLkwbQypWxHKzMZb1NEIJrimBsaC0mclX3wjRLDZemFDf8lO4dVCCXNkCOcny
         BK132vfefFa/cne9wgZ+UYxESIjBQeU9ch5Se5jGNsQBXoIvwXxAx6TvvR9jWA7ZMldp
         IHPFd6/WQUx/wLA7vdLqwG9JZsWY0RH8pk5J/Yg9SS1Kv9o3qzhaz5jzdNVS+NrBKx+U
         KnpVh/2AMLrKQVfVD6HCcEHm0Ttn8N2jpoMCHnNdtHDAihwf1WKfUk+o3WUATulFWa4u
         kpv2SYBB/ebI710SUpJOviacfV3OQSs9lzydWE4iyR5KuBVzuiC1zP2SyEC4VfYJs7WH
         BtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK3oBZHeGMBf5DEA3ZMJVpoGgfF86x1uCg/7gT3tHQycY3xjGVEywfuZW4bXDS7J4ZDyLgEEN3wtGgYghqPGjX/zM4KPOkkgMyPso3
X-Gm-Message-State: AOJu0YzDi2MgYpMCbQYo/7g/NLfHhcq4Bkx0TG9x0ZzBA+nBBb7X3K+K
	9LD9Ys9WdZvYubrygQZOu1afiOUBjwfUwgdn3WQ5tIxaIK3lGZwxNgHA27k3/xk=
X-Google-Smtp-Source: AGHT+IFCgwK6nkMac+bbLrNRTZhR+zW7VHze00Gv6obmMLZnfPVZUTNFdOzpdXn2ab5aoZ07hd2k1g==
X-Received: by 2002:ac8:7f4a:0:b0:440:1c5a:5c9b with SMTP id d75a77b69052e-4415ac0ecbcmr16496121cf.7.1718198641035;
        Wed, 12 Jun 2024 06:24:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4403895aa9asm55436811cf.7.2024.06.12.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:24:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNxG-008t4f-Ig;
	Wed, 12 Jun 2024 10:23:58 -0300
Date: Wed, 12 Jun 2024 10:23:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <20240612132358.GU791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:17:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 27, 2024 12:05 PM
> > 
> > +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> > +				       size_t count, loff_t *ppos)
> > +{
> > +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> > +	struct iommufd_fault *fault = filep->private_data;
> > +	struct iommu_hwpt_pgfault data;
> > +	struct iommufd_device *idev;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf;
> > +	size_t done = 0;
> > +	int rc = 0;
> > +
> > +	if (*ppos || count % fault_size)
> > +		return -ESPIPE;
> 
> the man page says:
> 
> "If count is zero, read() returns zero and has no  other  results."

The above does that? 0 % X == 0

> > +
> > +	mutex_lock(&fault->mutex);
> > +	while (!list_empty(&fault->deliver) && count > done) {
> > +		group = list_first_entry(&fault->deliver,
> > +					 struct iopf_group, node);
> > +
> > +		if (group->fault_count * fault_size > count - done)
> > +			break;
> > +
> > +		rc = xa_alloc(&fault->response, &group->cookie, group,
> > +			      xa_limit_32b, GFP_KERNEL);
> > +		if (rc)
> > +			break;
> > +
> > +		idev = to_iommufd_handle(group->attach_handle)->idev;
> > +		list_for_each_entry(iopf, &group->faults, list) {
> > +			iommufd_compose_fault_message(&iopf->fault,
> > +						      &data, idev,
> > +						      group->cookie);
> > +			rc = copy_to_user(buf + done, &data, fault_size);
> > +			if (rc) {
> 
> 'rc' should be converted to -EFAULT.

Yes


> > +				xa_erase(&fault->response, group->cookie);
> > +				break;
> > +			}
> > +			done += fault_size;
> > +		}
> > +
> > +		list_del(&group->node);
> > +	}
> > +	mutex_unlock(&fault->mutex);
> > +
> > +	return done == 0 ? rc : done;
> 
> again this doesn't match the manual:
> 
> "On error, -1 is returned, and errno is set appropriately. "
> 
> it doesn't matter whether 'done' is 0.

It is setup so that once the list_del() below happens it is guarenteed
that the system call will return a positive result so that the
list_del'd items are always returned to userspace.

If we hit any fault here on the Nth item we should still return the
prior items and ignore the fault.

If we hit a fault on the first item then we should return the fault.

Jason

