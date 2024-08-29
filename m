Return-Path: <linux-kernel+bounces-306828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F596443F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1731CB23D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F068195F28;
	Thu, 29 Aug 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vb2E+z62"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5B44C77
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933981; cv=none; b=INyV2+NORFAB1/4/HeJBy4K8wdSExieBRLt46M4k4It0Q0DsiTdbs60feGq6jGJqLNg0SFHTIYe5cTgO+1Gcfl1MYKXu+vRLYeLsZJ7Yc4+STXf1HXXkg/ImwCNpMVjbsVWcUsclfV0tYERUGFDywCaXdOUg93ABZNGYdaTF0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933981; c=relaxed/simple;
	bh=mY8Dgd+cyNhrpv+N1nPy7rifO7MGwoUjGwjPCFQ5g1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAJ5DpXhMVSXrh8kUmEROBEjby0iixH+0k3E+JQGmfGhBWhfeyOpY8uFBnJutE90HgN218G5hgffX4T/HZAyMZuwiCV4sMpvtlqrti3yEmxI/H6Q0qrlsc4M4ixG292n2ocZWmzc5xxExxRUP6SOBuW3cBEqttI4ykeWB5QUEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vb2E+z62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724933979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSkQSupYh8srGReshPqFouB6VAGU7iib2jvE4nu45yM=;
	b=Vb2E+z62TlDAznLJuT/imuSvsgmYB6h2suIwpWPHIh5q1iLPkXVgw1dZdEdXKjZn/eFGzg
	2uz0xYyzH1UEyKYgCPhRgnhQR2RlCkaAEhE3JVfHyn0QtIaPkHdRjOlurYt5cYl1AWdQhp
	yGiDcWZfV2V4CUPkbOU26ElwNnzvDAg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Xyw9-EQpN9eJRPd18ZOUZA-1; Thu, 29 Aug 2024 08:19:38 -0400
X-MC-Unique: Xyw9-EQpN9eJRPd18ZOUZA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a86975f70a2so45139166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933977; x=1725538777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSkQSupYh8srGReshPqFouB6VAGU7iib2jvE4nu45yM=;
        b=bLrsQmY6nMMC64+mG/nmiWIRBt7rxq8hhDHHa32blLMpzc+g7F60CSqjDDrebqlRRv
         FiDH0hvBAT3o8eOBqD52qDv/tj+0dpUQS59bibBm7BF11WogHmujLxcyfIMPdQbRJugE
         nstRjbHtHw5uxbHMwA2+SmoPj2rcu36G/oUSwm+SU0oGqWgsLbSO8PN9AhuCFyi6/4kI
         wN/X9Nya+NYEvIn0yoIPGWrhDvvo/ZaEh3z++ojON4DUmFJxVJP8B4jq/jLVuzkF6PE6
         SzvFeNvc30QOMSIdUV6wB1p8b8SXEgCY22DWUXbDMqyao3rFwb74J5aB4hGtDsDh3ZYQ
         QOvg==
X-Forwarded-Encrypted: i=1; AJvYcCUReCNNgA/fIWFAcuj0LMZpOMv9qJYa2mait5lJW7fGq8ipN+OYWQKRV+CHM6XLyHjel6iK2adh7jAiUM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQpmnbdw8tnyrnRBMkfarCGOlwNlt/g1jrMgjXmBepMuFADAC
	pxOElzmD4PgT05ElSifkfnxvpQiU8BCtZEwS73w21cNSZEq3pjzMS18XEgsDb1sgteZ0btlwjIL
	5YcZ4l5naZTBYoHC173ZghfP3Q5RGk+GoHzuqSN5dfb62eHS6tt+9If2/KWtCSA==
X-Received: by 2002:a17:907:9712:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a897f930bbdmr199686366b.34.1724933977000;
        Thu, 29 Aug 2024 05:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG9hsNF/FyU7NjcehPXdOC7KV+W3lxtyv+s5kfZUVe/jX8oMQoKUdOVwW1ijqi1fRaZigcQw==
X-Received: by 2002:a17:907:9712:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a897f930bbdmr199676666b.34.1724933976116;
        Thu, 29 Aug 2024 05:19:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968f4sm72412366b.106.2024.08.29.05.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:19:34 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:19:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	marco.pinn95@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <20240829081906-mutt-send-email-mst@kernel.org>
References: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>

On Thu, Aug 29, 2024 at 01:00:37PM +0200, Luigi Leonardi wrote:
> Hi All,
> 
> It has been a while since the last email and this patch has not been merged yet.
> This is just a gentle ping :)
> 
> Thanks,
> Luigi


ok I can queue it for next. Next time pls remember to CC all
maintainers. Thanks!


> >Hi Michael,
> >this series is marked as "Not Applicable" for the net-next tree:
> >https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
> 
> >Actually this is more about the virtio-vsock driver, so can you queue
> >this on your tree?
> 
> >Thanks,
> >Stefano


