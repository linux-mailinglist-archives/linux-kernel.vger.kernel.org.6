Return-Path: <linux-kernel+bounces-350510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C95990630
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A930C2815FC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92712178EC;
	Fri,  4 Oct 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJss5F1+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150C15749A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052473; cv=none; b=qUyaORyrUbcChk3KPSXZB6xOByNpaEgvimVyYeD+zX+iBIC4mvLO1U875dSBSo4oLeziRcz9tuZdHZ3giv5rTF6pBSIgCfuArG1lk4D+pz2Qgycxj+R9IOatqv0XgQSq1vDHDz8Xt5MqO/tk6SdWNxiTM88kiVqftYhjtWL5c0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052473; c=relaxed/simple;
	bh=3aISpKShlj2CHhji8UWYU36L3jXAJvB4tTlbTML+Ojk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXKVho/jcqdp/PnNS7ea2ZZTZoT1Qb7wz7owIN8ga6CyADWT5WHNcKZcWWGqzJhRnKTKRWUY31cElg0VTrpILQNHZbsRdR1UnoTOAkQuQ2fbDcsqVCT8o1hnPzo5RHCJnXRWcB1twQhytAcT2BJJ85p9SDuAM2TsS9TTBW0Jdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HJss5F1+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BC9nmJQQ1vJwIExoU2h3dhDujW58HlT3FVP8MyhAdQc=; b=HJss5F1+g38swUPnFDJH9KrDJA
	LhrCoCqCgS0mvyxE1FZ8NpUZA3S4MphJoY4Rb4+hklrXJfb/X2R8Wi27nDUmi9BKOf9BOlZaBNvwf
	kInkkYvTDNageGqRq7n8jHDqWv53TlNuS06gXXr6wrbCMIBb5MGNBuYzJaEVlg5/iedI3h/jxIJnM
	LqLA+UkfK92osndoWv46O13SbAtDUBHt+UlUN5vsI5snQ8FAuR0LCUGzUdbTJhrZBtJoGUEXrn4+N
	6iQCgTfoRXZBasXqloJZh18BaJpwbk5bGO/S8TalfW28WbeiPOqhnzPD5Pb1dM4TMhoedRCnLuITu
	QwSxHKqg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swjNt-0000000AbyT-3pxw;
	Fri, 04 Oct 2024 14:34:21 +0000
Date: Fri, 4 Oct 2024 15:34:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: swap: prevent possible data-race in
 __try_to_reclaim_swap
Message-ID: <Zv_87TBZnh2lIwyH@casper.infradead.org>
References: <20241004142504.4379-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004142504.4379-1-aha310510@gmail.com>

On Fri, Oct 04, 2024 at 11:25:04PM +0900, Jeongjun Park wrote:
> A report [1] was uploaded from syzbot.
> 
> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to skip 
> slot cache"), the __try_to_reclaim_swap() function reads offset and nr_pages 
> from folio without folio_lock protection. 

Umm.  You don't need folio_lock to read nr_pages.  Holding a refcount
is sufficient to stabilise nr_pages.  I cannot speak to folio->swap
though (and the KCSAN report does appear to be pointing to folio->swap).


