Return-Path: <linux-kernel+bounces-272848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381B9461CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4DD1F220E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7867E136356;
	Fri,  2 Aug 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q6gQAtMQ"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630E16BE2A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616260; cv=none; b=UFloa7jWzDGoCkIfpfOEG7dp1US5iI8amldoOzXy7bPgryKLoCcCQr1wm81sLczWJv3AIxhtL1Iq97N19Nb/t7vknPsCsgOuc5FObEK5bo6GlrEcEZdH7LQMEY+w4a0/MadCCQCyIgcFX5TXoKhh5e5Ec8RqBvR8Dpbgu/E3148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616260; c=relaxed/simple;
	bh=2SxaU0mT12o6Bl2jx2MqiTjKjVwYivXcEsdDw2SUwz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOkUZ01Meayx9ubPbOrYQ/dZBdv+Sd6I1Q+twrZxlb5GAFazl7S5o69MAJKzE+9cT1Oz+61aHYL9Rqg0Kz+/2qebdz2e7kdo3lUwc7H5YUejWPaZ8Qzny5Ud+u1V7vU6NQJsRkvUuu114YNcyKNwg+FFE2mEuPd4LCvwVT5pcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q6gQAtMQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Aug 2024 12:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722616255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ozwy6taMQ03I7AoUstgAGU/ke/Rn1/4ce/KBpkiht0=;
	b=q6gQAtMQKIXlVxRGMVQrZvJ1jqynztP8V5ha/iA7TeinozTgbkfCN6O8f8WCrWYds89pVi
	3rwgKaMk0Th3JD31NvBq7Z81bv6xL41eFIrPZZJcbDSlTu3GAuunjd31GqoBE/YRCjEIt9
	Jdrafrx/WDMZnO1+O9XHAzU1VMjh9bY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Camila Alvarez <cam.alvarez.i@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: WARNING in bch2_trans_srcu_unlock
Message-ID: <brefgiw6mbvnpg5dmxhuwmoxfrh6upw3zslzn6qa6lfvbvhgi4@7vzwd55illrn>
References: <20240724010759.1631178-1-cam.alvarez.i@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724010759.1631178-1-cam.alvarez.i@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 23, 2024 at 09:08:00PM GMT, Camila Alvarez wrote:
> bch2_extent_fallocate should not return -BCH_ERR_transaction_restart_nested when there are no buckets available.
> Returning -BCH_ERR_transaction_restart_nested causes the sector allocation to retry even if there's no space available.

It seems like you're saying this fixes a livelock, but I don't see that:
if we return operation_blocked, the closure_sync we do before we return
will still wait.

More explanation?

> 
> Reported-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com
> Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
> ---
>  fs/bcachefs/io_misc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/bcachefs/io_misc.c b/fs/bcachefs/io_misc.c
> index 82f9170dab3f..b5b92ef030df 100644
> --- a/fs/bcachefs/io_misc.c
> +++ b/fs/bcachefs/io_misc.c
> @@ -90,8 +90,6 @@ int bch2_extent_fallocate(struct btree_trans *trans,
>  				opts.data_replicas,
>  				opts.data_replicas,
>  				BCH_WATERMARK_normal, 0, &cl, &wp);
> -		if (bch2_err_matches(ret, BCH_ERR_operation_blocked))
> -			ret = -BCH_ERR_transaction_restart_nested;
>  		if (ret)
>  			goto err;
>  
> -- 
> 2.34.1
> 

