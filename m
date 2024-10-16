Return-Path: <linux-kernel+bounces-367623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A479A0495
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8001F264A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B358204F77;
	Wed, 16 Oct 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qeF+fzjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90698204956;
	Wed, 16 Oct 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068424; cv=none; b=j+Dj8AwdoBgUKCockP62/keKh+p08Uqcgb9OoS1yzoLUTsL63fE34lwoDK/HCzchmjzj7pi+q6eKqt5KEALzIdMUyHdI1xEiO7kvEF42rLbKl+ogxgC3XLPiJOPJcYPgQZcAvoidvrB9dQ7ClYv4IWLzqtGhFTMjkxlPHAAPqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068424; c=relaxed/simple;
	bh=wWtowav7TJAkiJ8EeqkOQSPalsHYuxiQpdSu485gz6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk9nGlE/wolot/WHIUhCs8HQYKq+Hdea+TfTEf0qYzxpGML10h1yWEfb7PA4GJYwx1PkIT5hoEROSQ4eV9O612iAOhQKrAgJxqMJiuvppmEEwRKOe16nPvOBVfX59bI8kHRg74iUCBHkRaaqHyTju3W+tjBcoBtONR9br68qo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qeF+fzjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251DC4CEC5;
	Wed, 16 Oct 2024 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729068424;
	bh=wWtowav7TJAkiJ8EeqkOQSPalsHYuxiQpdSu485gz6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeF+fzjXRN0JEWmn2yrQmDSjc79FOmXOReTtT9ZRF+U03/KfaThTn1bJeEZuS/5w3
	 6tfLPOhqFThgjgM1TnBPh4gAJ9idGcEXqaKWLLHHlh7VTSa+UynYqzrXxOBNOadSa6
	 964qbYfaFbcG/S1s2M+9KUxSKAZbY5k5pUPNAo04=
Date: Wed, 16 Oct 2024 10:47:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Avichal Rakesh <arakesh@google.com>,
	Jayant Chowdhary <jchowdhary@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 0/9] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers and fixes
Message-ID: <2024101636-studied-job-41b2@gregkh>
References: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>

On Sun, Sep 29, 2024 at 08:59:20PM +0200, Michael Grzeschik wrote:
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
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> Changes in v6:
> - fixes in: ("usb: gadget: uvc: add trace of enqueued and completed requests")
> - Link to v5: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de

Breaks the build for me:

In file included from drivers/usb/gadget/function/uvc_trace.h:60,
                 from drivers/usb/gadget/function/uvc_trace.c:11:
./include/trace/define_trace.h:95:42: fatal error: ./uvc_trace.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^

what did you build this against?

thanks,

greg k-h

