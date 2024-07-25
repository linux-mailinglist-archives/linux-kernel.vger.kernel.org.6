Return-Path: <linux-kernel+bounces-262447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875B293C73F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95BBB23508
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23C19DF7D;
	Thu, 25 Jul 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPnlixS3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E919D082
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925514; cv=none; b=TVeSlvf9oD8O6ow1eWePM8VTaQxA+cNo2T3PKE0BdxZsWYeePvO4lNSg9JSlDLkZ0zE2fmTdFIvgy4UEyvVR7wfELv5/aMBrE2B4otKWxInjlVDq+iHoJi3VG1+RHZzNQFbcJxeidrtr4/O1W088IxDCiPri8h+2OY5R+LHeb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925514; c=relaxed/simple;
	bh=DFJqdzFltqvFCb7O3HVaF7UJ9yWxMML3AVCrY79j1ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhyRG8HhJpts9XP/kpae72Lv+c8l8BFsZhUI7AmeBm5/IVJv9F6/VLym3Rmgp663FQCALyYXOqGqXgAxmvwgYmPL/3tLql/B0/sf6cbt8yduvcY15FbXhu+G5tZM0ROr45iwSVjFeRmb629/2Xf0ID0WwdlzbzaoSoj1fzAkIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPnlixS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721925512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmhpMaKw4X5CZZDMzXoNDtyzrmJbLZhDy7YR6GMuBto=;
	b=YPnlixS3yb0Ytg/Pj+J02qAjhMR93ouMfbmllveLSQegeYZ+4OBIK21GVHcG2eoIY0Qd6c
	YbdyD6cv01ZYf5e50vQnGx0rQK2yclkvdzL3R32FZ9KLdbUwk16RMLcTnN8yMy0oxM5yAK
	e8D+chMOwuFUTcnNhPsfv06pAfzCAjA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-_d4QCmvNPSOVldzQjzeOAg-1; Thu, 25 Jul 2024 12:38:30 -0400
X-MC-Unique: _d4QCmvNPSOVldzQjzeOAg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4279837c024so8268185e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925509; x=1722530309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmhpMaKw4X5CZZDMzXoNDtyzrmJbLZhDy7YR6GMuBto=;
        b=Wr8qjRDflFSSznAxtIwZ8LvPQ9kHECgg8MqI/6ALEfvI7slceiI4bNgwcZiypXgMTX
         YAvn9Ezv4jhII2zjUC/svCZDV8ushftfxaRybncdDVVYeonWyjqcDx1srnluuSem0mq/
         U0SxjQBelhTJjNIprL8eDdDOSDwursydjtwShgOwsxbJOXIu/pzdDURTgtdtLrvUkmuU
         0RD/CQUrbjnedBSOIjEAlJGZoC+w77cDrQ0BgUQaxYNz3BE8Y8HKuWZZdjYRwXXW4yls
         lC6+5Ly2YQuLg4l1pKAdycaIZ9Pw/btqnJSbMyIbTjfrRER2BukUAAtzU9T3wvb1btbE
         lguA==
X-Forwarded-Encrypted: i=1; AJvYcCUVdy3OTkXCD3KQGEQNZqFugjIT7DGnb1Sp0PFs8JX5aGycG+6UpwwSwHtVNJDXyXSxQt+TkaWB0ClmZchLn/Uc4Lh+Q2K5pSKR1KW1
X-Gm-Message-State: AOJu0Yw9c5GZaLvAcyhysvVkv4luO7U9KAI4Wwvv7gJsmpcb1ghO250G
	PVHbwmKluEyYW8/JNygWPAcv8GTnMZcYXltBi8QMjnfVBEfZIYHV4MK/8QM26l0glY5ZALbzHbb
	JhuS0ikw7iZ/5PQEjoYWYMXbZWgvbYVtqTeaXkn//OLziOgl++zs1P5b8dl/ZaA==
