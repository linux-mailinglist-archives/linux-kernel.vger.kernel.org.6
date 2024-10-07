Return-Path: <linux-kernel+bounces-354121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BF5993806
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2782F283C39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51E1DE4DF;
	Mon,  7 Oct 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/teCv3s"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4B1DE4D1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332027; cv=none; b=QYAY7sOMtPAQW0xPqC1TPOKB8OG3wJbpXzqMx6n941klMiiIL7vcVgqad4AlYOHSVHgsFJgN5UmGDuqnO5EeFCrp/9+uEY678vMmMrJMkP+eilN+7jPn1oPKZWwHthJ+pbFwAtBxkPQKUh97yXvvEmTPq+X79z+E/789kLyGC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332027; c=relaxed/simple;
	bh=kWz8zF/MBILymvS5qXFwRvyBXzU7ftKFfl0LYPOlHGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR8jliW1mpwj0sOc7LKPPLAW/2DlLcixqyhMK8FhZ5ng8l6MrBFcncVzwnrq521c3NWK4Alv/ni94hw6fvrWEzrBFH9JUYSXongAu4da5JPM7ycRRyd2EIobhYIzjEuqQLlRlro3q4dkdtRPDuUkkYkZdnWspwzinR18UO0mnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/teCv3s; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so49332205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728332025; x=1728936825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx0pt4scDmNk1EWAFeHFSniKZ7EUYcMTiEUSd4YB+1U=;
        b=a/teCv3sHpOk9WrZqpBPkOoMWA7mNGlgAjY2ydLqCQNv5LZefY9K6LYVJeephfjV3f
         Bsbgua+xLeVj/w2UrtDw5K9SEOyknWDZKGQCtP9srqm7pqp6R7sI4LpGYwyb5rwHodyP
         tIRlLlz61hgLYU4Q9rdmyvBvQlEZyX+tGMAEiuqcVzBMTzgtzMw3tw3ZRCETWfH15xNc
         ED3j6j1+2d0V/yqibmwVhZBxSoPZpiPL8Q6/elhsrsHe9LND/PXfURQU4THO0ktLZwkh
         /+1gR9+MSMhMEAs4dSWVZufLTpyVu2Hi6dn70YImL3baL/gjY/GEfcpeCAHMXrpNVlXL
         6/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332025; x=1728936825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx0pt4scDmNk1EWAFeHFSniKZ7EUYcMTiEUSd4YB+1U=;
        b=PM/8P26qksSXNcJGVBb2xc4aWyyXVd2yF8m1BiAU7yp01XyPMaFAYAIm1UbgCzfV98
         slOUTV7TyI2shiWDpGKQi7pVFfNn5qbz1MMfjgIdV/vscITNmc1zNJE3+pPPWZK/WZwC
         J7FCEyHFMZU1VvoF6jNi6MwPnpAq8aeLqTMiYcdWR3umJ0P3pg+OeMwWpLiYoGbm/nHW
         3kPcWSyvciBszFe6jodNUnAY+6McuOn88uRoLIelUFvgXhivDMbi8/tPz3N7v8mhQ2Jj
         n3wEojSQANKZDqWLo58+J2a/xH5zR4/saNrhb0KtCh1BlX2vchoBh+3DaBOp9EdhaDXs
         s5/g==
X-Gm-Message-State: AOJu0YwhJBA0seHRHl/gDnEoJb3I+GB5r+v5qglM/p2jaWJJUP1sTRGc
	Ra5SlVJNx8vGWTjM6ItCAXEGKG9T5BuVehhbUomwF9qINdtoWnQwjTGNkj/ppg==
X-Google-Smtp-Source: AGHT+IECSBYGWYElrGQ9/PLjCv/QGgIvTaH6gZjMVFJX3HJR0CsTFxRRdwcOmmbwk/i2hOLei1z4+w==
X-Received: by 2002:a05:600c:1907:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42f85ae9d2bmr109959455e9.22.1728332024426;
        Mon, 07 Oct 2024 13:13:44 -0700 (PDT)
Received: from localhost (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b43f2dsm103724915e9.31.2024.10.07.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:13:44 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:13:41 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vbabka@suse.cz, willy@infradead.org,
	hannes@cmpxchg.org, anna-maria@linutronix.de, tglx@linutronix.de,
	nathan@kernel.org
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <ZwRA9SOcOjjLJcpi@google.com>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>

Hi Shivamurthy,

On Fri, Jun 21, 2024 at 01:16:04PM +0200, Shivamurthy Shastri wrote:
> A W=1 build with -Wenum-enum-conversion enabled, results in the
> following build warning due to an arithmetic operation between different
> enumeration types 'enum node_stat_item' and 'enum lru_list':
> 
>   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>         |                               ~~~~~~~~~~~ ^ ~~~
> 
> Address this by casting lru to the proper type.
> 
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  include/linux/vmstat.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 735eae6e272c..72ecd46fd0c4 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -511,7 +511,7 @@ static inline const char *node_stat_name(enum node_stat_item item)
>  
>  static inline const char *lru_list_name(enum lru_list lru)
>  {
> -	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> +	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
>  }
>  
>  static inline const char *writeback_stat_name(enum writeback_stat_item item)
> -- 
> 2.34.1
> 

We have encountered the same problem after trying to update Clang to the
latest version and this is a blocker because we use W=1 to compile the
kernel.

Do you plan to address review comments about casting to int instead of
enum node_stat_item? Or I can submit another patch myself that addresses
it.

