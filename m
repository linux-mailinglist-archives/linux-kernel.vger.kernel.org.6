Return-Path: <linux-kernel+bounces-268784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AB94293B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5675D1F242D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F91A8BEC;
	Wed, 31 Jul 2024 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fl96kmJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C41A76CE;
	Wed, 31 Jul 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414760; cv=none; b=HZSbjtJCJX15r+P7wCcSbsOYeAG/zw5PX5U2n/RVt9jjs2TcxgP5U/XDKE9pr/RlBciotHNaPeTbehmJbTBRDFUOTBl6Skk5G+O7q/euZbMglLkGKGzhXssJjXNiiD3qhyItq9DJSdfmZH74OfNuOaV0QbFOFYVU6FuSGUJJKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414760; c=relaxed/simple;
	bh=iNJDaDDKfsib5G/MiRJlhu8tCyRetr4xDCI8p/x+Hcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv7zaOOias4UpJFo6qYOXNq7EIAtp2MSgjB8Yr0JAIFRf8aAziV3FSj+PnUS/GyFtKOM6p7WAXvysPHXC2iI3Wal3AZhHsmzXABlD0UrsZtM6XVzk0md96fOFqtuG4I/JiNwDdIaN3ZCg4L2CpeIEyDbxaZH3DSd/MaZ1W4nulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fl96kmJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD100C116B1;
	Wed, 31 Jul 2024 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722414760;
	bh=iNJDaDDKfsib5G/MiRJlhu8tCyRetr4xDCI8p/x+Hcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fl96kmJ65fILRKODJA6GX7PRFfHKSkME5B36JTzB+5878ReJf9jT5sNMaSOlGg0x2
	 ybQ7FLNfxsWI+qp4mXwRxyHWTY/A3boJ7J9uuZqsvsWXBrK9zM20thkG0VgelC+rCb
	 lpWhPh3vfaRjRuiGsaMBKStQNSZSp39VNFRK7j80=
Date: Wed, 31 Jul 2024 10:32:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Walle <mwalle@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_acm: make bInterfaceProtocol configurable
Message-ID: <2024073151-violator-unskilled-6866@gregkh>
References: <20240730194337.2583784-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730194337.2583784-1-mwalle@kernel.org>

On Tue, Jul 30, 2024 at 09:43:37PM +0200, Michael Walle wrote:
>  struct f_serial_opts {
>  	struct usb_function_instance func_inst;
>  	u8 port_num;
> +	u8 protocol;
> +
> +	struct mutex lock;
> +	int refcnt;

Attempting to "roll your own" reference count is almost never a good
idea.  If you really need one, please use the proper in-kernel apis for
this.  But you need to justify it as well, I didn't see why this was
needed at all.

thanks,

greg k-h

