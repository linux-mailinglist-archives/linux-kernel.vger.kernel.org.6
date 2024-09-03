Return-Path: <linux-kernel+bounces-312649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF796994A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C080A1C238F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B341A0BE3;
	Tue,  3 Sep 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dzg0MTH8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA01A0BD1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356356; cv=none; b=Vdt30xfgAh3jNO7b4FSsmUx0LuVCqa+I8MIlqwdb1vW4RWSNNvhemCS3P3ye4cR82ejcS1W5THtm95PMB6fkokZpnm1Kc7rGysDAoEiwyIl4V3lgLfAjhbTce5FXjlM+CROuQMzn3HDzAGGql9w7VVebYzzSGsm0juwEq2FNpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356356; c=relaxed/simple;
	bh=Roj+Ea7LEvenEhyYiuiVmXINZE+I65g3EEz0Bl+4ooc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhVf4kPHHg9JAI2/XNSusnuJwawlNwaPcKt6DDX9lsF2fFIazG4NGEQVihtI4ybtp0UWFUFsCrPAc0+TyjryFtwve6U1YSeKPjTo/meuwrRnUxy6XvLRBpziy4sGEXQ3rrHmdM4cuW1coJUlnzeSLJbDGoy0lILM6W5pOgRbT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dzg0MTH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ROekkmcoe+OX/H/SJ0CegmonvJxcYbn0m80zXzGYZLw=;
	b=Dzg0MTH81X5MuDrt2OLTZjTsfh9S3IMwT3enhoGoSO6WkamznRckYPFV/zOLIYifHtDPca
	1BhbhhsTEHZPay5jkVb1UzEAC5MMmXvBQ+sjnV4TH/VcTe8ZWyQmeNvCC9sazU0q3Vk4Zx
	a1E8p1kuNnRNg9omv2MGxYn1oIYzP+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-C-j6hPqgOyCSsLhszXU4tA-1; Tue, 03 Sep 2024 05:39:11 -0400
X-MC-Unique: C-j6hPqgOyCSsLhszXU4tA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42c80412dc1so21029015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356350; x=1725961150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROekkmcoe+OX/H/SJ0CegmonvJxcYbn0m80zXzGYZLw=;
        b=mA9t2pdAKxpCLgcVkiepnIBAgkCT1QuFNwug+RPXKFnQMZTDEp7OxIxPGm2reDktpP
         j9mNs2PndaWmGKDLaw6PFARqv672/NbXGLV/9JftptpOGPwiiQfTpaExxTj+JKvNSdWo
         XJe/r74WCPvNfYHdDhCpVf0pNIt/EKdqHu4L98LtOq+UpPSiE3t4i/S0jRIQIPQDqwWA
         wAksiEAIZLb4J19puRV0gE8npVrjrG0ZmvBu/v93FuryTzdMlkSwwbzUucb3GmqGhey0
         1b4+wMNfZTH/Ui8lKZAYZ/oiUB3hLeaY3U7K4Ua3DdPFBfX5okVi/3eoOj4vJfe8rYNC
         UWxA==
X-Forwarded-Encrypted: i=1; AJvYcCUTjflJNnDc3LZFMWR8IsOBOabnLbrd3hM+zHbJdZ2SfoUCp8Xm5exhyKP2D/QWdawKBQJ6t0n++ypVe80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPhsZ0YghoIFcS8zGlkG42HuKmuMxzbIztc3bxjHRpPeFH4SA
	N5i6HkqedX2FAYeMqBCswyCsH1q0cDIYgQD1ejdANeHEXhz3FhrX1Xe5qL+fJlcXePpnigG913u
	DfuHoCeqlPxljT13Cgex6XSITfoiRdqH9q5TvcBKlMfut2+f8u07hWBEic79pTA==
X-Received: by 2002:a05:600c:3d0d:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42bdc6375abmr66533065e9.19.1725356350123;
        Tue, 03 Sep 2024 02:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmeosf/mJIf4OuBVOC1FXDQtaN47WobnVUFS/lrBzspPK+LAJFhvAiwYTR4QIKkjIzV+Hhfw==
X-Received: by 2002:a05:600c:3d0d:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42bdc6375abmr66532735e9.19.1725356349385;
        Tue, 03 Sep 2024 02:39:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba57bb20sm142356975e9.4.2024.09.03.02.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 05:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>, Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-media@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] vdpa_sim: don't select DMA_OPS
Message-ID: <20240903053857-mutt-send-email-mst@kernel.org>
References: <20240828061104.1925127-1-hch@lst.de>
 <20240828061104.1925127-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828061104.1925127-2-hch@lst.de>

On Wed, Aug 28, 2024 at 09:10:28AM +0300, Christoph Hellwig wrote:
> vdpa_sim has been fixed to not override the dma_map_ops in commit
> 6c3d329e6486 ("vdpa_sim: get rid of DMA ops"), so don't select the
> symbol and don't depend on HAS_DMA.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vdpa/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 5265d09fc1c409..b08de3b7706109 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -11,8 +11,7 @@ if VDPA
>  
>  config VDPA_SIM
>  	tristate "vDPA device simulator core"
> -	depends on RUNTIME_TESTING_MENU && HAS_DMA
> -	select DMA_OPS
> +	depends on RUNTIME_TESTING_MENU
>  	select VHOST_RING
>  	select IOMMU_IOVA
>  	help
> -- 
> 2.43.0


