Return-Path: <linux-kernel+bounces-375273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03199A93FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8190D1F21665
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9E1E7C25;
	Mon, 21 Oct 2024 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABw98VDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F21E260C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552723; cv=none; b=KDVrwPWJnwKZ3ekURQKKoUWqryL93OmsJk6GpPtBXOoj4Y0R1PVOsy6huW/8GPgIaXDwIY3h/Pm7n/j09SEbnCIMjx97m+6TUbkhmbI+yI4GsV872U4A4f+W57K6KdhXGRKLlnqtArVFb2DRptDfaCBTamNMLuHplcvMJyJ75ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552723; c=relaxed/simple;
	bh=qAofwyLaCqfFXe2wS/I3RsZjJtggKj/Ah91XXFai2Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVU4ZV35ONzj0uYeSc9yCHknFr5P6tGoJXpCryQRw7dVLE/F6sM4vzJWhzVsLQhTzucRCc7fA++RsESXZ0luUMJqaPcmGvwtsqkwg4xGO/Qhwj1flHETiIZb0k61nBXbbq6CPSRCGXtVLvx39fqecYGN2TvviGQvw9OjbX7qJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABw98VDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DC2C4CEC3;
	Mon, 21 Oct 2024 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729552723;
	bh=qAofwyLaCqfFXe2wS/I3RsZjJtggKj/Ah91XXFai2Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABw98VDrR21T+xC8TzqmUzsOceiZqP+wfcVeLUD3eV8Qq2mYguTJl/H4zFuIR1lMn
	 DwQBTOX3Xze02dJch2fNt8hlqTX7UBYMsL7X9jva2uYVaQn/BuUXETjEkGKGtY6DxU
	 a5Hy2Da/ZxIMkkw4y5cha72MMJdSTAK8Z32Lhj5zqT73w+nS0keJR1qpohiGtKHupu
	 22bbEf6xCSRf55XABpSXCZFgs+Vv0BWcoUNv7ygibnEwpB/VXzRPNs8ifp6aeK8JuF
	 gQQgS0ChLOBZBbAf6Zn3kgZjSaoIqruT2QmU4+WlKAayChLpbWVOP216kF2Jn2Modf
	 biaTMSgpf03ug==
Date: Mon, 21 Oct 2024 23:18:41 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] f2fs: zone: allow IPU for regular file in regular
 block device
Message-ID: <ZxbhUUuKx_zaWAx4@google.com>
References: <20241018062638.2619214-1-chao@kernel.org>
 <20241018062638.2619214-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018062638.2619214-2-chao@kernel.org>

On 10/18, Chao Yu wrote:
> blkzoned feature enables lfs mode by default, for data updates from
> regular file, it only allow to use OPU, this patch changes to allow
> to use IPU if regular file's data block locates in regular block
> device, if data block locates in zoned block device, it still uses
> OPU.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 12 ++++++++++--
>  fs/f2fs/f2fs.h |  5 +++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 949b6bb957c7..c6d0e4aa12e3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2648,8 +2648,16 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return false;
>  	if (fio && is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>  		return true;
> -	if (f2fs_lfs_mode(sbi))
> -		return true;
> +	if (f2fs_lfs_mode(sbi)) {
> +		/* no regular block device in mainarea */
> +		if (!f2fs_blkzoned_has_regular_section(sbi))
> +			return true;
> +		/* blkaddr locates in sequential zone */
> +		if (fio && __is_valid_data_blkaddr(fio->old_blkaddr) &&
> +			GET_SEGNO(sbi, fio->old_blkaddr) >=
> +					sbi->first_zoned_segno)

What if there's another regular device beyond zoned partition?
I prefer to keep the entire area as lfs mode to simplify the performance.
Do we really need IPU on conventional partition? Why not asking to use
file pinning, if someone needs IPU?

> +			return true;
> +	}
>  	if (S_ISDIR(inode->i_mode))
>  		return true;
>  	if (IS_NOQUOTA(inode))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 55bcd411257a..6781b4fab43f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4790,6 +4790,11 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>  	f2fs_invalidate_compress_page(sbi, blkaddr);
>  }
>  
> +static inline bool f2fs_blkzoned_has_regular_section(struct f2fs_sb_info *sbi)
> +{
> +	return f2fs_sb_has_blkzoned(sbi) && sbi->first_zoned_segno;
> +}
> +
>  #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>  #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>  
> -- 
> 2.40.1

