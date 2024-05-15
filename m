Return-Path: <linux-kernel+bounces-179343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6928C5F02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF8B21467
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BAC320B;
	Wed, 15 May 2024 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ex3VJywQ"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722411182
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737846; cv=none; b=e7owpRNuSPawSuRrOlQtFjOX8qi6C3fdgIN5YKhdrkfyNEVj/tsZRFmUPD26g0TX4W/YBgP0rHnIF2H37TtWGrM4Q+xOeOLCscXMvhl0ybE6ASQftLO6wQFa4ZHEhCvV7DD4vi827Xfhh7zJNv7E6saGYyeGxqzfUCVJXtqYLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737846; c=relaxed/simple;
	bh=pf0PLTBisxqzz0/IxYXsCLan5qUZOS6JoRqs8aKFEHU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AHRn/tfJNB5qlKI6bS9HkRbNleQbyFbMwakJAzi1QA7Y1DpvW0bgMF7paLg36RuOBAkxNkTOZgcrmQVifQrDSlfJ1rQ+AwWnPa73MwbwtNCHKTdujC61VmkHtf+PEDU6yh5UW5zI3K+qH+z5QBmsZ+FTnbG/j4mYLllu0MsS+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ex3VJywQ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715737841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um+LLAWibB7fswZ990STIjfH5bJNb9IuSwPgMuXjA2k=;
	b=ex3VJywQEJlE2rBN39osd0SXAcXK4bSWV3bXKtbbL+RgRs20rIZh9IfBHNkm52upzm0iy7
	KR1kJcROd/jLzoYJfsDSSffopfftx9Y2qLyOCLj8zYqowtDPEHUYJo0tyADVIeqef/tMBF
	X8DnmtVAzhOfP9qarR79iyKvd9ilH4g=
Date: Wed, 15 May 2024 01:50:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <6fe9f88b4d71f0f563d57eb73484bbbe9a285e6c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm: page_alloc: fix the incorrect parameter
To: "Johannes Weiner" <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240514124015.GA2697047@cmpxchg.org>
References: <20240514065933.1523170-1-yajun.deng@linux.dev>
 <20240514124015.GA2697047@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

May 14, 2024 at 8:40 PM, "Johannes Weiner" <hannes@cmpxchg.org> wrote:



>=20
>=20On Tue, May 14, 2024 at 02:59:33PM +0800, Yajun Deng wrote:
>=20
>=20>=20
>=20> The first parameter passed to set_pageblock_migratetype should be t=
he
> >=20
>=20>  buddy, not the page. Let's change it back correctly.
> >=20
>=20
> No it shouldn't be.
>=20
>=20>=20
>=20> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic free=
lists")
> >=20
>=20>  Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  mm/page_alloc.c | 2 +-
> >=20
>=20>  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >=20
>=20>  index cd584aace6bf..5422f6f8975d 100644
> >=20
>=20>  --- a/mm/page_alloc.c
> >=20
>=20>  +++ b/mm/page_alloc.c
> >=20
>=20>  @@ -1728,7 +1728,7 @@ bool move_freepages_block_isolate(struct zon=
e *zone, struct page *page,
> >=20
>=20>=20=20
>=20>=20
>=20>  del_page_from_free_list(buddy, zone, order,
> >=20
>=20>  get_pfnblock_migratetype(buddy, pfn));
> >=20
>=20>  - set_pageblock_migratetype(page, migratetype);
> >=20
>=20>  + set_pageblock_migratetype(buddy, migratetype);
> >=20
>=20>  split_large_buddy(zone, buddy, pfn, order);
> >=20
>=20
> [ pageblock | pageblock ]
>=20
>=20^ ^
>=20
>=20buddy page
>=20
>=20We're trying to isolate the second pageblock, but it's part of a
>=20
>=20bigger buddy. Remove buddy from the free list, update the migratetype
>=20
>=20of page, then split and free the chunks back. This puts the first
>=20
>=20pageblock back on the original freelist and the second block onto the
>=20
>=20isolate list.
>=20
>=20In the else branch, it's the first block we're interested in:
>=20
>=20[ pageblock | pageblock ]
>=20
>=20^
>=20
>=20page
>=20
>=20So again, take the whole thing off, but now mark the first block
>=20
>=20isolate, then split and free.
>

Got it, thank you for your detailed explanation.

