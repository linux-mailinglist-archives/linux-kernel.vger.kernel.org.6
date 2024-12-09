Return-Path: <linux-kernel+bounces-438013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C69E9B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A42165E92
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B4146D57;
	Mon,  9 Dec 2024 16:27:23 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4113D638
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761643; cv=none; b=NNv16fSdxqI4Sm6q+iormjTxmlVlqMl2NaPQONMeCcejf5yTk/cg48UddhvR6y2wBDMIC2cEu10ykIn1V4gjf3j87o50YdfcM14kr4MeYSOy1IRUpIL1fhDrBN5A62xQhgnMsDBnQBouUXCsg96M/PO65QCsmdH2ltndGbJcQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761643; c=relaxed/simple;
	bh=nC9hi7DObQA8Xd2weeJ23eDukyxFS1fKJy7v2IrOzi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmFLVUUuR6YuVbWrYoEjZy/tjZ1X/fIDNi4Sxfml7DlWcvqAaWOlcbVwkqYTVj08RZ/IAzM8JSfUt6MX70CnYe9koIqhcfv8vMCaH51vqYVN5LtP9vABOM4q15sS03qmrTulCUgnk4bgvvLCspLDa+ZmvKMaraIJn8Xd9ZHyS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51889930cb1so77386e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761639; x=1734366439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbIgp/7PNgwmdJb3CXsYquHn1gIukIbIKtWuEk8ZUe8=;
        b=oynJM8xNdAdq6WCB4K9hUExkITVsghLd3k8yTsF7XAcmvTEf9peRo9+OU6N9/dSDJx
         5ZPs5PKqFQpyM47uwrAMtzaBefEyHD6KhdvFrRadLmcx+zfyR3xC8s1tLULGolSS/4gv
         WR8x/9yCqHRLXzT7QJYMqayPKrs6twYxhlQKWZlAGYTVdOyq3srGzWvKSNCCDBHcWSsQ
         SZ11A7EbongQNJPiysn0ox1GcM5wrnh4KwCx0jcn0lbIn8U2Y6qu1ddmRDvvRpCBF1EH
         61dDs4J1WKWwFgKUBYs+r0G3VUQPo5UbFPkWtTq4EsqFCuYaTYw3kj6OlqMXr3ZVIYhC
         LhXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdGEqNKZwOeNA9ECKaOVXuAeeHAEhyEH7EMADiWmYeGCHBQHmUAt0ToWyi8hvSwap6CA82bSP0lt0XVp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrALBAsfc80q1/MjQZT03Kn7LwMFzJOr267K+tgHsIB0XeX+5w
	E/hpNXo4zfgENpDTjxXzDFI2CPyVCdNJ4VyAQUXaOCPd2YYZzrv28WM5kQpwXBM=
X-Gm-Gg: ASbGncuCL4vcXtoBdFUSMfel9G+FQtmlfLcNED1zY2FckIC2DgwE9Nlbg53t3Avuc+a
	H6zKcaSH0UK1aRshtDEbiId6lbvgLGTq0fmjCLFhcdSZRf/I3jiLJSQtT7lyYT0L20qzxnlBy/W
	KQ30KZgZgIvrD93x4IgsqcX1amsaJp4Hq0XY2T4VncJVGvr141/d6R7dtzWI6jvgKgA6iJ6SJ7j
	EffAOU/P3dO1xg0wzQ/9WUPraLCCsjNAoNzrDjAijvfsdZtuxOeSluPLfjC++2dZQ0au5fbfZar
	Vqck/p7F/n9q
X-Google-Smtp-Source: AGHT+IGUZWk6u5xB/iKQsuHDCGgBSmKIv5uBn/fEsulbR0r/Merm1Fjx5kepGzQhPu7sIIFUucYE4A==
X-Received: by 2002:a05:6122:278d:b0:515:ed1b:e6dd with SMTP id 71dfb90a1353d-51887fcebd6mr1835855e0c.0.1733761639040;
        Mon, 09 Dec 2024 08:27:19 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51885a635aasm60577e0c.39.2024.12.09.08.27.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:27:17 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afe70b41a8so600062137.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:27:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUulZeSa1gVxOTMeieFxVFKXWaAHUAzWTU/8/p4O1f/IPVjDZhmUeLstRX+P+p/LDVdYglmEfQMknyaisI=@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:4af:c58f:4550 with SMTP id
 ada2fe7eead31-4b11608da9emr1985151137.7.1733761637670; Mon, 09 Dec 2024
 08:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204162128.25617-1-dpenkler@gmail.com> <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
 <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
In-Reply-To: <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Dec 2024 17:27:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVsmNqZhqxPu1iMkZUqyGUQqyY1ae01JAkE1-AQbiu5mw@mail.gmail.com>
Message-ID: <CAMuHMdVsmNqZhqxPu1iMkZUqyGUQqyY1ae01JAkE1-AQbiu5mw@mail.gmail.com>
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dave Penkler <dpenkler@gmail.com>, gregkh@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Mon, Dec 9, 2024 at 5:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> On 12/9/24 08:01, Geert Uytterhoeven wrote:
> > On Wed, Dec 4, 2024 at 5:21=E2=80=AFPM Dave Penkler <dpenkler@gmail.com=
> wrote:
> >> These drivers cast resource_type_t to void * causing the build to fail=
.
> >>
> >> With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsign=
ed
> >> int which cannot be cast to a 32 bit pointer.
> >>
> >> Disable these drivers if X68_PAE is enabled
> >>
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >> Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142=
da@roeck-us.net/
> >> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> >> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporatio=
n GPIB driver")
> >> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> >> Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB drive=
r")
> >> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/staging/gpib/Kconfig
> >> +++ b/drivers/staging/gpib/Kconfig
> >> @@ -50,6 +50,7 @@ config GPIB_CEC_PCI
> >>          tristate "CEC PCI board"
> >>          depends on PCI
> >>          depends on HAS_IOPORT
> >> +       depends on !X86_PAE
> >
> > !CONFIG_PHYS_ADDR_T_64BIT, to match the definition of phys_addr_t?
>
> That would be wrong. It would disable the code for all 64-bit builds.

Oops...

    depends on 64BIT || !PHYS_ADDR_T_64BIT

Assuming the driver actually works on 64-bit?
Perhaps people keep an old i386 to control their GPIB gear?

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

