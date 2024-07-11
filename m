Return-Path: <linux-kernel+bounces-249265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84D92E8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E341F2426A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0F15EFD0;
	Thu, 11 Jul 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2bNu1X/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18815E5BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703317; cv=none; b=pzj+7g5ygyspAdf0l0mWtWiKUgprACZOwzWPmMqWunhnA6e0M8goWij/1e85sZci0RbbR3NW5xqHwN1uF1D8uiL7cvsJ8Y0luTOiFA8AE9121FLtUPEC6hopTE0dCdCCADRO5ewROJDr5lYGKrp1sJeEiovrCr/cIFOEcy3/z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703317; c=relaxed/simple;
	bh=vFtisb/LyjrfNctB1QrPn60UjNVpu84iPkGnS79yVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uteI9HP9ydlZy3W2W1an6Q/DEfm5LDuMzB7zTiatdJJqN6xLE3ypzJCCQEq+s0WZVF2P6GMerJusvRmNrtbU1dv8gV1G8bMRQvNUPH4HtSGuvhp5rWZ+5aMXRpZTh5tbcOhB7VMjHZ9dOghgylVG2mtKbqIyz8XgGBcIrzBDems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2bNu1X/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NFf3uHXmFSDdJu+av0ve7/UXaiDn+6SGLQPlv++sSyU=; b=E2bNu1X/yDxVrx/nEoo7IDC3NL
	0uwB9UaGXE20+DTNR5HghBzsZJJF0KPm1ryc3odKJKaxEHw2kLr9QIdfe1xvXXc46Oy9Zk+lccxMX
	X+X/mY4FpBKnPAUrxHAo6LWMDWRK6UQEqCh8lAffvLwAKwYxygk3yQJNy0VfLfDObrE77cqFM+7D2
	cWj97klHOpgfO38s8DDNhDdIJ+U2dGtO/gfMHj3ptUJSlG002YudvJJN2XmWdWE6VR+WIQbLMriKR
	62bUKFw/qi43h90jYsbMaHCTMO3ZMzJwp3SknDI5e0RZeE+bMxnUuEAvr/BGrV4WK2wXokx/waC0a
	U08WAMXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRtXF-0000000B7ls-0Jvl;
	Thu, 11 Jul 2024 13:08:33 +0000
Date: Thu, 11 Jul 2024 14:08:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: unified folio_test_anon()/folio_anon_vma() and use
 them
Message-ID: <Zo_ZULOseAmEQMIw@casper.infradead.org>
References: <20240711130351.2830-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130351.2830-1-yajun.deng@linux.dev>

On Thu, Jul 11, 2024 at 09:03:51PM +0800, Yajun Deng wrote:
> +++ b/include/linux/page-flags.h
> @@ -691,7 +691,8 @@ static __always_inline bool PageMappingFlags(const struct page *page)
>  
>  static __always_inline bool folio_test_anon(const struct folio *folio)
>  {
> -	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
> +	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
> +		PAGE_MAPPING_ANON;
>  }

This is wrong.  KSM pages are supposed to return true for
folio_test_anon().  I haven't looked any further at this patch, since
the premise appears to wrong and you clearly haven't tested.

