Return-Path: <linux-kernel+bounces-226962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9F914678
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82F8B212BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E931131BDD;
	Mon, 24 Jun 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H0S5k/4u"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435E71B5B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221523; cv=none; b=CXh7gGsjsn36268bQ58iidJ7Ml90VNGRh88EJpVaHOBvp8tY21eqKT0b8RC3ONlzT2qKiAexvdU96rCT1nfL463AYUn0MIplrWlL8L8w1c98fOnlACtMdq9m5HpLnb7OQvGQaNV2PO0xht+IGOUhqnw3JxHAiYAwoG5JX8wEsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221523; c=relaxed/simple;
	bh=i6GsoA4U85wFLMJhxJ2uKt9+SS1Lm1mh24yo44FYz9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb/grdzHw/jn6gn6nailFXUAB3StagyUyw54VChchHP7/iJ1qTC2KuOmqYIPGdsa4Y4m3dt/+36qkVbzeWcYKPlavanPVU5zj/xeIdMhIoEKhh7SkqFP3wwU8bp7VNekMvtFVyzw/zEYwdqNKHgFHbeurfgutVaVePe2xXCWL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H0S5k/4u; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724e067017so104369166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719221520; x=1719826320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtSoSxfjq8aHhF6gq2sk0dwqY29zGCyMkL+T3Rh2MIE=;
        b=H0S5k/4uxcwsSl8ZM6KYVeyiQ2H6fPVwwrAChVWd56eEJCYxeOCSKKl9pjzMunGZ2u
         b0u3OybOzOCDzqAG32Uh9pUPr+8N12d1I/J9w3/JH5Xv+cAbVU93N2CbV9xrHaf8bkq6
         gftRLD2WFnaQeR70ZLL5fR6w7sxzkZKDQimFvHttOdBWAj+MCC+suje+GKYXgSJmAB1H
         Ulf+ndgRrb61BQ4K12tDRSuDWqNStdFdc3hLPU79NRt+t6htEETXywLa8BK89bW+lkLj
         QkoMxWBXKaNxj5aQAvBreesRI7Hw5DJypTCZQs0Ym4tt5+m5u9s91P7tmncjnMmAVcfB
         kWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221520; x=1719826320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtSoSxfjq8aHhF6gq2sk0dwqY29zGCyMkL+T3Rh2MIE=;
        b=aPncsbswv6GYJrge6eVvgB0TMpNsL6+gjXWA8CHXWrhpDjzCjUlDEOgvrqK5dF7d9j
         dC8dXp/URgh1aHs+9dFxck1i9jy5e588MZaj2cdzikhHKaK0jt60fN7nwY9Zqxc2p58s
         Y7i41IYR1iCt3batFS8Vp5MSBqsBjTo0NKmC8eiyphSODQrTv/UDb8lQKIKebQNO4x5x
         E34Vxk4Y6CRWCvS43rBYkDeNM8MUfJk/IZNqCoRKoAnt7Wx+BWWMKkjFsdIudgbpltWd
         utrj2EkwPKToaBYLtZ0HUrqwA1PAy08s16AwMSYRklzGvY7JnAQBRmpEND1dh5P5nsel
         lqYw==
X-Forwarded-Encrypted: i=1; AJvYcCU2U3B8JoZW7dt0V0v5Cpv+c/ISSNhWpEp5AexXXgbAXLpwlyA+4fBXjy7boyumt4uTci/R9VH/LsPBYKMX+22HBselh9yuBlr5qhYR
X-Gm-Message-State: AOJu0YyPzz4iBQEGvh4Pc94KgPZgEvcYcE/wPWvFmDKodT9JyhvK8zmJ
	wdZwp3WHUeVRVduDrZBd03Lp7l1PhShdY8l62AeOyGBIdmPAbKJ4iaBipdsBoEA7NFXhrCfYi4B
	evAXnyhVqp0FUR+Jb3l30OWKxq7M1UfUr8oPYgQ==
X-Google-Smtp-Source: AGHT+IFVeOm41TPJdia3V+ypKDs5ua30MsXI4dF3qYEF70GUNjAd+SwTuXPVZZMhmO/B5Tw3/mwInQAqPilUcV0OMrk=
X-Received: by 2002:a17:906:7c2:b0:a71:94ce:9b03 with SMTP id
 a640c23a62f3a-a7245b6251amr241286166b.20.1719221519773; Mon, 24 Jun 2024
 02:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605114100.315918-1-bjorn@kernel.org> <20240605114100.315918-6-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-6-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Jun 2024 11:31:48 +0200
Message-ID: <CAHVXubhx6VxB3JCXQo_eo-6J27i620ALTBHCnnVif6RG7hpXww@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] riscv: mm: Add pfn_to_kaddr() implementation
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(resending as gmail client turned to html)


On Wed, Jun 5, 2024 at 1:41=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The pfn_to_kaddr() function is used by KASAN's memory hotplugging
> path. Add the missing function to the RISC-V port, so that it can be
> built with MHP and CONFIG_KASAN.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/page.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 115ac98b8d72..235fd45d998d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -188,6 +188,11 @@ extern phys_addr_t __phys_addr_symbol(unsigned long =
x);
>
>  unsigned long kaslr_offset(void);
>
> +static __always_inline void *pfn_to_kaddr(unsigned long pfn)
> +{
> +       return __va(pfn << PAGE_SHIFT);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #define virt_addr_valid(vaddr) ({                                       =
       \
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

