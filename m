Return-Path: <linux-kernel+bounces-566288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55542A675E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A853A84D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557E120D515;
	Tue, 18 Mar 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Bu1mQfwL"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC2126BFA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306741; cv=none; b=aJI1Ux70FtPacG3FX3l00Ff8IaJU6D+dAycUWTfz79MHSuHeGwJSf9BHsE8B8zOExn6XfRl2Xj3SIj+Q03fOiIPokk5t4tis52bM+fPB7qtSx2OeuTgt/RlfSFD6dj4ojxm532JKmUUP0wHG/TvUC82wxKB2xF9h8wQPCjERE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306741; c=relaxed/simple;
	bh=6HRxJdhRl5ryVD7r2k2KY6j6OAQgrAXwY8e6c2hP51Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hBCBPDuq+yp8/fgEBPbJLjji5m14yUYyZiaoWHzW7cJEmBd9PCzqiswNa32eeUUoefErSAwBpli0WE9sCi0FnU7BUN13FCb6m9alvHzQOPaA3dpICxaW9DuH9qbcegG3jgP5KMSJc3RSx7QpkprSc0Vdc6BJj1/X6kmHpDIkiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Bu1mQfwL; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52IE52TD1047232
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Mar 2025 07:05:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52IE52TD1047232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742306703;
	bh=xcskFzaJmWwQHhXRNYnfle/H5Zmhj/Ez80BK/ukbygY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Bu1mQfwLBBJceyU6GlMRpaM6gtgBcicKIGbgEGv4ltalRZv4cPsJg8LQCDPjzq5V9
	 NzmlUjUuZgSgm6XTCpGApYKINAF0K2ioOZPNVw4eBKwj7ZbTzvIAdnXptrdACF2x83
	 2TXRsWyh39TnvoBgrRmwzgQNdxJ6OVAM0WgZm3Fc1jSoZKnUpq/+gTXRlgVaWyhU09
	 p/a6orH5bt015IxPO9k9RvYC1fHJwdiQi7wyoMxTyZAWWn8ujVa66ncQP56CO1p1dx
	 4fY6qFKSXwXvHNmm/u5FS7/p6QbJVa/BKO5XspVKQcxgLZPwCiXDibEV7DNZnqZL0W
	 VVRYq2eG5s3sw==
Date: Tue, 18 Mar 2025 07:05:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
CC: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_x86/cpu=3A_Introduce_=3Casm/cpuid/t?=
 =?US-ASCII?Q?ypes=2Eh=3E_and_=3Casm/cpuid/api=2Eh=3E_and_clean_them_up?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250317221824.3738853-1-mingo@kernel.org>
References: <20250317221824.3738853-1-mingo@kernel.org>
Message-ID: <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 3:18:19 PM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>This series contains Ahmed S=2E Darwish's splitting up of <asm/cpuid=2Eh>
>into <asm/cpuid/types=2Eh> and <asm/cpuid/api=2Eh>, followed by a couple
>of cleanups that create a more maintainable base=2E
>
>Thanks,
>
>	Ingo
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>Ahmed S=2E Darwish (1):
>  x86/cpuid: Refactor <asm/cpuid=2Eh>
>
>Ingo Molnar (4):
>  x86/cpuid: Clean up <asm/cpuid/types=2Eh>
>  x86/cpuid: Clean up <asm/cpuid/api=2Eh>
>  x86/cpuid: Standardize on u32 in <asm/cpuid/api=2Eh>
>  x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api=2Eh>
>
> arch/x86/include/asm/cpuid=2Eh       | 217 +----------------------------=
----------------------------
> arch/x86/include/asm/cpuid/api=2Eh   | 210 +++++++++++++++++++++++++++++=
++++++++++++++++++++++++++
> arch/x86/include/asm/cpuid/types=2Eh |  32 +++++++++
> 3 files changed, 243 insertions(+), 216 deletions(-)
> create mode 100644 arch/x86/include/asm/cpuid/api=2Eh
> create mode 100644 arch/x86/include/asm/cpuid/types=2Eh
>

It would be nice to get rid of the bleacherous use of *eax and *ecx as inp=
ut-output operands=2E The use of four separate pointers is just barely tole=
rable because the compiler can remove them when the asm is inlined=2E

