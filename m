Return-Path: <linux-kernel+bounces-266624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E994038B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2A0283347
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5EBA50;
	Tue, 30 Jul 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVuYk+Cz"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5F8BE8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302669; cv=none; b=N4Nu/mNrLZQy9PQ7K1AVYEaam9AVDt9gp4eEhnRb0nsAXGQYwO8D9xa8VKIRI+g6UZI0apFktyXvNKQ20Aujv1I76HymlQWwVhqyHiXW6gHSYrJ7WsAbkDB9WuN7KXV5Z4ETYwyttw4e9u3xp0ly4MRSm0USnuP7E9Qw/s0AUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302669; c=relaxed/simple;
	bh=RaCz8kOA9gJQg1NiFgkaNmoekj+wIxT9Z0vMKD9pDIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upUtNt1tc8AvyL3NAikcLYzjrcqqWTcZpHcqIvOB6pqskhoiYNAJ/OUJvQwvA4bVyNkcXHtIPTvoa8+jcA12gl6mSpjj+RNVLI7VZqQbxxb3r968d1OEYleYYFBvPqbDro+jfocVvyRmitqHQ9l44UZ6b9LRoWlG9sMWXtu7n44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVuYk+Cz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso52756371fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722302666; x=1722907466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwOGuMZQFuaD4Dih4GXo1yBU1KI6eOWoN2V0SUGkrhA=;
        b=fVuYk+Cz6PJggxGa52hky3qyzk2h2v4KhTOnrJiSP1RMzMm4DloV4SFMntw5gatlcH
         vk8SVH6En1/P0bXDba2qa/+iaDum5NQc8vx50Bn0u7iC5+ODs7RMro9zkr9WUp4EEo6O
         l6LSx+dTAzBQ5h7rUPu7/GZ3vcHWaCrUFZmD5JOfpl/wKGHict2GSlHShv5zbOg7pf0H
         iJcRIuH8C6qvGCsStcMVfOn7/UPpVl2wB1gE8YLEDhlWGorbcnel+DtyrdtwiqLNKWeW
         Kap6XgPhrWxGarvtoh7uFCNfRcFTusm+Tj6r/GeC71Ll/oBpifNvYOzw6o403sKQ0K8v
         UjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302666; x=1722907466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwOGuMZQFuaD4Dih4GXo1yBU1KI6eOWoN2V0SUGkrhA=;
        b=ltuN+ctSagHaZWoLn6qYZvIkinguiNj47aYBHKGTYZVE6BHlg1DSm0W0eF2JTdDqhU
         z9dYFq/gOOxaWStHsuMo0EjK65Vj8wy/Xe+k3RXHHDpMgDhpG1kORNdIjBRw3WS04hxg
         MAD/1gOeN+tOOg4FqXhvhAdFJLuBudB3d5TZu2PkEVi1ZlWgvDpEosgs81yYNbQIuv5l
         7s1W9zTSYTxp1vnlbtlPH3xp9SVdNm466C/6x6mRX1mzsRQ+RUy/txjPlGxz1/iL5Mtw
         6NBvfUORj3oIen/wdEPUGWga5VYH4bvWLJdellRpYV77icqJLygCNoEEDr4wQpzjsJhG
         Q7sg==
X-Forwarded-Encrypted: i=1; AJvYcCWN1TKxbErAifzivS9wRumROehfpKPEtVfggo0qmJSRXs8hb8RP5IDTx9lyKttNNrPi86lOEYP2CQYW3MvrOzcj4lHWa1mGWZlLKaVL
X-Gm-Message-State: AOJu0Yzz6V5LS+Cdn0+xMpy/WFbbSgJ0X8NJp9xNYaORY6+oOQ8dDCxk
	2iKy/K1iyiXcKnujGmcP9Rwn+W6REaMfQ9Dh/4/9JkB7zI+SZ+RgS9RUcSoAACDlqRJOl/zLuh7
	Aor3sHol06AYZOtbnKoYe3Sqa5AY=
