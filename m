Return-Path: <linux-kernel+bounces-419082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFC9D693D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A419F161633
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E39194A6C;
	Sat, 23 Nov 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c7BszMOj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C697188583
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368115; cv=none; b=Tu7nzRVf9HiFqlBJViEEZtNZYLCt/29vW1iHZodb/g4zRrF/+Ui7MFXER6Vytz1auCjzFw+XJYkKKoJ4g0BEMTWF/JLwfgJ8mpud+yzq+uMjKOQ5b+5QXOL66NJUl45yrjhO7FhN1LifAUVJ2FMGrRMumQ0bam5P/6vW8o+GksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368115; c=relaxed/simple;
	bh=0cE/5Iy0zYyWn0lTLHY90OKGOXTaLYxigIKl10FFOfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7ptYMqLAeEZWV1mxH4A5zFAJKHupmhD34uHcCfemz2hGDn7Re9UQSX5ZeUrP31wPm7ja8JTyDHZARVQSr59g2EsDWlJrRVtg2Y59qscJslq5NHUDVmSvoCjncdZUK8aTe+7fOOL9syUp1f3nZ01pHz0ns9JgsB6h3gm2aGjJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c7BszMOj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N31QDUTvoits/QW5lPqzznYuH6QmqbyO2qKLFIWG0VE=; b=c7BszMOjmZs5S5OStqTmAGqIHg
	3JxPZSMUVEl9nyN3FPUUyUta/araZ1xNJpTH5gAfvo/BNAnp+ySHptx99gii60tkAUN8FUJDQlg1N
	Urjq73CNABnV5whhBtRCk3TtZYCbG4Z3P8NIM/mPVrHX/w9OifMIEv1I8evqfQVFp5ORqk9sGw14r
	msOw9JNKX+2+rptmfCSWkjpxZB5nwqBTqzCbgN6HdMfAZCO00K1QiffT7yHPAElWrLsCsS4mUb2On
	pAbetcFgYVNUuVI9rQPMOcNVL6M1N1jifp1ic+meiBzCzIyct8KDxbxTT399vyp96+vhQqYRVlYjP
	ypXVmLFA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEq57-00000009FR0-1WZf;
	Sat, 23 Nov 2024 13:21:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3CFC730068B; Sat, 23 Nov 2024 14:21:50 +0100 (CET)
Date: Sat, 23 Nov 2024 14:21:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] objtool: Rewrite annotations
Message-ID: <20241123132150.GE24774@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122174056.jtkddvh24plvw2bd@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122174056.jtkddvh24plvw2bd@jpoimboe>

On Fri, Nov 22, 2024 at 09:40:56AM -0800, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 01:10:16PM +0100, Peter Zijlstra wrote:
> > Just the objtool annotation rewrite bits.
> > 
> > Changes since last time:
> > 
> >  - split from the x86 and kvm patches
> >  - s/ANNOTYPE_INTRA_FUNCTION_CALLS/ANNOTYPE_INTRA_FUNCTION_CALL/g
> >  - made __ASM_ANNOTATE() take a full label name (no longer appends 'b')
> >  - added a patch that moves all the annotations to objtool.h
> >  - some changes to the first patch
> 
> For Valentin's thing we'll be adding annotations for static keys.  Those
> will be symbol specific, like STACK_FRAME_NON_STANDARD().  In which case
> we could have a generic .discard.annotate_sym.  And then rename
> .discard.annotate to .discard.annotate_insn?

Done.

