Return-Path: <linux-kernel+bounces-189043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6318CEA43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D26D281D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A857C8A;
	Fri, 24 May 2024 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S0SJt4mE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5D5674B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578631; cv=none; b=B6KaqMKigrx2+/Wd/YT3e6bqwHxJFfyxNxP8rq0UV3qjhXdwfAjSos7tSU0GLDjP2CAHjysliFD/SdaYvsdn5VMp/Xm2ttX9THtuuGd01hlktMkAEyfkqtGp0u881SZhmFp1DNE8E9297/y16BIg/XttRQ4lb9Ms/K5fBMXB06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578631; c=relaxed/simple;
	bh=an+56TCay0hx2I5X0ZsHR2PGodXzu+U9P0uKBuDlkKI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jwzSgeMEco28NDC+iLtWttjFCYAdvaWXxTrBDg+vd2aPC+elR7WMFjTrK2kkWjBG6np/aWDYiereKItyBxfyKvGqQCuK7OXbwoBrvec3WTrWgxKoQD33zNQoCwMSl2p/SjZUF2Qa0D/LUjd7efZeHxLZJdYmGc/+KT2QJ/Sg9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S0SJt4mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FB8C2BBFC;
	Fri, 24 May 2024 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716578630;
	bh=an+56TCay0hx2I5X0ZsHR2PGodXzu+U9P0uKBuDlkKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0SJt4mElogTK1nKWV1ZZfHZhV50PYGOHB+4tCgWNbwv+dl2RpjgVRm2sjQEPKL2p
	 CkjgbQ3YlhIRccU+/WWaEp5JxilMlO+CHSMI7eC30QZARIwQiWNRKiL1SShJ2s0HRa
	 /zKMcT7uZQ2WuEiKvRhQnSuTKuEzpgdb9V/sRBAM=
Date: Fri, 24 May 2024 12:23:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/lib/slab: Fix potential NULL pointer dereference
 in kmalloc()
Message-Id: <20240524122350.a22ca8dfe07a21f3eb862159@linux-foundation.org>
In-Reply-To: <20240524191459.949731-1-visitorckw@gmail.com>
References: <20240524191459.949731-1-visitorckw@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 May 2024 03:14:59 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> In kmalloc(), add a check to ensure that the pointer 'ret' is not NULL
> before attempting to memset it when the __GFP_ZERO flag is set. This
> prevents a potential NULL pointer dereference.
> 
> ...
>
> --- a/tools/lib/slab.c
> +++ b/tools/lib/slab.c
> @@ -22,7 +22,7 @@ void *kmalloc(size_t size, gfp_t gfp)
>  	uatomic_inc(&kmalloc_nr_allocated);
>  	if (kmalloc_verbose)
>  		printf("Allocating %p from malloc\n", ret);
> -	if (gfp & __GFP_ZERO)
> +	if (gfp & __GFP_ZERO && ret)
>  		memset(ret, 0, size);
>  	return ret;
>  }

I suspect we have a lot of unchecked mallocs in our userspace code.  If
there's an argument for fixing them all(?) then it would be best to do
this in a wholesale fashion rather than patch-at-a-time piecemeal.


