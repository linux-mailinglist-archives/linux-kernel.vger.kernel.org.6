Return-Path: <linux-kernel+bounces-537279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A622A489F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DDF188F809
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445F326F465;
	Thu, 27 Feb 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P64ttOiu"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831619DF52
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688740; cv=none; b=PoP41D9Ve5FkIxECfFwLpp5wOIeDArCrs7j7QTmfuOdrN1KYq/jf+371WgoVwT2R/kFl47fK+NXKEo7HxKMV0wgZu5SB9Ob8Ki81QDRCikLNns1rjNWy1y9cJrazhdg0eCRGhyyiEI9JMI1mgiHs9T4wLCqMabUhS00ODj2JBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688740; c=relaxed/simple;
	bh=tMLyfjj+PLIq74mmCTMG+2Qq5ezLhFjkwAJEJM30sx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKKXETLalegS7KlmoUnCl4ZY9CmJ0Tku8zo35PTAbjp9sv64Y1FxAXS21V2epl8HGTojyf6FGPan10C4PdphKvKAilUcPDIH+3tAprQksYPAuiXXzLz7Y0G9uuLlNp6i5ThYgfrRJC7uOq5wCFqDtdyobr2ajKAikidsPpMcyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P64ttOiu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471eb0e3536so24726641cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740688738; x=1741293538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8/Qt7Vv2+DDRlyzFkpTUnydrm+Dq5juNVKCyJPPEsk=;
        b=P64ttOiufROrXgA1UwKfgdKzgMWcFYHqr4q3Eqp+H49vJqRvGSN/B8avmYScFINYpA
         +45hsbvCSISnXogl4eKj3sgU0WXQiE8X+gih9FTZ+nNa2umPzNJPeYUF6y1w7CPCHegs
         GdabA15ZOR1mzx5hhs0kx51JpiSLhPbEOC2P5SsDsjnmOk6Ufh3kJtxM8Qd6IqDvdn+r
         /8uNF6iEZNz9U23IxmhbJy9Q/+rRs9J5H7oV6qhioDWNQd70BSWVF753tkMmt/yrQfN6
         O/+lIpaklUDd83++IL0TlJ1QQGtl4JdDj1jg11TP9dtLU+SdnYngYO+mDS9ANEV1LNfV
         2WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688738; x=1741293538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8/Qt7Vv2+DDRlyzFkpTUnydrm+Dq5juNVKCyJPPEsk=;
        b=OFtrXJgZQX5qUIJ90wbqdbFijo9/oxn3GDcqc5foejBGsrEGiXFBoLA/Mmmu8LJAhT
         IbrfjqGhEO0cRUCHDFi8IEXPjZxXVEWQawoduvtx+hMbDxmRT8oUoP9EJ1nZb6XYLvzc
         FdLFYpM8nx8Dafh5tfeILrI8AX8GcRZsYtrPh66kgT0ltKx1U+dCZrQ/vEqWn5JM2b/y
         xIWLZW1FfL0w+oRNVaOXTCOerjFJbT1zzLlqLGLMVPLxYfzc06eAn299ooIkUrRmtAN0
         D5awFhjLd3dOKTBmFMTcuM45SLYJNJuj6NIFVnGD54P7uSa23mGihSxFK1ug9ngpqkxG
         Hj4g==
X-Forwarded-Encrypted: i=1; AJvYcCXqDaD1PfBr8aKiz0CPmM/6uqrQHigm+H1YNjNdBpW80kqtogs0Dw6C34ijWCI4gdd4ighYPNr6PpgP/tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqdJ+GwUY1/tk1FS9ZhuD6lqTSnfjfaYT7+1cWCj3CerbcSsA
	3TbNQ743iMTwedUHhGwOzze9wDPCTP0qcudvf1ffsmmU/Us3JllTs/h+ExF1Srk=
X-Gm-Gg: ASbGncu77RzpKtgHjMgbnfXXLy1XHCRO/QNVHeX45U6HSkzobon4n5vrPDKSeaKjQFc
	qD+huPR9UdIAXr/10ja6QJ9woAGAyJWKL86v4StntVmD28cYgXIFLGQZ6OWnbOOPHhYYtTEItcj
	yKmNXKDBihny+/c/pJkIBVx3GP/B01iALjME5n3DYtFx18JZVwGUr5Cnhr4QlS72R+yPAJdmmxF
	d65q7F8NgGtziw/bgrR+l4PVYow857TcWHKZ7FrrjLr4mAbuEFSbKjLMSJ+kKfuyo3HRgB0ucUg
	WsjLgCSG60r9IHO1564+5QD+ntZ6wtMqUTBLfXHQJAEMXQs2hYKneLlqa0eU9AzFiW/8tSlm8WY
	=
X-Google-Smtp-Source: AGHT+IH9h5nIeqRBN4A62EgPqAGrwp4q9RWIx3Ok1zBoIEmHHWXkJ71RN3O4VBV+synHi7sJ/BjH/Q==
X-Received: by 2002:ac8:5e11:0:b0:472:165e:91d4 with SMTP id d75a77b69052e-474bc0848aemr8752981cf.13.1740688737797;
        Thu, 27 Feb 2025 12:38:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5eed4fsm15111101cf.31.2025.02.27.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:38:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnkel-00000000K3V-3Gtf;
	Thu, 27 Feb 2025 16:38:55 -0400
Date: Thu, 27 Feb 2025 16:38:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Message-ID: <20250227203855.GI5011@ziepe.ca>
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
 <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>

On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
> 
> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
> > > > Provided the system does not respond to those events when this function
> > > > is called, it's fine to remove the lock.
> > > I agree.
> > I think it is running the destruction of the iommu far too late in the
> > process. IMHO it should be done after all the drivers have been
> > shutdown, before the CPUs go single threaded.
> 
> Hmm... so far it is fine, the iommu_shutdown only has a little work to
> do, disable the translation, the PMR disabling is just backward compatible,
> was deprecated already. if we move it to one position where all CPUs are
> cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
> case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
> transaction there on hardware when issue the translation disabling command.

There is no guarentee device dma is halted anyhow at this point either.

Jason

