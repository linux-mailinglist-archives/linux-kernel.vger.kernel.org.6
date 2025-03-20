Return-Path: <linux-kernel+bounces-569027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD176A69DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C853B5C85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB21C07F6;
	Thu, 20 Mar 2025 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0C+IhPuX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D417991
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435167; cv=none; b=sOSnZ00UPilaqcj6P9LAh3yZDmkNGjCjy0hnNKkouNeEgLexNnvIDWejnM8f7BeK0fxvEM6r9nB6l/JfWsAFVRCG0tr0SHVI1zKscHbPqoyJ/zrRpUdxE5TunZbHJoKxAqCOOlndBgsij/23RhQ6UD4+RzMOJdZniWUHyy4tSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435167; c=relaxed/simple;
	bh=b1y8qDu41B/irlm5MHtGDB7HIhBPfkR82Mp9PRcOmgU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E+oKtLT6N53FnhDz8OJrm1ewxSOZR5m1D7n8cbCF6SH8mLPt6p4m3nFd+9/UcCL6pM8+TArAvUUXGKVD02D5uAf2+Zsbt/B++VwWtDrcTEm4M9yADnCisK8hsm4RtpRWHBD4ib4TCrTUQ/sA5m+ppgdD+uKUu1KxuMpSEIWnbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0C+IhPuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E343C4CEE4;
	Thu, 20 Mar 2025 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742435165;
	bh=b1y8qDu41B/irlm5MHtGDB7HIhBPfkR82Mp9PRcOmgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0C+IhPuXnSn9kOpf9zmvjzjLuIlKuV2nfMx6hseGc4dIZ1h5LV7sqEZlQ6XcpXaj1
	 cYb0vJK999fumf97kADTaz5CnXyNJgB7b8xqlsYM0ofkzz4b/nQUm5kABRxoI/kzyn
	 ijHpi/sT8cusGedOFppqKBqFOacL3B7si/IMsf8c=
Date: Wed, 19 Mar 2025 18:46:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: T Pratham <t-pratham@ti.com>
Cc: Jens Axboe <axboe@kernel.dk>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: scatterlist: Fix sg_split_phys to preserve
 original scatterlist offsets
Message-Id: <20250319184605.809fc9ce3b169478102b9313@linux-foundation.org>
In-Reply-To: <20250319111437.1969903-1-t-pratham@ti.com>
References: <20250319111437.1969903-1-t-pratham@ti.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 16:44:38 +0530 T Pratham <t-pratham@ti.com> wrote:

> The split_sg_phys function was incorrectly setting the offsets of all
> scatterlist entries (except the first) to 0. Only the first scatterlist
> entry's offset and length needs to be modified to account for the skip.
> Setting the rest entries' offsets to 0 could lead to incorrect data
> access.
> 
> This patch removes the offending code, ensuring that the page offsets
> in the input scatterlist are preserved in the output scatterlist.

Is this merely from code inspection, or is this issues known to have
observable runtime effects?

If the latter, please provide a complete description.

>
> ...
>
> --- a/lib/sg_split.c
> +++ b/lib/sg_split.c
> @@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
>  			if (!j) {
>  				out_sg->offset += split->skip_sg0;
>  				out_sg->length -= split->skip_sg0;
> -			} else {
> -				out_sg->offset = 0;
>  			}
>  			sg_dma_address(out_sg) = 0;
>  			sg_dma_len(out_sg) = 0;
> -- 
> 2.34.1

