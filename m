Return-Path: <linux-kernel+bounces-223475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3851D911397
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1A32848C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0C762C9;
	Thu, 20 Jun 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZXLIHFfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F7482ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916473; cv=none; b=TmH7rDPp5GaXRW9oatu8dVWq4zC9PRecgvBS+z1uEU00CSn8lRAES/vTLbjBweiT3dAjQTHcJY1EllTlJqQtyO8yTTv5RiiO/HRRRj+URCxFzbSkR/mGc86JHbmYohyjOpuk+ZnrYc3CGkxAzH6D233g+nVo/z168OxNT6I9Br8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916473; c=relaxed/simple;
	bh=DaQWszFMeA6fJDrTZjgKRrC144b6pN3rrn1BQKHmRGE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lU3QbBFu8kseiL+rQqV2e8cILG3C/pLVI9Gt9FvaI3WI37QiQfWMxSKW9EMUnDCvKqO0J/1nerjA/TrTrD7hFLOPkEcxL69W7QLrrLLsJyUyhtHANXCjVpq97jSzlkQeKG6oV91rQ7XVv/LdLG93OPDW5zz7i4DxEy4XNP+tp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZXLIHFfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B72C2BD10;
	Thu, 20 Jun 2024 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718916472;
	bh=DaQWszFMeA6fJDrTZjgKRrC144b6pN3rrn1BQKHmRGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXLIHFfjsGkKlIWhxGLAy97DeLTi+aoFu9X8dNC7PdIeLqcdMZmFMg+OMwk74ZnQx
	 GvhOaojm8Zy/6+fZzgcL5TWgQmZ8Ke0h4lqgcy785mA7QT+kZD+DZKtst1q7F4VenU
	 Y1R4VsGKNnyBsr9ANiWudxdx9gpp6WYCmklBeHe4=
Date: Thu, 20 Jun 2024 13:47:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sung-hun Kim <sfoon.kim@samsung.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 sungguk.na@samsung.com, sw0312.kim@samsung.com, sebuns@gmail.com, Stefan
 Roesch <shr@devkernel.io>
Subject: Re: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
Message-Id: <20240620134752.9a63c12403282c0c7e728764@linux-foundation.org>
In-Reply-To: <20240620043914.249768-1-sfoon.kim@samsung.com>
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
	<20240620043914.249768-1-sfoon.kim@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 13:39:14 +0900 Sung-hun Kim <sfoon.kim@samsung.com> wrote:

> The current version of KSM does not take into account the number of
> used ksm_mm_slot. Therefore, when users want to obtain profits of
> KSM, KSM omits the memory used for allocating ksm_mm_slots.
> 
> This patch introduces a new variable to keep track of the number of
> allocated ksm_mm_slots. By doing so, KSM will be able to provide a
> more accurate number of the gains made.
> 

By how much does the improve the accuracy?  In other words, how much
difference does this make?

> @@ -3672,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
>  	long general_profit;
>  
>  	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
> -				ksm_rmap_items * sizeof(struct ksm_rmap_item);
> +				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> +				atomic_long_read(&ksm_mm_slots) * sizeof(struct ksm_mm_slot);
>  
>  	return sysfs_emit(buf, "%ld\n", general_profit);

This assumes perfect slab packing, no?   Should it use ksize()?

