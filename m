Return-Path: <linux-kernel+bounces-186610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E68CC63D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2328207A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CE145B13;
	Wed, 22 May 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW6M8zbt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A81BF40
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402166; cv=none; b=DiPnpzL5gVYSwmJirezdNC7ECZhUAxYOPPZG69v4G33ULMPqbzxVczxSBOXaotbu3zwVmz1IJzYsQkva5rI/Mg1ayYhGqghNj95gL8AcSOwBmnvsmBmOwuL49txGZVudDaxu1+7+lie45RufZZYKVvKdWwzIqK473SuMeHhCHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402166; c=relaxed/simple;
	bh=Iq6KaucHUeO7d2vhmsu3CWa10QOWWbSDbQyQJO4o9+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqBlTt/u9f9c24N8vtXKEKIv7w09rU8tDYVDJPjL4gajqiaPfrzCdyR+72keva76kwA4tfELexshiXDz6jspqPU3+2I4jECcixzMzIKXAUSQIxFNEn6I/UbZjmS/FPoD1VEjCRqzms4tv5VPg9Ol5+bPjZVkznTESH6Nu/rOhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bW6M8zbt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716402163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLatQqZlGNky/Pj/2JrwlT+MuEkPUVh+4wXLBcmTFkA=;
	b=bW6M8zbt9PcYkWx2WntE/7F5Oblu3sZSfZEUQSiyaDXnS16dqPfXcxqmKhuAXObaLq9gvO
	hZwc/eOKzpdF8R9WFIirdapUCtPDyrqJfAxCDuKpu2OPojC8RGjfoGINyfZs9kxVrJjG8U
	iz/U0rgRZwgxKYEeD803zhduKvGXMfU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-I3zHTf_AN-K45IxCkmbfjw-1; Wed, 22 May 2024 14:22:42 -0400
X-MC-Unique: I3zHTf_AN-K45IxCkmbfjw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c9a9449072so444811b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402161; x=1717006961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLatQqZlGNky/Pj/2JrwlT+MuEkPUVh+4wXLBcmTFkA=;
        b=QDCz1MbLITXT/6K/nMNjGvV4Ts05fsdjQqbX4MMgs+t/ffkkrTj5cNiN/N6Ya/30GY
         +8LRI0vz5sNgKqtWVtFgSuOBF+xuK1yAYzpdQlaKEGP7VnMORTBEvkg8ldOzI8maurM0
         ozGn+5whH/ywGymAtjKCoZzCzIIsqgV7WNRUodQo5zcIro/5/u3umMcYpt1jX+gws7bl
         5H/+TOUdfbkX4B9XIDkUa4aRvH9C5+wDPpFN0NLwtuX2cIMMJ8YorrsF+1ScXYcpSorE
         X2U33bytZln53VcUcPwRUUzLsEXt+WZUHlvI3LJCbGz5da2k5RIrG4N/cmiDSVCCWcYX
         QQzA==
X-Forwarded-Encrypted: i=1; AJvYcCVsfbs/CHV91iA7VowgyUXJEk6jvUXsYEkOn2rpDp/tq0CDTIz28yYZsGyJi3SNC2MfwW3Oe31r535R4dIV1pB22ZzRVr4Wt0nllTMd
X-Gm-Message-State: AOJu0YyuyYooVC2Okh2NunQszZDDD8Ed0SNx1QIpWSvMIOQqsnbiz7o4
	4pTo/6PTCTU3/L5Gpl823NsjJvpzxeJpxsPqp3Rbntds+nVfsre3SacjUdzog2I/JvnO7O4dTgj
	DjpKslrExCaNVRQiLxLZIIz2S1d7xrwTUd5aMMsCJXKLzW2s8xvBi62XiUonynA==
X-Received: by 2002:a05:6808:241:b0:3c9:c755:a194 with SMTP id 5614622812f47-3cdbc568b62mr2526924b6e.59.1716402160493;
        Wed, 22 May 2024 11:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5vZvG6tsDWXDP5VEip3wRFTIGOmtPrEdCqdECt3XJLP2LbA45K02hd5EjKoficyR2hUPYOg==
X-Received: by 2002:a05:6808:241:b0:3c9:c755:a194 with SMTP id 5614622812f47-3cdbc568b62mr2526898b6e.59.1716402160051;
        Wed, 22 May 2024 11:22:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c99308f4f3sm4570470b6e.13.2024.05.22.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:22:39 -0700 (PDT)
Date: Wed, 22 May 2024 12:22:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Vetter, Daniel"
 <daniel.vetter@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/5] vfio/type1: Flush CPU caches on DMA pages in
 non-coherent domains
Message-ID: <20240522122237.1b4bf782.alex.williamson@redhat.com>
In-Reply-To: <20240522165221.GC20229@nvidia.com>
References: <20240517171117.GB20229@nvidia.com>
	<BN9PR11MB5276250B2CF376D15D16FF928CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240521160714.GJ20229@nvidia.com>
	<20240521102123.7baaf85a.alex.williamson@redhat.com>
	<20240521163400.GK20229@nvidia.com>
	<20240521121945.7f144230.alex.williamson@redhat.com>
	<20240521183745.GP20229@nvidia.com>
	<BN9PR11MB52769E209C5B978C7094A5C08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240522122939.GT20229@nvidia.com>
	<20240522084318.43e0dbb1.alex.williamson@redhat.com>
	<20240522165221.GC20229@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 13:52:21 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 22, 2024 at 08:43:18AM -0600, Alex Williamson wrote:
> 
> > But I think this also means that regardless of virtualizing
> > PCI_EXP_DEVCTL_NOSNOOP_EN, there will be momentary gaps around device
> > resets where a device could legitimately perform no-snoop
> > transactions.  
> 
> Isn't memory enable turned off after FLR? If not do we have to make it
> off before doing FLR?
> 
> I'm not sure how a no-snoop could leak out around FLR?

Good point, modulo s/memory/bus master/.  Yes, we'd likely need to make
sure we enter pci_reset_function() with BM disabled so that we don't
have an ordering issue between restoring the PCIe capability and the
command register.  Likewise no-snoop handling would need to avoid gaps
around backdoor resets like we try to do when we're masking INTx
support on the device (vfio_bar_restore).  Thanks,

Alex


