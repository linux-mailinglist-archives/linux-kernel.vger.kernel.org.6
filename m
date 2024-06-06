Return-Path: <linux-kernel+bounces-204054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437A8FE368
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7301C247AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6496917E8E2;
	Thu,  6 Jun 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bm614vT2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="St3G3ObY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72946145341
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667434; cv=none; b=tJd9zF3zGXxTGCtX7QWq3JPomkwPC9zZUPSPxAUMcfkx8qbJNQ6ET/T1NpMhFBLaveRI88HnQleIJSirV5AV0K8ic0fyexVVrS3L8/mM0IpLHECwt2409nM+9wSbTtM+fMAbyPRPp4k12Ay18MNkzINzNQwiPlD7WTH1nAkSbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667434; c=relaxed/simple;
	bh=lm+tZvLpwOpjennQ5G3mOnuxYiEGPtNMeoQC/xtfm/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9y+Zb/gHS3TjgB5ajABbfyi/gJpdbdtVzYm95e3R6J7E0l2ItLc3D4oA6mKQlYszAVoiWyVdSElyr9rN1bqNCsSXUZxMHE6+s9HSiIdXoK/R4FIHNyz2rSun3bX6UsBNpfCpZ6FEo5EG/muxIxqXWGTjQfsUUdd3frBzcG+9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bm614vT2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=St3G3ObY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717667431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0anSg5HnrHQ7YhX2xXgy9E1PuGLrtp/Whwg+6ZdKAEE=;
	b=Bm614vT2gZX+sIeVYXayBByGzx1qEftbZThOOCvuLy+qR3zkgfweswPO1jjDT9HGc72rox
	ws5zLwLJZ+A1gSVBY7paDsRtmAcx/NTIgjzLQFCwARYJq8n4t0UyCoeEwQm90WEx+XVrnG
	dCXZCIEtK4A1QKqm2qJICM1go8GlNeWIVEC00f2IbGyxMkCgvxFQ+Cu/PIae2NIhxd8OC3
	SJk7ekRwY85iydka7WLtaUgPEX/tmbeCsQNLYG8mPMEhfCboh0n068pOYJgSVTaKR5V1LI
	tKuUmZ7Uw+89DHRKEyKtAQTvBR9uNIxTzXZ7QI+G+OrLdK2+gnqs8y2gFEXR9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717667431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0anSg5HnrHQ7YhX2xXgy9E1PuGLrtp/Whwg+6ZdKAEE=;
	b=St3G3ObYzx0fFFpvGuIjyT55hQnSJtRw4spoGTAgqbtvCLYmb5Zh0CKifQu4tD6opqI2JH
	oqQn3f4D08i5hHAA==
To: Lyude Paul <lyude@redhat.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <c735dcc6f6e4d4074bc834fba7204e22779e9ab9.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
 <87jzjxn6s5.ffs@tglx>
 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
 <87bk58n6le.ffs@tglx>
 <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
 <87wmntkhak.ffs@tglx>
 <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
 <874japh4ww.ffs@tglx> <87sey8g5z6.ffs@tglx> <87ttiha77b.ffs@tglx>
 <c735dcc6f6e4d4074bc834fba7204e22779e9ab9.camel@redhat.com>
Date: Thu, 06 Jun 2024 11:50:31 +0200
Message-ID: <87h6e62ye0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 05 2024 at 19:15, Lyude Paul wrote:
> On Wed, 2024-05-29 at 00:43 +0200, Thomas Gleixner wrote:
>> Lyude!
>> 
>> On Thu, May 23 2024 at 12:47, Thomas Gleixner wrote:
>> > Something I wanted to ask before. Is the BIOS of that machine up to
>> > date?
>> 
>> Any update on this? I really don't want to add magic workarounds if
>> there is a BIOS update which fixes it.
>
> OK - just booted a normal kernel up after updating the BIOS and you're
> right - that does appear to solve the problem :). Thank you!

Perfect!

Thanks

        Thomas

