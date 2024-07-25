Return-Path: <linux-kernel+bounces-261907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C9393BDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8061F24CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4558172BD3;
	Thu, 25 Jul 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gFl2fEfm"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C0173351
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894752; cv=none; b=WtOcgMw/2Q/IovRgewWbtzXwtSKNg3AZiJgghWfBRwz8ut/Wc2dFjxb3BZPBTjYQJIessodsJuT8qsLCbDUWNrjhk4IaJvtt/uUzeuK+VHqvkrMOJh7xthOI54K34/O/Ui8KEK12qbA9gqz986+RQSwBWLw2rKu3z1fp6GPZozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894752; c=relaxed/simple;
	bh=SAx8kiWrplUpDncl7Zl/7oZ+VwaJAtzJRhhrBI5NGQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY2q+w4HyvKRIiNdP6lIl3oixxKanvl1DrkZvxVmg6G9QxrbFBNuTpL9yVQC9sr7F0TJbFjQ54tnG2Z4S6ZJprS2GW5dzhcb+0J+dB680vRGvlDfKIjXZOiXqn+9HMozBBngbtRetmrUw1JwICTP+OHXC/HIGcfpchzMhmW9ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gFl2fEfm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8553db90so32810966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721894748; x=1722499548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRnH6NudcW58JntnCvmK82JIkEjkZNiIjkq+7RHs4dU=;
        b=gFl2fEfm5lhRSivDII0+mzqWAdp/9TsPXQFOvsHRqnOQN6hYW0nYlUI7vl7j1j3Gns
         WzJF+e+eZxtQQ3GnWQNHyF76i1zQarVnQ1I789TRvpMusIYYi6pw2n++zAHVwmgY94eL
         MI30XWByynjubXXdRFpE2VIbevD7O9yrWrSsi369UHKfR138qtBmehguHUkXz/47/IDd
         sRMBZ2FvAPR9f4xwBW59cmbxxNTbp74UapZLQ4w3roUoeYlIetGagRpIvzxpAzhdvUir
         iK7c3uSAMZba/rEjXN8dikf5U0cs0ya6Pj27U4eIoPETSUmN+ZIx+PhrZz9yR7Lv8RCG
         KCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894748; x=1722499548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRnH6NudcW58JntnCvmK82JIkEjkZNiIjkq+7RHs4dU=;
        b=HWp3od/6pAseljNnCnUpnMdJeStk/jN2z9k9um6LLn8FhuPz552EzCjaW2cBPZcyWf
         YzIGVBZzb5c1/aomO736PXHy0FBlzOvD8iM9f40InJu17/xVQv+OEkE501UYRXdfA0ya
         TJnKpH1T6KoH33bCvXBL4xnvqQF+pVLcVK1M3m7NpLVU1etJW19grkXlynHuPpJ1yyFs
         1KkPCT5zEk7oUJ4Tk1XAHa005f9FA5u14go/4mjwWuNkKYBhfivT+mJhebAJL5E4DAVi
         5owhY437svUrOow4Bj8Hr6tV9i2CTQlTr8e77tUFqOjRQoPU1GAN21nRuKAwVhSWqjdW
         WcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJm5Ll8nbHl0H1tCDFW5xStypgy3kFB+DIs6D2a1H83mDN1nSLTJvWISPv+UJ80E5Ic97dYp/LMFgCLAfIlZK764+qGomEGwZLRF7b
X-Gm-Message-State: AOJu0Yx2oJSf36KVlprcBGKZT8RfPYaTh+n3NHwQq4cTex+IunzunDo/
	OSmo6U/KknLcPnFCFS33Vsc8up6gRA+Rp3NvosqZUsIUzBrvRslbN7hrw6QXEyE=
X-Google-Smtp-Source: AGHT+IEt0zpE8oThFX16PUXvi9TPj5/g2oFDUegJAn6IFVRPdv0rZsZdOqxJ5yraYDVJJU9OOFCT5Q==
X-Received: by 2002:a17:906:7f05:b0:a77:c583:4f78 with SMTP id a640c23a62f3a-a7ac4f41540mr113834166b.39.1721894748354;
        Thu, 25 Jul 2024 01:05:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab5948asm45212866b.85.2024.07.25.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:05:48 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:05:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: mohitpawar@mitaoe.ac.in
Cc: yoann.congal@smile.fr, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] Fixed: Kernel: user_c: fixed whitespace &
 intendation errors
Message-ID: <ZqIHR9LDmp8bduyn@pathway.suse.cz>
References: <20240713174137.125978-1-mohitpawar@mitaoe.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713174137.125978-1-mohitpawar@mitaoe.ac.in>

Adding Andrew into Cc who usually takes patches for core kernel code
without a dedicated maintainer.

On Sat 2024-07-13 23:11:37, mohitpawar@mitaoe.ac.in wrote:
> From: Mohit0404 <mohitpawar@mitaoe.ac.in>
> 
> Resolved -
> 	ERROR: trailing whitespace
> 	ERROR: space required before the open parenthesis '('
> ---
>  kernel/user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/user.c b/kernel/user.c
> index aa1162deafe4..9e07264fd6f7 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -6,7 +6,7 @@
>   *
>   * We have a per-user structure to keep track of how many
>   * processes, files etc the user has claimed, in order to be
> - * able to have per-user limits for system resources. 
> + * able to have per-user limits for system resources.
>   */
>  
>  #include <linux/init.h>
> @@ -249,7 +249,7 @@ static int __init uid_cache_init(void)
>  	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
>  			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
>  
> -	for(n = 0; n < UIDHASH_SZ; ++n)
> +	for (n = 0; n < UIDHASH_SZ; ++n)
>  		INIT_HLIST_HEAD(uidhash_table + n);
>  
>  	if (user_epoll_alloc(&root_user))
> -- 
> 2.34.1

