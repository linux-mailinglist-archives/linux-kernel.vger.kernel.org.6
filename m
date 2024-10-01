Return-Path: <linux-kernel+bounces-346006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F9E98BE40
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D25B20ACC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0234A07;
	Tue,  1 Oct 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X+C5oohv"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8E6AA7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790334; cv=none; b=PpyLYh9rqlKPCt7Cl7YncSoLY1oKIYcKy/yeF42trmzZYHR5ikXywVC03oTkjcVbqPhfOPyGmYjuPdeEvkcewH0sXsmNRFVyDP8rlmoLFXfFaxad7gcZYtQxnwbWjX7crtHZBdMfnW04Ug22Xe59QvboqmqXEGp6R2dcDn4yA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790334; c=relaxed/simple;
	bh=pDbBzy+BoAaB8dRVK++eCMB4Dk8+UyQ1Oily4R1FyeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K24OuZdgIJASQJAJrYRi62D7x+5AG9yDk6LhcNvGOkf/qqLt7rwrfwd92XvzHZnEih6PR6h7SX6k+cLSZHWHwz5MxRSTUeefxwlEUaQNhUs0iUUxNNFi6/+JVTeb9cPhcvyyZzCSq2vVtiIm08UuYuW3g7ZkoxCTSRbR4itWULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X+C5oohv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4581f44b9b4so38473151cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727790331; x=1728395131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSUQi2CXVstrkKehz5CiFb0Pzkeiyixbu3bRD/RkH9w=;
        b=X+C5oohvOp13zcNxMOuL5rnEaH6QZ49pcNlQhgZnTVrkc0sX/BJEp/BqH8DXUMHOqD
         8k5iaYDUxGS2n2d0+ggc0F8fYcfGdZUjW4i2ensGh8/DGTKeahbNCZIFBjD70LJPvxBR
         lzi7C2mAUULmabslBMpMwxSEKpQocKnZRfjnzkjq8khH0iYq359Cb6LedBEEMpb9XqqY
         Ty9ru9g/zonqDTnse8hIHnPywVpgRUB9fua8DNneThpyz86su74I14Ot6OCb7ZB02xjB
         NRK+QX1kKBah8v2q63Fh4K02ZOdNaah15v1JYhSUV7CUKLWbmO4+HCjxxv2/kn3UsujS
         p4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790331; x=1728395131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSUQi2CXVstrkKehz5CiFb0Pzkeiyixbu3bRD/RkH9w=;
        b=f473pi3cuG9XrQcmQWkOCjnqmOHAVjFdo4aynwnsQIs85toS5K6eedDRJvONAUsyxp
         l3kQXATIbL1OJDDEDEch3uYwa2t38p905nG8OBUsdi1BvNgBYKMaNLHjKBRSfw82MYzN
         PWSma9g2LEfr4bY/RQxPoFysUXYM3rwk8o15VkMGqO4tNk9GFEcQWh9DSit5rMy2jtak
         nHKLMeEiIdf61/jg3Q7ZJoNjfHXtW7+TEpkASNTw6cN5BWiBnTuHev9S1uhPk5it1GGX
         aEYfrOBLGq49ep5YwfyEcOvXxXSJlV8C5TKLlMoCanltH2fj4nfXn7XYVBMX9Upp3cpi
         TSOA==
X-Forwarded-Encrypted: i=1; AJvYcCW3R37kxVaMaP/7OrRbNuhrnlPqP7lKuSnsvIZRUBR3b1H7cngsJIFQT2weBQeS+bhaOxXUBRxm5w1yMfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLPl8BZOlAgod4pQacezWacMaPQ75wx7jeRAxCsaKrXhdkNc5
	qSEueudY6EHfud+M9V16lneW0p9yEkOqyHiD2YkvB9u0YkUaNaDqy576X/DfWvA=
X-Google-Smtp-Source: AGHT+IHTNZNNg4AQLQSBy40Dioqas1hHQVeTzNppv4MVcc0nfKq4d2Vb9YQRTsfNuVobQNhX/I7NCg==
X-Received: by 2002:a05:622a:58e:b0:453:5ce5:9972 with SMTP id d75a77b69052e-45c9f1f0f1dmr249279591cf.16.1727790330620;
        Tue, 01 Oct 2024 06:45:30 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28ea36sm45405951cf.20.2024.10.01.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:45:30 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:45:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Message-ID: <Zvv83Xg_jDilJgqx@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-3-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:44AM +0800, Huang Ying wrote:
> Previously, CXL type3 devices (memory expanders) use hostonly
> coherence (HDM-H), while CXL type2 devices (accelerators) use dev
> coherence (HDM-D).  So the target device type of a cxl decoder is
> named as CXL_DECODER_HOSTONLYMEM for type3 devices and
> CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
> anymore.  CXL type3 devices can use dev coherence + back
> invalidation (HDM-DB) too.
> 
> To avoid confusing between the device type and coherence, in this
> patch, CXL_DECODER_HOSTONLYMEM/DEVMEM is renamed to
> CXL_DECODER_EXPANDER/ACCEL.
> 
> No functionality change is expected in this patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c           |  2 +-
>  drivers/cxl/core/hdm.c       | 16 ++++++++--------
>  drivers/cxl/core/port.c      |  6 +++---
>  drivers/cxl/core/region.c    |  2 +-
>  drivers/cxl/cxl.h            |  4 ++--
>  tools/testing/cxl/test/cxl.c |  6 +++---
>  6 files changed, 18 insertions(+), 18 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

