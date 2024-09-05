Return-Path: <linux-kernel+bounces-317181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851696DA88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084CA288066
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5019D890;
	Thu,  5 Sep 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hxt+Auo9"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321B19925B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543655; cv=none; b=UbbxHN7/TYkswBw6jB8e/B9KK947Qt3dMq6GjlKZE98f9uJRSfpBlLyggFOD8pyNL+6JCyPupgcpjrKOt+eD7ftjQHQEG2asUUd7RyA4Vvz7mgrp5Gz2DvAgyMjQza+sWwRAIBRetEiqnANZ7szVsbTgyRVo+IwIUL6rU0h3jeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543655; c=relaxed/simple;
	bh=AxPtjHYuOVtkkcmxIcpgFsQxIf83bf8J45zt3NGqfPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCDfAqk0PymM8CGy8E6zz7N9As/+VKtHrHJCF9LyzKKJaOkkkSkbbFO+IP6Zeh1eJFT23q5du/W8QofEI/urL34+Nx17H6heCKVSxpcQlEQ/Pa0Sw4fkO09AYFgogcXRvn0jOJ7xmm8OkGHOH2jld02nDmL5KuZ0BUCxXESVW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hxt+Auo9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-456757d8871so5009131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725543652; x=1726148452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UVryk+sEYmFSRDSp/0MfOEJVaFXd2+NxfDVIFtGzX2A=;
        b=hxt+Auo9Q2mnPIpEYTjgMCt8kq1fxdATKo6fi5w1wEAZZt8BQqo77nWYbp0kQOwX7n
         dw479o62r9W1YqUDfOmhrQCNbgsP2MkoqLsjiG46JVimBLITL2RkgKM5yf377gEqjvfK
         +1Uz01KEL1kYF1WmST1iVluLx0DR4YbNdD+q8HPxoW2YJ9fjSrnWj3eDV9DULG/kXF7+
         8L0/2Khz7p0sVKBNvlT9LcAo296o2OZX9AGZ6zeLXDUR0AblqVhicUgoriS8VxNDWAZQ
         W+0LkV//xwkYrqrw40L/4CORO+vBavmDAHh0lBbzMOEAlE7sh1PUMpdBLe67rY/rvivM
         vAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543652; x=1726148452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVryk+sEYmFSRDSp/0MfOEJVaFXd2+NxfDVIFtGzX2A=;
        b=BC6AXmUA9bpSGx3nLu1LBtopOPj0nHp2gklMQFmWAAO0aimePouX2a7Xp4H5/McsL5
         V8K+CMrgL4mRb1mLG3zuM3WGBOS9nb/hgou6iKhq+Ts6PV4iodwq81Grx8aVE+P5QtU0
         kRiwhrGBFz3yKtWIysgKR0uOf8iS33cTgJvUolpXTOWgIQoHfEYhKNnR4vJsWMcMb3Xz
         k4G0vffmNp4L/GIron0t9uitAlxuJxZmLsG1VFCLxrx3P1MAyoVTmKovkjAAx64ptghV
         95qx9aRsicSjm5ozMY8BKUtvxfBXX74ElTrGX3rKhHAmpxcl3IpYACHW1m2GKWbAVw/g
         xVkA==
X-Forwarded-Encrypted: i=1; AJvYcCXhp4r+Z86QFgB+krIkY+IcAlmQwVW4gsrAPCWleloyn2uvbS0y+4cjqCp2ebfehz0C5FJBfkD56XWLvkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeC03lMjvAxPuBdWPqhL+Aqls0GygMZMcGW2WC1f2Oo9qyI64s
	t0aHek+Oi6VqMORA2onuPvE2XxQfzPoEA9nHvco2ybhxJIkugqiMTY8C0Ubjkj8=
X-Google-Smtp-Source: AGHT+IEUdiC6y6FiD5Qy2DoUR0vrZOWliBVAargS1d8t8110/9207+SXKsATbVvJ1NnKgXhpPCa79g==
X-Received: by 2002:a05:622a:420c:b0:457:e3dd:498e with SMTP id d75a77b69052e-457e3dd4b3dmr105811761cf.9.1725543652193;
        Thu, 05 Sep 2024 06:40:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801dc366csm7138601cf.93.2024.09.05.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:40:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smCjD-00CZyU-0k;
	Thu, 05 Sep 2024 10:40:51 -0300
Date: Thu, 5 Sep 2024 10:40:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/vt-d: Use PCI_DEVID() macro
Message-ID: <20240905134051.GA2994907@ziepe.ca>
References: <20240829021011.4135618-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829021011.4135618-1-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 10:10:11AM +0800, Jinjie Ruan wrote:
> The macro PCI_DEVID() can be used instead of compose it manually.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iommu/intel/iommu.c         | 4 ++--
>  drivers/iommu/intel/irq_remapping.c | 4 ++--
>  drivers/iommu/intel/pasid.c         | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

