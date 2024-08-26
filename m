Return-Path: <linux-kernel+bounces-301920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7E95F762
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3624D1C219F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFC198A0E;
	Mon, 26 Aug 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXyPSNJU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEAA78C89
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691900; cv=none; b=STwSrDqAE53uPDcmyZynf2k/fxPF5OE956Yt064VVv6Q9SwLz5VmU7GymqQUQ7X+ayHufooEHPUq4hgKiDUAeW2g0VHSU/40WBVYQZVE0WmnJYJNSzm1X66Mf2suckDoaVO1Hi5ZQgQ7ygBbrix9eiZTWcUjuG5UmPuaISLPAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691900; c=relaxed/simple;
	bh=sSP3E1pz71KBeoaohCBRvwa3X+4yl+kGCoQ6GI6IpL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8jx2Mwj0aRDekRnXGiRB1aEZUxK7QJYkroX2iyYYol6jJo+NSAGWcsE/HzksrhVf+BMqGEiRruN+rYRqV6oM9gEbnLBdjnhxqmMSbHCmroRhV7l7dxWn6AhAaS8cWQetOdcjvFBT2/FU4yhN3+6Ov6QfrAvR8Vsrwg8kJ7EuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXyPSNJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724691897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwlIXih1BO8ZQGiTKnzjUQyj1FpIRW1qmjvRfN0Byzo=;
	b=WXyPSNJU1tAFGckdKga4cFiJadT9Hh9noaJHlg17xaU6FIPo5ZJU5tHuC6A/nF3/twpK+L
	0fq5QsvLvPVFbhwMVfKtPYgNIVe7hYNjc1tbgLiq3gLWN34wOViR9Z7QKF+6HUEU+eKb9z
	opN+X38AxPIbcj2m8pmcfjNttCIl5s4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-8mgMx44lMR-Te_q3I4bqSw-1; Mon, 26 Aug 2024 13:04:55 -0400
X-MC-Unique: 8mgMx44lMR-Te_q3I4bqSw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8285f737so49555339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691889; x=1725296689;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwlIXih1BO8ZQGiTKnzjUQyj1FpIRW1qmjvRfN0Byzo=;
        b=vma4XcSJ9yUErQLpMqkJ7XOFSGCW9OsqhbhUnnOTXKXt1B5LsgUedSArJS5NyFA22/
         FWysUodoA6+fSkYsAMeL/VfqFc0guqFtrzOjAM+sx1j84WEZfOG1kn3narZO6993qYFW
         W6KGvMFUEOBzWaMRVWdKTWEZuyMrHYRU0XluAb3hb5c7d6yzX3CsdQiN5MJ9uZp3De7r
         HaCi7Jghu3Buun7bh64jLXgChAzahm/UMG1nHQntI9iOJf/QLBZwknglcBt3J4EWBi+f
         RhEGHyztcXhbfdIDVVFHjJGycxBiH8sBTHwuRZTobK5JKPHVFoyuiIPdVmpUUtlyTU+j
         GQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6X6SWxcuv9n3wPD5gcp7CftJ6A/idfMehy4RMcN6nFZSfas0RQ1ltDBwLgbRQu7JbAyPoCUF9/4AEFSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCOfUIkD6DH64skBNlBlpHPdsNSB4BAraFnSyRihp5iQ1o02u
	HH28erGFDIuzQFJlxBbK1WPluccQpMiqR5Td75Jggg7u7fTPfp7If/GSsc3I3a0GuyhzxvzSQ0J
	/J9ObKv0rEMAVBhTF5Gqblm0gR53kqZZlxLXM1SSjftfVwzTlDD09gmQYdTw34GXga52yZg==
X-Received: by 2002:a05:6e02:1522:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39e3c97a5dfmr61324875ab.1.1724691889187;
        Mon, 26 Aug 2024 10:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/jEWrTo7q6VwBNGfSnxrn8MgB6Q7L404MZHrzYPI78/GNJ5dUbnlkNdD62TNSjIbJvZrssQ==
X-Received: by 2002:a05:6e02:1522:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39e3c97a5dfmr61324775ab.1.1724691888651;
        Mon, 26 Aug 2024 10:04:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce7113a21asm2269909173.166.2024.08.26.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:04:48 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:04:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Manoj Vishwanathan <manojvishy@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Dillow <dillow@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 0/4] vfio/iommu: Flag to allow userspace to set DMA
 buffers system cacheable
Message-ID: <20240826110447.6522e0a7.alex.williamson@redhat.com>
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
References: <20240826071641.2691374-1-manojvishy@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 07:16:37 +0000
Manoj Vishwanathan <manojvishy@google.com> wrote:

> Hi maintainers,
> 
> This RFC patch introduces the ability for userspace to control whether
> device (DMA) buffers are marked as cacheable, enabling them to utilize
> the system-level cache.
> 
> The specific changes made in this patch are:
> 
> * Introduce a new flag in `include/linux/iommu.h`: 
>     * `IOMMU_SYS_CACHE` -  Indicates if the associated page should be cached in the system's cache hierarchy.
> * Add `VFIO_DMA_MAP_FLAG_SYS_CACHE` to `include/uapi/linux/vfio.h`:
>     * Allows userspace to set the cacheable attribute to PTE when mapping DMA regions using the VFIO interface.
> * Update `vfio_iommu_type1.c`:
>     * Handle the `VFIO_DMA_MAP_FLAG_SYS_CACHE` flag during DMA mapping operations.
>     * Set the `IOMMU_SYS_CACHE` flag in the IOMMU page table entry if
> the `VFIO_DMA_MAP_FLAG_SYS_CACHE` is set.

We intend to eventually drop vfio type1 in favor of using IOMMUFD,
therefore all new type1 features need to first be available in IOMMUFD.
Once there we may consider use cases for providing the feature in the
legacy type1 interface and the IOMMUFD compatibility interface.  Thanks,

Alex

> * arm/smmu/io-pgtable-arm: Set the MAIR for SYS_CACHE
> 
> The reasoning behind these changes is to provide userspace with
> finer-grained control over memory access patterns for devices,
> potentially improving performance in scenarios where caching is
> beneficial. We saw in some of the use cases where the buffers were
> for transient data ( in and out without processing).
> 
> I have tested this patch on certain arm64 machines and observed the
> following:
> 
> * There is 14-21% improvement in jitter measurements, where the
> buffer on System Level Cache vs DDR buffers
> * There was not much of an improvement in latency in the diration of
> the tests that I have tried.
> 
> I am open to feedback and suggestions for further improvements.
> Please let me know if you have any questions or concerns. Also, I am
> working on adding a check in the VFIO layer to ensure that if there
> is no architecture supported implementation for sys cache, if should
> not apply them.
> 
> Thanks,
> Manoj Vishwanathan
> 
> Manoj Vishwanathan (4):
>   iommu: Add IOMMU_SYS_CACHE flag for system cache control
>   iommu/io-pgtable-arm: Force outer cache for page-level MAIR via user
>     flag
>   vfio: Add VFIO_DMA_MAP_FLAG_SYS_CACHE to control device access to
>     system cache
>   vfio/type1: Add support for VFIO_DMA_MAP_FLAG_SYS_CACHE
> 
>  drivers/iommu/io-pgtable-arm.c  | 3 +++
>  drivers/vfio/vfio_iommu_type1.c | 5 +++--
>  include/linux/iommu.h           | 6 ++++++
>  include/uapi/linux/vfio.h       | 1 +
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 


