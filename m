Return-Path: <linux-kernel+bounces-562483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B991A6297A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DEA7AA3F3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC81EDA34;
	Sat, 15 Mar 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3i00fgF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393D8828
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029417; cv=none; b=CSgbxf8y+kpctVYh2zm1hicVVUduw83/9yEAYwPt61NYmpNGVJc4dURRBAnrAskh7NKLqIp1VRumgl++l2MXdnnC+Qn6VqSY8K1qnuCrpyUz/275pdMZ/TuY+5A+kWUMgbQY3M82+1IsQfI3Qw0BlywK8IaYRaou/YNJ5HdjLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029417; c=relaxed/simple;
	bh=8eeFHDG5+exkdrnwU8tHnBtYcTONcJiRUl7Y7TmVLd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYzBahWHlyfxvVNr9IbpxpY80rN15p0t0xbdghgscLf9g6HOsrti5mXiZ+X2ki40/A1uS8VJ7CRjCzLS8DGsFCzvbbwoOTGynR9q+gOvx90goNkJ5Y8s54Jii0jvC/E2873MJJyVtUCYYUzsVMKaSBCjMmJ6rCPHZuGvKjNT+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3i00fgF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c0517142bso25579201fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742029414; x=1742634214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGHR7bTnW3nvanflLwagJdjs7My0Z7nMlfED2l7fwUk=;
        b=i3i00fgFuK/lzxVAQQ2pf8DTLUAETB69pg4T+N+OHOPl+Fd+hh5nXgE1IsZNCklUsk
         pwsAsZbgnvkouXuHOGbVfaGYPK74IY9uZ5WcZ/TRHCjYnmDus6e/p3h5Y1yUm2j1eAGe
         hWhKiPtAMks7siT19/n0yLGs//BVOcnUo8mTrsP+cuIhjEj8xmirJKUCN5NxcUooSzRv
         qERq6qYdjOWSi4W3SRthhOrUgbfhMZAlNsriUB3SoMK/dM43mtRuEU5O67fzfDR1RDPJ
         IjaRllLITRYixGV/eDmABloW08otAb7Hf2+ku57tJJCQY+C3ViFnDeyNmM0C9BLhvNSX
         ArbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029414; x=1742634214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGHR7bTnW3nvanflLwagJdjs7My0Z7nMlfED2l7fwUk=;
        b=nn9Qy/vbGDz9gB2H/g7hVrIa3Cwcc4rmEexNq4oOoRigD9Drp2cVGFv46Y35n8cXoK
         dgqjxRAI3HilakyiDQuZhjkkTjxLv51znxwBUUlMay9I0svvi4W85PUo6n1auBy+J0GR
         dPO9MT94SLGCN7MIv+m6LEC9b8uWCdHnGPcorjEWO8jjcC8gdfpONrS9h1NHvlmL8kmx
         virfitQrhVN0nNlrieO8el9VG2+GTY5GqrxViZ2RVAnwQKV3u6+VXoFkTsQezmlpNmLh
         Wt9Ozijh1BNAleD5YhHhAKbfnT+pHZiiom6fn9Ly6SyIzwUVVBEgix0mQrKHphO+o5yZ
         WCCg==
X-Forwarded-Encrypted: i=1; AJvYcCXnO/rts2hAPZJEU+d99rvYoHO+eiskKbGHWvIdZSZQedAi98wHLBxSdhdfayoRY8ZWghfR/XB+Ej9ri/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/kK/lS1arWzjg3MgyqONeiXLIUG9T33qBdu1bQubUb8f1IdP
	BgGZ1w4EceIKzLoJqxEIeDovuROKioilC7+ld0BFnjshs+2Q2WM85cMOhhJrsxJzZ4G7CohVJmD
	HZPC9qgdjs+Beta1Jhz/Y8zBWtMo=
X-Gm-Gg: ASbGnctS/ecRq/vkuKRXRUYCkRTaF2w4HypCK5a/YUW98bRuK9R1m2qXVcENPGQwkyS
	1SOxqojAAa2TQQYhglw7og39Pbl7NXXe67I2Ak4I8CNZWOCS4L5MRX9gHOtBY5StXsumCptCQgj
	n/S+FKnh+gJDOatJtEZ1tR3N8szA==
X-Google-Smtp-Source: AGHT+IGHQbVa4wxP+O3ej0/Df0xaMpCObqNzTEpdmZM7dLnLwn06taNku6R7x4Jtb/juH8AM+8WtIocd4NjlhRiOlPw=
X-Received: by 2002:a2e:9214:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-30c4a8726camr19595781fa.18.1742029413467; Sat, 15 Mar 2025
 02:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <5f79d7213503c426cf4abc8292ae6d240cacb712.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <5f79d7213503c426cf4abc8292ae6d240cacb712.1741988314.git.jpoimboe@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 10:03:27 +0100
X-Gm-Features: AQ5f1JqJMVHc_c8gCLzoCRvjLvsB78n356UodA4Z7knzb9RFBdQQX0jO-hgFZNQ
Message-ID: <CAFULd4ZJiYyaAJPm0Dg1VeF1q9uw54CCzz2WQ4ufPhJ46PXfkA@mail.gmail.com>
Subject: Re: [PATCH 16/20] x86/cpu: Use alternative_io() in amd_clear_divider()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:42=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> Use the standard alternative_io() interface.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/include/asm/processor.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index b458ff0e4c79..d7f3f03594a2 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -709,8 +709,10 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>   */
>  static __always_inline void amd_clear_divider(void)
>  {
> -       asm volatile(ALTERNATIVE("", "div %[one]\n\t", X86_BUG_DIV0)
> -                    :: "a" (0), "d" (0), [one] "r" (1));
> +       alternative_io("",
> +                      "div %[one]\n\t", X86_BUG_DIV0,

A nit - can the above be in one line? Also no need for a trailing \n\t.

Thanks,
Uros.

