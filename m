Return-Path: <linux-kernel+bounces-173066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B28BFAFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B9E1F218B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533080C13;
	Wed,  8 May 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQOUulpr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kwT/hKoY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464807D07F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164255; cv=none; b=qci/au+2pmgUdkYKD36akxwq54LXA3KjRquBOzetN9DZkhSXwfRFLD3/VEJh0hwpX03UR/naQTXecH0Zcc39zO5YcJl5cIyKLEkxk9v/1g3hG+a2GAcDwsD5kGMyMbjNdIV192mhCCA9WpEIgPximDMXPRZA0enCVtkP0eDAzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164255; c=relaxed/simple;
	bh=1s1srL/0Gf207uvzugl9RQeAHt4XjTI3gJLbGtQOu+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BW3QQ7aPjeCEOnSL78hzJw1a/b9SQoEVC0UD/ysbs05PJTEzUcrMdH8bVe7ni2PONOXv14RtHATm/NsoQV9RAewg7Fb9AgALP8+B4A6sFm/2uEy+MI3WEBVAZyYeY/IVvlyvWH+L5NDXr9f6mRkOyhlFu8KhrM37UfHhiOu919A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zQOUulpr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kwT/hKoY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715164246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPZyOXQkR021LGnLEOzBIbVQbMD9fJILR+LSRL1gNE4=;
	b=zQOUulprpgeUMTHmL0oMnJryQerhGSotERp6mn92CcyQsc9dwNQGFKUgYmlh2OUfm858hd
	GJgvBQJLIOIpqWSifqQJ+BwlKMseEq2uQ1pLb4g/2G6TdEhxToGjxdl2eViRdFZrYR2tRx
	QvfmXf+cAWb6lwBKC0cvtwvGpZ0Lm1aJgXrcpxNQrwJilWmVdZ9wQ9ChYzBkMJ8b+uq/+X
	Bqoelu91pkSP3Efetzxt6Wwok8Bosgt+eJYkpoUmElK9pUh504ur+yzv3fmwbeqgr70qMu
	vmNJecHdOgVaBv8zslbVDtyRLRjfOJU0GsJA2w2o32TNTR8YgKcTq1jfFC5GWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715164246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPZyOXQkR021LGnLEOzBIbVQbMD9fJILR+LSRL1gNE4=;
	b=kwT/hKoYTCSSfWR9UBWCfdlbHqamionQcfGl08K7KQH/f5NdtzedvV8c9JB0+PwYM4ABcY
	I2OYPGALZqbIkSDA==
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Lyude Paul <lyude@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info>
Date: Wed, 08 May 2024 12:30:46 +0200
Message-ID: <877cg4ppd5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 08 2024 at 10:38, Linux regression tracking (Thorsten Leemhuis) wrote:
> H! Lyude, Thomas, what's the status here? From here it looks like we
> were close to a fix, but then it turned out to be a bad fix -- and
> afterwards nothing much seems to have happened. Did it fall through the
> cracks, or was this already fixed and I just missed that?

I'm waiting for more data still.

Thanks,

        tglx

