Return-Path: <linux-kernel+bounces-368349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406499A0EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DCDB2323B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0120E03F;
	Wed, 16 Oct 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zqip9kRY"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0054F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093473; cv=none; b=iPe/GQ8Kk3RxOI9U7fJb5LbIqrqJ0XiLT/SmOnVzU8nV8ZkxRaQ4nFUT+uGCBVnbl21qbQiXa9NWYINK6zd7oWJY98Rw+I2dpT/d5vvfiaBoCfpswLIZ5U2gGZpAlSMlx7wPcFy9wugcthWMLNNjCU+NxXleTp3JBV4ZJOyV3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093473; c=relaxed/simple;
	bh=Wt8M3OtL2Uo77t8ctBBB63Tcked/Ps5DjEWBtq0fbIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcuikH+mwYr2uQ1k/9BAem46l5/vKKtj3XcD+W8UsJnmtDWO8MroNsXVGofIsTaxPoBdBe5vXyN4TIpTD3UyJ1H5DrSJdXiThHuqNn/ne2aUo7PNaWvUUqW6rhZN2mAxnLCpHm84GFrjkOQ2P3BxreMf0yHJAHStuq/v+u+A/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zqip9kRY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4608f054f83so10131811cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729093470; x=1729698270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQGH0HVIW9SU96PYTPyuC1ydSkg4GgQM+hqbTFWgoGo=;
        b=Zqip9kRYKVSvXHp7HRlWSobILUazYDJWn3S70BRDHKzzygMj7RjJyWRY/u4gkwDb7i
         zu99uQr/LaryTvQSI9sTOtd8Fz71S94VlHQlj1d70D+Zy/HK+eVx0Sc0Nt7PcLE06RFi
         9ilY988OiafcKdIng2VAYMBThg6B3coZ9hRyH7w4HIETGQfchV5tQrdpIBVHyuJ43KyX
         N8zOm968B+oxmznksC+cJoDNDahEjIjPzY7HXHMmpM2fpydyER9XGTyN8Jxl/fCgVHYy
         BPsPOwaDm6pgmMlxaxBIQdy0OpxyWe3meCmoabvtZXUXbLTmnqsdA0cTRqXt+tkxf3J5
         +tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093470; x=1729698270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQGH0HVIW9SU96PYTPyuC1ydSkg4GgQM+hqbTFWgoGo=;
        b=bvLS03qGH/ZSgzsraD4cFGDztaM3iKNrY12uzRYjBZxaE/ruPeC2kLPAkzUxPA86nD
         grhUKnShe6QU4KbTt5CLRFErhxGRigOZrbWmCzmuBNc27g8y/VZRgdeQSCeleBYSuBoW
         xmn3jA3IYHaEsGQVoEJ7Ht27rOY768r6pPMNAvDg6WAHPvd0TeOatafG33zl0tCwfyBU
         JzcQpG4AiNxVn5A/UwS/gPXXmTg9v5Ex6XpgbdIyMUdl953VOMuUiERdE4Fu4Oq+6wBp
         9UuLVJumkFAy8cZGLoJg+FEHdPqbrOqUjWkd+0MjpL4rHr2L2trvoQ4aagkKYMLCL0fq
         GNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl6HZ3vkHnulgw88UWezb3+OodSdnXSu8VlNq6nCD5wEENtyH6fHZay5ZX1F5XQB8xBTM/GrZo0RJg08s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBoSJ8Op/m74Db+OCblwoOGDBaMw9wpTfbCbkxpUNL+KMvIkTx
	iWpkAtkc0spXbhTeSclOgUckMJ2StMV0POT2Gywp8FmV8Xi7J4ghm1TQk6cNQwg=
X-Google-Smtp-Source: AGHT+IHphNZzLqFYrOFx7/ySDq7sBcTOs9Dks5qU/HFioLD65ljv8EK1dQjanMksDh9hLfIE6iUrIw==
X-Received: by 2002:a05:622a:2608:b0:458:4bc9:e949 with SMTP id d75a77b69052e-46058424bc2mr231836401cf.22.1729093470391;
        Wed, 16 Oct 2024 08:44:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a6760sm18990161cf.6.2024.10.16.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:44:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t16CK-000COv-F5;
	Wed, 16 Oct 2024 12:44:28 -0300
Date: Wed, 16 Oct 2024 12:44:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <20241016154428.GD4020792@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw9F2uiq6-znYmTk@infradead.org>

On Tue, Oct 15, 2024 at 09:49:30PM -0700, Christoph Hellwig wrote:

> > +	/*
> > +	 * Used for private (un-addressable) device memory only. Return a
> > +	 * corresponding struct page, that can be mapped to device
> > +	 * (e.g using dma_map_page)
> > +	 */
> > +	struct page *(*get_dma_page_for_device)(struct page *private_page);
> 
> We are talking about P2P memory here.  How do you manage to get a page
> that dma_map_page can be used on?  All P2P memory needs to use the P2P
> aware dma_map_sg as the pages for P2P memory are just fake zone device
> pages.

FWIW, I've been expecting this series to be rebased on top of Leon's
new DMA API series so it doesn't have this issue.. I think this series
is at RFC quality, but shows more of the next steps.

I'm guessing they got their testing done so far on a system without an
iommu translation?

> which also makes it clear that returning a page from the method is
> not that great, a PFN might work a lot better, e.g.
> 
> 	unsigned long (*device_private_dma_pfn)(struct page *page);

Ideally I think we should not have the struct page * at all through
these APIs if we can avoid it..

Jason

