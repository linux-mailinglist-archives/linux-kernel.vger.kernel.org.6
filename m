Return-Path: <linux-kernel+bounces-243823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF1929B19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1CA28127A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF44C99;
	Mon,  8 Jul 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UD2/ly6+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DC79C8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409664; cv=none; b=cE03VmB500BMW0UFn6Va4dvZ1Fc91RCq4JOfCGLCqev4vYfgRjxcEf9SYiuZov26LrQse1oRKFrmy57y70GnLTXeUKhJB2UnyMtlg3l2HgyqALaEMmtTA6sXQNwxMbtkO+b9DK4ARfh9LixHtl5IANovKKmtyIbJWOjfaxPKQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409664; c=relaxed/simple;
	bh=XXJkcWJ9CeBIPpMba+VPQijB8Fbv2R0CPb+fyPo8DUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/ty1mE9fBKKHyogO7RYAdkvMU09fP+WDGKc6k1ES3c5S1ckEbLfdOTY+NYlBMZ1u3VKMtf0fJomLPevaZyr17dmOcHZEgPmO0TIYUErHkGDmG1YG6NkP1ba5In9rjEc43z0tEn8Y9kGWfO1Zm6kf9apzvBuZTPFe0ELCdDFP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UD2/ly6+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lDiS3S66EExdt/3IE9jCdjT0bUuwhnzTrpGok8jEgno=; b=UD2/ly6+K1NUobueGrLIC1xdgU
	U0qya1U2TwMVp5yPj5zyZiU0bkXtqwgvC0fgUvIIpMfjvsQ/aA98eyQQ5rvgdgCJbV+C/But1WrPq
	rkdvAT+A4iRO4kgOUCPVBxS5zzgX6ZCzmKDy1sK8icrP3W9+6/yzbYU2j9W/zMCmzUigSYf6NmQNc
	ruQzM8GvlDFKuwkwy6a42O5LaiE3v//WbggCYJ4h7d7FbOLaMMpLWI3CzdEtC776yGBpTC/VxjFC/
	LPwyi0szZBbhov2C76pdtaL6AJxXDiTX0ciFoWSHZQzL97jvZCdx9PhpESJnBlzNEXQJLrZniogx7
	N06QVUyA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQf8r-00000006THx-1fFh;
	Mon, 08 Jul 2024 03:34:17 +0000
Date: Mon, 8 Jul 2024 04:34:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
	opensource.kernel@vivo.com,
	Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
Subject: Re: [PATCH v4] mm: shrink skip folio mapped by an exiting task
Message-ID: <ZoteOYap1M4kxWV8@casper.infradead.org>
References: <20240708031517.856-1-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708031517.856-1-justinjiang@vivo.com>

On Mon, Jul 08, 2024 at 11:15:17AM +0800, Zhiguo Jiang wrote:
> If an anon folio reclaimed by shrink_inactive_list is mapped by an
> exiting task, this anon folio will be firstly swaped-out into
> swapspace in shrink flow and then this swap folio is freed in task
> exit flow. But if this folio mapped by an exiting task can skip
> shrink and be freed directly in task exiting flow, which will save
> swap-out time and alleviate the load of the tasks exiting process.
> The file folio is also similar.

How is the file folio similar?  File folios are never written to swap,
and they'll be written back from the page cache whenever the filesystem
decides it's a good time to do so.

>  mm/rmap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  mode change 100644 => 100755 mm/rmap.c

Uh, what?  Why would you make this file executable?

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 26806b49a86f..16b7ed04bcbe
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -843,6 +843,16 @@ static bool folio_referenced_one(struct folio *folio,
>  	int referenced = 0;
>  	unsigned long start = address, ptes = 0;
>  
> +	/* Skip the unshared folios mapped only by the single
> +	 * exiting process.
> +	 */

Comments start with a /* on a line by itself.

> +	if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> +		!test_bit(VM_SHARED, &vma->vm_flags)) {
> +		pra->referenced = -1;
> +		return false;

This indentation is unreadable.  Follow the style used in the rest of
the file.


