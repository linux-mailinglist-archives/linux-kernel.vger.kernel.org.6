Return-Path: <linux-kernel+bounces-364638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F40799D746
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80A2B22D56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970EC1CC177;
	Mon, 14 Oct 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XWk5V+SZ"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E151CBE8F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933813; cv=none; b=BUI0mJrz+C6OpZP8Wj7Q9dLlLrVPiDBwq8qDRrhTLX+HQouTJT/siIwwwSAZ17bb3ZXJ1hiYA92MFxTEAXk/0+UAxEeKjLp3gY1La7Yo67rN9Ets+qEVjaco387mPH9TbLeevavU5Yv3N5UtwK4D652W0fI12m/djYgItvXsEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933813; c=relaxed/simple;
	bh=emeXBtwMn6DtEefBt6yswSxVk1ipftom5++LZf6LU6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pro3/ztgGeqYcaB0jXkSwWk1nRX0LOUqDcvNac9rtH5+6hlU92dbb3Lk7v0c44wdNVBKfr7MQOuIA2Fz5pKMjBrCnKtdPiJX0Tz/QASlNEdeQE34FJ2gmgoD5Ex+tu03xXG+E5UItzYeFL1LdvRCr2b2wo/BW3caApTJvCIwlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XWk5V+SZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45efe3c46b5so53691931cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728933810; x=1729538610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBhUds+HaOC7zQKJNy3XXJqe6YYOt7fx52YpM7tyG20=;
        b=XWk5V+SZ2C0z9+C+P0ThdbVJtGDU7YBUWkKHy5sMrz5MZLgRj4Ct1GW8uqlXhe+Xul
         zyPDMGyOiFGhL1MozIn9T/yOyXmUJs7xvnfKNz4jLje7HOlrtaooIE97nz2+jCw82cHb
         GQbz+5mOOEgoByAOr5dKTb0BzK3kjrCTUTOl1CETS65620yKkrRjsrz0FSaMJKrCgty+
         cRsi4wlvQMdaTeXASpKoznZyYJAZ5Tz/7Th6DZvXS/sQnFkulJZld6rbaLVDdEpX/ixP
         7ZnloFB3Fa4i5BlBOZSfyFSWo9kn2UnxrRzJOBC6ShQJ9+nuM/UYmtlr6h67Uqj31qNS
         E4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933810; x=1729538610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBhUds+HaOC7zQKJNy3XXJqe6YYOt7fx52YpM7tyG20=;
        b=Hlfa5FsJotn3MNPA8Z2aSyV4LHS29h7BL9DnkqqlaZYY4TxDcwnkwDMqDj2MobQwRJ
         ZjSVKwOr1l+T2JMN4hciTExkTJa4UqhrdECPjw0jL8Ofuk1/aYtbY1qWsyFVRZS6jlAL
         RGpEBGiyULCe5KTGTRMkIVJstf3szSx5GnVHZ2dJrE25eVtUV0x5Bp/8RuVDzP6dT407
         cQx5GjukFRM/FPZVDY0825y0h3Aj0Y4MQwGt6R30ggAWKNePCAUql+aagBrGMeBevc6v
         RQT4B6+k/+kDc0sm7mTkPFFDIQquq8i2NtxEE+3eXALQgJmQ81Qo3LeEsmTxUUveNZaZ
         XRMA==
X-Forwarded-Encrypted: i=1; AJvYcCXn1INx1W3HJ1i205UrLQJfO8UnbRYcXyWUDVrjURzFYw5AaiXzE8oIQsMxUsKFyaAl3cXphAt4rO/j8Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWcIpb1swk4YnmTaE6wBrz/yVQaT7Kuf/myaZT3vlYZ0Tu5eP
	G6taQzgYUnNA9ciwSYo7CgkZ0jXlIGzEuU9kPVl7zWnpDBoaXkIeRuPvVJ6DZP0=
X-Google-Smtp-Source: AGHT+IHKKfmRJFjO/sDfGl6CDPUc9QgdAJYQY99MHUxI4Xfg2C4EirPx+cp9a8iRn8S8ajuff68K5g==
X-Received: by 2002:a05:622a:11c8:b0:45f:a04:3d84 with SMTP id d75a77b69052e-4604bbcf77amr191886021cf.29.1728933810210;
        Mon, 14 Oct 2024 12:23:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c767esm451679185a.20.2024.10.14.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:23:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0QfA-008iSk-Of;
	Mon, 14 Oct 2024 16:23:28 -0300
Date: Mon, 14 Oct 2024 16:23:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241014192328.GC1825128@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
 <20241011132252.GJ762027@ziepe.ca>
 <b2926672-216c-49cf-abea-9848aa52f109@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2926672-216c-49cf-abea-9848aa52f109@linux.intel.com>

On Mon, Oct 14, 2024 at 08:53:36AM +0800, Baolu Lu wrote:
> On 2024/10/11 21:22, Jason Gunthorpe wrote:
> > On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:
> > 
> > > +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> > > +{
> > > +	struct dmar_domain *dmar_domain;
> > > +	bool first_stage;
> > > +
> > > +	first_stage = first_level_by_default(0);
> > > +	dmar_domain = paging_domain_alloc(dev, first_stage);
> > > +	if (IS_ERR(dmar_domain))
> > > +		return ERR_CAST(dmar_domain);
> > > +
> > > +	return &dmar_domain->domain;
> > > +}
> > With the direction that Vasant's series is going in, I think this
> > should be skipped and instead your other patch to make
> > domain_alloc_user (which we will rename) a full functional replacement
> > is the right thing.
> 
> I think it's too early to remove domain_alloc_paging from the iommu
> driver. Vasant's series makes most of the paging domain allocation go
> through domain_alloc_user ops, but for those that are non-PASID related,
> it still goes through domain_alloc_paging. So perhaps we can clean up
> after both series are merged.

I gave him a few more patches to finish the job, but yes let's not
make them interdependent. Just make sure this series sets things up so
we can delete this and the _user version can do everything

Jason

