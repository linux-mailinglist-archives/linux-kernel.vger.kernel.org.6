Return-Path: <linux-kernel+bounces-514920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB4A35D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326AF3A6B85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF7263F25;
	Fri, 14 Feb 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7N/9TGo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24025A65B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535453; cv=none; b=aAKRy0qGu+nS1v/kEPRt8MffeOYEnVNYjxRcZp6hOEEhaiLuwFD8fkSvy3AzsZdjI7yieSEEnyJU/d9H/MIeSklLAXW3IkcC6YlvTcaMTiHProPgZ4jDNeIIXcR9DtS50YKIFrGF5mywrs3lpbO4esA3khZcKu1jKbCJ/8xXiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535453; c=relaxed/simple;
	bh=508bg14U3UMJ8jdr3pX2AL6akRM/QyTn1EwYOGL0phw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa4IRjGKWN0AueJVc0Y0abVUETAO+2GfE262957cH1eAW4HKkWPvBH0L4FK0Q26o/lJ93i2OWMrhJ4kuk0XAVFGmJOV/LT7UYqD1lGPRtNNPtlm6izum+ZuvpvZgFpnzc7GKbmwXOdFgeLkcjioSg2fPByR67buomSHaCDDf0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7N/9TGo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739535451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZijvutShOwbMhwLPMjJwb8XWzeFIQw45xdK6ukivSY=;
	b=J7N/9TGovXCge1ko/0xLQVccvL2XxhtJ1uUVxvQ7FI/oWVJLZfO4MnOjNNP119rIdfgkDD
	TLI7Iw5ExEyybxgy8YFlNCSAILmlzeXbpXRSwVAfp62eNNFpLfOK1bti6p//jUC2jlj5Yq
	SDxdcjnhaEDUyuK7YVdZKDLBM/wLhQw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-8ha21_4BNHeffUc-blhqxw-1; Fri, 14 Feb 2025 07:17:29 -0500
X-MC-Unique: 8ha21_4BNHeffUc-blhqxw-1
X-Mimecast-MFC-AGG-ID: 8ha21_4BNHeffUc-blhqxw_1739535449
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab7e6be1deaso215260566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535448; x=1740140248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZijvutShOwbMhwLPMjJwb8XWzeFIQw45xdK6ukivSY=;
        b=b0GeHeOYDwtUV+5z4cA+VLFsnYW7wHX2Ugnzt0Zplich9E1klFRkNViFn3BIZjB2D6
         kIWK6tw9Ov37Qsyxi4BQ+Pl6u0FUeRhYXQeSz97j1MdAuxkhYap6dl8G4cmCydHSqYov
         Nk4tusB6E/1k49NLhdJUvWl6o5v34QziOiD1Y91dz82s3kCWKNqKsV1DHBXSeyUqKH2k
         +FeDFjKhAepPAxqunFa0JpRkfAKdg339iJcWBQ9SaZfOjDafElhSb4u1jGz71H+sKrC4
         WrfrisnAUJMO6QM9Nyq+F/SZBeBIlZRqfvVM4rImNPtP5WRWKAfQsXFd0VyxPns3nWlc
         xt0A==
X-Forwarded-Encrypted: i=1; AJvYcCXwc3UpUqc7TAq8H6hdTFvkpisR4UaeDIuSk96KoCP4c+hxRS7v0xDU0R3RdUnY5LiFV7/BPAfxz8NOGDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvozPB6qsMoXpIMjankyca8PQy7n53l8xploplIwWStiWe4311
	AMeJQmVsvq3MirHDEyHZ45/eylcFsCZLP5fvVYl3ri7muBZ0nCNU0iZaJtwoPlTkrTa1fobnIpT
	CqZYc8m7H3zjpxAXc7oSo3UDt/XkZh8UAv6mvumqQHKz6AUr59Gnyl5BsrCfAgQ==
