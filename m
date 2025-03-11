Return-Path: <linux-kernel+bounces-556302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BACBA5C3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD93A5D19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BC25C6E8;
	Tue, 11 Mar 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KkvIOfxn"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502225BADD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703407; cv=none; b=NkLJ43uKaR8mHw3nlQvQL4iajmwzoISPLdKQ6wz1TrlgDIuc5j4DkQKuvkgrW/JBvcE97YDY1cvIZJRW6M9evA7TSYW0Ci5bunbP72vnv9rAC30YLSvnFHSNADnhvwiexknsp9vukxT3yr6JHE3Pxpquh0ux2p8t4nnStO3buSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703407; c=relaxed/simple;
	bh=Lbqh9yusnCaTFaBmpPgXOAq3A86JzGOQedkX5BbKjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4rHgIMwe/UQ1CjzXpUwR3K6FVhX1GUgRhplLJp40Oil8i0ujM5k47Cri3KZiODI+FAM0xcBbM1x21+CYbRCz/0s/i3Kk1H7f5MGL3D9cHmbg1zxsD1z2o9xwU8QJ2uAXGydIsHnuR8bvCP7BiKqn3lxPJr/BkjGDkEjkryoRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KkvIOfxn; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 10:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741703401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVw0K9RE87ea7+I6+77tXwLVCr0UPTJI2bUsVl3CyC4=;
	b=KkvIOfxnSBr6wD0KgzOVnIMqoNki0SAJMnB6H/7kApX9VytOEgT+avr9HdSJcfkMdeijTR
	2wokh7wHK9FjNL91yzk0Czpmfart3pNYAGValOhtqp+C/VTFOF2/oq1b2pQyH5aLe5PG8v
	B5IjqJGfNJknWNvMh23O2OUICIfVJTQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use max() to improve gen_after()
Message-ID: <g5r32qh2tb3ttvnrsgs34jizaglwrbkvcw6q7lwpspawmgxdon@zb7mpeglnswj>
References: <20250311111310.495922-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311111310.495922-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 12:13:11PM +0100, Thorsten Blum wrote:
> Use max() to simplify gen_after() and improve its readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

applied

> ---
>  fs/bcachefs/buckets.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
> index a9acdd6c0c86..124ac380b22e 100644
> --- a/fs/bcachefs/buckets.h
> +++ b/fs/bcachefs/buckets.h
> @@ -167,9 +167,7 @@ static inline int gen_cmp(u8 a, u8 b)
>  
>  static inline int gen_after(u8 a, u8 b)
>  {
> -	int r = gen_cmp(a, b);
> -
> -	return r > 0 ? r : 0;
> +	return max(0, gen_cmp(a, b));
>  }
>  
>  static inline int dev_ptr_stale_rcu(struct bch_dev *ca, const struct bch_extent_ptr *ptr)
> -- 
> 2.48.1
> 

