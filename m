Return-Path: <linux-kernel+bounces-551444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54FA56C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754FB3B761A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62C21D3D5;
	Fri,  7 Mar 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="E+7PbPGI"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7821A43C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362412; cv=none; b=VLpfSQr6xKoiqczQGmk83VsSdTUk4ltYE7TadvImn65Qgvdo2AdObc8qtoQtYJkWv/N6PJvVm9DzG3yknCLOFngBBA663Db+kC+V4TjCLBxgQ6ANP46TjCXh/+I7KiBSnw0olwDY37np+P+aK9IhSQw2GocCbF8jWB7aa2bugHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362412; c=relaxed/simple;
	bh=dzdgbrwdwKwC2tc5nR0zRLXxWHoA9QrhHRHfsDPHh/w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YsKYzRhPDUXX/rAYvMdj4llm/O76XUkXIeopm8W+Z7pdPXejWY4PaQ/HrpyXufj4//qFVTemoTsRBOhxzTrN7B4Ppk1Etm49B4ypRHfsKXmxPlkVHDuNZFEQIx66JX+kOkqprKIv1+kaaty9x01xC1rVurdbVeCxqaZzPIz6rZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=E+7PbPGI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527FkNis302540
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 07:46:23 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527FkNis302540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741362384;
	bh=KOlnULMAV8BcFoheWremReuvxNwmBTNqS3l2ZfGHfVs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=E+7PbPGIl1VF2tBRUeN2CVvz/KFRxwbisJXeLr5guAtzFANXT1CRaHDdQ6ChWnViD
	 wyn0yPfR1cdtmkCqX2Gr+M1amQftgxB8gizPHehi0p5u388nJEMy18RZ4j6aNh2ufl
	 2uachGQMgGEgUm2c+XDopd1xJMOks0gKyAKy8EjR0wZnYDuTxwYpygL5u6ZiYfRT6u
	 zLL4zpXKoZrGhPfpHuCiXxTtb56gaVHc7bzm7Tm6Cs7C9kC3ApAvikg4sUH5JK0gFM
	 eEtdjuOkTcoqJJrcOF1LGR2srvZPSUjJlQFCJPVBbZL2F3KrdPHYK2kk4YXqxtDYx7
	 69eQyoXEv8lwQ==
Date: Fri, 07 Mar 2025 07:46:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_07/12=5D_tools/x86/kcpuid?=
 =?US-ASCII?Q?=3A_Add_rudimentary_CPU_vendor_detection?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z8r5E3wfFyv-n8XK@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de> <20250306205000.227399-8-darwi@linutronix.de> <0ada12f8-4fdb-4dad-90f7-b044993e829c@intel.com> <Z8r5E3wfFyv-n8XK@lx-t490>
Message-ID: <ACEDD5B5-8C43-46ED-9C32-4E1DC2A0948C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 5:48:03 AM PST, "Ahmed S=2E Darwish" <darwi@linutronix=2Ed=
e> wrote:
>On Thu, 06 Mar 2025, Dave Hansen wrote:
>>
>> So, this is cute and all=2E But isn't it a _wee_ bit too clever for its
>> own good?
>>
>
>That was funny, thanks for the laugh :)
>
>> Why not just have a dumb array:
>>
>> 	{ INTEL, "GenuineIntel" },
>> 	{ AMD,   "AuthenticAMD" ],
>> 	=2E=2E=2E
>>
>> Are we really looking to save a few dozen CPU cycles in this thing? It
>> took me at least a minute or two of staring at this thing to figure out
>> what the heck it was doing=2E
>>
>
>Indeed=2E
>
>For some reason I forgot that this is all little-endian and a simple
>strcmp() like what the kernel does at get_cpu_vendor() would suffice=2E
>
>I'll fix it in v2=2E
>
>Thanks!
>Ahmed

memcmp()

