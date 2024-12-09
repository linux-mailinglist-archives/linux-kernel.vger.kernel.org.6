Return-Path: <linux-kernel+bounces-437136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE609E8F84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CA418836F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6F2163AD;
	Mon,  9 Dec 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHJF2TBh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12322163A1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738255; cv=none; b=D3xyVpWM67qIsec8oODahuTKcDj0oPDnaCxie+nhTlrvxt2KuRSdj/J/Kc7Qca476k+JXhFhnYbF6vlr2dXMzE9ghq/8ByqwUq6hQgG2btnQp9X1a+J/PaboidgR8IrC4VV2adB2WfmIW/2xtwN3UWvfITiak7pwyakxi442JCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738255; c=relaxed/simple;
	bh=09ijedTck7OiuraQED80CickxGG3phnAZfeE7+OMmKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsjr3xBxrYbC0FEDBSClSk5l8JDcRlgynDP37La4m9Yt+nQkM4f+wYErKG4BevTxdW1NQeW6kbuJYLZBzhl1z6w2wysAXAe3zOeZixskDfXPbVRO8dImXQxxGvWuE1SdpX1nNiyGHe7kyODFnMPCvX4GA7OgxwZFqEpfD18dGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hHJF2TBh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMAqH3p55Chm8dTgNUbVFBRpM27TgbZfPHyZdsQBj8I=; b=hHJF2TBhLIm3ao5V7tdksIIwdP
	4ZbZeCWIMuA9U6e9bydjjS9PpJeQtNudKIPfJe8lsEA7ZdrTo1JIjU0BJX7056XID5R9LiPj6friP
	NvZc/mjI8NOujc4YxYn16SNxL+/EmcOF2wc/b16ZjpySXd9g1+xB0USwxlAurgFHJvmEIKxK2lG4a
	ohcsQxfpOP0+bQwjpEvYpPSdfhRAx7q2cwuzfl/5vkFj3HY225Ucrqn1fAMppsxiUuSbZ0X2nH3j7
	g5Z4/vahkx+B33v0dDGN+61XaZykd9ednILyb6+aDLSLqd1Lijk5mhfrF/AKQx7XYIpPMbUq4e5hF
	rpKZLYRg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKaWB-00000001AHA-2Emu;
	Mon, 09 Dec 2024 09:57:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98F2030040C; Mon,  9 Dec 2024 10:57:30 +0100 (CET)
Date: Mon, 9 Dec 2024 10:57:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: Interference of CPU hotplug on CPU isolation and Real-Time tasks
Message-ID: <20241209095730.GG21636@noisy.programming.kicks-ass.net>
References: <CADDUTFzK0FNS_mJ=S2_FH2vS2c5a+gW_qsjf3Hb9k=zzjB4JmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDUTFzK0FNS_mJ=S2_FH2vS2c5a+gW_qsjf3Hb9k=zzjB4JmA@mail.gmail.com>

On Mon, Dec 09, 2024 at 09:10:35AM +0200, Costa Shulyupin wrote:

> Questions:
> 1. Why stop_machine() is used during the CPU hotplug?

It is the easiest (and most brutal) serialization scheme to ensure
nothing else will poke at the data you're about to change. 

> 2. Is it worth testing using stop_one_cpu(), or would that be the
> wrong approach?

Yes, and yes. That is, I'm fairly sure that just trying it will horribly
break stuff, but it is where you want to end up.

> 3. Do you have any additional recommendations?

Audit the full cpu hotplug stack and determine who all relies on this
'implicit' serialization, then proceed to provide alternative solutions
for these sites. Then, at the very end move to stop_one_cpu().

