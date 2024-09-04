Return-Path: <linux-kernel+bounces-315197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9896BF1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BD1F225F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94B1DAC50;
	Wed,  4 Sep 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1awLJiWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AF1DA63C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458014; cv=none; b=qWZEGZXN1IIo1ds2kSjnydY3iy6XWHrVjaGQnEw1xiS8KEeXkr8btkw9rKK6ayplH4AgDB/Jv7fmAMngP8mMJk84x0bdX/clX1jabVKxbZcf32ETtzKDa9WlVHq6GExQ2QVcwBQYmTmQFUJo2LAJ0Oi6NgQ5aR4J7nFLMkkqPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458014; c=relaxed/simple;
	bh=M5KNltI7n2b5jILMz4GnlcLiGKFzR1b2Gy6pU/ejaNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3ISavM6kbRfD8mxatX+qFyh0ixylNR+PJJsqPWh705y1gb1VvsN2UlABuYgM4hUEx/Q/XcQBUCsxWn8cNJzfs8EJ09yjtZbplZhqMh/WEBkog57MC7vmAbRC5wtzJT/N+1X9xwEqp1TB983bSX76W2DQdw0SxqV7NOFvT+1FvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1awLJiWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72620C4CECA;
	Wed,  4 Sep 2024 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725458013;
	bh=M5KNltI7n2b5jILMz4GnlcLiGKFzR1b2Gy6pU/ejaNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1awLJiWd3MQnjmF48eIjny0thTOkrmcFbGPOO2smiVirdqObKST+VIhFqLoGdFQBT
	 EH3/uEXBa7T5aekD7KeiBY31aBH1IXzyx8RjkKvtwRMAYK+I2iBhCBQ1PzzdUIMpiN
	 ihrIZuL+EZpOiWerlMUFIQumncpq9je9KD60AAEM=
Date: Wed, 4 Sep 2024 15:53:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 1/3] driver core: Mark impossible return values of
 bus_type's match() with unlikely()
Message-ID: <2024090444-earmark-showpiece-b3dc@gregkh>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
 <20240904-bus_match_unlikely-v1-1-122318285261@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-bus_match_unlikely-v1-1-122318285261@quicinc.com>

On Wed, Sep 04, 2024 at 08:56:42PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Bus_type's match() should return bool type compatible integer 0 or 1
> ideally since its main operations are lookup and comparison normally
> actually, this rule is followed by ALL bus_types but @amba_bustype within
> current v6.10 kernel tree, for @amba_bustype, ONLY extra -EPROBE_DEFER
> may be returned, so mark those impossible or rare return values with
> unlikely() to help readers understand device and driver binding logic.

unlikely() and likely() should ONLY be used when you can measure the
performance impact.  And any "scan all devices in the bus" function is
NOT performance critical at all.  So this is not the place for that,
sorry.

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/dd.c          | 16 ++++++++++++----
>  include/linux/device/bus.h |  9 ++++-----
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9b745ba54de1..288e19c9854b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -928,7 +928,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>  	if (ret == 0) {
>  		/* no match */
>  		return 0;
> -	} else if (ret == -EPROBE_DEFER) {
> +	} else if (unlikely(ret == -EPROBE_DEFER)) {
> +		/*
> +		 * Only match() of @amba_bustype may return this error
> +		 * in current v6.10 tree, so also give unlikely() here.

version numbers in the kernel source mean nothing, and they age
horribly.  This is not going to work out at all.

let's fix up the one user that is doing this wrong and then we don't
have to worry about it, right?  We have the source for everything, let's
use it :)

thanks,

greg k-h

