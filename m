Return-Path: <linux-kernel+bounces-538566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1983A49A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8D717394C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59C26B96C;
	Fri, 28 Feb 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDU2peMM"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FB25E471
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748446; cv=none; b=VWxXjLzm5qrxbNJhX8929csc41BgsaeKw2Tr/kWqgYZK0F90zdTJTrPv2kQoalFXj1PeAfLUVyht18cGsEvs9txT36L7/uHR0lyRfCX3Rig4UpS3abmnlIiNEUpavL6vYOpYpzWargcTCuKtk29SrAIEom1QV4YYm9L7tzwMPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748446; c=relaxed/simple;
	bh=5Y/yAr3MxqNnC2ed09foiTQH60lntwwnjTvLsAzdtyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDSoLjIRjmntPbwoysg2f2RATGC9HtTW/DsP6Ew5RUu5KXdmnituHn6PWcWsDSqiBf3hw2QtOe1WyLGTRp4kGSDEN2RQSfoeOUN+FiQDI+6xnmeanLsM7VaVzKTjmXjkOVR7h8Puq040zwXRloosnuHec8UUkXugMMvZD3Y5+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDU2peMM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so23158031fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740748443; x=1741353243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=312B3wi7NtCRTBr1o81tHVn32TwC98AsSetRlap9+yg=;
        b=LDU2peMMT/dTACmJ8lizhoShRI/w+HabdKAxcUbiDHM1JnlMML/22K80AAE0tqnoIY
         UPTjQEn7zTfggUuAa5jOX98zKP8J5RJBzAunQXBo4aU7vS+VEu8hm99KNpq+Szw2hcLd
         PhOlGkoT60NlfPgjW3boUOZVzzmuSzpZlTnfkx758fbkUMlt1+8am/k4+vUhTSVYtXr0
         IsQL2OFLfRC2er/wkihvQYDWGa/sJY2WEGApgNxA4agrNcCwTj0JtvfdaBkKwszEWtCu
         usXpPuePKLhqgWz7nv/fxS+JMo5tA4imd+ye0rnESpRv8wWtPxUv5lPbE99X9RwGFFux
         RHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748443; x=1741353243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=312B3wi7NtCRTBr1o81tHVn32TwC98AsSetRlap9+yg=;
        b=kfdFWFwCPAw0nnb2Owj8s5puXpckXJ9YjPNSaRWR3F0K9esV/xXD/GtsnMI4qdLhTY
         4WTRANUdHzkkDAEqApv/CROTmYYlbSjukHBh9DtmvmX+SCSrf2HTEgOAp6NJTf+b3l99
         6fPLcXKWa5HcKx3DZ9Ep+qdvmiBMCEmVnM+zR6HkU1flsV93ji8fbrgtzb9hZh/tYRiZ
         Cx7YAOwzEcE1LbmGZPIM6H/tDWQmZdcEixnynl6TUNk8beyez2oozUplt3PiWmE0uaCn
         8ZKdEObn5wKyw3NEpdNd6dYXXi0EqHqjgmUXRx1P9QmaA+8lc3iuM2RChn41CkmqMogF
         tyyA==
X-Forwarded-Encrypted: i=1; AJvYcCURMKJJMD5wfoR+WH1bzpH/SaNEJdk/sxuu/1dg5cOpwA+4Ev73HldzyabGQzHwELEWKTtsC9DFXEGGR6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/bY2DEXCnIhrZsIrpMha0+Um2YlzZwPVSm9amBdKQxgT9tF2
	Ej0JJjT2Nfmv2cBcSBKzUPRvPwj7Dm/mWn7w6idtwYWSHIiODrl1c7fE3YBzrBytLlMtnq7gcSG
	6n4Blk9ELl25rBK1k0+PrGk++y8M=
X-Gm-Gg: ASbGncsqryYPbhYyM7/m51KXRTstcj+Pi6Nc8h0F2TtgaGsrZ2aub51DZLHNnNSjHS6
	xIrL8lK/TmgHujeEIy9HGCZU2ppXeOtoUq2VELYvd08SRfKTyFaN8DOKMYShQmSTXm8Ir7G9vP9
	aqd2XI+r8=
X-Google-Smtp-Source: AGHT+IF6+8IqFCl4rQFcC2Lvc++8tQF5aeWvByPkm4YKypAPobhLVrWWR/V4K0sTtKgiAs/+PWB1h0cA3u1tEFnPsZc=
X-Received: by 2002:a2e:be10:0:b0:309:251a:df1d with SMTP id
 38308e7fff4ca-30b9324e4dbmr11108741fa.17.1740748442936; Fri, 28 Feb 2025
 05:14:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com>
In-Reply-To: <20250228123825.2729925-1-ubizjak@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 28 Feb 2025 14:13:50 +0100
X-Gm-Features: AQ5f1JoYqZpDtXLWPoEaN-3SH18DnnCzUp_XPwsKHP0AcosKG7PSOCQxYoKZQko
Message-ID: <CAFULd4ZSS+gLeqFs4hNSoEsN-T-UUOGVzLX9OjR07maMrP+CHQ@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:38=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> According to:
>
>   https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html
>
> the usage of asm pseudo directives in the asm template can confuse
> the compiler to wrongly estimate the size of the generated
> code.
>
> The LOCK_PREFIX macro expands to several asm pseudo directives, so
> its usage in atomic locking insns causes instruction length estimate
> to fail significantly (the specially instrumented compiler reports
> the estimated length of these asm templates to be 6 instructions long).
>
> This incorrect estimate further causes unoptimal inlining decisions,
> unoptimal instruction scheduling and unoptimal code block alignments
> for functions that use these locking primitives.
>
> Use asm_inline instead:
>
>   https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html
>
> which is a feature that makes GCC pretend some inline assembler code
> is tiny (while it would think it is huge), instead of just asm.
>
> For code size estimation, the size of the asm is then taken as
> the minimum size of one instruction, ignoring how many instructions
> compiler thinks it is.
>
> The code size of the resulting x86_64 defconfig object file increases
> for 33.264 kbytes, representing 1.2% code size increase:
>
>    text    data     bss     dec     hex filename
> 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
>
> mainly due to different inlining decisions of -O2 build.

FTR, -Os (where generated code size really matters) x86_64 defconfig
object file *decreases* for 24.388 kbytes, representing 1.0% code size
*decrease*:

  text    data     bss     dec     hex filename
23883860        4617284  814212 29315356        1bf511c vmlinux-old.o
23859472        4615404  814212 29289088        1beea80 vmlinux-new.o

again mainly due to different inlining decisions of -Os build.

Uros.

