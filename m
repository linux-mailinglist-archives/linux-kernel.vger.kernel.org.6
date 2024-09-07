Return-Path: <linux-kernel+bounces-319783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7A970229
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1802842A7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4215B12D;
	Sat,  7 Sep 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hsSM6hd3"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B97155CB3
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725711624; cv=none; b=lmJMLRkC6oErjbKdREFaavYVCF1nztpnhLmQP9H/FOal7d/kLKCv2jBGnEg1/S+B1xuT0ES5qxA9W13D7oSK0MUipnHd5ihuPX2hPwNPu5Zvt6YipKBz9RrxfdXEDttPE6o7UITu7Mc5U7wKtEcchyXm8B55oyENMPQXXRdHZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725711624; c=relaxed/simple;
	bh=23b5QUF86rTmTLWdEmIRMcy4qYGQI4Dt8E6pceHHrFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPCG1dY2CJMDti8OznOmnC+Fs5Qyr+Ml0YFSMin1u+bZTWhFwbdwmeuxK9pHh1tlPf1x+SQPbenpepdd1nah6MVOX4ew5usW7OE9IGA2zng5tmqurBbKDNpChvBBnY4Hz20rW+yAD/DGNwk2a28+2RSJJnyCmRkoJ35RX/GfOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hsSM6hd3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45821eb62daso3503331cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725711621; x=1726316421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrfZKMwhUBII5rQ5V9cSiTUYqeiY+7c6ebw5rFPM7IM=;
        b=hsSM6hd3E5hwQCQyd6I9hIVjZNKhOJ0Hn72Z5shbwtqgZyiUXOf8Iqrld7r6Mbmkzg
         vaxyKqLOlosvVAqFM3K17qR3pM5j8WR1kexIRK0EdT6HWob84vZda03/lOlJ2K6BPIAk
         Kor8BDl7uVHb8FCvKA69vHLy7Sihm2fmbPCi85ULu05xzWY20+WZ04uUADgNKc97ziHN
         qtSyC8pAVHh8w2nEVzCixZgjmj17apM4LMMJFKiIIU3Gw6PHHs7TZUjMxg9K/+hSoBA6
         JuJEbEGfPvuhSWw/ir47UZBAtELpgj2HhmDEYigqBCS42VuxrN4HfsFikLl467nhgiLm
         yfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725711621; x=1726316421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrfZKMwhUBII5rQ5V9cSiTUYqeiY+7c6ebw5rFPM7IM=;
        b=htIWGUpHuMtoo0AetfWGusnqa+EbGk64rTfN6gXQ8WnTEmrGvxme5PMozYDSF5fcdt
         W0VdZeJCW1xNjykA0BlkZ4WEvtRIRU5NhydSJHqS2nrfJ16u1ZvA4bAAoK/s8p1cFrFK
         ox/WQooL032rE7hW8ti9fsfzdrBquc3Gy5bx8d/evJguqOys6HWD7FFWsGtJ8r8Htx/o
         1cCCdWVVlwfLBJv1n6kIL7N5xfMOTdzgObxcgYVeFSphpBiWYyJ1kGxw4Lkb0AhlM1YK
         yjZ4MTsIUFVOfPgOtGiTsD0Ba96N9gAiCdzVcl8VQYgQGi5j9iOsgMQZKGzP4DgjnnJy
         sHxw==
X-Forwarded-Encrypted: i=1; AJvYcCWiHHMwvAFXSPvwoU8pmdT4jkNW9shDwrsMrBlEqILSMqg37AIAzS0/ZFnUo9Csx3MvdDkivXuVF8Tyy+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbng18x3r3Xa/RQ/5GkGpe/+n4QSQw82ccLRNVllxhjb5QeJ9
	uqBmG9wZgTPNXt96Gi1Y6Q/g8KhfeO2S29S75fpS8oSSy339PaUWiuSqlZhbf8o=
X-Google-Smtp-Source: AGHT+IFc8nlwMAWVD4j4Rq3jwoqFGBPOSR8Rb8xebsYZYNleUkXX/b/9NqqvEPl8AfWpvsxBtC57sg==
X-Received: by 2002:ac8:5f47:0:b0:458:fb8:9dc3 with SMTP id d75a77b69052e-4582012724cmr31153961cf.25.1725711620892;
        Sat, 07 Sep 2024 05:20:20 -0700 (PDT)
Received: from ziepe.ca ([24.114.87.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e633b6sm3919851cf.13.2024.09.07.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:20:20 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3. with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smuQO-0001OI-03;
	Sat, 07 Sep 2024 09:20:20 -0300
Date: Sat, 7 Sep 2024 09:20:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: j.granados@samsung.com
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 3/6] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Message-ID: <ZtxFAxM6QQBYVSJp@ziepe.ca>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>

On Wed, Sep 04, 2024 at 03:17:14PM +0200, Joel Granados via B4 Relay wrote:
> @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
>  	depends on X86_64
>  	select MMU_NOTIFIER
>  	select IOMMU_SVA
> -	select IOMMU_IOPF

Does patch 1 still compile if INTEL_IOMMU_SVM=n?

Jason

