Return-Path: <linux-kernel+bounces-432962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BCC9E5263
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149D1284DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FEB1D63F6;
	Thu,  5 Dec 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLVFVg+B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9E1D3566
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394850; cv=none; b=FU5A6hll7ud1i2elbe9XQNuknMVSiFdoHpfM6eD8quDFa84Xu05/5SSNngzAVVSpcvmVzb9B9T2Hq+aL30oKQEZ1Gv/l/8UFhy0pj7xTrHx4mBs3CdlBF9w2tfQwjbjxC//dw2aX0iO0m7xuJr+aPnRWI8GzAliybz23wb+1Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394850; c=relaxed/simple;
	bh=4iSivaet3eWbcYQfu+va8eySU1IR4UGuLLebIGaqXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwF25utZRJDaqrukYM5zKXNJfGe0KLrgVHREgU9JzSgQS0F3X1DFFCgkVI5XJTqdKkJ6coDHiGSZ7uNSp/PZ5MM1X5q8mjpXlqYuAyAo2D1HGY0f+ZlJRUweYhlAKgAKqIuwI74K3k7AA0ldk3E+8RNPcloOA11148PTlezVyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLVFVg+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733394848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
	b=hLVFVg+BOVMljeoA00eQgysoxre3Uowf1+7ZiHJOcRKgFmpxqO+bf+ccNyvVA5MUKZTbK2
	UEHdDE4K1sY/c6fnqA1HYY39mVmwuTf+d1wuXVGtj4Yv2EuU9l9RjweThJr93Z3Y/af2UP
	kHhgc/kZvaAIUIP1tIu3Ebzh+W+Tp4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-PTkbDATVM6GCl9ZlerzAxg-1; Thu, 05 Dec 2024 05:34:07 -0500
X-MC-Unique: PTkbDATVM6GCl9ZlerzAxg-1
X-Mimecast-MFC-AGG-ID: PTkbDATVM6GCl9ZlerzAxg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385df115288so359258f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394846; x=1733999646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
        b=E27AbmLt8nEI3YpbJq8FuLJrbsG/f+OvgjdrUPh5y7bRg9ELjJoYZZtKT4FU98/ITR
         zwB2RayutsMLk2GpnkFwr6mr+lJ1M6PHWVjTYPNiFe44n4AUXeKtl7euR0dw4yjiYfK5
         2NwZRvEmMGls7dJ5oq1F85r15qPfSbHTdcJ5LMD7JbNvcVZx8rzTewhm3b1JPRdqAvQ5
         rmDhxTVMaBk3EzifrmkPIc/mVK/ol9mldrFfXViG/IN3YO9ie6UDqGPIS/8WUlXJ58i2
         LI7zk0Fc2+9jRm0axaMxcwylvrOSA664dq7sSkujO4iQxEk2wael4fq4IuKto6MFiJQ5
         eLAA==
X-Forwarded-Encrypted: i=1; AJvYcCWplS3uLp8BtsBAk7X+4k0cAi/5JmJ3xkuUFzEMdlSXEpJ7KQpvBykK1GuV1T7AV2Y3WyY6iC18pXrSX8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Kxo8MKReo5O3QfndorL6KI+khonX8YPIuL7J2iwCD6TIR47H
	mGVexMx53/NyAHfyJDj8EeuAvPuaAxGUo9eGtughoCRurEdbsMQ8hASKo4rqPh1cTAGzF3gUZNa
	T5I3gIzHBFZop7jSOr31y0vLD2hqz5MTPpY2t8mIW0sbe5IKx+/FrHVnLLM1Mhg==
X-Gm-Gg: ASbGncsh00cU6oAzE3R8doDIYt6SOI3VDjnrcGrwBsjwCh4TuNxWzfOFka+RCB0YVW9
	3G10JC45k2Tn/373MA+zB8b2V4jQgqxFSeTeSPOXrnEzpa9DMwnH/iuaQdZWGvqw7zbiv67g0Cc
	JsMq8Kw+MLFTiXQaO6rQ01XBUP4d21HNJF/sVH+EyubP0espON92CUyKeQYjMNqiApyKqGkT8Y5
	J18UYXoSHDTfJXUR0VmIkCnce3pjM/K/OslyAo=
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027396f8f.23.1733394845862;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJNPFWgvbSY2I3/I8jqi8rh7xZnIPunyw/bGll0UrDgSSCV6D1wzgUrHuDPt3xOF7WivnpAg==
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027369f8f.23.1733394845539;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909952sm1556182f8f.69.2024.12.05.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:34:04 -0800 (PST)
Date: Thu, 5 Dec 2024 05:34:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
Message-ID: <20241205053355-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-3-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>

On Wed, Dec 04, 2024 at 02:07:19PM +0900, Koichiro Den wrote:
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
> 
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 48ce8b3881b6..1b7a85e75e14 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
>  	struct send_queue *sq;
> -	int i = vq2rxq(vq);
> +	int i = vq2txq(vq);
>  
>  	sq = &vi->sq[i];
>  
> -- 
> 2.43.0


