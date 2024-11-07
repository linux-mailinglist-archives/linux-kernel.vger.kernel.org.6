Return-Path: <linux-kernel+bounces-400161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4C9C09B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08601C23A95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523A2139C1;
	Thu,  7 Nov 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mqImWRHc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5721314D;
	Thu,  7 Nov 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992280; cv=none; b=eHQqiLiBHhhNVwO5qbFb8Q4sScY3Wxbpww9piSdzHyN3QrRXBNfYZU3+s37SXnsd61VonoBNlSoxmBvDCtOg727nkLVx1JMjdqdR8JJ0Gth3GRb8RhnZS5R89Cpg1z0s2vBIl3kFYXDzl9EngN1ckb7psgAaj890OUDa+E6giLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992280; c=relaxed/simple;
	bh=mZg+SOL9g6iEESGqX8/isVXCxGzii21KxiARHkH42Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxzGpytQ1TPXVKBQeQ0wUUMpNhfJHsvtNNWDYmorQZ13Iq6JheIk4rhe9cWwtlleZ5OB0U8yfPjS4aO89Kvj9QWugMR2g5qGyrSHnY8lhHoa00+EQj2XqErPAXZPeSAuALUuIpiVUt3rpVbr9/QO1dv6nSvGQQO1mCl7Oj/sh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mqImWRHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E67C4CECD;
	Thu,  7 Nov 2024 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730992280;
	bh=mZg+SOL9g6iEESGqX8/isVXCxGzii21KxiARHkH42Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqImWRHcBrHyKnRZx89hEyYxP7HjmS9Gm5k6bQ70A66vDdbgXs1KyqpAje9KQrghu
	 3RIEPpQ2UEKDMMSy1irbTSuct+HkjJA0U7B9cLmsJtfU7OV7i7yVqN05iqAJtUAjZ4
	 iL/Zv/+KdPLD0I5M5j9xpPxUa/GyRFPrPlEC50x0=
Date: Thu, 7 Nov 2024 16:11:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v3] staging: greybus: uart: Fix atomicity violation in
 get_serial_info()
Message-ID: <2024110724-overbuilt-liquid-3734@gregkh>
References: <20241107113337.402042-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107113337.402042-1-chenqiuji666@gmail.com>

On Thu, Nov 07, 2024 at 07:33:37PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but 
> get_serial_info() does not. Fortunately, the impact of this is relatively 
> minor. It doesn't cause a crash or any other serious issues. However, if a 
> race condition occurs between set_serial_info() and get_serial_info(), 
> there is a chance that the data returned by get_serial_info() will be 
> meaningless.

Trailing whitespace :(

You should fix your editor to highlight this so it doesn't keep showing
up.

> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")

My bot says:

----------

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:


- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

