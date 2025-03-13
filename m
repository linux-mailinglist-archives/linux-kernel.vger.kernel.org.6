Return-Path: <linux-kernel+bounces-560292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E09A601E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB965420BED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000131F09B5;
	Thu, 13 Mar 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NrOW4m98"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B51149C64
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896465; cv=none; b=EdI0j24w67xmEERv5EHG4auJFqPb7C16/KCTci3jyX5BXxEPDFcEpBu9hUf+PiGcw7FFYPe3tln4wj7dO5r8aFLCV1fbA1MZmuw1jN2MGkAUdiZRBLNGS2zypsZrq81MQ9XuJL1h3jOtJLP30GFXsNcAMgiGJ+N7WOHdNkc/aVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896465; c=relaxed/simple;
	bh=Y31oLJPepfpjJ9y1KKJV6ybLtoncdZ781tuuwZJkbhY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Aatt9/0yvMZ9/xukGQSj8mOndWXvfBFyLibFwJkBCd9lEw/AJSmRgg7cGVaEiMsbmpmnoJBhaNMus69fIewakMeyrd53BsyggdyyDVdEBkXKxOD/XtTlz9/QKSRKbBXthjTIWuh0YpuMzowqhLUP4wItXqjIhHua6AyF0ybFiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NrOW4m98; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4740640E0232;
	Thu, 13 Mar 2025 20:07:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NUGBoEogCPgi; Thu, 13 Mar 2025 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741896452; bh=RVt9arP7hR72Za+mAzkWReo7aJGhi8QRJIaljG4KNns=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NrOW4m98ifYbYH+aZzGG0aiuYc9EbCKgs3MQeBtF1yygx9v6jrmLAJ72NI/YOocNa
	 V/HGjXHLTJbhVqn+YABDdp1lNLlGNHiIo5BgjjuwzP8VaIFipclM64nNR8nqzk4Ujf
	 KkQyj0lYarUagTSayOoBwgxufg7oRSliOd+RsC+1xs1fIV8f+gPeEOS1WgJ6gxfiIh
	 gmRhqT7EvsAWpX5LfGcLdDtSloqJ0KXWBMxaZEB3Kcfx4BNRT05BDvDTWKebD34Tih
	 Y632PcZj8mOI6E+GFDkip/mfit4wGnKrpBiUhS9eL4kj77ntwq+O36QaxXSTfBUMe9
	 FRz9Hdnob8iSOza/T6fR+bfyW95kKpJSqqZd61VXpMnQyXlnhTgriPXG6vNh/3AvcK
	 HBH+5rmf/cpimM2uoXqFlLGOC2mIeKeA0VXth7/WRJ6bMkQYkpvUWAAFilAoJbUV0q
	 Sac0FZBckiYS7radF9pGKdiAJDQthYFcoZYJ6zviyQkniiLqJE8g2eMyuzASD4r4fQ
	 egALYvDlEo0tupYuwcw3HNZNc2KO9ooNmafJXlTZ0cYcNkI6EtzjPe9m30roi0h3MN
	 OFtAcyK3m4vQOydijEujkRTDV/pgLPH5KuIRh38Hmd43OkGEkSO8yvos5eZYhHc7k4
	 oeeMQMASj2EZbxMLsL0MLk3E=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:266:6540:81ab:a9fd:fb89:8f56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20E0840E0219;
	Thu, 13 Mar 2025 20:07:25 +0000 (UTC)
Date: Thu, 13 Mar 2025 21:07:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/asm=3A_Use_asm=5Finline=28=29_?=
 =?US-ASCII?Q?instead_of_asm=28=29_in_amd=5Fclear=5Fdivider=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
References: <20250313191828.83855-1-ubizjak@gmail.com> <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de> <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
Message-ID: <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 13, 2025 8:50:24 PM GMT+01:00, Uros Bizjak <ubizjak@gmail=2Ecom> w=
rote:
>On Thu, Mar 13, 2025 at 8:26=E2=80=AFPM Borislav Petkov <bp@alien8=2Ede> =
wrote:
>>
>> On March 13, 2025 8:18:09 PM GMT+01:00, Uros Bizjak <ubizjak@gmail=2Eco=
m> wrote:
>> >Use asm_inline() to instruct the compiler that the size of asm()
>> >is the minimum size of one instruction, ignoring how many instructions
>> >the compiler thinks it is=2E ALTERNATIVE macro that expands to several
>> >pseudo directives causes instruction length estimate to count
>> >more than 20 instructions=2E
>> >
>> >bloat-o-meter reports no code size changes=2E
>> >
>> >Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> >Cc: Ingo Molnar <mingo@kernel=2Eorg>
>> >Cc: Borislav Petkov <bp@alien8=2Ede>
>> >Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> >Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> >---
>> > arch/x86/include/asm/processor=2Eh | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm=
/processor=2Eh
>> >index 5d2f7e5aff26=2E=2E06e499ba4fe8 100644
>> >--- a/arch/x86/include/asm/processor=2Eh
>> >+++ b/arch/x86/include/asm/processor=2Eh
>> >@@ -707,7 +707,7 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>> >  */
>> > static __always_inline void amd_clear_divider(void)
>> > {
>> >-      asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
>> >+      asm_inline volatile(ALTERNATIVE("", "div %2", X86_BUG_DIV0)
>> >                    :: "a" (0), "d" (0), "r" (1));
>> > }
>> >
>>
>> So there's no point for this one=2E=2E=2E
>
>Not at its current usage sites, but considering that
>amd_clear_divider() and two levels of small functions that include it
>( amd_clear_divider(), arch_exit_to_user_mode() and
>exit_to_user_mode() ) all need to be decorated with __always_inline
>indicates that the issue is not that benign=2E
>
>It also triggers my search scripts, so I thought I should convert this
>one as well and put the issue at rest=2E
>
>Uros=2E

Sorry but this doesn't justify this churn=2E There's nothing quantifyingly=
 palpable here to warrant this=2E
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

