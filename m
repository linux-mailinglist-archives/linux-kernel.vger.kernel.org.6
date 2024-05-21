Return-Path: <linux-kernel+bounces-184937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6B8CAE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01892282BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5176049;
	Tue, 21 May 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CcxUzRbP"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0F42076
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294192; cv=none; b=t5HFujQ1ZXY4pK97cMIhcGo1N6u2r0XF2CkATmfaGSzZWqIRb2W8yzeDZ8F2v/xKRVaT5qbkEcHLcyZNVailhU96h1Ule+Cco4iEzoMSrUuRj5Ho0Fz+QAS82aV5HzSoL17Uf7kCrBfzAl9dYcuzB2CO2dbG0Rnowbf0alBuMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294192; c=relaxed/simple;
	bh=lpYRt3wjuJ09ym0V4qH+KDYDfx6LZFwlM7l+U6NDPZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/vQSHCZ/C3Vq4VN20llznZAYG+2phDpPpKyUt5S0etzwf0EY2i6xvztklWgTunApiyoOnSXPCkbWiJ6iL3hXBuewun5ZCv7rLKrpY/kMJEpeyq3RafChu5ct5alXxumz6zgINvuq/3e0gEoV7Oh7smBZMUPQqFcqCmfeIeerQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CcxUzRbP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so762529366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716294188; x=1716898988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwv4UfeFB/qhGfzo1UPvxGLOjaOyyNNjAF75j9o1V88=;
        b=CcxUzRbP0Ym4sRJVskb9y2R9VuQcZ5fwrGbf8R0vufulJRJqzVuyzkuRvNQFQxwN7x
         b0Cp8FkVdBqd6grXJ5P7wiOxoVFoI9xFMz98v2icfI8/PAySUaKTFVhcq3EV2XMuhjOl
         m/L2muazZmNfcBimO8jnQZ80UI0gR1vUmUVsZMQKxS050lo3AzXztfhDPhcyD0vdMv5O
         Vz33cDvsXVRn4qPorIF5pgxy9/ogUPl1rD7NanEcdKAiDlcpjuy6KZkMtjhVNvrM7pvr
         5jeNsTJiIcEUcGARFshWKZed/qKF4msMlmxhEyqr7q3JmnTCjb3RJUoMmy0fK5m8+X1B
         2fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294188; x=1716898988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwv4UfeFB/qhGfzo1UPvxGLOjaOyyNNjAF75j9o1V88=;
        b=cS+mPhOFa76yUiTphdf9NK/FJtQPHI7VOMLR69VKkg0U/HCMItXoqAKwPofONUImzt
         pyKk5GA8OG9ZaqZ/biXRU1lRcgIZjWSQj/cltKeOxoaHZ2qxWwWPC2oJAA7/MDdHHheh
         WeAuthf5xjip4HggxM3MkF77CHu3dN10cepLPHcc17/N1BFQ36JB1QUSyIqNy/SeZFBv
         dw70cX2wKFEET62wKzKZ+d/d1L5ar8+rpsrpzsFLduWdoaPdvr4yCO+3J8jUu5sYQ0DD
         W9zl5EC0I64rkfYuhJ9Zvsqzcd7fzVR0P8OYaL0N3XaOvV0s0NeijXQaGfxkZUwRwcVQ
         dBdA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8XXDy1XoFtI3HlmszEifDj/WlegjgZ81KmWIh+F95nyV7XopOMNOkOwiUOl4tAcow1o4bW2RYE7fP7vorGoiOCzXHYME+OWP87Ak
X-Gm-Message-State: AOJu0YxdkD5NOl8t6E8hbxifVHkxZaJ0mWPHapAUwtZHbnPuz1qFQ0+6
	oMXji8V2+yWOX+ZGXQIQQUmZT6rC6gsbgJtarJQngbbZoey5oOCSar3RutVZ8PvwX6sVkUBQ8BM
	A7xxv4GuchrPL3r3/5gt5M0PrEWZA03BpvhWcYA==
X-Google-Smtp-Source: AGHT+IHX4jtW/r/4JyHv1bYM+G3dQXmDZlMIxpf7dQJZDLPBpeUHYdAiwTVGvcK2C7L80+t1dhIgiRP4aMhzpvkO6DY=
X-Received: by 2002:a17:906:5655:b0:a59:8786:3850 with SMTP id
 a640c23a62f3a-a5a2d681266mr2140690066b.72.1716294188405; Tue, 21 May 2024
 05:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-2-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-2-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 14:22:57 +0200
Message-ID: <CAHVXubhFesiBKL0iF=Xu6J7O2m2i4d903m6o6Anq8JLdwmnz1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] riscv: mm: Properly forward vmemmap_populate()
 altmap parameter
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

Hi Bj=C3=B6rn,

On Tue, May 21, 2024 at 1:48=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Make sure that the altmap parameter is properly passed on to
> vmemmap_populate_hugepages().
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2574f6a3b0e7..b66f846e7634 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1434,7 +1434,7 @@ int __meminit vmemmap_populate(unsigned long start,=
 unsigned long end, int node,
>          * memory hotplug, we are not able to update all the page tables =
with
>          * the new PMDs.
>          */
> -       return vmemmap_populate_hugepages(start, end, node, NULL);
> +       return vmemmap_populate_hugepages(start, end, node, altmap);
>  }
>  #endif
>
> --
> 2.40.1
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

