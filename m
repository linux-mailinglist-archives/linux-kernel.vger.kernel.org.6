Return-Path: <linux-kernel+bounces-321673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C3971DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056231F23B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4719BB7;
	Mon,  9 Sep 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y9uV9B7s"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624856766
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895007; cv=none; b=DPFYqO2CBKE6MY/um9Ou+dU0TAAfspHPOou4B+nJxDQFuAy0BLiU3FGLQha6d43ebv8WeY5yVVOU7Pa9gCTNOgOJaRfgmdOOwNUn+nht+skUgn3QwrLhhx0VRCnDvK8wqZ0VAyWuEax/PXkQGcCiEkQhBa11iKg7iYAbH566+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895007; c=relaxed/simple;
	bh=NigwiX9GPkklY+FWgvafDxLI2iZ5t043LZM4XHkFuzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UINWHpd5wP8V5c/0cnUnYY0+C5HmuJed+UT6zDTQKbvhzFPqEHBkV7T+TmWOOt7sh8nALcyj9fEJwbrmHgtVA3vwxY1EXUafFfbNfd8SOw7DWDG3rMJwDODU1JL5lSkAUp47bye6u1Qes7bs0UClIUjfbmMfjg5iYcU04NIO3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y9uV9B7s; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a99d23e036so201121685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725895004; x=1726499804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv9PZXsGeVNEOOgsoLAol6p/TXegiJsqpqgXCEhA5Lk=;
        b=Y9uV9B7sqnSIG7sg/sqbM3TdWy5xwX+yynLyiORdNBN7HblzbS5p8bKeUijw+IxJUt
         klBPdWMZPQTbemCTB164o8jXvF24ce9f6CDeYv+Lj8vJYHEG7SZEFyAFrM5JRtO/JjzF
         dH8Lcn08IEIT5iNYZsP47zBskglNDg3vU2Ga8NmOzdN7x7oBimOoYM4qj4bd9nrDUCdE
         pcxYb4V5DDA4WugTLzgUFUmjXmbIN0s4yIKbaS3KPdAqx2eIIqGgO2G4p4iNBrHUvOSD
         869THOawzaMvH7bhUpFAOJ0wZnAasqE4erVtU/3jp6RF7fSmvYzHBcI/H/H1ERS9gdfw
         Z8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895004; x=1726499804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv9PZXsGeVNEOOgsoLAol6p/TXegiJsqpqgXCEhA5Lk=;
        b=DWdNQ9hrSnjB5wttgHPAdR/WrLVGSeUtJODfWOIripKFBxVLvGekrxu1kq3jqc7bom
         BZJH1X2tHXWSED46v8XMorvefUgmBLErH1Y/OuJVPV6Er5UkXnzvHDvGzQiT7GGF+am6
         2qpEiOY05vQgo25jbrbwMAIDNTuwHtvZ5X3JDvja95OjehIKqoDlUjor1uCqA2PWJhih
         A1k1pDUMBhI+BZKRpIS8TdYCnE+7wY893utPfQrD26OO38N0cCU0Z0dG3VXHsmMozJti
         /cS0Mj2EDKLRcGttrrEkSID8heVbkWdH+BmF5t0iK/7A8vhe9fAWj+ek9welyoyaHmNz
         F5sw==
X-Gm-Message-State: AOJu0YwCl71sJmg+AdBeNU7ugcWPPvseGDNTbqss0D0ZdpvKqG06c83C
	K2mgSKjFaiDwISGhjSEzO3VpoZmXJc7OthSZg5LD8uHeh0y62XMLvNQkES+bhHw=
X-Google-Smtp-Source: AGHT+IFNb27YabbKzeMBlTUDF4KAD/i6OpwMBhHui1bFORvetJYA7EwypW+iYf68E8PeXFUVr8hOGQ==
X-Received: by 2002:a05:6214:3381:b0:6c5:18ad:b47f with SMTP id 6a1803df08f44-6c52850dcc6mr142805316d6.36.1725895004346;
        Mon, 09 Sep 2024 08:16:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53477c27dsm21509746d6.129.2024.09.09.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:16:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sng89-000jZU-Qg;
	Mon, 09 Sep 2024 12:16:41 -0300
Date: Mon, 9 Sep 2024 12:16:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B
 feature is not supported
Message-ID: <20240909151641.GC105117@ziepe.ca>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
 <20240906163818.GK1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906163818.GK1358970@nvidia.com>

On Fri, Sep 06, 2024 at 01:38:18PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 06, 2024 at 12:13:04PM +0000, Suravee Suthikulpanit wrote:
> > According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
> > in two 128-bit transactions or a single 256-bit transaction. 
> 
> .. if two 128-bit transaction on the read side is possible then you
> need flushing! :(
> 
> For instance this:
> 
>   IOMMU         CPU
> Read [0]    
>               Write [0]
>               Write [1]
> Read [1]
> 
> Will result in the iommu seeing torn incorrect data - the Guest paging
> mode may not match the page table pointer, or the VIOMMU data may
> become mismatched to the host translation.
> 
> Avoiding flushing is only possible if the full 256 bits are read
> atomically.

Also, please think about what qemu does when paravirtualizing
this. qemu will read the DTE entry using the CPU.

For your above remark it should be reading using two 128 bit loads.

However, it doesn't seem to be doing that:

static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
{
    uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;

    if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {


The dma_memory_read eventually boils down to memcpy()

So qemu looks wrong to me.

Jason

