Return-Path: <linux-kernel+bounces-399960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70B9C0706
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC51F22DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDE20EA28;
	Thu,  7 Nov 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKJ89Eql"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17851E1048
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985298; cv=none; b=C27qvai2Cu+jOMXzBqgfACkf6w4zdlL2cvcBPf3mzoqHPD49jDqaOnfrlpFFDe1dk+IB6QDkpHeCf5LInCRXytLWvCrUqQM4xON/zTuxSru46OyiUA4Kgb8G0ovzTsR4BjSSbZahTC941ip2q56RsTk1vtvtjjhBGLPek+GpDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985298; c=relaxed/simple;
	bh=UxRX1jWBdEci7WWcUoZVTblkqSpJEn1rSo2TN5VMvXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDCgccdy87i2ZtXoPxwlzGu+s3Frco6PNbAhY6HxP0/T5+cZKjZLZ/R2V+QEnIwvbVwOdw6YNQ29HjJ2/QA93V+qD1Eruttav977eOCaR1Du9cRgt1cRMdgzgzVoFG7RvyEYTadEr1A4a0WGwCwkkZvBN1oKlAI9svy2kVujHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKJ89Eql; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730985295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bb4h44+wBKO0YUrX05KiJS//N+0dK6owl3hOvkwqoGU=;
	b=GKJ89EqlGax2fSmiT9nLyfOincYxTtrlw+EEwx0/k55D72nvBZhGVWTH0pwudmAPzgpKSU
	Qy+lenR/1QbRaVqIfARm7a3qN2fzjFDqG5iEcnTyn2Xe4oQdLLlRnA69spq7K6ZmD7gwGG
	i7IZyb7dVyGhOV0peMpOf3wVnWepUUY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-hwOOwbtFMYyrqWlKQWK6hQ-1; Thu, 07 Nov 2024 08:14:54 -0500
X-MC-Unique: hwOOwbtFMYyrqWlKQWK6hQ-1
X-Mimecast-MFC-AGG-ID: hwOOwbtFMYyrqWlKQWK6hQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso6675555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985293; x=1731590093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bb4h44+wBKO0YUrX05KiJS//N+0dK6owl3hOvkwqoGU=;
        b=lD/jO3h7ZS7W1gNoP4D1IvOh92L+qUlAxwWcq9K4lRiLTT7Wi/olkUtJRb4vZyEIi/
         wZNjIxi6yKPi7wMR1EzRQ2Pen17o7OBrK8hqz8b9JlPZltzU7H9lC7RPtXhJrCBRvNjS
         uik64NFnUPnJl2uEnDo8q0ziB2Nxc2Kyjq3iFGYGkodzBXhK5kiPiiUR89m9Szb5oMZK
         AyJ6X/1bKE47BUzrY0lALDFRD/QDnQI+J7HTh9jxOpBYYL9nSTIAPRYWWFL+CxcVdkgn
         icHfs90o5Dm9sn4SnoiJcWS/rzo8ir9csiSTd9S7V4Hy9L632YrFRaoLyjBKwvqCJpRP
         xSLg==
X-Forwarded-Encrypted: i=1; AJvYcCVNw+/lGOpG30yeJ8S5zc7CwOvfxT++BGX3b26zRMLL54m0yOZ1Ch991ReUE27Y2lhFuHIbYx2U5kjBAGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuU3zpZ09Q47Fnkzcuv2wo6TUnht9B1xcfMWyj37MIqxbmjqKA
	KrCmjAzQ0jVlUuBHIz7irKCQIpTsRSx3fzWwLP8NLl2NC8Hp8nigk3xO4DoDXswkaRCrzHFYMlL
	JTx0heUNLSobOODli5bwibiIv6IKpFW1l7j477qWKhU/SR0hx5lvjVNQGItor+l0jfOt+Bw==
X-Received: by 2002:a05:6000:1f11:b0:37d:4389:e9de with SMTP id ffacd0b85a97d-380610f3011mr30283537f8f.1.1730985292697;
        Thu, 07 Nov 2024 05:14:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCd1mviEpJq+US0joKmcpItb2PwDOzQNg88R7qU9AZJ3pRK3nOUmXvb+o5IWKlkTBraxws1A==
X-Received: by 2002:a05:6000:1f11:b0:37d:4389:e9de with SMTP id ffacd0b85a97d-380610f3011mr30283508f8f.1.1730985292205;
        Thu, 07 Nov 2024 05:14:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5b96sm24252705e9.41.2024.11.07.05.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 05:14:51 -0800 (PST)
