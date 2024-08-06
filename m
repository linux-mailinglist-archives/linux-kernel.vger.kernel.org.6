Return-Path: <linux-kernel+bounces-276641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A4949674
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E364283346
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4D433D0;
	Tue,  6 Aug 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aX6/nhU0"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919834CD8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964400; cv=none; b=Nyh2c0kFAyebFi8MlXFZJ2LmOXiTV4LJOI1MRPN2Cb+67zkQlKRZyEXe62OROc32RCiOLI2dMLk048YWq8a9dX1VWZ0t0H9BVF7aJXZS5JzliFwlCQtaTGSZ+gn/9pf7mYiu+oUv/gjLYU+22rw+sy75URqFLBSVIL/JJtl/9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964400; c=relaxed/simple;
	bh=YN6vMSV5mJVWgg/to8AJg4nV9KUUtYkIyeYo3vJiXEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgEOztOJmkaZmRECwDm1F+CNAP9zrC8hpiTqo3msAAeSVstpTHplCO3OIMSJ3sGX2tjZU1yLbjD7IKaDZwU/P51tj6F7aXTMK6HzwIMMs0PRQbZ39KOpAR5TILZt6Afc6iNMi+MpIuN9afzhe9Xhyq4roBGHmwN6DEQNsMjiLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aX6/nhU0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fee8813c3so5693611cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964398; x=1723569198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSznEVEIYw46wyW3XMMsma0WGZhVspw+jN+9r2mgLEc=;
        b=aX6/nhU0d8o10ELmpYDDrjaoj6uuUN8xmHOpFiV93cQLBJVSbu2aVw8KJqaLKNPdnO
         1Do6e4lZaaZ7C2h2n/VBc6Ifrctt89gZYhReGfhqfSj3FQdj+HnuSHz7DAnjJrqhZUPL
         Yfblv9j3PSunaCpeZ+KjP0qkZmKw0jDmJfRhdxZTF80WkajEQukDdDyhiiX+o+Fzy2E9
         ag+K6F7HeJS+cW/Waag7HGecLyIxRosSiytVaH7M1MS04AFhIu98ZAauhKvYmDsBT9wI
         AR9c9vWN/edDi43So3JTMsGmZG0lav2Z58KKD/1vciImDFutQbe3SuBZqAuCG05huzG/
         4TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964398; x=1723569198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSznEVEIYw46wyW3XMMsma0WGZhVspw+jN+9r2mgLEc=;
        b=O1aMbwkqo7S/TLrENXRxCUZp9bC0xhnXDevU9L0j1JG2JMBADCif7vH6PNwG+Yo3OG
         HzJGIcnP8e/kRv3fm8yPd90ohtME84L8gbBwp3Z3OYfntUD4HSEmk1Hx4S9yP1vMWwhA
         9fsL2hZkxKv005g3zZW7IJMTpk54uXmmYBm1nH8NcPrQTa9esrK1yjNtNEYJoU2+eddn
         dl/TZ1ipcudzY5r+pFlnc6HzqVSblX+Hx8P/9Ow7jvp+REU2tZooIByPdDXBCYERAa95
         Mc5gCiiJ0AHrJ/PisvRarxYpS3UN7gngba/VtIXaSrrHRQs5ZipW3KJyZXoDEJZY6qpv
         wz7w==
X-Forwarded-Encrypted: i=1; AJvYcCX8GW7tzDvG00XAO8sj8J3Wk1z6L0l8YG5pOOCHWU1CKhCRCvIpVh3pgZMZEyGZSN8C8j3wpAu3+rr0+ZbjeteOfHAbKc+8FM8H/CCN
X-Gm-Message-State: AOJu0Yzoeo3QJu40laNvVwCVDc9oq1RzJunUKQ4O6+S93uUZUl/QwiHl
	91rqheVWXQ72CLNmcqKEWc7c0OblSWbx1le7eiN7aKSPzWj1UQVrS0IKRB3nnHY=
X-Google-Smtp-Source: AGHT+IFVCBe2Zb/J2ADzsYBFArjOGEaznrjwg9WBDhd5sbiJxGOBrhqlded9CgkJnij9iXaZQUtVHA==
X-Received: by 2002:ac8:5e09:0:b0:446:47e9:6591 with SMTP id d75a77b69052e-45189204457mr182702781cf.2.1722964398063;
        Tue, 06 Aug 2024 10:13:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a7714fdsm39532601cf.86.2024.08.06.10.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:13:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNkL-00FVat-3x;
	Tue, 06 Aug 2024 14:13:17 -0300
Date: Tue, 6 Aug 2024 14:13:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Factor out helpers from
 domain_context_mapping_one()
Message-ID: <20240806171317.GN676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-6-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:39AM +0800, Lu Baolu wrote:
> Extract common code from domain_context_mapping_one() into new helpers,
> making it reusable by other functions such as the upcoming identity domain
> implementation. No intentional functional changes.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 99 ++++++++++++++++++++++---------------
>  1 file changed, 58 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

