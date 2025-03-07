Return-Path: <linux-kernel+bounces-551403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C7A56C00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5B21767D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9221CC69;
	Fri,  7 Mar 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S1NXgcCz"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3321A44E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361301; cv=none; b=sVXwL82h37Mftpe6ZTP9xZhg96F8rTMjSjGmq4T80IGSBoSdpw9SuPCUtasiPg4WN7GB3OLwO7N9nDREuEq+bmq8iQutyTli+q/9US9lGSpetkwzlmkWGOasMGy4hZPBmVQkNXC/L42WXfxctewjsgGrO1hwrX52KqAHuxnOMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361301; c=relaxed/simple;
	bh=VTkJ5PjXSJUV3gSubC+LLZpcVfawi0v3k/Ncryr8wC8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Dr/bgheVcFSiqQivx6H4Reojo1A6Ig8eLpINQLGWU8g46ebWrhTJUoUi0gXhzePQtOrStXY0cYIUqSf7/WWKNpkBch8omNpy5HlCyQXm8BrFfTT+6AqFkVsVzexxxNMlfDiDiFh1YRK/aBwKVEAYQr5QS7j5HZtdXDGlTDyZlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=S1NXgcCz; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527FRmcc294242
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 07:27:49 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527FRmcc294242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741361269;
	bh=HTBlyqesXmXImHbIql8Zy3TVutjjJP4LUeh+c6F5vuA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S1NXgcCzGgJLF44l2HQejWDmhHfjvjtqtiWou/f0bOCZDAp+pB34wgMfKrttYxxX2
	 qcNM5FjIn3Pw4K3VutNUD/dsicqcVnfGMNnPITGbcUr4bHnBz3al/BTS5p3xNRhJ6d
	 0Cg62F9IG/WkICEghVpkdFFepTY5zWpdKuniHN7+E7irNl/2uIug8l7KNM49Nw4Arr
	 patyoOId5ShZx4Wu/5ExX7UjCkeEc5sVd27Z3Y7yHFzjqOIq1jF6+ELQA02SJE3Qqp
	 lHLp5c9J2BLti7MurY/7ZVaPn2GlF31M0wdXwKopcPqtAlrhLEl93l0qeQQQKUStnG
	 6oS9ec5ElTIeg==
Date: Fri, 07 Mar 2025 07:27:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_10/12=5D_tools/x86/kcpuid=3A?=
 =?US-ASCII?Q?_Update_bitfields_to_x86-cpuid-db_v2=2E0?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z8sLmGf2L4mszUEp@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de> <20250306205000.227399-11-darwi@linutronix.de> <C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com> <Z8sLmGf2L4mszUEp@lx-t490>
Message-ID: <B5E71AD5-3AA3-4B2D-A832-D95F72454E0F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 7:07:04 AM PST, "Ahmed S=2E Darwish" <darwi@linutronix=2Ed=
e> wrote:
>On Thu, 06 Mar 2025, H=2E Peter Anvin wrote:
>>
>> Leaf 3h was not unique to Transmeta=2E
>>
>
>Thanks, I missed that Pentium III can provide leaf 0x3 as well=2E
>
>It seems that leaf 0x3's format differs between Intel and Transmeta=2E  O=
n
>Intel, PSN is at ECX:EDX, while on Transmeta, the PSN is at EAX:EBX, and
>ECX:EDX on non-evaluation models provide the rest=2E [*]
>
>Unfortunately, so far, x86-cpuid-db does not support having a CPUID
>bitfield with different interpretations across vendors=2E
>
>Given that Linux force disables PSN at early boot, I'll just remove that
>leaf from the database =E2=80=94 for now=2E  (Time wise, finishing the ne=
w
>linux/arch/x86/ CPUID data model for mainline submission is a much higher
>priority=2E)
>
>All the best,
>Ahmed
>
>[*] "Processor Recognition", Transmeta Corporation, 2002/05/07=2E

You can simply output the 128 bits as is=2E Some vendors will have zeroes =
in some of the fields, but it doesn't matter=2E

