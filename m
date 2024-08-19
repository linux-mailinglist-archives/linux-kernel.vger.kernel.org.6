Return-Path: <linux-kernel+bounces-292637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A2957227
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122721F253C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13A71836D9;
	Mon, 19 Aug 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ymY+KyDE"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43745184549
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088570; cv=none; b=TJlO++6bnUvxq5IivNUpc2u8ltV141rfDTvlvxfycqGWQyynBf9SiJ0o/mfHhBJYem3t6TlCa2w8ME4VWG5lx8kU/sfMtum0NNtnNqVundfzZCZROcSe9nCG4twtqJBOoKV0xIt9QZCCz48fX2MBqMeObkk+u68Y5wL1urByuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088570; c=relaxed/simple;
	bh=HhRHdDxBKzzr4TrpXNx9i6/40WV9ocQIbiBt77x5ops=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyolB9BH+vJGwSJSgKzN1K2s2TGOyh6NddVFMFPplDkSUDJdhWzHWU5xXQcfl4jj3qpR4FtgKxie7U8AIlXyc8ss+8ybs2Cci7r9AygSkpEzGiLT6M4yw3tIqXjHDlcA33U0qeKMAtL31ixW9MuE6zRBfHmRfl7T4rlmBWPGysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ymY+KyDE; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f52bd5b555so2653231e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724088567; x=1724693367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTBF8xRO+6dr+B02W+DX5fAQu1yZkaocLrasHJ3WzbU=;
        b=ymY+KyDEfqFGMOK6peb7RoPlCwPcpldO7XZ4nYGxGUpz5qjppaV/Elk5DdXpGmX7JV
         A2FQMgGXZAf40OlSdh9JfRKxqRSddxHQNG53PNXL4TBGMt8PfWK0LKtSF/LOcdmnpCT9
         8OEIcup3P4jVyrop5knml9TTNWMDVCQ+wvYpXy2+B2vJri8Q4Us//KwgcxW5lP0tcrFP
         SPJvjxJgm48kxYm/Soifwmic9SpcVRE8Un2zoR8P/fc+M9HwxtNkLj5wmuHJePcdKUYT
         0sLeMqZvHPrLXW6epLkOfAl8R2Q9n6vSoKpLuNfWkD3Zpx0HADUXcrTdeJkpZMESou1k
         jYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088567; x=1724693367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTBF8xRO+6dr+B02W+DX5fAQu1yZkaocLrasHJ3WzbU=;
        b=T8mnulRp+K0O+T8c0VVBDaeQlIKsNId1mQir94OFDWQ9b3E9/QOYrkBFf05wfUOc7a
         7uHzyK0wmqK49CJ6kJNvysnE8Xp0hKibkpo87ZOmUUjBV1Cj5pIk0VRZzsgAl4YMBOrJ
         f95NkrWpry5e/xOnrmNnmA2j6lrivjTuiaYYhO3WrH2mAjSzQfWwmijxBuJgPoYC/JyY
         gb/EVzhHK/5pcMvU2YIfLrmB6jxu1sXVc7ih/nfa8F0cnoeWqK5Y4IYxPpj6M3bxb/WE
         4esRQXjWxKPWZKiap2mhTUvRJleoLhha989DB7urN3mVH7B4/qAQ8onSBP7dCTEEDXvt
         T+9w==
X-Forwarded-Encrypted: i=1; AJvYcCXygD5tCsoPFRU++Y7aAAqwWWhOCLOClCtqupJyubjwpwz6yBJlEY76A3VHjQtxLdvdFmskyPZO8DgtfsWEMYl4oYwEdMC5Q+a6vB8U
X-Gm-Message-State: AOJu0YyRtsHkrO7w6ZIRaJJlt1fL2ZnQsfml+3pOv16uTYbW5JEBkAEg
	7KG5CSeSmeCVpvp3A1rov08SUV64PTf8YjVWa5axH3bRlBF229AkbcGvxNnIdamg+csacYLaAVJ
	eqMRmlK8LZkZ1LgrM4LJPz6zYWYUts+wSqkGrKA==
X-Google-Smtp-Source: AGHT+IE5C25rMYlYJ9rNhDYQ9jQen34MSS+PvWtWf/qOkX3gU+Sjvd7JiPq70UYyNTDu5toD9RYEGxZa8dQkUNbwjUw=
X-Received: by 2002:ac5:c393:0:b0:4f5:2849:598d with SMTP id
 71dfb90a1353d-4fcd672d202mr327117e0c.4.1724088567062; Mon, 19 Aug 2024
 10:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817075629.262318-1-mikisabate@gmail.com>
In-Reply-To: <20240817075629.262318-1-mikisabate@gmail.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Mon, 19 Aug 2024 13:29:16 -0400
Message-ID: <CALSpo=ZsZWNm_cXG_4GXyZ9invSS_eKH=9Q-mdoM2XV=HwzOXA@mail.gmail.com>
Subject: Re: [PATCH] riscv: hwprobe: export Zicntr and Zihpm extensions
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mikisabate@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 3:58=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <mikis=
abate@gmail.com> wrote:
>
> Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
>  3 files changed, 10 insertions(+)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 3db60a0911df..5bb69c985cce 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -188,10 +188,16 @@ The following keys are defined:
>         manual starting from commit 95cf1f9 ("Add changes requested by Ve=
d
>         during signoff")
>
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2.=
0
> +       is supported as defined in the RISC-V ISA manual.
> +
>    * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extension =
is
>         supported as defined in the RISC-V ISA manual starting from commi=
t
>         d8ab5c78c207 ("Zihintpause is ratified").
>
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
> +       is supported as defined in the RISC-V ISA manual.
> +
>    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x=
 is
>      supported, as defined by version 1.0 of the RISC-V Vector extension =
manual.
>
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index b706c8e47b02..098a815b3fd4 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -72,6 +72,8 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_EXT_ZCF           (1ULL << 46)
>  #define                RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
>  #define                RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
> +#define                RISCV_HWPROBE_EXT_ZICNTR        (1ULL << 49)
> +#define                RISCV_HWPROBE_EXT_ZIHPM         (1ULL << 50)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0    5
>  #define                RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
>  #define                RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 8d1b5c35d2a7..30aede1c90ff 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -118,6 +118,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
>                 EXT_KEY(ZKSH);
>                 EXT_KEY(ZKT);
>                 EXT_KEY(ZTSO);
> +               EXT_KEY(ZICNTR);
> +               EXT_KEY(ZIHPM);

Conor, do we care about ordering?

Acked-by: Jesse Taube <jesse@rivosinc.com>

>
>                 /*
>                  * All the following extensions must depend on the kernel
> --
> 2.46.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

