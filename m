Return-Path: <linux-kernel+bounces-263056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C37993D06E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C661F21DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F7D13A240;
	Fri, 26 Jul 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKXMwW1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F61A286
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986312; cv=none; b=VUE2kdOPUk94i9pdz/PgyN1a9YAfhk+QoarYyjVNUHTva6s/F5Q2gRqrWXJfFXtprFn2v5E+oXvWv2M7bQGFxeOLznr/3MmjSYAwEl8js1e6UCg41/dmkUUhDUnepd6pYQQAu78ordwrtEi1+yCRI+QT1z/Ah4qpExIwj/RE27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986312; c=relaxed/simple;
	bh=DyyfWVP+jvOPvJ5UL+eN4ml7QO4ogAQEdtVCKR81Ad4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp7lUkocI+7tMOm8Yw8zEeOpLphoxBg1ZUOhsLuxGTcT/gq8+pa9BRrAV1tqL5yu9LOzNaCJ13/Ys6SMf4wkg0hx0nxB0da9C6NZlEZC6fhfPwuyBHW4JaMhWSS536V5vYNh1v6FqNcVXsuYowHHuLXTrcUmAQZcwYqRUOX+bl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKXMwW1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DCC32782;
	Fri, 26 Jul 2024 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721986311;
	bh=DyyfWVP+jvOPvJ5UL+eN4ml7QO4ogAQEdtVCKR81Ad4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JKXMwW1WtoNuNCclrwA6G3JfSvMZGpjk++gvU6Uy5ljjKn/Ri2S7z2acJCQQLh9fT
	 h0etuejY7FN+bP9eU8SnFfopXcNGMnx4jSVp7JLgPNZgGtO9vX3SfijwpczyCb9DLc
	 GNMgvdz34OkurtYAbS9mDKouDktvMLoyjMkBhIfX43bQEpCY31riCIpvdZ3MiWC2Cx
	 Wu6g8TfYx4+juQQGaaS+6xdf6gvaaE4SYv1OfrMjwKKmulKqhy7RSPMcEWqaKvhwXq
	 GjP+38mPnQC9VIVOoZbIsuXo5aNMLBq+GGiOMtgoGHm3sRI9i0SXNzA2AmLFawlWm4
	 QpCGJgEsiKiLQ==
Message-ID: <a6a65d06-2472-4f8d-a5de-8dcd66cea203@kernel.org>
Date: Fri, 26 Jul 2024 11:31:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: (k)vrealloc: document concurrency restrictions
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>, akpm@linux-foundation.org,
 urezki@gmail.com, hch@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240725125442.4957-1-dakr@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240725125442.4957-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/24 2:54 PM, Danilo Krummrich wrote:
> Document that concurrent calls to vrealloc() with itself or vfree() for
> the same memory allocation are not permitted, since it leads to undefined
> behavior.
> 
> Consequently, the same applies for kvrealloc(), hence also document it
> for kvrealloc().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Huh, did anyone ever assume otherwise and why?

> ---
>  mm/util.c    | 3 +++
>  mm/vmalloc.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 0ff5898cc6de..29ae93f6344f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -732,6 +732,9 @@ EXPORT_SYMBOL(kvfree_sensitive);
>   * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
>   * and @p is not a %NULL pointer, the object pointed to is freed.
>   *
> + * This function must not be called concurrently with itself or kvfree() for the
> + * same memory allocation.
> + *
>   * Return: pointer to the allocated memory or %NULL in case of error
>   */
>  void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index caf032f0bd69..2a6d4ce57b73 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4049,6 +4049,9 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
>   * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
>   * @p is not a %NULL pointer, the object pointed to is freed.
>   *
> + * This function must not be called concurrently with itself or vfree() for the
> + * same memory allocation.
> + *
>   * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
>   *         failure
>   */
> 
> base-commit: d270beaca6818349b2aed7e6034b800a777087cc


