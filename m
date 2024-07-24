Return-Path: <linux-kernel+bounces-261421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D493B71F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E4DB24240
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344A15F409;
	Wed, 24 Jul 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XuErSEQV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927449658
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847645; cv=none; b=Bg1Lr7wm6275xtzTICuzQDecwoBk70syLlzOfXTZ9FmzxZlZXSmrNlrnsqwrls++hYZhY2veq533xcqFLBGCzZkLNYP8gB/f8ALs+bHnWTbMXWOqKmLvHQm0ckZ4GIcWqxCH5eRpxl6vf0GIgKA2sVydIPZteCrrDZRijEARgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847645; c=relaxed/simple;
	bh=NkPLrp+DvJ2qkX/aT+LXxDGVGJDmAwtqvl6lVPEpaYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gamv3jzDeE2E1Nkzg66WZD5i5iz0InKVDCCeFSZdYGao8xJuBg3Rl6GqgqBtuemXN+HQMUnQ3+er/wimKatOuHaeejJyo72snOzWtnjzE87cXKBASZuL4/jYSpA43Kr6lrpAyd+NM5Wom+3A8Gnn1TYJQoXAViocMSqz7uQUpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XuErSEQV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721847635;
	bh=NkPLrp+DvJ2qkX/aT+LXxDGVGJDmAwtqvl6lVPEpaYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XuErSEQV8D2cc650zcKHplavmK3SBilWlD1wTlM2guWzSzAz46fTok5+K1hHZbZmy
	 o/JFlHI1+M1+JFi8NDFgLB7bQZSxNu5bLV56SFFKN73shodONVSCxs+54quiLYa74F
	 dRumTEZlC2wsK2f4A/CSPUyBV8nySXGOZOeA3LAIzNaANEazgnjal9qvArz/hgyk4w
	 Wuq2hSetTGXdlIgk/wm9nnUlC+l8NX9Gj0gKOTN6JXhj9TtJuKotXeok3+rzG18IK6
	 l/RdnoLtSGQ1Fs4sMKnbShXEchvVRmcrsyA6T9VS1z8du8EF2cx/K2pz1UrgR2XdDA
	 PsHQQyou6JN4w==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 76C2237813E1;
	Wed, 24 Jul 2024 19:00:34 +0000 (UTC)
Message-ID: <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
Date: Wed, 24 Jul 2024 22:00:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Sergio Lopez <slp@redhat.com>, gurchetansingh@chromium.org,
 tzimmermann@suse.de, mripard@kernel.org, olvaffe@gmail.com,
 kraxel@redhat.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20240723114914.53677-1-slp@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240723114914.53677-1-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/24 14:49, Sergio Lopez wrote:
> There's an incresing number of machines supporting multiple page sizes
> and on these machines the host and a guest can be running, each one,
> with a different page size.
> 
> For what pertains to virtio-gpu, this is not a problem if the page size
> of the guest happens to be bigger or equal than the host, but will
> potentially lead to failures in memory allocations and/or mappings
> otherwise.

Please describe concrete problem you're trying to solve. Guest memory
allocation consists of guest pages, I don't see how knowledge of host
page size helps anything in userspace.

I suspect you want this for host blobs, but then it should be
virtio_gpu_vram_create() that should use max(host_page_sz,
guest_page_size), AFAICT. It's kernel who is responsible for memory
management, userspace can't be trusted for doing that.

-- 
Best regards,
Dmitry


