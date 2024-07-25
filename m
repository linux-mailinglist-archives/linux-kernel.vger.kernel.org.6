Return-Path: <linux-kernel+bounces-262162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40693C1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1661C21DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA719D896;
	Thu, 25 Jul 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjEZWket"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82419D885
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909846; cv=none; b=BGl6kFGBP4fHvio+N8H9Syuqz19GVJVxsPYY/qbugx8VzBp6lBe1kJKsdM5fQXj1/sLLkVf1loRpXapPGKibG3e5UbfpISYSzQXRoC3jeaMCUBqSY8bwus/XVhGm1KPgpBLQa/pk7xgjfw7S9m61S5ABx03mnnVb8m6H2euD9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909846; c=relaxed/simple;
	bh=HVM0mVlaCtLos7f5wbrHV96ayPcblkpUKWT9CLfBrMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONhvcnNUsycKbn1FkeCnASfghcLEvK7Ci9qVsEjlrjkBTcRJ1YcbS9Vb8y0c9LqUYiGYgmQkes23xzvxZk8M0Ke7uLYWLx/sw/K2L07gi9VKpMPaaXQdeOEQsG+BeorVr49XaEkyDeFR1AblAWc+5qa/SiugDd/pEJPjc2a4UhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjEZWket; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721909844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
	b=WjEZWketa0yiquvy94lDLg026dn26dZaGXbJFOBtXYzJQiVIx9Wgmvgq2DFHs+trJRPPCh
	b70sWYVIFo98Y07furRnuFanzQiRpyKOdst3T+LHpXYTNrSlEEt062/HWxJWpADjYEyTOq
	bMtYM0pxBNAU4+uktjbtd8mlEf5UmuY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-IVvAzOZKPtGX3bCosfpTcA-1; Thu, 25 Jul 2024 08:17:22 -0400
X-MC-Unique: IVvAzOZKPtGX3bCosfpTcA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36878581685so494918f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909841; x=1722514641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
        b=YsIDwxRsLzIWIvJniNdrBZEbQPmxxh91SXTdJ9u9pPt+5+yDZJwA9kQXcqDq2i4Gm6
         8OUCaUvdKOjJqmI1pjRR0ohXMbxOviJzGWb5orPT4Rz/THllz1G/DAem7VJZ7q4ch284
         x+aw7P4wa57Zr+k44sXMmLrgWPT6EYFVxqVEnGY6xi3Uf3FoR4hQgLod293qdHcFUied
         /RVUXDVNUMmq34ubl/AnSEWvRWrnVZOLY71y+18KJe7KYHxyPbyT/8O50V98P4HWKXkr
         CkWLwnMO5L9gHp3PXOga12goT7P60xL9/IE4460bJ9hlpB36SltXui+0vnqxoBthPe0f
         XM3A==
X-Forwarded-Encrypted: i=1; AJvYcCUuM0g6bLxz58BhT3xiVVRSwSUL01E9yhuy4AUaDIoTmN9CbbZs77pMyyd6KeJvEM92Bru/cDCoZYa8zraaZO1aVyeUmeo+Jfqcx1iJ
X-Gm-Message-State: AOJu0YzFqReumulA8zNYTnTLzlXpWBCPX+zbAzKLtcumnZQepDzWHUzJ
	s/yU8lqEExrHWdynSZBfXs16GXgiJwPEViAHRZPwEp9bbU7EnwgbV8EP6z3OGa24Sfh6em0VEk7
	PtAz3Im0aJV+IoFqRm3If5y7e96Gs5cQwUIYpDTZuNE3aJF9UcW9PkUW1mG5+pA==
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id ffacd0b85a97d-36b31ac7126mr1799102f8f.3.1721909841501;
        Thu, 25 Jul 2024 05:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEKfa12+yv+9oCURpazLfKX3NylqFM0NYsmdlmyULxdYJys5id/PrGbgGHwZdmlDCg2IQWng==
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id ffacd0b85a97d-36b31ac7126mr1799053f8f.3.1721909840718;
        Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:1b05:4ed8:7577:e2b:7ae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm1983920f8f.109.2024.07.25.05.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:17:14 -0400
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
Message-ID: <20240725081502-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>

On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > Do you want to just help complete virtio-rtc then? Would be easier than
> > trying to keep two specs in sync.
> 
> The ACPI version is much more lightweight and doesn't take up a
> valuable PCI slot#. (I know, you can do virtio without PCI but that's
> complex in other ways).
> 

Hmm, should we support virtio over ACPI? Just asking.

-- 
MST


