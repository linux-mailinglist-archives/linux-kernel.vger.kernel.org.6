Return-Path: <linux-kernel+bounces-253059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB6931BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05101C21508
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5613AA2A;
	Mon, 15 Jul 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0F5WUGP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55531758
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075619; cv=none; b=dbTwZR8KC46BwlzT+92cpYJEVrRXb2gniBsVZitpvVX8H5ZOC8FtNZyB/OEs14slv22k/+XR5oDRYbv9R6qXFbOd0LPPGo5E/QUtrfx1BK30+yWRGMw4tfzn+5UjliYDVak718JfhHYa0h+MPRajNP/on4P1MQItTsA/sPhRhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075619; c=relaxed/simple;
	bh=onQcMoz8GPXOo1jUzaLuZp8M4wP24ok7J1K5zp1cIP8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bt3FzK3cEn/5roGg/fm6YO1A4lArApXKJqVEoq7bN58JZcHwn0PLzVb7jk1TJnUPyiu+QWqgKIizJV/KpQ3sDz2yBJIkwiwS9rieRdKfGGMsx989PwT7XoejQKLXRp7IGfK99EXAmLfVw5r+2ErXDZzNfsuz+xK5zr17IDrTSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0F5WUGP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBA1C32782;
	Mon, 15 Jul 2024 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721075618;
	bh=onQcMoz8GPXOo1jUzaLuZp8M4wP24ok7J1K5zp1cIP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0F5WUGP4Ij7cGXKtN+/fBZEoJUt0Mjcnmfcj87/GICSMuLtKjHR5XMObazRy88V5K
	 TxYl7eSqtIra9eoJsRs5NS3B2i5Enng44alrOkW3irSif7ZTx3V6kkgZSSzuKPjd7V
	 Fs7wXboWdhOPLfTw8ZkCVFExfeZngHIhPYs40HIo=
Date: Mon, 15 Jul 2024 13:33:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
Message-Id: <20240715133338.fb8b3b9a99f05b086fc54b82@linux-foundation.org>
In-Reply-To: <20240715102806.2638849-1-linmiaohe@huawei.com>
References: <20240715102806.2638849-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 18:28:06 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When hwpoison_inject module is removed, hwpoison_filter_* parameters
> should be reset. Otherwise these parameters will have non-default values
> at next insmod time.
> 
> ...
>
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -64,9 +64,20 @@ static int hwpoison_unpoison(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
>  DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
>  
> -static void __exit pfn_inject_exit(void)
> +static inline void reset_hwpoison_filter(void)
>  {
>  	hwpoison_filter_enable = 0;
> +	hwpoison_filter_dev_major = ~0U;
> +	hwpoison_filter_dev_minor = ~0U;
> +	hwpoison_filter_flags_mask = 0;
> +	hwpoison_filter_flags_value = 0;
> +#ifdef CONFIG_MEMCG
> +	hwpoison_filter_memcg = 0;
> +#endif
> +}
> +
> +static void __exit pfn_inject_exit(void)
> +{
>  	debugfs_remove_recursive(hwpoison_dir);
>  }

The new reset_hwpoison_filter() has no callers?


