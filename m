Return-Path: <linux-kernel+bounces-398282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EE9BEEDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B38F2864CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A41DF747;
	Wed,  6 Nov 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qvS9YrPZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCE646
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899300; cv=none; b=rOjCKjvs02fnJiZoPsSq0CmB9RXqKw3s9P6WOWHdo6F+nXfIkCQ3FoGSFmO68jE+nP5F7Vc/NtNhV3r+CwOctc0KlxoIIG/4OLxewjw5cgisOrNMKiq9Ixp4Dx5RQHwFfU3NPa374ldhJTw6S/ydJ8eeSuT7eblFIQ7qJPUwaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899300; c=relaxed/simple;
	bh=L4gObn6j06oIMdGdQW22qFXKQRjQnkUKPXbGIDbK3Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=actdgVkO3zn0QamN8EMC9eGOjJ0rXD7knPEnTZ0ZL4c2adFC30hv1uwI324WdOW5Vt30VlKXmDdaaue407+B5yBEyHWv+ZeNl4cs7wkfTiNv+kIwvotPOB/W6vYaIWGTCYVctbALMkXk7aoQuG2sBzRXovO99UJz/39TabSX4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qvS9YrPZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730899297;
	bh=L4gObn6j06oIMdGdQW22qFXKQRjQnkUKPXbGIDbK3Fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qvS9YrPZNQbU1UtsVy7BUApWZz4qT2vNKKEYry6WwqkipxxgsbqzwwcqHJCDNhUew
	 C+xyaHtSu1x9P3P8sp82Kx366X+VpWEJxRgh219vKPqqAKjhjuzwgqe3t+UJ3Mb7oD
	 u9sBchlm+T7VABRBzUKNlDdBupo3Pev+NdB2NntReVauOzlabVjOVuatdHUROYZMUL
	 k2+Bc4VlWFYWhfcwQ5gRhj4vYf6LKtvO6UatxPnXTRICkSFnmPN1NQO05ZhZMfEbps
	 7zGBzM4djhdKJKeCING9Ngqt95/cCYulwYT5Sv7pDG3IHAcU3gHhCB+MfFZBZ4PT+C
	 U0tJ/t4bNKX1A==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AFA3917E3635;
	Wed,  6 Nov 2024 14:21:36 +0100 (CET)
Date: Wed, 6 Nov 2024 14:21:33 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
Message-ID: <20241106142133.09378b5a@collabora.com>
In-Reply-To: <ZytqzTg2QnEkvDcl@e110455-lin.cambridge.arm.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
	<20241106131641.47487624@collabora.com>
	<ZytqzTg2QnEkvDcl@e110455-lin.cambridge.arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 13:10:37 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> panthor_heap_pool_release() does not take the panthor_heap_pool::lock, so the protection
> is not really there. I could fix panthor_heap_pool_release() and then add a
> lockdep_assert_held() before both calls to xa_load() if you think that's a better
> solution.

Hm, but panthor_heap_pool_release() doesn't release the heap contexts,
it just calls xa_destroy(). If we have objects remaining in the xarray,
they'll be leaked, but that's not a race. BTW, can we make this two
separate patches. I feel like the thing on the vm is an actual fix,
while the second one (adding a helper with a lockdep_assert()) is
safety net that's worth having, but not necessarily something we need
to backport.

