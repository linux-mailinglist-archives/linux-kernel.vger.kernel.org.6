Return-Path: <linux-kernel+bounces-264599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF9693E5D6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ABA281663
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA15914C;
	Sun, 28 Jul 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQNdLsIl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FB51C4A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180249; cv=none; b=mhISH8gF6lOmmyZFx7BoQ8yqQUPLrKJ4+AX7CbEdwseEKazvkxC64jSYmidYj3++dwa+OqsRUOsQkNfrEmLoFZzOiuMwQOy3V6QehJFn2VSLm3LVO/V8cwPP1knOZsYz6gg05MLJ8p6jEg2pKyYSKNvPq7/0dhtmijvByRAE9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180249; c=relaxed/simple;
	bh=IOwAsnqgHoluJc7mNb67jddHNZA6RYbBXNw2KHo1ji0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxEX9cvPdcaMBq7NT5JKxLuO5u69JLk4XTWHQItvvYdnQ6IokWRaUGCwXSXYIXwnS1FCt7ZNr/tNR6A4BIzv8cX+3MikAFo0t4u3i1+q6C5UI1Zhaocty5eqYBCyxrbC6rTn24NYQEHQQHwjQTHyGKFevNaAu5g5/j2QPELTucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQNdLsIl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722180246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
	b=hQNdLsIlItzkDPG97Tbgc91BSAXRd13R7qk49ma8jTRuMSI12RSyrJiwPceiWt3TLMpdp3
	ksLdXYkyy6KcayM02HZYy8/l4ugr+KqoMoJnhScN1mMWOtVO5M7HkoQEJvh4EI723MoZv6
	aYvqX8vgOQzR4OMIRwuveSkxf6GpQvM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-cNZn_8WAPieNnGFmoikc3Q-1; Sun, 28 Jul 2024 11:24:00 -0400
X-MC-Unique: cNZn_8WAPieNnGFmoikc3Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef23a67c5bso26799621fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722180239; x=1722785039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
        b=Hpc58ouSE8ilyAFDd+4w/3JitARl+RjWO3OuvfQTfZ7JVa8x3SCJ27jAby5tzwTdwC
         qNu8fPpt1HR+ytZ7TBLUP2Xzbdcnsa1fvtEzWY3Cc3bd3Qx9kVC4YvIm1UwWVswDS4SC
         iWOjeSqNOIHZs5W42FHD8vgBdBsmGjyd9Iq7fs+Tz2doUIVJkkleovTqvv6yy0kltGL7
         vMiL1auJrR2Dw/4TGfc/lyvMgSKD9j91JuYV3ZZpSCT4OgT3kF2YgMG9YB70sZY+OopG
         AjuzHaMBtsW5UZlw0mNqwuoRvhD0ZI/4izs+PyPH0hguOeFIPo6mZNzRsI319DXu/sWj
         kndA==
X-Forwarded-Encrypted: i=1; AJvYcCXf+Zvbiu+XlWn9IGx7CLdWuSR39cjY9Vu/3BUX1RFtlrncpRhSRFVyPscybT94+hdfAOXMGCllB6qwz23M5o7p0EuaVgYNxc6ztu18
X-Gm-Message-State: AOJu0YzV7yOPXiyqWKch+Yc5JbgjrwP9k1crgSulZZXMMN71zsel+Kf8
	jkvAlbWS648S0t+c80MiC5uCRMQfa3J4gcuvwMeLsdY0bHwghty4A8zK5DKjgSDbMZjogQE4SqN
	fU5Bqo1Sx4JHWTNxKSGLVIEN2dLKBqfV9MEHIMgQOJN9pxjTqtjo0M9w/KM7gsQ==
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2f12edfddc0mr34329471fa.16.1722180238924;
        Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU13tBt+N37F7ob3Jx0ruuvo8+dsNp9muZtzaqjHOl31gS3qTrnO0jECcjoxvWesNrjNQyHQ==
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2f12edfddc0mr34329181fa.16.1722180238084;
        Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428054b9196sm147521925e9.0.2024.07.28.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:23:57 -0700 (PDT)
Date: Sun, 28 Jul 2024 11:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Richard Cochran <richardcochran@gmail.com>,
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
Message-ID: <20240728111746-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
 <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
 <20240728062521-mutt-send-email-mst@kernel.org>
 <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>

On Sun, Jul 28, 2024 at 02:07:01PM +0100, David Woodhouse wrote:
> On 28 July 2024 11:37:04 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >Glad you asked :)
> 
> Heh, I'm not sure I'm so glad. Did I mention I hate ACPI? Perhaps it's still not too late for me just to define a DT binding and use PRP0001 for it :)
> 
> >Long story short, QEMUVGID is indeed out of spec, but it works
> >both because of guest compatibility with ACPI 1.0, and because no one
> >much uses it.
> 
> 
> I think it's reasonable enough to follow that example and use AMZNVCLK (or QEMUVCLK, but there seems little point in both) then?

I'd stick to spec. If you like puns, QEMUC10C maybe?


