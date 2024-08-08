Return-Path: <linux-kernel+bounces-279689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A994C083
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A166286645
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8C18F2CF;
	Thu,  8 Aug 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNR1Pwg8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9818EFE7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129421; cv=none; b=bUdOssFXKNtAncayVFnernGPUkTCHH/mAdqw6ZSY0yeDxrKYmfMoeFY2kHaIussk8oYkGHH+/wkc7JMWHfj28s4Gd6Q3lPrnvv6+Vq7mK77KgRvQ8/yeraNv/CB+Wg6ML99U297vkHOY1WtaRwLr8Ljyhga2lB/e2WNP9S4fdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129421; c=relaxed/simple;
	bh=o9kLwDsO6A9K6j8xf/c6CW0vBtGgQqwBXtILXprIUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7pdVOl3o0ZAaYs8U/m9uWVaDkBqVkodHYA9KJ3XSOCX2O2SjKIuHKcCBCesxvojoUEHTHd4t6Lpz1e3osvPsMjwyHGrA16JIjAkxbqtsyeB7g66IJpa0UMsrQYmSk60/pBSmor5oGAd/ikss2vh57dCS4qtWpINIs81RHhfy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNR1Pwg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723129419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MibcXSoq2vjzsX8VjmQt+hKWDJBPxaePrDMf1gWfvyc=;
	b=VNR1Pwg8gIyCRRggO0xEC2LYZsi5F2l8WmTL8I0749AsAgEJwF7yRkcytASqm71EJgdzXX
	Wx/8t2VI1821AQk7AdY+p66qRMu47rDK0fe94EX1tS0ITbvyNB2xIqRvlUpzW1Bd7hEqSs
	fJu47lOEJC45/9tgd/BRHXWoIe/LoaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-26fWztQ9Ngi2MkzkQxjI1A-1; Thu, 08 Aug 2024 11:03:37 -0400
X-MC-Unique: 26fWztQ9Ngi2MkzkQxjI1A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fb72245bso5728735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129416; x=1723734216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MibcXSoq2vjzsX8VjmQt+hKWDJBPxaePrDMf1gWfvyc=;
        b=OUS0xc1OXNW+cmnY9Mi1oIxo50+CEWnGyhUpdFjHfie7C/i5ebXkLzljzvXvRKS37r
         VYVo3NUKo77Rst6ESpfoQbSP8ITmxjrH52avNuOO1QVdsexudLnER2Vca50gJ6CIV3wb
         gNR8qY9uHkSExmIpw/Er6r2SXz+teI2YvIQUOL8Bl7rfZTYIIvlrkLm5lXcmOMmSEukx
         HyT5WZPOM7Wvr1RHSG06Wd+1exZtOMFrYyarNXWNQUPtdlMnZPq+QSKwY+y7yuTNE3+T
         gkN40b2okAqrMAj4zcdRb6lKoVZj2XfmsDjU0hjUZr6woT+778lnm+GNgWU7aOB2MMSC
         dwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCaWVQmIQrov6T6PqDtJGkGgCyFLFL2ObAPdngLkC8v8BEHhYBRNOntnmb+SRbUiG84OP2uR1r2mwJXmDkc11SbpdjAIZLHWZHcCMP
X-Gm-Message-State: AOJu0Yz1WgPWeLLmgKAEepT3d67Z45XU9Ffv2ykQTm+kh05DcaJDZVm0
	Cps61TIyMqvlJFifyU3oxEv5A99X2h2Rm+PafxhTfVyciGUcN0teFkSZUXAIaYe2fhDxvw4dTF1
	B/0SPkwUyxzoswbeJ8GH3DzQiS7Nj++xVo9Yq+Y04NRgZq23gGDZMhDTtC89n9KvLs5RSRw==
X-Received: by 2002:a05:600c:4710:b0:428:29e:67cc with SMTP id 5b1f17b1804b1-4290b85c350mr23190795e9.10.1723129415772;
        Thu, 08 Aug 2024 08:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0qZ8m6+/YQZHtmKvTjjY1k5UimGT+5++YmR8clsXsMTOPr7cpAXLzkVZUP/l7DqGVh9r5rA==
X-Received: by 2002:a05:600c:4710:b0:428:29e:67cc with SMTP id 5b1f17b1804b1-4290b85c350mr23189515e9.10.1723129414735;
        Thu, 08 Aug 2024 08:03:34 -0700 (PDT)
Received: from redhat.com ([2.55.14.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971993sm80105095e9.16.2024.08.08.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:03:34 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:03:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20240808105006-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <20240808075701-mutt-send-email-mst@kernel.org>
 <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>

On Thu, Aug 08, 2024 at 04:15:25PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 08, 2024 at 08:10:34AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > accesses during the hang.
> > > 
> > > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > > 	...
> > > 
> > > It was traced down to virtio-console. Kexec works fine if virtio-console
> > > is not in use.
> > 
> > virtio is not doing a lot of 16 bit reads.
> > Are these the reads:
> > 
> >                 virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> >                 virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > 
> > ?
> > 
> > write is a bit puzzling too. This one?
> > 
> > bool vp_notify(struct virtqueue *vq)
> > {       
> >         /* we write the queue's selector into the notification register to
> >          * signal the other end */
> >         iowrite16(vq->index, (void __iomem *)vq->priv);
> >         return true;
> > }
> 
> Given that we are talking about console issue, any suggestion on how to
> check?


If you do lspci -v on the device, we'll know where the BARs are,
and can compare to 0x102877002, 0x102877A44.

> > > 
> > > Looks like virtio-console continues to write to the MMIO even after
> > > underlying virtio-pci device is removed.
> > 
> > You mention both MMIO and pci, I am confused.
> 
> By MMIO, I mean accesses to PCI BARs. But it is only my *guess* on the
> situation, I have limited knowledge of the area. I am not drivers guy.
> 
> > Removed by what? In what sense?
> 
> So device_shutdown() iterates over all device and we hit the problem when
> we get to virtio-pci devices and call pci_device_shutdown on them.

Hmm that clears bus master.  So maybe what we see is actually
device trying to do DMA and failing? We'll need to know where do
these addresses are on your system.

> I *think* PCI BAR (or something else?) becomes unavailable after that but
> it is still accessed.
> 
> > > 
> > > The problem can be mitigated by removing all virtio devices on virtio
> > > bus shutdown.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > 
> > A bit worried about doing so much activity on shutdown,
> > and for all devices, too. I'd like to understand what
> > is going on a bit better - could be a symptom of
> > a bigger problem (e.g. missing handling for suprise
> > removal?).
> 
> I probably should have marked the patch as RFC. The patch was intended to
> start conversation. I am not sure it is correct. This patch just happened
> to work in our setup.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov


