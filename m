Return-Path: <linux-kernel+bounces-218117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108590B97E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27EB2894CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC4198A06;
	Mon, 17 Jun 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pq79Q1UV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258B198832
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648098; cv=none; b=hC31vE9AYeOgiP1UsdURQ5S3lTE4Q39LwX3I5ADbTu9UZ5/1e5xZmpqpy+i4SrLS//OArfxAbzDvYz23bPP96P5rFUWs9wlnSDfnBpR1sdLzEXKJEsl/e8sx1yGD+Q/xKFtZbeVOhX3KllPdj2XYQ4ZXiuw0EK5+ryo4muFu6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648098; c=relaxed/simple;
	bh=m+kTbsc4dhka50X4MJIJYgMQbW7Z1Ew5oThQd+cxLII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyFN6rziQkQd4XkqRbqY96O/gR8bGvYJOuVTBPC1RBW2POpCMSne9HlWfQRLKutCm1SImpko1R4IDc+UlPaKOrmxsDn8iLPfcxXEJKLWlcmO6ujo3Lon4jumww/Ndf1JNINktX+Y96WsjZefCzJ/8XeKNB9bAmAmrUxYaTITWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pq79Q1UV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59A3C4AF1C;
	Mon, 17 Jun 2024 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718648098;
	bh=m+kTbsc4dhka50X4MJIJYgMQbW7Z1Ew5oThQd+cxLII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pq79Q1UV44yYmiSDQWhe7Ffgiv7QOVt4fGFBhi8SQ+dE4Vl6aM7SeBcIRvOLKzTup
	 hwY5PQH8Imyb8tYKXuZr7nR2U1w73+uyLCvRRpKeqv7EnOOpfnBbqoLYpdiVnZVnds
	 6UGDBDCc93XDZaTHvvqcyErrA60Z3tYtg9H5aFvk=
Date: Mon, 17 Jun 2024 20:14:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] devres: Initialize a uninitialized struct member
Message-ID: <2024061726-payment-editor-7431@gregkh>
References: <1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com>

On Mon, Jun 17, 2024 at 09:09:25PM +0800, Zijun Hu wrote:
> Use memset() after kmalloc() a struct devres_group to initialize
> potential uninitialized members such as @color within kernel API
> devres_open_group() as alloc_dr() does.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/devres.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 3df0025d12aa..ba3e4603cd77 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -558,6 +558,10 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
>  	if (unlikely(!grp))
>  		return NULL;
>  
> +	/* No need to clear memory twice */
> +	if (!(gfp & __GFP_ZERO))
> +		memset(grp, 0, sizeof(*grp));

Is this an actual bugfix (i.e. do we have uninitialized fields today?)

If so, what commit does this fix?

thanks,

greg k-h

