Return-Path: <linux-kernel+bounces-286834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F681951F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CF7285F22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6641B583E;
	Wed, 14 Aug 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx/Ek0TJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B11B8EA8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651997; cv=none; b=bxDQZjL5fZZ5ck0RN207lIh5OB0EQsZ7/UETfGyE84Ofu4hjf1opjPyS1QzMt0PTiPSZmsRYjCCQYMuw/vAs2/KQP9Hajq8mfzWDvNDd1DEQHT2lDVFhn1emssIanwy6EFsWSWWnHY5Kku1+VvXRTWxUEnQde0cf8dGGBpTw4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651997; c=relaxed/simple;
	bh=d44m1S8mwmHexTAfN1Gv9j6XmNoZXCXnN2acC6FhLOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA9wf0IKL3UXs4iKInoeGxs0PYmbtUrb7ToZEq0PwlBhYtyWi4DltA+fN6mgjVVsxF+DxRlLYdEOx6DFkXmAy8ekwymHK/0RxgtMZ7yJE2i/IvRVewp6+9ONh+rbu5ldk0bTwsSZ26OHZwZ9MCkyNU5DQG5GZzbM9FkxNsHwats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx/Ek0TJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723651994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8l/e+/hw38ZTc3H1Sjqvh3fnMtNpnbvEnIVnHb6Kn8=;
	b=Gx/Ek0TJ96k6DhUEVzFa7T63xd0L/R/YsHO7q8JVpakJgDlktJmSIOxMiJpGnJ6rkKOYX6
	JhDRT1dmqLMlNduTzG5yjIGZI3qP/KqwJduOUUzOfz85Djo7gFWR+4SDPC5gnIq4Nm+hQL
	dFNcWS3gB/+++yU4JqR/A+i3Ul6H6hg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-2GLpErreMkS5WLnxkSwxoQ-1; Wed, 14 Aug 2024 12:13:13 -0400
X-MC-Unique: 2GLpErreMkS5WLnxkSwxoQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-709664a6285so5833435a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651993; x=1724256793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8l/e+/hw38ZTc3H1Sjqvh3fnMtNpnbvEnIVnHb6Kn8=;
        b=Urg15c6rwz0Fnma37OktZLtU0WE0GNC2C5s1U7TdfzRqlXZxqjHc0R06eYpEv5mgfY
         K3OLN4gIrcC/V0fiNd8il6pX3q9tI0vvCQ5QXCfbRNxLJwoptStpsmz7/XofNCk7ApoJ
         F8jwGRw4tp2Dg+RM7RDDtDTrzeGHTS/LSTPjfM6vk/qzytYAHCXHK9zxzWbZ/YzjCbOo
         m2gz1qpaFQmBAXicyGze1TJ1WdD/R+edkyE1pp/XdGBj+gXBZrmeV+DYK7Ti3zEZZGDo
         mvixB+zryHl2W/T1ipeI6Szwu368KqEbTiN7GOa8ZEThMR9tMfIP6vQt4bv3SX13W4mB
         aueg==
X-Forwarded-Encrypted: i=1; AJvYcCURdnt6p3Fu05KlPQM4Ke9bz2AVN2SmF1Sm1sYrKiJckfUunksfoRow7Yh9NS+fpSTpK/YTxFwrovP73Wui3QGYfhabRqxbJT5+68HW
X-Gm-Message-State: AOJu0Ywv+FL4RiiTTnE2fltcnCvEdpGZm69Y3UW+63tyHd6tgayG8SAO
	1QipjGeeEg1vQEBb9sHRpzfTYv2AaF0m3nIH38WnGYWuIyk88j9fNWjatRXzM49kaYJNIAcsYWE
	nl3v+BXS4a4Mly/GU1hQyRAjL5i0JsvoHk/H0TIApR1+aTVF4P/9HKLGwx4ZsxQ==
X-Received: by 2002:a05:6830:210d:b0:709:450b:a3aa with SMTP id 46e09a7af769-70c9d9d54bemr3985233a34.21.1723651992914;
        Wed, 14 Aug 2024 09:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET4fUVUg5Ku8gd0F4+hHNEqb77dViMPB9mv2/u4HKBnP/huGni2r7nkTEqdDY6xTD0gAHK3w==
X-Received: by 2002:a05:6830:210d:b0:709:450b:a3aa with SMTP id 46e09a7af769-70c9d9d54bemr3985203a34.21.1723651992516;
        Wed, 14 Aug 2024 09:13:12 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5ee71sm45692186d6.18.2024.08.14.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:13:12 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:13:10 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iommu/vt-d: Require DMA domain if hardware not
 support passthrough
Message-ID: <6t4vbpxwibd2egshbgro3mixmnfdhioy57fb46bpc35hjhzdoi@l2ck53gfq63z>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-2-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:35AM GMT, Lu Baolu wrote:
> The iommu core defines the def_domain_type callback to query the iommu
> driver about hardware capability and quirks. The iommu driver should
> declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-through
> capability.
> 
> Earlier VT-d hardware implementations did not support pass-through
> translation mode. The iommu driver relied on a paging domain with all
> physical system memory addresses identically mapped to the same IOVA
> to simulate pass-through translation before the def_domain_type was
> introduced and it has been kept until now. It's time to adjust it now
> to make the Intel iommu driver follow the def_domain_type semantics.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..90ad794a1be7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2149,6 +2149,16 @@ static bool device_rmrr_is_relaxable(struct device *dev)
>  
>  static int device_def_domain_type(struct device *dev)
>  {
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +
> +	/*
> +	 * Hardware does not support the passthrough translation mode.
> +	 * Always use a dynamaic mapping domain.
> +	 */
> +	if (!ecap_pass_through(iommu->ecap))
> +		return IOMMU_DOMAIN_DMA;
> +
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pdev = to_pci_dev(dev);
>  
> -- 
> 2.34.1
> 


