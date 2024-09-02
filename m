Return-Path: <linux-kernel+bounces-310644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A815D967F90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92DE1C21A43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70233152E12;
	Mon,  2 Sep 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZGiy2Xv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E47136982;
	Mon,  2 Sep 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259059; cv=none; b=VESVi7xb5yHNcNDnB1zDUrUO4xc81k95fdTeEcph39ROUdM6lZklz4Bo7ntEh03Sa80HrPy0rvdZROcz2ldO8+hqhUSicivV1uTidtSq1XgFs+1DD9C5eb/dXQnuFT4ye0MMI6PEFog8/KjqGq1g1k3/uuiPDtfKEVB2U+Lz8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259059; c=relaxed/simple;
	bh=xSb4BNooMB4KLTCFcdB3Tq4qzP8BjQcXgqaW5oG/Gy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkPduLArcyvh4Lj0aQtV3nB/3moXuge+3+eaHslRnEgOMg3WMKBIudUy5sCEaYjAJ4LixBdwajZibs4mkGQrQdRkpFzwAf88QopBTKwxKqFSnSJfB3uwWRRobvBUq/YMuD0QM8+LN+023oCM5mo/58y6RWbghrohWg2HRn/opBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uZGiy2Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14E8C4CEC2;
	Mon,  2 Sep 2024 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725259059;
	bh=xSb4BNooMB4KLTCFcdB3Tq4qzP8BjQcXgqaW5oG/Gy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZGiy2Xvcxguyw0dLUh8J/5AyJxpW3WB782bpVPNH7RlkUzo8Ta1f289/rChdULTB
	 OC2jHDiGCg7ktbyoj+7BxXTcuQKP6ydJOJAhzuWF4uCfGz5nswbqzptx/BgEjulB7z
	 MdIurnCFpQwWbrp3aXBRtkaFakKL7/QPWK4pRG5Q=
Date: Mon, 2 Sep 2024 08:37:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
Message-ID: <2024090225-monthly-denatured-e0be@gregkh>
References: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
 <2024090203-challenge-paper-e1fe@gregkh>
 <4ccbc9ad-7d19-430c-95aa-d726b6b83412@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ccbc9ad-7d19-430c-95aa-d726b6b83412@siemens.com>

On Mon, Sep 02, 2024 at 08:28:42AM +0200, Jan Kiszka wrote:
> On 02.09.24 08:06, Greg Kroah-Hartman wrote:
> > On Sun, Sep 01, 2024 at 11:11:29PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> There are apparently incomplete clones of the HXD type chip in use.
> >> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
> >> flooding the kernel log with those errors. Rather use the
> >> line_settings cache for GET_LINE_REQUEST and signal missing support by
> >> returning -ENOTTY from pl2303_set_break.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  drivers/usb/serial/pl2303.c | 13 +++++++------
> >>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> >> index d93f5d584557..04cafa819390 100644
> >> --- a/drivers/usb/serial/pl2303.c
> >> +++ b/drivers/usb/serial/pl2303.c
> >> @@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
> >>  				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
> >>  				0, 0, buf, 7, 100);
> >>  	if (ret != 7) {
> >> -		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
> >> +		struct pl2303_private *priv = usb_get_serial_port_data(port);
> >>  
> >> -		if (ret >= 0)
> >> -			ret = -EIO;
> >> +		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
> >> +			__func__, ret);
> >> +		memcpy(buf, priv->line_settings, 7);
> > 
> > Ugh, how is this device working in other operating systems?
> > 
> 
> I don't know. Also, the last downstream driver Prolific posted [1]
> didn't point to this specialty.

Given that prolific's windows driver is known to explicitly attempt to
disable clone devices, I would be amazed if it supported it at all :)

> I opened a few of those adapter cables (some received from [2], others
> from a different source), and the chips were not labeled (in contrast to
> the picture from [2]). So I'm suspecting clones to be in play. Reminds
> me of the quest for sane WIFI USB adapters.

This chip has had lots of different cloned devices over the years, which
is pretty odd given that the thing is so cheap to start with.  Anyway,
we live with it and move on...

> >>  
> >> -		return ret;
> >> +		return 0;
> >>  	}
> >>  
> >>  	dev_dbg(&port->dev, "%s - %7ph\n", __func__, buf);
> >> @@ -1078,8 +1079,8 @@ static int pl2303_set_break(struct usb_serial_port *port, bool enable)
> >>  				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
> >>  				 0, NULL, 0, 100);
> >>  	if (result) {
> >> -		dev_err(&port->dev, "error sending break = %d\n", result);
> >> -		return result;
> >> +		dev_dbg(&port->dev, "error sending break = %d\n", result);
> >> +		return -ENOTTY;
> > 
> > Are you sure that ENOTTY is correct here?  Why not just send back
> > -EINVAL or something like that telling userspace that this is not
> > allowed for this device?
> 
> I was copying from serial_break() which now returns -ENOTTY if the
> handler is NULL. If you prefer -EINVAL, I can change. Just looking for a
> consistent code.

Ah, yeah, that's tricky.  I'll let Johan pick one :)

thanks,

greg k-h

