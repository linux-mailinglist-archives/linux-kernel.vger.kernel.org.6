Return-Path: <linux-kernel+bounces-263271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0093D38A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297611C23171
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A417BB02;
	Fri, 26 Jul 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq0SQC1Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E417836A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998349; cv=none; b=lOrp4R3XIluN/qtaKEhfZ8yFAMrR0vyS/QraK5SPdMj1jErNMTsUsWEZ8GoNGLxYBp5R9SSc4HKFxOoGR7lIbenV4JmYEMUg76ROFPTbV9XMdAUFOZ1JZPkoyr2mb4To9XGIBCmkiNy92axYT2LwkO3uDQLSpgEdgWvTSKNJsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998349; c=relaxed/simple;
	bh=Sp+ueQmSpfGLiC6k78+rR7dKtxhLr7HvODWfBRy/H98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAhPxAxh+2F19ocy7d3HMa+tLm+0HVo2x0tAGbBgVVBAzFSPgghqPa66n9Sf+b1bjLwkeYRwfZdBbOSBAxQjvpnbauUZCkE1Jzx4IsJQQE9NaS/QAANPEhi1g4Mj/nD/3raRew9LbfK55WyNihxhuKpzC39NgqFaFr3QpblnSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq0SQC1Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721998346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
	b=Vq0SQC1Z3zBZaXzYRr5LrIjdoItqkJT0a9bcNDeMFdJ+wxIj5qVy3b0VyV/GXdzKHBE0Cd
	Umuc+l9oQKi3fBGrhkQO0/xBfL2KfkzqIlwrjkfNFf7JuNa2GKjqeYXfkLgpbRriR/K5hu
	qcg1IvAHRbWHhrFjMPizxXRay5vu4fo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-pELJYxzQOTqFswDoIOC2Gw-1; Fri, 26 Jul 2024 08:52:25 -0400
X-MC-Unique: pELJYxzQOTqFswDoIOC2Gw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428072eb4c8so12933935e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998344; x=1722603144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
        b=C54+LUcrTNuiaBHTM84Z13xGJ0s1Tx2XPeoPUHDkZ82m1hd1niUxKisqvtY/3teZTY
         SeBROi8LaB38gDHC25LcSqW++B4hM1UDdKcFYJQgZ+Rhe/EEosAito6ehVvJuUdpilV5
         mRrYmWn/iBYBpVAoFN3TPZe6UxS3CTMqK/X8W+ipek7AK+sftAXD1a8gq7C4c+GPzHYK
         dNUqeRvwbE1OU9J2zZDqOevtwk52RL5CjD9GCiFKEeiyTcI5IHj1IwARbH8KLhOQwNTC
         JvUUs5tf8qyud5Qj03BEEmizXtd9gib5FZrS45A+cohZ+ixJbdsF9aH/QpQTnplNeyyV
         0HBw==
X-Forwarded-Encrypted: i=1; AJvYcCUu6HeKt6LAwnfaFTMkSKD2nkuAeXP7dkfvafNYu9iqQzi44LIHZ0w6VOy0djio1wSXj4FAoBnv9T8M4ITN3LI/vx8QmvWdKldNPtV7
X-Gm-Message-State: AOJu0Yyiyfia7c3O60i0JZO/j/9pXw5pTPUwUJKyTy3p/x1ncnyI4jx1
	3eaDMRgjnZo3SML3CySgSwuYrePETeBMW+eTM/0qoDxTWlQPmFq73295xK6F1OY8K4qwOh4CDKA
	jvjmtlW4TULpYbW4uMtAAB7Noda0N5aluwBOn9K6UjIothhE3gxKrEaKNb5Smfw==
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42806b94444mr35917555e9.17.1721998343808;
        Fri, 26 Jul 2024 05:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZtYe8A1GZTEmL+i7voXFimPt8dBDRrCiuydzX4tPFYqbNapaldNesLi/P0+Gt5ylw7JbVQ==
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42806b94444mr35916735e9.17.1721998341579;
        Fri, 26 Jul 2024 05:52:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm5219141f8f.107.2024.07.26.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:52:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:52:16 -0400
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
Message-ID: <20240726084836-mutt-send-email-mst@kernel.org>
References: <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
 <20240726015613-mutt-send-email-mst@kernel.org>
 <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>

On Fri, Jul 26, 2024 at 09:35:51AM +0100, David Woodhouse wrote:
> But for this use case, we only need a memory region that the hypervisor
> can update. We don't need any of that complexity of gratuitously
> interrupting all the vCPUs just to ensure that none of them can be
> running userspace while one of them does an update for itself,
> potentially translating from one ABI to another. The hypervisor can
> just update the user-visible memory in place.

Looks like then your userspace is hypervisor specific, and that's a
problem because it's a one way street - there is no way for hypervisor
to know what does userspace need, so no way for hypervisor to know which
information to provide. No real way to fix bugs.

-- 
MST


