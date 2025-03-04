Return-Path: <linux-kernel+bounces-543732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C2A4D91B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DEF7A3202
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4461FCFFE;
	Tue,  4 Mar 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtNulAOm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30B1FCFD2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081625; cv=none; b=qbVEUOIFyAHCLQB2DgKkAwLDTXTzG52OXqtIAW15fsvC1rhaEaeGXvf+TvOJjQkJpmnLpUHPtkuGitxzFbo0mYPX131QLnEdlOE3zvrbz/Kxk9scgy2PIucIJZ6S90sxmIRo/SxY5FA25O4w3a3opyCbXTStN8Kk+mSMD93Lwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081625; c=relaxed/simple;
	bh=0wXdinaXSN5qy0jF6IaPQC041JouYwi+t9tdAPeFE60=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbstBAtz0enXVeJrq63ssQW5NdTLoj9ad4YAdGMlBr4v7o3yyUI/rrvNDcZEP+PGLwRc+pwmwmEhonpxeMg/PlIoz4MKc9ii410mVrKzhwXCBRus7CmfWc2TETQMFT4zWZrS+wvjk4IOQBxbwwFAki01mquxAXgUPpxr6ZkDp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtNulAOm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5494bc4d796so4824742e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741081618; x=1741686418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDostDuCz+69r2wOSDeI1fXNvVPWdirSCV/X9dfMlRE=;
        b=jtNulAOm4OkicJuvMBovIQ6dUwezBPzo0RkLUT/Zf8rZEkQSXyatDMv/rCWuFT3qTs
         gcby2AaFIXSxF5+ipzWxrKYUd+AOAu7cLZhnb0I4Brmka2zkzBjU4SaSEai5MYbOfO8j
         85mdLp4nmaHy9XhNFJ87x6Tv4tH20ZhxZZGLySx6fUWI8BrMVv1bkKkt+0bq4M/x9pYi
         dopuepHlV+/HgPwK7OqZc7p/WZhCfLMC3XiR8u42NkX04IzPbFsW81Gu1a8eD83/SQJi
         ZhNslAouxu9j/vS10D/FhuDM0aWazBJcS7VQT4lpmZaRoqtG//M4z1/P+Fbgl1MHbM/Z
         /Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081618; x=1741686418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDostDuCz+69r2wOSDeI1fXNvVPWdirSCV/X9dfMlRE=;
        b=OUVG27AfCCVG7og+D7s6vy8cyiCbpxKdpl56961gZgxluI7Tg0JBYvBRIm88xs81P/
         hFxOg6GNYXJ+NCzY0LKua7y2tAe5lRSo+zuNVTrQnGwE4lus7r9G0QnOhMThzHAiIywr
         u2ebLMpO1rhKqnvLvJeVXMlXYosQEvzJpVdnakR6RYMj9+XznAMiCLMFvNk9zgYdTlkJ
         N5HNOFjHcIPq8kqci6woXXJImhnmXJWl9ucLtjt3B3UR4beQlUIq1LUf0WP/rjTk0jLK
         Qb9txB97O9jyYJ52WCIG2hwVeU92wQ7j/k8s+2GHEvnVTiZ7YwdDqHgpYeTU7D6MvlCX
         r1kw==
X-Forwarded-Encrypted: i=1; AJvYcCVYp0RAx+AkjiJeG7lqJA6N5o81CqC2aRGjZWg2kwlTkW8FlJJKApQ7AVKIw8oCrFDGun3N5xxRQTEl0g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgb5VuS5+6aej5fh00m8L1UIueXoIPqktxPTXggeY7atGMw3K
	Blj8Plqw+B+MyqfxpYoxkej27KJbpI93gn3tFZIPyOF7GkEgR2z5
X-Gm-Gg: ASbGnctBvY+eKBtNgI2bYwfwl5TGzKTCmpXULQFSY3/vlZyJGag8jgGAX17kAcePo4z
	ateu5vA0lm6gO18/fSnjh4Cy0OarID+rqzT1+9mhfUIInadY+PHxv3A+5edle4PTjAwIQtVuRd6
	qMI94qTtJVVFr6xKtkrEDefw1s0fP7XcmgfiM/1bJDWn3zm2L3lVcMdFyq4Z2LKEJAqB5BusAoi
	0x7kHh9iX4pDMjaHuPk38yUW5ydoH8PpoEQHkwvwaYxcTHuSSsH/6jVapwcMQwwV9SbuYumyAUu
	d6xRDmVpX9Y=
X-Google-Smtp-Source: AGHT+IGfzQnZ26ydI/Hp3PtQZN4UXtI5pke9feZjOxzsb0bBFWh1zSD7cQWbLYhGYm4LdjPoaqrnvg==
X-Received: by 2002:a05:6512:6c9:b0:545:ee3:f3c5 with SMTP id 2adb3069b0e04-5494c32008amr6366824e87.17.1741081617269;
        Tue, 04 Mar 2025 01:46:57 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549570fc8fbsm1129701e87.80.2025.03.04.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:46:56 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 4 Mar 2025 10:46:54 +0100
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Move free_vm_area(area) from the
 __vmalloc_area_node function to the __vmalloc_node_range_noprof function
Message-ID: <Z8bMDi1TIlCaec2X@pc636>
References: <20250303015702.319416-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303015702.319416-1-liuye@kylinos.cn>

On Mon, Mar 03, 2025 at 09:57:02AM +0800, Liu Ye wrote:
> Moved free_vm_area from the __vmalloc_area_node function to the
> __vmalloc_node_range_noprof function so that allocation and freeing
> of the area can be paired in one function for better readability.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  mm/vmalloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a6e7acebe9ad..dc658d4af181 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3651,7 +3651,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
> -		free_vm_area(area);
>  		return NULL;
>  	}
>  
> @@ -3844,8 +3843,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  
>  	/* Allocate physical pages and map them into vmalloc space. */
>  	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> -	if (!ret)
> +	if (!ret) {
> +		free_vm_area(area);
>  		goto fail;
> +	}
>  
>  	/*
>  	 * Mark the pages as accessible, now that they are mapped.
> -- 
> 2.25.1
> 
This one looks good to me:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

