Return-Path: <linux-kernel+bounces-523479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC86A3D767
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855513AB470
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59601F0E2C;
	Thu, 20 Feb 2025 10:51:43 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275A1F1510
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048703; cv=none; b=D/Xni6nc+neiRszR7C3/QeCDDmnTGl9kEcqJgAobWxCyvbtU2TjW1y52KwnPpFHZwTsHyEa5HIH4+5BwEW32WPLjru1PxcikypaFKvbhAUIj3eRKrBIF7XtcEIq0qL+e8Wfud/mrqVs4T64NF/mz5LpMgECXWtmv1DDGmnjpZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048703; c=relaxed/simple;
	bh=2kDN3nPBO25fmfYMhJbafNSKD40Rzjf4VVY+oJncUCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFdiyiTSWPzliaM51dbM1St0JviL8AlRpQ07HSHFxKpeH0GpQ7fCN23eKagyVXWzJYtsce+ETwhU+PfZft25bJpLwDyvSMlsOd3G4nCIqkxX9+1zaKzXHWxKx10NBRUqR5X2eqyoM0PyfLcTvzM0ukv+Y3sYrQJaIonsqbgfsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-92-67b709367d78
Date: Thu, 20 Feb 2025 19:51:29 +0900
From: Byungchul Park <byungchul@sk.com>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20250220105129.GA54095@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220103223.2360-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsXC9ZZnka4Z5/Z0g0fbNC0O/HzOYnF51xw2
	i3tr/rM6MHts+jSJ3WPSC3ePz5vkApijuGxSUnMyy1KL9O0SuDL+bPzEXHBLqOJs2wq2BsZN
	fF2MnBwSAiYSFw+cZYWxX9/8B2azCKhKfNuxngnEZhNQl7hx4ycziC0ioCzReWEWWA2zgL/E
	hFsbWEBsYYEIiSeHToDV8wpYSJxceg6sXkggQeL11P3sEHFBiZMzn7BA9GpJ3Pj3EqieA8iW
	llj+jwMkzClgKtF4/ijYeFGgVQe2HQcq4QI67SerxM7rEHMkBCQlDq64wTKBUWAWkrGzkIyd
	hTB2ASPzKkahzLyy3MTMHBO9jMq8zAq95PzcTYzA4FxW+yd6B+OnC8GHGAU4GJV4eGe0bksX
	Yk0sK67MPcQowcGsJMLbVr8lXYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU
	1ILUIpgsEwenVANj7GHHQAlevSimp4vOvVvvZjXv0xRGuedWIdHX8yW6ahnaWd8dnXPOPza6
	6o7CfM2qCyrC26pm5+y/98+Pee2jXQayu7jWevu3616Vdm+auNhI9uw2LdHJf9MvTWMpVHr5
	Lzj54mSuuJj5N/cvfya3yEz4dOl6+bQzt2YnFFa2r7eR8VZncctQYinOSDTUYi4qTgQAPtGW
	zEoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsXC5WfdrGvGuT3d4NZzRYsDP5+zWByee5LV
	4vKuOWwW99b8Z3Vg8dj0aRK7x6QX7h6LX3xg8vi8SS6AJYrLJiU1J7MstUjfLoEr48/GT8wF
	t4QqzratYGtg3MTXxcjJISFgIvH65j9WEJtFQFXi2471TCA2m4C6xI0bP5lBbBEBZYnOC7PA
	apgF/CUm3NrAAmILC0RIPDl0AqyeV8BC4uTSc2D1QgIJEq+n7meHiAtKnJz5hAWiV0vixr+X
	QPUcQLa0xPJ/HCBhTgFTicbzR8HGiwKtOrDtONMERt5ZSLpnIemehdC9gJF5FaNIZl5ZbmJm
	jqlecXZGZV5mhV5yfu4mRmCoLav9M3EH45fL7ocYBTgYlXh4Hzzemi7EmlhWXJl7iFGCg1lJ
	hLetfku6EG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA6ND
	xMPJh/P5XrDeMbBmajbhsvIP26z6uPpLU9HrU3/q7MRWtaWLX78WeXpTa6r73naO8Pn6f7l2
	2ffrcRUd/Hy9ZLrsLKZjeqZHflkp/OORmfxZi0fy5xZO+TudR85aLb13TF79yhIP98QdU97l
	xk5ubxe6+Pn+xRsmNS1FAnv5FFS3r3kv91qJpTgj0VCLuag4EQB+4dwpMQIAAA==
X-CFilter-Loop: Reflected

On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
> > To check luf's stability, I ran a heavy LLM inference workload consuming
> > 210GiB over 7 days on a machine with 140GiB memory, and decided it's
> > stable enough.
> > 
> > I'm posting the latest version so that anyone can try luf mechanism if
> > wanted by any chance.  However, I tagged RFC again because there are
> > still issues that should be resolved to merge to mainline:
> > 
> >    1. Even though system wide total cpu time for TLB shootdown is
> >       reduced over 95%, page allocation paths should take additional cpu
> >       time shifted from page reclaim to perform TLB shootdown.
> > 
> >    2. We need luf debug feature to detect when luf goes wrong by any
> >       chance.  I implemented just a draft version that checks the sanity
> >       on mkwrite(), kmap(), and so on.  I need to gather better ideas
> >       to improve the debug feature.
> > 
> > ---
> > 
> > Hi everyone,
> > 
> > While I'm working with a tiered memory system e.g. CXL memory, I have
> > been facing migration overhead esp. tlb shootdown on promotion or
> > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > migration through hinting fault can be avoided thanks to Huang Ying's
> > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > is inaccessible").
> > 
> > However, it's only for migration through hinting fault.  I thought it'd
> > be much better if we have a general mechanism to reduce all the tlb
> > numbers that we can apply to any unmap code, that we normally believe
> > tlb flush should be followed.
> > 
> > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
> > flush until folios that have been unmapped and freed, eventually get
> > allocated again.  It's safe for folios that had been mapped read-only
> > and were unmapped, as long as the contents of the folios don't change
> > while staying in pcp or buddy so we can still read the data through the
> > stale tlb entries.
> >
> Given pcp or buddy, you are opening window for use after free which makes
> no sense in 99% cases.

It's kinda 'use(= read only) after free' but luf ensures the data of the
interesting pages doesn't change.  That's what luf works on.

	Byungchul

