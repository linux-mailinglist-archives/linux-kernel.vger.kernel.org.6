Return-Path: <linux-kernel+bounces-190174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F78CFA90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4265281A94
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4A36120;
	Mon, 27 May 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJgG3CH6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A673A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796367; cv=none; b=SNn7ik3Z+lTbzhJpDyRLr3xcfJvgzCUTlrPcA5rzzo4YgYgsNqx4dZs7JI+77wcdHhwjkYAPLXTNJ+pk+pFtpXM7CAPgx/XNMejDocxxTQ6A/L8TCyRLVeUg1xfUklcu6uVjXF/2TakIt4YBwP7Gs9M/U3MzlDm/H773RoGmN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796367; c=relaxed/simple;
	bh=TM1t05Bam2TI9Og9Ycmjuz9Th+Jrc0NoOIk5tBLaklI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdiPkUAJTPZb1dK2kblge8YJV4v4QJpdSwIFELQXRTRS/jabh93dCaCdazBP9SPflIIVH05yQygTFGrUa7aOWjTgPv/hYcEoHzVypw5ULMEoszYPSnPzXTqvScYw72PmSFyJuYTyZMBh9nxTWuETRtRMUwntx/Tin+WiofEC3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJgG3CH6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716796364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thc/L9s+2sOtDwAm/KUlb0xgz4MZpvoKHDvg7DhDHKo=;
	b=VJgG3CH64flYbps5N0wcYuMZItXV32Kkn1RGEBwxw9vtgZjiTuk9Xw2j+0gT3FgcoDyx48
	8tDl+4CMlUpvd/CwLvBMoNyIYZ4JoUgjwYiBzSFhRFmqFdjJgH6+Pw+ON2ST9RWTru5N4C
	Oklbw+V1fQeCvi+bj6/Gu5CwlKAoXFY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-oCbuZF2-OvmYRgZTTaK_qA-1; Mon, 27 May 2024 03:52:39 -0400
X-MC-Unique: oCbuZF2-OvmYRgZTTaK_qA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35847dc0690so452311f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796358; x=1717401158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thc/L9s+2sOtDwAm/KUlb0xgz4MZpvoKHDvg7DhDHKo=;
        b=SBKEqu5oc4M9/7dixmgmyOhVSqkv2KfXaD1WsAOFIyj/U2Ye2dw57fG0d30XvqfS+P
         NcnOtq17HMhcnJWyyLSo42SSgzEVjns9on/Pe4Ils0V/eN3khH4zrcXlJ8lHnwRo29rR
         2yJb/B/ZtflSOjj2dfqw6eKrfxWSAtbc+9dj4Km9VfaU+RV55LIV6KtkJDvdnYqXhcJ9
         1M/vmq/5KXfJsqnzjVU9Hy12GbEJ4+9Lb47EobfPtB7ihuMOHwgyHp8zRQbCLOCQZ9S8
         uC6YitnKGkoohtAlD9ayHlAnWOgyyFSTP2ABS1VZye8T69DeM73bkgri/RBHbKcx3XsE
         dyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEsfxiYagmHiLcJrO0iPGBxKWcCTSa372L2/Iry+FyCA5Pl8gnRbo3L9S7q1G+crj2XOrwQH/ATx1l3QmJq0Mijs6fEy3gmMpgjIK
X-Gm-Message-State: AOJu0Yxj+YpM6Wq3j1jSbCdRDXCzM9DddvYPGw6bHe288gY+js0eBiPW
	FzjSrBLyPVPNg8g/RTyGYv6yoHfHzqx8v2qtjG42+DGBmduXMtduP9sOiHglZWuMZSsFNo/VuV9
	ecEL/oc2KIR+Vk9Jr7/9G+3tcls/xOy7Llzx/Ldzn+dTs14DylBXlnZvAYraqSA==
X-Received: by 2002:adf:ee8a:0:b0:354:f622:fc5d with SMTP id ffacd0b85a97d-354f75219a7mr9417774f8f.20.1716796358262;
        Mon, 27 May 2024 00:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUJgA9y8QUFq6+A/jElmXWEBdvPCJT9Gb6c+IL3oX/gqOcRBCgLttm/wO7nHhToDnUdxOC0w==
X-Received: by 2002:adf:ee8a:0:b0:354:f622:fc5d with SMTP id ffacd0b85a97d-354f75219a7mr9417746f8f.20.1716796357625;
        Mon, 27 May 2024 00:52:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:cd82:9c62:7faf:9d73:ba3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d963sm8271015f8f.21.2024.05.27.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:52:37 -0700 (PDT)
Date: Mon, 27 May 2024 03:52:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: yskelg@gmail.com
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	skhan@linuxfoundation.org, Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] tools/virtio: pipe assertion in vring_test.c
Message-ID: <20240527035009-mutt-send-email-mst@kernel.org>
References: <20240527071330.105268-1-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527071330.105268-1-yskelg@gmail.com>

On Mon, May 27, 2024 at 04:13:31PM +0900, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> The virtio_device need to fail checking when create the geust/host pipe.

typo

> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>


I guess ... 

> ---
>  tools/virtio/vringh_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 98ff808d6f0c..b1af8807c02a 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -161,8 +161,8 @@ static int parallel_test(u64 features,
>  	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>  	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>  
> -	pipe(to_guest);
> -	pipe(to_host);
> +	assert(pipe(to_guest) == 0);
> +	assert(pipe(to_host) == 0);


I don't like == 0, prefer ! .
Also, calling pipe outside assert is preferable, since in theory
assert can be compiled out.
Not an issue here but people tend to copy/paste text.

>  	CPU_ZERO(&cpu_set);
>  	find_cpus(&first_cpu, &last_cpu);
> -- 
> 2.34.1


