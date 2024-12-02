Return-Path: <linux-kernel+bounces-428064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9852A9E0B34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2053B3C0C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF80C1DA11A;
	Mon,  2 Dec 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoCB6DR0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5CB1D61A2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159998; cv=none; b=uHD0ynkcNMYBaRoXOISYQNvin0BG18epT6Fi7xE0djqyPwtunVLl8tYmYPWOkvg2ncPYo4vScv5Rev1kWWr8n/ZslkKqECf6NEtltUNLW95mCiyXajhyjd/VcFh5Vg9BPzztZQ9+rQ7QPixuZE6WhSF/F9Em8swt1McvFHObqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159998; c=relaxed/simple;
	bh=hVlnEEYy3yDi00u82Ouy/7ev7XcY9fPHePYgTs0AyJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPyZLGtEzh91dDgEQwp/4L4zL7FLv8PEy8SxvJlNRmrr0V0aplp6wnwz7Mge2d06UX/ByliJ0swprD2JZuujjYNzi6TxQRNrkeKjchTl99novFeLvXRmnVJ/9alQ5O6GAG2OPX1yyw8po8lqX+j2le7shEgvcULlbO2uKNV3FH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoCB6DR0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733159995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOfr91+KiLZkCa9xiK0L/FZ2M5u6/xclChDT0RYiwkk=;
	b=KoCB6DR0nYog5Ax5wa2wQEhucXKO2/lyhOlSMaJjByQRQqWtFKvDvR066XBIpMf3i6k/pI
	Ui4nTwhqH0mY6l7TgT+KCmVVPRPPvJL0420CHb3tCdpxsPK+Em/aUyoF9MOI+wR4iWDFqh
	TNnKdufpwlYKXae9VWNmUfDoqUaATLA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-yt6Dxh7BMeG8IddMhtfEDg-1; Mon, 02 Dec 2024 12:19:53 -0500
X-MC-Unique: yt6Dxh7BMeG8IddMhtfEDg-1
X-Mimecast-MFC-AGG-ID: yt6Dxh7BMeG8IddMhtfEDg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1339790so1697672f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159992; x=1733764792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOfr91+KiLZkCa9xiK0L/FZ2M5u6/xclChDT0RYiwkk=;
        b=Dl8b4j7lirzqpsTUC0If0nGMwngXKgXc7jb1KQY0C/oo9Y2TftPHcTLYlXJ3VTc1EQ
         L8Dso+N4TXudKMjQPZ9UpstxJlOlOghfjLwlhUnXkjCYz+1ag42rV34IqpTA2kyyY3JS
         Ic3SWngtRonw8HeiX3Jdk7ASGjavWeOs4udNuBK73nt0GMWn6d7XUG8+HeNDy73JfSdZ
         zER/EbDnCQ9kwmxAljQPEIco66w69XSkdaFQsl/eh27xKDQ1RnaCNoTdyVoRN0AEdyDH
         zo62cnifmN3zcjHP+som40FPZdAD+Zb/fYY8SQghpSrvzAZ87rZOBdrjMaC64lLmpnCv
         233w==
X-Forwarded-Encrypted: i=1; AJvYcCXD/npw3MSXMT3F9ub3L11mPUx+cxUxBBG35M00xOyg2kHzpmBe057Kiq3nfnNJze7mPXQqtsX/OcJrsLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyUhHC0LqS49X8CFaVqEmN7aDMB9GYAKTUo5EzdYB69GdWX/C
	lG/8S6uV71XNvkr4bSWl6IpaDnTcjssDP0TMDQvm4G+sNL0ZjrqALWrv6A/JZTLJmI6TBsd3P2m
	yBkM9dvWEJISBTZ0edKVHK3JwUiMXifSULu4uRYdWsWYcX+bSWv2q3AzIP6bgxQ==
