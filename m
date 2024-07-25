Return-Path: <linux-kernel+bounces-262185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C993C212
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA31C21ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26737199E87;
	Thu, 25 Jul 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqfDw6++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0211993A4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910582; cv=none; b=AHTSB2AVLofuMtN9u4Kubg6qA1vAElFuBCLbwwhI3u3e/+sNijPcSQ9gdI5KM75y7ZP8GqublaJANQI0plrgUwHn+8pvJMlsIp6sehJrW1U2yjCpYaloDFXfp8hAFG7CPr9ascAIg2nfLg7A/2INuTMSxxxisXrye7CfE5uFJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910582; c=relaxed/simple;
	bh=1x+MRrK/gKvb0AP5m2fDvNNFyowu/Kb6wBFKgceGBH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo/Mb4C4OGlNKSoRBthpZuxKMXo3urf4ZbJnlbMaxDAmjHtHKLc23quGeZ9C9OlYg19myLF3lLECdLfoekp2xKds9TP0H52vTqZXQLsPo8LelNpwJyHq4TezlfqG/xoYXCKvhfPSzWiROZFCP1DAC7qx6O7YWSRiLJOSqvXjKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqfDw6++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
	b=gqfDw6++CVupAPu02BFuEpKOKpavCO0AnR4w/Ko7O59nNmkCJBXvkM6HIWxBufVDNA2Tcz
	88SpRbSDivmnO4gto0InI9MgO8HaezSNDDaJD38uBjo05dkWrYRslDPQzyHFBu1Nw26AnH
	pt94KUM/X2eKFGIft0HwLhOuK1idktk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Gpj9NuYEMdqCXxiUA9LZVQ-1; Thu, 25 Jul 2024 08:29:38 -0400
X-MC-Unique: Gpj9NuYEMdqCXxiUA9LZVQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a8b0832defso1392043a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910577; x=1722515377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
        b=uDS/3F1Ik7PH2h0iRopv6YC+NjzV79n9X81s7Xv3h8wwiKNW7OCR/ctDRGWRJNH2fM
         1qKaNK0Ag2zDM2Rfif+ydF0vdnT7zyqXLLym8cZ/p4v4dW/TYT4WCeI93FSLyzBZiJwf
         2BV27CkxAjfmPDo663Fiu3xWbhW44ZWf0dznAZ1hNwgYk6ZA9OnedRvUu/z86ayViKjr
         tl6t6tDYSJB4Ge1H9SRExV317T9u/ntH684InxkV6bAMK5hNN38w/asE1oqhsVe3tS+V
         qiJ2oTeoVbEwVa8mLxo8Jg1P+/pNv+J/ySfQ0AXFh4QXni4IB+w3w14wmbyYFVllTGqD
         kkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYopkcU3t3D+Ep8TlmSr1JWzk3mQQhRnt2PIkHXJS9bhmTfhmOS5kkmWTNaGlOObp0G10J0I4l9zn1HKKqp5t2geVBfw1qe8/hHP3d
X-Gm-Message-State: AOJu0Yz7gxSRPlJgcJ10UUvjXFwkXaPMxam81Kwhy/Xi40Q1ipMqKzAM
	Jr49Ja7KtU9jdAZtRjs4n6jdSjqWPx3lYsv3bIZyBtD3kegBB146/dEoPhqPoHOmV27BVn2+GiU
	dO1HKCB4dtih2n79dDtMvLurtcEaybTLX3REJWfmkF4SQlCJqjqa0XEFoG90Lhg==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr5616856a12.10.1721910577478;
        Thu, 25 Jul 2024 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESzTf1Dq4jXq+lb4GZ/ln7u62lD42/qJf2maAOGtbm2TYn0twTp0kEGmFg6gBHrHiC+FsesQ==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr5616818a12.10.1721910576749;
        Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3becsm768874a12.74.2024.07.25.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:29:31 -0400
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
Message-ID: <20240725082828-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>

On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > trying to keep two specs in sync.
> > > 
> > > The ACPI version is much more lightweight and doesn't take up a
> > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > complex in other ways).
> > > 
> > 
> > Hmm, should we support virtio over ACPI? Just asking.
> 
> Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> exists with a DSM method which literally returns DT properties,
> including such properties as "compatible=virtio,mmio" ... do we
> already?
> 
> 

In a sense, but you are saying that is too complex?
Can you elaborate?

-- 
MST


