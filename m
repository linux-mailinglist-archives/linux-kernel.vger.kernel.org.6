Return-Path: <linux-kernel+bounces-262300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D493C3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C61F228A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C219D087;
	Thu, 25 Jul 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIRE/muf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734019D07A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916689; cv=none; b=DZjBx11r9mcmP6NmlSOLAqDc08usiH1KhAPn6t7ZS77GqUfnnbdVKTDrKnBFnpjc0Ur1xDftvzhIAonLTx0qPTDJKIhRtlCy5cGEpLh90QWfI4/fHO3UKXc/y/Z03iJh3NH559wh3j/wApy6iCOVlbTZW30HVshd6u27PTI/1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916689; c=relaxed/simple;
	bh=o+d3VCUm+XiAK3Nsbsy5WUA3R0e+3/oHGpriSysq0og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBpbKyzAqIsp37TojKRa7UW9CfAHCU6OIe9/caP0YdEct0xWMEvrK26/nbEzW0n55jW+w4KiGBMhnM0ZCi7k6F1Umg3/HXWUz5DITKWGEvYcndMTknWo7l++p8p0h9OnvFH+wVMUQ/vUEXA/qd68nUmc/jbFwVazgyFWCXbP0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIRE/muf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721916687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+7qqjfSJJedkSM0ho4FvwKX/Ww1MNIJK3ukt4D885M=;
	b=TIRE/mufZdCghlu9Z1l1CGMvcUwJgr2twMFFGVvqQWj9Od+Gbphn7F1BDPsyqc6sCT2eO+
	sTyL6nSvIj2QIgyAGd6EbqL+yTNoNPE8EdFsqje71PcVBLq80+lP/QCHeAu/NiSzKz24Lm
	PGD/oxj0T+snHqWwtrtEL+oKaJzP9GI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-LvCFK4KlOuGVAoxRGNkdHg-1; Thu, 25 Jul 2024 10:11:25 -0400
X-MC-Unique: LvCFK4KlOuGVAoxRGNkdHg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-427fc86aaa2so6912205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916684; x=1722521484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+7qqjfSJJedkSM0ho4FvwKX/Ww1MNIJK3ukt4D885M=;
        b=A8yD9KSzRxGqwLYhHY6fMA1v1eFdAXCfMBVRQb6uIEDkuuwLo+L45McMkpk2lqEBcr
         MbqQ9VvZsXA4t7ZwCv5PjuKtldtBGOEcvj1n3QHXTXrHlGWjM7sxqAexZkCVGhmhS6d/
         O9uy3o7ZI1Q336sgElCC2kIKFjTi5pcm8R9zguMib8CXSkzs32QZUHOENi4xUEdX9IDh
         yrDEb+3fyo3e5MS5AZGYmAVZE3zAfokwxD6TFGvXj7StY3DNf/1wFepMRqTjb06u3V05
         UGI/w84b2ce8A0KeQBkXKvAsa2oQKgkxqDplOPJ7nvOisTe3F0CQNMkYMv9U7c7MZKRU
         lqMw==
X-Forwarded-Encrypted: i=1; AJvYcCVmay7zOy/qp71o5oc1f50hZ12QpmUAFkM3RdpHWiXJYXp3QQBQPShPhlnjs0zRv1tFw5O9O5k609pbKLF9TnV2G3WWsu2dkPUOKCx0
X-Gm-Message-State: AOJu0Yx+53zl+AurjL2cXuqDoF6Dq9Ap7AjRWMAY2FG8KkrPvif8arTP
	Zv5IC64e3ZwLT4B+OaPH4PD09QaAiK2aqz49FvVlu7FMR6YKllg7l3DO7CxcGEr1V0pppYKLaN5
	vcAqBO2tH8eleq5621inSsdktzrg6hmSDm2jfhG8bHctf4GdWQnktttCQM3yowg==
X-Received: by 2002:a05:600c:138a:b0:426:6320:226a with SMTP id 5b1f17b1804b1-4280548fb4cmr18426065e9.15.1721916684224;
        Thu, 25 Jul 2024 07:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNsRboMyhKaoJYp9kK8awnKz/IQ2dhEpvJdwFDL7IFTPJdpWaM7Aqb1Bj5iTJbBTmDrGoXmQ==
X-Received: by 2002:a05:600c:138a:b0:426:6320:226a with SMTP id 5b1f17b1804b1-4280548fb4cmr18425765e9.15.1721916683628;
        Thu, 25 Jul 2024 07:11:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6307sm37266205e9.36.2024.07.25.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:11:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:11:18 -0400
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
Message-ID: <20240725100351-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>

On Thu, Jul 25, 2024 at 02:50:50PM +0100, David Woodhouse wrote:
> Even if the virtio-rtc specification were official today, and I was
> able to expose it via PCI, I probably wouldn't do it that way. There's
> just far more in virtio-rtc than we need; the simple shared memory
> region is perfectly sufficient for most needs, and especially ours.

I can't stop amazon from shipping whatever in its hypervisor,
I'd just like to understand this better, if there is a use-case
not addressed here then we can change virtio to address it.

The rtc driver patch posted is 900 lines, yours is 700 lines, does not
look like a big difference.  As for using a memory region, this is
valid, but maybe rtc should be changed to do exactly that?
E.g. we can easily add a capability describing such a region.
or put it in device config space.

I mean yes, we can build a new transport for each specific need but in
the end we'll get a ton of interfaces with unclear compatibility
requirements.  If effort is instead spent improving common interfaces,
we get consistency and everyone benefits. That's why I'm trying to
understand the need here.

-- 
MST


