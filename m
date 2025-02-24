Return-Path: <linux-kernel+bounces-528368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC80A416F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD271895262
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF0241671;
	Mon, 24 Feb 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuiaMp8Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E422A80E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384732; cv=none; b=TT6FRBkGolNA7V8YZlstAEgHG9wYzLvmVvejMZHR8VcJOr4WPEt+IMrQ0SrO72SXZpBkQZuMQcao7YbIov0JJfsHnk9So+Tu82FPvHFPVWAK0x5buP+A++KFYLh8Kdruc3ydptMVTwxKb1/Hd/qqrGuXThW1OkPDkpWo0x2O/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384732; c=relaxed/simple;
	bh=h6wZlsMGwmOTccfnNZHe/vu4HIvt9y/ixO5SyNgwdNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOr0xumq+4jjIiv0DGeom6abQ3JmEfjhZr1ipUsnj9gm7pBXd/vzyXAYX9uERaf78c62Gp6KrzFiSPQKA7DJC4KY96h38y8UEM9PIcwCpmdEI3bPg1pKx4IFUE6mXQF2zUFGgF8Ve2jsu2K2MpASTKDKvbAMqtYMnsG37d2n1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuiaMp8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740384729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S+PquGhoPh+7bpUWG/HgveiI8uxcnh2uY5Z1i8v0Nv8=;
	b=AuiaMp8QUdtXlz8+Mm/iQrCcoPaeTDxnxOTmlQCWmrMgTfqvosVKwePR+kABHn7opHH7Dd
	wN4YeawuXt3+7nYMaMURNiKb1dgp0Qwyr+gHon4Ybx7EJDONJ/YM7I5gszII+fOwCr+4+j
	hdLP2qF3dsBJ9R8AmhWvh3wUgk5O0x8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-RTGSQhxsMcepgbYHlcecFg-1; Mon, 24 Feb 2025 03:12:07 -0500
X-MC-Unique: RTGSQhxsMcepgbYHlcecFg-1
X-Mimecast-MFC-AGG-ID: RTGSQhxsMcepgbYHlcecFg_1740384727
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f628ff78eso2088950f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384726; x=1740989526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+PquGhoPh+7bpUWG/HgveiI8uxcnh2uY5Z1i8v0Nv8=;
        b=UNKdg3GUXjx1SbyViVwNUl4mnJRWhxF/5OtI+ijE3lWAdh9CZC72VWuT6bQAcmk60/
         VLF5IcJ1tEly4RB/VpBSGcqVxlMfOQRmnFs7pmugQueN8OQxPStGc9NdrNIFRYE625J9
         KgyJTvF0Y2FCkyzFAdi668S6EQzsSKO0F6ARq3HLxMqjJnMp1ywfO3HMLF/ejFAhuhQ2
         X1VGbQ9bj3cnGGNgNMAr8eiWspVt3ynmPjKIMrqRXrOxerZfBl6VsM/bJBLgSb1fPJya
         O9wRbp/bz+AWTxCNZabGZOwu0R5VPx72nU5EyT0sPUzHC5E2/G+F3cBJR1f/kHwhxF8W
         4yJA==
X-Gm-Message-State: AOJu0YyOktlJ9fU8wkcKqCrouZ9wKxKZFKuBA8zYU00+B+FleejMu8Eg
	SdSBWLh6D7afbR22O7FOxl2iuHwek+e45SNhoqmzx0bNuf5VFQ1QR9AbnwGe7JYlHdJkrmKe+ib
	L6ffVRh8s75CnzWpH71WdtGg+rkyQmPrOE3uejbZzoZip4JzLJQn4/K8xSyCdha3S3tC2BRjl
X-Gm-Gg: ASbGncsk9t2Dm+l43LDgM+9DgiWP6PPhveFwIPYT02aFw6DhY2+FQWGE+2hhTHkuqnr
	rlxuHUOldNNZ9SWM9D26de912A0PRiM+sJxZh/0I03R/tsmUdV/hx0wJ243FFcaJvohfAntPhBA
	Ji3e5/85GAtiyK+al46lLC64MxU2DBv8MVhItpNHvAcLAg2TXlJKa9enD1WeEOpCy8GwLeWO4nS
	BvZdvbwvhWXg76rDBzwLHVzpllhBx23QacJCpZXjoFF95l17S2LEjkbce+7sLTimUpv76GnsxO6
	ehbaN3o=
X-Received: by 2002:a5d:47c3:0:b0:38d:d59c:c9d6 with SMTP id ffacd0b85a97d-38f61611400mr13606955f8f.21.1740384726459;
        Mon, 24 Feb 2025 00:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHScufgjq5BJwDdGXgbDd96wfhTvyL+5CbryuKCCKjubUE3V6n6X9879d7xW4HF9rjW6S9dXQ==
X-Received: by 2002:a5d:47c3:0:b0:38d:d59c:c9d6 with SMTP id ffacd0b85a97d-38f61611400mr13606926f8f.21.1740384726099;
        Mon, 24 Feb 2025 00:12:06 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f7:f94:19d6:f262:bf34:e145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f6bfbe8efsm10278032f8f.46.2025.02.24.00.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:12:05 -0800 (PST)
Date: Mon, 24 Feb 2025 03:12:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
Message-ID: <20250224030953-mutt-send-email-mst@kernel.org>
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



Will be in the next pull. Thanks!

Having said that


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
> > +	dev->config->reset(dev);


I feel wedging devices to the point reset does not recover them
if the driver is buggy, isn't good. This is something we should
maybe fix if it's observed with qemu. Let's discuss on that list.

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


