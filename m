Return-Path: <linux-kernel+bounces-396598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41B9BCF40
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D5B282DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E81D935A;
	Tue,  5 Nov 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L0llNO9u"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93E1D9350
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816846; cv=none; b=qqO0kpxxqTWDvbTD53+2AeSxotOjXnpur1D6mIcIgB0LYViPqn7abHyg6xewjnuUJjZv+pNJXEEAro2Ep/K4asFbUpQtMmxuuQxuhoi726Gm5yz3QQnllUp/I9xK6vidVpnpZHURPfsTqG0E1QhY2u3u1a8z7/A35pNoExxENNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816846; c=relaxed/simple;
	bh=AqTyyEj5q/WsI/Z/CsS3/vfL5vnd7obKAqa+fUJXtzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL+XOxeEhaTzd/kBpQw0otwLf7e8mWfpCD+78ubnQf2aXrj7dimtzetY1WCorHXH+DADkFMWOyXI0R6R8ol6Z7qA0goj/zi4buUjYD3IJgPkYGgUaRp4Oig3glxd6+Lrhb+Jsmil4xj3pHExB7aghK5bmFDo+wylcFU2slTYHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L0llNO9u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=smtsh+FIqN3PTU0YakwvqjwTSi2sK2slZdgx/LTpBu4=; b=L0llNO9uoEDeZRyWaitj8MeWlg
	/2pZNiTvaR1dQynEbTLPP1SCy3i6B3sV5mZGqJfRTVxpoaZz5v/JE86VexwA9IMJalDCLhxhyyT1v
	0ClvI0m85tEpkZRFwsKq43tCFTTERZlH+LgBfTS59gXew4mm6xRLTPPjvI3bWp26l+sOf/Fhainuh
	nuDzFsPjDaY8u4x2hyx0C7RXBfRPjYZdJlP1CfG9+QA81hV/8WiMBj5/GcVlJZjjAf7NHAdXh1SMS
	5y0ciLe36jvldrzoXnrD1w5jpqlsmouCzGyy57DmrjneTQrgqGzjBfD6a678EAAttWqCSUPteaFCc
	mfwpQIvg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8KWe-000000035PL-0C4n;
	Tue, 05 Nov 2024 14:27:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0AE2D30042E; Tue,  5 Nov 2024 15:27:20 +0100 (CET)
Date: Tue, 5 Nov 2024 15:27:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <20241105142720.GG10375@noisy.programming.kicks-ass.net>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
 <Zyoood0ooSbpultV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyoood0ooSbpultV@infradead.org>

On Tue, Nov 05, 2024 at 06:16:01AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 05, 2024 at 12:39:02PM +0100, Peter Zijlstra wrote:
> > The expectation is that all EXPORT'ed symbols are free to have their
> > address taken and called indirectly.
> 
> I don't think that is the case at all.  The is a relatively small number
> of exported symbols that are called indirectly.  I'd much rather mark
> those explicitly.

I'm not claiming they have their address taken -- just saying that
traditionally this has always been a valid thing to do.

Anyway, I raised this point last time, and I think back then the
consensus was to explicitly mark those you should not be able to call.

But irrespective of all that, this just makes sure all the .S functions
are on equal footing with the C functions as generated by the compiler.

Once that's done, we can look at adding to the EXPORT family.