X-Gm-Gg: ASbGncsiFsi5DVU2bA69TJ5eWmxtt/uSl3/MsuLZ7OpDnqjPDwz0froBr2/F+bHrd0K
	f1L5NX4kXepkqRXtlFHbb8pg5hvFOGaqApNZbT3Sop2XwZ4hWJARkzZgu46tLeaQseP7xQ9O0zx
	9wqRVO1RJqQDnNyd3hSwiFQEZtGM+BBXQ3LpZqGj1q+dCS3bt94J7fBfwkTm/1qzcBrH4lufU+k
	phezcUrTCcIFovcPQCpVHoPdrP0MzSZfjJJlyvBG4dNJeC+wke+eRMho25wbdb+xnxOJ/A4fCrY
	akDX2K75KKVQkA==
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3ac9 with SMTP id ffacd0b85a97d-385f1ac3d18mr6152852f8f.17.1733159992493;
        Mon, 02 Dec 2024 09:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG85WlZO/QBaGMCugoF9sYm8aSKqDaJ5QSq+jZSb+fyCDanlsNLsHP9JFWpNh2ca7HuW9w2g==
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3ac9 with SMTP id ffacd0b85a97d-385f1ac3d18mr6152813f8f.17.1733159992095;
        Mon, 02 Dec 2024 09:19:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ec6a3d8fsm5375947f8f.101.2024.12.02.09.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:19:51 -0800 (PST)
Message-ID: <a0fc9b8c-e86d-46a2-a1d2-5ce8793ad2a5@redhat.com>
Date: Mon, 2 Dec 2024 18:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, daniel@ffwll.ch, christophe.jaillet@wanadoo.fr
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20241129122408.4167150-1-ryasuoka@redhat.com>
 <be01d2f7-8423-4e10-b65b-a84a7bc7c99e@collabora.com>
 <3ca0382c-a410-4424-a5a4-7c1b8be7ebed@collabora.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3ca0382c-a410-4424-a5a4-7c1b8be7ebed@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 17:19, Dmitry Osipenko wrote:
> On 12/2/24 17:29, Dmitry Osipenko wrote:
>> On 11/29/24 15:24, Ryosuke Yasuoka wrote:
>> ....
>>> +static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
>>> +					 struct drm_scanout_buffer *sb)
>>> +{
>>> +	struct virtio_gpu_object *bo;
>>> +
>>> +	if (!plane->state || !plane->state->fb || !plane->state->visible)
>>> +		return -ENODEV;
>>> +
>>> +	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
>>> +	if (virtio_gpu_is_vram(bo))
>>> +		return -ENODEV;
>>
>> VirtIO-GPU now supports importing external dmabufs, we should reject
>> bo->base.base.import_attach here now too.
>>
>>> +
>>> +	/* try to vmap it if possible */
>>> +	if (!bo->base.vaddr) {
>>> +		int ret;
>>> +
>>> +		ret = drm_gem_shmem_vmap(&bo->base, &sb->map[0]);
>>> +		if (ret)
>>> +			return ret;
>>
>> I've now noticed that drm_gem_shmem_vmap() expects BO reservation lock
>> to be held and we can't take lock it at a panic time.
>>
>> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L330
>>
>> This resv warning isn't triggered because bo->base.vaddr is set for VT
>> framebufffer BO when panic happens.

I usually test using gnome desktop in the VM, and in this case vaddr is 
not set, and calling vmap() is needed. (and I don't get the warning, I 
will check why).
>>
>> We actually should reject all BOs that don't have bo->base.vaddr set at
>> the panic time. Please correct it in v6 and rebase on top of a recent
>> drm-next tree.

The lock is there to prevent race conditions between concurrent tasks. 
In the panic handler, no other tasks can run in parallel. Also the 
buffer object is the one currently displayed, so it can't be in the 
middle of a free/resize or move operation. So I think it's safe to call 
vmap() from the panic handler.

> 
> Think ideally we need to have a pre-allocated and pre-mapped BO. Then
> when panic happens, use that BO and tell host to display it, i.e. not to
> reuse currently displayed BO. This will make panic display work in all
> conditions. WDYT?
> 

This means a full framebuffer will be allocated only for the panic use 
case. For GPU with a small amount of VRAM, it's not possible. But 
virtio-gpu is a bit special as it uses system RAM, so it might be less 
problematic to do that.

An alternate solution would be to make sure the framebuffer is vmapped 
(at least if it's shmem) so the panic handler won't need to call vmap().

Best regards,

-- 

Jocelyn



-- 

Jocelyn


