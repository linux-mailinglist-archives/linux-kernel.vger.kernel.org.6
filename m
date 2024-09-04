Return-Path: <linux-kernel+bounces-314642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119096B63E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17C41F26015
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF219AD89;
	Wed,  4 Sep 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vkz5c7K+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693B17CA1D;
	Wed,  4 Sep 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441227; cv=none; b=Fc7ahzhL8Qx1ItML8SMLm3ERjxjzWCVmlg7D3ZJSXvi3I/8cuEhdU76Zh/SGyFaJGBE83vr5wErIa5Y93bclnWNTYGUhWPdCwB9OubALwKC8e5FCadFPkWScn2DvZltx1jCoHIWAWdooGAC7KNKpc8osLYkNykmaKpSHtnFDrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441227; c=relaxed/simple;
	bh=MYuWrpI57eWvfXTVBG8wRa47ghh9A7+OUqw8WpXjn6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YctHRh+Z6INha66g4nzWYkvFhYVFcqsutAVh8HqeShzYiy6FXquNDdLm8FbvZ4scp5I6EWVPlgHuRTZw3n08raHsrAzbE8cTarljnAvUW52XiGYzXNXzOYy6Bo8h48s9p65PlAN4S7bfFNxhz+2R7nD2Scf/2PHOB6B+OROR/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vkz5c7K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96995C4CEC2;
	Wed,  4 Sep 2024 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725441226;
	bh=MYuWrpI57eWvfXTVBG8wRa47ghh9A7+OUqw8WpXjn6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vkz5c7K+nsAveINoqWfTiRoZyWlaiQyw8mqLVTLmxHeNyFQDjUCkPTLJQMPfgpNQS
	 UVTVXVcogfE0b6d/0WW2hHw9P5WYjXq9gu9zL7t5INH0FNKivXfXljctqXG8FA1gRv
	 HnwpwcqmqNNA8DF6AULzvEH9dBkmdgIIUaLjQ6Kc=
Date: Wed, 4 Sep 2024 11:13:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Paul Pu <hui.pu@gehealthcare.com>, p.zabel@pengutronix.de,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, HuanWang@gehealthcare.com,
	taowang@gehealthcare.com, sebastian.reichel@collabora.com,
	ian.ray@gehealthcare.com, stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/imx/ipuv3: ipuv3-plane: Round up plane width for
 IPUV3_CHANNEL_MEM_DC_SYNC
Message-ID: <2024090442-handrail-backwash-1493@gregkh>
References: <20240904024315.120-1-hui.pu@gehealthcare.com>
 <20240904075417.53-1-hui.pu@gehealthcare.com>
 <918336db-3c3e-4b5e-a9c8-096c9290f9d1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918336db-3c3e-4b5e-a9c8-096c9290f9d1@nxp.com>

On Wed, Sep 04, 2024 at 04:48:51PM +0800, Liu Ying wrote:
> On 09/04/2024, Paul Pu wrote:
> > Cc: stable@vger.kernel.org # 5.15+
> 
> Why 5.15+ ?

Because the commit referenced in Fixes: was backported there.

If you want to be picky, just drop the "# 5.15+" and our tools will rely
on the Fixes: tag and everyone will be happy.

thanks,

greg k-h

