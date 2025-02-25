Return-Path: <linux-kernel+bounces-532424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32DA44D84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D4A3B49AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DF421A42D;
	Tue, 25 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j6+C/8pD"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011321930F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515153; cv=none; b=HWfTT0lDYyv7TdrHyij1SKLs6YKKe5iWIrE8JIkZ+5jtlzoNYpXdDa6tDRSpSeGBvdJ4vOd1+YbplE4+pBeYw8sqbfq/2rGqXVVb77kousHu8DvrT30xJyKL7rUsNPs/3rHJXjSFTv4BlD+760JceHFRUQvK966S25A3Ej1r/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515153; c=relaxed/simple;
	bh=p+pwKqqiJgGoKhhKfKEb2PlC3q2bJ+lUi7mJ6sJw3Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJOqrsR9l8j1bAdVy/nAc+CW2UyIs/L7Q/2NFPtw8k5UotZlYtx0VYOiqd3IqiPOo3N5iFg9viGgGCLJL1Cf7aynF0XnRt4r7GLaD3tPspH+mZbeBxSgamyXhagBOpbD7uujqQkD3O9sBPJ8NXYQxGyeKrzyGKZCXeNIsug4CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j6+C/8pD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8eb195aso23016505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740515150; x=1741119950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sahSWpKtSWo1rgbQdN3cw9Z14mvbGZlYM9iW6N7nIM=;
        b=j6+C/8pDPk8hVujyWgUeL3kvc+EExreU4AJ+mL5ZDQLkmx3Vafi14JMiXK8+e1yjmy
         WUTkFYLPfyjEeyPddbKPyq6EFWQSTSkj5i+eb3UzAQ2Ok3g4B44o8jcGPnLpSnKxydaf
         sSkwuUEByT4fQ1Ucc/xXI/loz6VLX9iBlCffBhiH1iOoMxVsfT+zkg8lJ3Bd/rYaygzx
         FKtYkW5aeuNRHfp3Kpu4gGiQA/8Hrz/RBMjUHpIVs6h8a1+7pNGXVQ2kvnq7Bl62lqwh
         ORYcXxs7fO86Vn1VKtDruz9srgQIXxxK6mWZtVodvj8GYgi5gaGCDRwSF/CY7xsP8k6v
         0P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515150; x=1741119950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sahSWpKtSWo1rgbQdN3cw9Z14mvbGZlYM9iW6N7nIM=;
        b=TFSiM9tZrIu2HQWETdn5Bqq19aEBjBfqBs7uvyL6q1AdCJjvL9zWrL/4+6Lwfa6+PS
         9slSxCAdHH+8c+W009XenYOcQUZgzAsnPytCVq0mK70DfDuPBHAJ/bdbeQntTEehlJBx
         0Q5Thshpz83agHWPC1vG+Wdre0UA8eji8ngIinGCKZ9BZMxHMOJXxmzRzOXcyPRj+1/O
         BTNHH9p26L4VEdfnilnx/oBsLdpDcRJiquVL3eTBFOkX4JbzHZR826azoQl/pOCV5Lxa
         tBcD5U7AE1k5EtWSuBrS6MOD3k13rl3C+vZLmPpwgiePeE/EGyiRDJ/L2CtsMZtOVxXV
         oxtg==
X-Gm-Message-State: AOJu0YyeH9i1eWQP/J+f6Wwx0BCUA+IgP+eG4Q7gFBOoti5e77uBaacM
	OG/aW5HoceqXqPbsPU/60wlFZBMyt8NBRq63aNNuNRelM5tI8F+BMCvq/I2MEgk=
X-Gm-Gg: ASbGncse30eRTYMnC/91F3T+zr8N60WJuTr+JWIwsoXu1b4tEVxbJtuxDWWpkY6qCdU
	tNtOH9rLd61NC1jdL44I7n9pTDXVw/R0sTGsMnqgC/0juKUhNAWbm4y7jpyvVY64bx6fuJw7t7d
	qkca/5IWUsVEVGYUIz/F1qfarM9cJiCzCqjBYAxQ1dHDzS/14RWHFYgcxznBXeqkQZ3Mf69FTa6
	tlIV5Cdvums7ycClPdf/3hIjo3G5jtHp3k43BAVBsckSyEkrev1DwawdKjxPIvr6u3ydPolM3Q7
	qgCSUIKFYXfhLUbqfk1dnpe+YMYMleLXcP08WuN+JO8Qq/y2tRpxI8N1X38huRrm7yGqfSCIuNs
	PJw==
X-Google-Smtp-Source: AGHT+IFJUKeSO/+jJc8oE4V1Fy6IwtegHWAoWJKcW7vsL+7oK8iiuDIcLUyurk4FQbtZ6ud4ESh4Ow==
X-Received: by 2002:a17:902:d4cf:b0:216:4853:4c0b with SMTP id d9443c01a7336-223201f7d84mr10594015ad.33.1740515150171;
        Tue, 25 Feb 2025 12:25:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000830sm18730065ad.30.2025.02.25.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:25:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tn1Uw-00000005ugE-3hi6;
	Wed, 26 Feb 2025 07:25:46 +1100
Date: Wed, 26 Feb 2025 07:25:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, hch@lst.de, willy@infradead.org
Subject: Re: [PATCH v3] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z74nSu3q2b3sy5wY@dread.disaster.area>
References: <20250224143700.23035-1-raphaelsc@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143700.23035-1-raphaelsc@scylladb.com>

On Mon, Feb 24, 2025 at 11:37:00AM -0300, Raphael S. Carvalho wrote:
> original report:
> https://lore.kernel.org/all/CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com/T/
> 
> When doing buffered writes with FGP_NOWAIT, under memory pressure, the system
> returned ENOMEM despite there being plenty of available memory, to be reclaimed
> from page cache. The user space used io_uring interface, which in turn submits
> I/O with FGP_NOWAIT (the fast path).
....

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 804d7365680c..3e75dced0fd9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1986,8 +1986,19 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> -		if (err)
> +		if (err) {
> +			/*
> +			 * When NOWAIT I/O fails to allocate folios this could
> +			 * be due to a nonblocking memory allocation and not
> +			 * because the system actually is out of memory.
> +			 * Return -EAGAIN so that there caller retries in a
> +			 * blocking fashion instead of propagating -ENOMEM
> +			 * to the application.
> +			 */
> +			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
> +				err = -EAGAIN;
>  			return ERR_PTR(err);
> +		}
>  		/*
>  		 * filemap_add_folio locks the page, and for mmap
>  		 * we expect an unlocked page.

Looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

