Return-Path: <linux-kernel+bounces-523795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EB0A3DB59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C518917B3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCF1F4E4B;
	Thu, 20 Feb 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="UXoL0xvt"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5E1F4262
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058309; cv=pass; b=evlxPHQYeFb4cwV7H0L9dQ8FG5Jf4sXH+LtPnz7sh3rYQM36JXuS7YJHxSxCeDVXbphXhMg23jDjTKwy7Vwu5Z8B4IkixRmyiCNGUH9xujRsxyShCoG6FLmoRzp8KXtqIXM1X59rl7dw0xsgIJg4KSr1w5jDWtkXRsSgMiEbY4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058309; c=relaxed/simple;
	bh=38UpxZeOUsXipbUwygCbrqOljhMT3i+SL0fC+IRIiNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnwHfnO701EmHcfuoANJbqD3EZdH72CyD2JTf4eBvM6s7KbmJFM6FfYJCco1KQYcPOBG7uRs/dI1JCFLbiLjuR4NGt4d1U9MO7O/WWvZ9LiOi89npbm4fvvE96NSfsVJ0OAKfKnuBY+QO7HsMx57RjotMN72DPDMh6HjvZbdUVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=UXoL0xvt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740058282; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nZ+99W4l2bOwH34wjrLy0cykDdkPJYNYyEnfRIVnig2i8J8r+j2f9e0y30C9hLSucrchccpVIPt9Uad4Pjqi5nbXVv22R8ssGE4WmGwX4pBG/MyyM0wIpImqtBw95f8N5NZfJXJ/E1WZzMzVcRvfc6ufuUpSDhIuqsi5fimDcw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740058282; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WwGtYpVbiHbXyNtzNp28/hsmWCNhDI4FpbukfWmffb0=; 
	b=iefjYKVOzPMb3GNZCgitH+a2lYbiFWDw4Bcl3xX73CZw9VXUFjYVEQLjL8V6uetqHMNehd0zXeb7wOacMf6M/NR72Fp2ocfN0mr2VLCSqafXqV4Hd2c2fy55KTLbGx3cfodvL46iG3NVEbE8c5QxwvZusn+GisBHU8Z1lGjiSb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740058282;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WwGtYpVbiHbXyNtzNp28/hsmWCNhDI4FpbukfWmffb0=;
	b=UXoL0xvtm1lIvSi8Qhx3+eUWHgoWc6aT95gQemoue/dUPAH5uIAJ59Wxr8AUxK4Q
	O53477u7GJjPs/aAThqhTxS4zQ0ghojo/vdGMtf5DM/o4b7VMWXm9640ZgsixJDsvYV
	YSbGscqSf2gKSTkPxE6L7OsNsie8FYZPqsv+DEPQ=
Received: by mx.zohomail.com with SMTPS id 1740058280296164.49908263796294;
	Thu, 20 Feb 2025 05:31:20 -0800 (PST)
Message-ID: <ca0dfb6d-4fc6-4963-a092-f4c0b3afb7a4@collabora.com>
Date: Thu, 20 Feb 2025 16:31:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/5] virtio-mmio: read shm region page size
To: Sergio Lopez Pascual <slp@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
 <20250214-virtio-shm-page-size-v2-4-aa1619e6908b@redhat.com>
 <1f9a86a5-97d6-41d5-9a30-0422fc9ec137@collabora.com>
 <CAAiTLFXihV_DUpd25Mc-OcgsNJ5tVJx7XYsETgxh+7cFuicuHA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAAiTLFXihV_DUpd25Mc-OcgsNJ5tVJx7XYsETgxh+7cFuicuHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/20/25 13:24, Sergio Lopez Pascual wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 2/14/25 18:16, Sergio Lopez wrote:
>>> Use the newly introduced SHM_PAGE_SHIFT register to read the page shift
>>> for the shared memory region, derive the page size from it and store the
>>> resulting value into virtio_shm_region.
>>>
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>> ---
>>>  drivers/virtio/virtio_mmio.c     | 11 ++++++++++-
>>>  include/uapi/linux/virtio_mmio.h |  3 +++
>>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>>> index 1f594b626d7a7734e8ec58766737a118c26bad94..0f892770739ea84b3e7be5615332773049b10ab1 100644
>>> --- a/drivers/virtio/virtio_mmio.c
>>> +++ b/drivers/virtio/virtio_mmio.c
>>> @@ -537,6 +537,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>>>  			      struct virtio_shm_region *region, u8 id)
>>>  {
>>>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>>> +	u8 page_shift = 0;
>>>  	u64 len, addr;
>>>
>>>  	/* Select the region we're interested in */
>>> @@ -560,7 +561,15 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>>>
>>>  	region->addr = addr;
>>>
>>> -	region->page_size = 4096;
>>> +	/* If supported by the device transport, read the region page size.
>>> +	 * The page_shift variable is initialized to zero above, so if this
>>> +	 * feature isn't supported it will result in a page_size of 4096, a
>>> +	 * default safe value.
>>> +	 */
>>> +	if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE))
>>> +		page_shift = (u8) readl(vm_dev->base + VIRTIO_MMIO_SHM_PAGE_SHIFT);
>>> +
>>> +	region->page_size = 1 << (page_shift + 12);
>>>
>>>  	return true;
>>>  }
>>> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
>>> index 0650f91bea6c70f935764070d825d181a2379afb..43348be30eff90ee228b6490b9d3c35ba4c50aa5 100644
>>> --- a/include/uapi/linux/virtio_mmio.h
>>> +++ b/include/uapi/linux/virtio_mmio.h
>>> @@ -133,6 +133,9 @@
>>>  #define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
>>>  #define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
>>>
>>> +/* Shared memory region page shift */
>>> +#define VIRTIO_MMIO_SHM_PAGE_SHIFT      0x0c4
>>
>> What's the logic behind choosing 0x0c4, why not 0x0c0?
> 
> It seems like Linux doesn't support it yet, but in the specs 0x0c0 is
> already reserved for QueueReset.

See QueueReset in the spec now, thanks.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

