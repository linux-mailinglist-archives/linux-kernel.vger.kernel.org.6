Return-Path: <linux-kernel+bounces-442767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231D69EE14D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD2165454
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993CC20C012;
	Thu, 12 Dec 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miwuHk0H"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B218643
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992286; cv=none; b=Bf579PwrphUQkH42kRHQSZ9JCAKvIrIDjWWOGiJ1xwS3SotLY7A1UH2oklR+2rOHDqVdjvHVBeFhJWI+EwGdRxkJ0+wyXVZU3t8m8MO1oSvrB8PrXmoUpnrx5x5K0GX027ptFoFpRL0BN2oqLYSx/hEELeeRj8v770arNKVHvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992286; c=relaxed/simple;
	bh=TtqwbhDdjTGWur/AFkn29pIoyLhmrdts8FFcsnS4ag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2JSb6ygrLn5lVXxqa77IUYuDqsqhHKunh5THtK4w7tQ1GE4x3iu9pcYFDf1a5IbbpajYH4LsiriTN95bKmmEQhp1kYoKQwYqTjqaOQwGrx6juxbbj4TPAsCcBhhiWFjK1pOrsy3bIUdjL1M4HEVkuVGLPksoH4lQKHW7R392XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miwuHk0H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so43858566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733992283; x=1734597083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Etgz7RSgss7nTlumi/Zc3I+JdxVFiVXjCxhG6C9rmk=;
        b=miwuHk0Hy1vp2KZ77bgD8ZIhIhw5WKaiNow/diXgivBAmH0hLCFjSQCP47XAxu79i3
         spIZap9d3Xwi4MKBxAul9C3m/48RxzK46DP2XlzFLB2JW4qkn+l/Yke4+8D+uBWmkV7h
         hAuxVxa1hYVbY2JQR8/AYaE763HooHpvnQazU6FHr2g8M4Rxegh6w7w5mp3muvMOU/RO
         EBM7pDyS6w8JaU6BQ4o0f+LsANW5LOd9JSdt5269CVgoSAaksLDwn9U4yxs5HcQH9Ici
         A9BlWcZPpDoZgZkZXSSW05A4qosk5tHCja8Nk4u3bRO9Zy7acqb/iYX8TpyrvGckA2OQ
         CspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992283; x=1734597083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Etgz7RSgss7nTlumi/Zc3I+JdxVFiVXjCxhG6C9rmk=;
        b=WErA0Go3fbclfhMXgyhk5ZmSCANdb4gLyCMTgYiJgiUXoyJbS2ZrxyFODpPrcOHhJR
         IeJk8Xn0Nv9quCb+RSx0zfQwancVh393j9lvU/QS0OcnjdmU6QhLEPpX2+8LN2k4yQ1R
         pYS+VTymBbZOwrtn4LgPpk25Dv1a6y+/KsD2u1G0Av8mOxctoCt6tAy7jm5dcbJK6Hyz
         O6AFu+bP3ZUaFeVhNSso9IofuUcjkN2SXhbMqHnLsLHXJ5MuqAD/0ZSX04IQociKFiTD
         sq9IxjbhmW7om0Lr9H+i7YfRr32A+wTWMaDYSVKpPx/apeZp6SdRvLihl8EH7CrUv9GS
         jlEg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNf8bSvynVZuqzN/tHJXvFNcKgdSwcFh5hb0OwwLfcDzE6KSWem5IJSSl2Lu3j66nJ8Pt7QvDRVYQ03o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QARVLmVIQpQ0Z9ip3z97JUlPaw5xtei7GWpKy4Nf0VAKobPU
	1x7RiezjtV8dBOdcJW6StOhPpsax5gPtKc/M1laxU1VBiX6aKIaO1GyNdYRRPg==
X-Gm-Gg: ASbGncsbzUgP42Retgc/HNb5HqOqW3LEeS6Mcip7CIsfdma4W4XOq3lFO/bLdfq0RXz
	XZCw3HvAPHWuRqfslbWzEt+G7TfNh5SGBFmK/lrvWoLQHuFHsL29UTqwlWaEmJyaGuXHkBrbjuv
	fnb40PgDNFIdHTpCVx7wJlxfmx5ven+ACXf3ObhIbwMTu/SmO7JWOQIBGR8Nmxbintjq0XbeT9v
	VqCy9T8z66BjRO9i4nmJQk4+s2gGEYYnrF68lSAFNz46HEyJPshGe+Fo9jhM9bZOF0xuTjd5GGT
	EJNOD7+BZN9rXC0R9998mee2bQ==
X-Google-Smtp-Source: AGHT+IFD3lPy25E1CHURlBiI+488wd3G2AN3safpm/L9TeioPakNrgwNL3OiBG7nWK80XYFaJpY3wA==
X-Received: by 2002:a05:6402:26d4:b0:5d2:7199:ac2 with SMTP id 4fb4d7f45d1cf-5d4e8f65be9mr479811a12.2.1733992282606;
        Thu, 12 Dec 2024 00:31:22 -0800 (PST)
Received: from google.com (97.176.141.34.bc.googleusercontent.com. [34.141.176.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6656f306csm759543766b.61.2024.12.12.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:31:21 -0800 (PST)
Date: Thu, 12 Dec 2024 08:31:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kpsingh@kernel.org
Subject: Re: [PATCH bpf-next] bpf: lsm: Remove hook to bpf_task_storage_free
Message-ID: <Z1qfVZDXLNoOjR9i@google.com>
References: <20241212075956.2614894-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212075956.2614894-1-song@kernel.org>

On Wed, Dec 11, 2024 at 11:59:56PM -0800, Song Liu wrote:
> free_task() already calls bpf_task_storage_free(). It is not necessary
> to call it again on security_task_free(). Remove the hook.

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> 
> This was initially sent in a patchset [1]. However, this patch is not
> closely related to other patches in the set, so sending it alone.
> 
> [1] https://lore.kernel.org/bpf/20241112083700.356299-1-song@kernel.org/
> ---
>  security/bpf/hooks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 3663aec7bcbd..db759025abe1 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -13,7 +13,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> -	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>  };
>  
>  static const struct lsm_id bpf_lsmid = {
> -- 
> 2.43.5
> 

