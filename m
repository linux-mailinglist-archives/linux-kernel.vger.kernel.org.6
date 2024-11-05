Return-Path: <linux-kernel+bounces-396343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D09BCBEA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC81F242DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56721D4159;
	Tue,  5 Nov 2024 11:31:15 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC81D0942
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806275; cv=none; b=OY9LFiv/IhqRfXQ4dqDR8pKMyh7N+ho+WkMIMhj/QzhjvyzO+VvH+wgfAvJPYl4FXKfSCtnS56i15ptUQGqMxGYRnmi6NJOoYsJ6kuPj6NnoOkf51hr+DAigkLIwO9wLvzhfUopVNlsIAfGkbIEUBqc+lbCushBV5QPVWQ9bPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806275; c=relaxed/simple;
	bh=fjybbPLO/BWHNGOywGvWPA3ZiGSWpzxjmYukNCTlqp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cfq+b6fAZ5V0Ah32//x+ZtxpjbqloZVeTwLAOMhv7c8Jbh71Tpe6D73Zdwrp7gvnyYdi8Bg550+UiTLlvJK8RKC6L8BblJUB6HSL3/K4g5N61TSew1sppYJ6aTMAB3fLK7atJpdDSDaYv6mvdfTtN94B/qMyyjy78GvlwzUw8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3314fc5aacso3009460276.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806272; x=1731411072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuN371NGARBXakroR5Vw4RFIFEwA0E/afFCyC5RBX9Y=;
        b=prdM55Nv1vZtTSwPucnyYhbMW6KFfPAnCiGhaGSpNTLctxEe+m86PFSEdaqc+HzMWO
         dau6BUOO1561IkG1vf8Noy+dyinGOGtzVrnQOS/3dwc1VbDazv1dNYSkBimgVY2K7TeD
         +py9i2p3Hai+RUbicUq/mdMbV+1w9m5q3sSQTCoHQSJVOTJSvUDNv5ziPgAIkdW2tNrQ
         LEoQPdhx7lo8mBOoVcjCqfhZaCwQEFSZDFDc4gi04f+2MhYcZnZFDHxp/vebW4AK9sOJ
         FayfqhIpjda6dvYHFjQGm3aXkQ/zOtqRvOVLYQMUfN8kLz051P6/7hlb0XzY0x8p+1bS
         DSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrKZtBxaIfzle9WsQjONaIPRhIGSd8dOzXceituZ9Ioh4eG3NZZWutmnLHJKU25j/pctbhKPSJADc5Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQjyMMhqq7JqTKIoLVLIf9vH1RdIBYAkUlNJBI7srW8/pSqk3
	6/uUAzexf6lLZ+L7ZuJxvFcrB2MTfeNoLV+hnM4D4JAKG7vkZnP8joDbwcn0
X-Google-Smtp-Source: AGHT+IGaLVU3T6aEpHqdoYLV9GQ+cMlutapgyUEnLFfZSxDoaQjAzZUaI7gbNwfMDgFewrmAZYUzZg==
X-Received: by 2002:a05:690c:2b82:b0:6db:db7b:891c with SMTP id 00721157ae682-6e9d893d10amr264063447b3.14.1730806272509;
        Tue, 05 Nov 2024 03:31:12 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c8845esm21476157b3.108.2024.11.05.03.31.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:31:12 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e30eca40c44so4718369276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:31:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWZfO5ZW+W3PgBPX8Pedw2qz92NpIQEfEagCkof1qiBQWJZhXTGsQGaDYUVpxD5YojIQpX8RHP8cttp/Q=@vger.kernel.org
X-Received: by 2002:a05:690c:a:b0:69d:e911:88c3 with SMTP id
 00721157ae682-6e9d8acb3bfmr309446657b3.29.1730806271787; Tue, 05 Nov 2024
 03:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e7636a21a0274eea35bfd5d874459d5078e97cc.1727926187.git.fthain@linux-m68k.org>
In-Reply-To: <0e7636a21a0274eea35bfd5d874459d5078e97cc.1727926187.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 12:30:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUZV7Fjy3ZmFimwoYqC2dR3zdjRKdS_rWQ37o-rA64DWw@mail.gmail.com>
Message-ID: <CAMuHMdUZV7Fjy3ZmFimwoYqC2dR3zdjRKdS_rWQ37o-rA64DWw@mail.gmail.com>
Subject: Re: [PATCH] m68k: mvme147: Fix SCSI controller IRQ numbers
To: Finn Thain <fthain@linux-m68k.org>
Cc: Daniel Palmer <daniel@0x0f.com>, stable@kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 5:32=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> w=
rote:
> From: Daniel Palmer <daniel@0x0f.com>
>
> Sometime long ago the m68k IRQ code was refactored and the interrupt
> numbers for SCSI controller on this board ended up wrong, and it hasn't
> worked since.
>
> The PCC adds 0x40 to the vector for its interrupts so they end up in
> the user interrupt range. Hence, the kernel number should be the kernel
> offset for user interrupt range + the PCC interrupt number.
>
> Cc: Daniel Palmer <daniel@0x0f.com>
> Cc: stable@kernel.org
> Fixes: 200a3d352cd5 ("[PATCH] m68k: convert VME irq code")
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Reviewed-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.13.

> --- a/arch/m68k/include/asm/mvme147hw.h
> +++ b/arch/m68k/include/asm/mvme147hw.h
> @@ -76,8 +76,8 @@ struct pcc_regs {
>  #define M147_SCC_B_ADDR                0xfffe3000
>  #define M147_SCC_PCLK          5000000
>
> -#define MVME147_IRQ_SCSI_PORT  (IRQ_USER+0x45)
> -#define MVME147_IRQ_SCSI_DMA   (IRQ_USER+0x46)
> +#define MVME147_IRQ_SCSI_PORT  (IRQ_USER + 5)
> +#define MVME147_IRQ_SCSI_DMA   (IRQ_USER + 6)

Indeed, in all other locations where IRQ_USER was added, 0x40 was
subtracted, but these two were missed during the conversion.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

