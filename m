Return-Path: <linux-kernel+bounces-577633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B104DA71FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D0D1899BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA1224EF75;
	Wed, 26 Mar 2025 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="BN0sZyrp"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B22E337C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018898; cv=pass; b=QkKQZ/5uL3yXpqPYp3IcteAi9Nq6PtPc4rRX0Rc19zBt7J3WLKDAPxg6FCuPHtHPMoX9jzRIHZ8sOo6g5RqKYjOdv3uJPjBnNHCAO/X5eqvC0T8E1lzgsjwse/Z08KxxCFxAv53FIxBggeEMreTJupWKXutkT2aikHfUi28XZc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018898; c=relaxed/simple;
	bh=Dy0J6EBrPQWCBVq9Slx+LWeV6rTwnEG6MDzoQ5GyC0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnZqaEo1Yp5rmAD2spT1MO+cFMJgXtIsmbZ1bG4FiYE+hdSZubuEherNhjKUk3qgg9AGKGcBAeomeEp6uIrxArzj9UTFzCIUSHDnmV/u5YS4OAzF9zzJu1Md/aW2oQSdtyhwy0jAp41cMLSBGHxIfFGnM3uRhzzEC3NCiijZcfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=BN0sZyrp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743018874; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=carkWtiol7Q6Etgnz18adBGw7YwbrRsciQm0GpsF7Ffgbfnbn85C4n6J4ZDvYkeqlLFqFXiDyeo9ZxFfYPoe+MmduF8YP81xznk+0ihqgGyULjrKN+EOZk4a9W90UUb09MhPZHx4C5IOvgyi9hN8LMsHy7n3z6aQ/uoN2698mPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743018874; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iWHtsRfC6sDeLCSXa8Igd46o0WY5wleHKKN8wZjwzWo=; 
	b=k2OPFthXhz+BwvZ6G5wpRr42R8nICmVLRAfcjcLv1SBln6h7uCof+UvJMAkonf4jBuCS2t8TtAYO4J5KF44GyQ3mnWwOHCHDCosoT1rKY96/sakdM/8fknwlC0+xsifAhYAl1qtze4xW+PZEdPEwZJ4Q3zglYASnvfXRSDSeXio=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743018874;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iWHtsRfC6sDeLCSXa8Igd46o0WY5wleHKKN8wZjwzWo=;
	b=BN0sZyrpUhLauOFR/PvagqgfCxqvjZZcXLFFrDlC557mlg+KM83XxoOhXC1wYFCv
	i3Jebm9yeoCdXk58yd+sKFJHAaBh75YN75nvlnGkwWjxYI/8/VJtnyV1YMQ3v0Nmo0L
	5LKuGG+5zDu2RD3UvzHc9MPZPIo57PGdG2JC5DBw=
Received: by mx.zohomail.com with SMTPS id 17430188720701011.2938235750142;
	Wed, 26 Mar 2025 12:54:32 -0700 (PDT)
Message-ID: <e4f41400-b300-43ee-843f-8bc407aa9f76@collabora.com>
Date: Wed, 26 Mar 2025 22:54:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/6] drm/shmem: Implement sparse allocation of
 pages for shmem objects
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250326021433.772196-1-adrian.larumbe@collabora.com>
 <20250326021433.772196-4-adrian.larumbe@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250326021433.772196-4-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 3/26/25 05:14, Adrián Larumbe wrote:
> +static struct sg_table *
> +drm_gem_shmem_sparse_get_sgt_range(struct drm_gem_shmem_object *shmem,
> +				   unsigned int n_pages, pgoff_t page_offset,
> +				   gfp_t gfp)
> +{
> +	struct drm_gem_object *obj = &shmem->base;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	if (drm_WARN_ON(obj->dev, !shmem->sparse))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* If the page range wasn't allocated, then bail out immediately */
> +	if (xa_load(&shmem->xapages, page_offset) == NULL)
> +		return ERR_PTR(-EINVAL);
> +
> +	sgt = kzalloc(sizeof(*sgt), GFP_NOWAIT);

You likely meant to use the gfp arg here.

-- 
Best regards,
Dmitry

