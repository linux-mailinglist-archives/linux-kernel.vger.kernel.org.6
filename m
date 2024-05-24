Return-Path: <linux-kernel+bounces-189073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15E8CEAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D2B1F22050
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0984642B;
	Fri, 24 May 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mV9pLWDX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEA383BE
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581270; cv=none; b=h4BPlCrOJjXWOEf/dh0u+M1nNXRXLkyY6eYdR889Jp0Aeh3tT+VgKrqE8BlsAYSIKC+VlAklw3d+D8eLEKvLsfrIoeUHa1XUF6xpqm0ca69M3P1KAtdU7E8kwFcY7Hdd0m9prg/CclqwvWqn5mSYj3LNUfY0ghJ3QS0kFr4mY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581270; c=relaxed/simple;
	bh=j9/YVtPEgRi2HN9680TGSgOfHs2Znjt5Y5XuEh1Jcno=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TrT77pXK0uXHMHDJj0nUTia69rb+kRo5LxNKBWLVTH1ztCeTfch7yuLidV1xLPJCN/xGJPAuFrDIs+fGOob2n1353GJwfTrSDJgUylGuQJZmAdlNzD33YysKFTasS1ax6T2YEm2rhb98w3w5hKyGx/D9xu0elCZ8V6Cd0Pu6YhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mV9pLWDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2599AC2BBFC;
	Fri, 24 May 2024 20:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716581269;
	bh=j9/YVtPEgRi2HN9680TGSgOfHs2Znjt5Y5XuEh1Jcno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mV9pLWDXmL1XQX4IFU8GvOu96QOd1u+4+JRPPCgqDB9CrWNDN1BJ3gGHzRqG6uRSE
	 SZs2ss/cWZ+Xpv3XNhWY0BhpFD9oL3Ko3S/j+cEqunBIONq1LtU8988mU6XSUTXch7
	 0pJ9RCSMP/ldk4FTswXFG98/Rckf5+wjweJ5YGVw=
Date: Fri, 24 May 2024 13:07:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] XArray tests: Compare pointers to NULL instead of 0
Message-Id: <20240524130748.cdac446bb90f75fee5ffe47f@linux-foundation.org>
In-Reply-To: <20240524071655.31386-1-jiapeng.chong@linux.alibaba.com>
References: <20240524071655.31386-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 15:16:55 +0800 Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Avoid pointer type value compared with 0 to make code clear.
> 
> ./lib/test_xarray.c:973:52-53: WARNING comparing pointer to 0
> 
> ...
>
> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -975,7 +975,7 @@ static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base)
>  
>  	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
>  				GFP_KERNEL) != -EBUSY);
> -	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != 0);
> +	XA_BUG_ON(xa, NULL != xa_store_index(xa, 3, GFP_KERNEL));
>  	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
>  				GFP_KERNEL) != -EBUSY);
>  	xa_erase_index(xa, 3);

Thanks, but we avoid the (0 != expression) trick in the kernel.

And as far as I understand, it's used to prevent people from
accidentally using = where they meant == so isn't applicable to !=
anyway.


