Return-Path: <linux-kernel+bounces-211598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE70290542E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E7B283978
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50E17D355;
	Wed, 12 Jun 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IwKO4hxI"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133617C7D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200344; cv=none; b=rTMo9Vs8OTIRynTeOTGnIQExKxGV31WN7ZsfJvdH9biHT2CFsHhd6zacmZg4DTPMzxp7ZaOVWvN8SCpkV8UUducfjS8fWUkd+TOgGVZIzW3fXpcotU9nJt8EVypuPer/WfHH0PxrZJDOXcfUXk9JVJHncTvO1uCvHxoU4n7Xp9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200344; c=relaxed/simple;
	bh=Oo7eKQ/vuiKK57nzWHRwBZAQcLEcZwfz+apajKIxjpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfiIiNIG5YjRC7HtowU2to7NthsIVV6Yd4cbmWZoiMEmNWYzSfF28mgHcT1BoYRaQRFWJyEm/8/m9/UbUlfFAED9CDXpvhshFDqUL3x2n85pZuSHiDGSXgCN3X7+/zX8xAnnWuaypr2VkRUlAZfx9Zf+8eHr3u727URurs+oqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IwKO4hxI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfef5980a69so447227276.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718200342; x=1718805142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4yFXPH48K7YremfXbvI5F9w5geLcApF+zrC9idLOg0=;
        b=IwKO4hxIzxgsEBkBNhUlUTztoGSaqBvsEw0ONBjyssFC2uDz/Y2052AUVgiSWt4Zwt
         qwcJzFYSiS4AjdDvZOEVaIyDw5TJvb8qpwo7nuL59l4ZOG7jDeIiiqLtgcoSRou7+Hrr
         y0UsNss+aqsogQYGEE4fFmrSEufiw+CU7zwSaqEuwfw5bJXVDCmCM0w2fKAdMs69REzM
         doEXs2Ev57lioYfQKXVlfRic94nxvxlX/9DeU+nGBY86iYS2n9c/wh1NR3E0wsR5XBD4
         j+cRt5Y8qcXEcXsCXUcWCLPK6DFmSdAs63ifn7Szm5m9W85pgzqnXzqlZfvMMTeozNWL
         txyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200342; x=1718805142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4yFXPH48K7YremfXbvI5F9w5geLcApF+zrC9idLOg0=;
        b=C15muNoYd3CALL8zx7DDeSyjFjb4U6Z52QA8IySF9PwgQnlnudkEo57752oZRz5t5W
         ykfwAzwQFCKdPomDo7charV49LrOrzmzLY5rkTuCGaWWeoprdeVIo9QFHhQ/is8JsJf+
         +uVR3GLjvJQpT+zk7hP9TRUzC5RjDMuNnoXCxqniXbxp0h4Ij1BXRoiMffNwJSxYzOwL
         OhuZB4dJXLpk1vrrA8mNyU7QMn46tsQpoK2xyjcDoaHvDNjVtt/0m4J3VAwSu9KQxrVe
         UyFvqUOrex8XOwsn350ana/x5HleLuo00eyX1FNVaT9E1H2Sl2tQrikpC/rJe2YrdSVG
         YWAg==
X-Forwarded-Encrypted: i=1; AJvYcCUpkGtnNFr1RbzUDe+KMPFubE0enOVvT0kazq761o/nVMWH/TzcYlpiliYMsyhFurRRjG2iTmCEDPE7kmVRrCwxnr3H69Q4elyc0P2M
X-Gm-Message-State: AOJu0Ywcs0TUYgjAU7om+EhgEkWGixdY/qsDh3IVGFzq6pvqlk1i8ZHl
	aFuu5qlMGE1s9XJHmFdjQqwFwkUlJV8YG3QNMwvn1ZMK9JT8+LyazrwNoH9Rb0tPKLqRaHAuQUX
	0apI=
X-Google-Smtp-Source: AGHT+IG5MsAGFlJNLCZBYHd/CyREyJszvbTdf4kNLXCsh8V0bZu+GJ7j2/lX4r8ZXtpS+8b1yVkNJQ==
X-Received: by 2002:a25:ac14:0:b0:dfe:388e:2987 with SMTP id 3f1490d57ef6-dfe694f0e9amr1659594276.64.1718200341645;
        Wed, 12 Jun 2024 06:52:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08dafd095sm16499226d6.130.2024.06.12.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:52:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOOh-0091GZ-F3;
	Wed, 12 Jun 2024 10:52:19 -0300
Date: Wed, 12 Jun 2024 10:52:19 -0300
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
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612135219.GZ791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-6-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:12PM +0800, Lu Baolu wrote:
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @addr: Fault address
> + * @length: a hint of how much data the requestor is expecting to fetch. For
> + *          example, if the PRI initiator knows it is going to do a 10MB
> + *          transfer, it could fill in 10MB and the OS could pre-fault in
> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> + * @cookie: kernel-managed cookie identifying a group of fault messages. The
> + *          cookie number encoded in the last page fault of the group should
> + *          be echoed back in the response message.
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;

Given we fail the system call if size is not exactly the right value
we should probably drop it here.

The ioctl to get the FD can someday specify the format of the fault
messages if we need to upgrade. If we want to change it down the road
then the old FD will be exactly as it is now, and the user will
request a new format FD that only works in whatever the new way is.

Jason

