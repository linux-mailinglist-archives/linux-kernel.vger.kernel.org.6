Return-Path: <linux-kernel+bounces-258097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA140938369
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 07:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3D281643
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C3B522F;
	Sun, 21 Jul 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNp54LWD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440481FBA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721541555; cv=none; b=qAr0Vmd5luq6wevwfliKdKLR3jmP2kGxSI9xFzlQ486oCmS5yKhvh8Ag6j4DOYNWnD/cKU3cJq9Wyh3+dE2FiYKVfhUYvaaOZocJOowzibXpgpdgBQA9QYkSAhgnfCZVs0o6z0jTpFuNbEg7q6DaSpS83nGbueqmwxxoZ0fmKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721541555; c=relaxed/simple;
	bh=+w5EnndjNnbbHrXM90/6rW5q3JsLTKm5h7zxGZ/d2lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSRWE1JY51w+iNY6mwYS+oz/3mLwVqGOVLvdyJlCXqEhRgDRnEsQykbKqwi7kHm40W56Z5FVYpZT8JqPs2X2h/VE45D3htJ8KcTn2fxwhnlEI9WSxbQYRWeM7flQaRliamyiA+YCjAXdblpx6mSU/QrzgyRytxwSMBdduCRR4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNp54LWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9CEC116B1;
	Sun, 21 Jul 2024 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721541554;
	bh=+w5EnndjNnbbHrXM90/6rW5q3JsLTKm5h7zxGZ/d2lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNp54LWDY/mtnJaD3p408bi8+9Ug9J3hj+PK+NWC7O0URreZnkDlBvQvrIr15c2t9
	 NmczwEFF6s6LojNLxILb3iTOQUAmKA59d1DVRWm/HA0Daa6vsbMhNoV8JoUkbxe5Y4
	 LEwboKh3aVmOvvKFi3VIh/862zizj4q9RnuFb0AuDsx4iAbWQ0j25mMHtCh6VjoeGN
	 CH3YbtOss16SdD51m9r/6ILIpwJHq6yi4qyN/7hVWoIAK8u+H2Jh3R1Tj3aJgSOD1+
	 4s7JKsiLV+qGcMSXxvxuTO34GiebDVu7Se4kstqCUJNROH1iuZD4Q9NjPgjAP12tgx
	 360sGx4JQ8sDA==
Date: Sun, 21 Jul 2024 08:59:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yufeng Wang <wangyufeng@kylinos.cn>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: Keep the same format in struct
Message-ID: <20240721055910.GB1265781@unreal>
References: <20240719073350.116347-1-wangyufeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719073350.116347-1-wangyufeng@kylinos.cn>

On Fri, Jul 19, 2024 at 03:33:50PM +0800, Yufeng Wang wrote:
> add some tabs to keeping consistency format.
> 
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> ---
>  drivers/infiniband/core/cma_priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the patch, but it is not related to netfilter, and together
with that patch is not truly needed. Let's drop this patch.

Thanks

> 
> diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
> index b7354c94cf1b..261431e00820 100644
> --- a/drivers/infiniband/core/cma_priv.h
> +++ b/drivers/infiniband/core/cma_priv.h
> @@ -99,7 +99,7 @@ struct rdma_id_private {
>  	u8			afonly;
>  	u8			timeout;
>  	u8			min_rnr_timer;
> -	u8 used_resolve_ip;
> +	u8			used_resolve_ip;
>  	enum ib_gid_type	gid_type;
>  
>  	/*
> -- 
> 2.34.1
> 

