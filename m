Return-Path: <linux-kernel+bounces-556855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E7A5CF85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE5188A95A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8582641C6;
	Tue, 11 Mar 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPRgK1E4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F1D17591
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721772; cv=none; b=o6Ti5YeeGYt29gLRIYV//xsPiVZqOsU91sN5qsgk/Hw7fsrHB17r/o79YqX9+dCFDJ76xkLiU3grzDZzrVZiHOaz3MXqzGb9hFfGTYDnT3gTp8pwxnkltpPkYrRNycOOJkE+SNJNyRxGQq6EV3uZMFKw0cP1Ok3rsC1r+lMOz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721772; c=relaxed/simple;
	bh=9ZztcwujM2RKBfgxyjm6I2U1WTb1K0JNKkmtxjuvMAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rITCu4ogaBqHDQjcfYu5mL56t707BKQC7/+hA3pcB0GLFYsdhU0fyvuQyv+8A1wXlN3JQkQVdazb3X+Bluh+pn1FMHU3xWbBjGxYmqikO+mQHqSCvIxeaMKQ7iucB7xd2tTGNmPbNTBgKRWB8ZORpbhoh8IKvsQlgUDz8nx9igY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPRgK1E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482F3C4CEE9;
	Tue, 11 Mar 2025 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721771;
	bh=9ZztcwujM2RKBfgxyjm6I2U1WTb1K0JNKkmtxjuvMAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPRgK1E4GvODrXB6h5Y4d5ZvXmPK+l1GA0Dx5t6z+TrqR91t9/UBLHqG+3H3AeDYT
	 CRSMdbbn1t2KX0LuXPWBBqESThVJ6AUILcs/tSLidO7y7Dz5nEzgMsvErp+PyyaWZX
	 DbpN9upbkQhHwE29dellxe9MyeBUsOLAQHaRXhN2oVQ2fhRu0UY0JYDx8d0XU+O1TC
	 IiEqFabOWQO/VRPau92QGpHccial7TYWn50jZ9IrpEBQk1KutAQQTy8z2IoVwQqm8h
	 Ueamdly0b9OwmeBTMOLHYXGbHnzTbM+r8x32TxIOTSFoKmDdANdj4s79kUlXJvKYpN
	 Da/JkP0cVe7tA==
Date: Tue, 11 Mar 2025 21:36:06 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] drm/connector: hdmi: Evaluate limited range after
 computing format
Message-ID: <fgimm4muxrk2g5wclquhj6nxk6o3ioj4tqaczgaabswpany4kf@oi5lvsfg474v>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-1-fbdb94f02562@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-hdmi-conn-yuv-v2-1-fbdb94f02562@collabora.com>

On Tue, Mar 11, 2025 at 12:57:33PM +0200, Cristian Ciocaltea wrote:
> Evaluating the requirement to use a limited RGB quantization range
> involves a verification of the output format, among others, but this is
> currently performed before actually computing the format, hence relying
> on the old connector state.
> 
> Move the call to hdmi_is_limited_range() after hdmi_compute_config() to
> ensure the verification is done on the updated output format.
> 
> Fixes: 027d43590649 ("drm/connector: hdmi: Add RGB Quantization Range to the connector state")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>

-- 
With best wishes
Dmitry

