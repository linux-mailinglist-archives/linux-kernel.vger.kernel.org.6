Return-Path: <linux-kernel+bounces-285293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1986950BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB862816A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373311A38D4;
	Tue, 13 Aug 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g5ysmiry"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CF1A2C32
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571822; cv=none; b=byXOv88eO2VUhRl59oDHx3ul/v33eZQXJc2ALa7f1yL7HKEhchxGHToaj2Ym9OuyZcBMxwyz0BKUNuc36q33kxdrI3inlvh3wFXO7nJyREx/NvN2lNLFvMCHjJgO0F3aNM5v0vohmhl/Em3CcV3WxzUU1aKajhBur5EEWLS84Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571822; c=relaxed/simple;
	bh=757LLvYh7tCy/Za0nmABifBJAXzCB8Y9uZkMalML1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvO0pmD2x9q2V2e3wO2ulpmqRaD5FXb3hkxcuEqFnCBuiEzZTtNjuo0MSe1wsmADWWdlye4Fa7Ogcy0xDL9d8OtQMC+xln1vN2QlYV9tTNTUlnWpYIY0THFAHLCUD0S6oFjVLy95n++toHXJ+0F3IlG1/O7nNCSS0WNQoGBuTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g5ysmiry; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso37910726d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723571820; x=1724176620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqHCv1f37dJdFmlxfLDwmGn7VkBUztlhPRalJOl3Txc=;
        b=g5ysmiryuLrvfAKoSHoFlunF5Ak/mXEWobK0dBdZniSYb0iD8/EFf3ssDMDkPERP6H
         Ih2YyKAk0pIPZ4mh+khVjLV24Du8sRXMD1tkord34INDg9CE68gw2qFLVpXlQE0rb6Al
         ctuZgSWq20iyK2iFwLyOeLzVhtvTjI3t16CtlWd3kXJtevl1xLCG7bZZRQL+BOYG/vHU
         7GowgLUbF7HRTBl/qMGqjkdnXcoF+E006gyDRGfA8chs4cB+dMVjgpEPr3irtJ6hgm0g
         h/s9Gj3jUFzgUvJJMB1hXdguCRH+3nL/M0FrwP7J0cSEJJL3JahwrS99ojWJI99c8fN2
         LzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571820; x=1724176620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqHCv1f37dJdFmlxfLDwmGn7VkBUztlhPRalJOl3Txc=;
        b=XI6N1/vsV2Uwe8pdpXyJCxxKsb26KZ53pqlbkO/p1M59CDbHt1QAS+WlhRgCBbsqf+
         qFrk3njgXJtTmwA9H+nWsZFwU5sedjlQPUa9QzZMb0sC800Y7ef5IEpV6ugu6w6edPnR
         ExJg0NJ2P4mVWgOh2BB+Be05P9kv1cYFCO021V8Jw0y+EdJJ7wJdKsf5xk+5l07svYzF
         W3V72UPko9syqNPiFaWqsw2VS/hlPoCORSxAZvxa0hvuw8kHO0pPo0Do7XukeMe2oFm5
         +Myv/2qiFVxqQxdqsfA2qpreazFc5JGqE0CaeKKhwIXI1mLZ08dMhKDGWwcXw0qp7JyV
         kZjg==
X-Forwarded-Encrypted: i=1; AJvYcCVTnAKSp4G8bYMyKiRRfNK2ZrdczHlr8w/KhlB++7cqaILIAY0WEDc14OKDe466InQFcgOUUzGAMOVTpg7/LC7K4Q9D+mUfiEejAQAZ
X-Gm-Message-State: AOJu0YybvmPeh3h5Ldy/p8/NzFAGKksiZTQJXfs/gbuBWH971Acv9ImL
	c64P+zGH8/NzaF5UUgNtPTXu1M7FqLCl1oEb82R4CCNU3fhbHEe+M7LWjByJ7w0=
X-Google-Smtp-Source: AGHT+IF0ahYqaweAPCwsOz0r2FqFsLLNlBLP+hAUNAK3I7TnTFqEVk0JoImTkYUd7Un7vFvQodQtow==
X-Received: by 2002:a05:6214:318e:b0:6b8:5afd:8f89 with SMTP id 6a1803df08f44-6bf5d23f9b3mr2429676d6.37.1723571819915;
        Tue, 13 Aug 2024 10:56:59 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e33ec9sm35691786d6.77.2024.08.13.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:56:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdvlS-008pOM-3A;
	Tue, 13 Aug 2024 14:56:58 -0300
Date: Tue, 13 Aug 2024 14:56:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240813175658.GO1985367@ziepe.ca>
References: <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca>
 <ZrJIM8-pS31grIVR@google.com>
 <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>
 <ZrTNGepJXbmfuKBK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrTNGepJXbmfuKBK@google.com>

On Thu, Aug 08, 2024 at 01:50:17PM +0000, Pranjal Shrivastava wrote:
> 
> Kunkun -- Please try this diff and check if it fixes the problem?

This looks OK to me, you should send it as a proper patch..

>  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> -		report_partial_fault(iopf_param, fault);
> +		ret = report_partial_fault(iopf_param, fault);
>  		iopf_put_dev_fault_param(iopf_param);
>  		/* A request that is not the last does not need to be ack'd */
> +
> +		if (ret)
> +			goto err_bad_iopf;
>  	}

rebase it on -rc3 and there will be a return line added here
too.. Maybe you don't want the goto in that cast

Jason

