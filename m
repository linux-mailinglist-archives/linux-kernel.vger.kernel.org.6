Return-Path: <linux-kernel+bounces-562527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B154A62A9A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBC9170F77
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074441EDA1E;
	Sat, 15 Mar 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgUeAakc"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55041DFED
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032833; cv=none; b=dY/rj7bI8YrBTIs06LbrmxmiDLqgKe6mHzeBu1ibW48cneHEN+PlE41WGaEFZi/FTGIALIO6ebHzZvOZmSlGB6pAwrLtBsX7lX8Eo2WsvBpKuECM8EcYyrOSXc33CCke//L6XANj2xXMJiMNMFjfrcphq1q+Ggvp/ot72S4ak+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032833; c=relaxed/simple;
	bh=qlXezZfEPEzxR3zAYUit6h5DQQaBFi+GSdRF226QNLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXSDfHjJGSe2xZRMVQIMBtrVLd2sOu4FIkjORrqneIsu3Sn3m3n3SD3Gm3mP3obiBcRvCJrS6XleYFDkLMR2tL2Dz8nQcXGc5l1OM5QZaG8pdbaZQ6zZc4G+X72nHuqzP3dd5tguPS9KnPyfrdEtaOfBOBiN7+9rN7ajxQENG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgUeAakc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso28359131fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742032830; x=1742637630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SKOb4s7UJ+CRqLv0uuos0ZHyY2OXZUFISjmyYeG7aM=;
        b=bgUeAakcEIch2avu7fV60KCpj85wyxs7cTHlbo33T4bNOJUbOYYx9lyHL6p6PyA5ko
         HkBTVdLaFF7R/jzxNW/ZQdqizZ9UdsJ3vEzFpkXIFax2pD4H7xx9nB/1abEvuxXox3ko
         N0GO9Ho7wAh4lYOo4rHRJ4oIv8RljBqLWu2EVIU+Wn9LmaXC/vPXANLQbhH5bM81sjmR
         fsuMPq53nf2M1jA5gUfS2B5XMtWHKRinRxvpRv8a4vnoCOGB9QglQya0elsBSsFyK7K7
         pvseVQsMLmohKTY7cx86uONvswpJFsv/Mft4O4nJgvWO9JCYKfdhi/DOVovZAMuisDrk
         KYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742032830; x=1742637630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SKOb4s7UJ+CRqLv0uuos0ZHyY2OXZUFISjmyYeG7aM=;
        b=M4nwMPppxFFn03p2Dczbxbr/riP3/ho7+Cer4cZLrfr6nf5xd+tsCutnSSVYZ9h9ah
         leL4Q2mVa6Dg2ejD33zG5/pyJoOA/NZlleoFmckVeSXLSUmRS034W1dRitwT+Kuvxzl4
         KDYhu2GTruhR+a7/Y2u5USaSeVqjbYPrOERiiuUku1M5fjQ0hEcNM9QQms2FHJOyc/ae
         PtaNZS3h23QbfUFItw1MCerUu1zO+/8pyq/ef+TYUEhAQ/q2zNB942YxG+vPWdcnypvq
         yUap/fJt9KNDqw6pk9mpmVvsSppRhOorQOw20qYPUNWBe3aPvRei783w3bNApqK3X/yw
         uvIg==
X-Forwarded-Encrypted: i=1; AJvYcCVx9vVQ9YHEMT5lRtAN2jEvYD8PCB1whwgnJ3pbQUvYSh7s0nqFbXaLM8YbDKzplNIlppm7pnemPSXlDCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUpaL2UJwzsq9CK7oQrOBvRFHK/eoCOfit9ou//ARPYhfVlbS
	xb3OP6k6N/uqJjqwteYzl8IastUvQiRRgkGxNY0E97lYmyvsaroQ9znLSTzuIK96a+yrLmL17gq
	EZYVNdDBEgsxBUUogxtWk1fIwngc=
X-Gm-Gg: ASbGncuqBmZomfrGNUFzYEHNiLOFYfq8ZxkN5toQqX+Ah2Rv8gmy9yMyUFYo7mooPr0
	jfsAIRULEGab3Pl/hZccW1obQrBCvjG6d311Bl5A19FEZN3YtKUiFaPWWZwGjvJGpR29Qgnymkz
	KngoJsE6xRQsYzCdfbaaAS93aH0A==
X-Google-Smtp-Source: AGHT+IFgzYN6zVs6fza4G/1aCf4HuEJWF+HHPMqLQmJhYLVCXwOdi4oMKLeRP1NjFkFSVQK6166tlIMzJIAc8WDnvQI=
X-Received: by 2002:a2e:a7c1:0:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-30c4a7547b6mr21238091fa.2.1742032829627; Sat, 15 Mar 2025
 03:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <ced9352a854e896e00f57ab2b062526d688a5b8a.1741988314.git.jpoimboe@kernel.org>
 <CAFULd4ZK4F+BNPb=W8iYFXoCc=JzXyxWH5tqJ--HS7fD997HHQ@mail.gmail.com>
In-Reply-To: <CAFULd4ZK4F+BNPb=W8iYFXoCc=JzXyxWH5tqJ--HS7fD997HHQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 11:00:23 +0100
X-Gm-Features: AQ5f1JqajY6iCWcUa-iLZWy2CDdp_iTYb8BzwCmi_c5Svp4it1PIWTOLqWEq9ps
Message-ID: <CAFULd4bO6BKimOQgm8b1iBn4-fU59ZpH22WM_5whTuPDuv+sgg@mail.gmail.com>
Subject: Re: [PATCH 15/20] x86/cpu/amd: Use named asm operands in asm_clear_divider()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 10:01=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Fri, Mar 14, 2025 at 10:42=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> >
> > Use named inline asm operands in preparation for using alternative_io()=
.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/include/asm/processor.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pr=
ocessor.h
> > index a1baf2fc5f9b..b458ff0e4c79 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -709,8 +709,8 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
> >   */
> >  static __always_inline void amd_clear_divider(void)
> >  {
> > -       asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
> > -                    :: "a" (0), "d" (0), "r" (1));
> > +       asm volatile(ALTERNATIVE("", "div %[one]\n\t", X86_BUG_DIV0)
> > +                    :: "a" (0), "d" (0), [one] "r" (1));
>
> Please remove trailing "\n\t" here and elsewhere.

Also, please change $subject to mention "amd_clear_divider", not
"asm_clear_divider".

Thanks,
Uros.

