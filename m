Return-Path: <linux-kernel+bounces-284509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B39501C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62151F21C45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D2187552;
	Tue, 13 Aug 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/hRVgWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2B17BB2F;
	Tue, 13 Aug 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542973; cv=none; b=Aux3ZoNWh9+0FYhzU92WimiEoOi+0UmNZJXQm78NJ4XquuB5uzgfm7ShRwWvy1mZS88b7dzffYhe/EyuGaQ9TGiA3MT7SFIxURGRF7BEx/lBdClwH0YaQg/vKEeCRrJPkqu+X1EItwaILdt9UHVVz2AYoKCzqBA+y0HK6BgT9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542973; c=relaxed/simple;
	bh=GZVVnh9fJ4ACP4uxEbbZ5XuxKuMTj9SuB195yWSIMvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F19MMBgNf5W+nih1MxrUz8/Ty92EsIG0Bot4T5dlB+DlHHvWJjIxxc78+kRv2m1JZ31c3hVPf0UsqM59u5RY2i9Rql1kx+bEG5A4DflwqQlPCZfzahNnSDIuXKBctiCq43rJeLzwSGFK+3vVMfnpFLGORvNzGYd0LG465c2nFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/hRVgWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16066C4AF0B;
	Tue, 13 Aug 2024 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723542972;
	bh=GZVVnh9fJ4ACP4uxEbbZ5XuxKuMTj9SuB195yWSIMvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/hRVgWXyd/EdEYanJ+7yWbPoBtWFSYZrFv1KdxZA3nPZ27if2ZLDOPoLN1vpEXjZ
	 Q1TlRH/jbxkEd4ZCK4bcjwhFCcas7WaMuokGCZAyZu5KbTBRYN0u87JLeS8U0wtrsU
	 9K+pwam2Tz89priMvIl9S3gUwjuHJQj6UlHDu9hg=
Date: Tue, 13 Aug 2024 11:56:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers
Message-ID: <2024081354-pep-dreadful-c242@gregkh>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>

On Tue, Aug 13, 2024 at 11:09:24AM +0200, Michael Grzeschik wrote:
> This patch series is improving the size calculation and allocation of
> the uvc requests. Using the selected frame duration of the stream it is
> possible to calculate the number of requests based on the interval
> length.
> 
> It also precalculates the request length based on the actual per frame
> size for compressed formats.
> 
> For this calculations to work it was needed to rework the request
> queueing by moving the encoding to one extra thread (in this case we
> chose the qbuf) context.
> 
> Next it was needed to move the actual request enqueueing to one extra
> thread which is kept busy to fill the isoc queue in the udc.
> 
> As a final step the series is increasing the minimum amount of
> v4l2 buffers to 4 and allocates at least the amount of usb_requests
> to store them in the usb gadgte isoc pipeline.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> Changes in v4:
> - fixed exit path in uvc_enqueue_buffer on loop break
> - Link to v3: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de

I just took v3 in my tree, should I drop them?

thanks,

greg k-h

