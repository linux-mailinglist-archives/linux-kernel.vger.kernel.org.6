Return-Path: <linux-kernel+bounces-560281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CCA60197
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760A5421CED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A31F3D3E;
	Thu, 13 Mar 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnviFxIo"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E941DDC3B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895439; cv=none; b=gmMiEsfkIV9bNNcAFohJBj5ALqWXhTq/DmDlsb0YBmhy4MyeWrd7Y0xcL5K19agmhs17I+y15iyXQTl7HNQY4A/PTmTloHkc3ctNlGM6F/cGyA2AjRB5Z1Uq9ZuiMvtEW/XlNWKxRcddE2X8h2FYyBiRGEGMB6wGxnf1G+0oYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895439; c=relaxed/simple;
	bh=Ts3jP2ArueQlgldeR09Pb3+hNmIbgrEP/89WpBtfDns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkrcMeuof/Z5VRkfLWv9obaS6qYea8e217F93wPxGsp7jS715TE+b6+uzJYIyIVqi/pvUt91DV3VvgVBKuBSl5mI2v1JGtmadEIS+bBrZlpb7BmRXCh3Qp6IWE6BjaGTkTkKwecBpMw9W7eIC/rEo8F5NPGGUeo4LlLzmHVF9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnviFxIo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bee1cb370so14468901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895436; x=1742500236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ly8ES0URP3TPz3x62rhvM0L5MQNB2ADkDO/Kyyc8PoA=;
        b=jnviFxIoIBISLgfXtLQPClntc/xEdeHI/vLlnUM0YHsXhU5qr5syXIiwsMfrEd55jL
         S2BNqxbh2F+DRQfdoRSQEvJNQijYCq1AoJb6EZNrlGKAW2BDgIkDqwlZ5z9lqfhJhLwI
         /Q9QOtpYe3I/V3W/CvMhX3S7obItLiUGtSYeE83NxxMeg7aCrHU5I++2kXevhVrasBLM
         YOUgHNJjFO23xEpA+bJ+1ysyZvuShQhkKzWG+tDA+whESx44Gi2qXK0PgL+eF3eqALz9
         Z4DXkm/rDsXL8yxpMYgz+99NrQdo6ZsBmZcQj4DD7gh2gQDk6/TK+jrqUFEPV5BNqvJ6
         RcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895436; x=1742500236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ly8ES0URP3TPz3x62rhvM0L5MQNB2ADkDO/Kyyc8PoA=;
        b=mJAMT7yUOWrEHSso00qy4+CuKNyMBD58Zvy1ejky0ePYmJ7NXwnJA9y6OtTnh0J55K
         MjLj9+K4v2oigEv5kG+tfwzJQJrE6+fLF2O6N/aKxCutpYonhtzT6cNOEXFDn6aPXjgA
         xDgajVrUCHDdJZByQOUJ5OodAF67p9+Ewtv9GlnXIAWD5bIygqf0+HJd1Sg33OTZMxBF
         wYgGeNyTWnyxC6SlcOFwtbwRkF868bvfn863ulOWDPJoPgbeWmWunfHwV9695xwS2l+l
         zZfotFIcMyNRF/VpdD8j/MOHcyU/DqLKzNlu1d2mx0QLRwE3YPQYFBEvg2Am1ubYdu9h
         7lDA==
X-Forwarded-Encrypted: i=1; AJvYcCW+muxx3jn5E9H06ZZp8nO339HEk3JUD6HmjVWwTWYoiSi76yaIqmyV/IRolxgs8V6llcg1E/YqUj91TKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxo1Xl7wxsnAIZ1TV7nkI2TNL8mWnpiV6Gu8B6MaaSy8UwQsDq
	bnbvllCwBDrSz/n3A1TfeNtr8cLlhC8TeZFRnamQkC4dtoHYELbHurxNUTVeXn+vunrYuQ9osJU
	46rZ5vMhktRxiUoMQlHt16GR52hc=
X-Gm-Gg: ASbGnctVOm77saVdvQk13sjusPpL/lwc7R9L7lb67psz12szG92jU/M4DdJKQtEzlnx
	v5A4JFQE89D7T/UmQqJmjcLhifdbEk+wWjjae5mmFomnx+ATS9XwPJGIB78Epksw/kI0fO13NPU
	rZfNukAB4ukxIFHk4usg1xjW54Mg==
X-Google-Smtp-Source: AGHT+IHrJLILcK30rlMOs+0dzGBtusj7nZ+d0y33vH2xkFFpUcUdt1ayPvwnuhWE9Xh2j4CWi9VMwHDL4v2EkwBT5yk=
X-Received: by 2002:a2e:b544:0:b0:30b:be53:bdd4 with SMTP id
 38308e7fff4ca-30c46b57330mr3785971fa.20.1741895435929; Thu, 13 Mar 2025
 12:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313191828.83855-1-ubizjak@gmail.com> <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
In-Reply-To: <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 13 Mar 2025 20:50:24 +0100
X-Gm-Features: AQ5f1JqdKZhakWoSaLE_Y9BqKQ8iRQWHNvfC1epGbfqWUTwDTHTidxjd851RBlE
Message-ID: <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in amd_clear_divider()
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 8:26=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On March 13, 2025 8:18:09 PM GMT+01:00, Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >Use asm_inline() to instruct the compiler that the size of asm()
> >is the minimum size of one instruction, ignoring how many instructions
> >the compiler thinks it is. ALTERNATIVE macro that expands to several
> >pseudo directives causes instruction length estimate to count
> >more than 20 instructions.
> >
> >bloat-o-meter reports no code size changes.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@kernel.org>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >---
> > arch/x86/include/asm/processor.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pro=
cessor.h
> >index 5d2f7e5aff26..06e499ba4fe8 100644
> >--- a/arch/x86/include/asm/processor.h
> >+++ b/arch/x86/include/asm/processor.h
> >@@ -707,7 +707,7 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
> >  */
> > static __always_inline void amd_clear_divider(void)
> > {
> >-      asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
> >+      asm_inline volatile(ALTERNATIVE("", "div %2", X86_BUG_DIV0)
> >                    :: "a" (0), "d" (0), "r" (1));
> > }
> >
>
> So there's no point for this one...

Not at its current usage sites, but considering that
amd_clear_divider() and two levels of small functions that include it
( amd_clear_divider(), arch_exit_to_user_mode() and
exit_to_user_mode() ) all need to be decorated with __always_inline
indicates that the issue is not that benign.

It also triggers my search scripts, so I thought I should convert this
one as well and put the issue at rest.

Uros.

