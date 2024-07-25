Return-Path: <linux-kernel+bounces-262212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3293C28B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5821C20EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907519AD7E;
	Thu, 25 Jul 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kKGxnarw"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F5199246
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912330; cv=none; b=GbDpY9FrmStkJnJQfU4kU/8dg0Oola76diUTb0tA9kp9Kb3BrRYTqv8Nhzt+V1YzKjJ31WxRfzNoLt4LTM2m01jJhDTbYBs3RUVRSf+vz11Pyc2XOAmA71JR4A81i6Hw5ahdcOr1iL7XJxB5/tNlUg3uftcErCKT8A+6x2yrlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912330; c=relaxed/simple;
	bh=ol9QeSXj3jLXnW607BTnItEsLO3rwJkVUILiSBWncic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF8YE59P0xbj14CuLHTmRHAGBZga97ipBvNYPFjP8vG71V8PiC9LZVnSZVSYsJblDo3cMk5R522CBaTVdqr21CnH5SZNPkhCdeOALpZNuIYY7puk4aYo7nkJlmeorUx+nRnNvBe4PCuqggELax04m4XiH50x+07IbrRec/LNUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kKGxnarw; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d6f4714bso54066285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721912327; x=1722517127; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XTnt44Tc3tOs5dIbjDK1ckNp4sIhauYdQ2vBo3NA//A=;
        b=kKGxnarwUMpBrhs6aIesz/pp4+tN4k8ZQu8H/prFEs+Yeu0kCk5MgnuRzVPtu8zK2B
         EPc5Nb8djcKfJN/UVe1E9kJ7cwC+Xaisv5gy6aEBa/UqyX165XZ9JBLnakTtwYmXfB0w
         zgK2jcfwuvS3K6Ohvqrh/7WWaX2L3nWwHVVpgSUQl01aFlCjDo0nv3ea60jd97zBxYou
         QqM+azz8Iieb1PHdCnBqqpm8PME/c72yJlqSYomQPnAzIIe2mGl9XEviD3LD2L+Xzlzm
         hzBh9kzwnARtZsLs/XHluBl+B4TyOh5yloi1P1wUZwGuG5wtbWeGw6RWTzrZdyo0mvpW
         65Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912327; x=1722517127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTnt44Tc3tOs5dIbjDK1ckNp4sIhauYdQ2vBo3NA//A=;
        b=GzRJzIHO76x7UuDSN7W1C7g48BE78+TiKXIn7G0jbvvBCSIZeJDv02PXoEhVuq3nJD
         EHQDJyhzREg8m/6Zs5fIHIP9Ap7h/0PeznIhH9WoN/MwibFH5/bm0oAiUQBl3wl6u48i
         gY6urYTo15739zb7svj43MHrQApnc84ol2tPVJ1Xs0ZpbWeRf/p+QuR0Dya5rBEXkXFX
         YTazLHi4zvx2MP3oifX9zV0onjAF32DDfFfrLx/LKzrG+qr8F4DwpQX43i3sQjYI+rDO
         5ZyXdvq13IDZStWnNS0U9Tb6pH2/boKW9kYcseu8ENc2Tw8UiIeQ/oZG8LBAQRYFjnQB
         UkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7kbQIAhFZ6mEVNpgwce8mjObmR5Qp2dhCaekY5MhGbjN+KKODYgPv1zXu1HcQ2huuu1+rLvxybaPm3Jccei4QXjTlA+9sYR7rTOSk
X-Gm-Message-State: AOJu0YxI2fZ5QZnz7G8yH5E32S7mmkX6UyN49Kps8P/Nkj8dc3i5tr6w
	tNWo3MOLqk+WRuQkd59q4ABeuS9sk4EmJ29HzQTansIrqD5Iquu4j+3JklBs06g=
X-Google-Smtp-Source: AGHT+IHx9rnGlQN50s/n7MK8EdztTlSHMdKXKuhSXvi0+wTmEqSX5ZDNnlHTYeBtpQqod+69XKwLNw==
X-Received: by 2002:a05:620a:28cd:b0:79b:b571:4c06 with SMTP id af79cd13be357-7a1d45bb73emr455622385a.6.1721912327510;
        Thu, 25 Jul 2024 05:58:47 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b6030sm79668485a.52.2024.07.25.05.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:58:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWy3R-00Haxy-Ku;
	Thu, 25 Jul 2024 09:58:45 -0300
Date: Thu, 25 Jul 2024 09:58:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"tangnianyao@huawei.com" <tangnianyao@huawei.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240725125845.GA3030761@ziepe.ca>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <20240724130320.GO14050@ziepe.ca>
 <BN9PR11MB52762A8455449C6A432DA0BB8CAB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52762A8455449C6A432DA0BB8CAB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Jul 25, 2024 at 07:35:00AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, July 24, 2024 9:03 PM
> > 
> > On Wed, Jul 24, 2024 at 11:24:17AM +0100, Will Deacon wrote:
> > > > This event handling process is as follows:
> > > > arm_smmu_evtq_thread
> > > >     ret = arm_smmu_handle_evt
> > > >         iommu_report_device_fault
> > > >             iopf_param = iopf_get_dev_fault_param(dev);
> > > >             // iopf is not enabled.
> > > > // No RESUME will be sent!
> > > >             if (WARN_ON(!iopf_param))
> > > >                 return;
> > > >     if (!ret || !__ratelimit(&rs))
> > > >         continue;
> > > >
> > > > In this scenario, the io page-fault capability is not enabled.
> > > > There are two problems here:
> > > > 1. The event information is not printed.
> > > > 2. The entire device(PF level) is stalled,not just the current
> > > > VF. This affects other normal VFs.
> 
> Out of curiosity. From your code example the difference before
> and after this change is on the prints. Why would it lead to the
> stall problem?

Because of this:

  	iopf_param = iopf_get_dev_fault_param(dev);
  	if (WARN_ON(!iopf_param))
 -		return;

If you hit the WARN_ON then we don't do anything with the fault and it
remains uncompleted.

> > + * and the fault remains owned by the caller. The caller should log the DMA
> > + * protection failure and resolve the fault. Otherwise on success the fault is
> > + * always completed eventually.
> 
> About "resolve the fault", I didn't find such logic from smmu side in
> arm_smmu_evtq_thread(). It just logs the event. Is it asking for new
> change in smmu driver or reflecting the current fact which if missing
> leads to the said stall problem?

It was removed in b554e396e51c ("iommu: Make iopf_group_response() return void")

        ret = iommu_report_device_fault(master->dev, &fault_evt);
-       if (ret && flt->type == IOMMU_FAULT_PAGE_REQ) {
-               /* Nobody cared, abort the access */
-               struct iommu_page_response resp = {
-                       .pasid          = flt->prm.pasid,
-                       .grpid          = flt->prm.grpid,
-                       .code           = IOMMU_PAGE_RESP_FAILURE,
-               };
-               arm_smmu_page_response(master->dev, &fault_evt, &resp);
-       }
-

Part of the observation going into b554e396e51c was that all drivers
have something like the above, and we can pull it into the core code.

So perhaps we should still always abort the request from
iommu_report_device_fault() instead of requiring boilerplate like
above in drivers. That does some better.

The return code only indicates if the event should be logged.

> >  	/*
> >  	 * On success iopf_handler must call iopf_group_response() and
> > 
> 
> Now given a return value is required we should also return '0'
> in the following path with a valid iopf_handler.

Yes, that was my intention

Jason 

