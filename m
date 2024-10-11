Return-Path: <linux-kernel+bounces-361473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C499A8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D481F23235
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC4195FEF;
	Fri, 11 Oct 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mdJLL1/R"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA41F5FA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663470; cv=none; b=gFv4GOu1Nn3S6Bwym8tEslYB0Z9YjAkb3Fy34/pSsmMSPlC69KYtoNEye+svIVdMA1P+TuG85IMfB1V0AkCgbioBe9ZtTgN5akjpzY06vjs4blvsp5XBAVIs4Mf20QAxI15O1Uf0IJOCZr1CTVtf6U9gi5QZTgkb4VZB66xqVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663470; c=relaxed/simple;
	bh=6LHOnL9js5JpiK6Up4Ip7xSByYfXX+0ciPYwyn8Ual0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thNU86ZD9lVS0dF/0lv/0xEDO2A9UwBmJxdqXLblBcA/Ef773INX1VkCi6+xyP714h+7Ea6mOmq+un/Uiw1bXDOIrZCWFbymivsg88QDtuILnezgnu89NZvG5gSs8lbIt1vJG9nSI/SvNCFfl8R7R/jqB7zybefTpJQ+b4NqUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mdJLL1/R; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbe3e99680so11185556d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728663465; x=1729268265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UKpbHrZYVo3z7RG4GImvYUh7LTzAZY0h9E01fy0uS4=;
        b=mdJLL1/RwXTNrdf7YHX3KhowppRCPQLoIkwYRfL/Rg+MfpM3nzP2DBIQliMUFzUK69
         XhWxPAaO/Rp7IzW+2v/EXU+u48H5attkLnbrzbIK0aGSJ+RAWZsklMYuakfgnw8DtX10
         Qg1A1aLuBPVKb5NQzVnfa1Xkj6nDTRSN1GzabAbV4Olq/0M13/7gn4jacoccDfnYdcpU
         gQB9nuvnjpWen4UU09CDC62YUBmCTHvieYcGGaCqD2HQmNLOnNhBKd+tiuVeoo9d+2MU
         0L86WHFN4d+14DgesSQ6E0pBx5CMk/x/c/Aqvs0dc11ql5S071xs+JiccHNMEcVO2ABE
         CMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663465; x=1729268265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UKpbHrZYVo3z7RG4GImvYUh7LTzAZY0h9E01fy0uS4=;
        b=WOawcqVIgZRyxqbFOVcpK89TXTINJeLGBpDQad91jJ2hHQDePWjgRY7HuW4lO/pm/w
         Vc64lEux7KlDqUBvouYy3MZ8jMr3nurwKBXdcbfS0QRq/Csdy/PxYsIEM+BiaSWaY7G7
         GJ+v42s/9PHO9sXb4jbnvzxbnRKYMGtW706WXNSFW3MCX42CtjwaFu+3V9XUSJMXQLaD
         cWY1d2lNU3gR8HTc6QJNXg6BRUOAHrkYR9UPkQMSrQZ2gHWA9Z1ELwxG+8Xyf1IsxxPD
         /neb0bZyOfKAPWFA52aOcrIDWvSVya5K6BmtQq79XPI0K6WiuTq5HmvtOR2rn67kGazD
         y/bg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LraB9bIiywFg4HL5vcxpxg8lyKqyHMcPK32qVHD75cZjTppv+Vcqy9ISVPacbRurv3z6gU3xMbsC7NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrofzytxJ9ejHCCwoEwqKwjMYBo6s0gpru5kjEYlf5qXoSkJ4J
	c7Nt2ebUTWFmHKUXn/hwuBEWd7pzbaP9gUz0i43byUibmo3kkwuSspCiBESpbp8=
X-Google-Smtp-Source: AGHT+IHpDIVQFRzj504Zk+f3/vKgKGmhDgAK7B3kpCWJ3cuNby9GPkXv5Gj6L8nhBBMuQOMUCmm0JQ==
X-Received: by 2002:a05:6214:5890:b0:6cb:c9d0:df32 with SMTP id 6a1803df08f44-6cbeff80f57mr35886636d6.11.1728663465301;
        Fri, 11 Oct 2024 09:17:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5d3esm16930336d6.10.2024.10.11.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:17:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIKm-007akF-AK;
	Fri, 11 Oct 2024 13:17:44 -0300
Date: Fri, 11 Oct 2024 13:17:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iommu/vt-d: Remove unused domain_alloc callback
Message-ID: <20241011161744.GK762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-3-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:17PM +0800, Lu Baolu wrote:
> With domain_alloc_paging callback supported, the legacy domain_alloc
> callback will never be used anymore. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 90 -------------------------------------
>  1 file changed, 90 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

