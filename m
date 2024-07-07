Return-Path: <linux-kernel+bounces-243457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936992965A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8482822FE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBE4C98;
	Sun,  7 Jul 2024 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V/QlLI9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850A4A1D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720318284; cv=none; b=hveVub5g/OKcv7opi2ErqPe+47rVdyveqD8erfYH0DVU0Y82h3smeKT4X6JLtwLY29XH+MgkfM7rRl6iqOLv+fdyTSPjRFyTIAfa9Qt/Z1qzUyv9mV2yic+8BcHgXXN4pbKJvm8ff9bY4bIrmFO9lyBKZVxOSi74UjFctSEan+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720318284; c=relaxed/simple;
	bh=uVV4zf6SMSVoLy2muGtpKIxe37Jvz/r6lR9ZxeJZR4M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Unvb1DoeXT+7jqUwoK+TADkUXCqhFgiu52AlPwMTKjMHM+jwhp+ynHEoCSNZHFoSLOR+k+eb8YrOln+wlyWUogLV5ano/Cu7E6X1gAxbWA1IuWRujD/GohHwnexta2mnfhWzOmEpOhAmBTJX2SSaDRFxlEISEglRzBRM5NWOYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V/QlLI9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF5BC2BD10;
	Sun,  7 Jul 2024 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720318283;
	bh=uVV4zf6SMSVoLy2muGtpKIxe37Jvz/r6lR9ZxeJZR4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/QlLI9XKXAX7glP3L70L8cnhoJ2nzp0tiUjg8kVT2YEolYmWlSShNxo6cNB5ZJs/
	 7eOL5upPHLcVJMjSSBFZ7Q44SNgz7U7Hynv3gAzDFl+iswwRpgogWhnTx0s0+8jlPp
	 sv6uk+Mdf9CUnAFR0aidIuac1vRW44z/zzam2ysU=
Date: Sat, 6 Jul 2024 19:11:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, Yang Shi
 <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>, Barry Song
 <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Message-Id: <20240706191122.134c5ae35e86c68d52bf11a9@linux-foundation.org>
In-Reply-To: <68feee73-050e-8e98-7a3a-abf78738d92c@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
	<20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
	<825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
	<7b7f2eb7-953a-4aa0-acb0-1ab32c7cc1bf@huawei.com>
	<68feee73-050e-8e98-7a3a-abf78738d92c@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jul 2024 14:29:00 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> 
> What you show above is exactly what I had when I was originally testing
> over the top of mm-everything (well, not quite exactly, I don't think I
> bothered with the data_race()). But I grew to feel that probably everyone
> else would be happier with less of those internals _deferred_list and
> __folio_undo_large_rmappable() spread about.
> 
> There are many ways to play it. I had also considered doing it Zi Yan's
> way, freezing always in the !mapping case as well as in the mapping case:
> what overhead it adds would probably get lost amidst all the other overhead
> of page migration. It will not be surprising if changes come later requiring
> us always to freeze in the anon !swapcache case too, it always seemed a bit
> surprising not to need freezing there. But for now I decided it's best to
> keep the freezing to the case where it's known to be needed (but without
> getting into __s).
> 
> Many ways to play it, and I've no objection if someone then changes it
> around later; but we've no need to depart from what Andrew already has.
> 
> Except, he did ask one of us to send along the -fix removing the unnecessary
> checks before its second folio_undo_large_rmappable() once your refactor
> patch goes in: here it is below.

Grabbed, thanks.

> [I guess this is the wrong place to say so, but folio_undo_large_rmappable()
> is a dreadful name: it completely obscures what the function actually does,
> and gives the false impression that the folio would be !large_rmappable
> afterwards. I hope that one day the name gets changed to something like
> folio_unqueue_deferred_split() or folio_cancel_deferred_split().]

Naming is important, but so also is commentary. 
folio_undo_large_rmappable() lacks any.

> [PATCH] mm: refactor folio_undo_large_rmappable() fix
> 
> Now that folio_undo_large_rmappable() is an inline function checking
> order and large_rmappable for itself (and __folio_undo_large_rmappable()
> is now declared even when CONFIG_TRANASPARENT_HUGEPAGE is off) there is
> no need for folio_migrate_mapping() to check large and large_rmappable
> first (in the mapping case when it has had to freeze anyway).
> 
> ...
>
> For folding in to mm-unstable's "mm: refactor folio_undo_large_rmappable()",
> unless I'm too late and it's already mm-stable (no problem, just a cleanup).

Missed the mm-stable mergification by >that much<.  I'll queue it
separately, thanks.

