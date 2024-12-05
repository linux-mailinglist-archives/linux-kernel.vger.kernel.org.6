Return-Path: <linux-kernel+bounces-432842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD09E50F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D137F166367
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9F1D5AAC;
	Thu,  5 Dec 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecGYBoWI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B01D4359
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389937; cv=none; b=Pmuk5nLmQXkEymt0HUTJIP0NWGk1pTS2VQp010D0w+qPRbjNbhHaDC+l64FQPNddEUBDKFqq1kwlxvRXkfx8av71aWCK/2BKTdet/r8Psd/F+yiCYxMB7HXuTwXSVy+zeB/58XF7fxZ9sJksC3N8shXc0ILehjRW2IYPxgnrbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389937; c=relaxed/simple;
	bh=voxyG9j0+SG63JH/hJ+opZ3Fhv7hiJrmgSm/heFcPpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKyJZjukv2XmSFdZZMtvkcBOFwjqf0fzM/jgkF3XPZ2M9mR0AFeZJyts+snY8nxjzlMVbD686RcFRMMNOZ4kBxnNrZdOanEct6K2mZHxedaMW0/NiDbljaNj+BezKA/vXqeDOOWczuaKasq2BcjcIyT3Hz34NKzxHgPgec7irWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecGYBoWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D3DC4CED1;
	Thu,  5 Dec 2024 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733389937;
	bh=voxyG9j0+SG63JH/hJ+opZ3Fhv7hiJrmgSm/heFcPpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecGYBoWIV6h3f+Fn4osGGyoEw5jcOudrsvswg5epswLLsukmAdK+ABiEq7zVl6Ml6
	 X1i+XkNsopITXm1RRkjlXRlhgsKZZoTi8//bF9ziN9PH9mLnZw+VFBycsqQZ67FjcL
	 ZWQHey49FGQlwEOb+nnGzY03+PGv+HS53N2Bj57A=
Date: Thu, 5 Dec 2024 10:12:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH] mux: constify mux class
Message-ID: <2024120557-halt-enable-224d@gregkh>
References: <20241205085605.9501-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205085605.9501-1-brgl@bgdev.pl>

On Thu, Dec 05, 2024 at 09:56:05AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> All class functions used here take a const pointer to the class
> structure so we can make the struct itself constant.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Greg: Peter picked this up into his branch long before the v6.13 merge
> window, then never sent it upstream. Could you pick this up this time
> into your tree?
> 
>  drivers/mux/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 78c0022697ec7..02be4ba372571 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -42,7 +42,7 @@ struct mux_state {
>  	unsigned int state;
>  };
>  
> -static struct class mux_class = {
> +static const struct class mux_class = {
>  	.name = "mux",
>  };
>  
> -- 
> 2.45.2
> 

Sure, will do, thanks.  I should sweep the tree for the remaining ones
as well...

thanks,

greg k-h

