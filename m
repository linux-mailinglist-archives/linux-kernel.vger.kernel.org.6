Return-Path: <linux-kernel+bounces-522898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05964A3CFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B752218920C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77AD1DF99F;
	Thu, 20 Feb 2025 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="DIKFljpP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE11DEFD9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020949; cv=pass; b=WJSHRsLUcUfe43CTzLotrCa7Pju7LO+9hqzMYcdmez8doM/CQ2cxQC2tErG2yXxYmdRJLYoZZwaXSD6KdR14UJVSqGHViNn2nYo6JYxBuAufJEZ+AnoRPQXbtgUN67AaJcpSMepv4JMTUA9aIBWmSZk4rrLfZLUm7aBKtdqyOxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020949; c=relaxed/simple;
	bh=xfhIdynj1BOrr5J3UbPjAp/L+hhP6a12c2XXRdv+AUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rts3tLLpBoHcWWlq3R6QgBXE275d2dKDFgrmj4E5Wvew6wJ4aGroQeHMFfIBbhu2KfljVJjva/1U4GQ49c571Mx25Jc+WqC631aACDZLJ+BVyi4W5du7SEzH8FtFr1wRycPUqh7ONIx4JH1zAcNJcKwqC6kT/KsgFiGkfLUTd10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=DIKFljpP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740020924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LD1ORXenoLaViYaG5cbMYZJqHL03jlVoOwTQn6FDNfe+WZ6WMEWL2Kdavt1JiWUU5nG7qA+AIONFtt/8atT/Xv+CkTi/8vOB5NJoPTfdG6XAPP7+5D5/1CArRVkvfit8y9YvOnppDhWH7AisyvZVT8hRF86WYTVKuQKzmqbG7ko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740020924; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D+4Yg1sIOnwm4kyjhgsdw96gYTuVHcmlk5nuiTt5ijs=; 
	b=Ic27AqaqFOnyNJ0XUs/UvxX8VK9i90+VKKpajV7l/sHfKhR+2HG3veuB093qbuG3yn2uB/BsvBF9khzvZk9JsE7CARQRvpuumP6uKeG5ZRHWGxFX10uTNSENHo1hQ7VhEaMGU0N3X5VanF37cM6hqSvw7U2mulRkKizfWXpW/JM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740020924;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=D+4Yg1sIOnwm4kyjhgsdw96gYTuVHcmlk5nuiTt5ijs=;
	b=DIKFljpPNFko5H4SBJLHHYwAUIHDreMamf8erb9gS1D63xYNj182PVBZOHsWEBYB
	ZdWgQLs37qojungPuzgGh4KvH3PMmdgJR/5mlLWe4XDjd7P8mkTj/y+JpoaLy4GFutZ
	rIGQ3I330OkrgJuc1n+jh0uWvFuQK91bLU2B5Sq8=
Received: by mx.zohomail.com with SMTPS id 1740020921513211.06059206425857;
	Wed, 19 Feb 2025 19:08:41 -0800 (PST)
Message-ID: <ddafa68a-6043-4b65-a34c-62a34373ef46@collabora.com>
Date: Thu, 20 Feb 2025 06:08:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/5] virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
To: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
 <20250214-virtio-shm-page-size-v2-2-aa1619e6908b@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-virtio-shm-page-size-v2-2-aa1619e6908b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/14/25 18:16, Sergio Lopez wrote:
> Introduce VIRTIO_F_SHM_PAGE_SIZE, a feature bit which indicates that the
> transport provides the page size for SHM regions.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 3 +++
>  drivers/virtio/virtio_ring.c       | 2 ++
>  include/uapi/linux/virtio_config.h | 7 ++++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d7aeb2e50a3c499dfb68d58cb89b829ea2e50454..ab0e1d9148057c431676bfacfe5f68cc97eebb12 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -367,6 +367,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  
>  	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
>  		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> +
> +	if (features & BIT_ULL(VIRTIO_F_SHM_PAGE_SIZE))
> +		__virtio_set_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE);
>  }
>  
>  static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a2aca864bc917306536685afb66a6..d853d5cf7e553be8bbe0ff461dc7312b258c6e58 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2983,6 +2983,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_NOTIFICATION_DATA:
>  			break;
> +		case VIRTIO_F_SHM_PAGE_SIZE:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 2445f365bce74b4e926c6929322b269252ab6830..3171e3792263c2cd472ac09da18e593ab400751d 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -52,7 +52,7 @@
>   * rest are per-device feature bits.
>   */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		42
> +#define VIRTIO_TRANSPORT_F_END		43
>  
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -120,4 +120,9 @@
>   */
>  #define VIRTIO_F_ADMIN_VQ		41
>  
> +/*
> + * This feature indicates that the transport provides the SHM page size.
> + */
> +#define VIRTIO_F_SHM_PAGE_SIZE		42
> +
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> 

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

