Return-Path: <linux-kernel+bounces-510471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29469A31D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AEA1672BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111C1E260C;
	Wed, 12 Feb 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yf6X/ZnH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA227182D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334501; cv=none; b=Rvr8HpETCrJVGpV0DyjfJxqPdZwoTvAZ1Zop95a+l1pwR2s3g61yigqxHIncXkjOKeq0FPchf3MGXyEjqLvBauOo6jCO8D+BXR/bHvGAO73aDJu9XrRWltUPbXdB2KzljzXx7RJ0+pFmE9Kt7N/+0tXYFRIuQhMRffNLbhdfIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334501; c=relaxed/simple;
	bh=rxGjGOf9cJ20a+x6QxHSnXLoh3WtfjioDaShbKpVv74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK4BjhoGkCXDFJ3QCJDdIDGLE5dXOTp3PyqAgKOf9vgEn18fihnXuatzSk+qC+hkFnmmJDzgOa2ROOLZO4WFxvb/DD/Keo0nh+EhhUZPNNpi+ZXuMx5XG8e5HKWRoiu65jtOImaj0cQ1K8HGuTbpeZf7oocTJ3qd2cz/bdILu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yf6X/ZnH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HjowFBZjHeZYOplTepD05PX4mWsm7bGiAj/uMGBz3po=; b=Yf6X/ZnHpb9Wu6Dx7nt/Ty3ZnD
	Iqx8SMLOwhMyh3H4uvprU+fhdtU7/iWNi6eVjht2MO7GM0sLAPPkA1srVE3O4ec1J9WPBeNkYRf6v
	2yBS3OVO8LCsutZV0rbw5268MvvCK/rXw+SOkFhCIkUp5PfswhVilH/CUxEJ+Gt6Zqbr8wit4LL9F
	6PZ6SYy+vNYU2thcSxUY04KLzVgy4W3zfp9tbuGy1cPxJ24sPSVVYM+BXJhtulHD0K8t+ujIBfj66
	olEMVbQ6kefMhH5zxVPFZzQ0FZNR/mCEcwYvaZQo6FgMpBfkXSLvkk7BnFDA2vT2z6arMlGZUdtZp
	Y+iS9j8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ti4MD-00000003FT0-1zF0;
	Wed, 12 Feb 2025 04:28:17 +0000
Date: Wed, 12 Feb 2025 04:28:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shengken Lin <shengken.lin@amlogic.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant PageMemcgKmem(page) call
Message-ID: <Z6wjYQUxIstEqJHC@casper.infradead.org>
References: <20250212020627.3461237-1-shengken.lin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212020627.3461237-1-shengken.lin@amlogic.com>

On Wed, Feb 12, 2025 at 10:06:27AM +0800, Shengken Lin wrote:
> The function of PageMemcgKmem(page) is the same as that of
> folio_memcg_kmem(folio).
> 
> Since __memcg_kmem_uncharge_page already uses folio_memcg_kmem to check
> if a folio has been uncharged, calling PageMemcgKmem(page) before
> __memcg_kmem_uncharge_page is redundant.

But it saves a function call.  NAK.

