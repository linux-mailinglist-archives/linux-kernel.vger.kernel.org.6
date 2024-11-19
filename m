Return-Path: <linux-kernel+bounces-414011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB59D21CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D91F22715
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0F199EAF;
	Tue, 19 Nov 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaF/4kZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E513C8F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006123; cv=none; b=Mwe5mz5GoYJGlB7oDumrR2LQivAt8f7RO/495RzGXTNtn8Y8rg8+pxjd/P2/ybqGnOcUNMUKoZrVE04Ow4U0hzrY2Eu9ZhV9sj8iWVg2ZZW28b9PP3dT73wyV89b+GAaZ8sna+zIVKfvqzE0FPXmR7472ZAUFeTxKMrB1W6GQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006123; c=relaxed/simple;
	bh=qUPrHNOjTXsM3m+4zxm7QsnWHRQlkHeGy4VZZ/bTTFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXEOrjGUmWE9M6KPMqyCDWehFDs6aarVriEhnvFsOOKaWK2i/n2fa/10JxXLlhSEQR0uDQl6V6GIOyan/ZLhL7Ly6DWJCvRyDXSmnziltq4VAhT5D06MkLBbm/rA6ZCKqZnKLCY+63U2VO17crZlHspc9dj70x7lTdeFWJi0O3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaF/4kZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B8DC4CED7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732006123;
	bh=qUPrHNOjTXsM3m+4zxm7QsnWHRQlkHeGy4VZZ/bTTFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VaF/4kZgN/FfU114VRD5atuac2vdDd+wddmsyEaJFw2p2BrnTJFwzJlhhY9VkWPU4
	 T34JLqYtmeG7IjyaSVK7MM1sj3YBxqY2pFXo5IJc/56P/mJqfj2RplXfXmaoYlu4hN
	 rr5A8EtoYdLZevEGaK598CXBh4o293DR5NbQr/7TeGKmTfRneoo7y4Y35/u0M38P9b
	 1faecKfq51cf+Q07VgZz2SiqVxoHGuMDxXk0K5nhnjUKQfyq4XvovRTgyvPSw04C9A
	 s8MCY0eL57nYGF4nuUDUk56Bo2ywIpVZVxSjy1SEJDPNjLt9S3L8/I1GeN8eZKthIZ
	 EOWz7AuA4QtKA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1f73966a5so590715366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:48:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVS2XgamKQwdAiaRR5Sl8YkgD3DNWZXpAtiLYy2QMrmUB8DRg/PaRQfpS7ywSIYqtmfilHQwiAvWhEJjzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RlvFDJHh1JcmcQpmT9LoKCDnt7OT5s8LQ4zU2180ELJ8YV3n
	xzWKYwltbrW6YeTsQ30Kbx+4y8QEkjk60xJgmpZNK/QDIM/2qLwm+Gv+uSgyshAvvELGpBIdRsj
	hDx5GtmFeWNObvl8r8pfMpvpG8iM=
X-Google-Smtp-Source: AGHT+IHJTl7n33lF+4V/J0EXF3Wx80x+47kYwX2AtcgcYJT2dasDXhd1F7vRJ/Ki0BpnHWlNKlexsarzXrkxPshIuLk=
X-Received: by 2002:a17:907:d01:b0:a9a:1115:486e with SMTP id
 a640c23a62f3a-aa483525d0bmr1183625666b.45.1732006122054; Tue, 19 Nov 2024
 00:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241119065655.21123-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 19 Nov 2024 16:48:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7MP-gsZ3bT4o9=VNvRSs95cxq=Y5VbTK4aV+c=wyOKJA@mail.gmail.com>
Message-ID: <CAAhV-H7MP-gsZ3bT4o9=VNvRSs95cxq=Y5VbTK4aV+c=wyOKJA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Add jump table support for objtool on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinyang,

If you have time please review this series, thank you.

Huacai

On Tue, Nov 19, 2024 at 2:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> This series is based on 6.12-rc7, tested with the latest upstream
> mainline Binutils, GCC and Clang, most of the patches are aim to
> handle the special cases compiled with Clang on LoongArch.
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
>  tools/objtool/check.c                  |  68 ++++++++++-
>  tools/objtool/include/objtool/check.h  |   1 +
>  5 files changed, 226 insertions(+), 6 deletions(-)
>
> --
> 2.42.0
>

