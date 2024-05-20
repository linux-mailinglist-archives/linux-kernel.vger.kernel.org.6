Return-Path: <linux-kernel+bounces-184132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCB8CA2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC5FB224C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993C139569;
	Mon, 20 May 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqa3Dbbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C61E4BE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234747; cv=none; b=iO0mfUvjOEXNvibjd54cFRnWIsHEX0i72rkOIjXgRZtr+NyFsWaaWbhayOY8xE2AEFf+HyWcuxPafOVOAd5cL/GHh0mucVGTBUu29B2v9EI7/V9vy55xLSsUZWBc3NX7O5fawP9/g7MGt7KJtdIaQrwDNhJppYLqIUecx9wNVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234747; c=relaxed/simple;
	bh=U2CMoe4AE+nyQy1FyMvXOkw8VyQr9iKivbdDeG3xG14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnPFuWtfPblxON+KYy9c8uEiJiGticyBNu/RIFyx31cV/VyAh1Mlz8xiVLU6frcefEzzVJ88jbXzLyRs5gNpyi3uq7kzojFGutwdr+VIk8aLbFstdUfIweJUyunVvOTNYPi79cNr1EACdIZ8ZGZHU5wJBLR47qCviEYav85FakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqa3Dbbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358BAC2BD10;
	Mon, 20 May 2024 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234747;
	bh=U2CMoe4AE+nyQy1FyMvXOkw8VyQr9iKivbdDeG3xG14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iqa3Dbbqw6bpcrwiqzWuFRKSKf26vkkvQdyjYxaiKydiPjx+mQa241ogQWQ1dVsTB
	 vgl1VptkRMvH62nqQiHZ5qdFdkG3Ut+gKKqA52Tu/g/u+Ufm3TGT1gOHLBiurPhFmz
	 R/jPduEWkBgO5+ipRPGa/AjXyNfUHSm7j83ismgOz5obIMCqazpmwI1ftW0KMVy9h+
	 aauX7E58FTGv7+Ra2TE/CHrdyaLEXRjVRNdCNOsINIgPii80fDFDLNmjDLpRpBz2yc
	 PG7AcoJzwCWeMaxBQWEDZfVUA1X57JWvOnrm+0iQxzNZaq/JZAqiUY7jutGYyjDJLf
	 tnqXGvCiLEPKw==
Date: Mon, 20 May 2024 19:52:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH] f2fs: fix to check return value of
 f2fs_allocate_new_section
Message-ID: <Zkup-c2K74bxVJ0i@google.com>
References: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>

On 05/17, Zhiguo Niu wrote:
> commit 245930617c9b ("f2fs: fix to handle error paths of {new,change}_curseg()")
> missed this allocated path, fix it.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/segment.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a0ce3d0..71dc8042 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -5190,7 +5190,9 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
>  	if (cs->next_blkoff) {
>  		unsigned int old_segno = cs->segno, old_blkoff = cs->next_blkoff;
>  
> -		f2fs_allocate_new_section(sbi, type, true);
> +		err = f2fs_allocate_new_section(sbi, type, true);
> +		if (err)
> +			return err;

I hesitate to apply this, since this may give mount failures forever. Do you see
a real issue with this?

>  		f2fs_notice(sbi, "Assign new section to curseg[%d]: "
>  				"[0x%x,0x%x] -> [0x%x,0x%x]",
>  				type, old_segno, old_blkoff,
> -- 
> 1.9.1

