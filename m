Return-Path: <linux-kernel+bounces-333375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F185297C791
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA771C2754B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25119EED8;
	Thu, 19 Sep 2024 09:50:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430D19EEA5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739421; cv=none; b=X/B25rAW9ksoJF5HuY1PPcLWdSKpiKvTS4xtvqwt6IkkNFJXI8qDqOQRNZRCpwvwhXakd2e+hg1wEK7FvkyXVZmfqT2NIYSSAzF4DHcwpg9lXeZMoUWyhIqoewYuVklSYhywGkg+eoeEVtEL5YaGI9fFe5TllhYlh6sk9ixl9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739421; c=relaxed/simple;
	bh=4PWFZAFg5x6eIpJFxmUF4O8cy9Ps9tqEx/7EtrVvLUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J27mxTzQWj21ORbOx9cWR2IJPyxj2KadozIwbrErmabRHpFIGwScXYmQINHOcLzI7XrZHQADEx+6JM+NxvZ7PfKaxhylcM0/cGSCiRNO6ry+SKExEZlOeJXtMWZk7UodTz/q+vK2ZW0/Hd91ru7aN0ESBa+72ufeyR+BAzb7QJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92DC01007;
	Thu, 19 Sep 2024 02:50:44 -0700 (PDT)
Received: from [10.163.34.169] (unknown [10.163.34.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EB303F64C;
	Thu, 19 Sep 2024 02:50:12 -0700 (PDT)
Message-ID: <069fea6a-3c14-49c8-b9d6-72b49616ff2e@arm.com>
Date: Thu, 19 Sep 2024 15:20:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Add some comments for specific scenarios
 to make it easier to understand why unmovable and reclaimable allocations can
 steal from moveable pageblocks by default.
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20240918045836.10825-1-gxxa03070307@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240918045836.10825-1-gxxa03070307@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The subject line is too big.

On 9/18/24 10:28, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>

Also there is no commit message here as well.

Please do follow the instructions for submitting patches as explained
in the documentation below and then resend the patch.

https://www.kernel.org/doc/html/v6.11/process/submitting-patches.html

> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>  mm/page_alloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 91ace8ca97e2..cc8a7a0772cb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1818,6 +1818,13 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
>  	if (order >= pageblock_order)
>  		return true;
>  
> +	/*
> +	 * The reasons why unmovable and reclaimable allocations can steal from
> +	 * moveable pageblocks by default aside from the above comments, a different
> +	 * and better understood scenario is: System initializations are all movable
> +	 * pageblocks. If you want to alloc unmovable and reclaimable pages,
> +	 * you have to steal from moveable pageblocks or it may fail.
> +	 */

Although there are sufficient comments for this particular function, it
does seem like this new comment tries to explain why using unmovable and
reclaimable migrate types as steal fallback makes sense. But this can use
some clean up and rewriting.

>  	if (order >= pageblock_order / 2 ||
>  		start_mt == MIGRATE_RECLAIMABLE ||
>  		start_mt == MIGRATE_UNMOVABLE ||

