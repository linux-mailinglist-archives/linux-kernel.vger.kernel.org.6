Return-Path: <linux-kernel+bounces-173983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42D8C08A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71CF1F2219D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AE3B295;
	Thu,  9 May 2024 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brH3UiF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC578364A5
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215592; cv=none; b=sWKal36WETeM68MJLy8oDvgKizbQmOXPyrNYAVUOXL4KK3jyo3msW+TFamx87erEK4FPtTFUC4XABrhjUlSAZyzKQJB2ishdW5WaFsd6+rD8wzTtVMEYLtNNeIzpYtO4yM8pr2Go5mjEtf+GU9Knud6J/6djOVFJCnog8qbrFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215592; c=relaxed/simple;
	bh=zYzZ47aIbLYgJWhf+ax5I/IicovIZS8EJW8+BM1aTIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JadPB4J0crMVvzSqnqmlhja00GJbW7zCXcZSe2XZW5fSUSCVI3GyuDLqTCp9ZEROxXWBpgK0Ai3BwF6DYUg+DWpkvFxrl1scrPCK09GY53haODdTPrDU+74ixsyAZC2tuqo8RhzjXQjUNPyzGczO8q7aOD7aBYQ6WiJanA2fhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brH3UiF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F004C113CC;
	Thu,  9 May 2024 00:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715215591;
	bh=zYzZ47aIbLYgJWhf+ax5I/IicovIZS8EJW8+BM1aTIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brH3UiF5pKt7B9d3J3arotQt31ROL88isqOCQma1jlku4vDpHehmVMl/brEbHudaa
	 A1g4FN7fUUsLQRN/SCvIq6U8dz2dpos4PASMDL8QSvbx5QM2LmwrAhYBhuM6ErOdA5
	 xtyY8RTWCcBNXphNN3Y0GvkfXGUktkFiPNx3Q3zq2AZn2e33fzKHXszB5/0o0dwAcO
	 /mzW/luTIEkkDec/fmsCMkgs5EcWk39ppyBflIgLl58/WOUBIlwDi/RiswYgiy/eow
	 SOUS0HDDnCxcA4LNIoJ9UgFjR5zp2EVmMyLooe8/mvmft18UJ5/Q2FadNk5+UxB2Vx
	 3dQSeb4lbplIg==
Date: Thu, 9 May 2024 00:46:29 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] f2fs: fix to add missing iput() in gc_data_segment()
Message-ID: <Zjwc5QGJfm6XXzOX@google.com>
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506103313.773503-2-chao@kernel.org>

On 05/06, Chao Yu wrote:
> During gc_data_segment(), if inode state is abnormal, it missed to call
> iput(), fix it.
> 
> Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")
> Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/gc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 8852814dab7f..e86c7f01539a 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  			int err;
>  
>  			inode = f2fs_iget(sb, dni.ino);
> -			if (IS_ERR(inode) || is_bad_inode(inode) ||
> -					special_file(inode->i_mode))
> +			if (IS_ERR(inode))
>  				continue;
>  
> +			if (is_bad_inode(inode) ||
> +					special_file(inode->i_mode)) {
> +				iput(inode);

iget_failed() called iput()?


> +				continue;
> +			}
> +
>  			err = f2fs_gc_pinned_control(inode, gc_type, segno);
>  			if (err == -EAGAIN) {
>  				iput(inode);
> -- 
> 2.40.1