Message-ID: <d885913e-e81c-488e-8db8-e3f7fae13b2c@redhat.com>
Date: Thu, 7 Nov 2024 14:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241106114932.3101891-1-ryasuoka@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241106114932.3101891-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2024 12:49, Ryosuke Yasuoka wrote:
> From: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Virtio gpu supports the drm_panic module, which displays a message to
> the screen when a kernel panic occurs.

Thanks for the changes in v2.
I've one more comment below, otherwise it looks good to me.

Best regards,

-- 

Jocelyn

> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
> v2:
> - Remove unnecessary virtio_gpu_vbuffer_inline
> - Remove reclaim_list and just call drm_gem_object_put() if there is an
>    obj
> - Don't wait for an event in virtio_gpu_panic_queue_ctrl_sgs and just
>    return -ENOMEM. Also add error handlers for this error.
> - Use virtio_gpu_panic_queue_fenced_ctrl_buffer() in
> virtio_gpu_panic_cmd_resource_flush
> - Remove fence and objs arguments because these are always NULL in panic
>    handler.
> - Rename virtio_gpu_panic_queue_fenced_ctrl_buffer to
>    ..._queue_ctrl_buffer
> - Rename virtio_gpu_panic_alloc_cmd to ..._panic_init_cmd
> 
> v1:
> https://lore.kernel.org/lkml/20241031032101.2836264-1-ryasuoka@redhat.com/T/
> 
> 
>   drivers/gpu/drm/virtio/virtgpu_drv.h   |  18 +++
>   drivers/gpu/drm/virtio/virtgpu_plane.c | 168 +++++++++++++++++++++++++
>   drivers/gpu/drm/virtio/virtgpu_vq.c    | 148 +++++++++++++++++++++-
>   3 files changed, 328 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 64c236169db8..5387e3fd9dee 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -125,6 +125,12 @@ struct virtio_gpu_object_array {
>   	struct drm_gem_object *objs[] __counted_by(total);
>   };
>   
> +#define MAX_INLINE_CMD_SIZE   96
> +#define MAX_INLINE_RESP_SIZE  24
> +#define VBUFFER_SIZE	      (sizeof(struct virtio_gpu_vbuffer) \
> +			      + MAX_INLINE_CMD_SIZE		 \
> +			      + MAX_INLINE_RESP_SIZE)
> +
>   struct virtio_gpu_vbuffer;
>   struct virtio_gpu_device;
>   
> @@ -329,12 +335,23 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>   				    struct virtio_gpu_fence *fence);
>   void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
>   				   struct virtio_gpu_object *bo);
> +int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
> +					     uint64_t offset,
> +					     uint32_t width, uint32_t height,
> +					     uint32_t x, uint32_t y,
> +					     struct virtio_gpu_object_array *objs,
> +					     struct virtio_gpu_vbuffer *vbuf);
>   void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   					uint64_t offset,
>   					uint32_t width, uint32_t height,
>   					uint32_t x, uint32_t y,
>   					struct virtio_gpu_object_array *objs,
>   					struct virtio_gpu_fence *fence);
> +int virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
> +					struct virtio_gpu_vbuffer *vbuf,
> +					uint32_t resource_id,
> +					uint32_t x, uint32_t y,
> +					uint32_t width, uint32_t height);
>   void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
>   				   uint32_t resource_id,
>   				   uint32_t x, uint32_t y,
> @@ -399,6 +416,7 @@ void virtio_gpu_ctrl_ack(struct virtqueue *vq);
>   void virtio_gpu_cursor_ack(struct virtqueue *vq);
>   void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
>   void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
> +void virtio_gpu_panic_notify(struct virtio_gpu_device *vgdev);
>   void virtio_gpu_notify(struct virtio_gpu_device *vgdev);
>   
>   int
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index a72a2dbda031..056d1e7877c1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -26,6 +26,8 @@
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_damage_helper.h>
>   #include <drm/drm_fourcc.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_panic.h>
>   
>   #include "virtgpu_drv.h"
>   
> @@ -108,6 +110,30 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
>   	return ret;
>   }
>   
> +/* For drm panic */
> +static int virtio_gpu_panic_update_dumb_bo(struct virtio_gpu_device *vgdev,
> +					   struct drm_plane_state *state,
> +					   struct drm_rect *rect,
> +					   struct virtio_gpu_object_array *objs,
> +					   struct virtio_gpu_vbuffer *vbuf)
> +{
> +	int ret;
> +	struct virtio_gpu_object *bo =
> +		gem_to_virtio_gpu_obj(state->fb->obj[0]);
> +	uint32_t w = rect->x2 - rect->x1;
> +	uint32_t h = rect->y2 - rect->y1;
> +	uint32_t x = rect->x1;
> +	uint32_t y = rect->y1;
> +	uint32_t off = x * state->fb->format->cpp[0] +
> +		y * state->fb->pitches[0];
> +
> +	virtio_gpu_array_add_obj(objs, &bo->base.base);
> +
> +	ret = virtio_gpu_panic_cmd_transfer_to_host_2d(vgdev, off, w, h, x, y,
> +						       objs, vbuf);
> +	return ret;
> +}
> +
>   static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
>   				      struct drm_plane_state *state,
>   				      struct drm_rect *rect)
> @@ -131,6 +157,26 @@ static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
>   					   objs, NULL);
>   }
>   
> +/* For drm_panic */
> +static int virtio_gpu_panic_resource_flush(struct drm_plane *plane,
> +					   struct virtio_gpu_vbuffer *vbuf,
> +					   uint32_t x, uint32_t y,
> +					   uint32_t width, uint32_t height)
> +{
> +	int ret;
> +	struct drm_device *dev = plane->dev;
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +	struct virtio_gpu_framebuffer *vgfb;
> +	struct virtio_gpu_object *bo;
> +
> +	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
> +	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
> +
> +	ret = virtio_gpu_panic_cmd_resource_flush(vgdev, vbuf, bo->hw_res_handle, x, y,
> +						  width, height);
> +	return ret;
> +}
> +
>   static void virtio_gpu_resource_flush(struct drm_plane *plane,
>   				      uint32_t x, uint32_t y,
>   				      uint32_t width, uint32_t height)
> @@ -359,11 +405,126 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>   	virtio_gpu_cursor_ping(vgdev, output);
>   }
>   
> +static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
> +					 struct drm_scanout_buffer *sb)
> +{
> +	struct virtio_gpu_object *bo;
> +
> +	if (!plane->state || !plane->state->fb || !plane->state->visible)
> +		return -ENODEV;
> +
> +	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
> +
> +	/* try to vmap it if possible */
> +	if (!bo->base.vaddr) {
> +		int ret;
> +
> +		ret = drm_gem_shmem_vmap(&bo->base, &sb->map[0]);
> +		if (ret)
> +			return ret;
> +	} else {
> +		iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> +	}
> +
> +	sb->format = plane->state->fb->format;
> +	sb->height = plane->state->fb->height;
> +	sb->width = plane->state->fb->width;
> +	sb->pitch[0] = plane->state->fb->pitches[0];
> +	return 0;
> +}
> +
> +struct virtio_gpu_panic_object_array {
> +	struct ww_acquire_ctx ticket;
> +	struct list_head next;
> +	u32 nents, total;
> +	struct drm_gem_object *objs;
> +};
> +
> +static void *virtio_panic_buffer;
> +
> +static void virtio_gpu_panic_put_vbuf(struct virtqueue *vq,
> +				      struct virtio_gpu_vbuffer *vbuf,
> +				      struct virtio_gpu_object_array *objs)
> +{
> +	unsigned int len;
> +
> +	/* waiting vbuf to be used */
> +	while (1) {

It may trigger an infinite loop, so you can add a finite timeout:

for (i = 0; i < 500; i++) {

> +		if (vbuf == virtqueue_get_buf(vq, &len)) {
> +			if (objs != NULL && vbuf->objs)
> +				drm_gem_object_put(objs->objs[0]);
> +			break;
> +		}
udelay(1);
> +	}
> +}
> +
> +static void virtio_panic_flush(struct drm_plane *plane)
> +{
> +	int ret;
> +	struct virtio_gpu_object *bo;
> +	struct drm_device *dev = plane->dev;
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +	struct drm_rect rect;
> +	struct virtio_gpu_vbuffer *vbuf_dumb_bo = virtio_panic_buffer;
> +	struct virtio_gpu_vbuffer *vbuf_resource_flush = virtio_panic_buffer + VBUFFER_SIZE;
> +
> +	rect.x1 = 0;
> +	rect.y1 = 0;
> +	rect.x2 = plane->state->fb->width;
> +	rect.y2 = plane->state->fb->height;
> +
> +	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
> +
> +	struct drm_gem_object obj;
> +	struct virtio_gpu_panic_object_array objs = {
> +		.next = { NULL, NULL },
> +		.nents = 0,
> +		.total = 1,
> +		.objs = &obj
> +	};
> +
> +	if (bo->dumb) {
> +		ret = virtio_gpu_panic_update_dumb_bo(vgdev,
> +						      plane->state,
> +						      &rect,
> +						      (struct virtio_gpu_object_array *)&objs,
> +						      vbuf_dumb_bo);
> +		if (ret) {
> +			if (vbuf_dumb_bo->objs)
> +				drm_gem_object_put(&objs.objs[0]);
> +			return;
> +		}
> +	}
> +
> +	ret = virtio_gpu_panic_resource_flush(plane, vbuf_resource_flush,
> +					      plane->state->src_x >> 16,
> +					      plane->state->src_y >> 16,
> +					      plane->state->src_w >> 16,
> +					      plane->state->src_h >> 16);
> +	if (ret) {
> +		virtio_gpu_panic_put_vbuf(vgdev->ctrlq.vq,
> +					  vbuf_dumb_bo,
> +					  (struct virtio_gpu_object_array *)&objs);
> +		return;
> +	}
> +
> +	virtio_gpu_panic_notify(vgdev);
> +
> +	virtio_gpu_panic_put_vbuf(vgdev->ctrlq.vq,
> +				  vbuf_dumb_bo,
> +				  (struct virtio_gpu_object_array *)&objs);
> +	virtio_gpu_panic_put_vbuf(vgdev->ctrlq.vq,
> +				  vbuf_resource_flush,
> +				  NULL);
> +}
> +
>   static const struct drm_plane_helper_funcs virtio_gpu_primary_helper_funcs = {
>   	.prepare_fb		= virtio_gpu_plane_prepare_fb,
>   	.cleanup_fb		= virtio_gpu_plane_cleanup_fb,
>   	.atomic_check		= virtio_gpu_plane_atomic_check,
>   	.atomic_update		= virtio_gpu_primary_plane_update,
> +	.get_scanout_buffer	= virtio_drm_get_scanout_buffer,
> +	.panic_flush		= virtio_panic_flush,
>   };
>   
>   static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
> @@ -383,6 +544,13 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>   	const uint32_t *formats;
>   	int nformats;
>   
> +	/* allocate panic buffers */
> +	if (index == 0 && type == DRM_PLANE_TYPE_PRIMARY) {
> +		virtio_panic_buffer = drmm_kzalloc(dev, 2 * VBUFFER_SIZE, GFP_KERNEL);
> +		if (!virtio_panic_buffer)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
>   	if (type == DRM_PLANE_TYPE_CURSOR) {
>   		formats = virtio_gpu_cursor_formats;
>   		nformats = ARRAY_SIZE(virtio_gpu_cursor_formats);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 0d3d0d09f39b..f6e1655458dd 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -36,12 +36,6 @@
>   #include "virtgpu_drv.h"
>   #include "virtgpu_trace.h"
>   
> -#define MAX_INLINE_CMD_SIZE   96
> -#define MAX_INLINE_RESP_SIZE  24
> -#define VBUFFER_SIZE          (sizeof(struct virtio_gpu_vbuffer) \
> -			       + MAX_INLINE_CMD_SIZE		 \
> -			       + MAX_INLINE_RESP_SIZE)
> -
>   static void convert_to_hw_box(struct virtio_gpu_box *dst,
>   			      const struct drm_virtgpu_3d_box *src)
>   {
> @@ -311,6 +305,34 @@ static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
>   	return sgt;
>   }
>   
> +/* For drm_panic */
> +static int virtio_gpu_panic_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
> +					   struct virtio_gpu_vbuffer *vbuf,
> +					   int elemcnt,
> +					   struct scatterlist **sgs,
> +					   int outcnt,
> +					   int incnt)
> +{
> +	struct virtqueue *vq = vgdev->ctrlq.vq;
> +	int ret;
> +
> +	if (vgdev->has_indirect)
> +		elemcnt = 1;
> +
> +	if (vq->num_free < elemcnt)
> +		return -ENOMEM;
> +
> +	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
> +	WARN_ON(ret);
> +
> +	vbuf->seqno = ++vgdev->ctrlq.seqno;
> +	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
> +
> +	atomic_inc(&vgdev->pending_commands);
> +
> +	return 0;
> +}
> +
>   static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>   				     struct virtio_gpu_vbuffer *vbuf,
>   				     struct virtio_gpu_fence *fence,
> @@ -368,6 +390,33 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>   	return 0;
>   }
>   
> +/* For drm_panic */
> +static int virtio_gpu_panic_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
> +					      struct virtio_gpu_vbuffer *vbuf)
> +{
> +	struct scatterlist *sgs[3], vcmd, vresp;
> +	int elemcnt = 0, outcnt = 0, incnt = 0, ret;
> +
> +	/* set up vcmd */
> +	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
> +	elemcnt++;
> +	sgs[outcnt] = &vcmd;
> +	outcnt++;
> +
> +	/* set up vresp */
> +	if (vbuf->resp_size) {
> +		sg_init_one(&vresp, vbuf->resp_buf, vbuf->resp_size);
> +		elemcnt++;
> +		sgs[outcnt + incnt] = &vresp;
> +		incnt++;
> +	}
> +
> +	ret = virtio_gpu_panic_queue_ctrl_sgs(vgdev, vbuf,
> +					      elemcnt, sgs,
> +					      outcnt, incnt);
> +	return ret;
> +}
> +
>   static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>   					       struct virtio_gpu_vbuffer *vbuf,
>   					       struct virtio_gpu_fence *fence)
> @@ -422,6 +471,21 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>   	return ret;
>   }
>   
> +/* For drm_panic */
> +void virtio_gpu_panic_notify(struct virtio_gpu_device *vgdev)
> +{
> +	bool notify;
> +
> +	if (!atomic_read(&vgdev->pending_commands))
> +		return;
> +
> +	atomic_set(&vgdev->pending_commands, 0);
> +	notify = virtqueue_kick_prepare(vgdev->ctrlq.vq);
> +
> +	if (notify)
> +		virtqueue_notify(vgdev->ctrlq.vq);
> +}
> +
>   void virtio_gpu_notify(struct virtio_gpu_device *vgdev)
>   {
>   	bool notify;
> @@ -567,6 +631,44 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
>   	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>   }
>   
> +/* For drm_panic */
> +static void virtio_gpu_panic_init_cmd(struct virtio_gpu_device *vgdev,
> +				      struct virtio_gpu_vbuffer *vbuf,
> +				      int cmd_size)
> +{
> +	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
> +	vbuf->size = cmd_size;
> +	vbuf->resp_cb = NULL;
> +	vbuf->resp_size = sizeof(struct virtio_gpu_ctrl_hdr);
> +	vbuf->resp_buf = (void *)vbuf->buf + cmd_size;
> +}
> +
> +/* For drm_panic */
> +int virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
> +					struct virtio_gpu_vbuffer *vbuf,
> +					uint32_t resource_id,
> +					uint32_t x, uint32_t y,
> +					uint32_t width, uint32_t height)
> +{
> +	int ret;
> +	struct virtio_gpu_resource_flush *cmd_p;
> +
> +	virtio_gpu_panic_init_cmd(vgdev, vbuf,
> +				  sizeof(struct virtio_gpu_resource_flush));
> +	cmd_p = (void *)vbuf->buf;
> +	vbuf->objs = NULL;
> +
> +	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_FLUSH);
> +	cmd_p->resource_id = cpu_to_le32(resource_id);
> +	cmd_p->r.width = cpu_to_le32(width);
> +	cmd_p->r.height = cpu_to_le32(height);
> +	cmd_p->r.x = cpu_to_le32(x);
> +	cmd_p->r.y = cpu_to_le32(y);
> +
> +	ret = virtio_gpu_panic_queue_ctrl_buffer(vgdev, vbuf);
> +	return ret;
> +}
> +
>   void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
>   				   uint32_t resource_id,
>   				   uint32_t x, uint32_t y,
> @@ -591,6 +693,40 @@ void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
>   	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
>   }
>   
> +/* For drm_panic */
> +int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
> +					     uint64_t offset,
> +					     uint32_t width, uint32_t height,
> +					     uint32_t x, uint32_t y,
> +					     struct virtio_gpu_object_array *objs,
> +					     struct virtio_gpu_vbuffer *vbuf)
> +{
> +	int ret;
> +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
> +	struct virtio_gpu_transfer_to_host_2d *cmd_p;
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> +
> +	if (virtio_gpu_is_shmem(bo) && use_dma_api)
> +		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> +					    bo->base.sgt, DMA_TO_DEVICE);
> +
> +	virtio_gpu_panic_init_cmd(vgdev, vbuf,
> +				  sizeof(struct virtio_gpu_transfer_to_host_2d));
> +	cmd_p = (void *)vbuf->buf;
> +	vbuf->objs = objs;
> +
> +	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D);
> +	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
> +	cmd_p->offset = cpu_to_le64(offset);
> +	cmd_p->r.width = cpu_to_le32(width);
> +	cmd_p->r.height = cpu_to_le32(height);
> +	cmd_p->r.x = cpu_to_le32(x);
> +	cmd_p->r.y = cpu_to_le32(y);
> +
> +	ret = virtio_gpu_panic_queue_ctrl_buffer(vgdev, vbuf);
> +	return ret;
> +}
> +
>   void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   					uint64_t offset,
>   					uint32_t width, uint32_t height,


