Return-Path: <linux-kernel+bounces-348020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB3898E198
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E935285541
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041451D1728;
	Wed,  2 Oct 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olvTRvVQ"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCD1D0F73
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890035; cv=none; b=pLWrPbNUTqv+FE3RAam53WiYxz1WdDa17HYNtnb1Exk5FPn9oXKfELbGr53TuT01+Vqh8F4eIjCCpPquhdsUDIgOL/AbHDsRWaeheWGmIg5R3aHXKZbZsaXLWP5Rpt+Da5MLhIv7ilGbOdNbuO9VHpFZGmaRs4AeHtZx5IB2kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890035; c=relaxed/simple;
	bh=SocYftxUHr9w/jnN8xn7LLcrWjIlXouj2kN7OZNzzKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Apk+3I6jL3YJ+aMPsbikoKsrt9YomCMMXwU+Bkojj+bYHtq2r1SyjRcMAJOE8MEQvFdYJIIaNjbX2N/8Gc3lJHGR7dTHcSRPVcsuEkBJMqqctFOavPUOpsVA7Ui9J8+jPNpC69OWIfUKUKQ9+iUn2iAgT/Gbi7cmlWXenKVXUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=olvTRvVQ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e77a1c5ec6so46366eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727890033; x=1728494833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcpwQDqFjRc9TPBT3Ven2uPXygdgVnzrkRiUijDEusQ=;
        b=olvTRvVQnftR1PMah7Nwz3tk59+mj+w7fdYij94y10IZ27dzQTWCxZIBnST+N/O5zj
         LR0HMYnufDHaB2cLsYArsK4stA/JiHaeFHwDYC8QAii6UjQZrr7b9xrPgdY3wkjGl+4N
         aBRigAn2bf0OzPm8ZaY3BsqzZv/FpJcdjZwURM6YKtpV+rznwjUfHrCYaMtRKHjP6ZrM
         qw6C4rYnlGtF2/vQdO4uI/BvHUPWDXJjL01CRM/BnuwO8/GZ/e16tyPKPugIrLil0z00
         P6QE6+FHX0S+3z3f7S/0dinJ4s7et+w7FJJlTeCNO4TC0B0+L3VcSMw9+xWDBRY59Ep2
         YsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890033; x=1728494833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcpwQDqFjRc9TPBT3Ven2uPXygdgVnzrkRiUijDEusQ=;
        b=WN4PBaXS49u/KMK1J13ExXI5Zg2sbYrt90kEjxtM/9pggOV8kwPFCCOvAAASzcMlOz
         OftnxRuhl9+dwRWJeAog7fzCXvXPJZpDZCBKKyUIrbh92gm1sISMw4p/X9RdcIKSHLa3
         nd8z9eXlp8tfHql8gE3a/bCoMwWjpj7ZXMhjd/LcLdjX3IlIsQYjLomBYJOMHHWqsjw/
         ZYS0CXHx5EXJIMkoXRGid+Eqz0XAb2thuwea4J6f2p9g7mb/em58N1kDi1ZorGn8U0NV
         bAUeH2830ZZ8p6F1mOWCMAbDTTIfmcS9R12g1QwcqCsraLIa+UwZk75WAsAA5CsgozHW
         JSDw==
X-Forwarded-Encrypted: i=1; AJvYcCWRnQFcGz/Kg8erwu7MyuWiKSx+wsdKnashympbvgXm8jGckKg/RxHsRJ1ghAIM3Z14VLaGxQycUEs2VlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesCwnhE9eGHMb2P9wVt5TvPUbMKggzBANJOO9YOQ/nNwuvs+g
	pZ7pW+G1mXJVmobA7PtW05eNswkUuPbNdfguytyKtGal9CDGyErGWB5kA9AfVwOKUWDiKffrkeM
	ONL7KYWcQc7WhRzV33qbQFFFnh5emajbKwFk7Tg==
X-Google-Smtp-Source: AGHT+IEmChJNwDq74MTvTNe0tklYIlz3UWX3NLcXVAP16EzJl4cnkRTH/L8Z58qCVv2MT+eNH4Rjz+F9ejmfUBbLWMA=
X-Received: by 2002:a05:6870:3281:b0:287:340c:247d with SMTP id
 586e51a60fabf-287889b7a21mr2975134fac.10.1727890032660; Wed, 02 Oct 2024
 10:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com>
 <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
 <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
 <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com> <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
 <CAMj1kXHu_8Ffjznq=-9o2PCquDyoKQ8_aTHDnoGhGopgr_NUKQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHu_8Ffjznq=-9o2PCquDyoKQ8_aTHDnoGhGopgr_NUKQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 20:26:36 +0300
Message-ID: <CAC_iWjLe7r_se30QUWE5AD3RnysYsZwrKi5oMyMdRQ4+dFehfw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>, linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ard,

