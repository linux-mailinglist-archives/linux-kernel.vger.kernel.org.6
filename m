Return-Path: <linux-kernel+bounces-256044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39864934826
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0051C217C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8515A55E58;
	Thu, 18 Jul 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lw7oDvgJ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2EA38DE1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284583; cv=none; b=rOipuOG0edI4aRCWbVRBPKZnHsy508PiAJ++ZPHb/tUsxsoj7sOyJw9rUdyVbVoiyqkxIMk86+g+M4nFnvEHUF/cBK3qRHUH5zoX02RFoyN2WhqjZWRM8On+cBX/5f90v2M8Js3NFNxIYpI4hAbLZhS+K7xzpPVFj+DdnSL2ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284583; c=relaxed/simple;
	bh=kKu8M4Ys25JGjAI9AWyCPhJrMrl3Ra0FEMmgZaSnnZQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qKF57K+suufVudZroL3X9Lsig/V5hmKJJjcw00UVJYsfY0hKj+JAVgbQdGkrZ6MDLQ4K8jlUgnouHBrCzAVhwku0P+zJjKzVT4j2XO61N4v+OiJhF/F/+3/TAjI1Ywfb9PnmJ28mhDSPVhB4tUc2Sj1333+0vPJJ+2+b8VhZ3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lw7oDvgJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46I6a0vI3098584
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Jul 2024 23:36:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46I6a0vI3098584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1721284561;
	bh=olo1J9Ekj3oE7AMNzS+YKv+bJI1P8bkfXQDak1NfIMM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lw7oDvgJHZzls5gqBdVbWtrmt1nTugB6QIOco/6UbR1XkbX8IcNdOi0GHHqVzUU+4
	 KYvzD4h41Best6tZr40wbkhNr43tMB3xAGCNC5giu6Do3dd0jmiNCN/8vSyXRBzoul
	 xjDQtTldbf9JYSbSycv1Kxry8PQpW/AoT1xT+UeBrARso9HOdRR2URmzUBTOq8Tfsg
	 ndIqev1Ioyaa7owV/VBFM0b568hBVB7zcbsQ9GNnzQh91I4Jb1Cv5hQscHg/X/RiLA
	 GPN5dbjH6R7EqzsFBFX6mBmTPWDz4i24pQfhcde8YszY6RhtCQPOss5vZolXaUEeYX
	 JaI7jQQB6lG8Q==
Date: Wed, 17 Jul 2024 23:35:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Use_=5F=5FASM=5FSIZE?=
 =?US-ASCII?Q?=28=29_to_reduce_ifdeffery_in_cpuflags=2Ec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240718063242.52275-1-ubizjak@gmail.com>
References: <20240718063242.52275-1-ubizjak@gmail.com>
Message-ID: <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 17, 2024 11:32:18 PM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
> arch/x86/boot/cpuflags=2Ec | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>
>diff --git a/arch/x86/boot/cpuflags=2Ec b/arch/x86/boot/cpuflags=2Ec
>index d75237ba7ce9=2E=2Eaacabe431fd5 100644
>--- a/arch/x86/boot/cpuflags=2Ec
>+++ b/arch/x86/boot/cpuflags=2Ec
>@@ -2,6 +2,7 @@
> #include <linux/types=2Eh>
> #include "bitops=2Eh"
>=20
>+#include <asm/asm=2Eh>
> #include <asm/processor-flags=2Eh>
> #include <asm/required-features=2Eh>
> #include <asm/msr-index=2Eh>
>@@ -36,13 +37,8 @@ static int has_fpu(void)
>  * compressed/ directory where it may be 64-bit code, and thus needs
>  * to be 'pushfq' or 'popfq' in that case=2E
>  */
>-#ifdef __x86_64__
>-#define PUSHF "pushfq"
>-#define POPF "popfq"
>-#else
>-#define PUSHF "pushfl"
>-#define POPF "popfl"
>-#endif
>+#define PUSHF __ASM_SIZE(pushf)
>+#define POPF __ASM_SIZE(popf)
>=20
> int has_eflag(unsigned long mask)
> {

Just use pushf/popf=2E gas hasn't needed that suffix for a long time as fa=
r as I know=2E

