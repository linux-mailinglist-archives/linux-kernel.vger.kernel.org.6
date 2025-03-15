Return-Path: <linux-kernel+bounces-562733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7041A63208
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 20:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5033B0215
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FF19AD70;
	Sat, 15 Mar 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="J7Ca6JSo"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078B192D9A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742065743; cv=none; b=dyzNEeNOjg50GxzufOS6nph6xRKuH3YK1PAzuiU6xvrSH0YIls1t9JZndvxzQ9oJtDYcQhE1W/pW72jPlBcwQ6Mo8bF/zqd9SCIJkDww3iOAtwJe9Oo2PcrNpgD2bGMf/TFyrpSJAN6YtGRTIKRGK+fiyzLKKziivv9QszHcMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742065743; c=relaxed/simple;
	bh=57IlnoCoyLChABV6cG0m5KbTyy1ckfvW8clNzV0da70=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kn6KUbunCJt+b3cAuRVjTL7+UXVEiJejKwQad3FdDqNiAy0qRR5oBtDFXQG0KOL+PRg3QoQjVbpDkV/MkX+EorsrDekXzfl/RqYVQaQkK0SS51Wa8yBbQUTWhV/XzMDLH1ZzTqipElwVUB+G3dm9yBGN6FlA+kgfvKNxoy8ivXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=J7Ca6JSo; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52FJ83b83955090
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 15 Mar 2025 12:08:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52FJ83b83955090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742065684;
	bh=vDFAjiFlM+4DBIJ/4z6nRlQwnDaAdTjiJHI2yVg+WRU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=J7Ca6JSoFztlouWk0xqap5ZmegDJGlsFhZJEs5pvLBMcvAsVzfLwa5H67HACcOvwF
	 N21lD66gwEs81b7Fw98TEB+jqG1TA0t07D3innrue00A80VaTfzhJi9gzuSF3OUmnc
	 kDdkQ1DvO5MLrwDkJiR3gjFmO0z0+8FqmZCXmY0sUCnHQfaqGJiiiJQ9vLdYDLwdyu
	 RroQ05wIXcPo26q3/FBIbYlIokxUsOIzASY07sHmFbDTMm4Z7oBfUE1NmPVY0VOl5j
	 0ttghkrqIl8hTgyHt4k3KCBTkDsWXc59oJ1ETFHzKi9vsFNUy8p6U9BbDDizkzl8sd
	 yi1C+CpgllgMQ==
Date: Sat, 15 Mar 2025 12:08:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250314081453.565859-1-ubizjak@gmail.com>
References: <20250314081453.565859-1-ubizjak@gmail.com>
Message-ID: <B0BAC00B-2FF4-40C4-9034-68EAB51341B1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 14, 2025 1:14:38 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>Use higher-level API to declare assembly with alternatives=2E
>
>bloat-o-meter reports no code size changes=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
> arch/x86/include/asm/processor=2Eh | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/pr=
ocessor=2Eh
>index 5d2f7e5aff26=2E=2Eb4b5aa46f68b 100644
>--- a/arch/x86/include/asm/processor=2Eh
>+++ b/arch/x86/include/asm/processor=2Eh
>@@ -707,8 +707,9 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>  */
> static __always_inline void amd_clear_divider(void)
> {
>-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
>-		     :: "a" (0), "d" (0), "r" (1));
>+	alternative_input("", "div %[den]",
>+			  X86_BUG_DIV0,
>+			  "a" (0), "d" (0), [den] "r" (1));
> }
>=20
> extern void amd_check_microcode(void);

I realize I'm probably in the minority, but I find these "higher-level API=
s" for alternatives much harder to read and understand=2E

