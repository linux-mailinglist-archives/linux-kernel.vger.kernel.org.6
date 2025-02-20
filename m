Return-Path: <linux-kernel+bounces-522776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890AA3CE66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D7917752F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03950175D50;
	Thu, 20 Feb 2025 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UZS6idH1"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156D156C69
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013431; cv=none; b=dt7VrhK15edTs7WE0jf7y4MFoqlcCiMup7qaotMU+j3G5fCGZ7OxBYi5qehIUqw2RATN6EMFceWCEQS80wpod/rEAIaYZ3wzWn9qnKiIbkRMK/hiH1XyR6nKRkbuXKZqKTa7BnTVPvcCCxn/EOtUd4GjfBey9BaWvQFBh3QLiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013431; c=relaxed/simple;
	bh=OcRbs0Mux2+mvsQBoP/SK/C35tNLoYRRWX6CXINx8pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/sPkOPLB+pDOpb1gr/rheqAuus2pgkt9eiAvX2WcLnCo/I++lsu+T2x2LxUKICZ1WAJKe+vAv0FMlOtxJZGTq7fuVLVx87sFyyuPNKUqin+qhF6u0iiN24tScOGW/z1ztz7HmBuam9UIcqGoolp8iJM3+nhikaVu7A8b8VaC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UZS6idH1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e68943a295so3098006d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013429; x=1740618229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8g0odvNWuxjBdKX0oyrseDQK/1N9fYZ+BlDhaPQ2UqA=;
        b=UZS6idH1M5vTErJORA+tfal3AYaNeoKXrC3ajT8Ywd5mWBnHF8gR/nnJPZcOxHD4Zz
         5tR/k2GDblNLGOLS/bSiZbS1TY32GKB5L0ftTP8skINaI/RFw0QOmEGMtouei7BOZBxY
         7F8ylQgMWBwgAE4Z9zkceYjv5OEVHWBsRh6ZJYHadDz0wPiN/XssfgL0mns4qpO5tB03
         fuGoeCyU2i3NwQwAP/HdzQu5eiHV90nGcCKSj25Wk3Q7WPXiaG9FpUJyFBwTZyVJvAJa
         FFfo/vcMakJhNOqGPfL9zjh0qJbkmVVgnk3ue9hgCLOHjEhGecO0gGes4+hb1nhQAz8k
         kaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013429; x=1740618229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g0odvNWuxjBdKX0oyrseDQK/1N9fYZ+BlDhaPQ2UqA=;
        b=gV9ZhWoqBtIp59ZSxH2INL9goKWxIvm8hXOBe8KMZqNt+f7AtoPhgnSvuW7rYkyV0h
         CwTmEsBjYdoP/kjKwW91US+LDRtj0sSBIVFrmzOtDoItZdJk0wvqyQY31ytZWjU0uD6o
         +b+9NdwqdesgOEbdn/DxIwO8T37OQNzeS0W7PTntHAifjk7WtvSAuDPYr6tsxgnxT68T
         WDReU4T5UdYoQIZBrTmAQPjnA+xd8JQ/PpDUviLiS+4d3+9t7UnEqzZxeF8vfMwdqE2R
         u/s5SE7AwZXhpNs4ZbUtlZVS88GSabzH/oz/ikowhrwxfiujfe2EXXCIUj6C/zomyu+4
         htKA==
X-Forwarded-Encrypted: i=1; AJvYcCWP4EbI3tmMUT9D0ewq1iA1yNcraXjti5T3tRtXdbt534zbWOSWMvAncEwqC9NJ2OFVH+Dx0xPDrEpTb2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwP2uIyIAT8Lml8G9WaiPVKklCzWJMAhc+mObU5e9c1jljfW5e
	RMW7LzF1JbeZ/SCi8jf3KUplWGm8E9rJFNbM1XlEY6eeVO89GHDy/2nd0Ju3jwI=
X-Gm-Gg: ASbGnctem1lWu/Njt4UymCTr8CqWM0p54LyC3nVsk3PFPDVkMaZmTdZ/ua1iTGQ3FHJ
	GtPZsY6x/5g2C4KhAM3zLJTcxiKSQOGS6Z36hyqoArTtiNW7dGPi+KaYmumQEsnweUq56NEvF9Y
	/kzJ4FJOVCc7eIXJypWJ8VC++2nuknDg4qyLrGg7Y1p26q3FCeeDwBAkouSEJreQSTrbja9YX7S
	ToreHk3FS2IvLj2lt2poOSm4sCTn+bU5p8KT0Ul9/Rl7drXLGUB2o86DQCYWmZoC3k6RK9ZyVw5
	wsH4UsF2JZMPsBwAv7+uFaioq3gl/HHn7KCWMvnJ9mY7tPmNE1DTNXdRNyQYcrd7
X-Google-Smtp-Source: AGHT+IGQ51agWvygAJ6arkMUSoXHWOrR8ZGhqnn38CdfbtD8muJx789k755yxRMiQLjZ9SKySGEwnQ==
X-Received: by 2002:a05:6214:5190:b0:6e6:617c:abb6 with SMTP id 6a1803df08f44-6e66cc7febdmr308640816d6.6.1740013428938;
        Wed, 19 Feb 2025 17:03:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785bdbsm80468916d6.38.2025.02.19.17.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:03:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuyh-00000000D7v-41Ib;
	Wed, 19 Feb 2025 21:03:47 -0400
Date: Wed, 19 Feb 2025 21:03:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <20250220010347.GS3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-11-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-11-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:02PM +0800, Lu Baolu wrote:
> None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF anymore,
> remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/misc/uacce/uacce.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

