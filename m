Return-Path: <linux-kernel+bounces-572648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD36A6CCA4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7ED318949B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6322F3B8;
	Sat, 22 Mar 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sxlAqcxb"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F1DE2DC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678802; cv=none; b=ZtP97JIiiGiUKVAng7WUGTgUFFizNzNztX7nYYhfk2GKJh3Fk27UEH0DIVZdT1da84IXZqQYj5kXt78Di6o52kcNEMVdLIXWlGkow114lHbcmArNb/ItfZWOtkg0gp5w3ZzmLvEAw1URDd1axB7TcV5CFe0YoBJfEvzgOF3+FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678802; c=relaxed/simple;
	bh=aJKrk8AhFU5inmvC5FMnFgltEpcRhKTMhWxISXywHho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seJh6332fJj+YbNfNJJTcJUX6uakSlfv2jdTP4+82CDW7iTQl2HiUpSZg4dLKI09Yth4yBwKB49lEmmbB6oK01zmogIFkWuDTKkzYvAkMLnCfUlQs0CH1wupVsfCMCb4Ig2h60D9orndXT2zWVnyhWqsptr+al2nNHbIc8i6OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sxlAqcxb; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A920214C2DB;
	Sat, 22 Mar 2025 22:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742678799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlQXDT9qjPMuCQRb2y5j+QqB42E7sudAvA1QZKSwl8U=;
	b=sxlAqcxbFegzN+9/JA3Mq4pLML+DTcOv4PDeAh8rfbDiwM0e6B0ULM3xOyLhY//CwgEVTU
	8+ph1HJqs5NsACoSbYCA1Ct/oabash214Ghlb6+GO0aARvLAlNm5PGmN452+u6rtQOegHf
	6CaumImpLCQqgPPP709YExp4o4V5ir/T1rAxHBwJH0wEC16mjW/m/a8WlLrPg35OHJYS7I
	TPTdx1RlYVEtb6RM+I7eEybFlxD1cnfYG4GZUzcbygFObFB6aB6IqIiVi7+WDUNQgtqOuk
	mTPzXo3h3/O5Bkp2gK6um0NJN3pcED3f5YUe+n/biVStLKdyi5Zv9vkZDMDBJg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 00e7e8d0;
	Sat, 22 Mar 2025 21:26:35 +0000 (UTC)
Date: Sun, 23 Mar 2025 06:26:20 +0900
From: asmadeus@codewreck.org
To: Sasha Levin <sashal@kernel.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use hashtable.h for hash_errmap
Message-ID: <Z98q_K71xueitBeB@codewreck.org>
References: <20250320145200.3124863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320145200.3124863-1-sashal@kernel.org>

Sasha Levin wrote on Thu, Mar 20, 2025 at 10:52:00AM -0400:
> Convert hash_errmap in error.c to use the generic hashtable
> implementation from hashtable.h instead of the manual hlist_head array
> implementation.
> 
> This simplifies the code and makes it more maintainable by using the
> standard hashtable API and removes the need for manual hash table
> management.

I'm not entierly convinced this is simpler from my little island (that's
one more API to learn about vs code that doesn't look all that
different), but I guess I can see the point from an overall perspective.

I see no problem with this, I'll pick it up for -next
Note this code is not used for 9p2000l iirc so I currently don't have
any test for it :/
(but it's simple enough that I'm willing to take the risk)

Thanks,
Dominique
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/9p/error.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/net/9p/error.c b/net/9p/error.c
> index 8da744494b683..8ba8afc91482d 100644
> --- a/net/9p/error.c
> +++ b/net/9p/error.c
> @@ -16,6 +16,7 @@
>  #include <linux/list.h>
>  #include <linux/jhash.h>
>  #include <linux/errno.h>
> +#include <linux/hashtable.h>
>  #include <net/9p/9p.h>
>  
>  /**
> @@ -33,8 +34,8 @@ struct errormap {
>  	struct hlist_node list;
>  };
>  
> -#define ERRHASHSZ		32
> -static struct hlist_head hash_errmap[ERRHASHSZ];
> +#define ERRHASH_BITS 5
> +static DEFINE_HASHTABLE(hash_errmap, ERRHASH_BITS);
>  
>  /* FixMe - reduce to a reasonable size */
>  static struct errormap errmap[] = {
> @@ -176,18 +177,14 @@ static struct errormap errmap[] = {
>  int p9_error_init(void)
>  {
>  	struct errormap *c;
> -	int bucket;
> -
> -	/* initialize hash table */
> -	for (bucket = 0; bucket < ERRHASHSZ; bucket++)
> -		INIT_HLIST_HEAD(&hash_errmap[bucket]);
> +	u32 hash;
>  
>  	/* load initial error map into hash table */
>  	for (c = errmap; c->name; c++) {
>  		c->namelen = strlen(c->name);
> -		bucket = jhash(c->name, c->namelen, 0) % ERRHASHSZ;
> +		hash = jhash(c->name, c->namelen, 0);
>  		INIT_HLIST_NODE(&c->list);
> -		hlist_add_head(&c->list, &hash_errmap[bucket]);
> +		hash_add(hash_errmap, &c->list, hash);
>  	}
>  
>  	return 1;
> @@ -205,12 +202,12 @@ int p9_errstr2errno(char *errstr, int len)
>  {
>  	int errno;
>  	struct errormap *c;
> -	int bucket;
> +	u32 hash;
>  
>  	errno = 0;
>  	c = NULL;
> -	bucket = jhash(errstr, len, 0) % ERRHASHSZ;
> -	hlist_for_each_entry(c, &hash_errmap[bucket], list) {
> +	hash = jhash(errstr, len, 0);
> +	hash_for_each_possible(hash_errmap, c, list, hash) {
>  		if (c->namelen == len && !memcmp(c->name, errstr, len)) {
>  			errno = c->val;
>  			break;

-- 
Dominique Martinet | Asmadeus

