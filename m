Return-Path: <linux-kernel+bounces-177671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102D8C42DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EE41C20F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB816153835;
	Mon, 13 May 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d47PCMxb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vw0P+P2F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38396153823
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609326; cv=none; b=AVcltC2k5ULPaNLK+y5DsuQAwunJG3Qw8ld8JjwZnSy1ImzdUJDSAYstpEzeRN4fdyJwbgQ0ZeoApMqb66jpazmT7lV2nWb1CSmODPVYwDq95k6vSz5wcdWOlJY8XNLPPISm1xN9/p+1rAptCUJjXmATre84u7nbVn50RajS7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609326; c=relaxed/simple;
	bh=UT5j7BgJNNrlLd9K13kM/MkWDznH/+I5nuxgWBNbFDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DX1wV3KyXA2fuKganz0lZb3S1tgsfF9HQtUiL1QdE0XxRtCRsx41LccqRiasKB8s8IML/onuMruKtgYiY98iM6nFAOcvflVKT8XN0V9eEfBjo9edKpHwHB39Jp+p37zmp3mf2Ie8W6LEchMh1GCzgxf0MZjIc90riJgQ0XPgKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d47PCMxb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vw0P+P2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715609323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlV+zvrsTzEjXr8XFq27EiNK1xlgS37wfphlRcyXsZs=;
	b=d47PCMxb+7X00xF0re7aKwR1NF5o93jJuXr0CcBg168+ySKiSATgNERdALWpHlyTg8CRmr
	JYm42p5ORow7rQxfyEc/vhVkLln68Wgv3f3UqemDUC2n0sJ+GSWMu8ZXjeZZIyRD77cfJb
	qiz+IfPM0Q/p65YWV3T0vp7QFYfHL2HPoE2WfEB/9RAVwSBg3jyIjSqOg40g5cyrqzIfx5
	fL7p9TM+x05j0p1kY0+JuPiuBo6KiRpU3ZGmvINBIMlIjkMr2ZJbilFl08EDNLYX/LgCfq
	wprKnh4mjZDOWbKiGSMOzFmlOHcBC1S+fyR+9gneNriq4MJ18uj8nxoiwdCLzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715609323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlV+zvrsTzEjXr8XFq27EiNK1xlgS37wfphlRcyXsZs=;
	b=vw0P+P2FxgAyUMs8hP3N9W6LMWgiTzIJ2p0xX4ne7diYGDi6nkvuyqDzUeBKlEpgUh3IkH
	GLKYrKLgM/STqwBA==
To: Lyude Paul <lyude@redhat.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
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
 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
Date: Mon, 13 May 2024 16:08:42 +0200
Message-ID: <87jzjxn6s5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 08 2024 at 19:21, Lyude Paul wrote:
> Regarding the test results - I tried possible_cpus all the way up to 17
> and nothing got the machine to boot. However, possible_cpus=8
> intremap=off did get the machine to boot successfully

Oh. That's interesting.

Does v6.9 (released yesterday) boot with just 'intremap=off' too?

Thanks,

        tglx

