Return-Path: <linux-kernel+bounces-523924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3316A3DCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DA2179119
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AEB1FBCB6;
	Thu, 20 Feb 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rbb0QVZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2328EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061938; cv=none; b=lh4EXDyIUW7BsVUi1vtrVodOYCgarbcbV54DuLPrh79afde98BYHeVy7NXWXTySUu+rVyj8zHIC7LSUWfH4c8Hs48RGIPNf3LFq/pO5JOujLKqZcpWu2EEFor0XwNv24IJMKADQ003yy614iYVNcby2rV1J3JkT6yCcQ9nB0XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061938; c=relaxed/simple;
	bh=zUcbLKcTSKCJaz5KXdrUt3hXq8CZzVxPsUr2Ja6qF0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd2GnFOI2KJsCqFLqC0J/f8vN0xXReNxtyXU/0F7+uJA7NP8ktV9XQxGziNV7LikqFxhWzqP37+Rs8GO9d3VTr7l9xz+wTNHC2S1t8+1B1jFcm14xTueTKjwKxlulvmhdSQ8Ecuh9D8XmucWgD1svkc6R4skNRgDJtkfONU8w5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rbb0QVZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BB8C4CEDD;
	Thu, 20 Feb 2025 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740061938;
	bh=zUcbLKcTSKCJaz5KXdrUt3hXq8CZzVxPsUr2Ja6qF0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rbb0QVZNGmtW07YPOIsx8mqNuWQ0fJkkpZlTR6WoVZsqZayzi/w6m7aqfGYP1+XL6
	 BGcmGO2PAv8zkX88kGqVjZ235L+GYucBLWedyrs4GJFuwJF6ALsJ8YcdjSY+a3byxQ
	 /9oUoQuSqL+v4QhvuEJjMuqylLL1kh6bi+7A09ds=
Date: Thu, 20 Feb 2025 15:32:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 2/4] char: misc: add test cases
Message-ID: <2025022023-fragile-moonstone-3419@gregkh>
References: <20250123123249.4081674-1-cascardo@igalia.com>
 <20250123123249.4081674-3-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123123249.4081674-3-cascardo@igalia.com>

On Thu, Jan 23, 2025 at 09:32:47AM -0300, Thadeu Lima de Souza Cascardo wrote:
> Add test cases for static and dynamic minor number allocation and
> deallocation.
> 
> While at it, improve description and test suite name.
> 
> Some of the cases include:
> 
> - that static and dynamic allocation reserved the expected minors.
> 
> - that registering duplicate minors or duplicate names will fail.
> 
> - that failing to create a sysfs file (due to duplicate names) will
>   deallocate the dynamic minor correctly.
> 
> - that dynamic allocation does not allocate a minor number in the static
>   range.
> 
> - that there are no collisions when mixing dynamic and static allocations.
> 
> - that registering a static number in the dynamic range won't conflict with
>   a dynamic allocation.
> 
> This last test verifies the bug fixed by commit 6d04d2b554b1 ("misc:
> misc_minor_alloc to use ida for all dynamic/misc dynamic minors") has not
> regressed.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/misc/misc_minor_kunit.c | 515 +++++++++++++++++++++++++++++++-
>  1 file changed, 513 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/misc_minor_kunit.c b/drivers/misc/misc_minor_kunit.c
> index 293e0fb7e43e..84e13bc5c61c 100644
> --- a/drivers/misc/misc_minor_kunit.c
> +++ b/drivers/misc/misc_minor_kunit.c
> @@ -51,19 +51,530 @@ static void kunit_misc_dynamic_minor(struct kunit *test)
>  	misc_deregister(&dev_misc_dynamic_minor);
>  }
>  
> +struct miscdev_test_case {
> +	const char *str;
> +	int minor;
> +};
> +
> +static struct miscdev_test_case miscdev_test_ranges[] = {
> +	{
> +		.str = "lower static range, top",
> +		.minor = 15,

As I don't agree with the previous patch, I'll not apply this one.

How about at least just redoing this one and using the values that the
code currently allocates?

thanks,

greg k-h

