Return-Path: <linux-kernel+bounces-256059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF19934875
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BFC1F2207C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8742573451;
	Thu, 18 Jul 2024 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QRxp75lm"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489391BDD0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285957; cv=none; b=ok6Pps8uYnKiuAULX3h7sKkkzJnlY3n5YaYY1oEEY/mPqS3ufnGK3bgNbotd82rQXAWTgjIkHxvwRZNlklImOse8YmAVr02aUHWAFGxjUZheTANa6E+AV1GLp4xFZAY2q/BOjV/dCn3zQBFm+RwmaQbe6tjS3KQVoFGfZ1H5858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285957; c=relaxed/simple;
	bh=Wh53cFEZ+Mhydzp7CWKQE1TeLxIrPCdjgs3DVVSzCMw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b/kV3i68z07MTFi4eoMDKcBTqlhnD/jLmu2yb4BVr8t5ssXPhZWk5McHaDvTFRmohZoyZXS3HD/d0iJBDYQ4ikrslpQedmMESEyGB/oYl3yntxsuAcH+LVTF4+7rBW8HZ8ZM4bj3l+v9PywPqI4kJtVADjf8UBeGoKRnvjbk3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QRxp75lm; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46I6wsBV3104449
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Jul 2024 23:58:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46I6wsBV3104449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1721285935;
	bh=mDNWpItDbrgPUJPwjFTTmXKB2iVYvDSdMpM/hXKLysE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QRxp75lmKYox+KNQyb8qwkVYcV3t1bnCjQAIWBxWNYA13etiyUKCT2sXJCjQRfKiJ
	 mIN57BZUcieGRbm4eh0jgHeB7N+T4dv6KsX053opp8ide09W3ufzdy4FNkVj2/OEOi
	 4uhb3yQHHbpOHf3CvSqSAslVRdHdBohJFBKl/OtbmYpJVdKCoBbzxKSNUa4Iaj76GJ
	 05jqN56+yWctntQ1hPeHRcnMczvqmnzCS2dYXOTNMgHfh+8fWn60AFPXOCNXkb+K97
	 6NrrhO9vRFTIwTaVFUnL6rWHbL2WUq/JXr8vMPcCsleXJ3sDcDN/WQDNbhni2qob5B
	 7ei9C7z8o3e9g==
Date: Wed, 17 Jul 2024 23:58:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Use_=5F=5FASM=5FSIZE?=
 =?US-ASCII?Q?=28=29_to_reduce_ifdeffery_in_cpuflags=2Ec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4bVO39emR49thto4w6LZX0vS9eJKE75u26aCFk7CRVrVw@mail.gmail.com>
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com> <CAFULd4bVO39emR49thto4w6LZX0vS9eJKE75u26aCFk7CRVrVw@mail.gmail.com>
Message-ID: <3E2205B3-C2D9-4D4C-9847-1CF0BFF68D72@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 17, 2024 11:46:57 PM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Thu, Jul 18, 2024 at 8:36=E2=80=AFAM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On July 17, 2024 11:32:18 PM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wro=
te:
>> >Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf=2E
>> >
>> >Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> >Cc: Ingo Molnar <mingo@kernel=2Eorg>
>> >Cc: Borislav Petkov <bp@alien8=2Ede>
>> >Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> >Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> >---
>> > arch/x86/boot/cpuflags=2Ec | 10 +++-------
>> > 1 file changed, 3 insertions(+), 7 deletions(-)
>> >
>> >diff --git a/arch/x86/boot/cpuflags=2Ec b/arch/x86/boot/cpuflags=2Ec
>> >index d75237ba7ce9=2E=2Eaacabe431fd5 100644
>> >--- a/arch/x86/boot/cpuflags=2Ec
>> >+++ b/arch/x86/boot/cpuflags=2Ec
>> >@@ -2,6 +2,7 @@
>> > #include <linux/types=2Eh>
>> > #include "bitops=2Eh"
>> >
>> >+#include <asm/asm=2Eh>
>> > #include <asm/processor-flags=2Eh>
>> > #include <asm/required-features=2Eh>
>> > #include <asm/msr-index=2Eh>
>> >@@ -36,13 +37,8 @@ static int has_fpu(void)
>> >  * compressed/ directory where it may be 64-bit code, and thus needs
>> >  * to be 'pushfq' or 'popfq' in that case=2E
>> >  */
>> >-#ifdef __x86_64__
>> >-#define PUSHF "pushfq"
>> >-#define POPF "popfq"
>> >-#else
>> >-#define PUSHF "pushfl"
>> >-#define POPF "popfl"
>> >-#endif
>> >+#define PUSHF __ASM_SIZE(pushf)
>> >+#define POPF __ASM_SIZE(popf)
>> >
>> > int has_eflag(unsigned long mask)
>> > {
>>
>> Just use pushf/popf=2E gas hasn't needed that suffix for a long time as=
 far as I know=2E
>
>Yes, this works, too=2E So I guess we can also remove the comment
>explaining the reason for explicit suffixes?
>
>Thanks,
>Uros=2E
>

Yeah=2E You may want to check the version of binutils that fixed it and pu=
t that in the comments=2E

