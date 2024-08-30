Return-Path: <linux-kernel+bounces-308133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199AF9657A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF9EB225F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879614F9CA;
	Fri, 30 Aug 2024 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFpcYn0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292B44C7C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999561; cv=none; b=baZbUNkOObH9GHjW8nj2xS8jMSCrs/6nLAzXZBZh9DytdhquCypCmnV5HfxAeqD0KPHDWA2P+CzAYnh6H5d2BXEDJRjZR4mJuTO9Z4B/aMq70VcAU6gzVqmSnAXlxgjqgb33JYXkgGiZHrmpi+b1E35smFGkpe4RH3ohaiw8Ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999561; c=relaxed/simple;
	bh=VMqKJ1JGITkREK/yofWVBvmuimETfHiYKui33Vd37OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNSN1b+444oFvz+ALeuwddSl/oQleSG09jx9i9iaKPikIwfOw9vZQO0KSB0qQEVrNEgo2HY32uFAH9HkpOcmp5a6IRood2ci0jUdvMXVbXlndLjzvYV8YHd4j74ZV0dbKRJZPPsvncqk51VIv3hb/dK7BemCQ1UKWKdTgei6Hxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFpcYn0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2462C4CEC4;
	Fri, 30 Aug 2024 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724999561;
	bh=VMqKJ1JGITkREK/yofWVBvmuimETfHiYKui33Vd37OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFpcYn0mv+BJq21HZjfUSSwGJEObGxsIRKdmzAqvSY0T68IM5Ei9lldKT2eQqgjMz
	 YmMFY52wekA7xN5BCIQxlOef5Ke/4m8ugvb7uvxJIjLqVdW/W3ZUu1HCJvTRbXuJ5j
	 SgPYsB+8ycz03PuIWP6apZVPuHQZlQdyp0q3Qr/k=
Date: Fri, 30 Aug 2024 08:32:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: arnd@arndb.de, masahiroy@kernel.org, kees@kernel.org, mcgrof@kernel.org,
	jannh@google.com, ardb@kernel.org, song@kernel.org,
	ojeda@kernel.org, gary@garyguo.net, wedsonaf@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] kallsyms: Fix wrong "big" kernel symbol type read
 from procfs
Message-ID: <2024083030-cacti-ruby-4dab@gregkh>
References: <20240830062935.1187613-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830062935.1187613-1-zhengyejian@huaweicloud.com>

On Fri, Aug 30, 2024 at 02:29:35PM +0800, Zheng Yejian wrote:
> After commit 73bbb94466fd ("kallsyms: support "big" kernel symbols"),
> ULEB128 was used to encode symbol name length. That is, for "big"
> kernel symbols of which name length is longer than 0x7f characters,
> the length info is encoded into 2 bytes.
> 
> kallsyms_get_symbol_type() expects to read the first char of the
> symbol name which indicates the symbol type. However, due to the
> "big" symbol case not being handled, the symbol type read from
> /proc/kallsyms may be wrong, so handle it properly.
> 
> Fixes: 73bbb94466fd ("kallsyms: support "big" kernel symbols")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> ---
> 
> Resend this patch due to no reply more than a month.
> 
>  kernel/kallsyms.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index a9a0ca605d4a..9e4bf061bb83 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
>  {
>  	/*
>  	 * Get just the first code, look it up in the token table,
> -	 * and return the first char from this token.
> +	 * and return the first char from this token. If MSB of length
> +	 * is 1, it is a "big" symbol, so needs an additional byte.
>  	 */
> +	if (kallsyms_names[off] & 0x80)
> +		off++;
>  	return kallsyms_token_table[kallsyms_token_index[kallsyms_names[off + 1]]];
>  }
>  
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

