Return-Path: <linux-kernel+bounces-345375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B698B561
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58125B2111B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712DA1BD4E2;
	Tue,  1 Oct 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sT53d+2b"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FECC1BD009
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767237; cv=none; b=sU11q7Z68LHTWWpI3dGOepNOcb9B9uqSOyzGZd7ECS/E7Iyl8CQns/Iici17r9ENfvTboVCn16JQJ9NgtiTUalPQ7cKxJFkOFpfpDH5+9cibLNPYi95MegzrD237kawfEhJdyTeFSNytzLMVRWMXyb4OAbN2xUGrtKO2MafWY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767237; c=relaxed/simple;
	bh=5h8Z9+BACu6Y3g4BqrqeNxuHtGeeYVN06us7lRCHW7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWGPe6kqRPnYlz6EUzLY7h4mT7uCjj+i7amVY0oMl7dwNmOsiBqrHPFgiiGJzCKYoVKCmSFDYIo3rZGmEKLvDG1ut4Wg4HDRq5kJN7wggVAy5vwcyNcZhhBW3etu3NLJR/yo2yvf/nLxztg3GFGiAKQYafwmtHkQgTEuzZNsXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sT53d+2b; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso4324228a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727767235; x=1728372035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UrfZZcBE4IBwNjE75QjsQfrwHNd7APgRNgH7YZ+uNQ0=;
        b=sT53d+2b4wl66gVVGo1dztMu2nXjNp696yj8APAPs5pJ36PggldLgoxXmCF6K05yMi
         sq1pReyhGKgWg/4U81uPIA88HLBvYc2M+9vMsFukzcOtsLS9gdFU03e7wW6p+r/UUxpK
         pdrC2/63rTItz6pKT0NP8kaOFAEe0nGYra8lrrKgNc53eKQ1WiCn7EO1EVwtUOYm/gex
         uK60qqfrbGe7flCIq5dkgbH662O/xUxnKPC0QkMjUXRvdY+b/8BgPHn3wVDSGzps6+cS
         iKrXr6/AN/h9Ri/sg1DOjgoUUV0KaMbyBhh4Ol0dT90BwAE7y0UqPx1o3y8JQ7za6yya
         SKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727767235; x=1728372035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrfZZcBE4IBwNjE75QjsQfrwHNd7APgRNgH7YZ+uNQ0=;
        b=N/UqyxNTW9gGjDjGzhIyWCQQ099h8jqpH0NbBuLtgncCg335lEsEbW0YEGrXz3XfsS
         1qf8SNCusP0UYX4+l9vbRz3SiP4QHXE70Lp/LIswUZxdHopM6OiOLLRXLqKnMkt4ECAv
         xlPsYRgQs0m+rBMajG2ehzZ3hPSOGbRRNDHLuINGY27/MoVn5Zxl5m//fYnyaRIZic3y
         jJ+8U16L6jJVrAz5xea9Q5zQ6asKC9htoqZGyloEcl4Nm8E7WJ/monnYLMKnihvUGpS6
         OfsrT+yzZtvbAmTwVLfZ6pPe+BOInDptVmfT9OS7S/C8c7wXOFdOsHWhxG0U06D0cfnl
         GYEg==
X-Forwarded-Encrypted: i=1; AJvYcCVkwI6IiMajuvOedi/G9Q9STQm1R8B1+YFuDzge5FOquEE6Fj780FngANJkrwfm6+krTXGOVyG/jEbIoE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYElWvyWPg60VwU8QySEgTvvz7I4YqJv7NYT33iSDF5jrJh+hG
	ivBDhetAy2zuAFctDAP8XxOZdCRLw4bcYMQguHM5DauWE3+g6/dvyzk6QCmiCm5mi7mzR5EFcXr
	OxmfUNrGJpLKteOOEXbrcRm4T38eVTU+DaFHbn5tDQ+TBL1J2
X-Google-Smtp-Source: AGHT+IGn8cW3SYdd4w+T6U3zSQ2meHeHsO/ArsiB4LHjAKN+D9s9kXmEsbXtdSFt9b/qhWf0WXYGZa6s56q0/kV5jmo=
X-Received: by 2002:a05:6a21:3389:b0:1d4:fc75:8d48 with SMTP id
 adf61e73a8af0-1d4fc758d9fmr23325457637.3.1727767235462; Tue, 01 Oct 2024
 00:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com> <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Oct 2024 10:19:59 +0300
Message-ID: <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"

Thanks, Ard

On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Ilias)
>
> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >
> > Currently the initrd is only measured if it can be loaded using the
> > INITRD_MEDIA_GUID, if we are loading it from a path provided via the
> > command line it is never measured. Lets move the check down a couple
> > lines so the measurement happens independent of the source.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index de659f6a815f..555f84287f0b 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >         status = efi_load_initrd_dev_path(&initrd, hard_limit);
> >         if (status == EFI_SUCCESS) {
> >                 efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> > -               if (initrd.size > 0 &&
> > -                   efi_measure_tagged_event(initrd.base, initrd.size,
> > -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > -                       efi_info("Measured initrd data into PCR 9\n");
> >         } else if (status == EFI_NOT_FOUND) {
> >                 status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
> >                                                  hard_limit);
> > @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >         if (status != EFI_SUCCESS)
> >                 goto failed;
> >
> > +       if (initrd.size > 0 &&
> > +           efi_measure_tagged_event(initrd.base, initrd.size,
> > +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > +               efi_info("Measured initrd data into PCR 9\n");

Back when we added this we intentionally left loading an initramfs
loaded via the command line out.
We wanted people to start using the LoadFile2 protocol instead of the
command line option, which suffered from various issues  -- e.g could
only be loaded if it resided in the same filesystem as the kernel and
the bootloader had to reason about the kernel memory layout.
I don't think measuring the command line option as well is going to
cause any problems, but isn't it a step backward?

Thanks
/Ilias
> > +
> >         status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
> >                              (void **)&tbl);
> >         if (status != EFI_SUCCESS)
> > --
> > 2.46.1
> >

