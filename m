Return-Path: <linux-kernel+bounces-274437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9E947811
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C51282750
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D914E2D8;
	Mon,  5 Aug 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXFw5BtV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EEB13DDC2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849255; cv=none; b=NkcUodM1KxVGNLfzQ8YXfonTCGK7E8jKWi49LW9RZGgK//67O5UZ3ka2i3ek9Sc4khK7Xr0fgqUtaYSYqTewYEy4PJwPX+QTg4vxsD8ofBBzQGhVr3tt/SX7RVZvXF1gcDaI0+aPaKnG2jnW3BNwfRVWYFS5iLjQiZYDLe8zZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849255; c=relaxed/simple;
	bh=cYEr12ESNSjKojO6NUh+zO4URzAONDoFGizHlfeb6CM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwRRZcHUYUdgnkKun8FgAUNWGBkOSldIWXk51NSPfm515XInvmZ7YjAYrd2xMAslRP5ETh1coxY0hqXV4b7gkPoNkO/NCJK2I4cAi4Tz6ItrXcFDHIuZoTbWQXhtkJf0JxgS4Mj5m+LZOjK07JMD9mQZQ7fOb/k6GPPxLkVPHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXFw5BtV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722849253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYEr12ESNSjKojO6NUh+zO4URzAONDoFGizHlfeb6CM=;
	b=WXFw5BtViZwUqbc0+CS1qP5qd5eOmmRILvUR4BD7GPx2HfGt4QKyUL9i9KYpueYP4waX8H
	5aRt0udzZSnHmkIguWYS6STVzlhxzWqkx5EyIdNPzjOjffdkjuISDwnpvNvudT+yKBNOVH
	EEsTwi7SDW8PxDqFchSAzCiHcUJiZXs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-LJmGJ4MdO5KGI4OcQ2klYw-1; Mon, 05 Aug 2024 05:14:11 -0400
X-MC-Unique: LJmGJ4MdO5KGI4OcQ2klYw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7a1914d0936so8089530a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849250; x=1723454050;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYEr12ESNSjKojO6NUh+zO4URzAONDoFGizHlfeb6CM=;
        b=b9/+1e1bXF9y/R246KJiRmZzLSMwVUaNcm56UUJCR6vpc1nxO16zFDzL5U6OFGuXA3
         ygPowJdUDmZIXkPWjhSFFH3A305rGzu44eIUN3kaFJyJvfl9m8E7G3tM3wfy5FJLXiAx
         dPq1nPCOQsrp9f61siJIp8Xm/q93TQFzYXVaMBFgaJrSVJ4d+rJYL8ETGYruHVLZd8BA
         8EfLFqCdwUIoDK+zTRtuTrh/rPkSC0ln7pxTgOQ8kIdMZYopIKGudVQmTTt1GkX1Wro2
         I1cO6Okuz3snQmWYGBkU0SGbd1p8gOhXqlVUOUpMmTqBcbXquYM3uGUkYbDoOVdvCVNP
         1Icg==
X-Gm-Message-State: AOJu0YzNfzuXT6Nw1SDNtzfinwqmn0rhqvFQg6vhKxbkw0MHme2T6CzW
	D8cw1XQbjmH/A1K2Gs/iGOfXgHcp641BI+XnciL/zvoXE3Gp5x5YfnvROQirIKuyAMix0qBZoi/
	lM5E/k3vSI1Y/6zlyviAM4tegM1hJp80aiuy0XnBRxy1jJuetl7g2b66MGiaCK+fpVAtzPUbt+/
	/Rr2BrrWrJpq1gRKKkNNt5fzqvljC3NrCZ3ocQ
X-Received: by 2002:a05:6a20:d80d:b0:1c0:f5ea:d447 with SMTP id adf61e73a8af0-1c69959d1ecmr11272138637.31.1722849250577;
        Mon, 05 Aug 2024 02:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHx+ra0bxEhW+9FV7kXYO0559BlpJINXNAHMKtXsFbYfAG4Tt3wh9BjFp2TlNFgdjgQOeIaX1M39gbMSBHCUQ=
X-Received: by 2002:a05:6a20:d80d:b0:1c0:f5ea:d447 with SMTP id
 adf61e73a8af0-1c69959d1ecmr11272112637.31.1722849250168; Mon, 05 Aug 2024
 02:14:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Aug 2024 04:14:09 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Aug 2024 04:14:09 -0500
Message-ID: <CAAiTLFV6mAgrMj=itcxoBCibvYRyrAk02wYp-gYJ8kxhF0EPmw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, gurchetansingh@chromium.org, 
	tzimmermann@suse.de, mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 7/23/24 14:49, Sergio Lopez wrote:
>> There's an incresing number of machines supporting multiple page sizes
>> and on these machines the host and a guest can be running, each one,
>> with a different page size.
>>
>> For what pertains to virtio-gpu, this is not a problem if the page size
>> of the guest happens to be bigger or equal than the host, but will
>> potentially lead to failures in memory allocations and/or mappings
>> otherwise.
>
> Please describe concrete problem you're trying to solve. Guest memory
> allocation consists of guest pages, I don't see how knowledge of host
> page size helps anything in userspace.
>
> I suspect you want this for host blobs, but then it should be
> virtio_gpu_vram_create() that should use max(host_page_sz,
> guest_page_size), AFAICT. It's kernel who is responsible for memory
> management, userspace can't be trusted for doing that.

Mesa's Vulkan/Venus uses CREATE_BLOB to request the host the creation
and mapping into the guest of device-backed memory and shmem regions.
The CREATE_BLOB ioctl doesn't update drm_virtgpu_resource_create->size,
so the guest kernel (and, as a consequence, the host kernel) can't
override the user's request.

I'd like Mesa's Vulkan/Venus in the guest to be able to obtain the host
page size to align the size of the CREATE_BLOB requests as required.

Thanks,
Sergio.


