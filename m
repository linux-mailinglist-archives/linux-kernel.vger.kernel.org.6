Return-Path: <linux-kernel+bounces-232406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23F91A85E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8201C20A79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCA194C84;
	Thu, 27 Jun 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yz+NUgDx"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63C194AEE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496446; cv=none; b=mpfzXVvg6a50ezDrzk6nnx3wTapPr4ckA2g+kNErQl8YSKrscrlqnKtFB2KPEeIkJkI4z3u0oLtWC3su92XkmKF7HZ4lTuJ9kSNMZSHtX1e7/HUndaY+z2MyzsOMW1Uy4V5xffZx0tAR4F/BrsAWDLxV0ZalVUK06M9y4QzkKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496446; c=relaxed/simple;
	bh=BhyQjUB20DyNLCbsVlNcG90NSdLghe8EYXQE/AWy5kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lk6mw/VvI4fb8JUauJGsfZVI6GLupOJ5TrVIxSi+Nz3MZS9s3btXINpMwn/D15iJJyJfyTzd3L7vTgximMWlKR3B/ACM4Fx4oXhNXvrIoxQgXoNAFBqZqqC28stkq4LjfEwfECXzYs81fHw/jd3+J2KjCUAe5ELoG8phVS6I3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yz+NUgDx; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719496439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0OO5DYnxjOEWbc1tryLeGsCPnuTvb2MssSGWS2a+zQ=;
	b=Yz+NUgDxFfnrapkDKi0FEgLYBzp00I+FLUhEiqsNLLZUI3n/poZk80GOHrtEBLKIV1gbje
	//mpoA+aQJ67ZZeZ09wKqk88CPq9tdrMJPi0U3Z/8oN6ZOdAcOcFX6VvqWt3M2xP99xuWj
	K+Jgdw/IiDbhq6SVWZyEgQxtoNi5D60=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: yi.zhang@huaweicloud.com
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix infinite loop when replaying fast_commit
In-Reply-To: <20240515082857.32730-1-luis.henriques@linux.dev> (Luis
	Henriques's message of "Wed, 15 May 2024 09:28:57 +0100")
References: <20240515082857.32730-1-luis.henriques@linux.dev>
Date: Thu, 27 Jun 2024 14:53:52 +0100
Message-ID: <87a5j67aq7.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Wed, May 15 2024, Luis Henriques (SUSE) wrote:

> When doing fast_commit replay an infinite loop may occur due to an
> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
> not detect the replay and calls ext4_es_find_extent_range(), which will
> return immediately without initializing the 'es' variable.
>
> Because 'es' contains garbage, an integer overflow may happen causing an
> infinite loop in this function, easily reproducible using fstest generic/039.
>
> This commit fixes this issue by unconditionally initializing the structure
> in function ext4_es_find_extent_range().
>
> Thanks to Zhang Yi, for figuring out the real problem!
>
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Gentle ping...  Has this fell through the cracks?

Cheers,
-- 
Luis

> ---
>  fs/ext4/extents_status.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4a00e2f019d9..3a53dbb85e15 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
>  			       ext4_lblk_t lblk, ext4_lblk_t end,
>  			       struct extent_status *es)
>  {
> +	es->es_lblk = es->es_len = es->es_pblk = 0;
> +
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  

