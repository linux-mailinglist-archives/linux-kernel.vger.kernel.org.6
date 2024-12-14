Return-Path: <linux-kernel+bounces-446161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377FB9F2081
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48561888BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63611A8F94;
	Sat, 14 Dec 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lUswMLbK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D321922D4
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202530; cv=none; b=GB6OYkTPtbqjId4mRHVPCrOI0mssosBmNqszk+1oPz6CfH99du076P4heMSoULY6ihHxqNarpr6krW/LcOeabeYhSRW+C1atTxeybDMlzIBucdzPbIA14Y1sBKZRdCaA7iID3inGLRYvs7VMH09gLIS6pyxsA53yL7Q81prSqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202530; c=relaxed/simple;
	bh=tGBNbcCRq0sbUN85ytraPXFhmCcq6mIVLV079/flAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9qU1JMLRWcfPjbcp3hJeTpsCaJG0racUunLMTlLiEFFJ3ooO09Q1MUCA/GNi7VTK6q3QfsDitwMIypNA38GKLd8l+sRXQcsrFVkk12DeCOdpsvgqORlytldIcfOwu21ahDpRuySsgCiodQwNlE+CWh9ipos2+XHol3IU6jQ+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lUswMLbK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tGBNbcCRq0sbUN85ytraPXFhmCcq6mIVLV079/flAmM=; b=lUswMLbKvhDYlp6Un/Esx8qMhf
	uu5XC/0VQIO2P9g72uKhJZHBKqXAt9W0xLpRe4g6rMyBdFnAyZgLMcq9nZ9Uz2t7goaC/TU0S8mua
	1RhCcdGtH+bYM/i1GvB2x6aYZP2KzO5nwCUZXlQnDf7Noajv6/pAKGo5964HbSS1TEMeQt5cpTqb3
	fFJDXiVL2AHX+t2kuxIagwP5JpYWhO3Uv1P0tD8qsAFI0MQ8Zor4Eb+qTPAWTYBA54Tw5moZdLpX5
	FlsUmQuwyqHjJtlVAtnMniL2FgNgjktr/h49MBRcuoZS6mviLJ4SdMWHYLOa/Z3y0BtlX56HZwWO6
	ckgR+IDQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMXIG-00000004U40-2aC8;
	Sat, 14 Dec 2024 18:55:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0767B30035F; Sat, 14 Dec 2024 19:55:12 +0100 (CET)
Date: Sat, 14 Dec 2024 19:55:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com,
	hughd@google.com, yuzhao@google.com, willy@infradead.org,
	muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] move pagetable_*_dtor() to __tlb_remove_table()
Message-ID: <20241214185511.GF10560@noisy.programming.kicks-ass.net>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>

On Sat, Dec 14, 2024 at 05:02:46PM +0800, Qi Zheng wrote:

> As proposed [1] by Peter Zijlstra below, this patch series aims to move
> pagetable_*_dtor() into __tlb_remove_table(). This will cleanup pagetable_*_dtor()
> a bit and more gracefully fix the UAF issue [2] reported by syzbot.

I'll go over the patches in more detail on Monday, but at least the
first few patches should probably carry something like:

Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Since you extracted it from my half-baked patch, the rest could probably
do with:

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Anyway, thanks for doing this, and so quicky! As said, I'll read more on
Monday.

