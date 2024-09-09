Return-Path: <linux-kernel+bounces-320516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3458970B74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD701C2175E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF421078B;
	Mon,  9 Sep 2024 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="Bd2s99wG"
Received: from mail-108-mta226.mxroute.com (mail-108-mta226.mxroute.com [136.175.108.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B3848C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846421; cv=none; b=W9vQVok7FopTSSjnoAT/4SVgk62Qfg+J3zkVTsdnLg4LEdMu3dDAyW+Wyz8uPvcSunBYuZOx1zbf2ZmebKkVo0F/HrbY4cZfkmrSM8xH3tPd44AsvbYui7ckKLnK3UTO2IjFVZiZLwAPmpEL5XEU/0AhOO9i3o1xYV1+7Txto7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846421; c=relaxed/simple;
	bh=Vl1XZQ4ehWXP1MzoYo8Qi2riUZwXqRvGjH4Pc4zllU8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=AHzA3NCB1/Kx2TEzeLOBa3IKawWoTRkR2eoKJOv0tY7bTmmC8Ala266PYnssr+CLbZDvxLKjM8eBDZYqEquLkHQln+wHXRzbitABFQarUgHlX59OZPHhhO6SNxvNatDSu2KmsEpexPTIh5H805TK2aD9PE5TFj9B5bDFYyHflSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=Bd2s99wG; arc=none smtp.client-ip=136.175.108.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta226.mxroute.com (ZoneMTA) with ESMTPSA id 191d471a7800003e01.007
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 09 Sep 2024 01:41:43 +0000
X-Zone-Loop: 094246584e93c0cfa65c9d2ea226b1280b6d2fd6fb9e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
	From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9kRBX5Xxgx81I3Dt5y40OjvVhxCTtAFEHcZ7ysdiK3o=; b=Bd2s99wGK2LpVqDTjcFj9OPMed
	XC5i0b0X7rWKQzgJcnbYzkkmm4D2+iPZyQDMKgbMVkQw0naiR29S2xIX/TjNplRqJwYYcTPatqZb9
	dK5MUd7uKk5eLlyAmo/Jf9koVj2QiIyuVdIKDrYfOiXRhLAC9rgy5G3VvG01qRnpZNDjDDTiyhCzc
	CGev11Ps3S0eL5T3i2JYZtCNxdDdNnWecZuJqcw6SnHHUfDTCNwLYEdTWm0lkRxFJmUbtNVUHNQ1U
	2ELEJFA8vCrB5znplZ4VSmn6bl71MtXt5cP0zvd41b8rVlZdvDAa/g/dJsJSX0NK3NkBomNvckl5M
	oVutAlDQ==;
References: <20240906221208.136692-1-ghanshyam1898@gmail.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
Subject: Re: [PATCH] ocfs2: bug fix when bh is null
Date: Mon, 09 Sep 2024 09:39:50 +0800
In-reply-to: <20240906221208.136692-1-ghanshyam1898@gmail.com>
Message-ID: <ikv5ob7f.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org


On Sat 07 Sep 2024 at 03:42, Ghanshyam Agrawal 
<ghanshyam1898@gmail.com> wrote:

Commit message please even it's simple in one line.

> Reported-by: 
> syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
> Closes: 
> https://syzkaller.appspot.com/bug?extid=adfd64e93c46b99c957e
>
I think it's fixed by 
https://lore.kernel.org/ocfs2-devel/20240902023636.1843422-1-joseph.qi@linux.alibaba.com/T/#t 
.

--
Su

> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>  fs/ocfs2/buffer_head_io.c | 1 -
>  fs/ocfs2/uptodate.c       | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ocfs2/buffer_head_io.c 
> b/fs/ocfs2/buffer_head_io.c
> index cdb9b9bdea1f..e62c7e1de4eb 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct 
> ocfs2_caching_info *ci, u64 block, int nr,
>  		if (bhs[i] == NULL) {
>  			bhs[i] = sb_getblk(sb, block++);
>  			if (bhs[i] == NULL) {
> -				ocfs2_metadata_cache_io_unlock(ci);
>  				status = -ENOMEM;
>  				mlog_errno(status);
>  				/* Don't forget to put previous bh! */
> diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
> index 09854925fa5c..3242291402c3 100644
> --- a/fs/ocfs2/uptodate.c
> +++ b/fs/ocfs2/uptodate.c
> @@ -471,7 +471,7 @@ void ocfs2_set_buffer_uptodate(struct 
> ocfs2_caching_info *ci,
>
>  	/* The block may very well exist in our cache already, so 
>  avoid
>  	 * doing any more work in that case. */
> -	if (ocfs2_buffer_cached(ci, bh))
> +	if (bh == NULL || ocfs2_buffer_cached(ci, bh))
>  		return;
>
>  	trace_ocfs2_set_buffer_uptodate_begin(

