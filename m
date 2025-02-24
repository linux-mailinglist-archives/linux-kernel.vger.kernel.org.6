Return-Path: <linux-kernel+bounces-529943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B3A42CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8928176631
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9421FCFE2;
	Mon, 24 Feb 2025 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoF9v1Fi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E770838
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425489; cv=none; b=iCj+8d2OmH5vjXy3rWuQxRMcXzv60OwZFLl5cMjThXgRBGinzhNtE+wBocpHgoVG9nz+mlwT3sTK8UuACnYdfMLaK2p7XCoqMwGICeeXL38ZcThlO0fQSCga9cgW8/52/qArsLcQbpuEwDGFpJ6ce1H6Ko6i6yewBjShPu2Y0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425489; c=relaxed/simple;
	bh=YBDsHACouaN+aMfoUrjYIa8r0lB8hOlZNo+jZD9yBEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m28z0kplU9eyybtryjfT3oG6SAOqs600QyJyIhBCEy89Bqaj2Ekoo5RYZBYleYPqIVWswUPRSrYnqSu8H+z6a4CHcOSDOix4JfhlcPKApZoSumSM1kYOudcSyLk6iAYR5JRCnOV99shVLbTmQzfwTYOBh/XNHG4jGuRK21dtek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoF9v1Fi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740425486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idT/vy1HvD2D4hD5nG4G0mRg704udpm8C/gIW77jkPE=;
	b=IoF9v1FiwPCUmIMU1HvXVI6T6hHvNv9WPRGqSynQ+sev27+IrHvMvB4F8CID7MxLkjhX00
	XcHEAecdYNzdMmjUuiNtEehY5juWo67Gp8R19TXHaIEpGViZPvIY5jwetCKh11iJuNE5dI
	8PsIPF67ZJqE8xB1kbu9PbpnzU9VWc4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-NlJHlYjPOn-m7KKOQz5fUw-1; Mon, 24 Feb 2025 14:31:24 -0500
X-MC-Unique: NlJHlYjPOn-m7KKOQz5fUw-1
X-Mimecast-MFC-AGG-ID: NlJHlYjPOn-m7KKOQz5fUw_1740425483
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab397fff5a3so501745766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425483; x=1741030283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idT/vy1HvD2D4hD5nG4G0mRg704udpm8C/gIW77jkPE=;
        b=BdfkQgkPCfOprM+b8EgvkhxL1gDejpuiCkh8EHrh/4iu46/og4eBsQKvvuiw8NRDnU
         AQLojECI5AQgdFE//qwv8NWt+u2Px+GyJSyDCEBbwU7MwXIgR4TGlAqFmXoGjiPXVRXg
         ++GPNVQ7sekxO2gaTaYxPnlixA2kPkg9E1yPXZTlKRCDFmScXSDg35ODhGUtyRTfYbzg
         UOgqnNP+Zfpv+3r0kINYi5qchR4Pa/OefaswWOrkwS2D3gjwSJ7aye5Gg19RrBIUdL/h
         I6x2Sqvh0hc6y1/7coLMHRz7iYmD1R9wBGExuk5fNnygHNKwpiFWhpbBUkNTocxsD/rq
         hXGQ==
X-Gm-Message-State: AOJu0YyGY2c2jxcXHpaGlJ6ABCbZoFpchVGiubQA4SSOYUohEuuZu5mK
	DrIAoNvx8oGhPy3IJCNiUe7yQcNnGTB7pSYZW3plBpzFRoaNgVY12Djw+uHovjRx3C9iBBO9EL5
	2rdgSyBR3SSNNvMubzuR7ewZL2TnLQBnEjsmWLFThBV2lb/trA3UtMYAuLvBAgQ==
