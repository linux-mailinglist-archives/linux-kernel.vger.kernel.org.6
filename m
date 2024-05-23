Return-Path: <linux-kernel+bounces-187673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE58CD63F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA49283AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C36FC7;
	Thu, 23 May 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7pdPEal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F9AD2C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476101; cv=none; b=G0bLvyOMJ2TVUOK7GbWvgxGOqjDQyR1Kae4H/3lf4NzC7j10RrPhM0l3+lCiF9ORhfqiLoba3uLCkli6XL7PhNE2J+8rLUJlVlt14T6nKvCA6on4tYraEQmxGKOoS73t2EfJefsVUBj4FV1njoXQAyHTj5kdgVjFYjPtTvS8ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476101; c=relaxed/simple;
	bh=IXR7S6Gc+F3sudLsZ8LWQ+6UJawqmAovn5NH00L+sI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXLBZ60TEvOwO5pvSeUue6g3AZnbMcpGBz8ioDdOWiTgYhJ4lMuwCqYQ29X5mGX809GSIYcubpRYPaRyu46y5Jtqd9jYFHMmYCCc4oozQ6+8XfEhl7LwQR7SauwgLD/wkni9oB5fNwa6jfCXyg3FmoBIyJXk7JGh++P8crNYQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7pdPEal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/IspulZ7ogp/9/Ev8vDQ4CFOVYGCYWHCfNnAnEppwY=;
	b=C7pdPEalU/POUZLOd81MGyp+EFCxmZ2hN8TdKNdIjmQL3HANam0tHKMcu2KaFY0CHfBsIf
	nwBEUQdZVvbxeEy53/J1ECUKGxDWkhQlNOcOgbtcYUMJDrLAbtG87fDoxXuIyndiQqAUuB
	vnpHjV4X3UOXLbfz+Y9fWFb1+Rvt9w8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-YRIPhlR-OfqCda-4y7JWqA-1; Thu, 23 May 2024 10:54:57 -0400
X-MC-Unique: YRIPhlR-OfqCda-4y7JWqA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e1f38cb631so13061491fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476096; x=1717080896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/IspulZ7ogp/9/Ev8vDQ4CFOVYGCYWHCfNnAnEppwY=;
        b=qTc0L9KTSLs0cGN0p2sakF+bh/oRyYSydxopGA9EIv0dc7VWBbNG64YjqtDuzdy7b1
         ofM/l3K+Lk4QRyHta5W7qahgiBnm3878p5MK7H4jWozDBvJ0MwEsoklok4iZADroug5k
         EzjaAXVTK3ZY4zxOkYa4HFsFAuxML2tILMIN+BaEVsmt8v+wQY5+HYEdPdRJUyL7Wz9G
         AfDlCL+C1UzpIfEPHhyDFPfTWu04YTBc3Az9JL37yobCecluh/YpuoJtkVYNP3ab/RS6
         ZzOYtxG+yKpanj3ctFBBxiOFPZHz8dxNBUFF3VzNCQNU2lgKI3WV3NHml8szQ1B0H6hd
         2PIg==
X-Forwarded-Encrypted: i=1; AJvYcCVFR49BrS+oHqBq2pjmC/MctET816RWbyd8/hVgxfXTYQs7u+9NXqprGFWlkNxkkZZZTRUxVYva9YFfAVQzBnq3uB26zNc+JTPNCZzS
X-Gm-Message-State: AOJu0YxxTrvvx0ZqsYCCUboqiPPxKWEiGK2VeCCBNmfWeK1jwnDpPt5I
	uNZOY8igvyfGZVk8rUM/jTbBlinLoEaWVz2hSsrfIYtsx59MHb00R0of86UmYxpdobQlRzmQjmq
	1MyTNCPm2fW8PyOxAu9cfwEKJwYL2OtgfsjW30SapK6diNvMqP9oQSWp+qwaOcg==
X-Received: by 2002:a2e:9042:0:b0:2e5:4e76:42df with SMTP id 38308e7fff4ca-2e94953fb10mr43723561fa.33.1716476096198;
        Thu, 23 May 2024 07:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC0bLoBdXb54NPxLQ4coOeZyHZBFadFkv6sukQZSvxP4AKs7iWObQtZZHt9eGMKoAkua8+hQ==
X-Received: by 2002:a2e:9042:0:b0:2e5:4e76:42df with SMTP id 38308e7fff4ca-2e94953fb10mr43723241fa.33.1716476095561;
        Thu, 23 May 2024 07:54:55 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdeacb2casm1095429066b.67.2024.05.23.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:54:55 -0700 (PDT)
Date: Thu, 23 May 2024 10:54:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 0/5] vsock/virtio: Add support for multi-devices
Message-ID: <20240523104010-mutt-send-email-mst@kernel.org>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>

On Fri, May 17, 2024 at 10:46:02PM +0800, Xuewei Niu wrote:
>  include/linux/virtio_vsock.h            |   2 +-
>  include/net/af_vsock.h                  |  25 ++-
>  include/uapi/linux/virtio_vsock.h       |   1 +
>  include/uapi/linux/vm_sockets.h         |  14 ++
>  net/vmw_vsock/af_vsock.c                | 116 +++++++++--
>  net/vmw_vsock/virtio_transport.c        | 255 ++++++++++++++++++------
>  net/vmw_vsock/virtio_transport_common.c |  16 +-
>  net/vmw_vsock/vsock_loopback.c          |   4 +-
>  8 files changed, 352 insertions(+), 81 deletions(-)

As any change to virtio device/driver interface, this has to
go through the virtio TC. Please subscribe at
virtio-comment+subscribe@lists.linux.dev and then
contact the TC at virtio-comment@lists.linux.dev

You will likely eventually need to write a spec draft document, too.

-- 
MST


