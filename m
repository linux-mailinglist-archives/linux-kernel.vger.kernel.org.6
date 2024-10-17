Return-Path: <linux-kernel+bounces-370143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8B9A2862
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EC0285076
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DD1DED75;
	Thu, 17 Oct 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyLUiinp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50A1C1AA5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181905; cv=none; b=Oo2robeUgzv1pfu9YbPFd9YTcltKkJYf50wXWZeYzMDKdRUGWMcvxvo7Ho5LqyPvut/ri90JwVvu3m6lkxJe2YwfpCwTN9mF66qbWNY7Kkfm9SaNqVK3okhB+re1BQ3t61JuabPEVykN2Hez8Hm3nM5vjGiUMjeD626RkKdK438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181905; c=relaxed/simple;
	bh=/ppNeeFH3ToWFdjqK0Z7lUfEpmEMU5Eo/SBOmaOgyFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPpjLdyo0t5qaXdwRi69ZQkcZS+r1ZKtFLVBZsLbMdCaaz3sh3tp/JTHZJjNRyh/OJihdYbMo/o43O6JUw2mwJBaEzUPpCBkduLL+mymgvwT4SWc6iz441M644RZ3G+yo71XrFCYG/01k93QYQWuZfp48HFVl0qpdU+2Nltyfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyLUiinp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E48C4CEC3;
	Thu, 17 Oct 2024 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181905;
	bh=/ppNeeFH3ToWFdjqK0Z7lUfEpmEMU5Eo/SBOmaOgyFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyLUiinp/UgPO4lddkPqW7MvkHPLukAO5nEpTGqjTXVjMmYankRxIaecC00d8juzd
	 g8wwF5tDz9LUQL6xhfa55mp/7Jm7L5rGe1VCYoBr5AM76mwGxnh+nCKme2HikD9UQS
	 SZCmhPayRsn+KcTVc2Y+sy0iXXH8HRnzIWWw+JtJ+NjHgUc4GoNXKfiAi1IyiJ2KPi
	 OP8C+QYBsZXYolEJfpQ5UffK0dyxZ1ZWyFc9VjGQbAf6yqBHUDDR53kVvf5oYLN/AS
	 bUicUvZLQJnZgVph8saPMAXEeYPqHbG5oKuCvCBCtmDLTI1k5Iv+uIKPnRwyfKqmLF
	 /yMScNDeQ6IzA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t1TCq-000000006yy-3qyb;
	Thu, 17 Oct 2024 18:18:33 +0200
Date: Thu, 17 Oct 2024 18:18:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Mark the of_node of the aux bridge device as
 reused
Message-ID: <ZxE42DvdBwrOnaEa@hovoldconsulting.com>
References: <20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org>

On Thu, Oct 17, 2024 at 06:35:26PM +0300, Abel Vesa wrote:
> There are some cases where sharing the of_node renders different resources
> providers confused about the same resource being shared by two different
> devices.

Can you be more specific about what type of issue you are trying to
avoid here? Is it due to pinctrl for example?

> Avoid that by marking the of_node as reused since the aux bridge
> device is reusing the parent of_node.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/bridge/aux-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
> index b29980f95379ec7af873ed6e0fb79a9abb663c7b..ec3299ae49d6abdb75ee98acfe0682f1acc459f8 100644
> --- a/drivers/gpu/drm/bridge/aux-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-bridge.c
> @@ -60,6 +60,7 @@ int drm_aux_bridge_register(struct device *parent)
>  	adev->dev.parent = parent;
>  	adev->dev.of_node = of_node_get(parent->of_node);
>  	adev->dev.release = drm_aux_bridge_release;
> +	adev->dev.of_node_reused = true;

Please use the intended device_set_of_node_from_dev() helper for this.
  
>  	ret = auxiliary_device_init(adev);
>  	if (ret) {

Johan

