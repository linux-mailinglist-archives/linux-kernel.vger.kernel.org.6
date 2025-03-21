Return-Path: <linux-kernel+bounces-571803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D9A6C26A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269283AFF80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8E22FDEE;
	Fri, 21 Mar 2025 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/nDUDsY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B21E3DED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581967; cv=none; b=diwR1VCzrUWyNAuQwOwJQ3+YMzP2bxj6Hy8YFaIz/8r5bGPXBIENomT/07Kl811u9pfdywduEzg5qUO2M5Q29+MHlh0ZH5ExOFNeSB748r2sZeA5s/3kImtc07Fd6DCximR4JVm/sn7nS+iXFES3n4KcDm24abioPMRpxowiVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581967; c=relaxed/simple;
	bh=OGIF01jTzLLwnp3yRBbvZluiVgmfjC+jL66qfu3gwks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZEs4MZis2bKlU5i+CVvOHro9h9xkReQXD+f5O4BNEmve5Tk4/fZQtGhZllFmV3EgARlLbR2s+QDya3dflpXgcDNSha2LA7+hxOd3a7pwUb+ZcLSAJpd6N9bqDFLHx9qGg4zj191BDq8LAyDvcUx+CRQca2CBDisMqiO9g0CSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/nDUDsY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6Pr4yNEy0Ee63hyTGb7eb9xdvxKn8eEKjzFLCkdY+o=;
	b=i/nDUDsYaS24go49HwGVoHmrV3GQzY5+/B6R5QZfKSYRmtL6CyrJU7gkamhakkLcbNpQUt
	vFqxlYkntCR6BX4TS2je4LoK4iYiRNNivm2eW2//KO/9c+NcL403XQFZj2gdq494euIT2s
	Piz/OxTl5ND/OHvLCQrzXva/SydVz1Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-oJ6dmARVN9ubevgE53ar9g-1; Fri, 21 Mar 2025 14:32:36 -0400
X-MC-Unique: oJ6dmARVN9ubevgE53ar9g-1
X-Mimecast-MFC-AGG-ID: oJ6dmARVN9ubevgE53ar9g_1742581955
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2265a09dbfcso57935635ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581955; x=1743186755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6Pr4yNEy0Ee63hyTGb7eb9xdvxKn8eEKjzFLCkdY+o=;
        b=wi+QKgYMY5mXcle8u7iYCOf9dPw39IUe2tbBfs+hGAI9ffyDm2XGbdE+f7pHCpYKw2
         ty4idKex069apcF4yyHZyJy4s0TNFElk7lqVgJj5gSNJHPHRH0DcaA5J4R+TigUAWOwH
         Sd85aOFrGvDo8kUxDf6PinaTeLD/G0goRcgz4D3bvHBFnZSM4UkYXufKw5byI01d750i
         EvkAzJ8t1/WsqZmNTE2uNkiYEAaxmSxr+UILj3WqUbp2/Ym8kLMzGReJbABnyCxRytlK
         YqxQe6GWQrIcxZK4Cxmu+808+mUEzJvRcK20aAO2eaQP+fL+MJusgbDckHsqJZ2H+/Bt
         xPdg==
X-Forwarded-Encrypted: i=1; AJvYcCURC04eaqKRPnzljO71vPtDfBp+EOJQ2VeGuI32J754nAzmtYwQ/FQ9UVhI3vTQGzXbaztuR1L1NuGzA+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4QxdOd9MgyQ0WUluGGeT9VXXlFDFFgQ8X2rb7dDV5PsIZQh+
	nerE6Og8nDr6OIylOLufC+Llobe81V4TtiEz3FaeAHc9iGjN9uf4HK4s5J2cqks2OdqHEBijzZd
	xgMY8wRPp0TDyDbi3P8SLn5JrLoetQeyxbH0NZGlFCoGEqN3WTD0tz0BFrQ9pDQ==
