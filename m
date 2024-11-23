Return-Path: <linux-kernel+bounces-419076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0729D692F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F465281D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C6189B80;
	Sat, 23 Nov 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVMUCpWx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168031EEE6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732367369; cv=none; b=grYOwMRw7c+0jL2Nd32smmv6H2u0QqpITK7KmYntL9UGhn4LScQFsj2SXnVMQJHspmFTkPk72+vnXaBw3i/DnSmEWH/loXt+caMgMn9ekeR4xUoXel/huMktkaHCss0VgMkbk8TP5JjXqLF/zmYAVL+4OhLGVhn4SOr2ALcOVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732367369; c=relaxed/simple;
	bh=k++Wy0STB48MMdcQnykA8i43AMPrrqsa1PUnpy018ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaKMIL/EJ5neLQJ9wbDXGZSo4nTuZ5vwhh4FYOUmNqOmaZCmPgA+Xs+iJulQSAsacZ7Ly9tUMew2D3RRBZKtt/6PGD8RYJ0JJu79SPGoZwPiZklAaUZbNO9lFFJBGH5UbxTT+dCH8UH/O9+kmE2BQFp7cJcuOt3a1phI45OkXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GVMUCpWx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2mLyvYcGoybty1wpHPq7oZtIQKwSDVu5sKSJhKOprtU=; b=GVMUCpWxFapOeY7+A9BXzs/OJ8
	Ua8hNLfdYbV3EhI/p0txoLeQltejV0RFKdOtlzuVS78SwLgUlZT31+3XTZeKXSlGPxm+52K44lXSQ
	hqsfo/Otl/WQwgXPzHmLmOgTvkLhHDrb6t1KdW3ZOZjtFnCNXboAJz3GWoacICYem7Llfk1D9/rc+
	K8uTXpp89puD1LwFoY1heGVsv3rgUEC7TVKZWz8KKw0peXWjVcvYca0xoi8wVOm96B/dy2pK2D1bt
	j0v5Uzy61KV2ZlcVFtXFCWlJ91AKgCyoM1uSBMVoGbCWkiRYwPpn/Xdk06Mdj7ONDStEOTTy/CY6e
	dmAgvVVQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpsu-00000009Eqz-49uW;
	Sat, 23 Nov 2024 13:09:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B99130068B; Sat, 23 Nov 2024 14:09:13 +0100 (CET)
Date: Sat, 23 Nov 2024 14:09:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] objtool: Collapse annotate sequences
Message-ID: <20241123130913.GC24774@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.447242540@infradead.org>
 <20241122175713.zxtwuz77ppjcotg3@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122175713.zxtwuz77ppjcotg3@jpoimboe>

On Fri, Nov 22, 2024 at 09:57:13AM -0800, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 01:10:24PM +0100, Peter Zijlstra wrote:
> > Reduce read_annotate() runs by collapsing subsequent runs into a
> > single call.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20241111125218.921110073@infradead.org
> 
> Stray link?

Gah, yes, Was from the previous posting, I though I'd removed them all.
Gone now.

