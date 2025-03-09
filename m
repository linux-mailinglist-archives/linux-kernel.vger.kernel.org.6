Return-Path: <linux-kernel+bounces-553049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487ABA582DD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD373ACA4C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB11B3957;
	Sun,  9 Mar 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5d8GoY9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEC1B3922
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514255; cv=none; b=cXD/S4LEfPq1vB7rAOnj3xAsdLrogMthhF07BMCgCDI5Bm8jv5l+/675gF0jwO2G7/VN183YaRp5xw3BFVwt/2UQh5MZ+rhRgDFXWvV2etlE7vSvET1+g/llOF8FmbEvmXAxl/zAlEICJmzzjdldkHS4KD6XaidzmbiA9V2KFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514255; c=relaxed/simple;
	bh=vEBmhpd0DuxHrvuafKk+qU5O1OZoIjryryuVpwvwb7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mvsw7YX2kLfyfmiBeWs/QGQOfhNNLjIcQ2k1Vua894KmuGt6nt43rvg6ySswKxEwnRs2bPBQ1ibNDitGNhDRcwH04/Ed7Z+QKVMF1Y2YPdUArxzcJe15xjohx06CnHtF0uE7PVKyqCVYElMng8ssYYBfm2rO8s5umSowo7AYOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5d8GoY9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so21247861fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741514252; x=1742119052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEBmhpd0DuxHrvuafKk+qU5O1OZoIjryryuVpwvwb7I=;
        b=Y5d8GoY9ASvWvG+/mo0dLl03trZ87z8axI2ehaK31fN6xViQXYp3EjWJgaUYe6dx3F
         gpcUHquU0ZXwXt5gkoje+koiCpRDQ/4XrTSJr2GLAFt+b2ZBkBS4xH0UagAxJkBqnsMv
         eViZVQXGIPTabPerduLY8hS4k0KuBD6st7WnJcv5DcWg7VIQz1dXJ8ibbA43lDLpaO8d
         On2UX40YQ49eTQm8/TdCsEjsmidMboOPwEKxmTShVhd4SxqXK9Czo6XCP3iRd07Ql7M+
         wEySj5fnfc8lOLO2QV4rkQF1TISX7pKx1g8rZrL3hT/1ellLC+ysnpgmxKSvM0YVs9TG
         OJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741514252; x=1742119052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEBmhpd0DuxHrvuafKk+qU5O1OZoIjryryuVpwvwb7I=;
        b=mZqb4xQTRK54yN+OmtnjwXjdLScf3QX+Z6Wg45imed5ejBJjFQIVeFwH3Fz59zGDXS
         ng1ALnq40ypsmwSP6ThTbLJCOijZSwZR4xgnultdgrwdDxENJDxtsXrplwypYWWqjDGR
         ClJQ0tLI8NwjdxSxEDZvizw1j41Iw2mImQ3NS6k8JkbRrcm0Z4uczrs2b9WnT9ZFPhjJ
         YznbRjEaqZNMSIgme+FJT/8egQzpJmsk21oV7fN7qrcH5C39pE+RJNGVFA0zds8Vl9Ba
         DmEXuoFEZxayj4UM6Bg0KGq4SWMgIxVNesCoCnryoPLcfb1T9GF3Kn5VwHVHkAR6Elbh
         KnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTVXM6/ivjHsb3xlDC4XJQHaQoX+4ec8VNrJK3XcFY0FUz2u8fTaaSBy20X6JfySWHOM74M/gsCsQjLgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEbfY5zOfQEXw1uh3u7xPaCPTi74WO2m9w6/YPylgv8+Swso2
	EIQWRQhE1I62Vlv9i5LVS+YXYK+/gjhsjiqGp3gF3canSCJ85JatLQuM6Tn/v4L3cZXEpZEWFz+
	llQFY5xaUPNKqU1aSXI/ueFewhBo=
X-Gm-Gg: ASbGncvZ9kNg9fS75uvUPNsnCZbOS3I1mXUXa2CKViKie0zNoo4xpSi0sVrtGgFasuH
	T1ltcYm8Uet/kXyIU8FQw8k8bL5YnEpYgCa3k1PPj9A/1wShBK8e4pCba1uNvl1ZIDPd4tKaAkG
	BSQ4XDS4VJ/H2m7KjzwyQO5tjRnQ==
X-Google-Smtp-Source: AGHT+IFlSjlqbP5a/MMYQDbhi1k5WqBr8vhXIzQju8i5ukelCWeiOa/0RsngZgpJPftPd6QNHxz0CkNqiZTVsLu/BFY=
X-Received: by 2002:a2e:2c0c:0:b0:302:1cdd:73c6 with SMTP id
 38308e7fff4ca-30bf453bb4amr29092671fa.20.1741514251329; Sun, 09 Mar 2025
 01:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <954c7084-3d6f-47b8-b6cc-08a912eda74c@zytor.com> <CAFULd4Z0FugNh7+6c5Di_o6zKTNOmkNytEpn0kfPhinFQEOSzA@mail.gmail.com>
 <20250309094613.50e930de@pumpkin>
In-Reply-To: <20250309094613.50e930de@pumpkin>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 9 Mar 2025 10:57:19 +0100
X-Gm-Features: AQ5f1JpqcBwXu2sIPHF9O0bKjyWOrf8zRGhDtd7jI2v30wEOw6HH1e7vscN6RYc
Message-ID: <CAFULd4Z9_5oUA2aNUd5+4MM=N2Tphj4NDuYDrtwE6sXRKy-tXw@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: David Laight <david.laight.linux@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 10:46=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 9 Mar 2025 08:50:08 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Sat, Mar 8, 2025 at 8:08=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> w=
rote:
> ...
> > > In fact, I would wonder if we shouldn't simply do:
> > >
> > > #define asm __asm__ __inline__
> > > #define asm_noinline __asm__
> > >
> > > ... in other words, to make asm inline an opt-out instead of an opt-i=
n.
>
> The asm statements themselves get inlined (typically they are in an
> always_inline wrapper), the size affects whether the calling code is inli=
ned.
> You are now in the 'games' of I$ fetches, overall code size and TLB looku=
ps
> (not helped by the speculative execution mitigations for 'ret').
>
> > > It is comparatively unusual that we do complex things in inline assem=
bly
> > > that we would want gcc to treat as something that should be avoided.
> >
> > I don't think we need such radical changes. There are only a few
> > groups of instructions, nicely hidden behind macros, that need asm
> > noinline. Alternatives (gcc counted them as 20 - 23 instructions) are
> > already using asm inline (please see
> > arch/x86/include/asm/alternative.h) in their high-level macros, and my
> > proposed patch converts all asm using LOCK_PREFIX by amending macros
> > in 7 header files.
>
> The other ones that are likely to get mis-sized are the ones that change
> the section to add annotations.
> The size overestimate may be better in order to reduce the number of
> annotations?

Yes, this is why I think it is better to use asm inline on a per-case
basis. While ALTERNATIVE and LOCK_HERE instructions result in one insn
(and can be trivially amended with asm inline to instruct the compiler
about this fact), this may not always be the case.

Uros.

