Return-Path: <linux-kernel+bounces-187360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B68CD0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184DD1C22DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406A1411C2;
	Thu, 23 May 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+w7MO7E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6uZdPj1e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FE7E578
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461250; cv=none; b=fAiNLUCqMKrVXan9lopMcHOEkJetnS8u4QfrdA5EKgpGGs1qUbGatCqx9YX5+/7D03J/vpl1Vr+KpYty+ijNyi8uuUhDk+eYGxpBG3NcSpiyf4fTxPT7H96Mtec9iuwZRPNVTHICgUF8g/XfchI4Kc8dQm6UdAeKCIwC0I4+yXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461250; c=relaxed/simple;
	bh=6xic3m2Z/b8JssY+G+yC8GMAsB3STPNjvhrSe+2GBMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=on4OOFjbMqSnt9wElIvvqU1M8P+h8hLyK7ZlJhpIcBiUIwMOtPg0vMWIUcX0f3CyTFW2Co8VfvMEZmKC7+HAJS6Cb+bJdw8PTlNg/pn32XKUeqELdPpqQ463nuHCdkjGyOaicE22TiN0qq6ILeWFSsBbfYRjPXZLinU2U/NInBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j+w7MO7E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6uZdPj1e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716461245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTwoj5FwMGiUZwdUDR3dax8zYvyhGmcof54ev8Ziq+g=;
	b=j+w7MO7EQlshksBt9zvxu4/RxLkQjYkkl3h0TS6e23Le1akHEJ2eGfAfHid11oQr/3k6PR
	Q53S7NA6ABFJyhEK+ADVmyJjWXP03czQU8ZaudrGxrIpDAYvIKweXsRV11QsxOAiUnjmgu
	GFaIrd7knkTn5uEiO7h8vqUBbHKHqHuPey95ibBswilEE7GtHML3CXFZWKxczY4ja8eRFE
	x7gI+AFwAFyWctyGYubZ75tvSgUZNB1YfkI0Pie6YBHSU+K4Mfh8ItYfUaiEQteM7luTDn
	bgQR4pBFbawj/xgz7L/dT3aH5/Pjnbnya9bhfj+cWOZWR9/c67BDQmfsdWqqXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716461245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTwoj5FwMGiUZwdUDR3dax8zYvyhGmcof54ev8Ziq+g=;
	b=6uZdPj1eNrEX5s105ZK1m8W7edXARJxa2F/dv8YLmrCbJaF5n6CTEJn6Uj5U8xKY5iXJsx
	juNbm9BGR4H0xmAg==
To: Lyude Paul <lyude@redhat.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <874japh4ww.ffs@tglx>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
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
 <87jzjxn6s5.ffs@tglx>
 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
 <87bk58n6le.ffs@tglx>
 <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
 <87wmntkhak.ffs@tglx>
 <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
 <874japh4ww.ffs@tglx>
Date: Thu, 23 May 2024 12:47:25 +0200
Message-ID: <87sey8g5z6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude!

On Thu, May 23 2024 at 00:12, Thomas Gleixner wrote:
> The first issue is that we don't know whether that's only a problem on
> your particular system or if there is an underlying systematic problem
> on that particular CPU variant (model/stepping).

Something I wanted to ask before. Is the BIOS of that machine up to
date?

Thanks,

        tglx

