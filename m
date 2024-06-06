Return-Path: <linux-kernel+bounces-204281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE38FE6AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A9282143
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9F2195993;
	Thu,  6 Jun 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tnaMhI/b"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090C13B28A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677498; cv=none; b=ul9t/LD7UKv2ecdQdsFpIvnqeISG/yoW5ma02DxocLT6fks+434mLO52NuELw14WQItuWT7fWuENt7P7LF42Fm+4kWPSnM2FGuv8IBSMOgi/eJXmV6AWN+OQNSYUZ1/+xaC3DZ47/BwtSWPihesniBkr1CkkeRM/mY7k2pjLbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677498; c=relaxed/simple;
	bh=As1pZa7eTukJhlvtuFr8QZj2m1//MHH82Nzoo+Skxkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8BY6v2/7/gf7VH0r7lPgR/DX/7SkLnEVumPUTDC5jyo9V6GkOJuU0X7/vWmgY+vcSCLaiTlwAX+ahB8dMYb3Q7suaf0TEhKMuI93KrfVi7bQ6wGz7SuANP9QUD+TGzST09aMHgmktzcJx9eMIZVBnA/LczTJblZIDziN8pi474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tnaMhI/b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wTgnAQ+pKxAYFknJ3Qb4mN2BUWUuDM11bEhEheLrtn8=; b=tnaMhI/busE8aGAHG/PxrF7UmB
	6Zhok6QfwzslX5poFwaFdTfywNDnbQcCPC7cF4smgnr2K5t+S7duTWug1nQklpcRKwMGbY4RH8Fa1
	+8ltCuaHgx+yCRWzbtvsLRnCavYO86FnkAik5P7zJrm6oTWA+0LKscjJi8TIvzHqiSN9x6UInbQt4
	HM71Ag6keJHCp8LTppHUsh1oZigC45fjo94Rt/gYHrXhiyKYAyRADCBIz/twwBaEOnRiHv1MfK3bM
	1UkA60YFZOhAdVWhod2JzyoGnMMNkW5/gAd9XVs8wUc3A9dtsEiGJLf2iFYJPpE23wREXRGiph2zS
	87HxemXA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFCNi-0000000EWBT-43Q7;
	Thu, 06 Jun 2024 12:38:14 +0000
Date: Thu, 6 Jun 2024 13:38:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: get rid of buffer_head use
Message-ID: <ZmGttup4xQM_jWky@casper.infradead.org>
References: <20240606095037.4086881-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606095037.4086881-1-chao@kernel.org>

On Thu, Jun 06, 2024 at 05:50:37PM +0800, Chao Yu wrote:
> For later folio conversion.

What tree is this against?

> @@ -3957,32 +3976,32 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  		return -ENOMEM;
>  
>  	for (block = 0; block < 2; block++) {
> -		bh = sb_bread(sb, block);
> -		if (!bh) {
> +		page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping,
> +								block, NULL);

You need to use bd_mapping, not bd_inode->i_mapping (since May 21 in
Linus' tree).

And I don't think there's much point in switching to pages as an
intermediate step.  You may as well go straight to folios.

		folio = read_mapping_folio(sb->s_bdev->bd_mapping, block, NULL);


