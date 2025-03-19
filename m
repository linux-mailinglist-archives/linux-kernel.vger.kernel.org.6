Return-Path: <linux-kernel+bounces-567241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4906A683BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B877A4B09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3520B7E2;
	Wed, 19 Mar 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wim0ReK6"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E44690
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355087; cv=none; b=KAiTwlP67mPDAvWNt09lQ/dd2GTyzcgp+XT4A6g9ehiWZb11xG6TsG1v566gtFmLqGSJ0Mf9NG6vIAofC3lQZoDb3ReEBRCURampW04JI4CNScCFTmWPSIym/waSWJCbRswt+XRKUsQ2vAHZZBipxlm6FHEXqWPpiGrsM5cx2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355087; c=relaxed/simple;
	bh=9G+X8S/v429Vow2GuVQbZRlED+Qj1Ccya4xo2OCzUWg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=W/GY0yMgGz+2rNH0Z3pkDTdg6qUMRjK95Y3zAZKDk3F5fCFdyooivy4ZdrazUfgnaMn9IuiDoqc4AyDWkMvyQj712SLIx7Ssvjf1KZnEhs2pXM2FmuusnzrC13FhrRfa08LsiZGRLtR6mjcnDLPfevpZaPsCc+STKP2RfLk7/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Wim0ReK6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52J3UqAc1321961
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Mar 2025 20:30:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52J3UqAc1321961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742355054;
	bh=XkzRW8S4iG77INjLobxxM00eT3gh8YW/E/qtbpPX0fc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Wim0ReK618S3/6DuWrj9Laibe7pH9iCkwKZXnp/nV0fJ8Y4+6xCk6auuCAjH9t4bR
	 2N31Vhd1SwnelVEIzfTHtT7EasYGDjhcKQZh6cUg3vBOt55SEi6AAfnTOHH+LziHVr
	 xmgHGwzJKQcDhSHa6Qzj9bod7dVoYZRUh8a2vMBtL4dyMFIU+n6QZFEkXjbK8R1tdC
	 Q1Fz2yHijy1zKPrEp7xfSukXvtH/BSQN8auC85nEDBid99muWIy4SFq9f7xn4XyOnA
	 TEgHv7DXrDWmByLA9kOb/T0D8uU9neFd42/Jg3pkysEtB42AmT0sO/Q9iKLXZ95OT7
	 BixWC5zb4g+Pg==
Date: Tue, 18 Mar 2025 20:30:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>
CC: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
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
In-Reply-To: <Z9m1rtmlk1PxGIQA@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org> <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com> <Z9m1rtmlk1PxGIQA@gmail.com>
Message-ID: <76FE5F63-A27F-4D99-A9D8-DD316EA78656@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 18, 2025 11:04:30 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> It would be nice to get rid of the bleacherous use of *eax and *ecx=20
>> as input-output operands=2E The use of four separate pointers is just=
=20
>> barely tolerable because the compiler can remove them when the asm is=
=20
>> inlined=2E
>
>So we have a nice structure of:
>
> struct cpuid_regs {
>         u32 eax;
>         u32 ebx;
>         u32 ecx;
>         u32 edx;
> };
>
>So instead of:
>
> static inline void cpuid_count(unsigned int op, int count,
>                               unsigned int *eax, unsigned int *ebx,
>                               unsigned int *ecx, unsigned int *edx)
>
>=2E=2E=2E we could have:
>
> static inline void cpuid_count(unsigned int op, int count, struct cpuid_=
regs *cregs)
>
>or so?
>
>plus we could implement the main CPUID call as:
>
> static inline void native_cpuid(struct cpuid_regs *cregs)
> {
>        /* ecx is often an input as well as an output=2E */
>        asm volatile("cpuid"
>            : "=3Da" (cregs->eax),
>              "=3Db" (cregs->ebx),
>              "=3Dc" (cregs->ecx),
>              "=3Dd" (cregs->edx)
>            : "0" (cregs->eax), "2" (cregs->ecx)
>            : "memory");
> }
>
>and thus we give the asm() statement only a single pointer in essence,=20
>'cregs'?
>
>Or do you mean something else?
>
>Thanks,
>
>	Ingo

Yes, I attached an example, but I used the structure as a return=2E

