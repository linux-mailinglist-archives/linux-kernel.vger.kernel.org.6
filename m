Return-Path: <linux-kernel+bounces-391532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFF9B8852
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561521F22A88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CAC61FF2;
	Fri,  1 Nov 2024 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzXXgyVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F34D8D1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424180; cv=none; b=fxrNl2Sp3XWBZmBNuHpitbaInHSMRYMgg8sESDVXSGdl9FFY0UnmSVgUdvcShhs6pmnB0Nc3VIounyDaA5nVazP5f2ojpWZ+DgeEZW1TVEnjS4YtfbnkjsenHusGMDGAW7X+fKRq4yCCybsXIlcmTZzUn2SU6j+BcPbAxW4t2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424180; c=relaxed/simple;
	bh=wzXs1qdakHCZrExniZa/Yr49WnDzRpD4rfPpqytB2AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiETuyDnDJUf78kX3hrSTpTc3mkxCnRXdbZt7pyRl0YfWs709K0ynbu5vOijyoG4pOaDldd3VEuH7kYN4f6p2wm2E7KCo2/bIoL5jlFXHq0xW/dXlcGnGc/N0oWZpcCCffXhfdzdHijQtLagASsVuRw+HjngsxuegoApEI4t3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzXXgyVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F2C4CEC3;
	Fri,  1 Nov 2024 01:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424179;
	bh=wzXs1qdakHCZrExniZa/Yr49WnDzRpD4rfPpqytB2AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzXXgyVry1Kt8aZehwH78q50mTUIx92z5UnJtm+a6cRGZshTQ3aXRPibFtizcWwn7
	 1EA59r4g1WaI0F8Kj+ULKQjfwzxvzA683fONZKldR0YEbn5qRgk55+CNHJynmX+nLd
	 IzlF/DCtyqqbEOojIq4LVZNQx8n0XKOitB18YHxo0Zg9gaSG1xTLULu5FHE2l/mMzi
	 yKBwVSM8XQuAaVdK4Wna1ci9aie4eVtOWLheXDN10iJ2ydrP/ZjQ6ue6SvgrAYFyrP
	 DXvqKeNfblCzgpxh6AE1CukSL4Puu6gf6sIlxujrj5NlMFgDivytBpk/Qh0kcsfJWO
	 cQ6MqBd6JyJzw==
Date: Fri, 1 Nov 2024 01:22:57 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH] f2fs: fix to map blocks correctly for direct read
Message-ID: <ZyQtcbtzpixFd6Zs@google.com>
References: <20241031102200.440407-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031102200.440407-1-chao@kernel.org>

On 10/31, Chao Yu wrote:
> f2fs_map_blocks() supports to map continuous holes or preallocated
> address, we should avoid setting F2FS_MAP_MAPPED for these cases
> only, otherwise, it may fail f2fs_iomap_begin(), and make direct
> write fallbacking to use buffered IO and flush, result in performance
> regression.

Is this fixing direct write or read?

> 
> Fixes: 9f0f6bf42714 ("f2fs: support to map continuous holes or preallocated address")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409122103.e45aa13b-oliver.sang@intel.com
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 306b86b0595d..38b85160c6bd 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1676,7 +1676,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>  		/* reserved delalloc block should be mapped for fiemap. */
>  		if (blkaddr == NEW_ADDR)
>  			map->m_flags |= F2FS_MAP_DELALLOC;
> -		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
> +		/*
> +		 * f2fs_map_blocks() supports to map continuous holes or
> +		 * preallocated address, don't set F2FS_MAP_MAPPED for these
> +		 * cases only.
> +		 */
> +		if (flag != F2FS_GET_BLOCK_DIO || map->m_may_create || !is_hole)

So, this is adding map->m_may_create, which is for writes?

>  			map->m_flags |= F2FS_MAP_MAPPED;
>  
>  		map->m_pblk = blkaddr;
> -- 
> 2.40.1

