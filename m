Return-Path: <linux-kernel+bounces-382172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C8A9B0A60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F50281733
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E101FB890;
	Fri, 25 Oct 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCpmp2Sj"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B081E3DE0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875302; cv=none; b=QgXPMDNKrsz/0dIashQBFFBYxgzxvZcGNp52V64s3LZC0ex9ZdU/hHPkHGezMnNU04eqyx+EHsl8BkSyDTkGSrEzM+h6ecyU4MIFWy3xh97CekoiAe65YBvJuFzS10+bYnstpv85MemReoWMm7mJoZYbe86vsSZAd+PNa1pmvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875302; c=relaxed/simple;
	bh=XsDRiPF4GTDvq99UzyGYEZSuJoYWVf2j7flx5peKA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZq1FwHVUNqUjLb6zNq+DAJsMP/i9fIQ3Uv3avruv9S+n+8BTcgrP9kAK6xC1+Dv3iAvynR1KRVtftNLi2SpStSCQvG6ZTigGgKmHi29h1FxI7NZgkglnpHXOMKUNMPltYzdMhwSy3P/xPRDgPEquySoB2DCngVNX5rVLsKav+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jCpmp2Sj; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 12:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729875297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cf6d/KEl9yestGdJTi8aLwum34Ify9orE/WKOv1JRok=;
	b=jCpmp2SjxWPxfU97LrbbqxMci+dUUclN1b8nwuFInamGFMHlBYQf9+MdNYDofuc1WpXJq/
	bMXnNuzZgSxKZhhYqrucq3qg6mwMkFRxe5rY8y8HSIccfG7dnh3pgEMMRhjZInAKjjokMu
	pK6jERJYPL6fGeAoiLhE0KkfJXSEIAo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jeongjun Park <aha310510@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] bcachefs: fix null-ptr-deref in have_stripes()
Message-ID: <n6nisrv3mklka3whfosvhrcevivri76clgijy3ijdxfbzjkuc3@wuogkgi5kf4s>
References: <20241025115618.2908-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025115618.2908-1-aha310510@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 08:56:18PM +0900, Jeongjun Park wrote:
> c->btree_roots_known[i].b can be NULL. In this case, a NULL pointer dereference
> occurs, so you need to add code to check the variable.
> 
> Reported-by: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
> Fixes: 7773df19c35f ("bcachefs: metadata version bucket_stripe_sectors")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

This looks identical to the v1? It's already in my testing branch

(But it should be in my hotfix branch, doing that now)

> ---
>  fs/bcachefs/sb-downgrade.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
> index ae715ff658e8..8767c33c2b51 100644
> --- a/fs/bcachefs/sb-downgrade.c
> +++ b/fs/bcachefs/sb-downgrade.c
> @@ -143,6 +143,9 @@ UPGRADE_TABLE()
>  
>  static int have_stripes(struct bch_fs *c)
>  {
> +	if (IS_ERR_OR_NULL(c->btree_roots_known[BTREE_ID_stripes].b))
> +		return 0;
> +
>  	return !btree_node_fake(c->btree_roots_known[BTREE_ID_stripes].b);
>  }
>  
> --