X-Gm-Gg: ASbGncsCZ/SOHk3zKrqwj9CqXoL1YpNytV/z8NeTQKoIJwX0r7sSXmj8rbZJRNUdiQB
	W0ZfR8gm8sVlWSrQ/39DwgM5ztipYKvF1ZzX1jMxtfs6q64Jo3GyuAJk2RuVR5IpuONpN3duRKr
	ueH6xkfAFtPDkJ/xJp11eurtD+orbQ8bAPSA3Lg4tkFbB8qYOKXDcRJszafx7qxWeTTWIKiiyT5
	YF1jbJU94d9vwQltjLTMRluoVERXzGyeOK+K6PIgpj+DojXyc4BqXdefV0Ls40R+nDZ/1X8c3nU
	xm97YFzJmQ==
X-Received: by 2002:a17:906:6209:b0:abb:b602:6350 with SMTP id a640c23a62f3a-abbedf561d3mr1802818566b.25.1740425483411;
        Mon, 24 Feb 2025 11:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEreZlvieIjHWrvIDKuMy4Qi8XnpbU4EBr9I74kSWjhWKQiF+lYJGIGdmXQF0nqO4S1HziFxA==
X-Received: by 2002:a17:906:6209:b0:abb:b602:6350 with SMTP id a640c23a62f3a-abbedf561d3mr1802816366b.25.1740425483032;
        Mon, 24 Feb 2025 11:31:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20121c0sm9919666b.99.2025.02.24.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:31:22 -0800 (PST)
Date: Mon, 24 Feb 2025 14:31:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
Message-ID: <20250224143029-mutt-send-email-mst@kernel.org>
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
 <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>

On Mon, Feb 24, 2025 at 08:49:09AM +0100, Eric Auger wrote:
> Hi Michael,
> 
> On 2/21/25 12:42 AM, Michael S. Tsirkin wrote:
> > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > accesses during the hang.
> > 
> > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > 	...
> > 
> > It was traced down to virtio-console. Kexec works fine if virtio-console
> > is not in use.
> > 
> > The issue is that virtio-console continues to write to the MMIO even after
> > underlying virtio-pci device is reset.
> > 
> > Additionally, Eric noticed that IOMMUs are reset before devices, if
> > devices are not reset on shutdown they continue to poke at guest memory
> > and get errors from the IOMMU. Some devices get wedged then.
> > 
> > The problem can be solved by breaking all virtio devices on virtio
> > bus shutdown, then resetting them.
> > 
> > Reported-by: Eric Auger <eauger@redhat.com>
> > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks!
> 
> Eric
> > ---
> >  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index c1cc1157b380..e5b29520d3b2 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
> >  	of_node_put(dev->dev.of_node);
> >  }
> >  
> > +static void virtio_dev_shutdown(struct device *_d)
> > +{
> > +	struct virtio_device *dev = dev_to_virtio(_d);
> > +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > +
> > +	/*
> > +	 * Stop accesses to or from the device.
> > +	 * We only need to do it if there's a driver - no accesses otherwise.
> > +	 */
> > +	if (!drv)
> > +		return;
> > +
> > +	/*
> > +	 * Some devices get wedged if you kick them after they are
> > +	 * reset. Mark all vqs as broken to make sure we don't.
> > +	 */
> > +	virtio_break_device(dev);
> > +	/*
> > +	 * The below virtio_synchronize_cbs() guarantees that any interrupt
> > +	 * for this line arriving after virtio_synchronize_vqs() has completed
> > +	 * is guaranteed to see vq->broken as true.
> > +	 */
> > +	virtio_synchronize_cbs(dev);
> > +	/*
> > +	 * As IOMMUs are reset on shutdown, this will block device access to memory.
> > +	 * Some devices get wedged if this happens, so reset to make sure it does not.
> > +	 */

Eric,
Could you pls drop the below line (reset), and retest?
I want to make sure the above comment is right.
Thanks!

> > +	dev->config->reset(dev);


> > +}
> > +
> >  static const struct bus_type virtio_bus = {
> >  	.name  = "virtio",
> >  	.match = virtio_dev_match,
> > @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
> >  	.uevent = virtio_uevent,
> >  	.probe = virtio_dev_probe,
> >  	.remove = virtio_dev_remove,
> > +	.shutdown = virtio_dev_shutdown,
> >  };
> >  
> >  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)


