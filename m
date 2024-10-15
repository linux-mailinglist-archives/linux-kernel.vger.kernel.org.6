Return-Path: <linux-kernel+bounces-365819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962999EA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A421F255EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CB1AF0A1;
	Tue, 15 Oct 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HsLRL49N"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1221C07CC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996533; cv=none; b=hpKLD85q7aHjGhpjqz5J8Zk+bEke4LSNyDqp9Rq/5oZZkiLNcaA48TEystbVOVBR92zBm36fAitESbmk2MuDZeclANdX9MXwaKsjS40xMdB1vW/PVPSHhzY8Rj9dKe7RVrpqkXbWqbqots2gnT3ZIkvr/p7deNfGA/ViaFibA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996533; c=relaxed/simple;
	bh=xv4oxzeLoZf2P8oJquHhc7sTymUcPArbhn84jCettC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtzHX1W5NrOvuKAsA8RH6jJSW8hcytPu57AFryErmfE8JUqPmhlbzjMKoE2ww0XvbbcJtZoO6oROFFtFja4ahs9FOPG7/HYwNf9IXMA3cfoEUs7tT3F5I1wLh+06vAxTPFGb/xKywIeuAXzS8uOn/WQHQOW8rorY3PT3OFECK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HsLRL49N; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b1205e0e03so275924885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996530; x=1729601330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0LbqFnwstwONCcUk9HDP0yNXp/TQA5wML1UbSxY6v8=;
        b=HsLRL49NtCrg78/3uyA64QdB+BRafZFnGx12gr60GDQwpk9+7RBViUwbOnnIYQRijS
         mRgDP3b/dn95QVdvfY8FHBP9JtIrvMf4pVF9+qWsXY1DcnAUuBO7M4eRGT63xBxp4/xV
         4pvdESI04M3GM2dtnxaA7IUibAICSlz1GMX3YkLryLTS9fqpv+bd/stv6Kwf7waXJR/V
         DkeMRVHRrOO2hSoJLpjpvaZyIJyQmnmcPAX2hejUtEB6H2OZk/su3lAFVGpVPWR0+lfW
         q2M4LhBVc45zteRoN/rhn2j2iCjpczSqj6CNdTgghH7kD5fQUebcxk/WtlNCSqoN4tGU
         jzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996530; x=1729601330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0LbqFnwstwONCcUk9HDP0yNXp/TQA5wML1UbSxY6v8=;
        b=Gh8Bsf5+gWPPgDDE/Cf7c7A2+jyt2dQO2C+O3FCEl4Xbl/26agQQ6dnyLT5FABMfoJ
         E8+pRLBFWXemq4mGTmSpicmDYt2IH3kqFEKZB8z0hFODV5oNhvIZxuBfGbxvZijwdHwL
         Iztq1u+n898PbtEdCKWZGGi8t5gvNwkhyGTt9ODkrRS/PE5sWNd++j2nEYfW38gal59o
         wbUx+rGj1IiJY4P/Zs97qLsQpMpkDiYHSnzemHkX/HRgW70ejFX77Ivms/97qdXCgah8
         5GG/ISRhlucq2muecaDGTR3/ch6Tn7Bv4yn5CaI1Ss2uyEm26mfW8UWJ6Ttwu1T430gl
         CNzg==
X-Forwarded-Encrypted: i=1; AJvYcCV8U4QDxJZcc6DH9siDkdmTfZVJt0I93E+Cl5CRUxPJ5JYz1ztitRtkTjGxRwDMCJRlwz19RtCFtW7NIZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexxLr6Ty02IVbClgAhMhCtimocVZI/TSCf0eYBdYukNVLvlCv
	iT6pGjTOaHRJ5oU/lPQv7V6kT9yAIP7AKLLg99LwzOU8zas/UmKfPhP5WGySPwY=
X-Google-Smtp-Source: AGHT+IFfGrKb2jqjuhBXp45+Ef97XFQVZea+RfwF3v+6xAAVLEpIItEAvCxqERFCRQeeKiMz3E4FBw==
X-Received: by 2002:a05:620a:f01:b0:7b1:1cf6:cfb9 with SMTP id af79cd13be357-7b14189f662mr38898785a.55.1728996530513;
        Tue, 15 Oct 2024 05:48:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616e947sm67046185a.40.2024.10.15.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:48:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0gyn-00D2jO-If;
	Tue, 15 Oct 2024 09:48:49 -0300
Date: Tue, 15 Oct 2024 09:48:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
Message-ID: <20241015124849.GJ1825128@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
 <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
 <20241014192436.GD1825128@ziepe.ca>
 <a95e8a10-6240-41db-b234-d9f29386694c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95e8a10-6240-41db-b234-d9f29386694c@linux.intel.com>

On Tue, Oct 15, 2024 at 10:52:19AM +0800, Baolu Lu wrote:
> On 2024/10/15 3:24, Jason Gunthorpe wrote:
> > On Mon, Oct 14, 2024 at 09:25:03AM +0800, Baolu Lu wrote:
> > > > > +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
> > > > It looks like this entire function is already never called for
> > > > anything but paging?
> > > > 
> > > > The only three callers are:
> > > > 
> > > > 	.default_domain_ops = &(const struct iommu_domain_ops) {
> > > > 		.attach_dev		= intel_iommu_attach_device,
> > > > 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
> > > > 
> > > > and
> > > > 
> > > > static const struct iommu_domain_ops intel_nested_domain_ops = {
> > > > 	.attach_dev		= intel_nested_attach_dev,
> > > > 
> > > > And none of those cases can be anything except a paging domain by
> > > > definition.
> > > A nested domain is not a paging domain. It represents a user-space page
> > > table that nested on a parent paging domain. Perhaps I overlooked
> > > anything?
> > It only calls it on the s2_parent which is always a paging domain?
> > 
> > 	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
> 
> Yea, you are right. I overlooked that part.  I'll remove the 'if'
> statement and utilize a WARN_ON() function instead.
> 
> And also, I will rename this function with a meaningful name,some like
> paging_domain_is_compatible()?

That sounds good too

Ultimately you want to try to structure the driver so that there is a
struct paging_domain that is always the paging domain type and
everything is easy to understand. Don't re-use the same struct for
identity/blocked/nested domains.

Jason

