Return-Path: <linux-kernel+bounces-219469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B790D2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736A21F226BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54B15EFBE;
	Tue, 18 Jun 2024 13:31:19 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375815442A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717479; cv=none; b=g9BfwxQiKDz4mEXV6vNALV9PdIW5SNBr15b+mzR8jwd2fAOmwzmH8/Kmo1xvriVNDD1lyh7zRTJolS75Oe3osXbldbLWgpB6BUcyrovLDAg1Zv8P+FrZcUmOxhVSnKJzmQYA7SQt6LhO0Q0aDOlCimqpT2LwRMtXfHVy7ZUmmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717479; c=relaxed/simple;
	bh=OwbKEY0HdKKs75LYG4AXAaC/Y00jobw3osQpqfj35GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POxZYw4wji4JPYYQk5Stt98mwEi5CIaCqdGbPpIb4gJo7qSR3wjKGPFZKktdoCXCFg8SUf4ZpSEerqTXC2YmVF7P5XxM5yvomvh/eXvm2BxRjmpQgSPsZfOQXwvzHoooVvvuB3jXjg+iSudQVXhWTU3ODt3P+0TnKT+XCDFWtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 45IDRsNt014239;
	Tue, 18 Jun 2024 08:27:54 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 45IDRqpp014238;
	Tue, 18 Jun 2024 08:27:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 18 Jun 2024 08:27:52 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jinglin Wen <jinglin.wen@shingroup.cn>, npiggin@gmail.com,
        masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
Message-ID: <20240618132752.GT19790@gate.crashing.org>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn> <20240617161336.GM19790@gate.crashing.org> <87cyoe1mbd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyoe1mbd.fsf@mail.lhotse>
User-Agent: Mutt/1.4.2.3i

On Tue, Jun 18, 2024 at 10:12:54PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Mon, Jun 17, 2024 at 10:35:09AM +0800, Jinglin Wen wrote:
> >> +	cmplwi	cr0,r4,0	/* runtime base addr is zero */
> >
> > Just write
> >    cmpwi r4,0
> >
> > cr0 is the default, also implicit in many other instructions, please
> > don't clutter the source code.  All the extra stuff makes you miss the
> > things that do matter!
> >
> > The "l" is unnecessary, you only care about equality here after all.
> 
> In my mind it's an unsigned comparison, so I'd use cmpld, even though as
> you say all we actually care about is equality.

We want to know if it is zero or not, so in my mind "unsigned comparison"
does not apply at all, that is only for range checks.  Heh.

But it doesn't matter at all: if you think cmpld looks more natural / is
what you expect to see, then you should use cmpld, that is my point :-)


Segher

