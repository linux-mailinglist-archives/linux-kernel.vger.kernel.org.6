Return-Path: <linux-kernel+bounces-284520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66529501DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6761F223C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E1E18B499;
	Tue, 13 Aug 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xGt0ZDp6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F4189F2C;
	Tue, 13 Aug 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543322; cv=none; b=BTY+OPhOfyZwnK0oDyIXVvbPfv56RXkpCXgLI4cLUFMg/cnRoOJQfCVFUkqVq+JGnO9YavqROU5/7b17Qkw7pac0Ic8jlLdbhJS+ECltez5ZnBoRtrygcmE+ia/HeJ/dkkf0WDCio5iR4P/2Dvf/Zaa6/cjRNJD0+bf4kwDtzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543322; c=relaxed/simple;
	bh=A9hwt8MjllL5mH1wSPrDTFfB++aOsKoZu1M9X/L7CuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JovNybqFDaCF8e44LzRzRKeJIk/0srdG0iU9cY1SGrS5qNThr12AJUXc8o5CnZPiYYQ2YZIdeY/oTp/wpbPFjDDCz0T9X88Vm6vDVihlnRI5X1Mxrn3r3BGE0aNQA7zfjOKCPcGePYorQhXKvtjguf3Pv9lRdJ2oLKJE/HSsdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xGt0ZDp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A587C4AF13;
	Tue, 13 Aug 2024 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723543321;
	bh=A9hwt8MjllL5mH1wSPrDTFfB++aOsKoZu1M9X/L7CuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xGt0ZDp6wOQYV+70yCZsmPVzKTcgQ7AcTV/vEcltAH4SYfRPYOuG96e4GUuY7b/5Q
	 xkH+hqzEASoL4w0ILABvAN93cFvAR66uXkdlF+t3D9bQhdAgZMwjjGpXdfY90eGsuE
	 wgQ/s8ETxVbxrY4EBQQrZTFH0gaYrbVN6SulGas4=
Date: Tue, 13 Aug 2024 12:01:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers
Message-ID: <2024081345-radio-automatic-be9f@gregkh>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
 <2024081354-pep-dreadful-c242@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081354-pep-dreadful-c242@gregkh>

On Tue, Aug 13, 2024 at 11:56:09AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 11:09:24AM +0200, Michael Grzeschik wrote:
> > This patch series is improving the size calculation and allocation of
> > the uvc requests. Using the selected frame duration of the stream it is
> > possible to calculate the number of requests based on the interval
> > length.
> > 
> > It also precalculates the request length based on the actual per frame
> > size for compressed formats.
> > 
> > For this calculations to work it was needed to rework the request
> > queueing by moving the encoding to one extra thread (in this case we
> > chose the qbuf) context.
> > 
> > Next it was needed to move the actual request enqueueing to one extra
> > thread which is kept busy to fill the isoc queue in the udc.
> > 
> > As a final step the series is increasing the minimum amount of
> > v4l2 buffers to 4 and allocates at least the amount of usb_requests
> > to store them in the usb gadgte isoc pipeline.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > Changes in v4:
> > - fixed exit path in uvc_enqueue_buffer on loop break
> > - Link to v3: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de
> 
> I just took v3 in my tree, should I drop them?

Oops, emails crossed.  I'll go drop these now...

greg k-h

