Return-Path: <linux-kernel+bounces-354360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D4993C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AAB236F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3918AEA;
	Tue,  8 Oct 2024 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GNrQCieE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7A17BD9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352246; cv=none; b=soaAx4eyX/St5WmKDX5Og7jn0+kBlsVM70V9btkVG6ci8KuGigNGncaY6SS9LwqW5nUi5Fo2H7Lncp+6pEq7wD6LE3QJTaWKIMJh5JAjYbUXcV/Gy2hdm4IGDS3SoiNf9Fvb4jCzcmHI1/8CXnBWimq5LqRS3kkdiN7ZJ+lxnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352246; c=relaxed/simple;
	bh=BsxriBA5sg19Ge4UvemMCatVU+3d+aE1o8hd4iQJQP0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ql/Hjk2vOXvgZXeQY56M/JHY79WeeqHkjijZE4d9vDXc9sYCTkX58yHhUYa0+KipVSm6luNh4OmhYX1D/wwQqCjXU5bSHNzoD0X0KHR+7Jp34C+mA3lu8/av7zW/ejMoBCnaoGsel9eIeIizLpSmeSfhX3eO0wSJrLVFiPMmDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GNrQCieE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29459C4CEC6;
	Tue,  8 Oct 2024 01:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728352246;
	bh=BsxriBA5sg19Ge4UvemMCatVU+3d+aE1o8hd4iQJQP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GNrQCieESfUArH8WxyQvBzeSWTViBEwJdKOqISBQn4SZEwDPHgiSibqE3woODSJxY
	 0veJ+yETua6zxK4z4MtCLhU9vVELF07KAK9s3BDmVpAXByDgRBmuSsC7HTUWqJNj9b
	 C5Q5eaA2QACdGXHjI1rgkf30lYNSiU5vHD+hK/kM=
Date: Mon, 7 Oct 2024 18:50:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishnu Sanal T <t.v.s10123@gmail.com>
Cc: linux-kernel@vger.kernel.org, lasse.collin@tukaani.org
Subject: Re: [PATCH] fix: possible memory leak in unxz()
Message-Id: <20241007185045.00d57782b2f446acc7a78215@linux-foundation.org>
In-Reply-To: <20241006072542.66442-2-t.v.s10123@gmail.com>
References: <20241006072542.66442-2-t.v.s10123@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Oct 2024 12:55:43 +0530 Vishnu Sanal T <t.v.s10123@gmail.com> wrote:

> Fixes possible memory leak in the function unxz() in
> lib/decompress_unxz.c forgets to free the pointer 'in', when
> the statement if (fill == NULL && flush == NULL) is true.
> 
> ...
>
> --- a/lib/decompress_unxz.c
> +++ b/lib/decompress_unxz.c
> @@ -343,13 +343,13 @@ STATIC int INIT unxz(unsigned char *in, long in_size,
>  			}
>  		} while (ret == XZ_OK);
>  
> -		if (must_free_in)
> -			free(in);
> -
>  		if (flush != NULL)
>  			free(b.out);
>  	}
>  
> +	if (must_free_in)
> +		free(in);
> +
>  	if (in_used != NULL)
>  		*in_used += b.in_pos;
>  

Looks correct.

must_free_in needn't exist - `in' is always non-NULL here.  And
free(NULL) is OK anwyay.