X-Received: by 2002:adf:ed47:0:b0:368:7f8f:ca72 with SMTP id ffacd0b85a97d-36b364443d0mr1823939f8f.29.1721925509558;
        Thu, 25 Jul 2024 09:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVkxqW5ZWpJzphEm72RP12t9yKD8nLEmAUKvkzy8Xw/le9MV4rpuQJkrCb/1ZIHocRHb/ATg==
X-Received: by 2002:adf:ed47:0:b0:368:7f8f:ca72 with SMTP id ffacd0b85a97d-36b364443d0mr1823895f8f.29.1721925508498;
        Thu, 25 Jul 2024 09:38:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857fdesm2828283f8f.75.2024.07.25.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:38:27 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:38:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725122603-mutt-send-email-mst@kernel.org>
References: <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>

On Thu, Jul 25, 2024 at 04:18:43PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 10:11 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 02:50:50PM +0100, David Woodhouse wrote:
> > > Even if the virtio-rtc specification were official today, and I was
> > > able to expose it via PCI, I probably wouldn't do it that way. There's
> > > just far more in virtio-rtc than we need; the simple shared memory
> > > region is perfectly sufficient for most needs, and especially ours.
> > 
> > I can't stop amazon from shipping whatever in its hypervisor,
> > I'd just like to understand this better, if there is a use-case
> > not addressed here then we can change virtio to address it.
> > 
> > The rtc driver patch posted is 900 lines, yours is 700 lines, does not
> > look like a big difference.  As for using a memory region, this is
> > valid, but maybe rtc should be changed to do exactly that?
> 
> I'm certainly aiming for virtio-rtc to include that as an *option*,
> because I think I don't think it makes sense for an RTC specification
> aimed at virtual machines *not* to deal with the live migration
> problem.
> 
> AFAICT the only ways to deal with the LM problem are either to make a
> hypercall/virtio transaction for *every* clock read which needs to be
> accurate, or expose a memory region for the guest to do it "vDSO-
> style".

virtio can support the second option, we already have
VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, I'd just use it.


> And similarly, unless we want guest userspace to have to make a
> *system* call every time, that memory region needs to be mappable all
> the way to userspace.

This part is classic for pci, mapping pci bar has been well
studied.


> The use case isn't necessarily for all users of gettimeofday(), of
> course; this is for those applications which *need* precision time.
> Like distributed databases which rely on timestamps for coherency, and
> users who get fined millions of dollars when LM messes up their clocks
> and they put wrong timestamps on financial transactions.

I would however worry that with all this pass through,
applications have to be coded to each hypervisor or even
version of the hypervisor.

I don't really know the use-case well enough - is sending
an interrupt to linux and having linux create a device
independent structure not workable?


> > E.g. we can easily add a capability describing such a region.
> > or put it in device config space.
> 
> I think it has to be memory, not config space. But yes.

virtio config space, which is just a region in a BAR.
But yes, maybe VIRTIO_PCI_CAP_SHARED_MEMORY_CFG is cleaner.

> The intent is that my driver would be usable with the shared memory
> region from a virtio-rtc device too. It'd need a tiny amount of
> refactoring of the discovery code in vmclock_probe(), which I haven't
> done yet as it would be premature optimisation. 
> 
> > I mean yes, we can build a new transport for each specific need but in
> > the end we'll get a ton of interfaces with unclear compatibility
> > requirements.  If effort is instead spent improving common interfaces,
> > we get consistency and everyone benefits. That's why I'm trying to
> > understand the need here.
> 
> It's simplicity. Because this isn't even a "transport". It's just a
> simple breadcrumb given to the guest to tell it where the information
> is.
> In the fullness of time assuming this becomes part of virtio-rtc too,
> the fact that it can *also* be discovered by ACPI is just a tiny
> detail. And it allows hypervisors to implement it a *whole* lot more
> simply.
> 
> The addition of an ACPI method to enable the timekeeping does make it a
> tiny bit more than a 'breadcrump', I concede — but that's still
> basically trivial to implement. A whole lot simpler than a full virtio
> device.

virtio has been developed with the painful experience that we keep
making mistakes, or coming up with new needed features,
and that maintaining forward and backward compatibility
becomes a whole lot harder than it seems in the beginning.

-- 
MST


