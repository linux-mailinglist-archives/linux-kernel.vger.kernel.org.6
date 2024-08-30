Return-Path: <linux-kernel+bounces-308488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449B965DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A3C1F273A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA3EEB7;
	Fri, 30 Aug 2024 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MruBwDWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73416D302
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011684; cv=none; b=ZPcjO3Qv2daC13fOvjzymRwkz1Tq/xORp9MFQI2hqE2w5lNdwzoPw6EeWgiLZe1VqhBPRITy1kWh+fXAgKnJTedRgEXX+A23GfO3LjgnP8cBHvTdZkfKFLWgSB9O+5m7PkNGRwcxFx/Day5opPU5PSOQIGYRt+l/kP0eh9vXnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011684; c=relaxed/simple;
	bh=WCI0Vt9AB44ldzS+OK0FeFtsUPiajmnCOLbxk1FwJeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3f4L+j/lOfq5GLREziSsP3QgImwLoW8tC7Isu3Wl4JiYoWcchVrH+8lUGE2ngGuXBV6MyL0LhO2MvzzZuFyrKVotnR1scm06FEB7ITfZQOVDlzCS7nIZfm97BwIk3eJzKc8oHYAxW/J4mrJ2b8xQMT7PJKPvLbA39Gl/fWc4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MruBwDWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C76C4CEC2;
	Fri, 30 Aug 2024 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725011683;
	bh=WCI0Vt9AB44ldzS+OK0FeFtsUPiajmnCOLbxk1FwJeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MruBwDWjB6Cf2v2eQBOjAbDjvfxfmbDjD5r2OubO+mhO4s8Ka8Mro0QScCAGYRHMb
	 Nbs6qqAyomlVQzlxDGnSakEj/47QyuDckqOeB1bWkB0xaNfSxPCThLxXXpi1xkxbXD
	 dPS6XVVkP4IecsqMiBJA/ISHyl721M5fRgD44MdY=
Date: Fri, 30 Aug 2024 11:54:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] devres: Correclty strip percpu address space of
 devm_free_percpu() argument
Message-ID: <2024083059-crummy-backrest-3b6c@gregkh>
References: <20240830083406.9695-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830083406.9695-1-ubizjak@gmail.com>

On Fri, Aug 30, 2024 at 10:33:52AM +0200, Uros Bizjak wrote:
> devm_free_percpu() calls devres_release() with a pointer in percpu
> address space. devres_release() expects pointers in the generic address
> space, so address space needs to be stripped from the argument.
> 
> When strict percpu address space checks are enabled, then the current
> direct cast from the percpu address space to the generic address space
> fails the compilation on x86_64 with:
> 
> devres.c:1234:32: error: cast to generic address space pointer from disjoint ‘__seg_gs’ address space pointer
> 
> Add intermediate casts to unsigned long to remove address space of
> the pointer before casting it to the generic AS, as advised in [1]
> and [2].
> 
> Side note: sparse still requires __force, although the documentation
> [2] allows casts to unsigned long without __force attribute.
> 
> Found by GCC's named address space checks.
> 
> There were no changes in the resulting object file.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-Address-Spaces
> [2] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/devres.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index a2ce0ead06a6..2152eec0c135 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -1231,6 +1231,6 @@ void devm_free_percpu(struct device *dev, void __percpu *pdata)
>  	 * devm_free_pages() does.
>  	 */
>  	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
> -			       (__force void *)pdata));
> +			       (void *)(__force unsigned long)pdata));
>  }
>  EXPORT_SYMBOL_GPL(devm_free_percpu);
> -- 
> 2.46.0
> 

What commit id does this fix?

thanks,

greg k-h

