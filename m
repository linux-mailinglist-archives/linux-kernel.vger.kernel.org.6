Return-Path: <linux-kernel+bounces-234733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB691C9E3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77EA1C213BF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C74BA34;
	Sat, 29 Jun 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dNe2wlNI"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E624C99
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623509; cv=none; b=d4SysKhGMBNR0Ft3Ft2smQSWwp24juKjxdYXbiQLtF9l4xIXO/dR5p5XejiACGT12npgYIO6Tz5RJWIBLqXSd3fJWdQgdJTruCnTlDJoUHIz400MGOqkpCVzzGWHidOnkrpl1ioREAVSOul1P7y0Cul39i8G64sGD0ebJTmcymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623509; c=relaxed/simple;
	bh=0qHl+0DqNRpvSKTfp02INWgx8IbLG3jiIbFjAdPVnaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZprcFCyyVUNxap5XnFgStas0JNH4+4I2LO0KeY+BD/Tn51rhdhigQ5akW6DTBy+1okLw+qD6EKKVqXHZy/pTDtK0/jHpWsGGRx1t5dVTv9T+5JBWq55CziLuKC94nPgf7ifcfMvl9pQqAR8A7GP9OpLmVQh7zbaTveXaQPzAcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dNe2wlNI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066c9741fbso992758b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623508; x=1720228308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWMM+W00ZGyNJkSp9eBep0aP7iOumSA6mBp+eSCZ4g=;
        b=dNe2wlNIZgVEMjnOwAvHbfu47LZ1CelvTCch/fdEufOlaiImGSD7yFpLlajmSeD0Ic
         anWJacao4cVVfBBkLbw0iUu6CjRZt5dFtdu1bZ3JZ9uB8csGi8jYDzXR5lvALs7qk3HM
         JasB1Ih5bdYP97zahvRJSyfRctcHxtyhSmNwlfiW6PMXx6988O29K61UhzphmMYZXwyz
         32GN07oii8dL/RZPk3Wv3A4nNE/wr8gl/HrbLxKRh8yxzGM07mWyOrnArhFI6orx6p6K
         i9PVPjoW5YVZhuvnBso5PIj88zs3MOq/WZHCMK630cvU9JA6jxZD46U5O23j1NsXdMSi
         l2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623508; x=1720228308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhWMM+W00ZGyNJkSp9eBep0aP7iOumSA6mBp+eSCZ4g=;
        b=UUmuPGqbnMg8PbjEYQESXJnQbsnTHGYli8YZnIszgeNTpSVtgsMp3LjB57HNGlIDUF
         vOCCV5A/+tg6SZlQU3m+bODt6UXXsM40J9VVYcSz4gMXIBS0MgSHQdzRnTEsPOEheKzH
         nBELHbQVd3QcKTjCi4rsMZI9KDDBySVATmRMbf+Ui0NwQB8sk/KmvWTlthI7Usstym8c
         igcOKUd9QkI2387P6AKwboYW2rA6Z1KxBqDbM3Dq7CjmeGiEqTJcZ9LUS6DGfEzrP4n2
         1Y1fSKeJrBJVtA44/ZmcneZSfs2plZMxwk0g9Xa91FWApG4psesiN/P26rRd+kxf+wW3
         pFBA==
X-Forwarded-Encrypted: i=1; AJvYcCW8EjWPeGVXbD+xJs8rxCTIwItRW01DqS1JEWXR5CPrsf7oybIeFE0+dDssdWLb5QajKO+mwwLmsvOKagg/ktgOCBiG1c+hABBH1m+7
X-Gm-Message-State: AOJu0YytR1CY5Uka7ChhGU4OUkh+lOexEO0tVSZm2kmWv2uZdWDdqSQH
	ucmgNy7m7AJTqAG2qsNf9SEiwLhEdgpv05uAj/8nWvQ4yUo6lrbb7inZj91ogs0=
X-Google-Smtp-Source: AGHT+IFV8W1dqzQexTf6L4R/t2BuL68I/iJC437XoQYe9jmo2sb2vcOp8E1T0SgaT9dJjMWIhEFnUw==
X-Received: by 2002:a05:6a00:9283:b0:705:d805:2168 with SMTP id d2e1a72fcca58-706745beb1fmr26156318b3a.10.1719623507953;
        Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIyF-0004Uj-H8;
	Fri, 28 Jun 2024 18:17:27 -0300
Date: Fri, 28 Jun 2024 18:17:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <Zn8oZ80p0p1bHgBC@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-8-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	struct device *dev = idev->dev;
> +	int ret;
> +
> +	/*
> +	 * Once we turn on PCI/PRI support for VF, the response failure code
> +	 * should not be forwarded to the hardware due to PRI being a shared
> +	 * resource between PF and VFs. There is no coordination for this
> +	 * shared capability. This waits for a vPRI reset to recover.
> +	 */
> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> +		return -EINVAL;

I don't quite get this remark, isn't not supporting PRI on VFs kind of
useless? What is the story here?

Jason

