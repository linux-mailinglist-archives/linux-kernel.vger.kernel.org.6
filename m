Return-Path: <linux-kernel+bounces-315525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7396C3AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF3A28577B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691951E0B86;
	Wed,  4 Sep 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q7wr0tvh"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D251DFE15
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466433; cv=none; b=JHoA4/aPdpLENRQH/tCEda2fthLYTEX3orY3WvPvDxfcARvkf20GpZF/BYv7T04SVhjHeYIJ3k0nWdJn5qDn1AkwCn9gPzTN3JsOUGM72IKyJU10PZKwBIejB9Y7hX06c1IJfADE2jV8icOcKGe+2Tz4dho4NYza73BzcvPOzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466433; c=relaxed/simple;
	bh=F0tflm8lUJEDxwwzpsOtmN1YD0WLfapvq+ZP3t3dN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mborfEd2JAbFbL+lRSaw3RIJ4CwgopxN26OeSrtgZWrE+I6J0bSwTeTEMy8rXR0f7QXWJVG4AW4YPrpuCWBYhvJk/wEAp+x8Nl2Qw0t7kM82F9/4lUJTycMGnwMMgTZyzLKarLKDfiqZWoFUMJqrmMkl+p38TRAUXtjZqWnNPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q7wr0tvh; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277f5c7bdecso1854981fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725466431; x=1726071231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj5mk/fNbVZIeIPVjyNKDlVGZrLoOf8EX02mwukEb/M=;
        b=Q7wr0tvhEymxKrRbV+8VtPfQ5FJ5djHtpzd1RiC+4lMTJ8vwvYrfZb70NxD1ayqeaB
         ECijC1Veyg8pGXigUIRyTth5LZs/ZogBpsoGTA9c9DV0uBYaYTPLTbFUUqN97IlgA9lh
         uYw2WmEDEPQapgnrgIFkyZ41HTZKOqGAEz8mSO0q39bFFR1P9Xs/IVDt+K7XDtaL93IE
         oasu4m9IfJRtXBAFuwqSX89xvrUULYBY1Nww+q5lzEglJze54bogygrXL+sMVMYJYhWt
         NTSPcHFdUq5Zv0b6s+xxNHMkCFgMVnkkzxKqjzHLbZMGuZjpMtsLozK9j1xu8i7ObAvj
         TBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466431; x=1726071231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj5mk/fNbVZIeIPVjyNKDlVGZrLoOf8EX02mwukEb/M=;
        b=Dl9m9Rd7c0iRGg3P+2yEszmDgROZSlvmD4QV+pBr1sFIa/2ztR97pVCtzOIoHxQ66U
         iBxuL8in1tK0cdY61cR/k2mfmiRp6TJxA4cuYziq6rLNMi8C4ERpVv/BakAJD5zgbT5l
         JpSH8dcRut3J26vgcwcAoSs//nfVKAIHEVFWeTHAeYMDwLXATad8x6upogLIGIP2RUz4
         HZSH5fWwyJ5BAxBcbJU1t6xiWX7ubP5MwFm6R8F2KAqOb1P+fNWd+G6txA5/4w4aez/1
         Yf/l1PfYnnvyTnHJMigKZ3SWfydcGo5WkrsOmKQDDIbV9h7wh4E2+HiMnP6XQ8QXGe1i
         WydA==
X-Forwarded-Encrypted: i=1; AJvYcCUIbx3oVfjbhDbdA+0aoRp6usQPWxEaAuKMEuW7e91cMdjwhXPVXl/hkVrdAwoFIw5FASAtqX/fTG5SLng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxH4YBEl1yld4CsMiqg0osyGeZSA1MVQsY7gj09eOSTYHV6uX
	QvnK6V+QqiYcBnCKsP5YzjpuaApo3a0JNp7yu8kr7stD7XOCW76hvY+YQcflA/4=
X-Google-Smtp-Source: AGHT+IG23YM435yb5+zdC+sOzZ47eKaCiwa4MpP1Qb9C9YZpsqWk7EV1Amt4nLH9b/uRuS3girT99g==
X-Received: by 2002:a05:6870:f10c:b0:261:211:9d14 with SMTP id 586e51a60fabf-27800506b56mr11670281fac.37.1725466431302;
        Wed, 04 Sep 2024 09:13:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d88943sm626411585a.133.2024.09.04.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:13:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsdi-004lkN-4t;
	Wed, 04 Sep 2024 13:13:50 -0300
Date: Wed, 4 Sep 2024 13:13:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240904161350.GE1909087@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
 <20240826135955.GI3468552@ziepe.ca>
 <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>

On Mon, Sep 02, 2024 at 12:48:19PM +0200, Joel Granados wrote:
> > >   Supplementary repositories supporting this patchset:
> > >     1. A user space library libvfn [1] which is used for testing and
> > >        verification (see examples/iopf.c), and
> > 
> > That's pretty neat, I've been wanting to see some kind of IOMMU test
> > suite based around a capable widely available device. This is the
> > closest I've seen..
>
> Yes! This is an obvious application of libvfn. Do you see it as a
> something that can be included in tools/selftests/iommu?

Maybe? What would it look like in-kernel?

I've been thinking the same thing with mlx5

Maybe some kind of test runner with a plugin driver that has some kind
of 'do dma', 'generate interrupt', etc sort of operations, IDK.

Jason

