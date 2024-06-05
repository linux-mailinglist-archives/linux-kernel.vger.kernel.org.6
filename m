Return-Path: <linux-kernel+bounces-202166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A088FC898
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266B81C21308
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997918FDCB;
	Wed,  5 Jun 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWQoFThp"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FC18FC6B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581865; cv=none; b=g8X7tcp5JOUsVrUqMzPTupoQWQPAXRfgRiJdwEn/RNkOKWqSvRCAGneUXRr7jy3Plna2R7nP74DBkhKCziQ1NYchhuo405z5u/TV/A6tsdDLXH8bz4KOKhbvtSZUcFLa3VGmGFkumGJTiHhBsKOerH4DchJaPoJ7z/lY0V0HcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581865; c=relaxed/simple;
	bh=V9afjXCLv74rpExL0uuplo9YHWRRfoe+FmZhXnu1o6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l+pVf2zoda3O6gofi5WOtjRZlmMVAVUDNN9Hsgkv+AhmPGeuFrWb2dSUhA9iPCQw/tjq/4gfHxJikdFyw8e231L0anHgKPNY4geUu/3B7o5HG2gRfmatPIVhG/FOITBffyChKgAQrdYzmexj07uZT0YehC++i5ycP2AfZ5R/CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWQoFThp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7025b253f64so3012528b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717581864; x=1718186664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7d1eUTZNGszW0x+tHAtEsjGhoVVhsH2xVEU1kXMK+U=;
        b=IWQoFThp8bqTClX1WVd034013a1L1N8GAwj9ekjkcimEJ5Bw54fu5xOoohZxXrsxwO
         aj31O/0b/QelBt41NY5GD6a7SlK08qsJFks345V5a294A2E1NAmYmEnwZOwMC2R+Fim+
         HqImK/yfSBp+dYpjt48hrwxxJUxeT7GeqPu1qhDMjszdf6aTviHfYRuiZxC8LzhOFhtW
         bQYkc+egb23XlfchoTIPilQLQ/D8jbUndjdoz5LXpPoOO0H+hnwaOacIs1xf9MrD6NuU
         14YIKiWnZBT+A9KGZbB+3CoihEvmr34tFs/sJb9f8FZvTAJTqD2OTB5owv/zkGDUAb0w
         VT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581864; x=1718186664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7d1eUTZNGszW0x+tHAtEsjGhoVVhsH2xVEU1kXMK+U=;
        b=vo1awRV9sc8d2wYPCSymFmH11aSQ/k69pJ82Tx3LFgAvDOkTQwv30rKwswAqb+rKNF
         F6gtxyQLvukB6hyLN5i5iUx6qrGo91txssSiZK7KAs0u1AyOXNgE9F2iLb0aTPcFMM+H
         /i1k23gMJW0pLXIfzfhYvVt4nXe9c+tKgYVNGYPfcE/QjOuaaAJIePYFPjQoFnOl3qw2
         oZ4SsGsukierMb6eaKrfRJa12K2rnhLRUG+cpOE6hgxjD/G/iHyCsK8JMYfdcYKOIQ7w
         xyJrsck+LgOPXaCvrvDOTEwF7fkAHiMvMVU23zLW7JL9GW5axn2X+nRnC1/lUMMdfkeK
         fdZg==
X-Forwarded-Encrypted: i=1; AJvYcCXLM4b9ArRmKNVLoqlNlcQ5bgiyLTe5hQEd5VQtEx7IFCI6FWbO3KvdhTwCaDcH2Cayp8z4YEymUEfSvcaUz/Sfgmwm4pSw/sA6Tx+M
X-Gm-Message-State: AOJu0Yw6BYFR9OxDQrxH1C+AvvNW3TkKTg/jg5Jpb4iIHwayLLTC+8bc
	bA8VWx5H/iSlhvZmQIVgy9DjMVw+6Pgf4QFCBb4pP/eNpX7c+Nqb
X-Google-Smtp-Source: AGHT+IGp7FyIzGZzB11PGFyatr+hn2MrYKFTbfkP7NCUaxvU4h42qPcX6DbM3UWRssnBa1+faOY7MA==
X-Received: by 2002:a05:6a00:1146:b0:6f3:ea67:48c3 with SMTP id d2e1a72fcca58-703e56d308amr2242920b3a.0.1717581863510;
        Wed, 05 Jun 2024 03:04:23 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae6b7esm8296082b3a.113.2024.06.05.03.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 03:04:23 -0700 (PDT)
Message-ID: <a1ba41f1-ecff-4790-b85a-ce5dc8077b91@gmail.com>
Date: Wed, 5 Jun 2024 18:04:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] mm/ksm: move flush_anon_page before checksum
 calculation
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com, david@redhat.com
References: <20240605095304.66389-1-alexs@kernel.org>
 <20240605095304.66389-3-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240605095304.66389-3-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let me withdraw this patch, the flush_anon_page come with the first patchset of ksm, and no explanation for them.
Though, no any guarantee for concurrent page write for the flush, but anyway I give up on the flush optimize.

Sorry for disturber.

Alex

On 6/5/24 5:53 PM, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> commit 6020dff09252 ("[ARM] Resolve fuse and direct-IO failures due to missing cache flushes")
> explain that the aim of flush_anon_page() is to keep the cache and memory
> content synced. Also as David Hildenbrand pointed, flush page without
> the page contents reading here is meaningless, so let's move the flush action
> just before page contents reading, like calc_checksum(), not
> just find a page, flush it, w/o clear purpose. This should save some flush
> actions why keep page content safely synced.
> 
> BTW, write_protect_page() do another type flush actions before pages_identical().
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---
>  mm/ksm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index ef335ee508d3..77e8c1ded9bb 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -784,10 +784,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
>  		goto out;
>  	if (is_zone_device_page(page))
>  		goto out_putpage;
> -	if (PageAnon(page)) {
> -		flush_anon_page(vma, page, addr);
> -		flush_dcache_page(page);
> -	} else {
> +	if (!PageAnon(page)) {
>  out_putpage:
>  		put_page(page);
>  out:
> @@ -2378,7 +2375,12 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>  		mmap_read_unlock(mm);
>  		return;
>  	}
> +
> +	/* flush page contents before calculate checksum */
> +	flush_anon_page(vma, page, rmap_item->address);
> +	flush_dcache_page(page);
>  	checksum = calc_checksum(page);
> +
>  	if (rmap_item->oldchecksum != checksum) {
>  		rmap_item->oldchecksum = checksum;
>  		mmap_read_unlock(mm);
> @@ -2662,8 +2664,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  			if (is_zone_device_page(*page))
>  				goto next_page;
>  			if (PageAnon(*page)) {
> -				flush_anon_page(vma, *page, ksm_scan.address);
> -				flush_dcache_page(*page);
>  				rmap_item = get_next_rmap_item(mm_slot,
>  					ksm_scan.rmap_list, ksm_scan.address);
>  				if (rmap_item) {

