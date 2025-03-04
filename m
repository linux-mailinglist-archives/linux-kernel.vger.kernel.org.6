Return-Path: <linux-kernel+bounces-543947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4737A4DBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4156189CE35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0E20124F;
	Tue,  4 Mar 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="AE6MV5R4"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC232010E5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086010; cv=pass; b=Q/TqXZFih8o64OcJNyxYGXVUgLVWnS1O6+sOSpET4azR8KeUKIrNBljiOR7rOS5D2qJ+sDpPrxPHiqhPMQuisiBM3eNYfI98w1bqwAtl5WnS4KzaroQpTtf7QnOD1k3TSB3AaaF7Sf7xjR0tc4o7ZLyZxuTXHMdpOGTRuNA5VDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086010; c=relaxed/simple;
	bh=mt7hEnVoH9ixJLgXuCnPk+QEtURpCqfN/VDQ8rFvN+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ul7mCQein/we6436nt8U+RhMwH7j+JAHZZKP4zLqxQKVJ48BF+Qi5TLkzVhJY10BFE/hZp015pA64FimC4fIQjx3H2qRR0ZbWf2ZMROwPuloXLa5AvFb/o6WKq9uoKYe7nbVfPVfGEegxF2yHaQT1ff6M2Hk9VbDCvqY9br9j8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=AE6MV5R4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741085958; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JgfciHxqZYyFSSfuhuv5vjVyq//D99mHx5wTVSy9RmDJQHUdgiW35c7twCWqZwXHJg5n6De5YA97iavK7rHFe4ZhbZrbqOVRu/MIFqxTAl3i8Ek8/V8XpRONF2QR1vml1jp/0laKIYlgLGG3QbMSkM3f3s5kXuhHBZoeS38vm3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741085958; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dbsr2DzMdYZQ4tGo8UWZqeyiKrIzRaj9gxDPB5xSI+M=; 
	b=ctwWrTWsqBfu/EzXaZS6O/bRL5u2s6IExQLG1qbNHnvSx8k8iZ9bK0sE/9ULBOFKRSJTUDAon6fCTw/HUDAvSeHwoTkpAt7BNLXRQiubBqCUxdcGNrLUVG7DuzWQ8fUweLmWJVQDDXKwcBylXbhxF5UqpwIeqAY79vC5LK9HvtY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741085958;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Dbsr2DzMdYZQ4tGo8UWZqeyiKrIzRaj9gxDPB5xSI+M=;
	b=AE6MV5R4+ndvbYnirTlQbXoIphSwJhAjOCrPYHODCALnoq6TCaJFUpwnUQgu8B7B
	GoVR7tT2Yh2PDT2PxyUJotLWTUnWda1TM2n6wQzgI2GQAy8Ml7LBrxMm159NK0pzL7j
	Xn8UXuv45TdXfxx1lLGgOpgsOVxmEW8NByqxB3NI=
Received: by mx.zohomail.com with SMTPS id 174108595555814.859596015899456;
	Tue, 4 Mar 2025 02:59:15 -0800 (PST)
Message-ID: <6b7d95b7-a9dd-43c9-b1db-8a636b85ad51@collabora.com>
Date: Tue, 4 Mar 2025 13:59:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-23-dmitry.osipenko@collabora.com>
 <d1f856c7-47dd-4f1d-a124-973064dcd1f0@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <d1f856c7-47dd-4f1d-a124-973064dcd1f0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/4/25 13:29, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.01.24 um 19:46 schrieb Dmitry Osipenko:
>> Introduce common drm-shmem shrinker for DRM drivers.
> 
> What's the status of this patch?

It was de-prioritized on my list a year ago as I had to move to a higher
priority problems. Rebasing and re-testing these patches takes much
time, it either has to be split up in a smaller parts or applied in one go.

The current status is that I started to work on v20 rather long time ago
and the patches need to be rebased and re-tested again. Heard that
Panthor driver may want shmem shrinker more than others today.

-- 
Best regards,
Dmitry

