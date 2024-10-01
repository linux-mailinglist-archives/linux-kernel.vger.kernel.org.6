Return-Path: <linux-kernel+bounces-345404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDDE98B5EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827D0281897
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C41BD4FF;
	Tue,  1 Oct 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zIOUiZpX"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35D1BCA1E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768589; cv=none; b=LeYAdTJ/ynGFbgEBU0oPhmYqYr4PEbeQVrAUYtTwhCNrlL3yhMxwMyWGPx4nBUk/oh9GOCc/rKCqZz24ii3fzTm7sVtrKFCp2/V8OF886XzpBnmokDyd7e8awrzpaaZli4NEXpk6UKoIQtnLfeWdTW/5n/cKcxLBqwAcN5yImeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768589; c=relaxed/simple;
	bh=YGPeFUyeBZ+HB3QEMeuldGJYuDh/jJ6q36UqTR8ZGtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdRbuYjosuX20SheRzjzRb/RoYY1EFJxdAtJdCe/B8F/M3cwpqnQm0y4Z4IXqlENUPDL9TPpsRL/dqsXf8Qb+IoRHF2hlny0jQ5qBaz3F68TaItOvPwlO0qP2IoloIc3E5/sySAIVI1riQMCQyjSvBnL5i2bNap03NCACYanuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zIOUiZpX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so1060767566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727768585; x=1728373385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI7Tk6w2DHrsufdOrBbXYUbGbTlEceKh4y8w9ZIk/ow=;
        b=zIOUiZpX4canzx+t9IWI1y/w3cbQERDoBL6T3HiZVHiKd9PeZS+kL+XuMcGcScIm/m
         UgcHPJIv0kbjDtzYkksQ9VL/cysTVN48EXKEwJH6TQZJJZ1K6eLyrF4UBqW+DvGTeTOM
         tWDQ634G+JukhpEHElJ6ujZaMnhZloTlcefUDxqAhGsnbVPRy5reZFJuPqVUNK6ehcjM
         4t0JK1fs37wIpzjGhsSU76+s5cMnTCfCOGB/lxgdZuSjyvTzCwoleCgJjocduTzamuv6
         gI7xyJJkbUV2D9LbQ1h+H+EXiBrvC+QkpmeMg8FTmUDCDMm/Z6iOPGW+syFjn38jBcAM
         XvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768585; x=1728373385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI7Tk6w2DHrsufdOrBbXYUbGbTlEceKh4y8w9ZIk/ow=;
        b=oh9pS4CKBBQVocReyxgRkUXuDOEr8umIDZK1H1n7xh0QC26E9WGedez+MfTTOJXlPL
         YjzkrzMszojPZBZio9G/Kn4MBDPEnJQ0u/SFOFBflrQLHnd+fl/6InlB9ook1tc+a5LE
         1fIf787NWHYXgobX30yaTsxnSXHS88SR9y9sGEGZiK66llomQ4tU0nhNmlsdfnt5geSm
         /lsjZcH9K+s7yb4QYw5bVKfsRvkrxlGzSbGxPaU6bI18cz5P8i/OzkL4Nj/ffMgBUpwo
         5Z7ZIJLT5DAiRehDENynR8vvnSi1gPiNA8tvLaQPjg8iIdl/2YZT+gyv8q4+gHVguiKA
         zv9w==
X-Forwarded-Encrypted: i=1; AJvYcCU3X1RkMtEpUDA3eRjx3u4Id/QRJ5PMk7s7LcDliTodrHT+O78TT5vF3m0m+AdwOAyx8i7dI35fRmiFPcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDsKJd9e1XuLRLkcxnrLLmm9k1HVlr529RhHAyeyE4u2hpwO2
	+o7EeGPvF8NoZGC28g129JWcquoeAyhhEbI9fu9X2dxsDG5djaX2cYxV3rivaNWpg49ks2SpkKP
	4
X-Google-Smtp-Source: AGHT+IEs8YPF9B4RZbXhnPXALL760M0necyP8/M6VUCax/NTy+q4juoAjI09X2o88BycaJJZv1DxVA==
X-Received: by 2002:a17:907:3f8d:b0:a7a:8284:c8d6 with SMTP id a640c23a62f3a-a967bfd9483mr209181666b.24.1727768585087;
        Tue, 01 Oct 2024 00:43:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c58e1sm660155266b.58.2024.10.01.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:43:02 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:42:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 3/7] zram: rework recompress target selection strategy
Message-ID: <61e752c5-ed1b-4b9b-8bdc-0562d2fbc828@stanley.mountain>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
 <20240917021020.883356-4-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917021020.883356-4-senozhatsky@chromium.org>

On Tue, Sep 17, 2024 at 11:09:08AM +0900, Sergey Senozhatsky wrote:
> +static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
> +{
> +	struct zram_pp_slot *pps = NULL;
> +	s32 idx = NUM_PP_BUCKETS - 1;
> +
> +	/* The higher the bucket id the more optimal slot post-processing is */
> +	while (idx > 0) {

Why is this not idx >= 0?  Why skip the first bucket?

regards,
dan carpenter

> +		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
> +					       struct zram_pp_slot,
> +					       entry);
> +		if (pps)
> +			break;
> +
> +		idx--;
> +	}
> +	return pps;
> +}


