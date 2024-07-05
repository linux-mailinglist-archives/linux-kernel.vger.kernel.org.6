Return-Path: <linux-kernel+bounces-242093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33F92836A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A445B214A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1B13C8F3;
	Fri,  5 Jul 2024 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+iYVyTe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E91481AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167074; cv=none; b=KsadiXFI80S/cIla21efV+7sVVqC0xZCEMQNEkZiMjvif3g0A7shXkijCUjJDll2ObVcrUha1yD+GWjO3Uk21HHga2F8q4oMYuye0FiZ31Nf6e+wjgvTuECKHN9TPXheRkA/mxgDE1R4/ROK7k/X4RCsbyBBxk7ScCEo8lf7Bpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167074; c=relaxed/simple;
	bh=gBqPfmddrH/OaT/vComJkfGDX4lFxIXlD55M1/sZb0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFe53pyD3+Tgq0sVnpwnqaml9yDmaTNSSK0Ph//7W554KaiAxOgf7iyHpDGgg2Qw4kVIQg2/ZkjK7OBHn4wfhZRdsoa1JfDkVUlxTFVDMCkt4jgabnzGaNMG/g/p+xItV+zxglg+Ekij5ppLLgOyeKl3W+Mna4AqV1Imp7tzHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m+iYVyTe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fTspDeJXWYWa25zTECERqTETokK/MNLva0Gqhr5gqqY=; b=m+iYVyTey7Jm9MaPKUbsk91cox
	w6+heyZqJrc8j4c/eSjQPBxqZLL9ngfPG5t/wPhdWihp2CNPzt+HOY26+s1ZRV9rEs0AoPe/F09yX
	j8r8naa+k/YLGcQtfYFJSnMv8fgy/txqh+Cxv2TF8k68cUMiVhDBBdwdD9xVACK8HW/3RDFIbdXCB
	7MQMf0/Ey+gOj7awGCWyuZ1M2x8+rBhMQRsP9G+4TegfS9cQ/PEB8l4wO9WENnZjBvZjCBPoGMge+
	nRPZBB0OfrbGESrd/T5kHrecbca87MFyA5lgMxgflJen4S7PD2h4poF2ITQh+uU9Me3xu1hbch5jq
	bJ9n3u0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe1t-0000000AJ0T-0vz7;
	Fri, 05 Jul 2024 08:10:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6F493005AF; Fri,  5 Jul 2024 10:10:52 +0200 (CEST)
Date: Fri, 5 Jul 2024 10:10:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	oleg@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
	tandersen@netflix.com, bigeasy@linutronix.de,
	vincent.whitchurch@axis.com, kunyu@nfschina.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, liam.howlett@oracle.com,
	syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [RFC] Signaling overhead on RT tasks is causing RCU stall
Message-ID: <20240705081052.GA11386@noisy.programming.kicks-ass.net>
References: <20240705075622.925325-2-radoslaw.zielonek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705075622.925325-2-radoslaw.zielonek@gmail.com>

On Fri, Jul 05, 2024 at 09:56:23AM +0200, Radoslaw Zielonek wrote:
> Hello,
> 
> I'm working on syzbot bug: rcu detected stall in validate_mm
> https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546.
> I have analyzed this issue and here is what I found:
> 
> When too many signals are sent to the RT task, the overhead becomes very high.
> The task cannot perform its job and as a consquenece the rt_runtime (0.95s)
> is not reached even after hundreds of seconds.

I'm having trouble parsing this. What overhead becomes high? Is the task
spending time in-kernel? Because if the task is spending time in-user
handling all its signals, it should accumulate runtime just fine.

That is, your analysis seems to leave out / gloss over the important
bit.

