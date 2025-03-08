Return-Path: <linux-kernel+bounces-552342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F194A578B3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 06:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE7E7A3E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF017B50A;
	Sat,  8 Mar 2025 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZREOVjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08684A2B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741412849; cv=none; b=ExXlcAetRCSLKkkogKzLIYr0C+SbDSYG+eIiePrz5j1klV50/IbYBJWbKLmWMG1xDEZwGO4FdlIcjCPVLht9Xsj6PnYnxJjKJl2xa/qkPV50XlQ3vx9+/r/RhZfi5V5knkviIq9JKrT3C2WyeYfuCXiYw1yBNaNoxgfgtQ+5hc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741412849; c=relaxed/simple;
	bh=7bt+6j5Q+vjies/LWa4TaAAJ1EJn6bHAw/B2dvHYS8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnqmpZIaqilB7fB3ZQUA7VSgqHFAF2ZBN0klKnwHvr4vWvpHH59TMvIwtBY/EgxauFCLViacd0cmxKB+9/YaTA/xc+8/foVpsh+fAP3uG1QgwTm6QSuleIR3w5zYOqL/HX11IoD/nTsJ+Yu/wgG0xd8ZMGZu5kNFi6SRK2+9oGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZREOVjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294ECC4CEE0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 05:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741412849;
	bh=7bt+6j5Q+vjies/LWa4TaAAJ1EJn6bHAw/B2dvHYS8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jZREOVjl0XpIQxoeGnj8aK2M7gw15HChHQTjyILdAJDimp8a6B5KSYyU8rrUDsQQk
	 6ZiKzETdsKgI99bl8tbYWYxZ+P+9MBEGzYbV7LiCwHU3AgZnnuVVokfrGRTiS6S4mE
	 VvjQ9nSt/Py9274OigAVA0nrf8C+B/0UEnFx4mkycMIHKDJza2OTD4oyxNq/82sPC8
	 k7OO3v3F9KL+iZrJmsx8HYPOlCE9C+83tQDuXJ1VKtJmbVxhizEou/ZIf9xNB9iZuV
	 FodmjVp3E9s37ZAWH84ngEwUbosWimevs2QgrYW3qgmAA0kIsVxyWwWtRqvrbdKzzp
	 K/8YwXK+wAPrw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abec8b750ebso427226666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 21:47:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeHzRIWBREEfXjkfmRsyJQa77sjCPVdXiEyU5xWF8j/KvT1Txz+GflmjrxZc2VkTUw1JL8FP/X/qJUb0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGmEcaOi17Rjaq+cOp0RpTUD1w4DOg6X1uPa8YejnxVmZTH0g
	6HYUdNeByptQkZ/mtgdrfk7/JPkRchHyIU8wjKhmWdutgkt6APaknBMrKjYEcDIP/jJkrygWXvn
	Ds2MvSWFk56nxxdb7teovq5sYLS4=
X-Google-Smtp-Source: AGHT+IHfblzcb3JDX2PJNJ+7gmb47AWa1o8o5uirTRFLLPDt6z2ebmfOscXdfMDQloM2YP7OD4ENLnlrPcBa1SoEuic=
X-Received: by 2002:a17:907:720d:b0:ac1:db49:99b7 with SMTP id
 a640c23a62f3a-ac252ff84c2mr692799566b.51.1741412847785; Fri, 07 Mar 2025
 21:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211115016.26913-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250211115016.26913-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 8 Mar 2025 13:47:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4UJe0_VexB894PrRz8wKT9V_i=-_ODQEHCOBv7ngs1xQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqP_SHk7GiHED2C-cFwFZJOJgfBB6TzFTVNf3xTrlGwoYbSTo94OX0rjOc
Message-ID: <CAAhV-H4UJe0_VexB894PrRz8wKT9V_i=-_ODQEHCOBv7ngs1xQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add jump table support for objtool on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Josh and Peter,

Since "unreachable: Unify", "x86: Convert unreachable() to BUG()" and
other relevant patches have been backported to 6.12/6.13, I think the
7th of this series should also be backported to avoid build warnings.

Since tip.git hasn't applied this series, I will apply the 7th patch
as part of loongarch-fixes now.

Huacai

On Tue, Feb 11, 2025 at 7:50=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> This version is based on tip/tip.git master branch [1], the patch
> "objtool: Handle unreachable entry of rodata" is dropped, tested
> with the latest mainline Binutils, GCC and Clang (2025-02-11).
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
master
>
> Tiezhu Yang (7):
>   objtool: Handle various symbol types of rodata
>   objtool: Handle different entry size of rodata
>   objtool: Handle PC relative relocation type
>   objtool/LoongArch: Add support for switch table
>   objtool/LoongArch: Add support for goto table
>   LoongArch: Enable jump table for objtool
>   LoongArch: Convert unreachable() to BUG()
>
>  arch/loongarch/Kconfig                        |   3 +
>  arch/loongarch/Makefile                       |   6 +-
>  arch/loongarch/kernel/machine_kexec.c         |   4 +-
>  tools/objtool/arch/loongarch/decode.c         |  28 ++-
>  .../objtool/arch/loongarch/include/arch/elf.h |   7 +
>  tools/objtool/arch/loongarch/special.c        | 159 +++++++++++++++++-
>  tools/objtool/arch/powerpc/decode.c           |  15 ++
>  tools/objtool/arch/x86/decode.c               |  13 ++
>  tools/objtool/check.c                         |  23 ++-
>  tools/objtool/include/objtool/arch.h          |   3 +
>  10 files changed, 247 insertions(+), 14 deletions(-)
>
> --
> 2.42.0
>

