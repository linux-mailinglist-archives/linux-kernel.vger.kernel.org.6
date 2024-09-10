Return-Path: <linux-kernel+bounces-322564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C3972AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB92D1F250A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900917DFE3;
	Tue, 10 Sep 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rvT8amEK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753917C7C1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953783; cv=none; b=p4NkZpeheRDLVW1b/PRexvJ5NjPzBm89T9RU0Yecg2gbjfo0if+escM3UBYHMFX/I4vQQwsaY1BPIo5Qc158V/Otg+g/pHymDvdMWUKrHagw99UHqFI8xJB4nmk1Gj2/zoyUcWWS1euYn2+PVk1lt9MvDrxGsyKqoI5SifzbEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953783; c=relaxed/simple;
	bh=oWix37stBNwJxtbe3UXPDaMSfPzGHkzXhGIMwquQFoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/dS6Xu1dLtTbBmzBSSLxavHjNMY2onwfuGQhk4OCeUKHNMPC4T8vKCSAIpWFWSmTZx1s0087VeZrFrDc+y31CW+H5qWxsac7ykD3JdO7188TaFqt19LyjFztlJ/uHK4btAF19vVdziJfV9RpuPrY1IOtpoFTZWy5x+4P3gUBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rvT8amEK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qsfq8CjFa3TULy0LmBKitvvfjc/5FR+uNsSc6qd7Jr4=; b=rvT8amEKQiQ8ZUr+i070flTxFF
	ayQH5RbNrEZUxPZQgjbl3/BXGzk5mka1iG82qtfICE4wCjWepqS4nK7PX/coVvveQxVEjVmQmTOu3
	FaKi2IjRxln/fnM9cVy5CQEXmOiqqWe/nLvKbpbSk6MM5jUuxgzMRYmU5/71fx1ZSqnD+QKAlxsc5
	5VNS6y7uBY9OHj85ewDOuY8ZeaWLUDGLaqrNmo7Fo8Vyiy/MFl9aUx+4W6ToCs9S4j5nuML1q+YPV
	gpfRbuikjQSXC+4xuDzRVAWXmFhLP7SN5L69EEI1NtnYDj8T9wG20EmyBCt3fKQfJQNXJ8v6Wyvu4
	cYO3uZ7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snvQA-00000006tRO-3Pw3;
	Tue, 10 Sep 2024 07:36:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 09B0B300321; Tue, 10 Sep 2024 09:36:18 +0200 (CEST)
Date: Tue, 10 Sep 2024 09:36:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: warning: objtool: data relocation to !ENDBR
Message-ID: <20240910073617.GG15400@noisy.programming.kicks-ass.net>
References: <20240910024409-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910024409-mutt-send-email-mst@kernel.org>

On Tue, Sep 10, 2024 at 02:46:21AM -0400, Michael S. Tsirkin wrote:
> Hi objtool maintainers,
> I noticed that each time I build my kernel, I am getting this:
> 
> vmlinux.o: warning: objtool: .export_symbol+0x3af10: data relocation to !ENDBR: stpcpy+0x0
> 
> Things seem to mostly work for me, so maybe it's benign,
> but presumably the warning was put there for some good reason?
> Am I doing something wrong?

I think you might be hitting this one:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116174

