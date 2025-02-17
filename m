Return-Path: <linux-kernel+bounces-517096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F2DA37C10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E153C16F98D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D718C33B;
	Mon, 17 Feb 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBmE5F0B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD7191489
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776783; cv=none; b=D+O5+LkPzAua62E484FAloshVKuxjy5P7m4SRtW0ruKwbE9WX3ZaFXWQb152QYoqeB8zIqZ2sQ8JPFrvFbfp+W2UTzYwkroV25Y+AjUE9rcxrJtLl5FiTcrXu1rJbNYHaywbMbF5xWAA7KQv+sY7JMx/i1ZuZ2lJawe7HEA8L3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776783; c=relaxed/simple;
	bh=vfGe1WhH3u9EJrPfu6F2TVFGpeySf1sa0OGAW7VgWZM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSBezp816bMLAjzfw5TNcWN1xXtqhXVi/ed+JMRPzLdde5zhSfS1sliDYsemFYWuGPAe2fUCZHChjT0kfqUNmkB7pmcaEpzs2BAHgnhmsHW+mDGygRTSAoR5msQIYzRsBkIBqMFN4iK/Eu84/bn/d0VLtKjjrz/iQMHbyPQJRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBmE5F0B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739776779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlfl+lmHhnb3eDe+iFkolSYqaJktZfayJNrM+qurEz0=;
	b=EBmE5F0BS6y/QANt7Kw5K902fkWGjBGZiFPlfzssLeQ1CRvE46XApwkjv8ocLVKLlNyOmM
	QuGyPvL8kaSGb3k2G58wfg3EE12ZlXZXSpaEH2Ph3hknywIn0jEkSsVJtQiP3WYdcRY6nt
	IChs8dH7iSlfMaBB3cJFyhmYlDQbosM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-anVF4ZemPHC_kz7x4UoS9w-1; Mon, 17 Feb 2025 02:19:38 -0500
X-MC-Unique: anVF4ZemPHC_kz7x4UoS9w-1
X-Mimecast-MFC-AGG-ID: anVF4ZemPHC_kz7x4UoS9w_1739776777
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc2fee4425so8499963a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776777; x=1740381577;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlfl+lmHhnb3eDe+iFkolSYqaJktZfayJNrM+qurEz0=;
        b=dYKStPSZozlrYn7uyq36bMfkMAkwGEObwrH1KS/QFq0OUwEi54PtWKIb4pvFMjOH48
         wwqjgyXL3RjoYStl7rKthZbqEBL6E/0F9emm9g+q5mySXlQFEPd+dU1YCbsxfFBccZej
         9Ubx1BOVyPgr5EQD8Az2WZkkAuzjFmpThj7PrnzPpuDg9azJIq7wzh2gPGHFemXPEUTR
         /2GD5ScFJDYoNOVrB2RPPh1KjF4eOfd03aaQ06wP4kEwIIUlKK1zH4HNbLFteq7lo8jw
         QF1qtPRLywMei+bGT9gRe5hgwt8PVbaIVAdjLhhpiH20RNE4OLbSOQhHrpv7wo1zD5rr
         Cyvg==
X-Forwarded-Encrypted: i=1; AJvYcCUS+D3uKvye7JProCZQ3CpCCmc69K0Qatvgfnb2vsMcotZTpSa+foXRPCVYpWFwediYNUXQk9OrWihzaD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXswH6ZUuKpO8UTvTtpZQelChDCRNaj1N47GA30mxnPpqi3cs
	lFozwhnL8ytkBgg2I5dNRM9mnbiCrOAUiPZWR/Nm/z8Qsu6FLMicyNFG/ExxxBnOGkdtJR9poSG
	JGPpZ6h+9B7C5Gf42OPEJ8WynnRzX88LgCmL9Z5LaMmpH2ALSZRqbR7It/6WvhiQQj0MTqAsELW
	Y5CK5J/ndIOFtLDHGBClOSZk6n+SZp1bzodblD
X-Gm-Gg: ASbGnctIUlxNmvaDmo8ZDCyheMo6R2mtFa4G8Q7VkuC0xHIztrE6TO2JcOKRfOpuVX8
	IwMMxLxbOl70pO0XtiriKPKDts+a+KhGRiHlGq7x4L7r8tKZ+XILqts/De2K1ldytrorxhbm+5j
	B3wuE570LvD1amNvJVvlY=
X-Received: by 2002:a17:90b:4ad0:b0:2ee:a4f2:b307 with SMTP id 98e67ed59e1d1-2fc40d14deamr14187534a91.4.1739776777316;
        Sun, 16 Feb 2025 23:19:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqqYNFvrv7otKwk8EcZ5/jMtgR2Ep8+aemJnqKzPb45Yu2FPbMWq7EQ9gKvlZNIOHRf6FoesIjHYgLlK7NWSg=
X-Received: by 2002:a17:90b:4ad0:b0:2ee:a4f2:b307 with SMTP id
 98e67ed59e1d1-2fc40d14deamr14187493a91.4.1739776776856; Sun, 16 Feb 2025
 23:19:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Feb 2025 02:19:35 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <f6d6de4d-1b87-4a53-a2eb-0d9ddfbc4311@collabora.com>
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
 <20250214-virtio-shm-page-size-v2-5-aa1619e6908b@redhat.com> <f6d6de4d-1b87-4a53-a2eb-0d9ddfbc4311@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Feb 2025 02:19:35 -0500
X-Gm-Features: AWEUYZkmTZoXk7_Rz3zTEPLKhoc079NRhM3R6YYEKHGPH952bEMjXNC96qKluPM
Message-ID: <CAAiTLFU3UhQyHzpPQKQpJcp_vpOrWdDU7Gv_ng6Vbm0B_+Lv9Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE
 to params
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 2/14/25 18:16, Sergio Lopez wrote:
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> index c33c057365f85a2ace536f91655c903036827312..4b49635b4fe1d4256f219823341cef8e5fa8f029 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
>>  	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
>>  		value = vgdev->has_context_init ? 1 : 0;
>>  		break;
>> +	case VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE:
>> +		if (!vgdev->has_host_visible)
>> +			return -EINVAL;
>
> Nit: virtio_gpu_getparam_ioctl() returns EINVAL for unsupported params.
> While this is a supported param, but there is no hostmem available.
> Hence, should a different error code, maybe ENOENT or ENXIO.

Good point. I'll update it to return ENOENT in v3.

Thanks,
Sergio.


