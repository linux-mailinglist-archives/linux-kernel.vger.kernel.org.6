Return-Path: <linux-kernel+bounces-422668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6C9D9CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CFC165FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE31DACBF;
	Tue, 26 Nov 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vmfkj05t"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80E1D5177
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642779; cv=none; b=FVKGomeRrPrmWscD14YJRqdfMh7qyx5Wc5pTzx+O8vfEdGc8EvBmTNx5SfXxlw86OLfwpd92t3ZYaT+1b2bbcjngzWO+gV6tkiIbm6eotWnYX1K9LezSzegIpihRE2wgnAYS4nOT0qCR2Z88bIsPBD1aZi/GB2gF/XbxjqfM+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642779; c=relaxed/simple;
	bh=DAKiNiRqUcrlk7qZBWQDMzgwuhNtCOQn4MLzxAx1CSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qt7oOaMgZpNYejjd4pvmkAe/mntCUCBNfVcCWbLsNeNOwzji0ODsSFF5r/SqJ7KATHMxrxS/izbK++tuvdqWUCHQRlfTPKJSD2NvNJiZWwQYkofBiLRCz8FwZANpQujU5eh+zF0xqhTKxSXRcH/u4flZQceZLvUG2J/aQKpPrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vmfkj05t; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668194603cso293681cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732642776; x=1733247576; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO1R0PYKOlqnWlFJjnkfRK8pDGmHq0P2DPI5kjZRm9U=;
        b=Vmfkj05t7isaRFHglD1py2yZgZCwpF1r1SD+qB6MpFLzCATosv0cFeKINQ00Oi605D
         5FR89BztmkInEAzY9LmnI7csE4lgzVoI1Xoa+6t8j+G9oX+hQVr1K22WhrAB/QLQdRDf
         aBU/sUq5CBjJlc9uIMK0poLPJVOLatFNMYpEo5rEExRRm8kkUwT9p2xSeBK1xjGD3UYw
         +RnUDHWiWecUJG6axbniQG0V53r26/xwxaZMJzGR9HQmSqPG146nQmd7BLiTBZRYwnGX
         Bmw1n46JnImHpji1u1THpkxrU+EzyUsovKT6gjK084slRDZAC3Av5LaBBGu3XSCCiV23
         Hk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642776; x=1733247576;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO1R0PYKOlqnWlFJjnkfRK8pDGmHq0P2DPI5kjZRm9U=;
        b=sJQLL/2kaKdwIKi0ZpsQ8bu+QW8dOPXeUIsgLk6M7S/YuAHjlGB6Gl81Q/amJO13v4
         wCAH4FYl8zy2RmzbeTgCGfy1wv1e43fYnXDQ0oFZ9EqcMS0FvZYg7UhByBnvXZAmEAee
         quutbGvAiwn6BNeOPy3+tcmY3w/wMiGnlL5M37gI6uTu9PlUrxzuAW1cgu4wK/07OZUO
         XeaG/FkxNvpHuMJXCa9CeBN5c5MLq+24qk6h7RM/w11LNXUrmhSZfZjs83GhgPjm7A18
         StJFNnVYcX3Ww9+sOA9JaA2N/OvJ23SthovjzP76x0sGMH/wZ8H50fJCaX7jqk2cCO87
         OzXw==
X-Forwarded-Encrypted: i=1; AJvYcCXt2IpqyFJtZfSIaPBkSlaEJHrbygT8Qyi/kVRq34aE069hbLrWgI1oB8Ad4Kn0nSVpSpDo1PAXTTTyzOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BLgy2EnnrXAxOOTUVLP/m6p/fy/dxHa4NRK/aLT7JxiTzYYg
	CkIiKkgYN0GDpzphnNHq9cwpWJuZMWhZcrY4mmYwNqTtwju3heJsxFpDIQchYLSWCmxAvFfdsmi
	a8kTnkr/gJ/WHVkJkf/RxMW+v/4xp29aayJ/2
X-Gm-Gg: ASbGncuaSmmPdaSG8GmQBS+0aUhpZAs1z3MJI8D/yex9lmt1MMQfCwsKkNUkKVRqAHh
	1E/SeDA4sfnAhkGjvxTy4/pDGSIBd4ZUJifQQH/PhpZLK+K1sZcnIe7MBr+iQ6A==
X-Google-Smtp-Source: AGHT+IHOx+4krsjByiLlQQVuIAKvTsAzFcNmJG+DBiAa7bOxbqLg19QqXzb+hjk+EC94pyG/DATm0bz/m8Je0/78BtI=
X-Received: by 2002:a05:622a:5787:b0:466:8c23:823a with SMTP id
 d75a77b69052e-466a7457c35mr3350811cf.17.1732642776087; Tue, 26 Nov 2024
 09:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126173409.3728585-1-xur@google.com>
In-Reply-To: <20241126173409.3728585-1-xur@google.com>
From: Rong Xu <xur@google.com>
Date: Tue, 26 Nov 2024 09:39:24 -0800
Message-ID: <CAF1bQ=QVA8tDM7vyQXr4aaed1g7q8+rguXap-1HNxTzmg1q66w@mail.gmail.com>
Subject: Re: [PATCH v2] [MIPS] Place __kernel_entry at the beginning of text section
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Klara Modin <klarasmodin@gmail.com>, Rong Xu <xur@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicolas Schier <nicolas@fjasle.eu>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to add the changelog for this V2: The change was to move __HEAD
down based on Chris Packham's review.

-Rong

On Tue, Nov 26, 2024 at 9:34=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Mark __kernel_entry as ".head.text" and place HEAD_TEXT before
> TEXT_TEXT in the linker script. This ensures that __kernel_entry
> will be placed at the beginning of text section.
>
> Drop mips from scripts/head-object-list.txt.
>
> Signed-off-by: Rong Xu <xur@google.com>
> Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Closes: https://lore.kernel.org/lkml/c6719149-8531-4174-824e-a3caf4bc6d0e=
@alliedtelesis.co.nz/T/
> Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/mips/kernel/head.S        | 1 +
>  arch/mips/kernel/vmlinux.lds.S | 1 +
>  scripts/head-object-list.txt   | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index e90695b2b60e..c7528d96dd1a 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -59,6 +59,7 @@
>  #endif
>         .endm
>
> +       __HEAD
>  #ifndef CONFIG_NO_EXCEPT_FILL
>         /*
>          * Reserved space for exception handlers.
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.ld=
s.S
> index d575f945d422..c9c1ba85ac7b 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -62,6 +62,7 @@ SECTIONS
>         _text =3D .;      /* Text and read-only data */
>         _stext =3D .;
>         .text : {
> +               HEAD_TEXT
>                 TEXT_TEXT
>                 SCHED_TEXT
>                 LOCK_TEXT
> diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> index fd5d00bac447..f12b4a7b8406 100644
> --- a/scripts/head-object-list.txt
> +++ b/scripts/head-object-list.txt
> @@ -23,7 +23,6 @@ arch/m68k/coldfire/head.o
>  arch/m68k/kernel/head.o
>  arch/m68k/kernel/sun3-head.o
>  arch/microblaze/kernel/head.o
> -arch/mips/kernel/head.o
>  arch/nios2/kernel/head.o
>  arch/openrisc/kernel/head.o
>  arch/parisc/kernel/head.o
>
> base-commit: 3596c721c4348b2a964e43f9296a0c01509ba927
> --
> 2.47.0.338.g60cca15819-goog
>

