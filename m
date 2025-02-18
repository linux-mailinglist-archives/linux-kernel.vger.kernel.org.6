Return-Path: <linux-kernel+bounces-518581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F598A39129
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B481630E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03632165EFC;
	Tue, 18 Feb 2025 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bvFCvDvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6017A5BD;
	Tue, 18 Feb 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848433; cv=none; b=NzVicNk1LiB/9lv1TefXtZjpajP7fij9ojrkPbKbL/nbZiFhFNEqz1JkfnZ91S6NhzFD1QK4dVpVCA3hHH62x38AwKde3XyluNrXf1RDIAYTsWRj+mXPr3vlCH65ftaQWp/ZWohRoECLjt/wn9UkeKnT8sMUm/9OrOvm1WnTTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848433; c=relaxed/simple;
	bh=Kgg9d4zpWG5aQiJcx1+NcYfQN3fATmHUIBQ9SeORSuA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=txGUvT78QXF/H2Q/Qx1eQ3LSdgX5mF5UzMUa087t3uwHM+rNVVtRs7BG5wkyFW9W60Yfe5mJ7zhyGq5nPfbntsGbFoGW3VNKnRKVGSjyHQSebSLhoLypeTMFILVZhFXipyK1ioB2l7FuF3usePVAtrxiryQPxYbjQiW/BvzE1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bvFCvDvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838FBC4CED1;
	Tue, 18 Feb 2025 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739848432;
	bh=Kgg9d4zpWG5aQiJcx1+NcYfQN3fATmHUIBQ9SeORSuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bvFCvDvGwjhK1bqLysdZpbWxrPf+zUMo22+IJ0Rn8J1oJQYzEwqbUalud9GdrM14T
	 dTcuOehBuie3jS5zN+ZxCwZ0nJBEyjtys/YlAcjk2FD/xLF2npSenBpjf/DPZVef2H
	 6HZGStknwpqLzNP+acWCwkoWAzCnYfJAfhYBRGaM=
Date: Mon, 17 Feb 2025 19:13:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
Message-Id: <20250217191351.0003a6f07d017d80762fae41@linux-foundation.org>
In-Reply-To: <08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
References: <20250217170934.457266-1-colin.i.king@gmail.com>
	<Z7N4tLUpRA1EKfDm@casper.infradead.org>
	<08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 18:00:22 +0000 "Colin King (gmail)" <colin.i.king@gmail.com> wrote:

> fOn 17/02/2025 17:58, Matthew Wilcox wrote:
> > On Mon, Feb 17, 2025 at 05:09:34PM +0000, Colin Ian King wrote:
> >> Adding an unlikely() hint on the masked start comparison error
> >> return path improves run-time performance of the mincore system call.
> >>
> >> Benchmarking on an i9-12900 shows an improvement of 7ns on mincore calls
> >> on a 256KB mmap'd region where 50% of the pages we resident.
> >>
> >> Results based on running 20 tests with turbo disabled (to reduce
> >> clock freq turbo changes), with 10 second run per test and comparing
> >> the number of mincores calls per second. The % standard deviation of
> >> the 20 tests was ~0.10%, so results are reliable.
> > 
> > I think you've elided _just_ enough information here that nobody can
> > judge whether your stats skills are any good ;-)  You've told us 7ns
> > (per call, presumably) and you've told us 0.10% standard deviation,
> > but you haven't told us how long the syscall takes, so nobody can tell
> > whether 7ns is within 0.10% or not ;-)
> 
> Ugh, my bad.
> 
> Improvement was from ~970 down to 963 ns, so small ~0.7% improvement.
> 

It actually doesn't change the generated code:

hp2:/usr/src/25> diff -u mm/mincore.lst.old mm/mincore.lst 
--- mm/mincore.lst.old	2025-02-17 19:11:34.093727411 -0800
+++ mm/mincore.lst	2025-02-17 19:12:59.797009056 -0800
@@ -1563,7 +1563,7 @@
 	start = untagged_addr(start);
 
 	/* Check the start address: needs to be page-aligned.. */
-	if (start & ~PAGE_MASK)
+	if (unlikely(start & ~PAGE_MASK))
      b27:	31 ff                	xor    %edi,%edi
 	asm (ALTERNATIVE("",
      b29:	90                   	nop

