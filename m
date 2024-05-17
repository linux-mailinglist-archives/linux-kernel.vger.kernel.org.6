Return-Path: <linux-kernel+bounces-182606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F848C8D32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C43A1C21FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABDA14037D;
	Fri, 17 May 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur9I/fdO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BD65F
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976744; cv=none; b=bdJ50cw656gNzEpzSWy8T7J4N3dwHgJX101NzrcNcYYqRUbjEl+minGaiufFLFzSfI7UZBRz2zSpM0AsxoczfGxSknZz0JNtLxM2qmkwvK8IphNNYYaE1FhUaart35zw5DBAIjZwhfsUKfHDEA62C4NSz/6jGDHjGztIpR7eHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976744; c=relaxed/simple;
	bh=S8uwpeLZ+ub2Pr8pjfgM4+SSbXbFNBtJ2z2gFUGvxh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUZTUhzs5eu778uvC5cOVCIC9X5s89yaEje2+POG6B+TXkvI74tO0NlyWp1CGn6PZN8jDPZTsCpqeiqplyxAWxYvFqyMXbbHSCtH69F9ReEhdh2w30xQf9IHmi5jfjQ1l/igDISPkyaUGhviJMLbx91Yiu3J1PqVeLwfByh0yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur9I/fdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D93C32782;
	Fri, 17 May 2024 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715976744;
	bh=S8uwpeLZ+ub2Pr8pjfgM4+SSbXbFNBtJ2z2gFUGvxh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ur9I/fdOwlQftj39+BLRaZvYz/EKKieyZqNSdOFkj1wv6eHn3qYhFQwVO8VNg0fy1
	 K7nLW4pt6Upyaz9lVmzGI0pELPdiicDSf8kcjqWvvJFX22MqEEtIUmSSj+VuLAXdb5
	 /h3dY/0lQlMb8FQOd9fYA2Dd73Q+sCLsyTTyNxUXSm4PhzG6/jG49d9OMVsI60dQsz
	 5/8/mexdS6A2hqg0GrR5lQojsRfpYbnssOcP6//KL2G9fk+BvQsODdxddqjaHzGmbM
	 NFKhiUmkAwDb3rjvZaitpuhY9ST5/AuU47sYn+Eoft18j+q2SqMMJEMzOxZQmd6rXO
	 xchTC4RlyUytQ==
Date: Fri, 17 May 2024 13:12:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, David Airlie
 <airlied@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter
 <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 0/2] Fix Kernel CI issues
Message-ID: <20240517131222.2f147cf9@kernel.org>
In-Reply-To: <2002d2b4-ab0c-4c35-9693-c2b82054262c@ideasonboard.com>
References: <20240426-dp-live-fmt-fix-v3-0-e904b5ae51d7@amd.com>
	<2a14d8ff-a8f5-4ebe-9f0e-a5554b417f0c@ideasonboard.com>
	<20240503162733.GA4136865@thelio-3990X>
	<2002d2b4-ab0c-4c35-9693-c2b82054262c@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2024 20:25:49 +0300 Tomi Valkeinen wrote:
> > I think the second patch also needs to go to drm-misc-next-fixes? The
> > clang warning fixed by it has returned in next-20240503 because it
> > appears that for-linux-next was switch from drm-misc-next to
> > drm-misc-next-fixes, as I see for-linux-next was pointing to commit
> > 235e60653f8d ("drm/debugfs: Drop conditionals around of_node pointers")
> > on drm-misc-next in next-20240502 but it is now pointing to commit
> > be3f3042391d ("drm: zynqmp_dpsub: Always register bridge") on
> > drm-misc-next-fixes in next-20240503.  
> 
> Oh. Hmm, did I just hit the feature-freeze point with the fixes...
> 
> Now I'm unsure where I should push these (if anywhere), as they already 
> are in drm-misc-next.
> 
> DRM Misc maintainers, can you give me a hint? =)

This is now breaking allmodconfig build of Linus's tree.
Could you please get it fixed ASAP?