X-Google-Smtp-Source: AGHT+IF1hwpKTxhTsoEgwZwtX7VhDvgPFJI+bYCPYsyBy4cBr4hsvyOy1Sis3/M4HNz6LkFsS/1th3dgfBWVE87Aavs=
X-Received: by 2002:a2e:b714:0:b0:2ef:1c03:73e9 with SMTP id
 38308e7fff4ca-2f12ee2f020mr54742291fa.42.1722302665797; Mon, 29 Jul 2024
 18:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726195044.18004-1-sedat.dilek@gmail.com> <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
 <CA+icZUWUdq-xR9nOB_c_8=pfwn8J062hiurFXcrF7zvmaNg8PA@mail.gmail.com>
 <CAHk-=wiruM9sWeOM8FKvGTetiWgSaGZF31YmdzS3_s=0bw0Ekg@mail.gmail.com> <CAJM55Z82yardOi-x59TbdrXb834xq6_Nt=1DPqJC77MfM9vvHA@mail.gmail.com>
In-Reply-To: <CAJM55Z82yardOi-x59TbdrXb834xq6_Nt=1DPqJC77MfM9vvHA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 30 Jul 2024 03:23:49 +0200
Message-ID: <CA+icZUXBvA4T-3UoNt6+Jt=V8jrd2rzxgRr4Ey6czkUip=asxw@mail.gmail.com>
Subject: Re: [v2] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for
 compressed kernel image
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 1:50=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Linus Torvalds wrote:
> > On Fri, 26 Jul 2024 at 13:54, Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
> > >
> > > And when you check a diff of two of your ARM64 .config?
> > > What says COMPRESSED_INSTALL to other than the author w/o context :-)=
?
> >
> > Even without any context, I think it says "compressed install".
> >
> > Which seems sensible. Because THAT'S EXACTLY WHAT IT IS.
> >
> > Now, admittedly I would have preferred not having a config option for
> > this at all, but we have a sad historical situation of doing something
> > odd on arm (and parisc).
> >
> > The RISC-V people used to do the same, but they decided to just make
> > 'install' do whatever image was built, so they base it on a
> > combination of different config variables: CONFIG_XIP_KERNEL,
> > CONFIG_RISCV_M_MODE, CONFIG_SOC_CANAAN_K210, and CONFIG_EFI_ZBOOT.
>
> With the approach taken by RISC-V you can choose which compression you wa=
nt
> (including uncompressed) and not just gzip. For arm64 it would look somet=
hing
> like this:
>

Hi Emil,

That sounds straight-forward than discussing a single KCONFIG variable name=
.

Is that kconfig/kbuild tested?

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ae527d1d409f..a99864491703 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -234,6 +234,13 @@ config ARM64
>         select HAVE_RUST if CPU_LITTLE_ENDIAN
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> +       select HAVE_KERNEL_BZIP2 if !EFI_ZBOOT
> +       select HAVE_KERNEL_GZIP if !EFI_ZBOOT
> +       select HAVE_KERNEL_LZ4 if !EFI_ZBOOT
> +       select HAVE_KERNEL_LZMA if !EFI_ZBOOT
> +       select HAVE_KERNEL_LZO if !EFI_ZBOOT
> +       select HAVE_KERNEL_UNCOMPRESSED if !EFI_ZBOOT
> +       select HAVE_KERNEL_ZSTD if !EFI_ZBOOT

Better embed these selects in a block
if !EFI_ZBOOT
...
endif # !EFI_ZBOOT

Do you really want to use HAVE_KERNEL_UNCOMPRESSED (see below)?

x86_64 does not have XXX_KERNEL_UNCOMPRESSED.

>         select HAVE_KPROBES
>         select HAVE_KRETPROBES
>         select HAVE_GENERIC_VDSO
> @@ -2337,17 +2344,6 @@ config EFI
>           allow the kernel to be booted as an EFI application. This
>           is only useful on systems that have UEFI firmware.
>
> -config COMPRESSED_INSTALL
> -       bool "Install compressed image by default"
> -       help
> -         This makes the regular "make install" install the compressed
> -         image we built, not the legacy uncompressed one.
> -
> -         You can check that a compressed image works for you by doing
> -         "make zinstall" first, and verifying that everything is fine
> -         in your environment before making "make install" do this for
> -         you.
> -
>  config DMI
>         bool "Enable support for SMBIOS (DMI) tables"
>         depends on EFI
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index f6bc3da1ef11..b798875311aa 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -159,18 +159,21 @@ libs-y            :=3D arch/arm64/lib/ $(libs-y)
>  libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
.a
>
>  # Default target when executing plain make
> -boot           :=3D arch/arm64/boot
> +boot                                   :=3D arch/arm64/boot
> +boot-image-y                           :=3D Image

^^ boot-image-$(CONFIG_KERNEL_UNCOMPRESSED)  :=3D Image ?

> +boot-image-$(CONFIG_KERNEL_BZIP2)      :=3D Image.bz2
> +boot-image-$(CONFIG_KERNEL_GZIP)       :=3D Image.gz
> +boot-image-$(CONFIG_KERNEL_LZ4)                :=3D Image.lz4
> +boot-image-$(CONFIG_KERNEL_LZMA)       :=3D Image.lzma
> +boot-image-$(CONFIG_KERNEL_LZO)                :=3D Image.lzo
> +boot-image-$(CONFIG_KERNEL_ZSTD)       :=3D Image.zst
> +boot-image-$(CONFIG_EFI_ZBOOT)         :=3D vmlinuz.efi
>
> -BOOT_TARGETS   :=3D Image vmlinuz.efi image.fit
> +KBUILD_IMAGE :=3D $(boot)/$(boot-image-y)
> +BOOT_TARGETS :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma
> Image.lzo Image.zst vmlinuz.efi image.fit
>
>  PHONY +=3D $(BOOT_TARGETS)
>
> -ifeq ($(CONFIG_EFI_ZBOOT),)
> -KBUILD_IMAGE   :=3D $(boot)/Image.gz
> -else
> -KBUILD_IMAGE   :=3D $(boot)/vmlinuz.efi
> -endif
> -
>  all:   $(notdir $(KBUILD_IMAGE))
>
>  image.fit: dtbs
> @@ -182,13 +185,8 @@ $(BOOT_TARGETS): vmlinux
>  Image.%: Image
>         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
>
> -ifeq ($(CONFIG_COMPRESSED_INSTALL),y)
> - DEFAULT_KBUILD_IMAGE =3D $(KBUILD_IMAGE)
> -else
> - DEFAULT_KBUILD_IMAGE =3D $(boot)/Image
> -endif
> -
> -install: KBUILD_IMAGE :=3D $(DEFAULT_KBUILD_IMAGE)
> +# the install target always installs KBUILD_IMAGE (which may be compress=
ed)
> +# but keep the zinstall target for compatibility with older releases
>  install zinstall:
>         $(call cmd,install)
>
> @@ -232,11 +230,15 @@ virtconfig:
>         $(call merge_into_defconfig_override,defconfig,virt)
>
>  define archhelp
> -  echo  '* Image.gz      - Compressed kernel image
> (arch/$(ARCH)/boot/Image.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +  echo  '  Image.bz2     - Compressed kernel image
> (arch/$(ARCH)/boot/Image.bz2)'
> +  echo  '* Image.gz      - Compressed kernel image
> (arch/$(ARCH)/boot/Image.gz)'
> +  echo  '  Image.lz4     - Compressed kernel image
> (arch/$(ARCH)/boot/Image.lz4)'
> +  echo  '  Image.lzma    - Compressed kernel image
> (arch/$(ARCH)/boot/Image.lzma)'
> +  echo  '  Image.lzo     - Compressed kernel image
> (arch/$(ARCH)/boot/Image.lzo)'
> +  echo  '  Image.zst     - Compressed kernel image
> (arch/$(ARCH)/boot/Image.zst)'
>    echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)=
'
> -  echo  '  install       - Install kernel (compressed if
> COMPRESSED_INSTALL set)'
> -  echo  '  zinstall      - Install compressed kernel'
> +  echo  '  install       - Install kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
>    echo  '                  (distribution) /sbin/installkernel or'
>    echo  '                  install to $$(INSTALL_PATH) and run lilo'

Does ARM64 arch support kernel-decompression for all these compressors?

Thanks for that vital contribution and your ideas!

Best regards,
-Sedat-

