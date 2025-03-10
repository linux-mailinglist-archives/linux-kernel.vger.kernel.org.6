Return-Path: <linux-kernel+bounces-555149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A80A5A620
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944D53AEE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F81E0B86;
	Mon, 10 Mar 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLFP3xl/"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0D1DF72D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641930; cv=none; b=O9yWgn0l3APk6EpQGg1r5sJR8sEFChJCRhDMFiQXFiUqjQ0vbf8lVmGy7byGon2NYJJvtacF0yygegyJCVrIf4b6c40XvOTf6MPEpCN09pG35Af0UzTsVLIx/V9J+9YrFgMkMrm4UiN0bT9MZ5Nc1roaut//YD7zSvg4KDTh2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641930; c=relaxed/simple;
	bh=mbee9zDsL47q7YEX/GK5uiod8mXkmh+aOjFFXgwJhFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6yOgGyd+m5UBRg3Zjf7oze367tBtuvI6oLpd+cXIq6sAzxakaRvSQL5OFlO6Ig6mUl1jW/GOejn9QLvMZwEvbYrgileqLiYzqxBXy6ASmwJLLL2CC7lnrT7IN8B+Ir43JZEpxOLEF+SKYk+5CzJuZyZzX9dpCPLzcJybSv6Nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLFP3xl/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bd21f887aso42924341fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741641927; x=1742246727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO6QTemDMrMG2OjKYGqYGVR+F6C3d0fV5feJCy24eBA=;
        b=hLFP3xl/uK6tzFjt+Xm1XpMN6dLod0tbeQA/EbPeOune2qSRdGZC3gGOiNjxiz9kEq
         San+RO5fLbBrjnfC0zPPuYAlwAZheJAxrbDX1LJQbjj/EBDq6nQtIhQq1RiE42iEZ9np
         tkjIh1W8kAKZGWNBAiiIfocHKPG3Z7FM8R7MSNC14kL7yREInbReuLAxv9sqq+qQ8WAh
         Qli2udPjv9ISdGssRaooO+UnlxJm8M60GqA6WOwmZa4GMkAdzfh3jjqGdE8t2LxR4P2t
         ieGi5oOukouxfGQLPYAclfXCpw03QcV2HtE0egemsOJajcdHIVlAZ67PuGw1iINJJKgk
         ezrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641927; x=1742246727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO6QTemDMrMG2OjKYGqYGVR+F6C3d0fV5feJCy24eBA=;
        b=Q65FKjgeRdrQP+FMX6ID3ixtWN8yvh3BBBHurFNX7Vdu21tJxSIX4Sj7riqDDJevsn
         sOm/12lvneENn8XuV/NXDf3hHp3C7S17Tip0g+X5ghGHuU6dIn3Pq8aKPlP9jceUv5hD
         9L44SCnD+T9nDU3238YVVXKzEyUAAdg27xoMgIiJ+qc8GXNKcS1TCwMjqZAU5na+oxrC
         7lb2ibwbSUW5OjtEQLc+/gotedKITawNY/9f52CYRcissHCG9SX1YpnNkSfsenaKQlB6
         Lt9xDu0IQRzf0Jrsl76md8k+KavBpYEHV/1TljQNponmjx5U5cHRvizkwtV2lPypxDdS
         2UGw==
X-Forwarded-Encrypted: i=1; AJvYcCVwYftvsBTvxIcCKBhmXx7IC8TEOHkfyPJQd6Hdmq3KYDYpi4j8TYlCJq5NcSOufsrRItAQDrvSLCvsIgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0PkZxWvBLjJ/X/8cQkaC8PIJGxB5NL8x5FG4x7C9b7xJTlab
	CYsrdvNkl+sZgXy4h4aQb+kzqm0ad9AlIdZGaI11n46o3ZJ7leyUGRZ8LtuUGrv2oSwH+zWbDon
	EygbBniDIEkKNKg4x70cvSsnQTSqV6vi20uc=
X-Gm-Gg: ASbGnctzWKjKZvsn0cFw0Fs87JgvYeJDZFwrvymlVs8gsWfdBUEUw6zWYDx1GIPPDJJ
	ovLl75kFRgCCmJNrU+vW0x9KXliqpw954dPpLg6frhOF0K+Gb4j4QvZ/7zm0uyywKrPTyTNLK+d
	WDQmYOpV1DxTcF4mxPcSFWR/4utA==
X-Google-Smtp-Source: AGHT+IH0yuBC0YetMAfQtKZSM9HyYE8/BiGs28wOM3Wr7WvUAqI1itQB0w8X1W80UVFrjmIpk3woHvi0NXG7xNoKLQ0=
X-Received: by 2002:a2e:740a:0:b0:30b:efa5:69a8 with SMTP id
 38308e7fff4ca-30bf463abcbmr37818741fa.36.1741641926587; Mon, 10 Mar 2025
 14:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310200817.33581-1-ubizjak@gmail.com> <Z89ImJlHFLJUDhFM@gmail.com>
In-Reply-To: <Z89ImJlHFLJUDhFM@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 10 Mar 2025 22:25:15 +0100
X-Gm-Features: AQ5f1JrteqIt7vuzO07tztTO06KvAIK08Yv5KPI98K9Dj7Ud_RRrf_E8Z8HXFNM
Message-ID: <CAFULd4byd1v26FVJFEWedPCvpCSsSKUj0PKz8gOzdfMqdcOoAQ@mail.gmail.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:16=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > instruction from being scheduled before the frame pointer gets set
> > up by the containing function, causing objtool to print a "call
> > without frame pointer save/setup" warning.
> >
> > b) Use asm_inline to instruct the compiler that the size of asm()
> > is the minimum size of one instruction, ignoring how many instructions
> > the compiler thinks it is. ALTERNATIVE macro that expands to several
> > pseudo directives causes instruction length estimate to count
> > more than 20 instructions.
> >
> > c) Use named operands in inline asm.
> >
> > More inlining causes slight increase in the code size:
> >
> >    text    data     bss     dec     hex filename
> > 27261832        4640296  814660 32716788        1f337f4 vmlinux-new.o
> > 27261222        4640320  814660 32716202        1f335aa vmlinux-old.o
>
> What is the per call/inlining-instance change in code size, measured in
> fast-path instruction bytes? Also, exception code or cold branches near
> the epilogue of the function after the main RET don't fully count as a
> size increase.
>
> This kind of normalization and filtering of changes to relevant
> generated instructions is a better metric than some rather meaningless
> '+610 bytes of code' figure.
>
> Also, please always specify the kind of config you used for building
> the vmlinux.

Sorry, this just slipped my mind. x86_64 defconfig - I'll note this in
the revised commit entry.

BTW: The difference between old and new number of inlined __sw_hweight
calls is: 367 -> 396. I'll try to analyze this some more.

Thanks,
Uros.

