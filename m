Return-Path: <linux-kernel+bounces-440098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6EF9EB8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECEE28336A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7AB2046AF;
	Tue, 10 Dec 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iv4OQuxr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1D1AAA1C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853156; cv=none; b=VN7dp2Y9+ErIx+sr30SKrECYqtDlytInmW3XUBnGpcI84rAvJeUkhAZ1iNEEcgrD2IWWtNiWClcKA1ZvTA45UwAG0ShTqXtvRZsPxPqpSu1WSbLHtBCPvdZ005s/o3vUMeQksGzg5hgCuQQSZ8e3k3zFzds1MvIGJFBduOq80/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853156; c=relaxed/simple;
	bh=jxM8Oak5FsSIuUdETeAfc41H8506k5MRoOUV/v8nVjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lov8nWHJ+tAOZDjEkgOSgjtuaCbghvz0cwFtCHZI5jfsXEOvO8KjQsE3H5CO7LieeX9wSy7gV1RWZyJSHKCCDgDYuWOPSANTgCoO62FeWKGa9RSmMP8FHzMBqJ7CxmNygFhYJJFfPKTYoosWKzmymt5Vew5vE3B0qVTX1twTRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iv4OQuxr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7wTWXny8CFCbc3FlHKUZFA0j/GNvYUzPKRP1yK4uOU=;
	b=iv4OQuxrwAzZVWRVt/D9XZMGBwE0gWcJpTfINSJyElEjm3Qh1dcOSSEaXY81cm71KwG6xe
	7LAFIzhYCp30dMDrNL3r7VPeEuT40qJhXSyYyC7AIC9HQpfjRFo3KDprm8bLcJrf1/dr4A
	6HHdA8DLIoFeVDm4mvAY+PMJU9o7kEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-ra0VtbSVN8y1jB1FWvBcEQ-1; Tue, 10 Dec 2024 12:52:32 -0500
X-MC-Unique: ra0VtbSVN8y1jB1FWvBcEQ-1
X-Mimecast-MFC-AGG-ID: ra0VtbSVN8y1jB1FWvBcEQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso2697795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853151; x=1734457951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wTWXny8CFCbc3FlHKUZFA0j/GNvYUzPKRP1yK4uOU=;
        b=KJf90PhOSKKXDVVO78hd1Ts0gxwvgvB2MwMr7j6yZJGZhAR+Pdy0EbUHi39TzTlk7v
         ze8QGLc6F06ZA661SE1p+hbpdqbEd/bjxtzCnWck1uckEoktIbnCkvhN468prffkhUH1
         SH2bro4uVPoDea0Iygli0tmt1LNav3agAZHXLIzIPRty1yHBXYGF9p3CgQT30yoETXI4
         YtH+PPYfa1MelsSffMsT0dKfwrbB4Oarw2M+JxE6hRLUIrePMwjj0ZczaRBxIWOh7Oo1
         1+nskbKd8Bs/2LtHWEI0lcewh5gjZeceXQMnoBNVjdd/etq4vtWOZhYGmjI7jnz5yV1Z
         tSkA==
X-Forwarded-Encrypted: i=1; AJvYcCVBfCfewpQXZ1havM3gi7wgR10fttnr0ZFsoEFoTTofCdbB5k/8XY0ofqK/8pUjOSbN/MroYHCWp5gDInk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPLpmIyq8VFQaOd62jkwP8GnufSosRsJfdjTIq3g38IoPXFza
	hJfELRq0YnW7tMTpMqBGxNuVoUF5y+JbGOnjRfURYVb5gRXt3iGCCDlqfgUrF7XXklFyP/Jw57x
	fhy/thBv5Wg6doSRNEH2CdXmDGKPnxrpc1rdOmBd54vpEvnxy2lPLOt1Tlhc6+g==
X-Gm-Gg: ASbGnctLAyMD/xPchkUIY0TvJ8uiHy06b3cP0D8xT+dpn+TvwSyzdKTIaYWh/u0SAgh
	HkmodLOP5ZgVbMbXx9okUombGX2cudSCofJQvRw4WV4rfkBgMiLJwHndSfwZn1Ea+OWPz5EfIVA
	grjxm6ZFq59v/4Pcot6TjJxGymAGLBMoBXtdWEXpiqsGlyf6IdsloPcnmXnNwWCnzwNyemlRZVO
	O0LQnnYnkdFbTGFs28ctGFF3UrVZ/m5kUKukFOwpBKLcFRUZdA5GpZqejvrlX3tbNFM0yNjScK3
	Flg6ncJqxA5w1M/6pyt6nMpsW5jikg==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-434f3a1b4f1mr73407125e9.32.1733853151447;
        Tue, 10 Dec 2024 09:52:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6Om4hYhYhyD9qJSgoZ3Z6qXK38YTr//I5hZ9Q1woRRwaJmZu4m0F7M5ZzfAHvZP1EyN1sw==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-434f3a1b4f1mr73406865e9.32.1733853150834;
        Tue, 10 Dec 2024 09:52:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3c96ca2sm99608845e9.24.2024.12.10.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:30 -0800 (PST)
Date: Tue, 10 Dec 2024 18:52:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-2-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:40AM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles,it confuses some legacy

nit: missing space in "principles,it"

>userspace app, Therefore, we are reintroducing kthread API support.

nit: "app, therefore" or "app. Therefore"

>
>Introduce a new parameter to enable users to choose between
>kthread and task mode.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 1 +
> 2 files changed, 2 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9ac25d08f473..eaddbd39c29b 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->byte_weight = byte_weight;
> 	dev->use_worker = use_worker;
> 	dev->msg_handler = msg_handler;
>+	dev->inherit_owner = true;
> 	init_waitqueue_head(&dev->wait);
> 	INIT_LIST_HEAD(&dev->read_list);
> 	INIT_LIST_HEAD(&dev->pending_list);
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index bb75a292d50c..c650c4506c70 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -176,6 +176,7 @@ struct vhost_dev {
> 	int byte_weight;
> 	struct xarray worker_xa;
> 	bool use_worker;
>+	bool inherit_owner;
> 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> 			   struct vhost_iotlb_msg *msg);
> };
>-- 
>2.45.0
>


