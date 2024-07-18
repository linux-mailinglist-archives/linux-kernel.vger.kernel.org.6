Return-Path: <linux-kernel+bounces-256052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FF1934845
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33759B22047
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F5548F7;
	Thu, 18 Jul 2024 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0xB9Y1j"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6221B86F4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285232; cv=none; b=irl8mZgK99cp7gu4zEc7eSn2TFS3OY96cR81hHXA7b4R39EUfzkqql3G94Hh19jX4nMkM1ST6+jYaTXaKlKSAb5USxWibU1Vq2NHHZtY/bPwqIv1S2MQ9RHqkX5+9eNljGMY+nV3g6P+GcKNkNgtiJwQBOfUvfd6EobVgl/dnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285232; c=relaxed/simple;
	bh=UlbtBemEK6GvKquWkv5ZyY/3GRVdzO8WO0mw+648oX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1xJoGCcGvnozq0PteuQCbZOzI8edQVVurt8I1rczMtFKR0KFNXPdbEIZnE8V35VE0H3Us/Oon0oX4WghyZZ5B/60+51UYwmyKwLYGyI7FoM33+llcPGI1WD6GB5iPPhr9z9fbhd/cxNUwcm87h0dO4xpndyl7aX5GZFPnVWvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0xB9Y1j; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so5108901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721285229; x=1721890029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Koq1oUeB0gtIrGDkTnuFVZsRFiG+jnXF5/RVRatsvuI=;
        b=L0xB9Y1jCF5Mo8YZt3m51x/LFMTRLGA9f+kDk8wcOGgaoOB/LxO9knWl31v7Ues/c6
         swwxU9HWrQf9eIuEl4rBWDlCTLyq0mfgZ8jaPkIwDEEp+1LKXcRz0rGri46Y9eLH//my
         pxC0W+sguHxYcALQgmfQmhaQRKEbIX/0K6fw8JbruR2zgrcTTphXS+AW5z+R+TlufX3g
         2tdDA+8pZC10fE0M0V7WRTcU7dVT7LPsDM3EcAo8KOT0jS01j7XxCzmjYvNWmbFoPt/c
         4RSdy9/kV3R5cDI8ieFodEFQs0i9DTQm78+WufIEUNzCsBa4zjlkLMBYew2RG74Di+/i
         DNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721285229; x=1721890029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Koq1oUeB0gtIrGDkTnuFVZsRFiG+jnXF5/RVRatsvuI=;
        b=qKqUsyDZKHjpD/LI7u5yt0QViv5n8+ulYis9ZNb61As96hqBI52Rkacl2bDbaSLxIH
         NKQpekKRZgg5KN+PaPAXjygpunUYKD+Hr4Q5M/dOthZPkEvl7/MbolrfliPcANN12qWS
         1WUzMjg0KiJUPJZfglKuTvuLdBBLP1pq/qpZL8SFW23kTZtAQsXH+6fIG1PsWDmGXgqg
         tYE0AAKXHxkbQMHq0xRMCqEDB28moPg1IY5PBgAH78QqPMQks5pZ364BxKqYdjlowhMu
         YW/WhJh2hpIpuBX0fLYM16zoYI7OxHuxUaJpC0zg6pdZwQg3W0AV3gLmAWRL+99+jRE7
         9Z6A==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZsIOnhPJ26+aLFn57wtgdrr1uMOPb9hrjR8aDwXOUR3krvP9TvbYQh+AMNtnmv4fUVGU8WBTH0FTNTgsrO/XdXOKJ7W0ruhWh017
X-Gm-Message-State: AOJu0YwZyJaHJQ0MeCn33qTAGSS35CmcI6T2WLtE74hjPq/JBSLsg5uC
	GJwRG3Ew0ZrA3PWDpepHbTN8JEwDzZj59z3tfNXkxF79pGgLvw5eNTkeTxohQACg+izXN6M4j4x
	TxnEtO1sDUanBtb17HoMpjDbFd0c=
X-Google-Smtp-Source: AGHT+IFydJquVFZOWqizYF+4etpQ4v+1fsLmR2yG9CbYmHQpcnJHPh4z2Uew/E7MDrm6pmmI+IdMYdnMcF19k4G3qNc=
X-Received: by 2002:a2e:a164:0:b0:2ee:868e:e281 with SMTP id
 38308e7fff4ca-2ef05c73786mr10895851fa.14.1721285228787; Wed, 17 Jul 2024
 23:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
In-Reply-To: <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 18 Jul 2024 08:46:57 +0200
Message-ID: <CAFULd4bVO39emR49thto4w6LZX0vS9eJKE75u26aCFk7CRVrVw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Use __ASM_SIZE() to reduce ifdeffery in cpuflags.c
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:36=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On July 17, 2024 11:32:18 PM PDT, Uros Bizjak <ubizjak@gmail.com> wrote:
> >Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@kernel.org>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >---
> > arch/x86/boot/cpuflags.c | 10 +++-------
> > 1 file changed, 3 insertions(+), 7 deletions(-)
> >
> >diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> >index d75237ba7ce9..aacabe431fd5 100644
> >--- a/arch/x86/boot/cpuflags.c
> >+++ b/arch/x86/boot/cpuflags.c
> >@@ -2,6 +2,7 @@
> > #include <linux/types.h>
> > #include "bitops.h"
> >
> >+#include <asm/asm.h>
> > #include <asm/processor-flags.h>
> > #include <asm/required-features.h>
> > #include <asm/msr-index.h>
> >@@ -36,13 +37,8 @@ static int has_fpu(void)
> >  * compressed/ directory where it may be 64-bit code, and thus needs
> >  * to be 'pushfq' or 'popfq' in that case.
> >  */
> >-#ifdef __x86_64__
> >-#define PUSHF "pushfq"
> >-#define POPF "popfq"
> >-#else
> >-#define PUSHF "pushfl"
> >-#define POPF "popfl"
> >-#endif
> >+#define PUSHF __ASM_SIZE(pushf)
> >+#define POPF __ASM_SIZE(popf)
> >
> > int has_eflag(unsigned long mask)
> > {
>
> Just use pushf/popf. gas hasn't needed that suffix for a long time as far=
 as I know.

Yes, this works, too. So I guess we can also remove the comment
explaining the reason for explicit suffixes?

Thanks,
Uros.

