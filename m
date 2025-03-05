Return-Path: <linux-kernel+bounces-546679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6224A4FD99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C8A7A292F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529BB233708;
	Wed,  5 Mar 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="QPYmHm4s"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279ED21421B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174072; cv=pass; b=d0wt8RiN3RSwmQZBxFPsH55ns7AK83ffHxXk2qpkN7tDUfRI48XpYcC/MxUXVn148PZcMJJGgeA3HygEsFJhG9oVlofBV8S7IIUg4bcQu+BiK+AObRR1Ogm1ncg0bKGQjyghLpcFNA8cKN26kI1sA145ptaGsld/7gwiivlGMCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174072; c=relaxed/simple;
	bh=v80FmKrGAL6smsBWn6tIKL8x5t/5JRF4vkflAvMBkqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo7GdvhGPQgGsrYfmYbG2lVMOCQcziZJ/msJxNVzZ0a1WDf4LFQcly9fgwEsbZD+D9jl+Vp5ql4FeeG/BjbAVjpz6GkwYRQSKf3DqgY9Whm8SRFs1+iovfedOz1CdXg5Q/qJzkEJT3vyWlc9UGrpn2HSpgecSQHuOFDaWnvf1Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=QPYmHm4s; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741174020; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CGgNB9ioCrBhZoIu/54P4IE8VnMh233mFWObUx4IRiSRYQN0kgpLfN/b1j6tf5xb9Qvawe5SYEsGSK1SKsCH+dJbVCYse5EBI+9PFV7Rmc0b36jSY3crmcWENqDPN/6t7PReK6l5xQ+TsIlEZAEIJAYGp006r/VmxtROQH9FOZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741174020; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NzN883oKEAj7l0UzhDNc+FFNuxWeXDfWS3FNs5UvJiU=; 
	b=KkVW8eJlC1hVbD11lN1H56RQJHKk6lUI912ctlOYikwCfPSGLEc07HcNeJxn7AAdEZmZ5nhmYrx9qqHxOhBwSmmnQ4ECRwwSgoxZsLadBzP+9iQJ5cj6h719LPU4dPnnY7ua33GJYX/yGb/i/OF/92tiedgKjG3ea7e7CkQy86E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741174019;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NzN883oKEAj7l0UzhDNc+FFNuxWeXDfWS3FNs5UvJiU=;
	b=QPYmHm4szIi7SlH9hSsNQbOfL5iaoAIjlaI4j/ShskiVl0RYg2oj2q+fLX7EyQBx
	djPTZWjB0QSPFT6ygEduHEVCS65V1dZkkAL0ipOv2v+S+NaDvJ4lQD+8EXil1bG9flW
	Z2CPVo0wGKJvUVQ5aKbtzC5q4r+fms/tl/5Nchk4=
Received: by mx.zohomail.com with SMTPS id 1741174017652344.167196887577;
	Wed, 5 Mar 2025 03:26:57 -0800 (PST)
Message-ID: <f164cb3a-5285-46e9-9ba1-062cfcb2f920@collabora.com>
Date: Wed, 5 Mar 2025 14:26:52 +0300
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
 <6b7d95b7-a9dd-43c9-b1db-8a636b85ad51@collabora.com>
 <d777ab50-51cf-4eed-bfec-a44eca7ba3c5@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <d777ab50-51cf-4eed-bfec-a44eca7ba3c5@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/4/25 14:43, Thomas Zimmermann wrote:
> Hi
> 
> Am 04.03.25 um 11:59 schrieb Dmitry Osipenko:
>> On 3/4/25 13:29, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 05.01.24 um 19:46 schrieb Dmitry Osipenko:
>>>> Introduce common drm-shmem shrinker for DRM drivers.
>>> What's the status of this patch?
>> It was de-prioritized on my list a year ago as I had to move to a higher
>> priority problems. Rebasing and re-testing these patches takes much
>> time, it either has to be split up in a smaller parts or applied in
>> one go.
> 
> The first 11 patches seem uncontroversial to me; maybe except for patch
> 9. Could they be merged any time soon?
> 
> The next batch could then be patches up to #20, which seem to be
> reviewed as well.
> 
>>
>> The current status is that I started to work on v20 rather long time ago
>> and the patches need to be rebased and re-tested again. Heard that
>> Panthor driver may want shmem shrinker more than others today.
> 
> I've been receiving reports about low performance of ast plus gem-shmem
> recently. I suspect that the vmap/vunmap overhead could be related and
> this series would likely lessen the problem.

Alright, will refresh the patches. See if the first ones sill can be
merged right away and then split the remainder into batches.

-- 
Best regards,
Dmitry

