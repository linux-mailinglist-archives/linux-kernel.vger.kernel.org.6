Return-Path: <linux-kernel+bounces-186632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CB8CC6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5A51C21A42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631314659B;
	Wed, 22 May 2024 18:58:26 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A694B1BF2A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404305; cv=none; b=GAlJWmY8mSFZSSC+IV0xfk86loHwHWyj8+neSdhtgxPQuMY4JHZjUKgiACaJV77d4KZMOSWJuLJlJFHNAQvpGHXSmFomUV15YaXVf4rpI4F7cEmYQmXKRkP0Xur8mpwj75uJekirsEgtTaFRzC+PZUWvV2ldShRVUGK8z8+OQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404305; c=relaxed/simple;
	bh=Tqi1FXFAW4fmx/FjDROKrxdWvdWa0RciI+q8Yszu5Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE1nkbb/S9pfGrB5O3xMquNhHT8aPgs13VabVieL2uJWXTHzEvyb+uUAGwGdJ63TX4GkpEsbQ09fLIN5iw5jwr9W82+czz7xk4yj1pEXLat31lw7rytuKlZhXugAtNRfiPCw3FXWtaQddw9y+8466HafD/SIF02glUpF5Uje4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 509435 invoked by uid 1000); 22 May 2024 14:58:22 -0400
Date: Wed, 22 May 2024 14:58:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
  Avichal Rakesh <arakesh@google.com>,
  Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Daniel Scally <dan.scally@ideasonboard.com>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jayant Chowdhary <jchowdhary@google.com>,
  "etalvala@google.com" <etalvala@google.com>,
  Michael Riesch <michael.riesch@wolfvision.net>,
  "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Message-ID: <e39e8340-0c99-4fc4-8e40-fcf052614020@rowland.harvard.edu>
References: <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
 <20240522014132.xlf7azgq2urfff2d@synopsys.com>
 <3f404a27-50e8-42c5-a497-b46751154613@rowland.harvard.edu>
 <20240522171640.iuol4672rnklc35g@synopsys.com>
 <Zk4td_0RR0cMJKro@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4td_0RR0cMJKro@pengutronix.de>

On Wed, May 22, 2024 at 07:37:59PM +0200, Michael Grzeschik wrote:
> On Wed, May 22, 2024 at 05:17:02PM +0000, Thinh Nguyen wrote:
> > I agree. The dwc3 driver has this workaround to somewhat work with the
> > UVC. This behavior is not something the controller expected, and this
> > workaround should not be a common behavior for different function
> > driver/protocol. Since this behavior was added a long time ago, it will
> > remain the default behavior in dwc3 to avoid regression with UVC (at
> > least until the UVC is changed). However, it would be nice for UVC to
> > not rely on this.
> 
> With "this" you mean exactly the following commit, right?
> 
> (f5e46aa4 usb: dwc3: gadget: when the started list is empty stop the active xfer)
> 
> When we start questioning this, then lets dig deeper here.
> 
> With the fast datarate of at least usb superspeed shouldn't they not all
> completely work asynchronous with their in flight trbs?
> 
> In my understanding this validates that, with at least superspeed we are
> unlikely to react fast enough to maintain a steady isoc dataflow, since
> the driver above has to react to errors in the processing context.
> 
> This runs the above patch (f5e46aa4) a gadget independent solution
> which has nothing to do with uvc in particular IMHO.
> 
> How do other controllers and their drivers work?

You should think of isochronous transfer requests as a pipeline flowing 
from the function driver to the UDC driver.  As long as the pipeline 
never becomes empty, transfers will occur with the desired timing: one 
packet (ignoring high-bandwidth issues) per isochronous interval.

But if the pipeline does become empty, because the function driver 
doesn't submit requests to the UDC driver quickly enough, the behavior 
is undetermined.  Obviously no data can be sent before the next request 
is submitted.  And even if the next request is submitted before the next 
time interval expires, the UDC driver might delay transferring the 
request's data until a later time interval.  Or it might not.  In short, 
when the function driver does submit its next request, there's no way to 
know in which interval its data will get sent to the host.  Furthermore, 
there's no way in the gadget framework for the function driver to ask 
that the request be sent in a particular transfer window.

This means that function drivers should do their best to make sure the 
pipeline never becomes empty, that there always is at least one request 
in progress at all times.  Even if this requires submitting zero-length 
requests because the necessary data isn't available yet.

Remember, isochronous transfers are meant only to be a best-effort 
attempt at low-latency data delivery, without guarantees (other than a 
reserved amount of bandwidth).  If a packet gets lost or dropped from 
time to time, whether because of transmission errors or because the data 
source was unable to keep up, it shouldn't matter very much in the end.
The receiver (i.e., the host) should be able to recover, resynchronize, 
and move on.

Alan Stern

