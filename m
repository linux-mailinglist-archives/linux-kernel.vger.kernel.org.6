Return-Path: <linux-kernel+bounces-386839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F99B487B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76AC1C21564
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58091205148;
	Tue, 29 Oct 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R1GWK4Uh"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1B1EF0B7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202186; cv=none; b=bNXTltZUlpgWu4vSm7zmFG/IZrai4/Tawf/3MAeSfPKvod2/nNF+RF8H88VZYX1mCubgnzIPuhlONCmIy+sgZ0wXWTcEwvGLfg4uPxGmqSFXVOP/ABtiVRdr0kyL7S43ShBRh5JJOB1il3sckJIntyZF6HI2tTlms8HSGnLG+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202186; c=relaxed/simple;
	bh=s0NtxfN0YKYoxUnO3lQNTiob9NH9vvfb67Uvl0Fh7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwb32qfuuxMuwxkTSQAp3h4smm6MBbhMG/trhKVt/KWraw9mvOp37FH0xlpcUWSTUK7Nccl+hRA/9zVO+3v7tIVVGNCBjr38rm5bPuCPQtzyUahd8c3jfb1txdID7kglYbVIRV8hrXOcr60jzaZOaJUrPTC1bMVo5VYkCOy8byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R1GWK4Uh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460c0f9c13eso45305381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730202184; x=1730806984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvHsIFSTi0XZdx0k62e6OyvWU9dWkoQVlshw4U0DAXg=;
        b=R1GWK4UhIh9Um0F3Yl+J3y6/2tJ09hUOZY47GIY516re7XkES52KZAaciRTvJbY3dj
         AAcSz5W4b79i6i/OTmmwSTcbUVoHPo1cj19v9ghrS0Pw2nKmmrDWuY9048ZoiOYocjDV
         oZh9gQhM1flQO9wRdfCobSoTPK3souB4boAQ10hGVWTyDvI1BnhKpmY4WX7rimGDYMDO
         KoNLdhPBW3dmrjPX6YttEiPaLERq5g6y0aeM7yRh0Paj/L6ymFTPdoVxLGnZFFaAs3zx
         tjxn62X3qmphpYD1V2uuVckNnxYfrAdZ3yu2/Vexf+7bzp99JqsX0W1IXwhwkk+BD7pA
         yuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202184; x=1730806984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvHsIFSTi0XZdx0k62e6OyvWU9dWkoQVlshw4U0DAXg=;
        b=i7ID0tj4z/dIX2saETleCTYz4AvqxKyqKGF3z04lBybuKHhXCeg6Z3ddFy2Bx7dLlt
         2G6V3OkeROSxdfGehyYIn3WDBtEMClvEZfnSnmd+r2Kbgf5K3KUEqmDq8glocBRE8yDb
         bwfX1Jb3qG9BGqyB2ht2yyQMAmau2ta++WQrNYGlMVc9qwkNmfZ51NRmigIKxoqWtQC3
         if47kM2mILZk1nTgo7qX+6QPTkLH0eKC6j9n3iYp1PiTqxwBMrbjKx6o9VE2TqpQKPBP
         zIgf+ATPrka486+atxK/6oSwMLIwgUlo3M5qUXaiE3Fli9qhNQ5kW0QBknNrY0aCkbUK
         tLzw==
X-Forwarded-Encrypted: i=1; AJvYcCVP080ZaFpXK1IDJkbHvbgeYvTiz6n3YBPrJCj/IGl2OXxfl/NMlO1KkFdOSEcDzOsl3eEoLUBjc6bUGLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+nMEhMDdm6tim12nrdS7sc59BC9v/3x66JM0hyQqqNghwJgm
	qgkHwF7LksT5hEEWD2ltvYa7o8AHZJaNhkcMyx9MSVKWy5Y/hcooLDHRnsAiKUA=
X-Google-Smtp-Source: AGHT+IHB2/Bh0ErrimuBLBmKhlXWmOBNgnoxFGD8U46br8NjpRaYQXlpVMZjkh13p9UY1aPjaplOlQ==
X-Received: by 2002:ac8:5741:0:b0:460:3f3c:b3ba with SMTP id d75a77b69052e-4616814a7a8mr30157081cf.25.1730202183823;
        Tue, 29 Oct 2024 04:43:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323741c0sm43669641cf.61.2024.10.29.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:43:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5kco-00000000nXZ-1YVu;
	Tue, 29 Oct 2024 08:43:02 -0300
Date: Tue, 29 Oct 2024 08:43:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH] iommu: Fix prototype of iommu_paging_domain_alloc_flags()
Message-ID: <20241029114302.GI20281@ziepe.ca>
References: <20241029105849.52069-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029105849.52069-1-joro@8bytes.org>

On Tue, Oct 29, 2024 at 11:58:49AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_paging_domain_alloc_flags() prototype for
> non-iommu kernel configurations lacks the 'static inline'
> prefixes.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Fixes: 20858d4ebb42 ("iommu: Introduce iommu_paging_domain_alloc_flags()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Lacking 0-day again..

Jason