X-Gm-Gg: ASbGnctPj7FQSLdcO0nWCuoY296u4ANOlF+I0DH8GJs890CvyKfa6wAjUzh2SN/Rxh6
	YpFNKlW5Ep3/qSVEF3/R0XGvfiKLQpmHtMthtVOlv8GVW51eRtOFKsEhfbL8IGkRu8b6JmSIoTE
	AZYtZZT3Ea7Wy7MRpJNubGxJ/stPdYp+v7Q3P0mUHII8H9satMFLxAw3IZmPkifJAqd26Uye+Wc
	Dl9W4koFl6MutovYrYU2NvLJXfWg74QlrIsQfrKOhvzn0TezQRsX89TFOvYx9K8bX8Hzg==
X-Received: by 2002:a17:907:3fa2:b0:ab7:5b58:f467 with SMTP id a640c23a62f3a-ab7f347aa6cmr1198348966b.40.1739535448562;
        Fri, 14 Feb 2025 04:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPf+AeSUeRn24l529Z9ZendqwqQDqP06Hke8qwzwFNKUt9IcGq+7DW+H44R0X87YfMunCk/g==
X-Received: by 2002:a17:907:3fa2:b0:ab7:5b58:f467 with SMTP id a640c23a62f3a-ab7f347aa6cmr1198344266b.40.1739535448190;
        Fri, 14 Feb 2025 04:17:28 -0800 (PST)
Received: from redhat.com ([2.55.187.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323226asm334107966b.8.2025.02.14.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:17:26 -0800 (PST)
Date: Fri, 14 Feb 2025 07:17:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, horms@kernel.org, jasowang@redhat.com,
	kuba@kernel.org, kvm@vger.kernel.org, lei19.wang@samsung.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <20250214071714-mutt-send-email-mst@kernel.org>
References: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
 <CGME20250214012219epcas5p2840feb4b4539929f37c171375e2f646b@epcas5p2.samsung.com>
 <20250214012200.1883896-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214012200.1883896-1-junnan01.wu@samsung.com>

On Fri, Feb 14, 2025 at 09:22:00AM +0800, Junnan Wu wrote:
> When executing suspend to ram twice in a row,
> the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
> Then after virtqueue_get_buf and `rx_buf_nr` decreased
> in function virtio_transport_rx_work,
> the condition to fill rx buffer
> (rx_buf_nr < rx_buf_max_nr / 2) will never be met.
> 
> It is because that `rx_buf_nr` and `rx_buf_max_nr`
> are initialized only in virtio_vsock_probe(),
> but they should be reset whenever virtqueues are recreated,
> like after a suspend/resume.
> 
> Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
> virtio_vsock_vqs_init(), so we are sure that they are properly
> initialized, every time we initialize the virtqueues, either when we
> load the driver or after a suspend/resume.
> 
> To prevent erroneous atomic load operations on the `queued_replies`
> in the virtio_transport_send_pkt_work() function
> which may disrupt the scheduling of vsock->rx_work
> when transmitting reply-required socket packets,
> this atomic variable must undergo synchronized initialization
> alongside the preceding two variables after a suspend/resume.
> 
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> Link: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/
> Co-developed-by: Ying Gao <ying01.gao@samsung.com>
> Signed-off-by: Ying Gao <ying01.gao@samsung.com>
> Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index b58c3818f284..f0e48e6911fc 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -670,6 +670,13 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>  	};
>  	int ret;
>  
> +	mutex_lock(&vsock->rx_lock);
> +	vsock->rx_buf_nr = 0;
> +	vsock->rx_buf_max_nr = 0;
> +	mutex_unlock(&vsock->rx_lock);
> +
> +	atomic_set(&vsock->queued_replies, 0);
> +
>  	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>  	if (ret < 0)
>  		return ret;
> @@ -779,9 +786,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  
>  	vsock->vdev = vdev;
>  
> -	vsock->rx_buf_nr = 0;
> -	vsock->rx_buf_max_nr = 0;
> -	atomic_set(&vsock->queued_replies, 0);
>  
>  	mutex_init(&vsock->tx_lock);
>  	mutex_init(&vsock->rx_lock);
> -- 
> 2.34.1


