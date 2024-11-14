Return-Path: <linux-kernel+bounces-409086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA29C876A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6731F21BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB241FAEE3;
	Thu, 14 Nov 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cTkyV4e9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF701E47A5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579304; cv=none; b=IYjRkSBZImHizchP9NPI2kiI2TU1sSgGUGC9gTmn0Hp0Ch8/LP7h027PNkO7ut07i+eCKIbLXPF75zNLXsbO50R0vi20iuou3QALS0Lq99ej+ZMXvOqUoKAoYZvrcVJddQ5eUMvhOgdEmHjLiIzoISZ4FWsRDPaop0MGNty7aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579304; c=relaxed/simple;
	bh=XjBsKUO6rUrhNyI3796ed0qV48UqN44QFk2RcSHOe1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdnpBXelEb9+AZXbdxh/UM4Ernm8bjxi9MxZLuHo7HU3ry06qqc9UI2kjs+TM9hY6fiHXpyG9G2a53gco32/L342F/lQTe6/L5TrOmO5VzO1AI+fWnKvqik0x1GSlLhphUs1N0sSXJeCBaluYa6S6BDKzuL5YfLGSwjgd0vxwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cTkyV4e9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZeVgFbRp5BF0gOErDpbLp9vYJmlP0VCMWqKbv+6Ce+c=; b=cTkyV4e9lBDUjgGm5YrjNo1UAV
	q+W+DhXj14yY7Kefmv474vRhgT0C7LGk+e+Pe8PNxrwuEm86wPNIs8sjM3hKFMqsL21jDmZzxG3ZO
	yDamyGgiKfunlp8LIMd3Su7NGPI79L/AnnPjuN5owX8agaURQ6U1zEBQZJsqDYc4AuO+Wm0SliaGi
	YFYzIMlzicUeg7wpKRdVQzCkpYmszstz6xQjv+yUO+8y+L7BgwtiwMaMPbsjd3J4KrhAcx/C+pBjA
	5VyKeB5+XPjBjnrD+8mvLX1CzvK1giS4awF7KHeol17Sn1c4yujBNK27YSs7WubDMVaf0B1Rp2M9i
	kF8uG99g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBWsK-0000000DbKQ-2x4x;
	Thu, 14 Nov 2024 10:14:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6848300472; Thu, 14 Nov 2024 11:14:55 +0100 (CET)
Date: Thu, 14 Nov 2024 11:14:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	tglx@linutronix.de, daniel.m.jordan@oracle.com
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Message-ID: <20241114101455.GL6497@noisy.programming.kicks-ass.net>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>

On Wed, Nov 13, 2024 at 02:36:58PM -0500, Mathieu Desnoyers wrote:
> On 2024-11-13 13:50, Peter Zijlstra wrote:
> > On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:
> > 
> > > This patch set implements the above mentioned 50us extension time as posted
> > > by Peter. But instead of using restartable sequences as API to set the flag
> > > to request the extension, this patch proposes a new API with use of a per
> > > thread shared structure implementation described below. This shared structure
> > > is accessible in both users pace and kernel. The user thread will set the
> > > flag in this shared structure to request execution time extension.
> > 
> > But why -- we already have rseq, glibc uses it by default. Why add yet
> > another thing?
> 
> Indeed, what I'm not seeing in this RFC patch series cover letter is an
> explanation that justifies adding yet another per-thread memory area
> shared between kernel and userspace when we have extensible rseq
> already.
> 
> Peter, was there anything fundamentally wrong with your approach based
> on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net

Not that I can remember, but it's a long time ago :-)

> The main thing I wonder is whether loading the rseq delay resched flag
> on return to userspace is too late in your patch.

Too late how? It only loads it at the point we would've called
schedule() -- no point in looking at it otherwise, right?

> Also, I'm not sure it is
> realistic to require that no system calls should be done within time extension
> slice. If we have this scenario:

Well, the whole premise is that syscalls are too expensive. If they are
not, then you shouldn't be using this in the first place.


