Return-Path: <linux-kernel+bounces-510432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DCA31CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662B31884A41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9731D9A54;
	Wed, 12 Feb 2025 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMdZqc0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD527183B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330668; cv=none; b=bu6i7l6k0vwmfWTW8uCCnNUgKwmhVtOH5z4M8fCjxiLUebCL4NH3Mbx52+9PvBwbezepAzX40xnnRwtZdQ585sP/HtHFFwnGON6q/xQ25eGBSc0gwm609ml2gHIkxhHw4EQgq0MaeafWDXsRGcWLN7It61eyOGmfnbO92SIj+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330668; c=relaxed/simple;
	bh=dy4F+MGp9D9JulVy4MJqpsD5oPjbC4M5GjqzusIpkoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2bKeiLyg2PL7m1XXgNbYQMqIgo9hedTlvJsdh2g00z3VXJ0ioel+98h0djZpGigsli0qRaiCozd8VLJnzb+38l3VWEINrq3qIgN68ECkl9OGR8R8PdqfRt6QS4Rn2axTtAEu+zkW0Yrs/HTu1iyg/vn3Ff58iZmAjNKiNsGJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMdZqc0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01FC4CEDF;
	Wed, 12 Feb 2025 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739330667;
	bh=dy4F+MGp9D9JulVy4MJqpsD5oPjbC4M5GjqzusIpkoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMdZqc0EAKiHlAQPK8T0z5op3FSxOPWxOGBBaDFnCJqddUE7Yr4NLuE8C81/I1U4X
	 7H9Dx0iKGAfA8p3KYCNiNuKPli2Q0UVUkvQi9p9z38weM0lqBCS7Iz5pxGwNl6hCVm
	 ZNEMDbh9He8jjMLlZry8iV6HqjpNrpsh8VsA/WGrfqKU4ZyINHGHgTD5WKW++AmtsW
	 yJsEZYJKkCuIByPh0Bb3YmeydYq/HyeytdSI8NLoafVX6IvBs0D11oHokb2bQ00age
	 UsUKLlercwaGpdm6eFuxcLZpqmpuX//bzV1LeQpOG+R6kzKkVmNw0UZq6QJQm41Kwa
	 NSwDYY8OXmR+g==
Date: Wed, 12 Feb 2025 03:24:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 RESEND] f2fs: add check for deleted inode
Message-ID: <Z6wUaT91OnABzNfQ@google.com>
References: <20250211071725.457343-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211071725.457343-1-chao@kernel.org>

On 02/11, Chao Yu wrote:
> From: Leo Stone <leocstone@gmail.com>
> 
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> [Chao Yu: rebase the code]
> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> - no logic change, just rebase the code to last dev-test branch
>  fs/f2fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index d6ad7810df69..543fb942bec1 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		}
>  	}
>  
> +	if (inode->i_nlink == 0) {
> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
> +			  __func__, inode->i_ino);
> +		return false;
> +	}

This gives a wrong EFSCORRUPTED when recoverying orphan inodes.

f2fs_recover_orphan_inodes
-> f2fs_iget_retry
 -> orphan inode can have i_nlink = 0.

> +
>  	return true;
>  }
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog

