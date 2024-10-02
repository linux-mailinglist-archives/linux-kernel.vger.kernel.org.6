Return-Path: <linux-kernel+bounces-348087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F389998E263
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A59B24367
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F3212F0E;
	Wed,  2 Oct 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYUMFbto"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7201D0BA2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893536; cv=none; b=HJW6+sUBXa/7YAg2DDLuAXwV5EmZ9vTt9OeFUhb7MJO6IpqAHH7U6JnbTyoaL9WdA4Js2HCS9ELYBpiK7VDkqx51LxZtlZcKxQUp/qNfq+NRgidWa4qykV9h29WYdHBrVjJwdn8vDLwbL5KsFglLIYT08jC9kodcdtjOLgnOlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893536; c=relaxed/simple;
	bh=BHmoF2zBqZK9UZgRUbeipEcydPMBAFNxUI1Auyj0jkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdPrpU3cdVPkrKQtyg9ADUnkVoJBMybVM8a6eU4TxtBjCHtNf6XPiwi48XwBO5ZJ/QYK6jumIMtjCbNd5dlt64DdDxb4aXC3bkcvC6XGrnc4hp9+P4OjK7KgBQvHBh/ETNevx5p/okHbZ2SfZ2YRiNO4tlFUMoS4r/YalORCsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYUMFbto; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e57b7cac4fso81530eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727893533; x=1728498333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O2k7/XKBucv/PWOD7cpF5e06OQdF8fcXFYcK2aIffFk=;
        b=RYUMFbtoH8qpYVXUVewhEelf7TO/rcmVuljJzd4pL6rDZznjxaokenYmlsFzFwahM0
         SGPCC9tuMgPXT62nmyfNoEODf+kk/ORvEaGz68xOQdJ6COC+isLYFcXXTJeQvzKsStWg
         k7LKSSQSsvR7F5SGv7PFYlVPqxhM5HJLFmabNzBnUZqBZUje9z6UzRw3/CuoImEkuPqG
         hKmdaZHpoh4P81lih8QIt/7I7v4St6pUVbzlm1cJ7JIY85C4HsHOqytmMgm6QNAbBMPF
         DCW/+elEDXiz6CeinbzyR6fWn0/8C6PAwTvwt819p7998w+uedeJhYZFjwiJGziUoZ2p
         7q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893533; x=1728498333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2k7/XKBucv/PWOD7cpF5e06OQdF8fcXFYcK2aIffFk=;
        b=XX+gzX2cOBZ9efsekNROl6GqLjbP6RGIiPxoExYLzYzmgL9IC1sBp0lOcnhZxLyCrZ
         6F/8yqmZSV8gQSteeTXg0Yh60NLLiI3gPE9Z5hTZA4MQG5Xs6ZSfxfZrhjwpAHikdWJY
         1Jz5zlqsMA5hC4mf+KXN9yFgkZh/hnbF95ZAIfbUo+XoBJevUHw56iFmTY0vwD6HBOHK
         ijsSkRfbcTVkx/dj3W+OXplc8LnUuo5Zr2kIW3tZDyM6DgW3uT5rTM2f3fiePmvuf32V
         tyZAearXYiNH0qEu6ZmQu0Pv+KH3eShkEdnpRO6aZ9XW+DnS9DknOiOFIqSfp6PSwLE9
         d2fg==
X-Forwarded-Encrypted: i=1; AJvYcCVIL/Aq+UDVXFpNALkL74p9Ce6wl2gHeqqbQ0xa79bpIox/QIQBv9EmuVeCur5krzpoNxSg9IN22bmKDz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymV+Owi3CibKMfe8kOuf7mfJLwxGFtp0ev+Qf7WxcLaI9bn9Iw
	2SCOX4l6wQl1I9doXMoHgF7fFMk8YuE+wokOSFx73IFK4KZbg0stEWyfTF0AvR6tNTNPswXznB9
	rSuQOUbfcDBxvsiibqR4fgkjiEsxQjFHU+Paco/B6V3Nty7Lljfc=
X-Google-Smtp-Source: AGHT+IEVCQ6FnCeUhcJQKx1EAtHfUEFNQxKU88PuK/IddOkSPuuYGzI0CT2ThdH47oynMmlxyfUrui9MKDwyeAYgJ+4=
X-Received: by 2002:a05:6871:7824:b0:270:5f17:b34 with SMTP id
 586e51a60fabf-28788a68d74mr2803593fac.11.1727893533412; Wed, 02 Oct 2024
 11:25:33 -0700 (PDT)
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
 <c0121455-6c46-468e-a386-6be2180dd7a3@arm.com>
In-Reply-To: <c0121455-6c46-468e-a386-6be2180dd7a3@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 21:24:56 +0300
Message-ID: <CAC_iWjKB479Wbg01bgbo46rM_OyNzDmxqH9OkusNr8+8GafcPQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeremy,

[...]

> >>>
> >>> Back when we added this we intentionally left loading an initramfs
> >>> loaded via the command line out.
> >>> We wanted people to start using the LoadFile2 protocol instead of the
> >>> command line option, which suffered from various issues  -- e.g could
> >>> only be loaded if it resided in the same filesystem as the kernel and
> >>> the bootloader had to reason about the kernel memory layout.
> >>> I don't think measuring the command line option as well is going to
> >>> cause any problems, but isn't it a step backward?
> >>
> >> Thanks for looking at this. Since no one else seems to have commented, I
> >> will just express IMHO, that both methods are useful in differing
> >> circumstances.
> >>
> >> For a heavyweight Linux aware bootloader like grub/sd-boot the
> >> INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out
> >> out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI
> >> shell),
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
>
> Oh, I guess the shell is a bad example because I was unaware that there
> was a initrd option in it now. I'm buying into the boot loader/boot
> manager distinction, where the manager is largely unaware of the target
> OS's specific needs (in this case, having the initrd GUID set).

Yes, FWIW what was added in U-Boot needs to be aware of the
Linux-specific GUID, but as far as the EFI BootOptions defined in the
Boot manager, we aren't violating anything in the EFI spec. On the
contrary, we use the _EFI_LOAD_OPTION exactly as the spec describes.

>
>
> >
> >> the commandline based initrd loader is a useful function.
> >> Because, the kernel stub should continue to serve as a complete, if
> >> minimal implementation for booting Linux out of a pure UEFI environment
> >> without additional support infrastructure (shim/grub/etc). So, it seems
> >> that unless there is a reason for divergent behavior it shouldn't exist.
> >> And at the moment, the two primary linux bootloaders grub2 and sdboot
> >> are both using the INITRD_MEDIA_GUID. Given the battering ram has been
> >> successful, it isn't a step backward.
> >
> > I am not saying we shouldn't. As I said I don't think this patch
> > breaks anything. I am just wondering if enhancing EDK2 to load the
> > initramfs via LoadFile2 for more than OVMF is a better option.
>
> There is a separation of concerns argument here. People regularly
> complain about firmware implementations tuned for windows, but making
> the FW aware of this GUID is doing the same thing for Linux.
> So, IMHO
> that should be avoided, rather assuring the firmware is made as OS
> agnostic as possible, and the OS specifics are moved into the OS boot
> loader, one of which is this stub. It would make more logical sense to
> have the stub set the GUID from built in command line defaults. To be
> clear, i'm not suggesting that.

I get the separation point but ....
If you do it the other way around you *force* people to use specific
OS loaders that implement OS-specific protocols. And the EFI stub is
not the problem here nor are distros that use such loaders. However,
vertical distros for embedded boards which don't need all the added
complexity have a reasonable way out.

Anyway, since Ard doesn't plan to deprecate initrd=, the patch is
reasonable, I have no objections

Thanks
/Ilias

>
>
>
>

