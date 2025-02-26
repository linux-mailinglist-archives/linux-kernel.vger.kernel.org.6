Return-Path: <linux-kernel+bounces-534754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC9A46ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F74E7A80A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97C22B595;
	Wed, 26 Feb 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAsuzmRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507F41C71
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597451; cv=none; b=TAXTMzJk2vz0RDMll+vUzNOmTli/h1qTZ8BUrMVEkYNidBm65s7Kkz17HkKSoOsErHffS6RKWQtYnEBNfN3eJm/VS6Ux0sSyt0OpNxXPBmcTUog48djX5bhfv6Am/u4RjiOgrw3Rru2PbtfMmHBrkRk/r7tPwf7PTV+XVs6ifmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597451; c=relaxed/simple;
	bh=uQy4KC889WlaUzReANLdzCpYD3AheMpItgiF6cac52U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLrxhTrjOXdyH6398vxvqzQjWAa4At12lmtxdzH1uIFg1N5DFkh9UCgdDcuJEvaCfo6YpbmyMawikTEX6vzdPLXHsfKyyz3UdUYxj5XWhADEgVgksuXs8DzWG/D8/J0oIbqBlBoJRh5f0yZdeaOYHfe0dIZQqrSroScyn/pmy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fAsuzmRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85198C4CED6;
	Wed, 26 Feb 2025 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740597450;
	bh=uQy4KC889WlaUzReANLdzCpYD3AheMpItgiF6cac52U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAsuzmRh0W9PRD1oYsawXjnAKFPEZ6qoggle8LqgYLFOl1GRCHCkJ0bMkC22+9BDB
	 1L0G2gEzul/ItGgBzHcEQiN3DOrAXeOXbP3MluvLS1umnm+CB6ViKUpNPX/yT9sw+o
	 c8x5T2+mi+KLjLmiPd7B/6pIanFPknapa9vS+Vts=
Date: Wed, 26 Feb 2025 11:16:21 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base: fix iterator cleanup in attribute_container
Message-ID: <2025022606-carrousel-unstable-f2f3@gregkh>
References: <20250226182753.257559-1-ayaanmirzabaig85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226182753.257559-1-ayaanmirzabaig85@gmail.com>

On Wed, Feb 26, 2025 at 11:57:52PM +0530, Ayaan Mirza Baig wrote:
> This patch addresses a long-standing FIXME in
> dirvers/base/attribute_container.c, where the function
> failed to call klist_iter_exit() before breaking
> out of the loop when a matching class device was found.
> 
> The code is now refactored to use a goto-based cleanup approach
> that ensure klist_iter_exit() is invoked exactly once regardless
> of the exit path.
> 
> In addition, checkpatch.pl warnings were fixed along with this change.
> 
> Tested on a minimal Debian System in QEMU with GDB attached.
> No regressions or errors were observed.
> 
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> ---
>  drivers/base/attribute_container.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
> index b6f941a6ab69..1e7af328dd49 100644
> --- a/drivers/base/attribute_container.c
> +++ b/drivers/base/attribute_container.c
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
>   *
>   * The basic idea here is to enable a device to be attached to an
> - * aritrary numer of classes without having to allocate storage for them.
> + * aritrary number of classes without having to allocate storage for them.

Nit, why change this in this commit?

>   * Instead, the contained classes select the devices they need to attach
>   * to via a matching function.
>   */
> @@ -21,7 +21,8 @@
>  #include "base.h"
>  
>  /* This is a private structure used to tie the classdev and the
> - * container .. it should never be visible outside this file */
> + * container .. it should never be visible outside this file
> + */

Same for this one?
>  struct internal_container {
>  	struct klist_node node;
>  	struct attribute_container *cont;
> @@ -42,7 +43,6 @@ static void internal_container_klist_put(struct klist_node *n)
>  	put_device(&ic->classdev);
>  }
>  
> -
>  /**

And this?

I stopped reading here, please, if you are going to make logic changes,
just do that, don't mix things up in one larger commit, that's not how
we handle kernel patches at all.

Also, did you test a system that uses container devices?

thanks,

greg k-h

