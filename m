Return-Path: <linux-kernel+bounces-227259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8BD914E34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7642822A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05A13D61B;
	Mon, 24 Jun 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jtxjl/lz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E113A876;
	Mon, 24 Jun 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235067; cv=none; b=qqUUDl91EC8AEbTBNIzvSV7GFgKmyw8N7MVnVc5s6KfXATHgUjr8bsyOAAEcQ3CBk/iObORgBAUhNGNvib3w3WL6IB38XwNSgE1h0xAOi/eVuiSlvVFqvyUjEGtbm/9lZcyFtVx2d7GU7xL7mShPy5IefyS0QAfKmeNJ5SOdeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235067; c=relaxed/simple;
	bh=x0qE1AbTE2E3Y2ugPMh1v8bbkWrZyWYuZzqqNaawNKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaapJIucjMx7ZJrqaW/lxiXmyqGBiSKzouP0Z/q6E+69EYcXKVzMp8vUOrFU+QchMyJUdTYS/z4mJRt2rsPVI5IpN5YadtE/UrkYeTIkvKxi+VM3DmCSivr9ycVTuWdmd62kqNy/9MgCcp1yxXqttOTcGEPAa9Rj3Ii6AwFV/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jtxjl/lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53F6C32781;
	Mon, 24 Jun 2024 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719235066;
	bh=x0qE1AbTE2E3Y2ugPMh1v8bbkWrZyWYuZzqqNaawNKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jtxjl/lzbjh2ajHo7DZeSnk5oGRUzKwen5oZ7MHu7GoBj41yYpkL5/s8jieKSyRO3
	 tvHlY3bjlDgyFFDWjv24w+IBc4jq8RKsY90o+glvK0Bbltgn7dfVL3jBd6cHDa7gmN
	 QCQ3mRyayi81qP6HC9d402qkSbAtii8eguP+EWq8=
Date: Mon, 24 Jun 2024 15:17:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: Align address to 4-byte boundary
Message-ID: <2024062408-stash-gluten-ef19@gregkh>
References: <20240614224256.43131-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614224256.43131-1-jain.abhinav177@gmail.com>

On Fri, Jun 14, 2024 at 10:42:56PM +0000, Abhinav Jain wrote:
> Add address alignment in sdio_local_read, _sdio_local_read &
> sdio_local_write functions as per the TODO.

How was this tested?

> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 107f427ee4aa..caee2d2043b3 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -478,9 +478,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct _io_ops *ops)
>  	ops->_write_port = &sdio_write_port;
>  }
>  
> -/*
> - * Todo: align address to 4 bytes.
> - */
>  static s32 _sdio_local_read(
>  	struct adapter *adapter,
>  	u32 addr,
> @@ -494,6 +491,7 @@ static s32 _sdio_local_read(
>  	u8 *tmpbuf;
>  	u32 n;
>  
> +	addr = addr & ~3;

Are you sure you are allowed to do this?  Why?  And a comment about what
you are doing, and why it is required to do so, is needed for this to be
acceptable.

thanks,

greg k-h

