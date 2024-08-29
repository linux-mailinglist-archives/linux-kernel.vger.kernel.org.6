Return-Path: <linux-kernel+bounces-306770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F8964347
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE99DB254C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970E1922D6;
	Thu, 29 Aug 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YCyLr5db"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C803191F63
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931688; cv=none; b=kh2mcn1P1HD58ENOiGIu093IMILRyqWOdMW0qzY/lNZ1q2UDlbbimOgp75hSv9dO39hoOXnkwyxCH+PK+ldSPPVg9S15JgFQFnIK7yjhQ7WnRHm+d/xiLy7mnJMeFG9g5QSSizstRAZSuYrU7wo0LlPeqm/YemI66D0JAQ7/yYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931688; c=relaxed/simple;
	bh=SKn8Wh+3LeVdT/w94GI0tUKPrlK8ASkBcZKoP1WMJwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdrLWbWrTS1t4E2TiWhRqyBrI8D7fgc2eNwbPfsIyGaeYVqyVOvNOiVzI9p2oBZuVsgCyjCpS3pKtxHgNvHHuw6m0Gv+nsLmJzP81DhapWVDjmwC+JNEa4gQafHP0vKjptg2u9yzJbs6EDdi24nWlU1oR/UlYuBKQvsYVOMol6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YCyLr5db; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 07:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724931684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKn8Wh+3LeVdT/w94GI0tUKPrlK8ASkBcZKoP1WMJwo=;
	b=YCyLr5dbXqcm5dotzHuyhHb9ngGEjYnQ8wN7pUllReO/ExzMV5UKv9v3ezxkb2IQdn+bz5
	xa7uJrrLC1sySB4KbTtQ2k/8uT76ELG8adcRQDxAjIdbK3B7dNDv909OrO/SDVeIo6j3OZ
	bWt414CI3d7n5QySCSM8QW/62qUadik=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <p6474aobgxhzuhjrdrqk47p36f7pwqjkt4ubkq2oky2n3hdgpw@qq4qpywriccr>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtAg8Slmclt8jm4a@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAg8Slmclt8jm4a@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 09:19:13AM GMT, Michal Hocko wrote:
> GFP_NOWAIT is explicitly documented as unsupported
> (__vmalloc_node_range_noprof). vmalloc internals are using
> vmap_purge_lock and blocking notifiers (vmap_notify_list) in rare cases
> so PF_MEMALLOC_NORECLAIM is not really sufficient to provide NOWAIT
> semantic (this is really not just about page tables allocations). There
> might be other places that require blocking - I do not claim to be an
> expert on the vmalloc allocator.

Sure, but those are easily fixed, if necessary. We'd also want to be
explicit on whether NORECLAIM needs to be NOWAIT or just NORECLAIM -
those are slightly different things.

As long as it's NORECLAIM that should be fine - it's really only an
issue if we need to map GFP_NOWAIT to PF_MEMALLOC_*.

> It seems that this discussion is not going to be really productive so I
> will leave you here.

I think you'll find these discussions become much more productive when
you're able to stick to the technical, and when you yourself are able to
listen to counterarguments. I remind you that we hash things out here on
the list; we don't resort to things like "this has been decided" or "the
mm community says"; you need to be properly justifying what you want to
do here.

And if people aren't listening to your arguments, that should be a hint
to you that maybe you aren't making good ones.

