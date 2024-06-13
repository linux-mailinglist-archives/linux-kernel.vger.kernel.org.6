Return-Path: <linux-kernel+bounces-213172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494C9906E82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FC2B27E58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0A1448D9;
	Thu, 13 Jun 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="STzDZDTz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="767Y7lEb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y8avc0Ck";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dokv8vaD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5981ABF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280429; cv=none; b=nKaSdC5NSX7R6K64tYNTYWJBZ4PwOhDPoXysTAlWHN/iG+OJa7iA+PFCIKsFeJ9T5uDGb/BcGY9H+F4oUrp5HT10AvGJ+yDUrwePbd6FbNRW70+nESm/AS1ZHvYPA1xalpidqFlhpwkDmHx7ZKwQ8M+ocJmhbqyR425Xz5DZZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280429; c=relaxed/simple;
	bh=8F1No02i5YBjPD0EWuNeyiMfGAGRuWUK/BgfbUulUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhVGaFJh/CSaUbQP0yjQUp0aldQnKYk7LJsDKRVjvDTcfDSGUFGOa+2aYgnj1ZkBiBn+BVoFdDJS4XhnmdTBbZ8i8l8X8v0vAAvnCzAGQe5xEbN316a6zPtYJAnWZktxAfwyU0hDGoNkq9ly5cKxRoWe+cjf6YsLqln70dXiZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=STzDZDTz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=767Y7lEb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y8avc0Ck; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dokv8vaD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3B9F3539F;
	Thu, 13 Jun 2024 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zAvrPhZhF6uatcsrntRNbw3qSSmpluUGwwNlU0hJc4=;
	b=STzDZDTztcGnhBcI537899X64efXubsdtnkC2b8WMHTCpstKMnCsAKPc9tLfJo/dFWDT5r
	utckXRJcPjYGvH3SvE1Qj8urvvZ1mk8sd2p1qV5TUMr09mYVj8IHDdetIONIM77wEbUtPS
	FYe6bFBvQ9bISR8KKi/2bs5nmVl/2Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zAvrPhZhF6uatcsrntRNbw3qSSmpluUGwwNlU0hJc4=;
	b=767Y7lEbmscSCVmr6ui8ujbNK8KhiYCKDbwiV56ppPlQLr8pYCfqYifwUB/e3p2tS3iv9Q
	UNPpOKp1KRQOGcAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zAvrPhZhF6uatcsrntRNbw3qSSmpluUGwwNlU0hJc4=;
	b=y8avc0CkMfS3mDoV+kIh1D3eaqfVannwxLCn6BglYyuXaPzEKXZYM8RigHQOIUX4kEdwK5
	2OgWyK/RBCKZwEi/Gztnj5h6HE9s4+HYDbBd1u17nYZUQ00QqMzQd3rWMvyhsKoeLNG6uM
	5x7mgHLvam9yqsUgHhLeruvI1Kd08Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zAvrPhZhF6uatcsrntRNbw3qSSmpluUGwwNlU0hJc4=;
	b=Dokv8vaDMACn9OruIAfqACroLQafUwYCiSelv8y1uJ8JpraEWbUWqP3Dl1VZm64EsOw6hs
	B4nUdNoVH8nj/QDg==
Date: Thu, 13 Jun 2024 14:07:04 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Laurent Dufour <ldufour@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
Message-ID: <20240613120704.GI19642@kitsune.suse.cz>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <875xudoz4d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xudoz4d.fsf@mail.lhotse>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,linutronix.de,gmail.com,csgroup.eu,infradead.org,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

On Thu, Jun 13, 2024 at 09:34:10PM +1000, Michael Ellerman wrote:
> "Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> > From: "Nysal Jan K.A" <nysal@linux.ibm.com>
> >
> > After the addition of HOTPLUG_SMT support for PowerPC [1] there was a
> > regression reported [2] when enabling SMT.
> 
> This implies it was a kernel regression. But it can't be a kernel
> regression because previously there was no support at all for the sysfs
> interface on powerpc.
> 
> IIUIC the regression was in the ppc64_cpu userspace tool, which switched
> to using the new kernel interface without taking into account the way it
> behaves.

The reported regression is in the ppc64_cpu tool behavior.

> Or are you saying the kernel behaviour changed on x86 after the powerpc
> HOTPLUG_SMT was added?
> 
> > On a system with at least
> > one offline core, when enabling SMT, the expectation is that no CPUs
> > of offline cores are made online.
> >
> > On a POWER9 system with 4 cores in SMT4 mode:
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*
> > Core   1:    4*    5*    6*    7*
> > Core   2:    8*    9*   10*   11*
> > Core   3:   12*   13*   14*   15*
> >
> > Turn only one core on:
> > $ ppc64_cpu --cores-on=1
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*
> > Core   1:    4     5     6     7
> > Core   2:    8     9    10    11
> > Core   3:   12    13    14    15
> >
> > Change the SMT level to 2:
> > $ ppc64_cpu --smt=2
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2     3
> > Core   1:    4     5     6     7
> > Core   2:    8     9    10    11
> > Core   3:   12    13    14    15
> >
> > As expected we see only two CPUs of core 0 are online
> >
> > Change the SMT level to 4:
> > $ ppc64_cpu --smt=4
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*
> > Core   1:    4*    5*    6*    7*
> > Core   2:    8*    9*   10*   11*
> > Core   3:   12*   13*   14*   15*
> >
> > The CPUs of offline cores are made online. If a core is offline then
> > enabling SMT should not online CPUs of this core.
> 
> That's the way the ppc64_cpu tool behaves, but it's not necessarily what
> other arches want.
> 
> > An arch specific
> > function topology_is_core_online() is proposed to address this.
> > Another approach is to check the topology_sibling_cpumask() for any
> > online siblings. This avoids the need for an arch specific function
> > but is less efficient and more importantly this introduces a change
> > in existing behaviour on other architectures.
> 
> It's only x86 and powerpc right?
> 
> Having different behaviour on the only two arches that support the
> interface does not seem like a good result.

That's unfortunate. At the same time changing the x86 behavior would
potentially lead to similar reports from people relying on the old
behavior.

> > What is the expected behaviour on x86 when enabling SMT and certain cores
> > are offline? 
> 
> AFAIK no one really touches SMT on x86 other than to turn it off for
> security reasons.

In particular I am not aware of x86 suporting those middle partially
enabled states. I don't have a x86 4+ way SMT cpu at hand to test, either.

The more likely excuse is that there is little use case for enabling
previously disabled CPUs (whole cores/thread groups) by changing the SMT
state, even if the SMT code happened to do it in the past.

That is, more technically, that the value of 'off' is 1 - 1 thread of
each core is enabled, and another value representing 'core disabled'
with no thread of the core running is to be treated specially, and not
changed when setting the system-wide SMT value.

These are separate concerns, and should be addressed by separate
interfaces.

Thanks

Michal

