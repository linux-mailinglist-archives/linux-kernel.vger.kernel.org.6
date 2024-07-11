Return-Path: <linux-kernel+bounces-249412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CF92EB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9911C21EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F216B3BF;
	Thu, 11 Jul 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnVqCYw1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFD1EB2B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710805; cv=none; b=RITV7SR9RWjc3COG7DrhacWqkUGtVTYyd+3rvXuEoopRSQLTar5KoPWHUbjKaW/gRV6QdshwGFdGOamOWxbecWBYiQ+4iVudXAqWgwdNYNDPHT3BhFVqwpUMQC3hkvzqGiajFqyq9MybrOnYqZeEVu99/coqI8AN+dTrIY978T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710805; c=relaxed/simple;
	bh=9zjATUP3xx6iVJ/dTpMxDzrlKeX9MiSo5X+0L6tu33A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd8vFNuh+claOhqhMqDvLJX1sE/U8tHt20diwD4hYqPQ5Xz746oMdBEu+U4+pXVnpv2rpvf3s+ypVOv2jqyD3jIq1HTfjCBbUy6DbI1NtvYTa8sNlijlUqePPSivfk4ZTY6tB497qKMWK97vDuMGiHaUotRA/I4oghBvySiq78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnVqCYw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CD2C116B1;
	Thu, 11 Jul 2024 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720710804;
	bh=9zjATUP3xx6iVJ/dTpMxDzrlKeX9MiSo5X+0L6tu33A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnVqCYw1kN8Qk+kO3EGoZatRIx+9DwEEqnWk2LBijACQAOnHYGxZLCyG4fSKPTsKW
	 qIOeHUJmh8JB6S92SRUKaXe6KLKfIfCh1T3fyKpfimN1d+bhTYIzrMNT2/owYeeJoF
	 sjKsG3UyPXfhmy8MXbltoAuzxYSB42AkLmm2rrtw=
Date: Thu, 11 Jul 2024 17:13:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver:core: no need to set a default value for
 want_async
Message-ID: <2024071101-cytoplast-overflow-d8cd@gregkh>
References: <20240711150545.3143-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711150545.3143-1-sensor1010@163.com>

On Thu, Jul 11, 2024 at 08:05:45AM -0700, 李哲 wrote:
> The default value of this member variable is false,
> which is only set to true when asynchronous loading is required,
> and does not need to be set to false during synchronization
> 
> Signed-off-by: 李哲 <sensor1010@163.com>
> ---
>  drivers/base/dd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index d047919d1f5e..47351d98f6e1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1014,7 +1014,6 @@ static int __device_attach(struct device *dev, bool allow_async)
>  		struct device_attach_data data = {
>  			.dev = dev,
>  			.check_async = allow_async,
> -			.want_async = false,

This is good to keep as-is for documentation alone, it doesn't actually
change anything and makes it obvious.

thanks,

greg k-h

