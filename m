Return-Path: <linux-kernel+bounces-263281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EBB93D3A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03B5285ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F364617BB17;
	Fri, 26 Jul 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGL8FSUL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756417A93B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999093; cv=none; b=VhGQbVhIWauTxZ2a1W4tZBaByqV4CB9NUhNsByIef1dh7vDhyfQZBh20KHDBuCZKpRXXGU8gKDaQnqRNR0pp7rAoJ3r9DQHwCVFFkUTvRfQSO1uVfVnTXawYwPwztvu/S0m1gTkcmpSfnl3ZEoEs9iVjRooY+JvlV6UWf4j/yZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999093; c=relaxed/simple;
	bh=uO12G0ckq47fIdqtlyWIWsBBD7gHquBqgoUXT4gDyT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZygt6XOnVBcoWymo48e2CRwIPBDpGVaTA20GQEjOReVvld4uClZxfcEVuYs0D8ty04UKVbV7k37pCoIw/5Qfbuh11SQAs+ESV7HR/5rg3kVD7S7ADRbmDF2xPuPHkm2TqXlLwtfWwyZRUzv+B4XPeZ0A8al7EPVGxll2Ot977k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGL8FSUL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3g6QURrGZPYRxDC3Hx/i8519mXf108ro6Hrgt5KPqY=;
	b=hGL8FSULNU5z4NB+DXzdJZYqaz+t6j/sT7raZakvbU0pP9c0ZurfP+5Zcf5736qy6V6dzM
	diCvqxtNryEoeNstld7nVg3FRJzB7tq6EhCdtO+VgAE852UwHFr9ktm+uFsSObAuf9Qbw7
	tcqiY/r1/y6O0iA71Qxi05B7cqTOHoQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-9PjhRBRiNjyp8bMhr6i-pA-1; Fri, 26 Jul 2024 09:04:48 -0400
X-MC-Unique: 9PjhRBRiNjyp8bMhr6i-pA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42808685ef0so10322515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999087; x=1722603887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3g6QURrGZPYRxDC3Hx/i8519mXf108ro6Hrgt5KPqY=;
        b=HuvO8fmFCihKm8twFn+45/lzVnlmLo1I84y3R0Y6qOJeb8J84VBFSQYhATERx0QevW
         t0DDo4miuSpqvH6tC9NOv7Nwo4LFLbaNUKE/PW/h8OaCYjD8FFd3lrLXyziGrp7qjduM
         PjxAOKIQB+DILy5/7iyPhEq0176phoILrc69H2Z/XeDLBqgRv0nvSL4oqr6OKtT5Y/x+
         dKgKVpnduWPimiAd2uJGKlbkWYeIb/P1ZrruzNhDw+vMmFBuPhTp+B16oo9Rx9yssznp
         ISPugbkwBmBIg6IQ8dYToKvaMrm01c+ir+lEYPm4sdnd7UfSrJHZ6s6vLMMpqmt5NcHR
         DTnw==
X-Forwarded-Encrypted: i=1; AJvYcCX7kYuypQaTKYC5Qir3NFrcngudjnDOGTR1uyFAuXiF+2ceNW2XwMcmYV5aOLRurHrLUcdvHdCQQ9DwcadjgIeVGzYANxbc7zSjA1eT
X-Gm-Message-State: AOJu0Yw5whZkWI4tNl9DZVX1xJPjDuImZUduuJberkpkk5/5bWqNBtB5
	LR3GP2h5cObyAqu8KxpNucnMc0D3ZAaH/R2zOLzRWwCy8BukK/O8z1NH+2IP2dDCz9TKC9HEnLQ
	Bczjbuj7cTYVjI7xlXI1S/U7xMYhHKo3Q9uHCRhcp6L1H5yWcx2uFUCtu58+nHA==
X-Received: by 2002:adf:f40e:0:b0:368:4ed7:2acc with SMTP id ffacd0b85a97d-36b3638148cmr3751282f8f.5.1721999087364;
        Fri, 26 Jul 2024 06:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2baiiVUKUBh/QT4ya/E9LOG3bE0mPK5t7EPOeVJPpQaN0mCePZ4SEB2ju0LD0SShA7ME5CA==
X-Received: by 2002:adf:f40e:0:b0:368:4ed7:2acc with SMTP id ffacd0b85a97d-36b3638148cmr3751249f8f.5.1721999086564;
        Fri, 26 Jul 2024 06:04:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36801828sm5090963f8f.65.2024.07.26.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:04:46 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:04:38 -0400
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
Message-ID: <20240726090326-mutt-send-email-mst@kernel.org>
References: <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
 <20240726015613-mutt-send-email-mst@kernel.org>
 <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
 <20240726084836-mutt-send-email-mst@kernel.org>
 <c115fa23a5e297284c14c1f7118ffcc3c9831097.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c115fa23a5e297284c14c1f7118ffcc3c9831097.camel@infradead.org>

On Fri, Jul 26, 2024 at 02:00:25PM +0100, David Woodhouse wrote:
> On Fri, 2024-07-26 at 08:52 -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 26, 2024 at 09:35:51AM +0100, David Woodhouse wrote:
> > > But for this use case, we only need a memory region that the hypervisor
> > > can update. We don't need any of that complexity of gratuitously
> > > interrupting all the vCPUs just to ensure that none of them can be
> > > running userspace while one of them does an update for itself,
> > > potentially translating from one ABI to another. The hypervisor can
> > > just update the user-visible memory in place.
> > 
> > Looks like then your userspace is hypervisor specific, and that's a
> > problem because it's a one way street - there is no way for hypervisor
> > to know what does userspace need, so no way for hypervisor to know which
> > information to provide. No real way to fix bugs.
> 
> It's not hypervisor specific, but you're right that as it stands there
> is no negotiation of what userspace wants. So the hypervisor provides
> what it feels it can provide without significant overhead (which may or
> may not include the precise timekeeping, as discussed, but should
> always include the disruption signal which is the most important
> thing).
> 
> The guest *does* know what the hypervisor provides. And when we get to
> do this in virtio, we get all the goodness of negotiation as well. The
> existence of the simple ACPI model doesn't hurt that at all.

Maybe it doesn't, at that. E.g. virtio does a copy, acpi doesn't?
I'll ponder compatibility over the weekend.

-- 
MST


