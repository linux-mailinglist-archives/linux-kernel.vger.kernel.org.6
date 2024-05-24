Return-Path: <linux-kernel+bounces-188783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C518CE6D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A461D1F21983
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCD126F04;
	Fri, 24 May 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h0SYFVy4"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084112C473
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560221; cv=none; b=JzXJLyI9+j1yUfh7AX85ZBW0fE9oAwXeV5dFkyd9XEW26zTXC5md6nfPgC7AIy7ipvkc6sJDgvj1PiL9exg4Isoa26z7qrB4Gq/vjomyYxNRpATCoEbNfZNw011X1wdDKRabAFZbrM8+gs4zY7+ZW+JB6vAVdH5GIoZCawmN//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560221; c=relaxed/simple;
	bh=801tCOV5OAv0DZm2X9cQ9Ugasii44hxsZOXOquLuSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdU9N7YG7LUdbvRx0UqlHwsV8zHX2ZEJhE+veVtOgNrBDmprOxNl9fhcfWQ2r50B3BtsiAGZS3Z3f34H/ZYFAyA3taFtPq8NRV7s/8mn8rUu5R5bT83l/NuFVo2EGy+HdDzler+0Us+3pMlSQ2FRLEhp/O039apDLwEdOcd6aVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h0SYFVy4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-794ab4480beso65498785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560218; x=1717165018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suZw9oB6HBTqRgA6OrNMLSYpruM3XqODKPk/UHtyCxE=;
        b=h0SYFVy4hLqjBjxuf6QqsSt6tF/a93RQPVnIawHGMUprLO4RqOwJrJQTgSANGS15VF
         2+viWvX42W2H2G9yCvePBOfHJ3oDfaxgYp4NMxmBombSZl7j2QKJmWEVKUCq7Hlc8slz
         0vS/wibJ8NDpuXkLMACQGSxm523af0o18ffhuw5b3YW4c4qTTjqTLGi7yJ3uKcY+fbmA
         KPGPjl7gLUBYvqTwbVskaWDmsGWka/wQtORVV+RiZ8/JkhoPhcdhSFDmjiiC48xWVBF0
         L+EIrprPNxWedstZNAfsjlLa6zxaRnTSuaMJoTJN5DEC3Y8LYR9kn9n9EUyunz4cV6Vv
         FuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560218; x=1717165018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suZw9oB6HBTqRgA6OrNMLSYpruM3XqODKPk/UHtyCxE=;
        b=GugTZL3UPkbwCwhPNmX6G1moVqR9jgQ7BYdrfDb7SKqIvvJhatqMucsh3C2tb22UJT
         1n92ilUUUXsZ7Q4gyNX2s+mDfYHfOILy27wr1rbfvcnhcPOb16UmozNBCKFEnew3Ssn4
         bzQz6LLzwPU1UxU7JBA5lejtql+H89ipTBlAL5XvxbQn2/tAy2DSQQTJ663spL3CcVTY
         R3GQWuiHVJkZZzvbTu6RW4xBv9uq9x9wsCi3frvSKvtUhfQzfRVuTSzIkPS/7v+trPQY
         K7gVOzkX63Xns1W92w/raUJguUhzIWwOatrM/Rk9TcwyD+9cnthCeSDBtQKt8aP14qat
         9sLg==
X-Forwarded-Encrypted: i=1; AJvYcCUlkgSwIioyDzkVNQImQepa4jS2jWGBTnQZU2wswG96mlU9buVjibsKw05FiUym8vukszMhS2fU/2Tkm1ZsAXiNyWL/+jwCVVJEiu0Q
X-Gm-Message-State: AOJu0YzRUpiOPwcYth+v1qL5ytbXxf8X73rv9HSW0Wxv2r9dJESlGya2
	3vtM2qmbnXqA47Kck7Q9H0Cmnu6tNBKga7eCTtbh5v/vjU6+s8Awf5CnGxbPzq0=
X-Google-Smtp-Source: AGHT+IGJz8qoEDJMKsE3K/mi44tccE8zp05AFCzKA8aB112w+RpaAl9TlJZS6IYNjZCyNnjlwMPUfw==
X-Received: by 2002:a05:6214:2f09:b0:6ab:86fe:514c with SMTP id 6a1803df08f44-6abcd0b1f1cmr32057116d6.38.1716560218580;
        Fri, 24 May 2024 07:16:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dab0dsm7645576d6.34.2024.05.24.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:16:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVj7-001Jqp-Hy;
	Fri, 24 May 2024 11:16:57 -0300
Date: Fri, 24 May 2024 11:16:57 -0300
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240524141657.GO69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>

On Mon, May 20, 2024 at 09:24:09AM +0800, Baolu Lu wrote:
> On 5/15/24 4:37 PM, Tian, Kevin wrote:
> > > +static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user
> > > *buf,
> > > +					size_t count, loff_t *ppos)
> > > +{
> > > +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +	struct iommu_hwpt_page_response response;
> > > +	struct iommufd_device *idev = NULL;
> > > +	struct iopf_group *group;
> > > +	size_t done = 0;
> > > +	int rc;
> > > +
> > > +	if (*ppos || count % response_size)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&fault->mutex);
> > > +	while (count > done) {
> > > +		rc = copy_from_user(&response, buf + done, response_size);
> > > +		if (rc)
> > > +			break;
> > > +
> > > +		if (!idev || idev->obj.id != response.dev_id)
> > > +			idev = container_of(iommufd_get_object(fault->ictx,
> > > +							       response.dev_id,
> > > +
> > > IOMMUFD_OBJ_DEVICE),
> > > +					    struct iommufd_device, obj);
> > > +		if (IS_ERR(idev))
> > > +			break;
> > > +
> > > +		group = xa_erase(&idev->faults, response.cookie);
> > > +		if (!group)
> > > +			break;
> > is 'continue' better?
> 
> If we can't find a matched iopf group here, it means userspace provided
> something wrong. The current logic is that we stop here and tell
> userspace that only part of the faults have been responded to and it
> should retry the remaining responses with the right message.

The usual fd-ish error handling here should be to return a short write
(success) and then userspace will retry with the failing entry at the
start of the buffer and collect the errno.

Jason

