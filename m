Return-Path: <linux-kernel+bounces-322789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A634B972DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF3728564E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639C918C005;
	Tue, 10 Sep 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkjg8dTC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B418A6DF;
	Tue, 10 Sep 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961075; cv=none; b=mY2y6benNNyc31jtFz6kJI+AoXIbCsc9GT/lI84f3C7338G30z8jBIMnC76dwpCnMl9rn0NWXFTG1Xm7ge9UOtl65CJ/JrG1WcgDQ450sOtM42kKExIShnIBQHDjeBQz4Waicz3+LJ5w8IrUq6aMQi1yjV1Fg0gzXzXi/Mt8lY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961075; c=relaxed/simple;
	bh=yjDJud8W9puFv5VkCEq64ew6K8UyJBnq0jOKzD0rCwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEnbPwH2XRHGw2k5YGVf3E4FcwgXteBxb50Oa13YZosJXBO38LDe+JkVZEE1I59OhQQFTB1NpRaIXspUsm1MR/Jq6alXcLKlleNUR41Cunswv9n+AqhrpIs0kvsTRAuH4nz55fbvpKskUcZ6bgB2vduntPtzkQm6zFby/DmnYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkjg8dTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CB0C4CEC3;
	Tue, 10 Sep 2024 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725961075;
	bh=yjDJud8W9puFv5VkCEq64ew6K8UyJBnq0jOKzD0rCwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkjg8dTCx7cKeL+RgZG6evo0MhXjZs8TLK80v5xpfB0AXZRPQFE7YSoKx6uMHKDKn
	 r1yw6w2euGfXTuDzJqbVK2ByZGotyU2JZqVxC689ea6YS/bootdkn1YEd64ZN/IDzm
	 FJthGYb8u4xAEoSiqCD73qWYHmm+7E/IXK1Xwuj0zWcyyVYFMxcQNEZ756ZmwYdOCB
	 bFZmS3vYYngNRkiRq04/HL3/f/Ov0ZpLUctgZT4OqWd8uM+tXx8jH4/ikF+IvHdlJl
	 KRd2OHpUBuM3pTrrMyNop4+oARU+j/UlkRpmM+SEPxBcJutraQc94yf2ZBQbjFoPzp
	 KAXDEju9zT7ww==
Date: Tue, 10 Sep 2024 10:37:51 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] caif: replace deprecated strncpy with strscpy_pad
Message-ID: <20240910093751.GA572255@kernel.org>
References: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>

On Mon, Sep 09, 2024 at 04:39:28PM -0700, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings [1] and
> as such we should prefer more robust and less ambiguous string interfaces.
> 
> Towards the goal of [2], replace strncpy() with an alternative that
> guarantees NUL-termination and NUL-padding for the destination buffer.

Hi Justin,

I am curious to know why the _pad variant was chosen.

> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  net/caif/chnl_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> index 47901bd4def1..ff37dceefa26 100644
> --- a/net/caif/chnl_net.c
> +++ b/net/caif/chnl_net.c
> @@ -347,7 +347,7 @@ static int chnl_net_init(struct net_device *dev)
>  	struct chnl_net *priv;
>  	ASSERT_RTNL();
>  	priv = netdev_priv(dev);
> -	strncpy(priv->name, dev->name, sizeof(priv->name));
> +	strscpy_pad(priv->name, dev->name);
>  	INIT_LIST_HEAD(&priv->list_field);
>  	return 0;
>  }
> 
> ---
> base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
> change-id: 20240909-strncpy-net-caif-chnl_net-c-a505e955e697
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

