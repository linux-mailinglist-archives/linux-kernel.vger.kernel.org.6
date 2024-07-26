Return-Path: <linux-kernel+bounces-262860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002EC93CDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA932815CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5023BB25;
	Fri, 26 Jul 2024 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI9s9kfq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EDD41C69
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973987; cv=none; b=InYvqSIm8EEw1cjPV5TlBdDYt5iAEvjg15KMD8AuN4ewsjm36Gq737A+nMzc5GxCFSvX1I35kJuMPjEyr4xotsI8p/8rYXP35GJZMEKqJdHbpfeKBcG6owHtBheLH3zNep0M+Hk3/YbiRd0pDkhrNVeZE/4GVgIzOZYFdesGoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973987; c=relaxed/simple;
	bh=6a7x76ue8Tb/QiSBhzrn7bO0FzEBds6B8ZU9VxKhPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el8Qyvs6PtJNmrmeO1HeiHtJKRrhkpa7YgFaUJVUi8clWlS9d2h9wrzhYK8Wu03Nd+GEhNlZ6m0TPWEedcyCkwvAlxiNMcLtcbAXGcO3V/uCs+8mqhsxZcFxX06VlOiW4wFHjQisLX/hDAMGgAma5rm84ihhIaxb/g7PXEtdCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI9s9kfq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721973985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
	b=KI9s9kfq78/gvr5zC6Ormvt+28n1pba2r78xX/StLGt7sWJeTAGo1ZlRxfhDHbD+mqNZiF
	JPnGezZqD0NI+wtHNlIzZX4VkN68+KLu0MMyY4SPJjpFppQ9Fylw4ws8bW6kqbrH7ddYeA
	qMBPcFRyXSfOD+cJzdxr5Bm2CYSb+Ws=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-pfejdKUXNJiNBd1rJAnYzw-1; Fri, 26 Jul 2024 02:06:21 -0400
X-MC-Unique: pfejdKUXNJiNBd1rJAnYzw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36863648335so1041044f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973980; x=1722578780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
        b=rkGDgXYcwQBufV1YEdpPK2Tswo73i+XMkXsu0sQ+ZtpbP7xEnxQv+7pa2UgWr8nekD
         OsBAE7tUS5tlW1EuHbR5KjLN9nB4lHSAlkVYKZXy06qA1iORuhzE0HrB02K3iiItg4dy
         Q5iWVIWSAv+PNEKZDJlFqtAlF4+lJ88QOM9pq7nhrfIzQ+r54pocG1XUNO6EOHgLEktH
         ixCfXCcHj+5CctVb4BlmdYZYG3DNHVIOAaftG3t3Mp1vNsFRoV7Ka1k3/N75dCwk9z65
         NT+62cWSJuatr034y5oh3gwtjtrTDiYCTpIoJo3yHPWX4Vb1QWzQ3568j7QUcp6u/9pi
         wxwg==
X-Forwarded-Encrypted: i=1; AJvYcCXpShQTFuLT83TUbLNbvagkfRxikxPjeMx4Dw1ngwi3cyCoypjDv6tMWQGXnwQM1XUREpC70Ye+KjJ0qeInYCeqlEadxls7ocBHn7Tx
X-Gm-Message-State: AOJu0YwAzBciOWVJ/dlOjc7UyRCY9hOx1y/i3W0exbwN9+XpJGGgniFm
	aA4lx8f82SeaY+Iyjz0XX//AP0s0I42X9O+USX7B7nIYLJwJ97aKwx8j9m6avuIZK9SMjCrQzt1
	Vl2uM0yanU1daiELCUJN+i073AhvzoxflKJCRK8iEzPKFN5SOcbDHt6+g9WdGLA==
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555941f8f.32.1721973980461;
        Thu, 25 Jul 2024 23:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcqinn2RbOzn7J7peOWcha9uEPwJVbe5Fk8jNLudEw/NhTNHYXX4sldsTgb73GWvF/16VyA==
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555913f8f.32.1721973979719;
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm4031338f8f.109.2024.07.25.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Date: Fri, 26 Jul 2024 02:06:10 -0400
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
Message-ID: <20240726015613-mutt-send-email-mst@kernel.org>
References: <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>

On Thu, Jul 25, 2024 at 11:20:56PM +0100, David Woodhouse wrote:
> We're rolling out the AMZNVCLK device for internal use cases, and plan
> to add it in public instances some time later.

Let's be real. If amazon does something in its own hypervisor, and the
only way to use that is to expose the interface to userspace, there is
very little the linux community can do.  Moreover, userspace will be
written to this ABI, and be locked in to the specific hypervisor. It
might be a win for amazon short term but long term you will want to
extend things and it will be a mess.

So I feel you have chosen ACPI badly.  It just does not have the APIs
that you need. Virtio does, and would not create a userpspace lock-in
to a specific hypervisor. It's not really virtio specific either,
you can write a bare pci device with a BAR and a bunch of msix
vectors and it will get you the same effect.

-- 
MST


