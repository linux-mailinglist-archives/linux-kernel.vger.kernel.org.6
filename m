Return-Path: <linux-kernel+bounces-419339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FC69D6CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 06:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8BE281622
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 05:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B93154444;
	Sun, 24 Nov 2024 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9nSNQQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FE13CA99
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732426437; cv=none; b=C7xbtt7s2HqeN541FtQhtT5zjqhP+zmiRQb9aiE/P+wjQyl/h+vozvA/QAp0VT3NoJJDvinzDG00xZB3BiIG3S7HWuoqm9YXdq8wDy6A497WEuT/wFxpOt/KhcwqXbkPfEemvN7uv//v4r7aJelf8UJrRQvHJzoUVJs+VHiOHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732426437; c=relaxed/simple;
	bh=lsWJ7hIwmqH4zKPKpDuOvRzAf9o0FX5oZjN1MtXjKEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPvrQCPYKtIpVsz3sHntVdTHDJKrVNjNoFrIfH4iLfNzl1KbORtfDX/af4XLkUPSH1PgvyK40gikzNudhBMxEr9PAwmQjzy0beakLHYwjXWD3OYFPQcgseTHEnKpNcKDyol1WZ2o1wBzNxfHm0xiByxjhBph1Y3OIN37sTNZW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9nSNQQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A1DC4AF0C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732426437;
	bh=lsWJ7hIwmqH4zKPKpDuOvRzAf9o0FX5oZjN1MtXjKEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b9nSNQQ4S8NcJIiKfjZMlu9xF9hplwLePIGaig64fOdsgPBAsCFj0vbS1V6Mdj2jy
	 t9bwHXpG/5rLJtutoNYmxx3txI9Rgkm9ZJ08fW6LWgXInGV7j+XZ+CHrtX3M4XVGjh
	 C+h/gRC5c5SZxXKES/Z1iYfVOWKb6voiozQhX8Wtd7ocSTSzlS/W1owfFdhdEvDtTS
	 5qjDc8ND/rD6hXb+dAHj/AIvQ4LAH4i9FkPxfzNhgzHkadI991XQqHYIRHcERyvbl4
	 G6a4SeGg1UpAChyilGceLMowUQl9IFUYj/uyO7rB/iW2AAdxgURgsrDzL4HUR5oxU7
	 zG8JsPKvN6pvg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so19833666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 21:33:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUk43f4YvFmQQ5Z8a1IiGUfC0KYFWqM9mcEmGgkefzJmMgQ18OjZygeGzfS4RvNGq43+z2Re7UOcL6f+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBB/lp4ZoV88RMwpZ7YYEhCg+QJU9ZGT45wwbepv1ejJKWdBuk
	iOm2//5ectedJSkm7Q+C0lF2WWdXZymVfS578L3XUOf9s/qEpwwtPJR455QVN8mC3ZHvy7OeOpb
	WZEkQ8DeHJ7W4qAto0hATiRiXubw=
X-Google-Smtp-Source: AGHT+IGsd4ISMnlPFdcMA2Mp+XlnM4DjrW4plopNbAX2q9mbjRW+4QSuPktNZdN+jLDwMejRrbo10At4krSM/0/2gyo=
X-Received: by 2002:a17:906:cc9:b0:aa5:459e:2db with SMTP id
 a640c23a62f3a-aa5459e03bcmr94401466b.53.1732426436178; Sat, 23 Nov 2024
 21:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241122045005.14617-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 24 Nov 2024 13:33:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6B_-y6ebR=GJmazzukW8Ad-=VRJPvT=ZF+41+rTX7D1w@mail.gmail.com>
Message-ID: <CAAhV-H6B_-y6ebR=GJmazzukW8Ad-=VRJPvT=ZF+41+rTX7D1w@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add jump table support for objtool on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Series applied, thanks.

Huacai

On Fri, Nov 22, 2024 at 12:50=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> This series is based on 6.12-rc7, tested with the latest upstream
> mainline Binutils, GCC and Clang, most of the patches are aim to
> handle the special cases compiled with Clang on LoongArch.
>
> v4:
>   -- Avoid EM_LOONGARCH and R_LARCH_32_PCREL undeclared error
>      for various compiling environments.
>
>   -- Remove the check condition "dest_insn->type =3D=3D INSN_NOP"
>      for unreachable entry of rodata.
>
> Tiezhu Yang (10):
>   objtool: Handle various symbol types of rodata
>   objtool: Handle special cases of dead end insn
>   objtool: Handle different entry size of rodata
>   objtool: Handle PC relative relocation type
>   objtool: Handle unreachable entry of rodata
>   objtool: Handle unsorted table offset of rodata
>   objtool/LoongArch: Get each table size of rodata
>   objtool/LoongArch: Add support for switch table
>   objtool/LoongArch: Add support for goto table
>   LoongArch: Enable jump table for objtool
>
>  arch/loongarch/Kconfig                 |   3 +
>  arch/loongarch/Makefile                |   4 +
>  tools/objtool/arch/loongarch/special.c | 156 ++++++++++++++++++++++++-
>  tools/objtool/check.c                  |  75 +++++++++++-
>  tools/objtool/include/objtool/check.h  |   1 +
>  5 files changed, 233 insertions(+), 6 deletions(-)
>
> --
> 2.42.0
>

