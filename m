Return-Path: <linux-kernel+bounces-262638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3193C9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C781F23E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837A13D531;
	Thu, 25 Jul 2024 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwCzZBTA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27C61FCE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940662; cv=none; b=jtLEhoYWll9ddfoadyHwrZZuCNYBtuSHFkRXvq5pjRR7i4YbvmXBY5Geo3GXt3eooo9jFy/TjRcuaMBoQdJwu50A4yLKMtn19dDg58oRsEdps275HiBWBbNwv7PazAUmuMtgbNBb1Ge+G2dSlclxEQuX0e05ZrVh+oRG2eQAgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940662; c=relaxed/simple;
	bh=kuusY9XGv6HlTmCnkp2wdWjx/n7YuXhw4w52RHy3fwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9Jqpp5jIsb6WnSUDYObBWPkbbvbKXoV4aVllCau5U1KkPMIW/9lKlRv6bp9zhcmSTks3z71I7riz4TKmzXNmZazw28dApjOlkGNeLXKGVBw0Ms2uPIeVSwrSIKOX6bFahX7YHrm+Qec4Rw/M7HIa4JBA4qkxXm+4anqxZ4PHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwCzZBTA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721940660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0TRSzPBcxjm5TEyUVQiD4/U25Z4w4e7FZY73nOkT9RE=;
	b=FwCzZBTAF/5r/uUqKOsjvkd6qmjSpgWjPjmbegm2ix4ZJKChfL4zknrO5jZRLsIffon8pj
	a16WI8oYUVQywGuP7T7dQ3ZU+0vr72l3HVIoxH3swDvudEScYhN+6gbma3xbi+FlQSi0KT
	Jf5otsVzGOb8bd7hKZE5Yc7Mi4Kew5o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-3TV9SDNzNwC0R-SdiLyyDQ-1; Thu, 25 Jul 2024 16:50:59 -0400
X-MC-Unique: 3TV9SDNzNwC0R-SdiLyyDQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280a434147so1397915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940658; x=1722545458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TRSzPBcxjm5TEyUVQiD4/U25Z4w4e7FZY73nOkT9RE=;
        b=jfp5J3EZRQJGJDi7LEOBkEKRIFiqhX8TDuHrBK7HsT/wnNTREarO0nWeuf8UlR4n6u
         jS8ik8XxXZ3wjjpLFq3Fb49yAZTGEoCgtilZWXpRj8wXdTP59LX+lbhHz/kJZiGDRquT
         vIQbVtnORdeL1mMiS0eJhdTmeDxEr7T11OcfL7hssxHgPR9yZ0PPqvGzDr3Ju68EWBsu
         vNxZ79jhx8Vv5GdAjMmXT6tj8AlEfcEYIZBHJo0LZINSEkLZxL3Qd1ElWJMjOgQwbRru
         n9ypH21mUl59NFdui3OEw/yMZP+a8uJhmD0umkT6Y861qDH2H33OZ5xmBeBMQZkHLWmt
         NiGg==
X-Forwarded-Encrypted: i=1; AJvYcCW9GPa5px5T9H2tSbM2Ly5UAlVF4BzLECQA3AO3soxPB+mjFZh9gD5HV80r9tUnd/8JQAE8nVoH7llDV+iJVjwIF6CZVU8dJj4bf4aP
X-Gm-Message-State: AOJu0YzMCaHnw2zrQrKnG48FW6tnNX9gImhv47gfXZ6wovlWlfXyF5Es
	1l+AnlnNeY9vxMEc1YftQfDpoFblwDdI/ytILErZ3vmb9I74g7MwXIpdv5yEo/EoBlrUq8Ve9EI
	3n7KkPa8udKyRUuaj8iOw+mwrVleO4jDRCyqw05qYvrKNoBc4hXn7HtfvDZyePY8OxmiiHI5C
X-Received: by 2002:a05:600c:5494:b0:426:6ed2:6130 with SMTP id 5b1f17b1804b1-42805708639mr26435385e9.14.1721940657750;
        Thu, 25 Jul 2024 13:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoEPQMNc9hD+uG29YGXpuoiH409yodxUDLC7kZ9PMGvkPO91aZcH5CMLfzEXGDuU2yH4Kk6w==
X-Received: by 2002:a05:600c:5494:b0:426:6ed2:6130 with SMTP id 5b1f17b1804b1-42805708639mr26435175e9.14.1721940656863;
        Thu, 25 Jul 2024 13:50:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573f935sm50565255e9.14.2024.07.25.13.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:50:56 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:50:48 -0400
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
Message-ID: <20240725163843-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>

On Thu, Jul 25, 2024 at 08:35:40PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 12:38 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 04:18:43PM +0100, David Woodhouse wrote:
> > > The use case isn't necessarily for all users of gettimeofday(), of
> > > course; this is for those applications which *need* precision time.
> > > Like distributed databases which rely on timestamps for coherency, and
> > > users who get fined millions of dollars when LM messes up their clocks
> > > and they put wrong timestamps on financial transactions.
> > 
> > I would however worry that with all this pass through,
> > applications have to be coded to each hypervisor or even
> > version of the hypervisor.
> 
> Yes, that would be a problem. Which is why I feel it's so important to
> harmonise the contents of the shared memory, and I'm implementing it
> both QEMU and $DAYJOB, as well as aligning with virtio-rtc.


Writing an actual spec for this would be another thing that might help.

> I don't think the structure should be changing between hypervisors (and
> especially versions). We *will* see a progression from simply providing
> the disruption signal, to providing the full clock information so that
> guests don't have to abort transactions while they resync their clock.
> But that's perfectly fine.
> 
> And it's also entirely agnostic to the mechanism by which the memory
> region is *discovered*. It doesn't matter if it's ACPI, DT, a
> hypervisor enlightenment, a BAR of a simple PCI device, virtio, or
> anything else.
> 
> ACPI is one of the *simplest* options for a hypervisor and guest to
> implement, and doesn't prevent us from using the same structure in
> virtio-rtc. I'm happy enough using ACPI and letting virtio-rtc come
> along later.
> 
> > virtio has been developed with the painful experience that we keep
> > making mistakes, or coming up with new needed features,
> > and that maintaining forward and backward compatibility
> > becomes a whole lot harder than it seems in the beginning.
> 
> Yes. But as you note, this shared memory structure is a userspace ABI
> all of its own, so we get to make a completely *different* kind of
> mistake :)
> 


So, something I still don't completely understand.
Can't the VDSO thing be written to by kernel?
Let's say on LM, an interrupt triggers and kernel copies
data from a specific device to the VDSO.

Is that problematic somehow? I imagine there is a race where
userspace reads vdso after lm but before kernel updated
vdso - is that the concern?

Then can't we fix it by interrupting all CPUs right after LM?

To me that seems like a cleaner approach - we then compartmentalize
the ABI issue - kernel has its own ABI against userspace,
devices have their own ABI against kernel.
It'd mean we need a way to detect that interrupt was sent,
maybe yet another counter inside that structure.

WDYT?

By the way the same idea would work for snapshots -
some people wanted to expose that info to userspace, too.

-- 
MST


