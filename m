Return-Path: <linux-kernel+bounces-365652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835AB99E583
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E291E28506D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C21D90DB;
	Tue, 15 Oct 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJtLHcQE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816B1D89F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991460; cv=none; b=I0w2UlQC7ZzwqiRoRzrMu2J6TJdQvEe6jEX9KAOS0M/oDMqMm4PgyIOYw2GT3cydDa+26dRFDD7O0CX42uBZoMKamWW/b6rfrqRST74MkNQo/8l3m9BC1jOaNtpgR6RjRN4D6v95Atjxs/WxkesInAxMaEpRSZUr0bhTKJ6UmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991460; c=relaxed/simple;
	bh=4wqZkJZ1fdwSSObWrBR7WukH28FMVtj64OyDp4Jojvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOhOuDC2ZYUoNZaX0Ay9sI5wWrdwUSW9jNzNbRA5RgTA+d8CcbAuzLCQ4qMOvaBPrON5pndJjvqy6ESUeHyblEGgS8MGQiuesd9yvboSuUXZ1u0W5x+/ws8W3ia6a+e0880sooU4nzZms28s1FUh9FWv4WjMP9sWB0WbmdMIXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJtLHcQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA49C4CEC6;
	Tue, 15 Oct 2024 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728991459;
	bh=4wqZkJZ1fdwSSObWrBR7WukH28FMVtj64OyDp4Jojvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJtLHcQEUDPaIKzMkmNenUsdUvFy7cB0zNEUEV0TlaVM+IIIqotcFXmG/b5GStTKY
	 G828barPI2yvnDpmPRdcVakL6ebYQtyqYvznvaEt3Hby2MAFFpS+vTmYlDXWdU0sWB
	 6o3SZz8/8jQ4RkMhn2cgsQ9gi74+Q+RA3XcKYIhc=
Date: Tue, 15 Oct 2024 13:24:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Oren Weil <oren.jer.weil@intel.com>, Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org, Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>
Subject: Re: [char-misc-next v2] mei: use kvmalloc for read buffer
Message-ID: <2024101555-favorable-pastel-9d78@gregkh>
References: <20241015104745.2242190-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015104745.2242190-1-alexander.usyskin@intel.com>

On Tue, Oct 15, 2024 at 01:47:45PM +0300, Alexander Usyskin wrote:
> Read buffer is allocated according to max message size, reported by
> the firmware and may reach 64K in systems with pxp client.
> Contiguous 64k allocation may fail under memory pressure.
> Read buffer is used as in-driver message storage and not required
> to be contiguous.
> Use kvmalloc to allow kernel to allocate non-contiguous memory.
> 
> Reported-by: Rohit Agarwal <rohiagar@chromium.org>
> Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
> Tested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 9d090fa07516..be011cef12e5 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -321,7 +321,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
>  		return;
>  
>  	list_del(&cb->list);
> -	kfree(cb->buf.data);
> +	kvfree(cb->buf.data);
>  	kfree(cb->ext_hdr);
>  	kfree(cb);
>  }
> @@ -497,7 +497,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
>  	if (length == 0)
>  		return cb;
>  
> -	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
> +	cb->buf.data = kvmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
>  	if (!cb->buf.data) {
>  		mei_io_cb_free(cb);
>  		return NULL;
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

