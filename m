Return-Path: <linux-kernel+bounces-281324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2594D57C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B11D2829EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57187344C;
	Fri,  9 Aug 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMQUXBFH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318912B176
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224876; cv=none; b=ndyi/hV+SYSQLAZNGKVnwLQk/MuRD6K+aAsvfV6Ob90OLZa1NZMhODo3NVq9Zf4wJtuh7JRIupxGMHn0SOlWaHJgJqi8ZpzIFMxlBpUtlOx+bgVcHQC8zoGv790aGpH5fbvxMovx0mMCRoP1EXOi8Yc++vSWm4Z4EBCj8T1Ahdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224876; c=relaxed/simple;
	bh=uaFoxvFaWKTcurfNyk9i82RYMbsjWOiWm8JvkajnOEU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nVEqcTRR2Zxhzoib9NS5zhv6BcyAolTvZQSYCej2HKCKPC4dLaQjE4/GnAIqoiQctStU7QRNn4/4fJNfhx9kHnXNvgmcvRBDBMI/E+9cIAR3PLu1JPv8NJVJmRWyUGcjhQZmNJsifqcpswnn7uiC8lzZ6QBPGNUeeEfXUpjPkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMQUXBFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723224873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qAgqY2+FOr0YdLUk8z8Be8IJe7YHmn8uPB+WVVFagE=;
	b=dMQUXBFHJZ+pAmBSNb8m3tMzK7mO3tUIGa7T77h0F1r8SJvoOYuzlUYjmE+UagYjajxb+3
	DMD+PcylDy6yFk4T+YMIbEo3TQCGBFcTfR+HfzljrWvTp5HMT7kOXBnluhaKBzttSVUPkQ
	NQsyeA3SL0SZsWVZzvvQSPy/r1jkh2Y=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-J4JaAdxdPZKoxty0KKaMZg-1; Fri, 09 Aug 2024 13:34:32 -0400
X-MC-Unique: J4JaAdxdPZKoxty0KKaMZg-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4929b9c17feso1187611137.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224872; x=1723829672;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qAgqY2+FOr0YdLUk8z8Be8IJe7YHmn8uPB+WVVFagE=;
        b=cWwcFzg4mU9uJOuY3X7O0GZFk2rXXquq+M74vhXyOqqCtKJz4FWZhRjytliFiCsp8/
         cH+USRvkOlbV2Np9H3YrOkJggWW2phbhzyMoPZjplB6zkwq+2Bf667GwNASBoj5Yx6IO
         OdKOmaoZBDa17LAmv0E2hU3zskrPn/JJLBm/w1oKqRCVTWKuu9eCKPM5pVjbDpk96csz
         f6qkpq/U9N3XchPZW0YsAQtHM11bL9HqYcSNd/mH29DGck2LOcU41Hfc+ziJ633LsLPq
         uyIHgFOm+aN8ZCBV8pT4BMJ9Gra3DbCdOIMgYzQjEO57r36gjDjy0tgr2FOb189U1pgt
         qsIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+eDE7+KhOBkac/g4fqN8PNlRDhyN6B4kKNVoXjoeTF2LdileRZJDWU9tqcAGdWHEezZ68K1ob9SKfsYwQaACfiCnz2103hK2Srq/6
X-Gm-Message-State: AOJu0Yw8KHU+88NFTbLPUulHtppztEgTuDnFmTdkpwHDbShwUd79a+/q
	a9Kk6bFcSoU/1AVztEXqAaELQp3SglM+sBpKyUD9n88zPlVJmRU4HURmZiFEA8LG0t2WRTXgCnz
	2wr9RsnyFISZRGqrze26IzDGt7iTxo0+F4/lT6LymFnbS3n3WRk61cZJZsBj5XY19QcuGcg==
X-Received: by 2002:a05:6102:3ecd:b0:48f:a7a6:bacb with SMTP id ada2fe7eead31-495d840a6fcmr3080142137.12.1723224871862;
        Fri, 09 Aug 2024 10:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuWaN08M43DbXCZSgcHg0HBsQZIbgEQVqpCg/mNM2hukMdn00DmL6gxpy8xax+9c89Jl8GZg==
X-Received: by 2002:a05:6102:3ecd:b0:48f:a7a6:bacb with SMTP id ada2fe7eead31-495d840a6fcmr3080116137.12.1723224871501;
        Fri, 09 Aug 2024 10:34:31 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f2452sm278505685a.59.2024.08.09.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:34:30 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:34:28 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Daniel Bristot de Oliveira <bristot@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error
 handling
In-Reply-To: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Message-ID: <c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 9 Aug 2024, Dan Carpenter wrote:

> If the "tool->data" allocation fails then there is no need to call
> osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index f594a44df840..2f756628613d 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
>  		return NULL;
>  
>  	tool->data = osnoise_alloc_top(nr_cpus);
> -	if (!tool->data)
> -		goto out_err;
> +	if (!tool->data) {
> +		osnoise_destroy_tool(tool);
> +		return NULL;
> +	}
>  
>  	tool->params = params;
>  
> @@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
>  				   osnoise_top_handler, NULL);
>  
>  	return tool;
> -
> -out_err:
> -	osnoise_free_top(tool->data);
> -	osnoise_destroy_tool(tool);
> -	return NULL;
>  }
>  
>  static int stop_tracing;
> -- 

Although your fix appears to be correct, I wonder if it would be better to 
create a second error label, such as out_destroy_tool: as described in 
section 7 of the coding-style.rst

Thanks

John Kacur


