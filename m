Return-Path: <linux-kernel+bounces-195845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA118D52B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA872846E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9476142913;
	Thu, 30 May 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="If/Yt85F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D11433CA
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099115; cv=none; b=fTP0kCTkVO245jUv/sw7lGM9rMFrsSuEtUKvG3m/jUTm5YFIq/K4ETW9vICnxlUmruYpqVmN8TeiMoDEb1kfpG6UobtLn+myhzBOfOr3xZMQln6CaID4t8PW/NRA/nuG8AIHiFoqpvxEyVHlDSXcrN95CG+/QS6QJWPdnytj73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099115; c=relaxed/simple;
	bh=QQhN3fBeDsJ4TwxAMRYmU9fsJQ0uQBGkrfT06jVyz5o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X0Dbhf150xsQ9jwgEI5TPCXE9Doh0hg8fg/CG2f5YI/tocw1zF6PWLptyRdhAeDxEmpmQoWKu8oMoVQ8FK/zWdjAdkuNuZHnA94pikm9HmZvRT9ROSIlYCEqeqyqoqllctlyvkqXf12iUI/ojdZV7NDhK1aN3mi401GBMKUWO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=If/Yt85F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9ECC2BBFC;
	Thu, 30 May 2024 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717099114;
	bh=QQhN3fBeDsJ4TwxAMRYmU9fsJQ0uQBGkrfT06jVyz5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=If/Yt85FbL+jFdwt1w/gf/EevPCse9Y3igXw2uHHogWsSGRxEKO4vXk9UF5qKAsin
	 CM27YDG+5zkC3k9/bXmaXHmwma0bmMZLZEVlcVrPLt37lPjIAAXZKbjarwyxzTooXI
	 UVmZahKLlVewfvFCfLjNuH+RSmgffQ7Hd9CtXElM=
Date: Thu, 30 May 2024 12:58:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
Message-Id: <20240530125833.fd5315f80316436e93f91dfb@linux-foundation.org>
In-Reply-To: <20240530102126.357438-2-usamaarif642@gmail.com>
References: <20240530102126.357438-1-usamaarif642@gmail.com>
	<20240530102126.357438-2-usamaarif642@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 11:19:07 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).

A little nitlet as you'll be altering the code...

> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,77 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>  	goto out;
>  }
>  
> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +	unsigned long *page;
> +	unsigned int pos;
> +	bool ret = false;
> +
> +	page = kmap_local_folio(folio, i * PAGE_SIZE);

It's rather expected that a local variable called `page' has type
`struct page *'.  Can we use something like `addr' here?

> +	for (pos = 0; pos < PAGE_SIZE / sizeof(*page); pos++) {
> +		if (page[pos] != 0)
> +			goto out;
> +	}
> +	ret = true;
> +out:
> +	kunmap_local(page);
> +	return ret;
> +}


