Return-Path: <linux-kernel+bounces-265771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C173A93F5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A79A1C220CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CE1494A1;
	Mon, 29 Jul 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3bc1ajw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388F148826
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257086; cv=none; b=rLvtthAYO59PNx9doGed4p7b3sy4zSp8cbnldVbdGYZbjFgXfKsTd1sogQMydQ1bfsjLRxRqnx+SGId8XcHTeaUFHRoQooKDQ0Jmbpmr1arWMWCWcNcnzHBG6IdYBd3rVEqiBdc71LH0ZG83YCjaNerifMTmVXLnfyOmpPv5cOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257086; c=relaxed/simple;
	bh=5mbYS28kR+anl9LddH2GIect/DwV20q0RBYiy+oebfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdkEl08OdKoRT3/YPY4FS365fUjAb07Lwt3mV5HJSBKzig8xWT6U2aviJ8CKOSBf4LgtOqiMsZ7R5QWlhjDJBEtkAVdI+kcRgjm9zcNeMBKtusYwlxHmk/tVPDMQ092PorotmyaaVMDBFFqOxR/wuEXpF6Mzu11H0/aCW+YCWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3bc1ajw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722257083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imU5JWIdoIr0tLfxDfEeLPjwXwqe1TCwz+4f/zgzfRE=;
	b=C3bc1ajw6FF2exRQYE5ZNqNvs7jyxKv6MwqM2O6OYRecl6JhYd3sDXYwzERgU3FA0JkHA8
	StIKjBtUyywyugwBkby4yQVE8WDWMP6X/UcL9SBr6yyI2rlERG5h1RRnGYuvyJAoRJXHjF
	Z4hOCjhOSo8D+GH6QCeBlpVGrV8Vpz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-YHzYks_mODqtuaRV4pnVeA-1; Mon, 29 Jul 2024 08:44:41 -0400
X-MC-Unique: YHzYks_mODqtuaRV4pnVeA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684ea1537fso1454687f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257080; x=1722861880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imU5JWIdoIr0tLfxDfEeLPjwXwqe1TCwz+4f/zgzfRE=;
        b=qXxX1vhPgEoXFL1EhBAcwMw9VsAPqcX6QOKECoJ37U7a9nPEBa2IttfxmMqJcZnaqj
         1gp2QH7WPZMPWh+UmSN3y4O/Qz631cu/O8+2P7f5HZCqNIBdInLSa1EN8pdcXQiH7VZd
         KKj/ZvvrSrE7k7LVgHk/qaxcQRjY45WV38p+97+a5WSd0PUuLxTUiiXK/nqJC+raRqaQ
         087zXrn3ud/EpAwTBevT8uH0bAp2UNGvIK9/XncGkdNCxRaIlUO5kPcVOy3zeaSpSJBr
         MQVeckLsrZb09BQqwpZVLuPSb1n50MJKiKRojwzoYAtFv1bGWPVgNJ8pN7L2YFpMJrka
         8z7g==
X-Forwarded-Encrypted: i=1; AJvYcCVLpByoexXqAcflUuaFobIqJlOUv6/P158WxfhbosjD9OasdE1/L1jKXQGxRePt/11QfycHz8cBOPfIqHdEPVv3voclAzez+c6P20b9
X-Gm-Message-State: AOJu0YxK568UPU1GxirW9k3XQEVXC+4/3udnY8E3CC9JxWCdFmZGQmOr
	B03J9L65+Lxyw3LCbVRJ5xAploLblx3W6dA2EkpvAMB3Uj2mjXfwwO7VwFYAxtLB/+HarBH+P4k
	B82R73Qfw3tqtEbWXRIeknbNqnEWz/YKNzU4zHBqvKjBg67hXekPDKHLwecEiNw==
X-Received: by 2002:adf:fe07:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-36b5d0d1002mr4391902f8f.29.1722257080417;
        Mon, 29 Jul 2024 05:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaJJDIOyE8oIlYOdXwKaZY62JoigjIwdVZsp9HQ8Tass/f0PxfO6xtI8+Zomu1LS9HO70CTw==
X-Received: by 2002:adf:fe07:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-36b5d0d1002mr4391872f8f.29.1722257079783;
        Mon, 29 Jul 2024 05:44:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9a3asm12002314f8f.36.2024.07.29.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:39 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:44:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH v1] MAINTAINERS: add me as reviewer of AF_VSOCK and
 virtio-vsock
Message-ID: <4hzlvcppr6t7g3shaghr5w7yv7lvr6q3p3h3albzv7xrs6xsfs@54fx34dq422x>
References: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240728183325.1295283-1-avkrasnov@salutedevices.com>

On Sun, Jul 28, 2024 at 09:33:25PM GMT, Arseniy Krasnov wrote:
>I'm working on AF_VSOCK and virtio-vsock.

Yeah, thanks for the help!

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> MAINTAINERS | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index c0a3d9e93689..2bf0987d87ed 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -24131,6 +24131,7 @@ F:	virt/lib/
> VIRTIO AND VHOST VSOCK DRIVER
> M:	Stefan Hajnoczi <stefanha@redhat.com>
> M:	Stefano Garzarella <sgarzare@redhat.com>
>+R:	Arseniy Krasnov <avkrasnov@salutedevices.com>
> L:	kvm@vger.kernel.org
> L:	virtualization@lists.linux.dev
> L:	netdev@vger.kernel.org
>@@ -24370,6 +24371,7 @@ F:	drivers/media/test-drivers/vivid/*
>
> VM SOCKETS (AF_VSOCK)
> M:	Stefano Garzarella <sgarzare@redhat.com>
>+R:	Arseniy Krasnov <avkrasnov@salutedevices.com>
> L:	virtualization@lists.linux.dev
> L:	netdev@vger.kernel.org
> S:	Maintained
>-- 
>2.35.0
>


