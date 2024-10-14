Return-Path: <linux-kernel+bounces-364641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB099D74F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6601C21429
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918871C761F;
	Mon, 14 Oct 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DkC4hHyo"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72F1C5798
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933880; cv=none; b=FGmfahvc8tJgDz6U6JHsRx25X3stGu/4CMcidzFKR8eZbIgc2b8V87nnp5JsCfUlzsbh8ZX+6gIE9ETtGmXoMVPelFxFnaByIrt2G9eRjHifF4a3LBFq0n1gC3uNbH+aNOp+3HuGOba2bUZS/3W8mMXwzE/TPI7ONV02k84VvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933880; c=relaxed/simple;
	bh=Krf8aUu9wJoYrroG/l+uabcNMWjlfsDG1ymMzmhkTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK6u4E6Nkz2E0o+LQAaPtJqWjKqicUICLZRL4UCH0RdKVNgfdYM8SQbWYUJ8bISc9E8nmgIn5KjwGXDB4X5QEojOwqdbs6NG1CG7Mi+n2qv9aYqnpOiGKUDjIMc+7iQWRYwFqSl2xBkoa0KoIEwSo5c7mSlueJBerweQAHZWTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DkC4hHyo; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28ff55468dso4705005276.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728933877; x=1729538677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chhtCPjzLYuNIHNBBWk7CoEmzEQjqCwVNlf9vMYQjEU=;
        b=DkC4hHyoKOUu5lqfT4RriCwsqzVTRVjeDUDB7hzD59kf1VLMYzdy6dyGoGiHRKpv9x
         Y3Qtn67eS1n/zOutNb2a5JEAFU8b+k5d57afZPmt18F1tG74HbzZvhvGS8D8kl1iARmq
         uc43s2qsWqFcXcowQtIYIQEx1uT0V/UFmtqBuk6BqGc5wS/i/LOOyUAfmGWLY/0eLpac
         hXyU1Y19xiBJTSCmspfiW+zSbs0zSN4EuQ6kTCYRUGex4xHpQjwoy6ILsif36Rj1c3UM
         /Jg9NqSOZDdat+ieY/XNVAVYhvy9oFxFrl2NrNBTZAwzLmK89iExmNDbmSWLrmzpr2C2
         y4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933877; x=1729538677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chhtCPjzLYuNIHNBBWk7CoEmzEQjqCwVNlf9vMYQjEU=;
        b=WTmjo2x8rAYWBK+/PLsGF826bOf+JT6EGkRZdB5fblWj8ocE32/NGsTMGXbLgQ93Ti
         geX9FlTggSJmq2sIPNST35HBNw+p++fBK57v0DNX288nifjy4JkOE8LG2fZ+Zw7UCbq9
         GdT3umWOCDyEOfmoBNDuXB0IVcTw4Gx6/i3Ucnzp66mnto4eKghEPaHwguvfM32KxdCl
         g7WRN+V0O08QwpVFf+5F2psvnV58+ySd8RI38a+UitdEo4GXxEFZu5+1NtJGwlDS8qKN
         iZplWzPdmfxrafb/GNDFWbf2oDGCeDGz9tm3JYHnIgRXa84bDLXiENLol5iDYez0fz3o
         g2zg==
X-Forwarded-Encrypted: i=1; AJvYcCVg1LfdyVgcLL4JTHmaO6w1nwcW7MuFcfF6eBMiOKzzZeBU0tZCNvIIy4X5uIWzq3C0DIwnQxkBhDyVgZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzarRv4+YRVd7PRGZWcNEVNQU14DexikT3EYCYm9EjnvXUF4BTA
	Uw8CV7X13bSKXdGboONvmWnmOr7fUmx2rAdzaLrM/t55jujwL/dCGs/IHx+QjmbwJF4i6uHoNVq
	e
X-Google-Smtp-Source: AGHT+IGiLMckZF/iDwtCPeOtlulkrsk3VgmFpLFFqeCWFo2lkhBdtTvvDGgrE7l+kfpS3rSDr/CbOw==
X-Received: by 2002:a05:6902:154c:b0:e29:2783:8707 with SMTP id 3f1490d57ef6-e29278387f9mr10259571276.48.1728933877447;
        Mon, 14 Oct 2024 12:24:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497ad55sm448982585a.112.2024.10.14.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:24:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0QgG-008ikr-0S;
	Mon, 14 Oct 2024 16:24:36 -0300
Date: Mon, 14 Oct 2024 16:24:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
Message-ID: <20241014192436.GD1825128@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
 <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>

On Mon, Oct 14, 2024 at 09:25:03AM +0800, Baolu Lu wrote:
> > > +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
> > 
> > It looks like this entire function is already never called for
> > anything but paging?
> > 
> > The only three callers are:
> > 
> > 	.default_domain_ops = &(const struct iommu_domain_ops) {
> > 		.attach_dev		= intel_iommu_attach_device,
> > 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
> > 
> > and
> > 
> > static const struct iommu_domain_ops intel_nested_domain_ops = {
> > 	.attach_dev		= intel_nested_attach_dev,
> > 
> > And none of those cases can be anything except a paging domain by
> > definition.
> 
> A nested domain is not a paging domain. It represents a user-space page
> table that nested on a parent paging domain. Perhaps I overlooked
> anything?

It only calls it on the s2_parent which is always a paging domain?

	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);

Jason

