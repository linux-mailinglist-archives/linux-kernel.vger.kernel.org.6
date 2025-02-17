Return-Path: <linux-kernel+bounces-515380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4ECA36429
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09673A69EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A766267B85;
	Fri, 14 Feb 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="I7XGqFdW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67C267AE8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553227; cv=pass; b=lYGGxq6fXVqzMN3tXQ2LM9NPJGr7oohMygSc4XEQ0+MEG+4yBzV+4f25nhhjLbCwAKeWckcKas2NU3xokZPQK0TNztyNMB5GBghqQZ6SVneVrSgiSuhQdkPpUsNe16NOmXhq5P/IRzNBxJ7iFEIPLXWUVqVQXU5T8LKNcqkIAhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553227; c=relaxed/simple;
	bh=OpB2YwORv7ZZMP2GLJvCEgX2ulrT6406s2E/L623RuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfDU2hdQ1XL/bpf+m54uB8mSwjQlFoNhDwmE4wfmh3Ki123ZzDYfz6XBl3hb2Nac7ql8hYsj8e5zXPAlB87FI4FzC8l4amkZP7o7bb1gStUlvV6A2vF6Q2jj9FPOmMipt0d1C977DbU+WrIPagOYgfNCzalzrxLsZVaZbfcoRpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=I7XGqFdW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739553200; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gjXqQx0PN9fIBRAdPXvG2V1D2iMEDJwYwHKwJ9gnYH6Zvmsgnw0M0i4WLydKUT9HumwYlmmRQb2DyEZUL+LPw+rGqlAI5nJNxPY5VrGTOy/vN6ZHWUDTGOR6EJJuJPf4eVWNHIuCyJabAgB2vei3ZJkPpJ0GityFpHocL0Hcx1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739553200; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rx4zOK0jMB+T5gcNOQuTYR78srSh2K1r/cPK3FfxCyk=; 
	b=Sa+a6c5dqeuoHvB8lEbCj6yju8t8zBDSkaz4QRXOzKXJP4kQsg5VKvnkRVZfOkstICpfTo7iRasOCNy30lpVSsnZOmVwLp/LKlQpFQK8dOuMRNrF9aTeqpT+PHaOTZho3n5LJWblxKBXo/sCutwf9bEa23xeSnJb1qLGl1cJ4zs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739553200;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rx4zOK0jMB+T5gcNOQuTYR78srSh2K1r/cPK3FfxCyk=;
	b=I7XGqFdWjPA5IMCXORPkrrCfozZDdiB7wzF+9HUPf4nwda+xcdRyfF8zWAoIK6ed
	M/vLUcZ+VWgyUpW/HMpb+KMp2jj+3Wr9A3gmPR9WgzBDAmQye41+0D14jcXC92T2NZJ
	msJE1Z8V1FmP0FiPFYRdxBGMi73pHhoyWEqd5OW4=
Received: by mx.zohomail.com with SMTPS id 1739553198330678.3612859142831;
	Fri, 14 Feb 2025 09:13:18 -0800 (PST)
Message-ID: <f6d6de4d-1b87-4a53-a2eb-0d9ddfbc4311@collabora.com>
Date: Fri, 14 Feb 2025 20:13:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/5] drm/virtio: add
 VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params
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
 <20250214-virtio-shm-page-size-v2-5-aa1619e6908b@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-virtio-shm-page-size-v2-5-aa1619e6908b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/14/25 18:16, Sergio Lopez wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c33c057365f85a2ace536f91655c903036827312..4b49635b4fe1d4256f219823341cef8e5fa8f029 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
>  	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
>  		value = vgdev->has_context_init ? 1 : 0;
>  		break;
> +	case VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE:
> +		if (!vgdev->has_host_visible)
> +			return -EINVAL;

Nit: virtio_gpu_getparam_ioctl() returns EINVAL for unsupported params.
While this is a supported param, but there is no hostmem available.
Hence, should a different error code, maybe ENOENT or ENXIO.

-- 
Best regards,
Dmitry

