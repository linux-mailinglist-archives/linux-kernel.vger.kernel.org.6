Return-Path: <linux-kernel+bounces-343058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0037989658
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFD2840A1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023DA17E44A;
	Sun, 29 Sep 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS33cFtA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA817DFF1
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628981; cv=none; b=KjOOZKixl4JwKeDFYwtlXG5QVUZP7IK54imFRSvaLWYKemzxqL10jAHlVV5ogtp43P3DOEgqMSPXOM2yVddHF0JoPQfHDt9SSYpcJNdg7OfYH7Jd0s66PW84O1tXJT50Qb2q+IS3MEgP+NztbWWTgAmXNybebPyh6LfoVNbAZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628981; c=relaxed/simple;
	bh=OuNHc8PIGaHQxuUXtKbA+OFDsOJlQHplpqTyjl6z6CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR4poFSkdoQaHR01TnV49cyfUKYbENht2K9UOwVH6Fm1injqooFMFTg0yMVZDDFb7yjBN1wsSZ02kUvNBR2OmkI2QTfB9wLtTQFhmTfb3cVK2tT2PIw9l2yf94XM/3v5oxsYAh3bwL5JAnjwQkjmLR6P7E5Hld19VfxG9cRcQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QS33cFtA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727628979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqpozjXyhnvHlQRJu2I4WgyAmmMM5tqK0NqWHw3trQE=;
	b=QS33cFtAh+UXoWEMFQ3o6ZYv8bMKtWRBTJYkLhjAT2bLWsjc9kQrfaQxzifzha2E27x2r6
	mh33GHy/U8prXXAMYrOypX+DFdKX1zTYrhM24hTegohSOeuUJbZ1OtBvPCF4oU+nCHZPnz
	pzmhiDbs1B3Itxe0h41DfSISimF43w4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-QhyOG-IVNECzTh-X8seZeQ-1; Sun, 29 Sep 2024 12:56:16 -0400
X-MC-Unique: QhyOG-IVNECzTh-X8seZeQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8ff95023b6so291967066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 09:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727628975; x=1728233775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqpozjXyhnvHlQRJu2I4WgyAmmMM5tqK0NqWHw3trQE=;
        b=X6vHI9rM44K9YtlZQpU+AgNi3oWzSJ7Q3+BUgEeo30hCsgpwHJ5xDeCyEotUtXXyup
         L0kQ/z+QXCcT1lP4F3xverxNZLhErW7X6/bHStSETxRZ2f9PIwwZ9VaLcyPvuimXOAp9
         9qleBenRjZ/oL+59AmK2kFqSFfq3rn2pg8qPSOecu35JOQiRuCrTnUaCigyUv5MGqH6a
         5g+bKAv1sgSBJN2Hq/NKpB3xt9Pe7PZueYONzrNVkpqd+FBPPm+ErfL6EOrRhTOizVrQ
         Gix5/YvAqlZwy7ARXSu/1yD5VqsBdcj9JLzj/GEdhtL2CAnVJ+RJgyu3MrgH7ll7WtLv
         pU7A==
X-Forwarded-Encrypted: i=1; AJvYcCWzJqGs8b/84fvmxPtCmT1MZtzdi9yquwn2y6WGXTVattwCaw9vyL6CwiPZn57BXaw3c5b6YcIbarH6Vnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrK8QfSPA5i7kp9WnY9fX01sveP21fI+cAEcu+C8cqjTUGOeTf
	1WKWyHs/mIPh0j6p2foEQIi3zKwbmVhki+I2noDtZuJH/prkhJp3jJEhCiFWOH19vFusCAE5lX7
	QJJk7GuoMJn2GofcufbT6NwSkxGjyLM1HHzBLFbu3+Psj18U+JhrMrp4s27D+AA==
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1026229166b.5.1727628975221;
        Sun, 29 Sep 2024 09:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBabYhMMakXtMQtZ10IYuTuTjIcGwfv1lKDLcZNtfQ8gg556HasAqswG+Wg0TAOWoqjInzRQ==
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1026226866b.5.1727628974679;
        Sun, 29 Sep 2024 09:56:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775995sm398955366b.41.2024.09.29.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 09:56:13 -0700 (PDT)
Date: Sun, 29 Sep 2024 12:56:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929125245-mutt-send-email-mst@kernel.org>
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>

On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> Add an explicit MODULE_VERSION("0.0.1") specification
> for a vhost_vsock module. It is useful because it allows
> userspace to check if vhost_vsock is there when it is
> configured as a built-in.
> 
> Without this change, there is no /sys/module/vhost_vsock directory.
> 
> With this change:
> $ ls -la /sys/module/vhost_vsock/
> total 0
> drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> --w-------   1 root root 4096 Sep 26 15:59 uevent
> -r--r--r--   1 root root 4096 Sep 26 15:59 version
> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>


Why not check that the misc device is registered?
I'd rather not add a new UAPI until actually necessary.

> ---
>  drivers/vhost/vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 802153e23073..287ea8e480b5 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
>  
>  module_init(vhost_vsock_init);
>  module_exit(vhost_vsock_exit);
> +MODULE_VERSION("0.0.1");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Asias He");
>  MODULE_DESCRIPTION("vhost transport for vsock ");
> -- 
> 2.34.1


