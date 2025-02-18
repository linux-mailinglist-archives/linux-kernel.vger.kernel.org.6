Return-Path: <linux-kernel+bounces-519893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F59CA3A33F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842263A6B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006426F462;
	Tue, 18 Feb 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lOW6ZBdW"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4226F452
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897597; cv=none; b=qReglYDnTy/orOm72FAVi5qwZ4jH2lUxvxybNfzB4V+LcPgYABYPRvTZUaiEZmuorlE6Iely3yzM2hRPyIxSFdkh4W4ECLeFf5vW2M/uW+AbbbUKYIjtDc3/DzLBG8DYGntYKwVV03daKrX31W4B52YD4pWTN0EOIfIZy8Wmv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897597; c=relaxed/simple;
	bh=JN+vmPozrfL53NbfbGS/Xiap+yTcolfIfbz+5mlE9OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcpvVIfpJBR8RDdLH+gnbb2X/A+UaSQpa/6qcDuw48109fWdFIC589/GeKmbLXVXSCoOOAULe39z/mYjQuQKsP5CEQNkL0QjD8/IJoDW06HfYNeDxyztj88IP2Ci7RdJy9EAIVHOTCCNKjwUEqgx/3m8GcGIHh0OY/LwvKKTYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lOW6ZBdW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso101236036d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739897594; x=1740502394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JN+vmPozrfL53NbfbGS/Xiap+yTcolfIfbz+5mlE9OU=;
        b=lOW6ZBdWxfmNuDYFUfHCyRoLuZGu3Ao8xuQ00vrXl0ePAkoRCDKYR8DoE7+LVurVlB
         cnUPsY9ZSzitQbrku0IS5xDVgGznc713SENK84XUwPHjLUkBk8YfrPb/vVfTLhxQJEkY
         d8GOJwH0K4zqGuAYX9W3GP+DhA/9VlrpLV4YK4Xi6zBEtY4aVBoGyBwl7cyqBX55rTdP
         fop5b8V+L/kkH4BDXxS6idZvVUMpYupvrqGO1KngDrGeLuxS6Rm1h0PoVZC9kMS9PxMI
         g9RTGRiHI0R0oNrB2aAKExI74MuOw1mRn6y3VLQmEA3ftFF95P5Hk6J89jGKBvq/lcZT
         MDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897594; x=1740502394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN+vmPozrfL53NbfbGS/Xiap+yTcolfIfbz+5mlE9OU=;
        b=vJ84G8HXEjMiqs55yRMxQgPwsjbizyi8dJjD6cNvsYGyQw8NSwInPKuybMAGmyoXVG
         bd7wSw7BQE/RlFXEdkc7A+B5ljmxa0tymkiiuVeyQbTLuCiJ8w4UQAlz/R+aD0K6GWfs
         p7QTJb1RVmVhGhlZ6ePGNWh3H3OOOSbZA//+Uzoeeaz/E5rzvjZ/Xx1GjgycklVNB+ec
         ydKy83DvDCvpkXA6lRJtXXe49U0eJz9TQ8wgBSsJ64CjJV9XA2Js6WSTIYAj1BirjCEQ
         2qirvMbJFuSAOFi0vS1YnjNhxXp062GbQGb7RC4NMm1zlNuHFUllc+EmCHktTE7MRTB0
         80Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVvv6mES5wM3C6frSQgi93qpuGmAmf09933LdiAXwGDm51HlDSVDx4lm5080fvOELY3uK+RKntPy7Kr3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/3ZH0sbyabWLIzcqJWD6AHWeROZK8LYBW4LXJho6Hl9zOtEM
	rFX8U/xwpvksa7q1eTNCsAr8tE7+9POoNgvb4em/BKBWzImeu1HeOE8Xi6DV6m8=
X-Gm-Gg: ASbGncshSzhKY1ClxiN6dvJd2Iml/nNVbaDIaZQcmd0i98yE9y6hcOLB//xn3eRHImu
	rrqASeWiXsFJdD+xc4AxveTwYm2vfM9tbGJ4vZb0LpSzCXQQOaTNK9N1AIHSX1oKIr97EC/u/N2
	/fcVSZ6zj8XGEuEWvAGp/Fa9MTOZNwluj3NYgw4Bs0AfB6B5WZMebJNCvuYY9px9aX6BjUXeVwi
	lpx+lHN+I9YLdN56JSvA+sYr3dfk83Bh6LyMlkuwfTYnJXLrLY+fK28IBU527p5rCAhfSKTU6rB
	Mds6E8CudsDRGArC81uhIiv38Pgy5cvargk/3y9rXtKl1XvDZYr2Q8GbumWeTYzd
X-Google-Smtp-Source: AGHT+IF4ueE9/T1SsRmpMnPF74ga1OvVK9kyodfV6ipyhxushK/lMBjJL6RWxuF+bbMy3ZOnH9SWRA==
X-Received: by 2002:a05:6214:20ad:b0:6e4:6ff6:bacf with SMTP id 6a1803df08f44-6e66cccb3e8mr226386376d6.19.1739897594138;
        Tue, 18 Feb 2025 08:53:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c87412fsm675156285a.101.2025.02.18.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:53:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkQqO-0000000HX3t-3bwR;
	Tue, 18 Feb 2025 12:53:12 -0400
Date: Tue, 18 Feb 2025 12:53:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <20250218165312.GJ3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca>
 <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
 <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
 <20250218135751.GH3696814@ziepe.ca>
 <CABQgh9F8BJr_bkEQD6s6DSsLw2jwpgq-p73YL=439_WwH8P5zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9F8BJr_bkEQD6s6DSsLw2jwpgq-p73YL=439_WwH8P5zw@mail.gmail.com>

On Tue, Feb 18, 2025 at 11:25:59PM +0800, Zhangfei Gao wrote:

> I have tested it, and it solved the issue.

Great, thanks, Baolu can you updated the patch?

Thanks
Jason

