Return-Path: <linux-kernel+bounces-303409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5097960BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3292AB26567
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1F1BD502;
	Tue, 27 Aug 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QS96USq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F601BD01C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764733; cv=none; b=sHpwOJNFWUgnKvdUO+6qGp2KdTb7rR4qXWKcF96W9TOH7IjOdjbOG2umRtWdA3fl2BM5C7lS7ZHoar6e8v8LVrLCToN9LdRZhJMKh9e4c2dPKXqNVN7H9AiPbybRxTs3Ir7CnFXaiVCi/mmKhslr6vEEk3MM9TyqTVM+LeBqhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764733; c=relaxed/simple;
	bh=sJQ5LyUiM/+vqoF0Rht56fcU4n/fGzs60pCM7TY+OtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYPYw3UuwBz/xhaKOdoZiObJF3G9sXi4TK0dOjUh4doW7yonxZKD2CzCP99s8jpXJNW5WoAK1ve6UJKoZeGZd9R9JzGTvX5leaiMEyisaMngYTtgX2kCCWbBfMJQHGrXyhyfyJbl8GtBA3VpTnTQgIZB05aQesw7Kkn/fez7Bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QS96USq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A4CC6105A;
	Tue, 27 Aug 2024 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724764732;
	bh=sJQ5LyUiM/+vqoF0Rht56fcU4n/fGzs60pCM7TY+OtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QS96USq88ogYaRqoVcotBNZ1d8LNyuYRBRmVWHATV4KVdhRU0nOf4GKje9wW1hOVv
	 a0WNRliC981gDOGhUoYVlWrRKBS1biNKT5w+XvS6E8Qo8nKTkltym8x7qgRndCOl0T
	 TvmMqObMZ0j0GFfpbRUaGioi1YMk6gzzP6TPZDoI=
Date: Tue, 27 Aug 2024 15:18:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Angus Chen <angus.chen@jaguarmicro.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: core: Add more print info for bus remove and
 driver remove
Message-ID: <2024082705-decoy-disk-6461@gregkh>
References: <20240827125244.1747-1-angus.chen@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827125244.1747-1-angus.chen@jaguarmicro.com>

On Tue, Aug 27, 2024 at 08:52:44PM +0800, Angus Chen wrote:
> When enable initcall_debug,some devices call bus remove,
> Some devices call driver remove.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8c0733d3aad8..ff965cd51bcf 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4833,11 +4833,11 @@ void device_shutdown(void)
>  		}
>  		if (dev->bus && dev->bus->shutdown) {
>  			if (initcall_debug)
> -				dev_info(dev, "shutdown\n");
> +				dev_info(dev, "call bus shutdown\n");
>  			dev->bus->shutdown(dev);
>  		} else if (dev->driver && dev->driver->shutdown) {
>  			if (initcall_debug)
> -				dev_info(dev, "shutdown\n");
> +				dev_info(dev, "call driver shutdown\n");

I do not understand, why is this needed?  Who needs it and what is going
to rely on it?

Really, this should be moved to dev_dbg() instead, right?

thanks,

greg k-h

