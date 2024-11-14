Return-Path: <linux-kernel+bounces-409452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7C9C8CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30254B2752D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40828E0F;
	Thu, 14 Nov 2024 14:32:06 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAC1C6BE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594726; cv=none; b=W14X8oFRj1xeO4SkAP1/Pfum+916smAflFg9bBBEUcMpH1njIhGlFnX2h0Zr+23uoWodXFTLD7Vv+efiNezEpsk54kEPU+h5lMR0DtH0Qul8yUMs7YUetFl3Pz0iMJI1uPYJVoEHEaRpoLh6Q8esBnCvmR31d9VM2pX2qeN85rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594726; c=relaxed/simple;
	bh=SfuYcuBqrPL4FoazWP67TJUK5HKz58seP9zsmZqc59E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgcGztGv6uxuluAsXUn+6hXY8v8tNP7mEzK4i1OcsmjaVkW8bwRSKyz8MZVe0wJ3UUE0a2WZ6swzeJQvWR11mE9vmsZRhOyzctUPIXFK61mXMax6TZlWgeWnNNZZmqIHXIvvhTVZsN6ldQFp7MKCgUHYuZ8XxcCI8Za3LbrNwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e30eca40dedso674500276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594723; x=1732199523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEw/QL8DjzngP6FtwkYMjBBUd+ADoH2d5hmL2oqNxQE=;
        b=qPM3agc3f6/0B6mY4Xr2798zdHubkNGIu2VYRNHubEnfkf0/K83pU7N+gqbzqQjAs9
         6Cakyy+xels3h41IN/31CeLFNSTB2Z7yrMcbtYaogAKyMcSxzP9np2RMKSG4wmv5+0WH
         Xh/6FMJdjXokMTTs+D+jtpPn3CRNfiE/Y0wO5/C+WZ/BUaKuFTe8AxpjuUtzSTT5dynX
         EMn3SQnTryEI/mW/iQyCQW/7QHT8WlFe6gI01bSkVlWwwGDxDRCdKq0SaK4kDzcmm4nk
         H8ZaIES6MKTJkqEDwewIj8VPTEdiuhEUzP4dwPIiZc+MbqETNuAGF6qS9J+bxbrRi8XT
         DJSw==
X-Forwarded-Encrypted: i=1; AJvYcCUsp2ZQ5uEoFM/DMEXOj/VZZPuRyU7e6j/mTFKYo2cF0NVvP7YcMJ/oguy0gxZVmMC7uoMDVW1dJby0ybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzId71WCR+42PeA3T27QYzBjye/hV109owTkEbJ+plOUYUWpkYE
	Whr83sfRGyJ7KvPW8KZCmqJMK4FlR/KGilHJoHVucOqJasu6P1V3voHaTHYO
X-Google-Smtp-Source: AGHT+IE2nulqMHumx/W/Lv403HhH+ZxUHLQu4zscuxMCG+0B+Wv0arFBHz38aSLBLakAqGu/89/BLA==
X-Received: by 2002:a05:690c:d05:b0:6e3:dc4:965a with SMTP id 00721157ae682-6ee43370709mr20999737b3.15.1731594722836;
        Thu, 14 Nov 2024 06:32:02 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee440709b1sm2535787b3.58.2024.11.14.06.32.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:32:02 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e30eca40dedso674461276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXo4dd2UP4rANTWDzGuLhPjqW/3wc+wNbtwWieJnrMt79nNAyVXIVGiY1WAiNPXCa3ll2zU/xVhTOtaaJo=@vger.kernel.org
X-Received: by 2002:a05:690c:3682:b0:6ea:3e6d:2b01 with SMTP id
 00721157ae682-6ee43385bf7mr20392957b3.19.1731594721950; Thu, 14 Nov 2024
 06:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114131114.602234-1-mpe@ellerman.id.au>
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2024 15:31:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBZJvVaKiWk_VaHY0ZQiaezn9Kqa0XpTXKzf0gh_rG+g@mail.gmail.com>
Message-ID: <CAMuHMdWBZJvVaKiWk_VaHY0ZQiaezn9Kqa0XpTXKzf0gh_rG+g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> CHRP (Common Hardware Reference Platform) was a standard developed by
> IBM & Apple for PowerPC-based systems.
>
> The standard was used in the development of some machines but never
> gained wide spread adoption.
>
> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
> some from Motorola? No Apple machines should be affected.
>
> All of those mentioned above are over or nearing 20 years old, and seem
> to have no active users.
>
> So remove the CHRP support. If there's interest in still supporting some
> of the machines that can be brought back from the git history.
>
> Note there are still some references to CHRP/chrp in various comments
> and some in the code, because later standards (eg. RPA, PAPR) used some
> elements of CHRP or copied the CHRP behaviour. These will need to be
> cleaned up on a case-by-case basis to either refer to newer standards or
> left as-is when that's correct.
>
> The CHRP code was copied from arch/ppc, and before that it mostly
> predates git, so the original authorship is largely lost. If anyone
> wrote any of this code and would like a CREDITS entry just let me know.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

