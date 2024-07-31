Return-Path: <linux-kernel+bounces-268780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A6942930
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C741F219CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B21A8BEB;
	Wed, 31 Jul 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Va2XUVvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3641A7F68;
	Wed, 31 Jul 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414635; cv=none; b=o79evoT1/miQT4QMSFVmC5mZmwP/WDorVU51ibLx7lR7yPckw2BvMA9VFFiq0i951jxvxJZAD1C6JoVW8lQ2w9m+P8iFTJrfLUPoc0MRa7znrWM+MRgjMQK/7DdXi4ZcYusjzWG1Uhjh8cI7ahlubhiLkW6axeeeA+Pa3+TyssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414635; c=relaxed/simple;
	bh=83tdkFTvpxeNWsYDJk5FXBclyqEpGP5v1+TSNN8ARpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQhGEwxulRX7r+0QsFeRtImDtiIh4/Xf0oT7pqye8CuBhMNkRBtEcr77gPEDOUJVJlzGnup8J2tZfh+Jp4e6ZGwwu0wCncq3FNcqMYez7NaLkDGA1Rdx+Nb/EPQ5Z57yeVuChHVXWlMI9UW9+uaow7wz+WGScMyAZDHozE99LYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Va2XUVvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDDBC116B1;
	Wed, 31 Jul 2024 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722414635;
	bh=83tdkFTvpxeNWsYDJk5FXBclyqEpGP5v1+TSNN8ARpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Va2XUVvSfqlIJj6AwPaTzk2hTukSHAjkHmMVg/0NI559w1qKvqq1RB+L3pW3LjmBp
	 VlzI3ic4Yr/2EQsKa8RRWAqE4Ssz+Q1qgd5Ns2Yc0G5MjT2v8Jr2oOU/B5DlaKtAEn
	 Al8dUsjVjhmyRMczbIAVlHbJM3f4uBLXW/ffg4+c=
Date: Wed, 31 Jul 2024 10:30:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Improve error checking and tagging
Message-ID: <2024073119-turbine-subscript-e19a@gregkh>
References: <20240324-uvc-gadget-errorcheck-v2-1-f141b13ade0e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-uvc-gadget-errorcheck-v2-1-f141b13ade0e@pengutronix.de>

On Fri, Apr 05, 2024 at 09:44:56AM +0200, Michael Grzeschik wrote:
> Right now after one transfer was completed with EXDEV the currently
> encoded frame will get the UVC_STREAM_ERR tag attached. Since the
> complete and encode path are handling separate requests from different
> threads, there is no direct correspondence between the missed transfer
> of one request and the currently encoded request which might already
> belong to an completely different frame.
> 
> When queueing requests into the hardware by calling ep_queue the
> underlying ringbuffer of the usb driver will be filled. However when
> one of these requests will have some issue while transfer the hardware
> will trigger an interrupt but will continue transferring the pending
> requests in the ringbuffer. This interrupt-latency will make it
> impossible to react in time to tag the fully enqueued frame with the
> UVC_STREAM_ERR in the header.
> 
> This patch is also addressing this particular issue by delaying the
> transmit of the EOF/ERR tagged header by waiting for the last enqueued
> buffer of the frame to be completed. This way it is possible to react to
> send the EOF/ERR tag depending on the whole frame transfer status.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> Changes in v2:
> - removed unnecessary uvc_gadget_errorcheck_param module parameter
> - Link to v1: https://lore.kernel.org/r/20240324-uvc-gadget-errorcheck-v1-1-5538c57bbeba@pengutronix.de
> ---
>  drivers/usb/gadget/function/uvc.h       |  2 +
>  drivers/usb/gadget/function/uvc_video.c | 69 ++++++++++++++++++++++++++++-----
>  2 files changed, 61 insertions(+), 10 deletions(-)

Same here, can you rebase and resubmit if still needed?

thanks,

greg k-h

