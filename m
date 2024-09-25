Return-Path: <linux-kernel+bounces-338235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983C98552C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BD71C2090E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8830158A33;
	Wed, 25 Sep 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vb/wc29v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E170155741
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251825; cv=none; b=G6BrzjWxyKO7NGKfedAuS4+sXXAvOJTj4DqOadXSCoWodb052mF1wh5X7Q/50LH4h23xSVcL2qYLJDhG2qPuL2CLvn9zt5/wkEYAgsYhDGvVSAgVzaD2TpyxI1Rg2EYPdUC+qFGtI98GQMhDnx6RYKZUxvGVGnN9SNQE2LY4/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251825; c=relaxed/simple;
	bh=3UeFz9qhVYZ+msdty2CcdnWbTrHFD37IngKHjDdyUxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OATLIvn+5jQn9LoPhIq5rpYsnWl3RrYzxA6LHD0bE1ieWsGbW8cFp82Ehcvj7rkDStzaqt4IgdvLS6W3d7CpPjgl8gIKtXaPLWa2HSUR+JjhJ/133FJwSKuARq4OobMn2WeNdYdVKBQ+nIstAaavC4HRiAOo18M/usDCJOgoHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vb/wc29v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A254BC4CEC3;
	Wed, 25 Sep 2024 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727251824;
	bh=3UeFz9qhVYZ+msdty2CcdnWbTrHFD37IngKHjDdyUxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vb/wc29vkbLSgiYt6jqcUMFFfmKBzzNsXq413PvO74HvAFk30MApVgkmfgC9QTq+6
	 fuYgFpTsLYvBYZu5IJuyq4wBjZS3JwJYtmWExMB423VtFgS3X0hGgIIR61xiibZa72
	 hR6GXWVb5GtO/LVwZpuuZA8iD7pxYbfoBbm2rU8c=
Date: Wed, 25 Sep 2024 10:10:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tkjos@google.com,
	Fangzheng Zhang <fangzheng.zhang1003@gmail.com>,
	Yuming Han <yuming.han@unisoc.com>
Subject: Re: [PATCH 1/2] mm/slub: Add panic function when slub leaks
Message-ID: <2024092556-tribunal-next-84ce@gregkh>
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
 <20240925032256.1782-2-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925032256.1782-2-fangzheng.zhang@unisoc.com>

On Wed, Sep 25, 2024 at 11:22:55AM +0800, Fangzheng Zhang wrote:
> Perform real-time memory usage monitoring on the slub page
> allocation paths, ie, kmalloc_large_alloced and alloc_slab_page.
> When the usage exceeds the set threshole value, the panic function
> will be triggered.
> 
> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
> ---
>  mm/Kconfig | 11 ++++++++
>  mm/slub.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09aebca1cae3..60cf72d4f0da 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -255,6 +255,17 @@ config SLUB_TINY
>  
>  	   If unsure, say N.
>  
> +config SLUB_LEAK_PANIC
> +	bool "Trigger panic when slub leaks"
> +	default y

"default y" is only there if the feature is required to boot the machine
properly.  That's not the case here, sorry.

thanks,

greg k-h

