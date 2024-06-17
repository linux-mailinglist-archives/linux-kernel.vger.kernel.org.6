Return-Path: <linux-kernel+bounces-218315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D869590BC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD471C22CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D621990A1;
	Mon, 17 Jun 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T+yOyCJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DD7492;
	Mon, 17 Jun 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657948; cv=none; b=JfsJyAfaR59lNze7TTgvjn4A1czN3f7gRPOKAjxmd/0qRA5vlB5fO6WL9xOH7bPCvunPCZSlWDNUeZxRdzwWVxAT3tsYU5z5z5GsQURuKvSS0geZbAzs+wHhKB5ceei4b/Sp0XFvE5hKfzS72s4KTTQep/5Dqxcm6JFNGT05MKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657948; c=relaxed/simple;
	bh=r/evhBHUMNraidh5cABHZlCVwZYX8ZukKZmz3qLDGk4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rfhvTk0ipyo1SwFYdg2cWzquySjO3FxR/ORAwNP1yjSuOeUkVaFBlxpsZiTPDV/VgNHteRPL0KE9ljC/+TEhB2xSXzS10OGg6AsjcdrwaQCpNiWNGR7w3p6uwdy5pzUjQIbvtyzeuPzK1DyBsa+x2gkiRkr8u6vrLMzVe6DBfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T+yOyCJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA61C2BD10;
	Mon, 17 Jun 2024 20:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718657947;
	bh=r/evhBHUMNraidh5cABHZlCVwZYX8ZukKZmz3qLDGk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+yOyCJnosetdXpxxwzSmzvK0TVXxCqa3olEllMPjwQsHcOLPDa6Kw41leAiWkKE+
	 aBfyED0EHEo4ylmEb0j+AL51piBRWkaTIxWgvWlLOzcgAqBifqbp4YyJPmtYdarF2n
	 0+TnY6TwYDGdEvIcwOKBe37cU/vmlMgslyNHtpQw=
Date: Mon, 17 Jun 2024 13:59:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Omar Sandoval
 <osandov@osandov.com>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Hao Ge <gehao@kylinos.cn>,
 linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
Message-Id: <20240617135906.4bd6faecf5ab5775408bd629@linux-foundation.org>
In-Reply-To: <87bk3z1f76.fsf@oracle.com>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
	<20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
	<87ikygo1yb.fsf@oracle.com>
	<87bk3z1f76.fsf@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 13:34:21 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> >>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
> >>
> >> Should we backport this into 6.9.x?
> >
> > Hi Andrew,
> >
> > Looks like commit 46df8e73a4a3 ("mm: free up PG_slab") is introduced in
> > the v6.10-rc's, and not backported to 6.9. So PG_slab is still part of
> 
> Hi Andrew,
> 
> I saw that you've merged this into mm-unstable, thank you!
> 
> Since 46df8e73a4a3 ("mm: free up PG_slab") is part of the current 6.10
> RC, it would be great if this patch could be part of the 6.10 release so
> we don't release a kernel missing the PG_slab info.
> 
> Can you confirm if mm-unstable will get merged in this release cycle? Or
> else, would it be possible to include it in a branch that will?

OK, thanks, I moved it into mm-hotfixes-unstable for a 6.10-rcX merge.

