Return-Path: <linux-kernel+bounces-383786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C89B2035
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D09281D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF717B433;
	Sun, 27 Oct 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm0xA7xs"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704344384
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059793; cv=none; b=uQnTzvxTxr6o6OV0gBXH//oX42dGE1lMMKYE4/GbMXaflHYwwOU19n9LcZuLgBjXWYeKJBEny9g72nG0McdvOOMh61S2GYea3EFA/vW7qOxWCsy8TZJPu8BsWH7f2UqU32PUe3vqor62I+usOccjKRvpX+ccH8FXNiDv13T8fI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059793; c=relaxed/simple;
	bh=hai02x0uF1f2p9wGjaBf4UK1RT4qPbgz/1BDXPHSjzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoZfL+oGZIpViwNZpdZ0vRyP+MLjc5g801oO/Yt/m8DQSBsgmqlXRB6iJLcO8j0i8/48lYs4lfC7CjMjjjWdEwRAESAjwl7eCUCP8KrxffCEdVETyAmP2UseL1NbEL3M0kk05h/Hs/P/1/Lm6rh8QD7+E1NNhBgXnEue1zJVtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xm0xA7xs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so2598853a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730059791; x=1730664591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cn0EyHtcGrdcmD6hlX0YTNvVFhgAh1Ym6B0WIFTqsw=;
        b=Xm0xA7xs/d2Y1o8zdTGi7HdSX7K1h4d6a7btfIdkHNsLRLlIb1dskmRAmeX0GCEtHr
         sqkDIp9lEYTSIslr+xPjiqMvCQhT4oDp0rGAFNGrcrTpZuBEcCdQR8maaRvRq7rBYrsf
         kkr3ETfy0KeBtb/sD8CTB9kJo7NsOcRj+JprDgcICzTRcvAfjkBQaLK1OuuJxucMHNK6
         Xs3jf6cJzybWIBhwIVswAnLa4YJ19EdpOSAffOu5M0Y1x6AjP6L+dUEFI/nFkA/quT27
         VOGJdJuHcVxLa5g0My7opLjN/hc1JXYFzWV7ASzF60G3EAc+Pjew3K4XuKBrt7+eNrRX
         xjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059791; x=1730664591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cn0EyHtcGrdcmD6hlX0YTNvVFhgAh1Ym6B0WIFTqsw=;
        b=KYz8DIAuPXJ2JsBdZdw5HCqQTHqqp0Zm2Eauig2+bLBQ0f7cMII4cnBknywtl35vJw
         sVMx44yYCrJxPRobSb9wjFGQsmrPh6xi9KkfHnp9+zl/RsjTYQyR9idPDinsPS/f8WSO
         ebpolS3JnL75CgPMGXyWIa8wbT6/mDrsZD28RX05QpTmU/gj3nDdmk8wVhZ7xQxEAeCI
         9ZXilk9fUY5H1W9Uh4W/wi+P9mhIHvlSDQuK1NlywLaOioSoBTkY8mnCUj+RqEVUHmtp
         Dz0qJr5mxC8kdD6YGyM6CJqoTrysmQeNOMytJxL1mu0n3ignDA46VD47b++o4YS86/af
         xeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4kWsgKmZAM1ZoJ/w7DInEUYxc2zQjkZ4b0P8Cl0tqQ8mydXIUDzGTF1B0jvg3gwYYSq/ENNc7pseIXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy81PolO+wBx+7LTIksc/tm+4Y3kcgn6e2pTVvNDuLqB8N6BhqL
	sNyQtTlAUuHIUWDCRyewJcpkRXWkwXAaloOSs5+KUdEHDjoFgeGWB31rhpQCyh4MtuGFm7cBr/q
	Lbzf1YVaeKCSvGBpWvHJKODtzDK9Tvjbi
X-Google-Smtp-Source: AGHT+IHrGSjFKH9SncqpBZHXGRv9cjlezV03OA7MRXYOgG0sQQ+U00lTiREVcpKN/xwG2bM9NX0Zx7Z0kGH/LpmBcRA=
X-Received: by 2002:a17:90b:1d85:b0:2e2:b46f:d92a with SMTP id
 98e67ed59e1d1-2e8f106d638mr7068411a91.14.1730059790623; Sun, 27 Oct 2024
 13:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026171441.3047904-1-samuel.holland@sifive.com> <20241026171441.3047904-2-samuel.holland@sifive.com>
In-Reply-To: <20241026171441.3047904-2-samuel.holland@sifive.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Sun, 27 Oct 2024 16:09:14 -0400
Message-ID: <CAJFTR8Sg_4DTQqWG05NVeNy8mbNA5mStTdPx6=QcR=EZAoM-zQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] riscv: Remove duplicate CONFIG_PAGE_OFFSET definition
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 1:16=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This definition is already provided by include/generated/autoconf.h,
> so it does not need to be provided on the command line.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Jesse Taube <mr.bossman075@gmail.com>

> ---
>
>  arch/riscv/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index d469db9f46f4..6ff2cbde5296 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -92,7 +92,6 @@ KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
>  CC_FLAGS_FPU  :=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(r=
v32ima|rv64ima)([^v_]*)v?/\1\2/')
>
>  KBUILD_CFLAGS +=3D -mno-save-restore
> -KBUILD_CFLAGS +=3D -DCONFIG_PAGE_OFFSET=3D$(CONFIG_PAGE_OFFSET)
>
>  ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>         KBUILD_CFLAGS +=3D -mcmodel=3Dmedlow
> --
> 2.45.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

