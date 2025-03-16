Return-Path: <linux-kernel+bounces-563058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7CA6366C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92BA16CB54
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687591C84BE;
	Sun, 16 Mar 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFwye/vT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD21993B1
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143276; cv=none; b=YCO6s99ItGfwT4nd9PSuF2Fm5k3317ZswIUaYXnHeqtDY5ehTqCtZTkQSv9wxO+pk5+Rn15NCorOV8RcB2RNdlzbvERLHheyVemQIQ+NPk5BIL6j2GXPrBIownABhO3IZ4hS7KV3radNyMwjBBRhumMdeCqOeEUKresiVzIv7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143276; c=relaxed/simple;
	bh=OgYdSXr9I5BAjxiCmHbr5Zrj7rZOIE4makhbhwf+UPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECdZsLALOh/8aUOOlRxj2KBobo4pKt8EAETVhf7EBjQ33t3k+EeCUtY2YmprsGhNqgzqqsYyyh2bKo4nLR1EHjxzvH/eGloJCKHKgx1M1BnnNHJi/JLkz1LFUtyKlXeuPxjAT5rgFAXoqd5JmgUmlU3hxB0dw0OAy4LU2vsVW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFwye/vT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe808908so45585e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742143273; x=1742748073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GBF4hrYNg5S2oageJXSHFRedLtcB0fhaX79E6KBaak=;
        b=OFwye/vTV3X0qbZBoK+4o1xOBH6Ln/IfnKp7KVKCOtgS73rPZBUQUb+XE/DRcnLApe
         CT6+jXXY0t9wUA9zYWwyVx1rIyHG1bXl8mHOgapgbo2HUD9QL0H9lNSj3F/zOvW/+kWF
         HOAawFvpElsca5tJs/3Vnkztg3W+hHVZOpspuuZHOPFIkTfyrgSX9AzmlCOX+XOkCR1b
         ENlnmzKw4aeNSMj/ZvyUN6GcRxfopAmibuqsFhcJx9S2N7BGHwMDokLguCGZK2fnVQJr
         rBGneefn+umB3oXse5qC7wjB+7mqb6YezdZWU1F905p2akCEli8H2IJwdp3B9J4fFpBJ
         DaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742143273; x=1742748073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GBF4hrYNg5S2oageJXSHFRedLtcB0fhaX79E6KBaak=;
        b=a4LsnkwuFLIybPXrxPra0bvdz6kVajiyI0PFfPATDj0u5MtUupe0TExY//dPQW7sc2
         77JB3x+QOP9Znvikp0nvl5NOttVL/97TDTh53871au3IQ1UuqL2Pox+kBWh3vYSPIwjp
         5J/JpdSEK3Uo0Olyk4cpzkDF99fkV2TilL3AETSEzo1GPMwBUjLDmnn4A2O7QBzsm5eR
         on6MaApkTjKUqk+OkTMj4TCS7hscB5tUYzXT1dmm2jI2qMf22+7dms1wFb9yxLP+Zeri
         A6X0gj1H1bG/DtNtJ0SRJc5B/0wWk8tP6HJ6fpL9+7cl2S/NUIMaLQAn8AGSrdv6iQlJ
         AowA==
X-Forwarded-Encrypted: i=1; AJvYcCXlirjgcXM/wKgbD8fUkYPGx4Adk7I6JWkjVbwcw+5UKVa5fD42NJ3XigmJBapMXarPcWzd5qNbCKOVzJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7ucxYih/M0xGVWtSfTkJuWz8hj8rNunSGgcBR1u6MRPz6KHZ
	MamhLF2FJ938E7a84cEseKrPRr11Deo8EeSTwDXttooOfRHL0fxn5HHIUF4tw7yOS6sY6qD1//5
	LmG3C97G7J4v6zqafzg0EHlZF626BVTCTghCO
X-Gm-Gg: ASbGnct+T4/h0AkhU/zxYZBJEazWV5UsHO0u0cwu+eWCCQK4PcKI3vSBHiR8R7orUO9
	jk9OCCrrmX6y5MfdwOyMY0kCzE8U+d8HxU0ZieWO70a+MtrwiBhSvLo/V136romdlyXM+5qVSYn
	O0NH6pK34ToYkF9HSbu1vbOstf
X-Google-Smtp-Source: AGHT+IF01D4Ob7pcCq8yAjLqxY9BCY5mwz1iWe7tPkMuZuzOjPrqhF7cEGLklDlZvCaLJveOXlkJJNWEbV8nPmuKJPg=
X-Received: by 2002:a05:600d:14:b0:43b:df25:8c4 with SMTP id
 5b1f17b1804b1-43d251f360emr1754805e9.4.1742143273244; Sun, 16 Mar 2025
 09:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315130201758KxKWj6Mb7bgN6SqVrzu94@zte.com.cn>
In-Reply-To: <20250315130201758KxKWj6Mb7bgN6SqVrzu94@zte.com.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Sun, 16 Mar 2025 09:41:01 -0700
X-Gm-Features: AQ5f1JouN29fy-ISQChV-CR0419-uR30-ym4OBM0CsdHXmZK3sOodPrtzjtePzw
Message-ID: <CABdmKX02xw+bDiW9ruXO+nLtDdidQsfKOp-N7NgvACHKyYq8xw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Replace nested max() with single max3()
To: feng.wei8@zte.com.cn
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, 
	brian.starkey@arm.com, jstultz@google.com, christian.koenig@amd.com, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:02=E2=80=AFPM <feng.wei8@zte.com.cn> wrote:
>
> From: FengWei <feng.wei8@zte.com.cn>
>
> Use max3() macro instead of nesting max() to simplify the return
> statement.
>
> Signed-off-by: FengWei <feng.wei8@zte.com.cn>

The commit subject should include "dma-buf: heaps:" as a prefix.

With that:
Reviewed-by: T.J. Mercier <tjmercier@google.com>

> ---
>  drivers/dma-buf/dma-heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3cbe87d4a464..96cb9ab5731a 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -147,7 +147,7 @@ static long dma_heap_ioctl(struct file *file, unsigne=
d int ucmd,
>                 in_size =3D 0;
>         if ((ucmd & kcmd & IOC_OUT) =3D=3D 0)
>                 out_size =3D 0;
> -       ksize =3D max(max(in_size, out_size), drv_size);
> +       ksize =3D max3(in_size, out_size, drv_size);
>
>         /* If necessary, allocate buffer for ioctl argument */
>         if (ksize > sizeof(stack_kdata)) {
> --
> 2.25.1

