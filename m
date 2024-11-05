Return-Path: <linux-kernel+bounces-396818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8439BD29D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5691F212E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E21DC06E;
	Tue,  5 Nov 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SGoHfx4t"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566441D9A6F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824728; cv=none; b=Tb7r9Joi97FiOiBFd38iVc5UAH1fT9QjOhvp9g5FB5OLTH+4gUHyU0uZmZNFYqf4nHYoMtNOZ68lGNG3fDG+GrpLeEpDTKNGLfLW/DSEMiXwPDTYLPejnq1k569o2HIhU+Y46muYGGtH9QjgOFqFt06LhGyEnioFtXwhs2N2aNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824728; c=relaxed/simple;
	bh=Fv+mcw/NiKtO+idJFAlvHIPXaqCyVS0fLeP/5d4CvI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqm7rQR6U83eftuMGosayYFaGMHclbYXkiAtdZmMU9sDwGzwal1n2b1bLFCQ6q/B3zs4KPR4F7m17vNr2jXStyGLkeQY9SdvMnU2xyNG/6Y97lWFGQTkCWb6XqxXgFO+D1rYFuUD56TL8fv9KB9OkwHDUq/5Bfc6ikV1YK/hfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SGoHfx4t; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 Nov 2024 08:38:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730824719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrkQFJvrlknPskvBK6hxqCCGXNIgK5FjJfbgLjTLDOM=;
	b=SGoHfx4tvHYi19QTB+rVHQpL6cPj5CgM6RyXDmIZgAwzuzlNn8wbUNmA9wX9mqHm/OjzPf
	1TOEs/yPrJjoeDHyo8QL5NT8Uv4fz06+2ihN+XD2IdYk/6h8yMAMlhprUUlzi0LaDiYpg1
	xC2TognkZdzSmwA3JLAoT41YDAsdktA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, roman.gushchin@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: Replace simple_strtoul() with kstrtoul()
Message-ID: <md72ehlg7qbaexaxypl7tzmstshs24uqgfegyrkbx5lxm5pmq2@4opgtkva3eh3>
References: <20241104222737.298130-1-kerensun@google.com>
 <20241104222737.298130-5-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-5-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 02:27:37PM -0800, Keren Sun wrote:
> simple_strtoul() has caveat and is obsolete, use kstrtoul() instead in mmcg.

Did you test this patch? I don't think kstrtoul() can be used here as it
expects a string containing a single number.

> 
> Signed-off-by: Keren Sun <kerensun@google.com>
> ---
>  mm/memcontrol-v1.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 5e1854623824..260b356cea5a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> +#include "linux/kstrtox.h"
>  #include <linux/memcontrol.h>
>  #include <linux/swap.h>
>  #include <linux/mm_inline.h>
> @@ -1922,17 +1923,15 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  
>  	buf = strstrip(buf);
>  
> -	efd = simple_strtoul(buf, &endp, 10);
> -	if (*endp != ' ')
> +	kstrtoul(buf, 10, efd);
> +	if (*buf != ' ')
>  		return -EINVAL;
> -	buf = endp + 1;
> +	buf++;
>  
> -	cfd = simple_strtoul(buf, &endp, 10);
> -	if (*endp == '\0')
> -		buf = endp;
> -	else if (*endp == ' ')
> -		buf = endp + 1;
> -	else
> +	kstrtoul(buf, 10, cfd);
> +	if (*buf == ' ')
> +		buf++;
> +	else if (*buf != '\0')
>  		return -EINVAL;
>  
>  	event = kzalloc(sizeof(*event), GFP_KERNEL);
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

