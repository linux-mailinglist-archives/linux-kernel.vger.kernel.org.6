Return-Path: <linux-kernel+bounces-421106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD69D86A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085FC284B98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901618C322;
	Mon, 25 Nov 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLdTb8ag"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387051AB517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542011; cv=none; b=kFDopo6bfiVbgXrJcPqMlew6QFD7PMCLVaQ3snuPBQPTsVTAEEiL0taX82IXh+FAwQWY/5J9hgvCyijYVktZd6x/fM5w6g7v/9e9hBZ2wDiqKplpXZMpkmuEgztJYmW7IGA0UkydcUofaeaZJeIAoUWx+RjjNuN6LMPjfvVz6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542011; c=relaxed/simple;
	bh=N+ji0oWKAqXTV3eyELHttCZ2hBamsuRxl9i4T+5SdBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0Lec5C18rvVYLNZ4bZnNnMmUu/oNgQCglCcJr9EkQluVXNh7Zpbl43RnpiO4blorfrqbg2n7oO+2jtcTtG0mY6iVindEgVn68bIMyzlRP6KIngPIR4coJyn0oboonYt7ehT+wEbsfRKEC+BW5NZ/sApmzP7zIJ2n3r2GY6j/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oLdTb8ag; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O8CEQBiDjvVdTkjgjsPUT5Xo9fuffQhYKqBOg6zyZfI=; b=oLdTb8ag6NYCJwzc0maGyEaoKf
	PTLyRnoJny5JjCIuIGc7QkQXipUYJKLpmv8HtNxQdDDNDggs2PucYunDvUGzUqpbQJDWmQYWN/EkV
	Wc46Adr+dhGMDS+x8WtMOz/rmgjbAFDNwgvPcEM5IVP9ufUDrgMF0zUMntL3+/K7wWXWZwnib7zeI
	ZmBlhkX9lqjh2jvLErmYgfX/j/5r3atQ1hyX64TSLEnvS/hM4ufxECD3bEq++30Agxv2hryvV7/g0
	A26XJYHMjmP0y3QiMSWBtZ74xN3F9kcfoAYQJITtvQFUSGBXIxhWRdAhMaFBsUs6WMlpjDu7Vdbez
	v6Paq5+g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFZJu-000000015Zm-1HyC;
	Mon, 25 Nov 2024 13:40:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 976E930026A; Mon, 25 Nov 2024 14:40:05 +0100 (CET)
Date: Mon, 25 Nov 2024 14:40:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] objtool: Collect all annotations in objtool.h
Message-ID: <20241125134005.GP38972@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.560621502@infradead.org>
 <20241122175445.tx3edadmof76yegs@jpoimboe>
 <20241123131943.GD24774@noisy.programming.kicks-ass.net>
 <20241125130613.GO38972@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125130613.GO38972@noisy.programming.kicks-ass.net>

On Mon, Nov 25, 2024 at 02:06:13PM +0100, Peter Zijlstra wrote:
> On Sat, Nov 23, 2024 at 02:19:43PM +0100, Peter Zijlstra wrote:
> 
> > > BTW, is there a reason .discard.[un]reachable weren't converted over?
> > 
> > Completely forgot/missed them. Let me add a patch.
> 
> So this is turning into a bit of a trainwreck :/
> 
> That is, the below works, but I ended up having to include objtool.h
> from compiler.h, which is really unfortunate.

Or rather, I suppose I can move unreachable() into objtool.h (or another
header entirely) and go include it from all the various files that call
it.

Only ~70 files.

