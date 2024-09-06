Return-Path: <linux-kernel+bounces-318849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B74596F419
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AC28250D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638771CBEAC;
	Fri,  6 Sep 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ou1G2edv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3076157476
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624956; cv=none; b=GTym8RNUtNifAR6+41g8bx23+AU/u0Z2QcA5jZFiAUaXPfQ11umyBiV+40+32Uht+eTJLAt97wLeSAVEGVTqcghf0EUXISzbrEETRrag5hi8eRiItB4GiMocsiDI+bbvseLsmq5uLA8M7lgv1rmxuBwnnSKD9Kwh7NuNazcQ63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624956; c=relaxed/simple;
	bh=8o6HrNJoy0Oj0DyfRcBQ/KQ1S3BHmQHVHs67iKCBZ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaqNiztzt/qrCq2K7VVCAzV0/GIjoQjfSn1hwf/ybbzmX1a4paH6cLMuAip9zXYlhM1RzypqPN5DuNOIedlr4stFeC6ay/lXQVF0B4TTFaMgt3bgf7gJaleZouXljr+d4AqHiVAxmW5SSsKX2bj5wKQCekdJNSyf6YCQ5irDCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ou1G2edv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A711EC4CEC4;
	Fri,  6 Sep 2024 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725624956;
	bh=8o6HrNJoy0Oj0DyfRcBQ/KQ1S3BHmQHVHs67iKCBZ7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ou1G2edv4N/LtjKHj5JYOwQt3mXdfCli+USWQFTBNEktE3/POT2QsHTnoMz/6hpYQ
	 Ps5sV5uTuPgtYKgJqFM7PKHI8q75fNSX2vRNz3RjdELnohwXltZi8niqDk/MwwyVoU
	 N7U5SpeHIghXEwiFMJQcA6yMHbJKdIgamOnNQnJw=
Date: Fri, 6 Sep 2024 14:15:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ni_routing: Check when the file could not be opened
Message-ID: <2024090631-boogeyman-freefall-fab8@gregkh>
References: <20240906121009.73799-1-RuffaloLavoisier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906121009.73799-1-RuffaloLavoisier@gmail.com>

On Fri, Sep 06, 2024 at 09:10:08PM +0900, Ruffalo Lavoisier wrote:
> Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
> ---
>  drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> index d55521b5bdcb..892a66b2cea6 100644
> --- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> +++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> @@ -140,6 +140,11 @@ int main(void)
>  {
>  	FILE *fp = fopen("ni_values.py", "w");
>  
> +	if (fp == NULL) {
> +		fprintf(stderr, "Could not open file!");
> +		return -1;
> +	}
> +
>  	/* write route register values */
>  	fprintf(fp, "ni_route_values = {\n");
>  	for (int i = 0; ni_all_route_values[i]; ++i)
> -- 
> 2.43.0
> 

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

