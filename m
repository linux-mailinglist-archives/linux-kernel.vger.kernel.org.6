Return-Path: <linux-kernel+bounces-280530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ACF94CBC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2831F21C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60118C345;
	Fri,  9 Aug 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZX9LLivd"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAC16CD3D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190224; cv=none; b=BEBzTrq3NWABnDB8q+59wxnkmdyKDlZRrjcWo4pCuSrCTRT8jL1aTKZE1WHKvxtqIod0NQQShep9sG0q7SZU2Rs0g5OrQD3DudwYa3vEu3QdbiOXa9hjT71pCId1IiO+SXV1yYlA6/muSOdQnl2XhGzAQo3yOVsokrtH6o5o450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190224; c=relaxed/simple;
	bh=P+o9B5Qz0ZtDkL2hLySey3oT5H+7QGtKNfKaCyayAzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4+cdoDOy6sYC0s7ZiGgO5LqJz5mEKX32PiNLLPZ431IJ/E96hcSBSdjoExyE1q9Gnpu0jK+e1sUn9YIAF6sAjGaqQOHyitXkXrWsLZiO2ZWE5Jq7V3Go853lWdpMlljeBeMqTcvZmKjwHL54gJquGNjGCHlEP0muNsndBAtxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZX9LLivd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so2185115a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723190221; x=1723795021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4X2j5n+HQVX/p/U1z0tmTHZFV7Oux1KeJmnmOuLwIY=;
        b=ZX9LLivdxxAKvPm5nptOrywSA494AJVOA2rmD167JEkfQNxluOfm5NVn2x3Vhwtfmp
         7ntn7IC6k3ISVBnGABRXAHDb/+hbCUl2ibwl2Jhj1JA6o8bkKwgaCLoVs/lDeqdsp0DD
         1x/OelXza+NaQDdsByDRg9AE1QqvYKSr2ahR0cBfUZA8WqrjF05uJd/ZqREQa9kEVD4b
         FZ/gwcJkvY+kgt/DMk5KQQq7h4pQQq9kQJlCsLkKRv5lZZ4LyNrx8vx8ORm+PggN+ydO
         ZGJqVQADiGtx0slFMlcyMAO24JVPBQzYmzG9jAjgnpb88fRq7Bx8IC3INOWMzTCZX+fr
         n9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723190221; x=1723795021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4X2j5n+HQVX/p/U1z0tmTHZFV7Oux1KeJmnmOuLwIY=;
        b=ODWP0pI7YxWVz+Yw68a7YMkiG/s6JdqIXK9l+UHRJflA9RgIai61KU4Zpm+U5SNgHt
         ujAfVA9eYo5G1SPhiTzdT+xzzKkxnHuJIMErZTBxdGuq79m1yUbilSk/HaPSnr5scO7H
         09+RkMWEK4XkFpAy7AjTaMIozo1Skhg9cTgOcLFvdabvl2ypmU0EM2Bk1gxZ1P3WEyl7
         HIEknnOQHmDeULn5ABSdtLtVWahVfk6nTJ15iIeX0YrmV6XUV6E+kTwyTGz7b9fE7yG4
         NjpC2/em/zXVDSaQAKstv+2GdYhEDiOVJHCcnzrRYwoJyWogNsuMK4J65nLxvi0T55va
         C/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWvIOrZ3GyEFxR4RqaGlDXle7kAvI6w6iN5mClx8tUJ03bcLSy4lLvzFTpaI/oyqEq+/QP+86IX9LDBLabjOudEmtMbPxRy19g5L39L
X-Gm-Message-State: AOJu0YxqZRp+b2/XoqMCH9bpw4GZ431KFzu5vfOWGaMv7Zztp49Gxa9Y
	mBztQkhwK9GmtEiN6qGn33fxuVnMEIk5gBp3+QDtVUlohM3BEik3fd+Kc9fCjJ6uPE968mbmbgP
	Z
X-Google-Smtp-Source: AGHT+IGn9nQwEAFW4Y/TSm4pYY5wYW39ON7OgDyDPub94onrCBjU1AoPd0RfQSKxRCt+Kk2msP+4Xw==
X-Received: by 2002:a05:6402:26c8:b0:5a2:1f7b:dffa with SMTP id 4fb4d7f45d1cf-5bd0a50cff0mr594761a12.3.1723190220878;
        Fri, 09 Aug 2024 00:57:00 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf855esm1299238a12.13.2024.08.09.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:57:00 -0700 (PDT)
Date: Fri, 9 Aug 2024 09:56:59 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/rhashtable: cleanup fallback check in
 bucket_table_alloc()
Message-ID: <ZrXLy6-EpFJdro8b@tiehlicka>
References: <20240806153927.184515-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806153927.184515-1-dave@stgolabs.net>

On Tue 06-08-24 08:39:27, Davidlohr Bueso wrote:
> Upon allocation failure, the current check with the nofail bits
> is unnecessary, and further stands in the way of discouraging
> direct use of __GFP_NOFAIL. Remove this and replace with the
> proper way of determining if doing a non-blocking allocation
> for the nested table case.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Thanks. This is not really something I feel qualified to ack but the
change looks good to me.

> ---
>  lib/rhashtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index dbbed19f8fff..6c902639728b 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -189,7 +189,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>  
>  	size = nbuckets;
>  
> -	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
> +	if (tbl == NULL && !gfpflags_allow_blocking(gfp)) {
>  		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
>  		nbuckets = 0;
>  	}
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

