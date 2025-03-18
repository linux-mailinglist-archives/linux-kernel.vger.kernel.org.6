Return-Path: <linux-kernel+bounces-566833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E3A67D15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6B67AC042
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320301E1DF4;
	Tue, 18 Mar 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jES3Blc4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB461DF724
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325968; cv=none; b=Wmj8vkrZlcK8f6+T/KMF2vwDj7JScNXa5i6MTZRrzhRFsDH/oY8XziM9WNT0ONk/3PzzRuOVvH02IPlEBV0qSgI9KqONhOYUo1WSZ5rgzlBLFpaT+p3UVzRW59eodjzztntwSG+P/Ld76nVnHOhUpz2X8Jq9lh2eI8luK4SvKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325968; c=relaxed/simple;
	bh=vVDYkROOfijHQ9/R4yU2UigJk2uyjAJvB4oxP6FqEiM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=X2LcuAMCxtdeqx7v1UL1Yo2ByOFdsPZx9G0B9Qr0FbLl3amh5UfJyHF2gDkREBHKfboj2X/OMcTAph9FIuRuAUt7obqRcbOb79GUY1gDY83xvt42creT1ePx0MJZNLV5SwV2rXWN8JGZdoXEuD7FYQBBow0g2DhY9HfnYrJa7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jES3Blc4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52IJPZ3b1159089
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Mar 2025 12:25:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52IJPZ3b1159089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742325936;
	bh=vVDYkROOfijHQ9/R4yU2UigJk2uyjAJvB4oxP6FqEiM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jES3Blc4fu+XKW4LuexgnAx/O9SqZ9/9qLLOP/zCGhIYP6laDE3uKtF7HzsQx1/z5
	 1bgxh53BQZXGnqoQf0P5AFn26iEcObhGtzOVruXwiDRhus5ncLKjmoverY7YG3zRjY
	 KG0OjmsNu12CeU1A/gccvRjs5BZ4z2ztHV8j1fsuWAtNleYfs+vQFseIvqHysCZ9ny
	 rgwKHEl48dqv/eEYPLIhHhEfysCMUPcxjNEk/4LeNB031qB3alBKkDP0iG+jny9d26
	 QOnE0h7NGQC6ONvnvgOXf752PSsli9ZxORsu2disLv39+QqwHkaHtPX+C5zdfYLcJJ
	 VXaPGhA0ac1Fg==
Date: Tue, 18 Mar 2025 12:25:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org
CC: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
User-Agent: K-9 Mail for Android
In-Reply-To: <bb1d6eb7-7dc8-49be-a4b5-aa461e85ac0b@citrix.com>
References: <20250317223039.3741082-1-mingo@kernel.org> <20250317223039.3741082-5-mingo@kernel.org> <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com> <bb1d6eb7-7dc8-49be-a4b5-aa461e85ac0b@citrix.com>
Message-ID: <57505261-45EA-48B6-824E-49AF2203C094@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 18, 2025 12:09:59 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>On 18/03/2025 6:48 pm, H=2E Peter Anvin wrote:
>> One more thing is that we ought to be able to make cpuid a const functi=
on, allowing the compiler to elide multiple calls=2E (Slight warning for fe=
ature-enabling MSRs changing CPUID), but that would require changing the AP=
I to returning a structure, since a pure or const structure can't return va=
lues by reference=2E
>
>It's not only the feature-enabling MSRs=2E=C2=A0 It's also OSXSAVE/OSPKE/=
etc in
>CR4, and on Intel CPUs, the CPUID instruction still has a side effect
>for microcode patch revision MSR=2E
>
>There are a few too many side effects to call it const/pure=2E
>
>That said, when experimenting with the same in Xen, there was nothing
>interesting the compiler could do with const/pure because of how the
>existing logic is laid out=2E=C2=A0 Removing volatile and the memory clob=
ber
>however did allow the compiler to make slightly better code=2E
>
>~Andrew

Well, I guess I lump CRs, DRs and MSRs together=2E There is also CPUID for=
 serialization, which is really a totally different use for the same instru=
ction=2E=20

tglx has suggested that we should cache or even preload the cpuid data (th=
e latter would have the potential advantage of making the memory data struc=
tures a little easier to manage, given the very large potential space=2E)

The biggest issue is that there is no general mechanism for detecting whic=
h cpuid leaves have subleaves, and if they do, how many=2E I *believe* all =
existing subleaf sets are dense, but one could at least hypothetically see =
a vendor or VM define a CPUID leaf with a sparse subleaf set=2E

