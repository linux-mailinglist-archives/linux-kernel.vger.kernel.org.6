Return-Path: <linux-kernel+bounces-269694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38169435E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9992850DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2163B14F124;
	Wed, 31 Jul 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nj/a2JY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfJ06FYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD613B2BB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451995; cv=none; b=elhmG+Dvu4ytogeBTxhuVWj/7pk8aqWkX98T39JetQqB6k1ZOJ/Qcu+Zmz91SUCGFXgI7g6cZtT5gGBrIhFoB9aIwU50bfxIW3j04FZmJQTZ1YmnQdudOMi1K+H6Dc4l6iqY6YXx0bOdDXV5+pjHEdpg1WmhGLJsOGakPrspwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451995; c=relaxed/simple;
	bh=UUi5/J2ap4WNpFaqtmfkjaBR6xBlhFPX1Fgv6gjnn7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JwYrY4Cnj8qLaOGxTArQ45o+lR56nl8jxoP11VUFhX0Ixy6soDc1xsjdiZGVMcY2nJf2Ba827Qwt20hhlvnWHiV9pFM2001eOFfaNf//AiJzKxvZ4E4OMU4MdmlQoCrQVoj0Plizd1MY1PJpSU1MTkGdf8OUu9FgUV7pk1X0g9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nj/a2JY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfJ06FYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722451991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3aMem7ZER8M4kJsRCB2muNUJiSoszp3BgGAcEL0vVY=;
	b=nj/a2JY7znXXhTX8mRM4yHNVeNi50SwafccRZlHINGCLHFY7wu5FE9zL3nwIRNLm2BpNHs
	8z5NmJOaRBrzuF/ITE9OYAMv6SlYeDYhN48RW9l1Tin/X1N5d83bWehXz6j95e2WS/IRi9
	m+UydU8rodVeCT71wAo6pMDADZiCLXGND8xfBF5hoYTPxycTO7DABWxZjzWwv5d+Bc2BjW
	zJef3gblC9DcmJ0bIyO5h2w5yjUBikzKUJorgMOPvbi73BVy8B2UR808FtMqscEGdsG8uq
	uoEIyJjVvFqqinbr08giYSOnlIc5CJ2pwjrgsKWlBBpZ3/r4OuPkBesiFW3a2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722451991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3aMem7ZER8M4kJsRCB2muNUJiSoszp3BgGAcEL0vVY=;
	b=CfJ06FYrJoMT7+EKbU1Xmp6RiaTFuKy9J/rFjH4dN5HziiZDQCFAh5axgx4JQ6DW6wWJf/
	uX4SbG/SPawEJwBw==
To: Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, paulmck@kernel.org, rui.zhang@intel.com, Waiman Long
 <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4] x86/tsc: Use topology_max_packages() to get package
 number
In-Reply-To: <20240729021202.180955-1-feng.tang@intel.com>
References: <20240729021202.180955-1-feng.tang@intel.com>
Date: Wed, 31 Jul 2024 20:53:11 +0200
Message-ID: <878qxh5r6w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 10:12, Feng Tang wrote:
>  	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
> -	if (topo_info.nr_rejected_cpus)
> +	if (topo_info.nr_rejected_cpus) {
>  		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
> +		if (__max_logical_packages <= 4)
> +			pr_info("TSC might be buggered due to the rejected CPUs\n");

I'm not really convinced of the value of this message.

People who limit their CPUs on the command line or at compile time
really should know what they are doing. The kernel already tells that
there are rejected CPUs and that extra TSC info is just annoying and
confusing noise for people who run that and have a perfectly working TSC
on a single/dual/quad socket machine.

I just drop that noise.

Thanks,

        tglx



