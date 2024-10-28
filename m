Return-Path: <linux-kernel+bounces-385538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D19B3854
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F8B280E81
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5581DF276;
	Mon, 28 Oct 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8Ceep6D"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066221106
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138179; cv=none; b=CAiJYbZlFjbTAyz5cy2bC2NcrbYbAsr6ZDkyW+lShfYLsqNQ2vSMrDFKVTanDNX4JEv61l6FhdCpVey1q4YLKm2lMf7XFYKPRceRSeLY+kF6WLdhCni9h9U+3BK9ZvLYMe+urDillDVC1YxUNwRjNnpay8IWsibKMSu/UGSShIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138179; c=relaxed/simple;
	bh=vHEOi2MgqTMeHB5VDkbC9NoXATmwDOnSSDR+Z3vwvLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm9ABLcKUQJB2FqYFE/5BKoAycpnozA3lSu9+MGg9dnND+9QR1EV+B0tZsrY8t4BkS/YJvoO5N0iRKc4pzYCyHkeeXNhu4PIGdHK/XHDrr/VwYYVDl9bGAU/+byChu3o4RElUHt9zYOd0+V6Lr8Cj743W6tZzEk4y508No78ND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8Ceep6D; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460b295b9eeso21061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730138177; x=1730742977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnKKC7ZBiOZ4MaVku4luTtadUC5Qtw20FPB6RQmwk+M=;
        b=t8Ceep6DrmMtMuznS7DxLb0OucCOHeZZ9sYFdQ6YZzFMRref+W9CcX88BtR1fRhW14
         oq5WWVyj5LDxpu22pMHep+vagXKA3BsKT4bm4RqTVRdO8nyCD4vusSxER+Z4+fdjoil6
         1QXRc/kjFLFrGPnJJkZo+RCo51wIR96DIY3nFjqCg5DkrG+CRUDb8Wkpr6f5/lfynzXg
         1fvsw4IktvWcCLULWrZ5oDpcBIppw5v/rzY4kBJHQd504XMYFmhi2lfhq2X11y8G+ARM
         5OCVyhGx++b03YQ9SC/UPlT2z8gkG/o1/R4Uy6UEoWHCy0axzfCJY/OtM2kOgkLQGtC1
         eDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138177; x=1730742977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnKKC7ZBiOZ4MaVku4luTtadUC5Qtw20FPB6RQmwk+M=;
        b=MMNXnJC/5AJmGuG4ekP3GSy74rb384zHT3B/bHfF4QlkIDXh17z9OzKoWyrZw1IwXg
         JkVD1x3nSzj6reE40woox8DwPHXQzWmo/KQ3cpeq/rJfflRL2Zw5WJTvczT+EzR3yr+7
         uavoflCg0dQP10TI8TfPaDT9AvMuNAefxDrrA0ydBk9qvaAj5s9sSLFoRS6jam5dPXIF
         30aGodSb4gh5gLFhD+ri+L6L/ItbidDzf7yJ6E56KVK8cz1e+OfQpQiQV7ocvylSzZdf
         PSu5u74HGMduJdhjvpWuvoBxUgTbTffX1uM5Cdvupn9zQzJeQyfOyaZ2VtyRJ4kZHsRD
         9xtg==
X-Forwarded-Encrypted: i=1; AJvYcCXVcR+XmEBazQVSvBvhHgvZhIelflDv20G0Jf/B8ClWUP4zTabzZxOcF3MRCAtz4qL4bRvoNOeuyVRX7IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKZ/nwALw7CvnUsKTW8DJhlnWGWWeErh3rZ2c455FwNHXYv6x
	RLBH8/XNvPjaTRAViCmypoM/i7VCTU/SWuSjvUp/pTgx8tfk5GUW4hP/k7xODl61FB7jxFJV9OT
	hzg==
X-Google-Smtp-Source: AGHT+IGbhI30etVGnBK74XRZbS4Hz/tVdWgx+1HvmeJb5XlH6m369kXE/tjUz5i3yf+Hn5aOBSARog==
X-Received: by 2002:ac8:7d04:0:b0:45f:997:4e5a with SMTP id d75a77b69052e-46165141734mr61651cf.11.1730138176504;
        Mon, 28 Oct 2024 10:56:16 -0700 (PDT)
Received: from google.com (204.246.236.35.bc.googleusercontent.com. [35.236.246.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a4840sm36781651cf.86.2024.10.28.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:56:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:56:09 -0400
From: Brian Geffon <bgeffon@google.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] zram: clear IDLE flag after recompression
Message-ID: <Zx_QOW79R5m6mg21@google.com>
References: <20241028153629.1479791-1-senozhatsky@chromium.org>
 <20241028153629.1479791-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028153629.1479791-2-senozhatsky@chromium.org>

On Tue, Oct 29, 2024 at 12:36:14AM +0900, Sergey Senozhatsky wrote:
> Recompression should clear ZRAM_IDLE flag on the entries
> it has accessed, because otherwise some entries, specifically
> those for which recompression has failed, become immediate
> candidate entries for another post-processing (e.g. writeback).
> 
> Consider the following case:
> - recompression marks entries IDLE every 4 hours and attempts
>   to recompress them
> - some entries are incompressible, so we keep them intact and
>   hence preserve IDLE flag
> - writeback marks entries IDLE every 8 hours and writebacks
>   IDLE entries, however we have IDLE entries left from
>   recompression, so writeback prematurely writebacks those
>   entries.
> 
> The bug was reported by Shin Kawamura.
Reported-by: Shin Kawamura <kawasin@google.com>

> 
> Fixes: 84b33bf78889 ("zram: introduce recompress sysfs knob")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index e6d12e81241d..a16dbffcdca3 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1864,6 +1864,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * We touched this entry so mark it as non-IDLE. This makes sure that
> +	 * we don't preserve IDLE flag and don't incorrectly pick this entry
> +	 * for different post-processing type (e.g. writeback).
> +	 */
> +	zram_clear_flag(zram, index, ZRAM_IDLE);
> +
>  	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
>  	/*
>  	 * Iterate the secondary comp algorithms list (in order of priority)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

