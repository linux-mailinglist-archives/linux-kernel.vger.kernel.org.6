Return-Path: <linux-kernel+bounces-377396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178429ABE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FE51C22981
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B113AA31;
	Wed, 23 Oct 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVG+M7aL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C61BC4E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663268; cv=none; b=qgHW0mzrVi7QztI1fyYJ52dduQDL5VZzk6zuj1e/sK+cMbldSC+BQ3fZ0s62t6r6SIWAo1GoM6ZR/oAJcd6LHX+KXvNniiQrlMYfjRyPucHbwE6eProwb63Q09ZCnsT3hYGL5mfa8XwrNsltPWXM2uOU7whj9uEYEjnVJMkjNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663268; c=relaxed/simple;
	bh=yBIEJDWbUKw3gDsY89eu0RqIzZKwZll+usCO+iQs8BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKopjF23mrDnmYGAec0j/nDqdRf5nGa0HqY2Kt+rwq9nulgIzko2N2LGMN1RIrpc/EJRGhHhnM25h3k9wR8TJDGeiw0JTOEZGJCb+LVhjY4bTcXuhWCubLHYF6I/OssA6cNhf/kcwtRS+mS7xki7EcvzHrnYE0R4xgj/66+K0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVG+M7aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2770DC4CEC7;
	Wed, 23 Oct 2024 06:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729663267;
	bh=yBIEJDWbUKw3gDsY89eu0RqIzZKwZll+usCO+iQs8BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVG+M7aLTz1L0kiRIFdp4ZhYjbUJwDrXCD9C9a0z+gG9Ocz9YJFTvXmkj9jFvzzXy
	 pApoIjJbPP8Winv4t9yfkLGq8O83Y1DT0AClNno6vXnpPAV+iKlh3Ys9DkTt6CYvGG
	 aDGU1QcHMQXnfi71/L8rFTTs/Jqm803qYNDSxaKo=
Date: Wed, 23 Oct 2024 08:01:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: jassisinghbrar@gmail.com, stefani@seibold.net, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kfifo: don't include dma-mapping.h in kfifo.h
Message-ID: <2024102325-gone-reanalyze-f105@gregkh>
References: <20241023055317.313234-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023055317.313234-1-hch@lst.de>

On Wed, Oct 23, 2024 at 07:53:04AM +0200, Christoph Hellwig wrote:
> Nothing in kfifo.h directly needs dma-mapping.h, only two macros
> use DMA_MAPPING_ERROR when actually instantiated.  Drop the
> dma-mapping.h include to reduce include bloat.
> 
> Add an explicity <linux/io.h> include to drivers/mailbox/omap-mailbox.c
> as that file uses __raw_readl and __raw_writel through a complicated
> include chain involving <linux/dma-mapping.h>
> 
> Fixes: d52b761e4b1a ("kfifo: add kfifo_dma_out_prepare_mapped()")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - improve the commit log

As the original commit came in through the tty tree, I'll take this through
the same tree as well.

thanks,

greg k-h