X-Gm-Gg: ASbGncvdmLUNEFm4ebwyMJgu27nfMXen8RhSofIkOBraa/T9tOtDCEVCcfhjKOXCL1Q
	gepPA6chKoXTTsE+okzYbElSO2AEldlsaRfA2QWhT033n7j7+fMrFQQslaBn+ioSeQ7luArCxHn
	EaFd2UmDeGfQ8fptYpMyvrMR05Z4yZ5Zni5jSS5Kp93YQsh7DEW5Sms+XgW7FAGXV9HryPIU1uB
	RSlsWZ2sn2hYPyrisPi2lwRHmWrX3z/ae/Rl/bWg8qpMB60GpOM1lYVujqd9u2x38+Bzc4jJVgH
	eLrPG8KF
X-Received: by 2002:a05:6a00:3d49:b0:736:592e:795f with SMTP id d2e1a72fcca58-7390598e637mr6094602b3a.9.1742581954620;
        Fri, 21 Mar 2025 11:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgvI4Fq7PhyVG2/6UfPhY7tEePZCtkHS/CCaoQm+lEN40XhsJxvkXhRtIdT7ONaz8I8Nvvbw==
X-Received: by 2002:a05:6a00:3d49:b0:736:592e:795f with SMTP id d2e1a72fcca58-7390598e637mr6094532b3a.9.1742581953971;
        Fri, 21 Mar 2025 11:32:33 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e08esm2305706b3a.169.2025.03.21.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:32:33 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:32:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
	mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	boris.ostrovsky@oracle.com, jgross@suse.com,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	heikki.krogerus@linux.intel.com, peterz@infradead.org,
	benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
	mingo@kernel.org, sstabellini@kernel.org,
	Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
	linux-devicetree <devicetree@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Robin Murphy <robin.murphy@arm.com>, hch@infradead.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, graf@amazon.de
Subject: Re: Using Restricted DMA for virtio-pci
Message-ID: <20250321142947-mutt-send-email-mst@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979b6a34ca5724ced1d4871b58bf227065d7da57.camel@infradead.org>

On Fri, Mar 21, 2025 at 03:38:10PM +0000, David Woodhouse wrote:
> On Tue, 2021-02-09 at 14:21 +0800, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> 
> Replying to an ancient (2021) thread which has already been merged...
> 
> I'd like to be able to use this facility for virtio devices.
> 
> Virtio already has a complicated relationship with the DMA API, because
> there were a bunch of early VMM bugs where the virtio devices where
> magically exempted from IOMMU protection, but the VMM lied to the guest
> and claimed they weren't.
> 
> With the advent of confidential computing, and the VMM (or whatever's
> emulating the virtio device) not being *allowed* to arbitrarily access
> all of the guest's memory, the DMA API becomes necessary again.
> 
> Either a virtual IOMMU needs to determine which guest memory the VMM
> may access, or the DMA API is wrappers around operations which
> share/unshare (or unencrypt/encrypt) the memory in question.
> 
> All of which is complicated and slow, if we're looking at a minimal
> privileged hypervisor stub like pKVM which enforces the lack of guest
> memory access from VMM.
> 
> I'm thinking of defining a new type of virtio-pci device which cannot
> do DMA to arbitrary system memory. Instead it has an additional memory
> BAR which is used as a SWIOTLB for bounce buffering.
> 
> The driver for it would look much like the existing virtio-pci device
> except that it would register the restricted-dma region first (and thus
> the swiotlb dma_ops), and then just go through the rest of the setup
> like any other virtio device.
> 
> That seems like it ought to be fairly simple, and seems like a
> reasonable way to allow an untrusted VMM to provide virtio devices with
> restricted DMA access.
> 
> While I start actually doing the typing... does anyone want to start
> yelling at me now? Christoph? mst? :)


I don't mind as such (though I don't understand completely), but since
this is changing the device anyway, I am a bit confused why you can't
just set the VIRTIO_F_ACCESS_PLATFORM feature bit?  This forces DMA API
which will DTRT for you, will it not?

-- 
MST


