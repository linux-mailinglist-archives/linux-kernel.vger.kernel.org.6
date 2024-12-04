Return-Path: <linux-kernel+bounces-431508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E499E3FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFCEB34D06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821A20C021;
	Wed,  4 Dec 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q7qDlfa5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62401B87C4;
	Wed,  4 Dec 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326186; cv=none; b=rspCnSHhOpx2nrCp3Gbk74GBdT+3ouhLZCNGx/LEb2KwM4bVrwpICJbFSXvH6zB1c7StOb1hQFpOXfL+Tl2eIkC3KETAVzlzUcQxnvo5SRuRl0ggsiWOLnUFypK/z8bli+CIvXSnEbTx5lsNGySCG6Rr/BDh2zvtHkvUZbXX7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326186; c=relaxed/simple;
	bh=gmeyHM3rFa40rGaAo7RcPt8M8Fl4fxTu+eHHTveRXN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d96iu1oErNlhSx7Z86gBxxv0H150BJFRlvAsO+VmNtuY56dTsSJyFQpv5p5GvoVOPwWgeRGCiSkDL0vEu8S16Q5smX4ASV/NAERHsNkOXpovW0YsJ5e2kiUYWWVp804gUGHWySsjzrU2IsGef3Pyq9qY6e1jmY69pbDcHFOtsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q7qDlfa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA196C4CECD;
	Wed,  4 Dec 2024 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733326186;
	bh=gmeyHM3rFa40rGaAo7RcPt8M8Fl4fxTu+eHHTveRXN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7qDlfa5Ju6Bjfo3AcqcWR5sSos9oRx/51ImA6h4pGihDsCVttX4W+EprwuYXmI5B
	 pbGsA3BXcQ59anEOaNzJawa0HyBG0Yg/OkhDT605czpIlumXf/fZnUGfLbaX0KRtyV
	 QT6LyDFZ4cpmrgSZkkNjAM3xqGQfIFAdTYy7w/rk=
Date: Wed, 4 Dec 2024 16:29:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: Re: [PATCH 3/4] staging: gpib: Fix erroneous removal of blank before
 newline
Message-ID: <2024120410-claim-precut-61e3@gregkh>
References: <20241204145713.11889-1-dpenkler@gmail.com>
 <20241204145713.11889-4-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204145713.11889-4-dpenkler@gmail.com>

On Wed, Dec 04, 2024 at 03:57:12PM +0100, Dave Penkler wrote:
> Replace original blanks with "."
> 
> Reported-by: Marcello Carla' <marcello.carla@gmx.com>
> Co-developed-by: Marcello Carla' <marcello.carla@gmx.com>
> Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> index 47db17418a74..c30db3615f49 100644
> --- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> +++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> @@ -97,8 +97,8 @@ module_param(debug, int, 0644);
>  #define USB_GPIB_DEBUG_ON    "\nIBDE\xAA\n"
>  #define USB_GPIB_SET_LISTEN  "\nIBDT0\n"
>  #define USB_GPIB_SET_TALK    "\nIBDT1\n"
> -#define USB_GPIB_SET_LINES   "\nIBDC\n"
> -#define USB_GPIB_SET_DATA    "\nIBDM\n"
> +#define USB_GPIB_SET_LINES   "\nIBDC.\n"
> +#define USB_GPIB_SET_DATA    "\nIBDM.\n"
>  #define USB_GPIB_READ_LINES  "\nIBD?C\n"
>  #define USB_GPIB_READ_DATA   "\nIBD?M\n"
>  #define USB_GPIB_READ_BUS    "\nIBD??\n"
> @@ -587,7 +587,7 @@ static int usb_gpib_command(gpib_board_t *board,
>  			    size_t *bytes_written)
>  {
>  	int i, retval;
> -	char command[6] = "IBc\n";
> +        char command[6]="IBc.\n";

Did you run this through scripts/checkpatch.pl before sending it out?
Please always do so.

And what is the "." for?  Why is this needed?  Please explain that in
the changelog text.

thanks,

greg k-h

