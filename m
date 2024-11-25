Return-Path: <linux-kernel+bounces-421218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B89D8827
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B32169746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984231B219E;
	Mon, 25 Nov 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4k4ywMb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB171B218B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545383; cv=none; b=DKfUCbUGf5sDifTl40CP0apTC4PX6L3tmXXqqsZ/aGn5XmQ1aYI9HtUA7j7CNnapNsY3bFrQcNIPGLprTDUvRmNQXjHSyqHVLs9ydr8pSi0UddUXSBF67EpV4PhLxfFc5CwDA441Zmg8TfJH1/Hzz5CXX//37E5VsNlNLMAJ5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545383; c=relaxed/simple;
	bh=hnxP6TXXcMZ27E1p+RYywSkk5x8YJsvdZiYDhpxzaHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKsJKJbelCLolqpaOdEt6i4H5HmzurJ+aPNx8sCNVS4PzcjpqJ6+jXrBARPlOIRp3vmb2qFX0WjBtNzZxdgRotSqUcpce+K74NIEZTLE5e0y3oz+2zlAab2ITh9v60Rx/Eby4uqEkHHBXE0DxFRFN5TLq2uChG/eIBD6Iw0GXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d4k4ywMb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E70Jk0zQHyZ6q9JfQSQLYetgqHd5IZ7emE3coUjhMDc=; b=d4k4ywMbxVHyRIKsWgTFpbs1ne
	HWYcLXNdrbxfVbF8w68Qn239gc5C55OehxemoNp4e0Dn3tkwVibo1C/fdFqbUXHcJHxGVkGfYDl4m
	FKQuB/3YnnFoqUgRaq105ikikO0Op4uc44yGo7C942KsSlH3/tB8rSiLDK6jXA4WmSE0hG8ri56Nq
	q70CGyQ0zVmWVZ5JS72Toedwp43vu8PcbepKLcgYNYiFoXdWG4bmKZZ0Z8nnuGryM54iOBr0Bb2VV
	8phPwxKbtljlDts9n0h0MWbN70r6bpO1DYi3TRotm3xGTXUnMfRwUPKSqGRClsC5PE4Up6Ns3gHai
	qZatyh3A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFaCH-0000000Byhx-1bb3;
	Mon, 25 Nov 2024 14:36:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 279D530026A; Mon, 25 Nov 2024 15:36:18 +0100 (CET)
Date: Mon, 25 Nov 2024 15:36:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] objtool: Collect all annotations in objtool.h
Message-ID: <20241125143618.GQ38972@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.560621502@infradead.org>
 <20241122175445.tx3edadmof76yegs@jpoimboe>
 <20241123131943.GD24774@noisy.programming.kicks-ass.net>
 <20241125130613.GO38972@noisy.programming.kicks-ass.net>
 <20241125134005.GP38972@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125134005.GP38972@noisy.programming.kicks-ass.net>

On Mon, Nov 25, 2024 at 02:40:05PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 25, 2024 at 02:06:13PM +0100, Peter Zijlstra wrote:
> > On Sat, Nov 23, 2024 at 02:19:43PM +0100, Peter Zijlstra wrote:
> > 
> > > > BTW, is there a reason .discard.[un]reachable weren't converted over?
> > > 
> > > Completely forgot/missed them. Let me add a patch.
> > 
> > So this is turning into a bit of a trainwreck :/
> > 
> > That is, the below works, but I ended up having to include objtool.h
> > from compiler.h, which is really unfortunate.
> 
> Or rather, I suppose I can move unreachable() into objtool.h (or another
> header entirely) and go include it from all the various files that call
> it.
> 
> Only ~70 files.

OK, done that. Fed it to the robot, lets see what comes apart.

