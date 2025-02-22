Return-Path: <linux-kernel+bounces-527015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401A4A40636
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1363A543D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660112063D0;
	Sat, 22 Feb 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmktNmA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0C1DE4E5;
	Sat, 22 Feb 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211735; cv=none; b=FS/aYB8s/HBEiueTqqRGoA9xHPfjGIkY5BUPomL4nUsg/9yFbNP5iQl9h6UCtz+vTVIgsaRNUjpwEfrHhGUM5IM/LE06L6/I7JSw9nHb+TiDld3ZK+UGBkGsWhUamcVxdHO//PkNgA2m6vYos/kiOgShmk6lKO0JnSeEZvzc/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211735; c=relaxed/simple;
	bh=mf/JTrPZ+rYMGB4XLBDIdkYNsIeKmoMH80r1sTWDbsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lte+9u+W5Lw6sEBPWeVZ++arFSqFBOfUT9Qphsh2f1W4cGMdumuJz/a250AxgyKSgO7qkaJcSer9DpOZDQjwhZX5POSrCSjuY3HnG/Px8OKYHFBnAIJtBrkNlaRs+sMhXTwI64RLlGrtLjLpislmAfROqtOl4wBl3PhLnwKHM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmktNmA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C633CC4CED1;
	Sat, 22 Feb 2025 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740211735;
	bh=mf/JTrPZ+rYMGB4XLBDIdkYNsIeKmoMH80r1sTWDbsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vmktNmA5Y8sq5TSOuSyFkq7ld17bFcARcbrU1mR1gI2HLUMj7+XxyI/XW8fpdcR+h
	 8v5lIuk510x5R7pjgifib798czYR9MB89Lw60prdhTl5nu+7oRJ0lvz22RzqfxxvpF
	 aUAWnNVdu5pzaxBtEyLl1GXaG9JbpMUerasxt4J8=
Date: Sat, 22 Feb 2025 09:07:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cleanup of most_video_dev structure
Message-ID: <2025022236-april-defensive-8855@gregkh>
References: <20250221163444.57492-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163444.57492-1-kumarkairiravi@gmail.com>

On Fri, Feb 21, 2025 at 10:04:24PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> This patch series removes unused synchronization primitives from
> struct most_video_dev.
> 
> Ravi Kumar Kairi (2):
>   staging: most: Remove unused mutex from most_video_dev
>   staging: most: Remove unused spinlock from most_video_dev
> 
>  drivers/staging/most/video/video.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> -- 
> 2.48.1
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

