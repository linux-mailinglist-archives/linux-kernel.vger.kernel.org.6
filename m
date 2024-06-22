Return-Path: <linux-kernel+bounces-225492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A658913139
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5161F2360D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838DA441D;
	Sat, 22 Jun 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cOq92MGl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5D1FA5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719017981; cv=none; b=c5lysBUTMX7hv8FaDcG2o/bYOSJZuMoTnZ2Sv0vbHi4e5WDlseSrtQHtjtyUNbkWXKOcKfjxVlvDdXFouDcCM1KH7lDOriUBGoQ9PtE+YuBMJJFKOCQLCWbGrwYENw5OjLr9TfG6CywslSIl4rCpOTFYqTwb6S3dn0Nw4i3csQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719017981; c=relaxed/simple;
	bh=l6E+/pOFYoPz0/65BUpxauVRh7+RaH5Xm9C9eF+VW2I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hb/aVygLWvyUDfmKtnULDhsTlbFvM5EvtoXNHIUl0I/4O22eupa71H4mpSgSo+wN23cWDqodoPHwxxmgJQ+A8CdFRed2ib4op4Ky+osBzHwH4ajgv+v7rJ2sqA3mqKV226y8Zn6nEKwrmwEtCQZVkIV2XThiSshFniA5ydhOWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cOq92MGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5D3C3277B;
	Sat, 22 Jun 2024 00:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719017981;
	bh=l6E+/pOFYoPz0/65BUpxauVRh7+RaH5Xm9C9eF+VW2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOq92MGlyu8ofUwJuq3p0k9a1CQ9ZHqycqJ41yF0KLkHNM/aPVxEILaBIc9abxNfO
	 OByVRBpGAGCZiN2Lin6Iz8uQEx+5a3K0Diwx8XsCt9JEM/CuTsvIUomageXp/JpB4l
	 DSSgJf3ZxFmZO9QnbuN5xyFEjVxCMfEzFgrGYZG0=
Date: Fri, 21 Jun 2024 17:59:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
 hannes@cmpxchg.org, anna-maria@linutronix.de, tglx@linutronix.de
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in
 vmstat.h
Message-Id: <20240621175940.dd080730047a3f5f5a190ea0@linux-foundation.org>
In-Reply-To: <ZnXC5Xa4R0Mp7FCB@casper.infradead.org>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
	<ZnXC5Xa4R0Mp7FCB@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 19:13:57 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jun 21, 2024 at 01:16:04PM +0200, Shivamurthy Shastri wrote:
> > A W=1 build with -Wenum-enum-conversion enabled, results in the
> > following build warning due to an arithmetic operation between different
> > enumeration types 'enum node_stat_item' and 'enum lru_list':
> 
> OK, but why do we want -Wenum-enum-conversion enabled?  The code looks
> perfectly fine before, and now it looks ugly.  What bugs does this
> warning catch?
> 
> >  static inline const char *lru_list_name(enum lru_list lru)
> >  {
> > -	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> > +	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
> >  }
> 
> and honestly, I'd convert it to an int instead of enum node_stat_item.
> Because it is not a node_stat_item, and it wouldn't make sense to
> add two node_stat_items together.  Just like it doesn't make sense to
> add two pointers together (but it does make sense to add an integer to a
> pointer).

Yeah, I suppose so.  The calling code iterates across enums with an
int, imaginatively called `i'.

Then again, it seems right that a function called lru_list_name() takes
an enum lru_list.



