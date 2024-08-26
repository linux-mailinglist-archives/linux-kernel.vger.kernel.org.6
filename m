Return-Path: <linux-kernel+bounces-301832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021F95F638
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9AB20BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EDC1946C9;
	Mon, 26 Aug 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ilj4xTAA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1113BACE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688915; cv=none; b=WmdTTuh++jXm6m+WUTtBnVkT70MCgduzSUPXjls9K3RTy7shjjXZkSC3tf31pTkw2jht5hjDUdXm/YNoRZ+xY/6GB/eZ86f22jyU0GWkFkTbunP/EHITMf6CeguKURXkNT7d7diQcD37eC/VK4cWBzCnELTYQQihESjDDyYNK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688915; c=relaxed/simple;
	bh=PpyI/C464x6EhgM1qIUWeL7Sz+KNsLjuJE/7iztvuPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ//9cz/MQDGwf24e3e20c2jXRV8IQ4U1aPQrIQABHyZwgnLLnT6kKbJgcJlKeaWmQ/myN2uyYJ2WFv9o4I5PY0xBNfDshCZGyz/SVbTqdzykcMco6SXtnvCvtO3+83kNuC4CQeaQacv5cZLEvgbXZgxLyJoz8l0zkDTNoUGuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ilj4xTAA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724688913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnTt/v04kG2lCJ1eZ7LwMpc3AUHrXM5GXqq1e2Zccg4=;
	b=Ilj4xTAAgoKo578IUO6RVyDr8qOP5Rx+NA5qdvawq0eobJpYclYlmryWNdkgzz12kh/0/T
	o5A5xCV16rQhgwQ0h+sDi0bwmiDxhUTazhCyU3aeU4svf8fHOjEQN6Ggs186kiaOOISrG0
	q6GZQMKe7HtvEBKoSOvN5u9j4JkvLbw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-HZ00kUsoPVWIkb3nVd2cLg-1; Mon, 26 Aug 2024 12:15:09 -0400
X-MC-Unique: HZ00kUsoPVWIkb3nVd2cLg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6bf6ead7783so52431626d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688909; x=1725293709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnTt/v04kG2lCJ1eZ7LwMpc3AUHrXM5GXqq1e2Zccg4=;
        b=siYU5w+HJgtw0jSYcIF2ryW00xIGTKPrx/0rPXxjgbf9a5TabTTZUHekY/L2i9Seza
         s0VjE8jU4CPjenNHZx/EFSbs5U2BrDMre8WEWLPnlZ6pVf6sXqZqIBeW3EW+V97pkugv
         yFpkZnA4h/KreUlQ8W32oU+9ymk13Y9ThBByY8SmdV5upN4Q8ypgkJ/32X2/iSdTsXsf
         u5Htrokcv37MpCUUl7RYK3JSPR68qZkCQ8xdy7VciVdzD1w9B2E4Nf+dT62snZ5XwEuU
         3WuAEPprZY4/27/l7Hqj+T2ErpwQMtEgdRA7MwKNn0No2voEoXO+CRHds9gXwIkMxFU6
         HO2g==
X-Forwarded-Encrypted: i=1; AJvYcCU9cuiyFuga+5cYDbXkCdbzXa8soFyDCQvTi/oUb/kaBo2w2C3exTHGZXpx1E5c/NHyBzM3M6FlBn1Trrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavsUhxL+xPC+d8lT/mpXFKaBqpZOnkUwRE2Odr8tLN9C50fui
	RXz8kmetfmJ5XlXP6UPdxB5jlPQMLKANJnTfStVfiJtcbdHlF+vmd41pgi+lhB5gdht2eXKYH2i
	f4jGwvUv7DQ5reJM0H+FZC1o/BqP8CHDSsC8zOr4g1yMFghHKwu0PAijIWpJ8iQ==
X-Received: by 2002:a05:6214:5544:b0:6bd:69a5:4fc4 with SMTP id 6a1803df08f44-6c16dc2a99cmr118357566d6.8.1724688909168;
        Mon, 26 Aug 2024 09:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt/ipYTrvhVyJ0rdzo5CkEtbzz8pU+g9RFTfd5qHbSoX00nso7ovG4mPjxp57hJgjSH8DYXQ==
X-Received: by 2002:a05:6214:5544:b0:6bd:69a5:4fc4 with SMTP id 6a1803df08f44-6c16dc2a99cmr118357106d6.8.1724688908584;
        Mon, 26 Aug 2024 09:15:08 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db067asm47686316d6.76.2024.08.26.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:15:08 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:15:06 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <2h2gyzr3anhcpyiorkrjp3o4cdg7sg2rmrvgzmkxopabdsr3ph@jlhq77xjtcdf>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>

On Thu, Aug 15, 2024 at 08:48:57PM GMT, Lu Baolu wrote:
> The helper intel_context_flush_present() is designed to flush all related
> caches when a context entry with the present bit set is modified. It
> currently retrieves the domain ID from the context entry and uses it to
> flush the IOTLB and context caches. This is incorrect when the context
> entry transitions from present to non-present, as the domain ID field is
> cleared before calling the helper.
> 
> Fix it by passing the domain ID programmed in the context entry before the
> change to intel_context_flush_present(). This ensures that the correct
> domain ID is used for cache invalidation.
> 
> Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for context change")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Joerg,

Can this go into a fixes pr for 6.11?

Regards,
Jerry


