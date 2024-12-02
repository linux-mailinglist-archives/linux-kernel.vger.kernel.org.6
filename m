Return-Path: <linux-kernel+bounces-427498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC19E0218
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E1328274B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4B1FE474;
	Mon,  2 Dec 2024 12:25:33 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FF1FC7C5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142333; cv=none; b=qXrI/Jf0hgeVnMcmemZu2JaUVEDBoJtyGP12E4+lXl0GDhkJE2EkFczUIVOBhzf+guuHtKTzxDKRrCo7VQNemAYyx4Ntd62BUsFDMMjA6Xik1O/+dgwqga20kkcyxaYmpdy2D2OpY3Ra43L6NVJVOh6GFqlRlA5uxY/GmqSG530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142333; c=relaxed/simple;
	bh=MH3PpIEAJXYHjbdbUJifQIPoYamck30BgsO8TkxHof8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0ATb7YhknPyA5GVMWAZK7lX39Cpyv0jBI5ls7A35F95173WpVvn8wqOsmgypQbopHUXJXr70H6PMUweKKmwhdfb4X4NCnwF4xbk2MDVUXYBjWTMVsKQ0CcPEUkQYOmTJWPrZMuJQ05dOT1L3NdbvVMipdHr4LJ9SFQSHrLMJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea462a98b9so2118723b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733142329; x=1733747129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHVQETbyFyjqaJ8sBP7gubM1/yZ2n+R3JRCiOlETrzk=;
        b=Rl1LDY25kcYNpWnrKcLV/gaQKy5afLqkVbMXeGwE4nxcTeFw/TQp06uEvebw3oxh/g
         XMm9uqk1gPVNWQXzFShK8fqtd00nIiBEi4sblZ1B2Avo03LmySXqlJ8sFCgasDsO5+K5
         S73lsq4xnQcaSw/y7u+UAU0iCgwEGqhmm/o/BEPoANvXC/TNx1CFi+a3h86+Bfoa4fw4
         riEE9gCSe5zxqU6FYnij/006dQ9cUCcyyOeHtkT9hmMOCUIG7CUz++9JM2Q5z2tiSchD
         Oy8QDHXbecP+7z0QQWPpPHnqvCeMNP+7hGKhb5IXyFqAMn9uwd0EszXiWII998QUJRis
         5t6A==
X-Forwarded-Encrypted: i=1; AJvYcCW2eAwO6WqOxuaY8Z+wzD/q+tFfxaroT1zEePpj6h6S4B3qu1oUsWl57eLZNr94VNXtsgVaRHeKM5XeZxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HLcsYODl22vR4qjFv5D+mKi3d2P3shZpoDEO9+IWglgckWzG
	ENLLIDlz8Y9G1V2wiwzuZ6kT0ZVOSMoIhwkwmMLXhvLro/ewRC3bACok6lP1
X-Gm-Gg: ASbGncv6JgCH2QRLQbQIFQ+IcFVMfm8aFuF+ppi9AkDzqGxRvRIqJc4Yq73jxbCxOjZ
	+m2G5HoIJByR3A9CdSOV2BtJ+9exd9jJ5QxKsDaddJI3Uva1k9vYHTuL+qGdVSVu6Kt+4ArDypM
	77PYc1FqjFUvd1EKBzHOYuCvQU/spBiFJINtj7qX2oGwa+7AM9TETE6tnppiTeyl3apLzPRdCsu
	8prVVztf1u9bUosFhKcIkzGvesmf/7eXDTBaLffUGxNnULFemEMo/3//8ypqGnBF7Fk75GzEGx7
	eN1X/7gc9cLR3pwc
X-Google-Smtp-Source: AGHT+IFOxGuH6TOT0G0rMBiAb7QJMe7dVdpcWva4k6wnP09Nb8XvxvsVomWOqc0nunedQODa+3cnlg==
X-Received: by 2002:a05:6808:1443:b0:3ea:63e2:1aa9 with SMTP id 5614622812f47-3ea6db7d39cmr17990424b6e.7.1733142329510;
        Mon, 02 Dec 2024 04:25:29 -0800 (PST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a311a29sm2261232eaf.7.2024.12.02.04.25.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 04:25:28 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea696c4dcaso2243329b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:25:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyZyhLoCJmuk9qPqGV9w37fsl3hGLuHUfFVOJIkI2Auon/4HElgfMZ2KrgnWE++YmU1vzmuYDR795/HiA=@vger.kernel.org
X-Received: by 2002:a05:6359:4584:b0:1ca:967a:3103 with SMTP id
 e5c5f4694b2df-1cab16a8e20mr743731555d.23.1733142326680; Mon, 02 Dec 2024
 04:25:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-gpib-tnt4882-depends-on-has_ioport-v1-1-033c58b64751@kernel.org>
In-Reply-To: <20241123-gpib-tnt4882-depends-on-has_ioport-v1-1-033c58b64751@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Dec 2024 13:25:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOib-1DGZ=1wtNkMXocK1vtTN=s41J+Vh3uD56_MSEEw@mail.gmail.com>
Message-ID: <CAMuHMdXOib-1DGZ=1wtNkMXocK1vtTN=s41J+Vh3uD56_MSEEw@mail.gmail.com>
Subject: Re: [PATCH] staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Penkler <dpenkler@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 9:03=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> After commit 78ecb0375685 ("staging: gpib: make port I/O code
> conditional"), building tnt4882.ko on platforms without HAS_IOPORT (such
> as hexagon and s390) fails with:
>
>   ERROR: modpost: "inb_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko]=
 undefined!
>   ERROR: modpost: "inw_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko]=
 undefined!
>   ERROR: modpost: "nec7210_locking_ioport_write_byte" [drivers/staging/gp=
ib/tnt4882/tnt4882.ko] undefined!
>   ERROR: modpost: "nec7210_locking_ioport_read_byte" [drivers/staging/gpi=
b/tnt4882/tnt4882.ko] undefined!
>   ERROR: modpost: "outb_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko=
] undefined!
>   ERROR: modpost: "outw_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko=
] undefined!
>
> Only allow tnt4882.ko to be built when CONFIG_HAS_IOPORT is set to avoid
> this build failure, as this driver unconditionally needs it.
>
> Fixes: 78ecb0375685 ("staging: gpib: make port I/O code conditional")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, this fixes my Sun3+allmodconfig build.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

