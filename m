Return-Path: <linux-kernel+bounces-353013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890CE992746
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317DE1F23B58
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFFF18C90B;
	Mon,  7 Oct 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwqKTmE1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9018BBA6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290391; cv=none; b=ToVQUitHri3tTwxQZaCz2Pxqz0L4R9T9DVQdwDbgkCBNup5zwwAAvOwRJeJ2orwnyi5StQ02O5wdUVw5sMOHtvt8wqyGjtr3F8i6LKynoPZr8Fj2JKEcgrLsudyUxjDkfcAlBmVs0j6ujN3+GBPL/aTcEOrR+05ICNeSSDFT6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290391; c=relaxed/simple;
	bh=HyBgSPTsy2rjPg2nYs+SAD2ckofJdsKs7QNcaMrFteg=;
	h=Message-Id:Date:From:To:Cc:Subject; b=G/Bqqihq+PTwSNgcPHl1mXkFTtZxpI2+x1M9sp3i1ySbV38oBhMW7jBS5m5KQqbC165bEuDlsiBacCl6qp6T7zuS945vz5CwtSS7Ee1XfB/49T6mGXG7Js+pPv2YtVJ3kCRfMCJ+4qr9+78oxBMiHiPPOunpQqeH442E9J8sFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YwqKTmE1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HyBgSPTsy2rjPg2nYs+SAD2ckofJdsKs7QNcaMrFteg=; b=YwqKTmE1Bnsa4qdG+tOZ362Wjt
	oKmUc/RrPBClwQAtMBhRc86JyKv1OU0YcC5CJ5+lv5uJnSa9I6KMxpYHEPmdUoUJVnPDbtcZeW93s
	s9aejSpntkQYyiGmAt8DYm65qKaAmwY/NVSeK2iqutxOvRU7C4ylMoUJVFUahlQdILuAXGDDBciwe
	uL5/CW6Pa5TMWH/A08x1iPJEY6FrGyxf3OoQEVgvW1h9T/Nf/sMIbFjDA36reustS/4pF7vquKagN
	AVoZxEY+6T72Ha70du33OY/7+kDv1+Lsk7f0hmMgQekTeqhm3Z6pXoyuOc8GP7/KExH8p593EzgfR
	zx97+qog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxjHN-0000000H0Wf-1VOc;
	Mon, 07 Oct 2024 08:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DB8F730088D; Mon,  7 Oct 2024 10:39:44 +0200 (CEST)
Message-Id: <20241007083210.043925135@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 10:32:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bp@alien8.de,
 david.kaplan@amd.com,
 jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 x86@kernel.org
Subject: [RFC][PATCH 0/2] x86: ASM based __bug_table and rethunks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

I ran into the __warn_thunk_thunk_thunk_thunk thing and urgh.

Make it a 'simple' WARN_ON_ONCE(). And since all of x86_64 has the same rewrite
rules, simplify the ifdeffery madness too.



