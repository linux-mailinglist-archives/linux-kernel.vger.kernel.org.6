Return-Path: <linux-kernel+bounces-361495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930099A8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315CD1F2491B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957A188918;
	Fri, 11 Oct 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KTm9Kgbw"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33E195B1A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664316; cv=none; b=AdsI7XVZ9+K0JOKSBhaB2NYSDAznBBhxR6V88VdXs8yfGEH+GNWPz4j7T6G9OrSvsIM8zQ7BNFWmLYmfpoixNDZL41azBMk0tSQZKR5geZokrJnpqIe7+K9RpWcsPz1ozMOFKgvGHc1x5jG/GkwVHMB9nGblJqTcQLAaHXFWkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664316; c=relaxed/simple;
	bh=woSR6Y75fZOeQBGQO24VdwIFZvxkz6FLKJFAaRwMgJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR9+7ZMC5ZlgMSDU5IgZ/1EMYbHty288NgZV1pou2wxTAsX0DS/CK4TwSo23bHvh7G0OU2f70636tIM0p0qjDS8ny9IN+HCDcMMb1jX6Zieamw7FaoS+O3VidkiTxG6O84+HU0dZGa/yk6gPGC42cio7xSV5tIPNsVyPqN7Glbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KTm9Kgbw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b11692cbcfso130709285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664314; x=1729269114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwEPzyjMz9lNyBSEKsUJavhwQs/1hDwuBWtKqgoIY1I=;
        b=KTm9KgbwCIOlSpLNcCXj8w0vHqi650EpoO3o2wxifvLlrQwETISXdS5YuE2GZrGO94
         t4Be+ggHZE9QIcMW/WfViEjszuOHksjpyiFNO051U3Fk+JGEqzQL/8CtFOYbqk+MKLId
         Wh9d/tG84+JOYbcRNqYrQN+gQTc4EGyOZulcy1+ueJCZ8l3DAVM0/WEqJAvE1KgusQFt
         z4yrbJhcfzDLO3yIA/fs7GGl2guTLVlfzPKR8ZwdwNwVs1tCg7hj/jF7l7kjjJvR/8PG
         1uTyhfhQAoX0d6uoIdkG+gTDaKJF937FgkI+5uuEskAC/q8UvTEx/DQGtfw9mj6fmo4A
         6gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664314; x=1729269114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwEPzyjMz9lNyBSEKsUJavhwQs/1hDwuBWtKqgoIY1I=;
        b=sbPAQwXkcr9lhHuCCmLUcEWTGP5nk36v7ol1z+l85iVnxmw77C9pbnvkvDXAwCaH33
         82nJrF4WsGCtM5rRiWUOnJ7m8ebh205117EbBru1QVy/tDKs8b1YluRqL4jO9T4hDJdZ
         lVdvZZjcvobuTI1o6dugAsMsNVUGND4LhMwZJCSz8relt3p6pfpw7qqt5V4a2+i/A95W
         UvTETCHOPHpm0pLIkXa6cS6941INbGzQZifBosJBOrajaLKt52WKEDuM5G409IzMTf/a
         7Ld7wr848ra1PJNuMYQVXShGphH/Bt+nW1/YHhwEjW3orqFIKzL9rYB0r96LTayWkHih
         5MPA==
X-Forwarded-Encrypted: i=1; AJvYcCX7aWK5f0DX3dI4WYNTu1qiHaAZ0n/TxV9oJiUh3iy9fuMT+z6ml4K5ZlyYkuNGbKfFfEpEIQDNg+p4QFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/u24nDyxLXknqeZKv4Q+5+IaSsDoKQOueSSrkL6ti0nJUw2Xp
	/vsoHQ1jXMZygDQ6Yglhtnrh/2d4cRtabZdHoOgzYyduiT9YHJRdrMc9PdYy4JY=
X-Google-Smtp-Source: AGHT+IFSqYpeyoL3JBtt2icvevdHUOGvDnGIXVpy91lCgbjPXgn3EqB0Bri9z5CcvXC6KNpLC2+w8w==
X-Received: by 2002:a05:620a:2622:b0:7b1:1cf6:cfb9 with SMTP id af79cd13be357-7b11cf6d056mr281355985a.55.1728664313746;
        Fri, 11 Oct 2024 09:31:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11c0a8902sm55860385a.31.2024.10.11.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:31:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIYS-007eRe-Rv;
	Fri, 11 Oct 2024 13:31:52 -0300
Date: Fri, 11 Oct 2024 13:31:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Message-ID: <20241011163152.GP762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-8-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:22PM +0800, Lu Baolu wrote:
> The domain_alloc_user ops should always allocate a guest-compatible page
> table unless specific allocation flags are specified.
> 
> Currently, IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_ALLOC_DIRTY_TRACKING
> require special handling, as both require hardware support for scalable
> mode and second-stage translation. In such cases, the driver should select
> a second-stage page table for the paging domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

