Return-Path: <linux-kernel+bounces-288982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F589540D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD31C21427
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DA477105;
	Fri, 16 Aug 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zH6d/rhu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57E8489
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784546; cv=none; b=Mt+/f8wexyk8wKQK+iHPi5gp/1CXNeppGui7me2VTSL+y1K5vnsUIjGEGSvY9J5XHt125nKdU81aNn1krI9KA2UwcVkY+G3WK5yBGL0AzDyIOedPaG5Vogr4BgJ7VCirfN2zmCpXwaK5bk57hDV4YUbtbqr8x9r4phE1PQ8dKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784546; c=relaxed/simple;
	bh=AEkbPxdpS1Ba7oCEoeKShqIutg2Z5i+vZsjUzLWOK8I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P843UgDYRHGsBNl+/dnc4UEqtVTECCwXQVG83MQj9iBG9rXoJLNoEF9Y0oXEuNOwyhSvy2n/z4hTZ8/L3oDAxWgQYuN5lNSsO07M2SC5e33SvGrgEoB8XLglpbUbTGko2EHCmr9nJCa1N+1x27cxSQ4D2x4epugbsWJ24BpwK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zH6d/rhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F31C32782;
	Fri, 16 Aug 2024 05:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723784544;
	bh=AEkbPxdpS1Ba7oCEoeKShqIutg2Z5i+vZsjUzLWOK8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zH6d/rhuRdJ6fGA+XdSY3a7F+ley1JXLdbDje+0mEyphAhSz0ZKAPYA+T4NM7fjA2
	 TFwc4OPNfVoyuM02a5WCuufM0ToxXVrvF9DXEmEYT/GpUkRYQDlguxR5b1JTHEuHn6
	 tRzJnJwzwF6advmIHtfGGnsQy4SEdBxxHxYMWisg=
Date: Thu, 15 Aug 2024 22:02:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
Message-Id: <20240815220224.d7970835d5c12b4833bd04dc@linux-foundation.org>
In-Reply-To: <d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
	<87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 09:58:02 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> > For the fix, I think that we should still respect migrate_mode because
> > users may prefer migration success over blocking.
> > 
> > @@ -1492,11 +1492,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
> >   	return rc;
> >   }
> >   
> > -static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
> > +static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
> > +				  enum migrate_mode mode)
> >   {
> >   	int rc;
> >   
> > -	folio_lock(folio);
> > +	if (mode == MIGRATE_ASYNC) {
> > +		if (!folio_trylock(folio))
> > +			return -EAGAIN;
> > +	} else {
> > +		folio_lock(folio);
> > +	}
> >   	rc = split_folio_to_list(folio, split_folios);
> >   	folio_unlock(folio);
> >   	if (!rc)
> 
> Okay, yeah it looks better since it seems I missed the fallback
> part in migrate_pages_sync().
> 
> Let me send the next version to follow your advice, thanks.

The author seems to have disappeared.  Should we merge this as-is or
does someone want to take a look at developing a v2?

Thanks.

