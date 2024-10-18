Return-Path: <linux-kernel+bounces-371957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA49A4295
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDBD1F22DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D320262E;
	Fri, 18 Oct 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNFS19f6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E81F429B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265764; cv=none; b=ptIQlbXqLV8YA+/hsHXBIkPyOo4UWQ4/TqOkkcTx4QJrPmaatjSxIO6XdaNnyISpDXfi0NJgXZJDjtykxQ8WrvJj6Cju5EtdCuFire0IhMxNTJMGP9HjQ0quEfPPuFFoFgH7boCjkW8SanfIm6zuI+HYJGK5ner5sB8PUEfMh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265764; c=relaxed/simple;
	bh=kEjY45TS5YmXa/acGnmU61z+8wLLu3ZsyHORAdZt2JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftbL1deVgR1eJ2fO1qPSP9v8dcRw2cMNjUw24i2NU2D5/UaMKGEvmmaGcUqlQPZeqpLRq00+Ak+xgLCeYA3tfkFVJawqkKI/fk2+Ld6sjatfheq4okEGaqysfoWKdaVd88L/xIX7Hfs4RKGrXYxNi+ItYMb9duC9nAF3pbz7dM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNFS19f6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d808ae924so1532262f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729265760; x=1729870560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADiKcUQrhytxciJ2JO2dLlP4GRgcbRDCG0c/xTRtFX0=;
        b=dNFS19f6GJpXR2xj4+AJfyfqIptFWwX2k3oVqz4laGaFh7IfZRvGzlwriJtvIKUnDO
         MncDIBLGh6Rn3QYXr3ojdVJFakxj+KJ1u8gP+sMQ5PC45alC6aYJyZ4g8eol6JUuV3Q2
         afqjyzanjL9zRuB4gGdwLgS5g0svpnzBhwgE0NDf5LVHY0VufZBJryKKLPoh6u0mF2N5
         BprMT6ztHoo25648i5zVyfRt/yttKRMNCczxNFdbvdXTpNOz0OjOOzYyxu1N58O2Rw8n
         pAyUl3ILV7QQy/Qcsg1bUVs0dEQI/eRcoEgR96g9dm4KVEyzOHfLgdVmKtEpLdhwK7aA
         KVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265760; x=1729870560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADiKcUQrhytxciJ2JO2dLlP4GRgcbRDCG0c/xTRtFX0=;
        b=mcf1HLecI4BrXI7lJzs1Puw3m3QFSVZTYWd8BVh+F79X7NNyQ6MJWRcZGWFs/D1j+a
         LdXTM+fmkeer5UqVGvCa3+kyAxnXhm6H9QgWtJ4GitX/M21KmihCXTH85bVR/F5jqp9U
         Ns2BNMAcz0Cyd4/1oQ5A+0S6Utowo22gLXLjuF16YqFJEoiCsiYdaOn/CJYe0csClhK1
         jKcr1v7pFJsei9kdBf9umDyQSYBRVZgNT2phMMUFEPAmXBdT4IItTKpY4fatGOTOSwtj
         9EcwCG2v1CF/EYMdygPQzbC4+Sm/r+m2j2ruH3eYkVG0R1MMG++jIrHnPT3Yn2IezTFt
         uh1A==
X-Forwarded-Encrypted: i=1; AJvYcCVdqn0vn7GL2+jR2F1Ee7xBFol0G+vm2A79+LEN/EgA3pZpajoTIziY4x8YQ6IOH0gytFJAxr+cTqmPeoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIIGY00xqGeQ706/9ntCjF54dkgPNwBJn/XxnvW8/7NWLi2Mh
	XFgG6tbbxXGWfhpfO7nXhZGyIvUuNBDxcGvJEOpQwe4scg7iBPUw/2dxwLq5JOUfZBFo+Y42TFs
	HBDhlSLbjeJcZQKOrcUH1aNMWUY4=
X-Google-Smtp-Source: AGHT+IG486ukXM7P/nmrtW7oHmy+w7LlPC071fffEcEQoFvoTZ0NFiF+e65nYbE7f7LRAyeEU2r/BeFNVpGJm64smBI=
X-Received: by 2002:a5d:6d03:0:b0:37d:47b0:6adc with SMTP id
 ffacd0b85a97d-37eab4d1248mr2731666f8f.4.1729265760377; Fri, 18 Oct 2024
 08:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151112.3533820-1-arnd@kernel.org>
In-Reply-To: <20241018151112.3533820-1-arnd@kernel.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 18 Oct 2024 17:35:49 +0200
Message-ID: <CA+fCnZdHBkFYGODVc=Qc_gmrmsuXbE0vUyYnG4s7TrvG5v7E4Q@mail.gmail.com>
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:11=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This symbol is now used on the kasan test module, so it needs to be
> exported.
>
> ERROR: modpost: "copy_to_kernel_nofault" [mm/kasan/kasan_test.ko] undefin=
ed!
>
> Fixes: 44749130ffb4 ("kasan: migrate copy_user_test to kunit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/maccess.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 3ca55ec63a6a..8f0906180a94 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -82,6 +82,7 @@ long copy_to_kernel_nofault(void *dst, const void *src,=
 size_t size)
>         pagefault_enable();
>         return -EFAULT;
>  }
> +EXPORT_SYMBOL_GPL(copy_to_kernel_nofault);
>
>  long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, lon=
g count)
>  {
> --
> 2.39.5
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

