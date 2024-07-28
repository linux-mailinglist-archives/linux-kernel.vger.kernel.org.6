Return-Path: <linux-kernel+bounces-264562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56F93E51A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762CAB21703
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7447A4C;
	Sun, 28 Jul 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYm1fJgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8D43AD2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170600; cv=none; b=hD7r6KGcEy/Q4fjVNe4qw5cZRRgEC5/rfXlzHm0n5bhmAvwBY6DVN+5ZkSETU95BD2cmZp3IYG9fhXUEHSG1FpliKbCD0gukAeKA6MvYa6L0fVsxHOnMx+lMdajuxvQ/S06J/SPKPTEQdpdTI0RL7hvTRp2gFZSOXJqByj5pc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170600; c=relaxed/simple;
	bh=jRdIaufBiBhrgbVPF6tPYKv5fkG3rFjTWJmC1W+1xt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbDR2nTQ2p+xcorqvf9joPO5r2IT8SwePq1pm7z+8R9npmf/kpxxmnwMbyMUaRlv3xM1DEfKS3+rZ+9VNfm8+66ZQZe0ztz9FauQ9BkQed6D92sJqae7UIzpeXhekcRl6xWjlLTCqsktaBzPlPdCmxywBBYdEz6X0aMzX3lDgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYm1fJgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C21C32782;
	Sun, 28 Jul 2024 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722170600;
	bh=jRdIaufBiBhrgbVPF6tPYKv5fkG3rFjTWJmC1W+1xt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYm1fJgxpp3l16wAf3hHdY2PMp/tTzeTwP7fDp9H5zKMbgEzqXUbdoayv9MO5h2C5
	 nJ8RPwLemSs3tGEL+MNNWSUr0IKqqzUSbjFYNENVftj/koRsijDnoEWAiyaZR58mi8
	 gwuIaH0FcNPDh+3lKnNXBhO6jx6sDd4VHD3T93D8wL+YPGdfjxtBZpTDYcjxDWldvs
	 Da8V7tEH3UEg8gq+L3BmkeVVr1ks4OjpoK4Faga8zpLQ+DGoW7UepmQ3NJIABY2tHI
	 Ki4GlTyLpCZiYH96zWNrU0u9ZHPZUt169w+4seciUde+Udt5ZWCCc/OsnozGRbKeE8
	 +qLTt4P44BviQ==
Date: Sun, 28 Jul 2024 15:43:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparse: return right away if sparsemap_buf is null
Message-ID: <ZqY81pf9dvl6mvg9@kernel.org>
References: <20240726071023.4078055-1-lsahn@wewakecorp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726071023.4078055-1-lsahn@wewakecorp.com>

On Fri, Jul 26, 2024 at 04:10:23PM +0900, Leesoo Ahn wrote:
> sparse_buffer_fini(..) takes the following actions even though the value of
> sparsemap_buf is NULL,
> 1. calculate size of sparsemap buffer (which is meaningless).
> 2. set sparsemap_buf variable to NULL (although it is already NULL).
> 
> These steps are unnecessary if the variable, sparsemap_buf is NULL.
> 
> Refactor the function to return right away if the variable is NULL.
> Hence, it doesn't need to take further actions.

sparse_buffer_fini() is called a few times on init so saving a jump (if at
all) does not worth the churn.
 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---
>  mm/sparse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index e4b830091d13..091e4bc2f72c 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -469,9 +469,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>  
>  static void __init sparse_buffer_fini(void)
>  {
> -	unsigned long size = sparsemap_buf_end - sparsemap_buf;
> +	unsigned long size;
>  
> -	if (sparsemap_buf && size > 0)
> +	if (!sparsemap_buf)
> +		return;
> +
> +	size = sparsemap_buf_end - sparsemap_buf;
> +	if (size > 0)
>  		sparse_buffer_free(size);
>  	sparsemap_buf = NULL;
>  }
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

