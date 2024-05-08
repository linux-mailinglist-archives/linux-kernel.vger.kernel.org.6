Return-Path: <linux-kernel+bounces-172560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7C8BF3A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AEC1C23512
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AD38B;
	Wed,  8 May 2024 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i2pU4XA7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC48364
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127911; cv=none; b=DiS8N3vd4sK9aZel1PpqFShNvt5DJVKN/wdmEz58VuL96IBkrQMVmxa2/+KIrbRxij/ZMCjNh0to0BYvMVLHxvQlRH1CeV0yfBMp5dlrtoe6U34EiS/fiRx2P3I2sgzm9JqpSrerm+eQhEb7mnAmmehFdP1wyNzxfGHckZ7DrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127911; c=relaxed/simple;
	bh=lwJncAe+bf7pRUOxcV0HmRnNwUlF2rdTBkMOBrZ2rk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRnB95RlZ7JID8yb7Ed8BRUNhUG2zVMaEPKM3FZs5WvHwpirvanKjCDNm8NSv26nZdgo0coCkreAN+WQu98gFltccAFO/z6NRgRLiRmkq1SOEJkAd5egVdQvF6eRLaHErqH7RD+j6hxdIz4sNC3SKD90fPToCWmGGiOeDkzKEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i2pU4XA7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43ab76cac73so3053461cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127909; x=1715732709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62oVLAkCTGDCTLLKSqh+lJU6r7gjh1o4XBhOsw5N1rI=;
        b=i2pU4XA7VRmlZ6DaoQhD603ByDM5kD2do3ORVWa6nse6pn/NsyKnsCsBd9394i8szL
         Fv8VlLzAxCvFjD55JLp8gbQZE92DbbC/vVAONJbRLT8XQPNcIeJawFry1moe+1fDmDls
         tjh3ciXL1v7fGqxr4w5vi3nODRUVFQAVJaAqmzP6YEPPXgaTPL822PAPZt9O+7vIfYgH
         BnqfZ//2PqR8yLjyJuFkhlQUZ8IdS1xr8rFbnRRS50uy8JKo55mdNyGPjq4p7egaf2Ft
         DpFi0ZbhU5km3StGYBugz95p6HhiXRu+68PB9HgaEzH4+Hngw7T4V5kUdSMah639njc/
         3hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127909; x=1715732709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62oVLAkCTGDCTLLKSqh+lJU6r7gjh1o4XBhOsw5N1rI=;
        b=LjgkGdCfeiXso6dX4EDilN6bwnkXveCT8FcEJFPsZIPNsz4MniT1QGjoZS8YxYCnIA
         Bpn3hnCdIt7WQ0ZPOYXbPGAsRZD9Blw4wV/RYSyJFqUVISGXFbFUqqhvsqZyftU9mY8F
         hZAgO+KMCN4sbIFH1u6ZrtEL4LOEs2PZ2ihjcuFdIXHKWBJeBLljU1ZbiTnZe8T0kKBm
         X2HtunBdKqyndpQYRa5F14xrJiEoX4wW6+fKhO/M/6ywSnqNpAH9c6750a2nK2MVyImB
         cwvy53C7T1l1SAaWf5zi0niDTNDvJMfeCiKkf2tmbZvbfyU1ff6OXfXw3jGlhDvN5UjH
         hFqg==
X-Forwarded-Encrypted: i=1; AJvYcCXMjTvWBqkUIUSveWI5qqAzJP7dn76v2rI60P+AnRfISgiCCsbM+loF8KIj1e0k+LwWg8khLuPHmMMuoN+PxsTQTHURRzP67hMRc05j
X-Gm-Message-State: AOJu0YwoWC87AVd74ZbEgE7XE3aCh9A8Whxpm0YSxo99hDqlLWTaMWpw
	BlQGodn0Z3x3HFALuJlGbZe+sBTrebt7y3IEeyL05iITA4of1fY0d93x+VcfFdk=
X-Google-Smtp-Source: AGHT+IFTxEBXk6pFTSfXuSIuCjv+y/O+PL/HIbz5Je8O0KKZUh3tsAMV/ImOlBAPfnNJTqCSHSBJgg==
X-Received: by 2002:ac8:5e54:0:b0:439:b456:25b6 with SMTP id d75a77b69052e-43d8f7cbbe6mr61262901cf.30.1715127908960;
        Tue, 07 May 2024 17:25:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id hx1-20020a05622a668100b004364d940d3dsm6840475qtb.96.2024.05.07.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:25:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V7M-0005JK-22;
	Tue, 07 May 2024 21:25:08 -0300
Date: Tue, 7 May 2024 21:25:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240508002508.GQ4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-8-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:08PM +0800, Lu Baolu wrote:
>  /**
> @@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
>   * @data_uptr: User pointer to the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> + * @__reserved2: Padding to 64-bit alignment. Must be 0.
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
>   * type that is returned by iommufd_device_attach() and represents the
> @@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
>  	__u32 data_type;
>  	__u32 data_len;
>  	__aligned_u64 data_uptr;
> +	__u32 fault_id;
> +	__u32 __reserved2;
>  };
>  #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)

[..]

> @@ -359,7 +359,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>  		 __reserved),
>  	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
> -		 __reserved),
> +		 __reserved2),

This is now how the back compat mechanism works. The value here is the
absolute minimum size, it should never increase. The first __reserved
is always the right value.

If you change it then old userspace that doesn't include the fault_id
will stop working.

Jason

