Return-Path: <linux-kernel+bounces-302700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BB960211
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2497D28110A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5161149C7A;
	Tue, 27 Aug 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MDj1d/+W"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23713D53F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740826; cv=none; b=AqkbGIWqaqWT57mE/Jdmp5uZMpQJmVNvwVUgDG5OPwzXo3nF9iZ2b7+0rQLuDIRTMy11hRs7Z96ji1CIN1y1B3knY4KHiM9Xa/dYtsN70FmK4ncgCvG8YiziDSkwLXcJ1b43wR8i2JvkoOSVP3z2ES6ahiGFo9YdnR1mm3EC0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740826; c=relaxed/simple;
	bh=uAcZu4y7bLgSB9heMOo1Yp8Y1l5hXVmDLaXgDUIlAH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1z0qmC1fyS1KJynxTWqw3OVgh1rF3KJATKo2Ubk44wRWyZhuE0maYwSJWxgZMHVdI6ycrIYVqYb0zFns2MvsabBbz7WwhqknEgNNaCPNnHzlkc18Qiqte4Qx2ASNgvZZhekzJisQjXovi7ixemVGXEz8+2ZOndJULOqpCzER8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MDj1d/+W; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 02:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724740821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQptxE7qA2VWIgX3oNQ1mmeqR6GHf9K4w2oDVMxZa14=;
	b=MDj1d/+WOS5gCRitsfLH/21htkLMK4K2TIyc1MjdWb4dK3v74eylUATRf/+g4Be72CAJh7
	fzv9vUbTA26ve+x7v0o/7FORTyGpY9JqJ7tG7RX0B1mJDSXS3uyYkuxYyVHjkQ7D+uAV3R
	GAQt+lBjNurKvR3kiN0ZcLosVVtHkqo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ru3d2bfrnyap7t3ya5kke3fqyrnj2hgbl4z2negbqkqj7z4mr2@gqrstl4lpl5h>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
 <ZszlQEqdDl4vt43M@tiehlicka>
 <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
 <Zs1rvLlk0mXklHyf@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs1rvLlk0mXklHyf@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 08:01:32AM GMT, Michal Hocko wrote:
> You are not really answering the main concern I have brought up though.
> I.e. GFP_NOFAIL being fundamentally incompatible with NORECLAIM semantic
> because the page allocator doesn't and will not support this allocation
> mode.  Scoped noreclaim semantic makes such a use much less visible
> because it can be deep in the scoped context there more error prone to
> introduce thus making the code harder to maintain. 

You're too attached to GFP_NOFAIL.

GFP_NOFAIL is something we very rarely use, and it's not something we
want to use. Furthermore, GFP_NOFAIL allocations can fail regardless of
this patch - e.g. if it's more than 2 pages, it's not going to be
GFP_NOFAIL. In general you can't avoid having error paths for memory
allocations, and GFP_NOFAIL can't fundamentally change that.

Stop trying to design things around GFP_NOFAIL.

> I do see why you would like to have NOWAIT kvmalloc support available
> and I also do see challenges in achieving that. But I completely fail to
> see why you are bring that up _here_ as that is not really relevant to
> PF_MEMALLOC_NORECLAIM use by bcachefs because it demonstrably doesn't
> need that. There is no other user of the flag at the moment so dropping
> the flag before there is more misuse is a reasonable goal. If you want
> to bring up vmalloc NOWAIT support then feel free to do that in another
> context and we can explore potential ways to achieve that.

The inconsistencies between what PF_MEMALLOC supports and what gfp flags
support are quite relevant. If gfp flags aren't plumbed everywhere, and
aren't going to be plumbed everywhere (and that is the current
decision), then we must have PF_MEMALLOC support.

