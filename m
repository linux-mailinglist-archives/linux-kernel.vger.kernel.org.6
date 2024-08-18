Return-Path: <linux-kernel+bounces-290967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49633955BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62581F21D24
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE416419;
	Sun, 18 Aug 2024 07:04:59 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7D13FEE;
	Sun, 18 Aug 2024 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964699; cv=none; b=I3rxfBG4g1rLfZBCvTn4/6Sxd+uAsnj8D2h9fWWwe/scDWhuUWzwzasc9jrMgPRtPfu27KvyfgvAlvDzp7QjcYQDMM/DYywHBTy/r4TG8Pc0IJe//3h5H0IryQgxEi6skGm2/vXopzwiYjLnUFG2SElx1Lyv4APOJECkEoaLHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964699; c=relaxed/simple;
	bh=mIrm6vVicupTZRlXUxSQzer2XzkiPaTTLGb8owVkW2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NH28ziGcV1tQXY3+NCDeyJDV0ZR8dnf5osUcpnUb6iXNDw8wNcZw6hMojsAdkiTs054sx9A3yZgPNih/vbeVny86Zvp2XakhJwC5CvBp27t+K2cWCbUfacB7pOsLbVAiDgeKJlkj6XoISciMaf9CqIsaYBVbNhYIxOqDzIrWKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so359834366b.3;
        Sun, 18 Aug 2024 00:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723964695; x=1724569495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6OkscswnHSoLQc+dDQz+vP2n9xYpi6RMiXpbL1v/jE=;
        b=bpPIBThuhrxMAIH2S62JJehP0fKIex43RB6/OtaCjJp0Xmp1310Xxz/wnUI5RAYZ7E
         rH/x7yT52cCMa53OvKfBC6ZQ5eeuu7qnqcEuDv2Jf8tfPuHtB+QMF7fWRjDkntZ7kQPA
         KeACY4oIUVMMpmbmvnV51UkQWlBK+4DkQeVeuhsGNUVCoANlmgokd465czbj8VL0SJnP
         MpJC6p8iaILMQ0IRDrjjE5Eic3HSnyAElcPnku4siQ7aBg2VyKrMW3otn7kW3Nl1Pxxk
         SIIOi634JAnY02SYayf7trEQPIWSqa/sp75UoKA9jWC47tmvKDIiq2QhO48cxglzlomn
         6xpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl8/EO9M8iJDaK3REQGj/3rcUjyQNtTNCT2WA+2oDBdW6MyDVrKJ9gmkuDPvdm4mr30tsJ0of9Ra+k/B8CIom0NHieQfLYIOG8nmSo
X-Gm-Message-State: AOJu0Yzmpl61aZloCT0o9IpqA89o1fa8nyGsr6UgloLnM7Vu0VKwfCxs
	ptRbT1yoEETxgsE4P+evKY1hRi2HgC2vu088+D/kq1eG2QS1hSCcTzDEMEME
X-Google-Smtp-Source: AGHT+IGOKmK8UpZ4hQS37OiAfSiZ72uYIU8SKLb7umOUDMA3+S1GQVzMNQTr4I4Pj6OhFuaji/LRNA==
X-Received: by 2002:a17:907:7e90:b0:a77:b4e3:4fca with SMTP id a640c23a62f3a-a83928a661emr426392766b.9.1723964695129;
        Sun, 18 Aug 2024 00:04:55 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934116sm488426566b.109.2024.08.18.00.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 00:04:55 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so442256966b.0;
        Sun, 18 Aug 2024 00:04:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZ+NZEE9ai64YLh1iwjdkNngnxYYR+8KD4IoeMMIz36WD6lrKAzNF/nOSYJxa7ayn9YIIyTxMH+Wvt3+hVxQgbxeM6APM/8hZSkmj2
X-Received: by 2002:a17:907:7286:b0:a7a:8da1:eb00 with SMTP id
 a640c23a62f3a-a83928a993bmr482431466b.7.1723964694394; Sun, 18 Aug 2024
 00:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731125615.3368813-1-neal@gompa.dev>
In-Reply-To: <20240731125615.3368813-1-neal@gompa.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 18 Aug 2024 03:04:17 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9qtud+9uJdratbLmD9EOWPrFh8xn5==-ip_AMZF82Vsw@mail.gmail.com>
Message-ID: <CAEg-Je9qtud+9uJdratbLmD9EOWPrFh8xn5==-ip_AMZF82Vsw@mail.gmail.com>
Subject: Re: [PATCH v2] init/Kconfig: Only block on RANDSTRUCT for RUST
To: rust-for-linux@vger.kernel.org
Cc: asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:57=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote:
>
> When enabling Rust in the kernel, we only need to block on the
> RANDSTRUCT feature and GCC plugin. The rest of the GCC plugins
> are reasonably safe to enable.
>
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> ---
> Changes in v2
> - Drop changing !RANDSTRUCT to RANDSTRUCT_NONE
>   (they're equivalent anyway)
> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index a465ea9525bd..0939486938cc 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1900,7 +1900,7 @@ config RUST
>         depends on RUST_IS_AVAILABLE
>         depends on !CFI_CLANG
>         depends on !MODVERSIONS
> -       depends on !GCC_PLUGINS
> +       depends on !GCC_PLUGIN_RANDSTRUCT
>         depends on !RANDSTRUCT
>         depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
>         help
> --
> 2.45.2
>

Bump for notice... Can we get this looked at to incorporate for 6.11?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

