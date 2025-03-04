Return-Path: <linux-kernel+bounces-544099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7D1A4DD63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B521189C712
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE6202982;
	Tue,  4 Mar 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq2k7AR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCD20296A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089638; cv=none; b=h8CTRz7GWbt6SYGJxFedYL7SyfeO35xsRsX7wWuwNqOpOyc1xT15NjKBEnWXUEq8EGpsXW9OEk5rYEIqKUtENHF1YktuCSSApTdh2toqg2HpDS+EeaE7QHXnCqDMZ/VFoHuwHax/ESr/VaO4pSUX0SvLtjrdNH4YXKbamgmFhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089638; c=relaxed/simple;
	bh=qB2mDI/ttVCvjrNafqYBohFXTw90rzENilQc1qH51yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQN0JpOOO7BK8pwZK7O/mKRqsrqoO+S20TsA06xh97paiJJyajuC6k6GuGm8V7QXWUsNPaKuiRvKVBr1lt3iUWTAaJPuRPxgbyb2MrX6Ec7GPwtN1mdLgrk0ln5u0DVv+x0Pjw4UR7BWM6ygq1JBhUfR7SSMdIBT9hIo9B05W6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq2k7AR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C2C4CEEA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741089638;
	bh=qB2mDI/ttVCvjrNafqYBohFXTw90rzENilQc1qH51yE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oq2k7AR6scRfRcG/tCEux+mX+H4Zx9Q4iil6mqu1Tu0L67QkGsp5YwzFifJC9B/3o
	 DNEhxyLuoGQacQoJrxZvT1m3rB/QeUy3sjxl2I0MJQ8USwADz5rvPmCpC5pPFrej33
	 DpcG+2PQzpulUVtJscJiJwSKAXHl/wSx2UtOd895oCkjdfB+sa5ekuwkddSipGn4kv
	 452F049x784PzthRDLYF3G5d2LAfdmavrnFCSAPJ6BPKqENhrh671AkI6HmpYnUI9h
	 AD+d9GjXKV3K60sI37bvvK0SIE0Cgyy3pEcUubkRJRwf6T2X3+TR1aTclUWlr5SjCf
	 kmDo/BHfCMbQg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf5f4e82caso504645466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW14cxyV7Aj6f6pIqMX/qeqkorAznsXI42Y3nfemh0lMieCzs9equ5rG4+pthlcmNz1JyOsNlTp74sy1B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8uxoBlfHoQ7iEpGWpLlmVDHR2Jdcr5Sl7Onbh4RgkrUZyX9Y
	SmRPakeuYIpFv5Zka9g3xcsk4wCxmeua8aFnbEG90Jly8AjIBIJe3bJmF7D222d59Icr/X/PNJF
	8QV5wyc2xy0cCjiHQ84pKzG6JIOk=
X-Google-Smtp-Source: AGHT+IGEsJXgMBrhUYNFg3pBxcpuirK0pMyFJXy3VeseOoaDUiqqYOHiEONe6XjAWh0emUQ4lLovrI1SO1NRKZ/RaDo=
X-Received: by 2002:a17:907:86a0:b0:ac1:e881:89a7 with SMTP id
 a640c23a62f3a-ac1e8818cecmr436379366b.6.1741089636759; Tue, 04 Mar 2025
 04:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
In-Reply-To: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 4 Mar 2025 20:00:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6zkq1KoLQSQgimEgHhdD=S--kHa9hmhfbxUS_6OOfSJQ@mail.gmail.com>
X-Gm-Features: AQ5f1JraBlaI6SvIcMjFpHRCisLRkrWnMRfclxUHHekZF7odgXnDlO-CdSUQic8
Message-ID: <CAAhV-H6zkq1KoLQSQgimEgHhdD=S--kHa9hmhfbxUS_6OOfSJQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix use of logical '&&' with constant operand
To: WangYuli <wangyuli@uniontech.com>
Cc: kernel@xen0n.name, yangtiezhu@loongson.cn, maobibo@loongson.cn, 
	guoweikang.kernel@gmail.com, agordeev@linux.ibm.com, ast@kernel.org, 
	usamaarif642@gmail.com, jiaxun.yang@flygoat.com, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	chenlinxuan@uniontech.com, donmor3000@hotmail.com, 
	Wentao Guan <guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 6:53=E2=80=AFPM WangYuli <wangyuli@uniontech.com> wr=
ote:
>
> Fix follow error with clang-19:
>
> arch/loongarch/kernel/setup.c:335:40: error: use of logical '&&' with con=
stant operand [-Werror,-Wconstant-logical-operand]
>   335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0=
]) {
>       |                                               ^  ~~~~~~~~~~~~~~~~=
~
> arch/loongarch/kernel/setup.c:335:40: note: use '&' for a bitwise operati=
on
>   335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0=
]) {
>       |                                               ^~
>       |                                               &
> arch/loongarch/kernel/setup.c:335:40: note: remove constant to silence th=
is warning
>   335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0=
]) {
>       |                                               ^~~~~~~~~~~~~~~~~~~=
~
> 1 error generated.
Are you kidding me? CONFIG_CMDLINE[0] is a constant for a specific
config but the config is variable across buildings. So the "constant"
for compilers is not as "constant" for people. Compiler warnings
should be double-checked by people, right?

Huacai

>
> Fixes: 83da30d73b86 ("LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADE=
R handling")
> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
> ---
>  arch/loongarch/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index edcfdfcad7d2..834bea7f42da 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -332,7 +332,7 @@ static void __init bootcmdline_init(char **cmdline_p)
>          * Append built-in command line to the bootloader command line if
>          * CONFIG_CMDLINE_EXTEND is enabled.
>          */
> -       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && !!CONFIG_CMDLINE[0]) {
>                 strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>                 strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
>         }
> --
> 2.47.2
>

