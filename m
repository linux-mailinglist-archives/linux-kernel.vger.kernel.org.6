Return-Path: <linux-kernel+bounces-323505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E1973E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A62F1C25449
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258219E802;
	Tue, 10 Sep 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWlvyrIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B61922E3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987962; cv=none; b=cKiqwB4h6Grs3anUDV6KpDcwa0Qbd+e9S1yEm38+2z0TZvV3LsAie6IgPUqwAdz0kocDEiQmFq9y05HEc7sfea+adElQg7YgFCeT7djxOCAf+Vbg6U9Swp0Sx8GgFEiKflmyVihMAUUeWAMB05yBPYjlOEj0FHtLZf3gfaVc+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987962; c=relaxed/simple;
	bh=9Du6n31xKQT+/2GaL7JJvZuXehy1P6YxYx3Nd2mdNDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buc+9ZxO8xBFq376xbQ0CT/zFUp35gccro7gXoRQAKkt/Ku/uOxmGFw+JBPBEzt3tUgYPYLY/xtnaTptFdZCu/lT9lEWu7qdxHElUlwNuSm8PQjR4xS7cX74XLWIXpDqKnE4NAp0kv4MZlll/1puW2WxeO27fsVJgJpKySbCE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWlvyrIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED7FC4CEC3;
	Tue, 10 Sep 2024 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987961;
	bh=9Du6n31xKQT+/2GaL7JJvZuXehy1P6YxYx3Nd2mdNDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWlvyrIXQdS5UcnYhQ0iqrSBUt/RT6WeOSeTGnjd3Vzd/mjSeR94omDWSRJ9Ob1ps
	 X6jhzqdVbE/DEcJLsmeTTcjJ3xisQsFtQO7wJPgRAmN6/HLDbbDjhrBux193ESRzTb
	 /6v4ZigjEJibgd0c2Yyl24xfOZeVlcqHSoH5C87C1itzAF4GZmv6yHtIqYBoISeukS
	 QRFVZdV+fGfEXuVs5spXv0eu9TozqVBpW8GOss2uPakSg+Dk30F36KXCl/iIDjlj/5
	 s2f5osDotFTaSG8NPbPxWMKT8a7MZD9UDinbh14PoYR5rmcTbLKwN4QLeY4yLmI+Ph
	 VGSuDpBDHMlKg==
Date: Tue, 10 Sep 2024 10:06:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to tag STATX_DIOALIGN only if inode
 support dio
Message-ID: <20240910170600.GB2642@sol.localdomain>
References: <20240910125753.80502-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910125753.80502-1-chao@kernel.org>

On Tue, Sep 10, 2024 at 08:57:53PM +0800, Chao Yu via Linux-f2fs-devel wrote:
> After commit 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
> inode"), f2fs starts to force using buffered IO on inline_data inode.
> 
> And also, it will cause f2fs_getattr() returning invalid zeroed value on
> .dio_mem_align and .dio_offset_align fields, however, STATX_DIOALIGN flag
> was been tagged. User may use zeroed .stx_dio_offset_align value
> since STATX_DIOALIGN was been tagged, then it causes a deadloop during
> generic/465 test due to below logic:
> 
> align=stx_dio_offset_align(it equals to zero)
> page_size=4096
> while [ $align -le $page_size ]; do
> 	echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
> 	$AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
> 	align=$((align * 2))
> done
> 
> Quoted from description of statx manual:
> 
> " If  a  filesystem  does  not support a field or if it has an
>   unrepresentable value (for instance, a file with an exotic type),
>   then the mask bit corresponding to that field will be cleared in
>   stx_mask even if the user asked for it and a dummy value will be
>   filled in for compatibility purposes if one is available (e.g.,
>   a dummy UID and GID may be specified to mount under some
>   circumstances)."
> 
> We should not set STATX_DIOALIGN flag in kstat.stx_mask if inode
> does not support DIO, so that it can indicate related fields contain
> dummy value, and avoid following incorrect use of them.
> 
> Fixes: c8c02272a9f7 ("f2fs: support STATX_DIOALIGN")

When claiming to be Fixing a commit, please make sure to Cc the author of that
commit.

> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 99903eafa7fe..f0b8b77e93ba 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -906,14 +906,11 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
>  	 * cannot represent that, so in that case we report no DIO support.
>  	 */
> -	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> -		unsigned int bsize = i_blocksize(inode);
> -
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode) &&
> +				!f2fs_force_buffered_io(inode, WRITE)) {
> +		stat->dio_mem_align = F2FS_BLKSIZE;
> +		stat->dio_offset_align = F2FS_BLKSIZE;
>  		stat->result_mask |= STATX_DIOALIGN;
> -		if (!f2fs_force_buffered_io(inode, WRITE)) {
> -			stat->dio_mem_align = bsize;
> -			stat->dio_offset_align = bsize;
> -		}
>  	}
>  
>  	flags = fi->i_flags;

No, this patch is wrong and the existing code is correct.  The cases are:

    STATX_DIOALIGN set and stx_dio_*_align nonzero:
        File supports DIO.

    STATX_DIOALIGN set and stx_dio_*_align zero:
        File doesn't support DIO.

    STATX_DIOALIGN unset:
        Filesystem doesn't support STATX_DIOALIGN, so it's unknown whether the
        file supports DIO or not.

Please see the statx(2) manual page which explains this too.

- Eric

