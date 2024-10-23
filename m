Return-Path: <linux-kernel+bounces-378822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECC9AD5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4FAB21801
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850341AB6F8;
	Wed, 23 Oct 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFJFSwq3"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A31CEE8D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716611; cv=none; b=B02BZt+uAOgWDrzDX9guVxDscvXyAzTD+XYm43vsdeix1Q3VockMlOIAptdlQ3uB0sFj+0RrecvrN02XAYLIzp/zYKQamMqp0kjYkCZyQkEOzwAvEPb6byHBLo5VaDUW5+Jg84beNONDXVQQr6HEhUyVXhjEBNnS9ZEKh0Ndt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716611; c=relaxed/simple;
	bh=pvwcKlWToYR7b5QhxrkFznqG7vI9ECyzu+ZT1VFC1tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edx9d9kvDflUnTVISVqZqebdBia3r4oUSsVBqz7sRhLc536GU+w72wNtaAyhxHgJFwxAi1GdLpoYZBHmeo4jyteAboh6QxrHknk7gvTl9pHipU7wFbVphuEKTco7S8XQuBZw2ux2H1wY+bjIoi43Jw3jwUc8qSOiNrJhIfzb+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFJFSwq3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 13:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729716607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hCMrhfwuTMkqv2o8jrBH2IAf5A8l6moy/IvYT4IwtM=;
	b=QFJFSwq3mkH0O1xfqXiYVQ+llGFoDemevTmYhM0TGdKFSNHiq20NssA8fFMyuK9vwfr9Wb
	HNfMz759cK8vjjvR/YgxPN9ulOewqeY0JcjbBuIVxS4boli9PuJZgj5ftIYx7RlstYRQ6Y
	JtFVvHtiaNwlLVzDT42np3l5BaOvCfs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: mcgrof@kernel.org, dakr@redhat.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, amadeuszx.slawinski@linux.intel.com,
	cezary.rojewski@intel.com, wangweiyang2@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] firmware_loader: Fix possible resource leak in
 fw_log_firmware_info()
Message-ID: <20241023204954.d4n5rba6e37cvmpn@4VRSMR2-DT.corp.robot.car>
References: <20241016110335.3677924-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016110335.3677924-1-cuigaosheng1@huawei.com>
X-Migadu-Flow: FLOW_OUT


On Wed, Oct 16, 2024 at 07:03:35PM +0800, Gaosheng Cui wrote:
> The alg instance should be released under the exception path, otherwise
> there may be resource leak here.
> 
> To mitigate this, free the alg instance with crypto_free_shash when kmalloc
> fails.
> 
> Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  drivers/base/firmware_loader/main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 324a9a3c087a..c6664a787969 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -829,19 +829,18 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name, st
>  	shash->tfm = alg;
>  
>  	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
> -		goto out_shash;
> +		goto out_free;
>  
>  	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
>  		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
>  	outbuf[SHA256_BLOCK_SIZE] = 0;
>  	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
>  
> -out_shash:
> -	crypto_free_shash(alg);
>  out_free:
>  	kfree(shash);
>  	kfree(outbuf);
>  	kfree(sha256buf);
> +	crypto_free_shash(alg);
>  }
>  #else
>  static void fw_log_firmware_info(const struct firmware *fw, const char *name,
> -- 
> 2.25.1
> 

