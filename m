Return-Path: <linux-kernel+bounces-194573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D18D3E69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5058DB22B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29811C0DE9;
	Wed, 29 May 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OgZhJ1v3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8B15CD55
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007663; cv=none; b=Q/ZZRmdnHj89pAUBVM7KK3EvNHR6dljbs0wNKZ6AxjuVG2BTXxY6uowFqDEvEf6LekyVMkjORDCjR1a5M9I9GDvYNs1Q7xWbJKNx5a31xFFtMgsn0WWUKVYeq0Pz6qcdyVonU1bPcUlm+mBqDl+n7JwuxLwVdL80eKPXEMd84uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007663; c=relaxed/simple;
	bh=/LUGPZ8sRhOa4AmLVDY/nkUbCDAoK3NG9aCU9NfcpLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itc3JihCd5xjukFHOZuOwUai1wlQoPSSkDB1s0cpqxqCVci5gRxjI+udABGGc1IPCw3tCWZBAkoWlET7KRvsK6UjTyU7wlBKKVVU5wMMa8PKZDx/zBDNf9DOtIyg3VAsLTvC+ve4DYSnrDIOK355z0XZsmkHbxd8LzcBB4qC/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OgZhJ1v3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-579cd80450fso528056a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717007659; x=1717612459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD6ZFR8cVhkF2jyWECX8kqG1Td4lUwUC/HVkt49WWDc=;
        b=OgZhJ1v3llbSl+P7ybHZpo77dFkoRJCUzreIynVyMlYFmB8JN1xCZfZtq4+H3R3kLf
         Q87UWZtausi4A9hi4rPQ4LeW628vpUkJznLoo8zp5g2ZdlB1iZSdPnGlFxY6CuSTVkIG
         VHnASZeLtUDC+eAqzVcx012e+3s5fLzgAmJLJeN7sNHJX8To3hLQeu0brJ9UwKgrA0E1
         ZOx6gAs23Q6hzFNNPu+VkNNipJ7f5gNwinK9kZxKyxLTDXHDVcxjsjSMtUOGr9SdQuWq
         VfvSda0Z3ccvlOPOp1qO22lickpvUPkjtjeZYy6r643JqSE2KET1gJ03R3hLsUYuWyH1
         cqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007659; x=1717612459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD6ZFR8cVhkF2jyWECX8kqG1Td4lUwUC/HVkt49WWDc=;
        b=HE29nxdS8SEL4zX5t9cBacd4j7U7NqzGLd4p3GVJUu5lRXHnJP3CM06+/jJOn/8L1h
         g2MbJCB7bj44oOGAYVeBkhubh3vweDFu4wyO5mpsTQmmXRYkVvkFjHUk/inQXlp1xBU7
         NT43cJCapRFZ39Pt942FHSxQDnZ+uHVWyRwqJqCKABoAS7K7Bvecp/HrmKi6s8TUtuaE
         tQiC5kbzWoarpldEn+6WTRfxFasKPepHe05Su26MlyZr4gjF82Ob4qxQDaFIQnX/22oN
         erpA9stN5vRjntt1NDoOqnjov4yVtDCobc9gZ2gUMm2UzTJKIPrQuLYWCxJQN9/PYkqh
         jlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1SeV1M/wrctIZx+HFL4MTncWD+3/H77GImlWEqoG2hzG5IEWFwK0hI/BNNdKBlTA1nuSr3Tynul1tRrQniVVlRlCir0M7zK/EN857
X-Gm-Message-State: AOJu0YxTY7VFb5P1BeyL7tr4Wx4jR7Pzbf4YKDHtDbDAFVOLVtfmHnFE
	mkrc+Lpy+bhRL1vR20SkAuI9YCaArxXKpl2DqGjqbJ0j7ZgG+XgG7tyv61IbaEZjNTsYZZaFf46
	jLuF3vTauMjWWLkGn2z3egLhwFZtL0iiCaUJ4LA==
X-Google-Smtp-Source: AGHT+IFfrfi+FZNye+Mi5cT1d9Y5frgn3oR/psuzmdDX57yFj6cbdF7CKYfEIUYsI39iYQu9pPkVIxjamQlqxGS+pZo=
X-Received: by 2002:a17:906:66d0:b0:a59:be21:3587 with SMTP id
 a640c23a62f3a-a642d2780fbmr270278866b.8.1717007658800; Wed, 29 May 2024
 11:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com> <tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com>
In-Reply-To: <tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 29 May 2024 11:33:42 -0700
Message-ID: <CALs-Hst_TpjuQw0t-p9GbcCY4FAwXSjWziHJJuToi3rWXo7mJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: hwprobe: not treat KEY_CPUPERF_0 as bitmask
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Elliott Hughes <enh@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:36=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> Since the value in KEY_CPUPERF_0 is not bitmask, remove the wrong code
> in hwprobe.h.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

I'd expect a Fixes tag, and ideally some discussion on the reasoning
and ramifications of this change.

I posted the other possible fix, declaring a new key, at [1], mostly
so we could see the two options and discuss. I'm okay with either
patch.
-Evan

[1] https://lore.kernel.org/lkml/20240529182649.2635123-1-evan@rivosinc.com=
/T/#u

> ---
>  arch/riscv/include/asm/hwprobe.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 630507dff5ea..f24cad22bbe1 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -20,7 +20,6 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
>         switch (key) {
>         case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
>         case RISCV_HWPROBE_KEY_IMA_EXT_0:
> -       case RISCV_HWPROBE_KEY_CPUPERF_0:
>                 return true;
>         }
>
> --
> 2.45.1
>

