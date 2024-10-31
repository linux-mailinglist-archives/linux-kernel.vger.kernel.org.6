Return-Path: <linux-kernel+bounces-390085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7C9B754B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9291F21516
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECE01494B2;
	Thu, 31 Oct 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkauYcsX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD34DDC1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359480; cv=none; b=h+BwntZ9yJ3c/uSpE+tA2hdMr8O28dZtRHsAqkdXQEPNm/Ns+BVr2S51sg/XkF3ljttSkKi336gx382Twp0WcH5iLy0CkyY8AgHuTU5RXjOSrZ7TiX+LbMFegvj0O0eUO5XT22ptSFRo+x7Dp/klQfyZL/tuJ+9bI5rmIhZ76hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359480; c=relaxed/simple;
	bh=1yFPby2pmWFYoqq00f9vK7djsqvzT3AMVgkFNLxoiL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml+e3i6rBYiwdQk9G78EJPajIK3d6b8ACUwqas14qRX15zxJDUxGiLNDd/j628DBoIsbx+s+923GG6HijykjRoGY5Zhu+4b+eIB817kvotaICX9h6UCs14SmWxCWrnfVL/Ij0B5eOkWNUPRugoxx82QtwdD6oZBrjdAq8jJcnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkauYcsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E1FC4CEC3;
	Thu, 31 Oct 2024 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730359480;
	bh=1yFPby2pmWFYoqq00f9vK7djsqvzT3AMVgkFNLxoiL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nkauYcsXcckISp551JdG8Vy7Wfu0wcHlN4p6unV7FCDHM4kRonczt8reVLEYWc554
	 6aj9pdGqxODtUWiqk/JqfpfETj+OlTU1cVPYu3B6l17xLFHi+PEKbvdYYXNnB06mI1
	 tOaxEeHpHswO0VsgyNO+yfJfLTJAWe8pf5LmD7HQepVQdvLb6B+EXk+bQdOU2iXx86
	 e1bT1PCdCOc6j8M7/RFK33u/jJcPHV0fb+e+f5LwBDj48LV6MlIi0U6eFdztExolJg
	 biCa/Y/K8C96IIZ9MvfDOMi3Rp6rw0fuafA+A3YdOpe9NhhxM9RssBwjmaZuU6WFX5
	 vfu7J1kemzr5A==
Message-ID: <8418b91e-04bb-4b74-96dd-a9489fbf9ba6@kernel.org>
Date: Thu, 31 Oct 2024 08:24:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/events/page_ref: add page info to page_ref trace
 event
To: Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org
Cc: minchan@kernel.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241031024222.505844-1-quic_yingangl@quicinc.com>
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20241031024222.505844-1-quic_yingangl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 03:42, Kassey Li wrote:
> This followed
> commit 53d884a6675b ("mm, tracing: unify PFN format strings")
> to add page info.
> 
> In many kernel code we are talking with page other than pfn,
> here we added page algin with pfn.

How exactly would this help you, what are you doing with the trace?

> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  include/trace/events/page_ref.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
> index fe33a255b7d0..76df13b2a5b3 100644
> --- a/include/trace/events/page_ref.h
> +++ b/include/trace/events/page_ref.h
> @@ -18,6 +18,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned long, pfn)
> +		__field(const struct page *, page)
>  		__field(unsigned long, flags)
>  		__field(int, count)
>  		__field(int, mapcount)
> @@ -28,6 +29,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  
>  	TP_fast_assign(
>  		__entry->pfn = page_to_pfn(page);

pfn is derived from the page, but not subject to KASLR, so in that sense is
better.
If you need to correlate the trace with some other data you obtained that
does contains page pointers, you will have to postprocess the trace with a
pfn_to_page() step, which is rather simple (but you'll need to obtain and
supply the randomized base) or have that other data source give you pfn too.

The tracepoints should not reveal the randomized base as trivially as they
would do after this patch.

> +		__entry->page = page;
>  		__entry->flags = page->flags;
>  		__entry->count = page_ref_count(page);
>  		__entry->mapcount = atomic_read(&page->_mapcount);
> @@ -36,8 +38,9 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  		__entry->val = v;
>  	),
>  
> -	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
> +	TP_printk("pfn=0x%lx page=%p flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
>  		__entry->pfn,
> +		__entry->page,
>  		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
>  		__entry->count,
>  		__entry->mapcount, __entry->mapping, __entry->mt,
> @@ -66,6 +69,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned long, pfn)
> +		__field(const struct page *, page)
>  		__field(unsigned long, flags)
>  		__field(int, count)
>  		__field(int, mapcount)
> @@ -77,6 +81,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  
>  	TP_fast_assign(
>  		__entry->pfn = page_to_pfn(page);
> +		__entry->page = page;
>  		__entry->flags = page->flags;
>  		__entry->count = page_ref_count(page);
>  		__entry->mapcount = atomic_read(&page->_mapcount);
> @@ -86,8 +91,9 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  		__entry->ret = ret;
>  	),
>  
> -	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
> +	TP_printk("pfn=0x%lx page=%p flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
>  		__entry->pfn,
> +		__entry->page,
>  		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
>  		__entry->count,
>  		__entry->mapcount, __entry->mapping, __entry->mt,


