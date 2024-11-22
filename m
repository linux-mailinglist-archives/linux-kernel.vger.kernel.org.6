Return-Path: <linux-kernel+bounces-418164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64B9D5DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB93B229EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC91DE2B2;
	Fri, 22 Nov 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKGzXm9P"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E85142E83
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274385; cv=none; b=BCGdkltogqZECOVkuFz2XYqhzZ5JzhXF8JDXIHFW8TkDGqou+0S1YvRFFBrvK59tzOTt8MPeJ78m2/XNDkziN6wc5qGjpMwMGzwFGTyzF+hkivZBpcicN3eww5Dp6dxucsskv7+1VV5FgFCoMOLTVOjfL4ZQxF41ho2QTOltdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274385; c=relaxed/simple;
	bh=FL+RqbsYKoxynvgb6QMF2g88+SUXRLvptcuxn9F4eOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5XPiW/HUg205ixQjdbjuvJoo+dFLG/1eouED8U516Sn0TMF9mMjbYuiqo+Wqg7z2HEyPn7yHMpy0ca2OdHhSx/Jy1YeLU1oGFlx5UaW6HET66nmjI0koYzjjwC7JlGIDt6G1ITPtw8PLGQ0vDEyCVgrVJXqDu7MZUGo4RXb2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mKGzXm9P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ctLdsz4y+k2OrLicuzfFs+xEyg9OClCM+rNmmpYTDX4=; b=mKGzXm9PD+mRrWTT8oHLoJ/s4o
	S2fVF9KDzcvAdrF7kwwfpddC5De9I+yFUbpvat2dj2QhsbeGI3ZZPDh5y2+0HoCWm9/t0pSRxQdLn
	NxoMsmKZOGZDLURyZx+qCeqBEkKshPXHsOG196uBfoDQRTe+2izVTaKwBciLFZ685OeI2LEp2rszy
	LpkpunwoeJx2hE4QdUDXgMeH8wS57cSynBFFD/YEMgnDthSmeqs6w6+f/05WuMduBtjqCtua0LY+a
	QAP+bLlGeY9WAxDaj767jfxMGLIMl8+bNjeJCwBZOC0DUM21oz/jch1NIH5AX3jmpfnlMbgj0mong
	DUDFllNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERgv-00000007adG-46gR;
	Fri, 22 Nov 2024 11:19:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 479EA30066A; Fri, 22 Nov 2024 12:19:14 +0100 (CET)
Date: Fri, 22 Nov 2024 12:19:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	andrii@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, mhocko@kernel.org,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, willy@infradead.org,
	brauner@kernel.org, oleg@redhat.com, arnd@arndb.de,
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] seqlock: add raw_seqcount_try_begin
Message-ID: <20241122111914.GS24774@noisy.programming.kicks-ass.net>
References: <20241121162826.987947-1-surenb@google.com>
 <46aa36f0-64a6-4aee-8134-0ec93f62e59c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46aa36f0-64a6-4aee-8134-0ec93f62e59c@redhat.com>

On Fri, Nov 22, 2024 at 12:10:29PM +0100, David Hildenbrand wrote:

> In gup_fast(), we simply do
> 
> seq = raw_read_seqcount(&current->mm->write_protect_seq);
> if (seq & 1)
> 	return 0;
> 
> Should we be using that there as well?
> 
> if (!raw_seqcount_try_begin(&current->mm->write_protect_seqs, seq))
> 	return 0;

Might as well. A quick grep doesn't find me another instance of this
pattern, but does find me something 'funny' in net/netfilter/x_tables.c.
Let's pretend I didn't see that for now ... *sigh*

Want me to stick a patch like this on, or do you want to do that later,
when the dust has settled?

