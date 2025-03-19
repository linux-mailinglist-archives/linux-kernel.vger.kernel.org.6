Return-Path: <linux-kernel+bounces-568154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D112A68EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473421669AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C880B1ACEAB;
	Wed, 19 Mar 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r08pHwKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E5158538
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393940; cv=none; b=COtbOnWF59ptKBYpz2Y2z1W7IYU9IN8LaGsMxia4ffR9I3Gvsvup1uzv+ZrYDFTuaOYUKsDXWN8GDcGqD9BuqNyC2p9Mnqy+O+CS5fmM0GmMyjObCrjeAuiWgRNQn2mARha6XfL6CDvvB4BL+gMKwMbdzp2gYNshMIjlyxH/4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393940; c=relaxed/simple;
	bh=dAoUWEgPhk2QRdXLCT44t/EDS3tWNjL6kBs1ZsCscdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfav4OKocDz7bgTktuSmaMsuQfO+wjpqgjK427yILWmbeSbFm2g0yjEmJYpH29CvzZkB6fM+VhWJiMnpK2kR3x37Dahq/whfNYqCc9WMMH964rClMIh1ccwPxLG3y3H5RV/23b7z7NFHeCQzKJT7vEvUwZPqzf3xduPuu5dLQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r08pHwKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE96C4CEE4;
	Wed, 19 Mar 2025 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742393939;
	bh=dAoUWEgPhk2QRdXLCT44t/EDS3tWNjL6kBs1ZsCscdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r08pHwKevnU20iS6Nz3unBUAHjit7HMdvHvZZXs95dpRqCUEKGb6iixPZj1MlEjEF
	 FZjHaHFu35sDnIaw/QelxEnpNYizzXEizUZJjyonscG3AIPI/OTJEtV9C5UWUms/Kq
	 qpBQzaw1k1oWaUtEpHMT1ZbI26zbNx4L6Gli5wotj+Y5G/GKHJR1vntbCRWeNkGPVs
	 DVOLAAgHrm8CrfdVBZDX7PaJBpv4r1Car13XYcVJOrTP95zQOkmMtrCR6FqLXLGE04
	 WxfBfeUIL2Wk9Gm7yBEDEVxUrrsDhUyJVfQoTzVf1rvQbTHP18kOSEBIx+7gDtqdh9
	 lY/A2OOztp0oQ==
Date: Wed, 19 Mar 2025 15:18:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
	nouveau@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lyude@redhat.com, sumit.semwal@linaro.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau: prime: fix ttm_bo_delayed_delete oops
Message-ID: <Z9rSTkXlub-JZAz0@cassiopeiae>
References: <Z9GHj-edWJmyzpdY@debian.local>
 <00e4d9c4-ecfc-4784-b603-12db04cda806@amd.com>
 <Z9q-ggKKgTsvW-Rz@debian.local>
 <Z9rA0G2urlVHFOSx@cassiopeiae>
 <1f4a534f-8883-4793-b191-60c2773f6217@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f4a534f-8883-4793-b191-60c2773f6217@amd.com>

On Wed, Mar 19, 2025 at 03:06:52PM +0100, Christian König wrote:
> Am 19.03.25 um 14:04 schrieb Danilo Krummrich:
> 
> >> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> >> Co-Developed-by: Christian König <christian.koenig@amd.com>
> > Then also Christian's SoB is required.
> 
> I only pointed out which two lines in nouveau need to move to fix this.
> 
> All the credit to figuring out what's wrong go to Chris, but feel free to add my SoB if required.

Then maybe Suggested-by: is the tags that fits best. :)

> 
> >
> >> Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/3937
> > This is a bug report from amdgpu, but I understand that the same issue applies
> > for nouveau.
> 
> The crash in amdgpu was caused by nouveau incorrectly dropping a DMA-buf reference while it was still needed.

Oh, I see.

> 
> Took us a while to figure that out, we could update the tags in the bug report but I think at this point it's unnecessary.

Agreed.

> 
> >
> > If at all, this needs to be
> >
> > 	Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3937
> >
> > Maybe you can add a brief comment that this report applies for nouveau as well.
> >
> > Please also add a Fixes: tag that indicates the commit in nouveau that
> > introduced the problem and Cc stable.
> 
> As far as I can see it was always there and was added >10years ago with the very first DMA-buf support.
> 
> But adding CC stable is a really good idea.

Sounds good.

