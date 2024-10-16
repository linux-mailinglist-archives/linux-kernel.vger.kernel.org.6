Return-Path: <linux-kernel+bounces-368338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2B9A0E88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D45B279EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73D20E02F;
	Wed, 16 Oct 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PZWWOk03"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37ED54720
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093083; cv=none; b=L3pOOaLva9Y7F7e5fjDzzmGhfxNZbCBJU1pl94cHITD8ghXFAj38GVC9tmo17K2MqdKwYw0rQFuKxN8FYCskww0yiCONS0DgMHBnI7IGgGp0Yu4sKNCBaUF8qF07PZRiAh3uOrBv6ekR7k+14lDiRQDoSblB59o5/986PuHbMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093083; c=relaxed/simple;
	bh=NKBeUU2C2029C+iUhop9Nzweyb84SlkdW0dRWtxqJCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz7/r1722jdZ7fpt8Ogp8//guiADe4csVH4ijv+BetkmshDYLTbe+T3OvxUU4Khy2r5yAmE/WFFnDZyDKosshCm7PKSWRMhmQpU9Xv2ULaLlFIF9uA9Etn3WhkhMfAjWmXX4JaNic5jQVUiBlZn/ttoQu7IxVqi3V51vQIg7i64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PZWWOk03; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NE/daF3JwSlAOHoHFySuoCdtdh/nK5By8Ql8VqAMJdQ=; b=PZWWOk03YymV9i8fSPmYETeYdU
	mePBbxPtqyNy51/xnqtP2chxnEgKVphBP4GiWmdJhyZm4/96KluzISKDb/RHLQ4v/H6g8qgHNhrhA
	ijYkWh+Ozk1U9gkf0R1NtfA6ExnLFD/1K3SZu3kB9QpyrINgYZw0gH1pAGbPvnY5yuHmnhuli4IkY
	9CvcF+m6hI9aDdn29XxtoQAMcv/HuYT6Sql8ptWPpNzdVBc4TV6Rbt6iLfvMdQFdAI2p/Xh4lQwcI
	28zM0hU8h1B4zWySnLRW/7PA/yMTemsXk8pIYFrc4+kV+C6tMEdP7QWgkdrY+aOr7ovVcKp1GNZGO
	HJS5YXxw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t165w-00000008Jej-1xLm;
	Wed, 16 Oct 2024 15:37:52 +0000
Date: Wed, 16 Oct 2024 16:37:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read
 performance
Message-ID: <Zw_d0EVAJkpNJEbA@casper.infradead.org>
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>

On Wed, Oct 16, 2024 at 06:09:30PM +0800, Baolin Wang wrote:
> @@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		if (folio) {
>  			folio_unlock(folio);
>  
> -			page = folio_file_page(folio, index);
> -			if (PageHWPoison(page)) {
> +			if (folio_test_hwpoison(folio) ||
> +			    (folio_test_large(folio) &&
> +			     folio_test_has_hwpoisoned(folio))) {

Hm, so if we have hwpoison set on one page in a folio, we now can't read
bytes from any page in the folio?  That seems like we've made a bad
situation worse.


