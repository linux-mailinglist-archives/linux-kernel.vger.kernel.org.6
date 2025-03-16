Return-Path: <linux-kernel+bounces-562956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB458A6351D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D1F188FCBF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496F1A238E;
	Sun, 16 Mar 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OpwdzX9F"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4F16C684
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122426; cv=none; b=UR5mAM2WXmycxOugpfwHs8M4Sk79DoAqnAl6h/bdK5mwSwlhTUyR7mIWfjBRwueYjNJj7XDNUEP/91xCqhRsFGof3jZY7oj+7kLfCBaWKUmwZajhuOibFmbyhi+7SV7zTTz7p3TwBTgycEmLRZotu8syNoBvdHVflnSCSR2wqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122426; c=relaxed/simple;
	bh=0AuieFQ5Yt92W7/3P5JqHhZD2He2RuMItGaSw2MmXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCf9IaGnPBRIAaPV2coz6eqkj8QXOJ24Nane1x8Y8IBuoX/om7QALepgHfZbhZC5Wzs3DwPlyJAR4KTIV4GGYEoXFdkByR51n00QYK2nWH/GMkRcfbYAP7Zty5f1kTxP836sEMXCqtU8tnCUUpl69WlV5+pvtQEqiVxvSI9Rg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OpwdzX9F; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 82D8F40E0214;
	Sun, 16 Mar 2025 10:53:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wqc6e4tXAxXQ; Sun, 16 Mar 2025 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742122412; bh=N1s/+9rJWtLKz27pzq5l9tCqGf1zk5rEXNigOD5mLl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpwdzX9FFbjvo5dFwIbDERcHH3ZGKLK7Ped5pi092WZU5CcMuWv/kn1PZSbev8miB
	 bkkvKlpne/Hg1PCYkOzUpze/YucwCJKoT78Lmjvc0hADP4U/6Dxz4uBwAt6MaBOIEV
	 I3nW5+6/+p1j3LymIkKdCWYk8JMF5MiKV7GKOLE0z0YjgAE9LDLOdifId0uXpNw99Y
	 rfteELZJGU+KGrEnxkg3ZQlU6C+rB33cIwiM7JzB4/4qIGwKS79NnXfEm0ZHlLwKoj
	 LOZMIuJfHX8r1gK93jS5jbP+VNPBwKWLVwrNw+LxNp3qTT0JwoTXw0td2I4kdsoeA3
	 8KoVsyTw7qGSR6IGf2sEsNw053DNZqYjVauob8KjDwlCSXuCjbJ2nA8CfpoBntP3ri
	 +IIhXkhTUWohXXgdSEOAcfRPcTn79++l2fd9h2a3rraWfnFBZGZGdhA2mScC6fkNpv
	 9HHBJOA2NysK1F6N4V6aMqxmKBQihklhh75QcqdhRUFmeP9iRiQ7g8FyBJsDXOjiDF
	 4FmHAu8GNNCGx+E64wFFAmS5H/tf67YuLJNfkVHf587lk0etPCmvGmsj1wtMaKnCZX
	 Q9P1tSboTWs+g4LCZyjw+ivub9mSKKbADdiYrWRzqU1QjEYXJntJVPnMxthW/FfGHC
	 /I55+x6CAy35cyBbjOyb6EIQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BB4140E020E;
	Sun, 16 Mar 2025 10:53:22 +0000 (UTC)
Date: Sun, 16 Mar 2025 11:53:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 amd_clear_divider()
Message-ID: <20250316105316.GAZ9atnKtYqZjvS4JY@fat_crate.local>
References: <20250313191828.83855-1-ubizjak@gmail.com>
 <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
 <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
 <Z9QB0nP6Mb3ri3mj@gmail.com>
 <Z9QCRydO2yiCq_YR@gmail.com>
 <20250314132306.GDZ9QtukcVVtDmW1V1@fat_crate.local>
 <Z9YdQ9fe4NJ1ciyi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9YdQ9fe4NJ1ciyi@gmail.com>

On Sun, Mar 16, 2025 at 01:37:23AM +0100, Ingo Molnar wrote:
> Yeah, so that's a suboptimal test for these particular changes really: 
> why would a simple CPU-saturated kernel build with low levels of kernel 
> use of the affected areas show measurable changes with this commit?

Thus "Or maybe I need a different benchmark." :)

OTOH, it still tells me that if there are no negative changes in *that*
benchmark, then I should not worry.

> So on my system there appears to be a measurable improvement in 
> performance on this particular benchmark on the order of magnitude of 
> around ~0.8%, which is outside the measurement noise of around ~0.2%.

That's fine. It won't make me fall off my horse but sure, there are some small
improvements. Just don't let code readability suffer along the way with those
exercises.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

