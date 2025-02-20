Return-Path: <linux-kernel+bounces-522896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDDA3CFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC953B6376
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FB1D79A6;
	Thu, 20 Feb 2025 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="NzvX+TBd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74BEC5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020865; cv=pass; b=QCtsi1E8nIeTWrsihHR1KwuTDnIqEJeO/QvEmzKA3zKBX+D01u0juTdq4dCvTZsWtcqkdU8zZoYZ/gBWx0O3HHclyVMhdVr7WfGmqTI1HEXkI/qoToCLX4+qsUqmroS2Ks1Ckjp2RBuxmWoKEcv7HpbSdF2jXw8c+GKnUBt3jB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020865; c=relaxed/simple;
	bh=E4JWbMuiJ1aOXMeomwMqViqYp812yAx6oUwT7BKClfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnV5LmY2asUsKX48yvuIxwEuzA+fQr08UR5glzpcMLBXOmzfLCSl+Mk9eSVL7nS7o+nEujW6Ff8RLWviRcYuYD70i5XazFwB8s2qOtB3Q811ouJw8GfnRHa8mUxfZyX7duqXf98i8xauthLdLFpNKqRLnZ5ClZLGtx/TxbvMX7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=NzvX+TBd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740020837; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZXkPzyFtCdI7/MNx7P0a9vhMmGG09UuFiUeXiGJItJ4H+LHna5t6UKuhd0gRGy4jGpxZUdf6zUMDEN/hz6zH3q8L0DS6pEL9qu+YMmYRy+JTMlmeEce6SZGRpXiDqvc/gaoMmYDpEU6zZR8wIUSqBjfXqlgHQWb3/NaxTCnjGFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740020837; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CZQfbH3KbzP7Bj9KoZzlxkG1srKiHYUm6CWgToaXURs=; 
	b=jlg+tTbRUsQzW4tCn3//ZXZO/wllesz+Ly7AxxRZrhMQLhsd7k0e2ws77zeB3a2o6jZw/rCL8VRoEKol8VvnGygmgeBLPS/lfZyIKd8BqLppx6q+pa6AcTWpTxmAT5/sMF9He1VvaCZG4P/NlHZGeBRBOtpyt4lvKKL4+3hMzwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740020837;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CZQfbH3KbzP7Bj9KoZzlxkG1srKiHYUm6CWgToaXURs=;
	b=NzvX+TBdjBz6ujTn7H0GZSwo8XNBPwlwQd4EAUNhlG8JhE9K9X7GEm+5D5WIBwu3
	mggAukPJn2+iqJbKphnnAQ6nUvXadoXI9KOUIQeH2UcdvqFuHQlrkX3sHOnwdoNzcwP
	ef6DfCVW80B0L6z0pepTx8WKsmz/amXTc36AFzrU=
Received: by mx.zohomail.com with SMTPS id 1740020835488353.06590206575595;
	Wed, 19 Feb 2025 19:07:15 -0800 (PST)
Message-ID: <29100f93-a7e6-4c81-ac83-af94ecd942a1@collabora.com>
Date: Thu, 20 Feb 2025 06:07:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] virtio_config: add page_size field to
 virtio_shm_region
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
 <20250214-virtio-shm-page-size-v2-1-aa1619e6908b@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-virtio-shm-page-size-v2-1-aa1619e6908b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/14/25 18:16, Sergio Lopez wrote:
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 5d78c2d572abfcfe2b84cdd82df622320fe97d5d..1f594b626d7a7734e8ec58766737a118c26bad94 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -560,6 +560,8 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>  
>  	region->addr = addr;
>  
> +	region->page_size = 4096;
> +
>  	return true;
>  }
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5eaade7578606e4b02af0d66447417ad6aa11064..d7aeb2e50a3c499dfb68d58cb89b829ea2e50454 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -862,6 +862,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  
>  	region->len = len;
>  	region->addr = (u64) phys_addr + offset;
> +	region->page_size = 4096;
>  
>  	return true;
>  }
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 169c7d367facb36dcabf9596068580ea8b8516c7..c1b2ce71ea55e81978e18db05494deab193fa4fb 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -14,6 +14,7 @@ struct irq_affinity;
>  struct virtio_shm_region {
>  	u64 addr;
>  	u64 len;
> +	u32 page_size;
>  };

Nit: I'd squash this into patches #3/4, to not add code that is changed
by a next patch.

-- 
Best regards,
Dmitry

