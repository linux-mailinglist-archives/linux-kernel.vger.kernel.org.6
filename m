Return-Path: <linux-kernel+bounces-334334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0897D5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9424F2888BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978D16BE23;
	Fri, 20 Sep 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JvY5OaKv"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F716A94F
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836879; cv=none; b=LOpXXf4kycuU0eDNsU8yYCPk3kzX3eJZeqFDjHs8dS3CXggrryx5UeUvp7ZblS6arCkz/mv6pu5L1vWBj90fPq1TozfwJYl7C6iX5ZBormuf3wuELWYkb7hBTnVbs98zEQ+loeHoocIEPmI6S9wROb/sJOyZrs3f3B9nRKeoo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836879; c=relaxed/simple;
	bh=92w6dv+VseI/pBpQZrtGVh/yup0MAZCj8HPO1uZ7qiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmEYqbnYtQ6Uymv9P5yXVtrUE9We/kmtsAm8jnaEsHodievy1bivt4ay4xvgVlVjFF1RUGH5+6qbirf0UfIzBscIxbNKZqvzXNBCe8ClndLJE70WnMezaSj0b/dfxrKy63tGiJBIqxl2L5R7JacJddu1ZVtduBzkCAhXOrygW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JvY5OaKv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365c512b00so2449715e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836875; x=1727441675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxOJXXuTPtJD2C97fiCxabtfgKFUIiIOX78ur33VM08=;
        b=JvY5OaKvuz1aJrzZJHVBrE2o00vDCTX6YtGXQGiXVs4Qh15hBx+QNbUSTnyqT+WU10
         woRgrT4SbatG47PCTH1UuBieTZV+vGNqGGWR5dzv6IZ20KqNtNVy2HnNnok8nXhomIKK
         9bHsPCZJBPj5OPE7t4+hu5/z4xbY/SNSBPA2jUB6eZzwx3q0lBO2ahoAH9eODB1UBbGf
         ixMY92MAHXm032DubA9AbiX3utQ9pa/mPV6EUBffeQRFsdT1OTY2/l9twySCQXszCKxM
         zVQo0yS2lpfgHYCvAcV0HTtsGFO9bzRXW+oYbCZmzVR7lfXmHX5UUdWz5mnSsfeO0MYF
         BOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836875; x=1727441675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxOJXXuTPtJD2C97fiCxabtfgKFUIiIOX78ur33VM08=;
        b=q+SIacdfRBMexfs6hx94YqGXHzpOD07rCUFnLzuKs8YAqTl4Urbdd6KtqGsaXOxKT/
         6hi9UgW7isEzD48ETvmcuSq2e+K/kdNRW+k2ksXPTSF4go+M10ZEf/sfYX2c43xw0qeh
         PA9pfS/8x55Bwrh/UsS2cEMNrI6b0K24ErYHR/KRwgn0x1ddP3DY518Z6EYa4CyUfqvn
         QqTKy7npkvbW4TkUECiwuQzfIVSxmqPB/t72tHsQvNF/l3UJXU9e4eUstDyfCchfdufG
         pPTO2e2WSGd2Xz9xVFlTVXRf98yKmdZsdAv/vsyP40+tK5EyVDGLWt5h5agLb219yAPY
         fZog==
X-Forwarded-Encrypted: i=1; AJvYcCVipWdOevHdGYv6BDItaTnQMEFbjS9wj9UK+uVhn6DfzvJEIjgCYwek8qRszYw37wpbH0Er1nJsgq0cAl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcqAboMSBAbqza5xZSpf++O1zmJ1u38XhoY3NIuhabm+991GP
	ciVTMLAAnaZ0VVZe1VMWOmOUis2IeomAg3YUhnxwpSTu7fkrvV62Zm0T+x2d0Es=
X-Google-Smtp-Source: AGHT+IHOG14KF21RzqtJPgrK582YmG8ObcTpDLjYz0OHoTRqntbt5Q6vcnyU0BwEDB79I9PC0gWfDg==
X-Received: by 2002:a05:6512:acd:b0:535:65ce:e901 with SMTP id 2adb3069b0e04-536ac2d6791mr1966041e87.4.1726836875496;
        Fri, 20 Sep 2024 05:54:35 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb497adsm7145406a12.14.2024.09.20.05.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:54:34 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srd9e-0001AK-AT;
	Fri, 20 Sep 2024 09:54:34 -0300
Date: Fri, 20 Sep 2024 09:54:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <Zu1wim6MZz3rkbWY@ziepe.ca>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
 <BN9PR11MB52769D1D1FEA9BAF0E6D19718C622@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c54a15d8-fe60-480c-9156-bd77114c196c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54a15d8-fe60-480c-9156-bd77114c196c@linux.intel.com>

On Wed, Sep 18, 2024 at 07:17:32PM +0800, Baolu Lu wrote:
> > more than that... for each IOMMU the current code allocates 16 pages
> > and 1 hwirq. Those are unnecessary burdens in majority deployments
> > which don't support/require I/O page faults.
> 
> Yeah! I only focused on the kernel binary size but ignored these system
> resources consumed by IOPF. Then, perhaps

If you care about runtime overhead it should be delt with by
dynamically allocating the memory and enabling it, not via kconfig

We can dynmaically add IRQS in some cases now for instance

Jason

