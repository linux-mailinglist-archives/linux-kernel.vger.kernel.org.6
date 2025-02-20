Return-Path: <linux-kernel+bounces-522779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FD1A3CE69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DE3189BA33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8A13DDD3;
	Thu, 20 Feb 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LpwcHi9B"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF74204E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013499; cv=none; b=u18iz9lkmKx1YmUSwWcxXZKVmWBDpGnYVYsEsUfGnkye0igQJiKUUC4WQ8pfwd8P2LdrJEFjH7hILocwa8KpfJs6nhr0xVhLUs5Pfn0gSGPiQq6v3/n+Jro9J8KNJWdn1QuMJPsveSUoQ5vMJ6UNzD/rtMzNqxfRLEDpCJmOBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013499; c=relaxed/simple;
	bh=JeYy4pG+I+Mr6dMRTEgew65StItnooXP7D/DpPk71P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPSVAVt4uTl6jnnvGa9v1Z8M/SzWlkhIs65ecvF7LF8f9dPQaIb5SsLbQ9YD7jfo9CR95FmOL6Z+XTw8qSzjgDDVdoeUl6789rU4YCdd9sCExOX5dpcXenzjwB88ikNbABqLulKxtxKhvaDY+vJ5YpIhrTg6DHgIttILTeX6oXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LpwcHi9B; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd420f82e2so4564746d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013496; x=1740618296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MWBwMxYKDvEMb5Nsgpje67CQl23BipqyXlvrUrw49c=;
        b=LpwcHi9BDOJSCJUWWYdK0brb0wEW5krsmflzW8JR4gvQvcv7jc6mRsXFxL3RumjwEV
         ZfMetsHRGgwVCn9xUVbhCQl3mh4XZ219KODBFpdvBqcSsXb7aLItgV1oUGMqP5nMCq5w
         KXk5DTR66oYBGGhB8AmwvWm0QKP4PCl35YWCOLRLUhaXdyYa6k0BzDP+ziR+AWkh4tdY
         R1UVJnj5UiTD9jyIvZuutmSth57XYxZtRy0VqTz8844MWeo8CBXJRoAnQahEb/VJvYmr
         5Ap6qS89RNgKU4OvRubYI1s5UZh36QqRgQSc1oPq6kKANTcw0UkMIUTpu08i3kbYL5mv
         4lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013496; x=1740618296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MWBwMxYKDvEMb5Nsgpje67CQl23BipqyXlvrUrw49c=;
        b=w/2SUP7UyBcqkgVSvn1rtZBaUs69iHSPb9BxhHumQDmTT4fMPrVqDK9kUrTCCCCSli
         600EofqAII/bHWBmgnuhAXUq8hbr5w31tHArJBxbRCfgtTGUDtP75hXItRiLA73t16G6
         QLWQ/exYm2aSC8y7h++HY4rknDpWIlTzned+1CQdw59lbWOsKdEk0MqojbdJXAFyrUP9
         Rg+6zQNW6kwabM9AMN5W09UWk9pnTsUpg9Z7GxkQRsP27DSDJj6mCjiOUrs69HJE+W1+
         BR9VnKcoPpAZ74cw53/Zc14+RjF0QiIZV0snX2jAU/fDayS5AQvH2cDSM6KstNGk9yxu
         Tjjg==
X-Forwarded-Encrypted: i=1; AJvYcCXEb4N15qix2atGuJSkypjJ/VfKxBbmCMywrME0fCxYGNwFENXviNXE6uDGHAVztft8QfwEnJNgNkgBBrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwakPtX+m/yo6/jGGil3wYuguySAmhu/vboQvZUAnBfx+qvwyAm
	08XMvoV8E0bYJXZDi9WgO0N4z4TLSB6NAFBqfHiHOhe1dM/gg81xDXOuTA/9rgs=
X-Gm-Gg: ASbGncszPO+ywEPtJC9T0ViSXpIjCNVHfSkik4PqxcsqelBmmk2hrVTndQiNyPebtdd
	/GZ/lc7ks3wWg62pc8vQ5F1qaUcKVZgVQmXP9RcuRZlpcOfLCFTrXvQLOh6Xg/sinqbt0DqaAml
	u9y841UimIIwi/IJJv88flJ307Vp9NJgKcyVL2x1omyiyBfB75fkgBFfZG2rPEaeFLDwLslYYGE
	zr1uxWnLT4zRVhveIoFfy6SRXCIkke7XR6VGAyWIV3kHVuAYIocmnhxN7u0bOVs78KeFtg98jcf
	baxNJwXYK5hz6n3JalpBhyE7NnN7N2Yx1qe8zOzt4FOpe7T+48Iiikn+UnfLDpv3
X-Google-Smtp-Source: AGHT+IFzEq0526xTcxemb2Cr+hRhWjxAyU9EvBZZD37sIHxTHpA3ldPJFUOlpPg8MYbowsx6pgY/ZQ==
X-Received: by 2002:a05:6214:21c8:b0:6e1:697c:d9b8 with SMTP id 6a1803df08f44-6e66cc8b653mr315657496d6.9.1740013496437;
        Wed, 19 Feb 2025 17:04:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daff4a8sm80630306d6.97.2025.02.19.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:04:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuzn-00000000D8m-2TxB;
	Wed, 19 Feb 2025 21:04:55 -0400
Date: Wed, 19 Feb 2025 21:04:55 -0400
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
Subject: Re: [PATCH 12/12] iommu: Remove iommu_dev_enable/disable_feature()
Message-ID: <20250220010455.GU3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-13-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:04PM +0800, Lu Baolu wrote:
> No external drivers use these interfaces anymore. Furthermore, no existing
> iommu drivers implement anything in the callbacks. Remove them to avoid
> dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/amd/iommu.c                   | 32 -------------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ---------------------
>  drivers/iommu/intel/iommu.c                 | 25 ---------------
>  drivers/iommu/iommu.c                       | 32 -------------------
>  include/linux/iommu.h                       | 28 -----------------
>  5 files changed, 151 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

