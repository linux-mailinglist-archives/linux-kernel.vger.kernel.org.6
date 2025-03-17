Return-Path: <linux-kernel+bounces-564896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FEA65C70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06BC421092
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BD1D61A4;
	Mon, 17 Mar 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZBVDbsaA"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C41C84C5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235769; cv=none; b=peybTYeynzS84xfdA7Adm7+XrDymHji/oHqMCiFzd9x9Z/quZKyZXs1LezeM+/Pq/biKWCGIHmbdZmp5jNkCaR+T4hjS9xUBbR8c8tVF6Zz+UHqukWjCm8WiaGu+X2jXCj/dsHlBwSIBMk46r/Pzuaj8sUvcTGHf+eV06RCEaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235769; c=relaxed/simple;
	bh=GyriXbZlpJ6Jo1sOQ8vUDBnuulxhpkpYweiPBnMk91Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Az8KRi7qPD/2ApOxkwB0AJqlzPAWGHX8y/IAWEMO7zfNSqC4pTI1hJGF/bTq22tW64lytN88Ec+P3G/63WD0sln08opc7uKU8pKJ1kB4b0GOeTQ6JJkgxA+LYKl5oeBKpRwhyDIBzCgzzCHLcWyNAERB6lWX9t48DxAkjX0zMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZBVDbsaA; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52HILhJH658381
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 11:21:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52HILhJH658381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742235704;
	bh=TNoiBfeP+kDKHxkYI68G6dTSldtAFQGfd1bKkMh5e/o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZBVDbsaAc1Eq5CQcDFlB+9HfVq+j38/vuyOpg4Oq5tkKoe7f2wtQxAAennjwxi++k
	 Xxet2d0vcpAaid8km849WEFrNtzIntto1SjHYys4lVieea26tWDUJ4x1qOxThGNyuO
	 qmhwxhDHAlHnmJaYoxPvOgWflIVH7NQVztHhs85hZXAU/wek7kugrwNyexwL3qzhv5
	 eMcb6LBbaY3nT8HhorWqFigeY9NoGDXf5ZkQrLw8eG61oJlzxF7plh6O0owp58ILVr
	 C1YF6PTnuM1Y53+dNnmfPP4JCom6nQPrMIm2wfzpUny7qnLSSLH532nAWegsqtfWib
	 M7l6DuWlsLVpQ==
Date: Mon, 17 Mar 2025 11:21:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
        x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_01/29=5D_x86=3A_treewide=3A?=
 =?US-ASCII?Q?_Introduce_x86=5Fvendor=5Famd=5For=5Fhygon=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0f1b3c76-5430-437d-aa9f-27c1dbf9cf01@intel.com>
References: <20250317164745.4754-1-darwi@linutronix.de> <20250317164745.4754-2-darwi@linutronix.de> <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local> <20250317174848.GJ6888@noisy.programming.kicks-ass.net> <0f1b3c76-5430-437d-aa9f-27c1dbf9cf01@intel.com>
Message-ID: <3ABF7C7E-748C-40BF-BFDC-F1B676DB4F4D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 11:11:11 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> =
wrote:
>On 3/17/25 10:48, Peter Zijlstra wrote:
>> On Mon, Mar 17, 2025 at 06:32:16PM +0100, Borislav Petkov wrote:
>>> On Mon, Mar 17, 2025 at 05:47:17PM +0100, Ahmed S=2E Darwish wrote:
>>>> The pattern to check if an x86 vendor is AMD or HYGON (or not both) i=
s
>>>> pretty common=2E  Introduce x86_vendor_amd_or_hygon() at <asm/process=
or=2Eh>
>>> So if we need to check "intel too", we do
>>>
>>> x86_vendor_amd_or_hygon_or_intel?
>>>
>>> Nah, this is silly=2E
>> Would it make more sense to have a Zen1 feature and check that instead?
>>=20
>> Because, IIRC Hygon is simply a Zen1 copy=2E
>
>Some of them can just go away, I think=2E This, for instance:
>
>        if (boot_cpu_data=2Ex86_vendor !=3D X86_VENDOR_AMD &&
>            boot_cpu_data=2Ex86_vendor !=3D X86_VENDOR_HYGON)
>                return false;
>
>        if (cpu_feature_enabled(X86_FEATURE_ZEN))
>                return false;
>
>Do we even need a vendor check if we're checking X86_FEATURE_ZEN? Is
>someone setting X86_FEATURE_ZEN on Intel? ;)

Maybe having a vendor bitmask instead of (or as an alternative to) an enum=
eration wouldn't be a horrible idea=2E That way multiple arbitrary vendors =
can be tested with a single test instruction=2E It would be pretty crazy to=
 have 32 x86 vendors, never mind 64, without a *dramatic* shift in the ecos=
ystem (there are currently fewer than 32 registered RISC-V G implementation=
s; that doesn't include the myriad of microcontroller class implementations=
 that don't implement the full G [general purpose] feature set =E2=80=93 bu=
t those are irrelevant for Linux=2E)

    -hpa

