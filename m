Return-Path: <linux-kernel+bounces-336373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA79839F2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41EB1F21DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA00126BE1;
	Mon, 23 Sep 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="agMHMDnZ"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800525FB95
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131813; cv=none; b=MIZwuzQTBbwBkKR4hn6mDXyvqayFxT6pK+5W23q9DpCqPup7fCvMvcL1uPgT0+r00NRAP/vVO6FM+xoISGALfOblf8oY9/qK4JjajMS5CrYmsiSkcljVApnxwmDXjKI1dRtjOsHiFKROFzdCvpgWrlWdrsm2e+Hmkgi4jdc52G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131813; c=relaxed/simple;
	bh=YR0Xqt8+C7mjR5jmlImSAF1hvQ4fzLLFFdhBQ6d2n1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbEL/PYINslxiJhmABmcek+pMYXR1Wxj4q/a7OHHoJdLQ5QaQmjLQ678sqk+ISwtXZooJIl3EF5I8l/dIN7NxsyLgOis9STLQbLlTeNgJVPEk1vt3hvAzIQ4C9vqJ/Qas2+B1b8ud3hfOk14jQAjyS/TaMAsQVU6nAcsRc59E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=agMHMDnZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 18:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727131807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aheXgiH8P/PbfSY7RqGe/lh6Ws0+uEzmE+gOJSefB2o=;
	b=agMHMDnZJYqAKoc/OftuqPf6artS+92E/NPmA0I1OABh7HuxX2MmOis59xZUleC/CqUNkT
	IKKdom2aZolIdpMBunDvl07/XO6KYyAlqMm5GohGhiTbAIZ06i7Apr91XXrUmDa7AZa88g
	cmcul+PcI1G8uxWc77jj5FQeaUHTi2E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: assign return error when iterating through
 layout
Message-ID: <oezma5vqvk2dqiorojwdxd4fbhaa5rpibs2ozekluyleen3gqh@t5h5lzp733ju>
References: <20240923222305.128344-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923222305.128344-1-djahchankoike@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 07:22:14PM GMT, Diogo Jahchan Koike wrote:
> syzbot reported a null ptr deref in __copy_user [0]
> 
> In __bch2_read_super, when a corrupt backup superblock matches the
> default opts offset, no error is assigned to ret and the freed superblock
> gets through, possibly being assigned as the best sb in bch2_fs_open and
> being later dereferenced, causing a fault. Assign EINVALID to ret when
> iterating through layout.
> 
> [0]: https://syzkaller.appspot.com/bug?extid=18a5c5e8a9c856944876
> 
> Reported-by: syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=18a5c5e8a9c856944876
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

Thanks, applied

> ---
>  fs/bcachefs/super-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> index c8c2ccbdfbb5..fbca0bd302db 100644
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
> @@ -796,8 +796,10 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
>  	     i < layout.sb_offset + layout.nr_superblocks; i++) {
>  		offset = le64_to_cpu(*i);
>  
> -		if (offset == opt_get(*opts, sb))
> +		if (offset == opt_get(*opts, sb)) {
> +			ret = -BCH_ERR_invalid;
>  			continue;
> +		}
>  
>  		ret = read_one_super(sb, offset, &err);
>  		if (!ret)
> -- 
> 2.43.0
> 

