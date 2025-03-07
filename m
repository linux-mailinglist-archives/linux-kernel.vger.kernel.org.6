Return-Path: <linux-kernel+bounces-551734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A655EA56FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194FC1882264
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDB323F296;
	Fri,  7 Mar 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JqV2Dc/e"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A384217670
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370595; cv=none; b=mjQY0Gza+EusmKt7Q6/u5SOaCB7jHqY56XHOHDXsBdwSqGWpft3HhAZOldQUMGEq1xq/bEEYqxFCc5ytMMNh0igEkPjEGwBREWzb7Q/gvSZylhKxCzBI+EnWinpi2ZLQ2OCX4ZX4c97fRXhi7drNPihVFbCy/F+KMfUWAg1KHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370595; c=relaxed/simple;
	bh=/y0yzVHchA2tl17hxt6buLr2BzX+4xd+bey+kcfM4Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrP/86rYEx4IZto7o8CAwEaSahym5BRw9vsa05ofwAILUD3o6uUJ18rzunSoVH2Ty5mo4GSkh2LiSBftLncqwzujstcNjIDGLNSXFzUJXbiybUlaJ1RNSLsqDYtA6l1UalWHdK4nBOue5IKG9DFv5m5YLq84Bk6JPOhIhoIXPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JqV2Dc/e; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 13:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741370590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mJyN2r0BtqvhRSaAdiAj7zLnSs7NigSVvuaBhtuBSg=;
	b=JqV2Dc/ejzKM19hngCxJ5mTYJgPRcjA4+8pMGZwixwIgM+W5D/+KKcqCXGBzm9kb4x5q9e
	kABCujgf449BEzbSc+JOSLlf/awLFWb9ud5d/2Wkp4Z2G3YTqALNIgfYXNisUqD+bI5PD8
	5B7iIWmuaP/fQxyJ8hKYEu/OkKBh7HE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Add error handling for bch2_folio()
Message-ID: <ofpgdyoofecqonkq6jqtf4vc3wxulghupbuaw3tuyoj7t7sdoo@tusacuvnwglr>
References: <20250304040311.2081-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304040311.2081-1-vulab@iscas.ac.cn>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 04, 2025 at 12:03:11PM +0800, Wentao Liang wrote:
> Add error handling for the case where bch2_folio() returns NULL
> in __bch2_folio_set(). Return immediately to prevent null pointer
> dereference.

There is no null ptr deref, this is only called from paths where we
preallocate bch_folio (and there's only two).


> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  fs/bcachefs/fs-io-pagecache.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
> index e072900e6a5b..1dc65fef3ff4 100644
> --- a/fs/bcachefs/fs-io-pagecache.c
> +++ b/fs/bcachefs/fs-io-pagecache.c
> @@ -159,6 +159,9 @@ static void __bch2_folio_set(struct folio *folio,
>  	struct bch_folio *s = bch2_folio(folio);
>  	unsigned i, sectors = folio_sectors(folio);
>  
> +	if (!s)
> +		return;
> +
>  	BUG_ON(pg_offset >= sectors);
>  	BUG_ON(pg_offset + pg_len > sectors);
>  
> -- 
> 2.42.0.windows.2
> 