On Wed, 2 Oct 2024 at 19:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 2 Oct 2024 at 18:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Jeremy,
> >
> > On Wed, 2 Oct 2024 at 18:37, Jeremy Linton <jeremy.linton@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > On 10/1/24 2:19 AM, Ilias Apalodimas wrote:
> > > > Thanks, Ard
> > > >
> > > > On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >>
> > > >> (cc Ilias)
> > > >>
> > > >> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
> > > >>>
> > > >>> Currently the initrd is only measured if it can be loaded using the
> > > >>> INITRD_MEDIA_GUID, if we are loading it from a path provided via the
> > > >>> command line it is never measured. Lets move the check down a couple
> > > >>> lines so the measurement happens independent of the source.
> > > >>>
> > > >>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > >>> ---
> > > >>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
> > > >>>   1 file changed, 5 insertions(+), 4 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > >>> index de659f6a815f..555f84287f0b 100644
> > > >>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > >>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > >>> @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> > > >>>          status = efi_load_initrd_dev_path(&initrd, hard_limit);
> > > >>>          if (status == EFI_SUCCESS) {
> > > >>>                  efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> > > >>> -               if (initrd.size > 0 &&
> > > >>> -                   efi_measure_tagged_event(initrd.base, initrd.size,
> > > >>> -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > > >>> -                       efi_info("Measured initrd data into PCR 9\n");
> > > >>>          } else if (status == EFI_NOT_FOUND) {
> > > >>>                  status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
> > > >>>                                                   hard_limit);
> > > >>> @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> > > >>>          if (status != EFI_SUCCESS)
> > > >>>                  goto failed;
> > > >>>
> > > >>> +       if (initrd.size > 0 &&
> > > >>> +           efi_measure_tagged_event(initrd.base, initrd.size,
> > > >>> +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > > >>> +               efi_info("Measured initrd data into PCR 9\n");
> > > >
> > > > Back when we added this we intentionally left loading an initramfs
> > > > loaded via the command line out.
> > > > We wanted people to start using the LoadFile2 protocol instead of the
> > > > command line option, which suffered from various issues  -- e.g could
> > > > only be loaded if it resided in the same filesystem as the kernel and
> > > > the bootloader had to reason about the kernel memory layout.
> > > > I don't think measuring the command line option as well is going to
> > > > cause any problems, but isn't it a step backward?
> > >
> > > Thanks for looking at this. Since no one else seems to have commented, I
> > > will just express IMHO, that both methods are useful in differing
> > > circumstances.
> > >
> > > For a heavyweight Linux aware bootloader like grub/sd-boot the
> > > INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out
> > > out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI
> > > shell),
> >
> > I am not sure I am following on the EfiShell. It has to run from an
> > EFI firmware somehow. The two open-source options I am aware of are
> > U-Boot and EDK2.
> > U-Boot has full support for the LoadFile2 protocol (and the
> > INITRD_MEDIA_GUID). In fact, you can add the initramfs/dtb/kernel
> > triplets as your boot options, supported by the EfiBoot manager and
> > you don't need grub/systemd boot etc.
> >
> > I don't think you can do that from EDK2 -- encode the initrd in a boot
> > option, but you can configure the initramfs to be loaded via LoadFile2
> > in OMVF via the 'initrd' shell command.
> >
> > > the commandline based initrd loader is a useful function.
> > > Because, the kernel stub should continue to serve as a complete, if
> > > minimal implementation for booting Linux out of a pure UEFI environment
> > > without additional support infrastructure (shim/grub/etc). So, it seems
> > > that unless there is a reason for divergent behavior it shouldn't exist.
> > > And at the moment, the two primary linux bootloaders grub2 and sdboot
> > > are both using the INITRD_MEDIA_GUID. Given the battering ram has been
> > > successful, it isn't a step backward.
> >
> > I am not saying we shouldn't. As I said I don't think this patch
> > breaks anything. I am just wondering if enhancing EDK2 to load the
> > initramfs via LoadFile2 for more than OVMF is a better option.
> >
>
> My original intent was to phase out initrd= entirely, because it only
> worked with the block device that the kernel image was loaded from,
> and it didn't work with mixed mode.
>
> However, both issues have been fixed:
> - you can pass initrd=<device path> and if the destination supports
> file I/O, it will be used to load the initrd (provided that your
> firmware has the TextToDevicePath protocol too, as that will be used
> to convert the provided string into something the firmware
> understands);
> - while mixed mode is a hack that should disappear over time, it now
> does support initrd= too.

Ah ok, I wasn't aware of the initrd=<device path> patches and I was
assuming you still plan to deprecate it.

>
> Even though LoadFile2 is still preferred as it is simpler and
> unambiguous, I no longer see a reason to phase out initrd=.
>
> So I think this change is reasonable.

Yes

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

