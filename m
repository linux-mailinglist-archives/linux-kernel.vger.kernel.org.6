Return-Path: <linux-kernel+bounces-556536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B1A5CB79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09231893E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAED26158C;
	Tue, 11 Mar 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhBQMdF9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05026157C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712358; cv=none; b=A7mxGVD5yTGXeEYgnMpNIlhbH7gm8UHrV6FHTMkTVc9hqy6ho1jxCD7+KQTd4hx71yzLkTDnqUNNbVyMF4L73Pr/jrcljVokNrsc01vl2cba2Y6u0Q3r61XksQPSPouCMWXBVPL1kaH2X+j0hB2UZlTaAqkAObX8wrA8lNnrbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712358; c=relaxed/simple;
	bh=Kxrawuzb4BFgf9aq26SAU4jjKNmS3pqCwyCxaidubj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b8yqqYqGTNNaP/kgemnXbfaFr1ucEkp5dSn9uvzv3kr3jaAUxaHDv2HLcc/vU4ztNhtYBjQQEhI9b9EizvmGloSt5t3hWlCXom71KQUNK84riP/F2xyIBusatyj2zMb+Y+Ag1SpjOCjlvpkXZYOUozB9S8pWEaz+gFmh6iF6KgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhBQMdF9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741712353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BPrX/3i7B8WQ59BDJo83O4/lZ+88fFfKiRl6URWuaA=;
	b=dhBQMdF9QNcOnCtXgIHQO7/8d+SvOBpJF7i7d85YnO9V/xlaXXYwhqhLR5Vwa6DrVAjTW8
	HhxO2qH/sFRzvrRImZT9jxSF7XetfAq0YyZqOMfDR1LnJW/aP7rc/Bk/DlAmxRWagaYoJj
	ZbxkoqS9ByKafS+60bXj+m/qPupXrLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-f4pu3KGrMOu_oNkqg7CTgg-1; Tue, 11 Mar 2025 12:59:12 -0400
X-MC-Unique: f4pu3KGrMOu_oNkqg7CTgg-1
X-Mimecast-MFC-AGG-ID: f4pu3KGrMOu_oNkqg7CTgg_1741712351
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3933ab5b1d5so564134f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712351; x=1742317151;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BPrX/3i7B8WQ59BDJo83O4/lZ+88fFfKiRl6URWuaA=;
        b=sG836BBKdxkbXSc6Pv5SWHzCABeTZJdI5HUIjSldZ1mBz98bQRt9qSmWiS+z2YxU/+
         hyba+C7PGvfz3iCix8SvTZywJswGA0cM6XLDjjg7djQKWFJ76TDMawsKtrisVglCdnGB
         oIOQ3GH8bI2T/6UaoRiK7n7GflDZ5uTdNIwe0n8erVYA8YZBh1GQVCVUe9QDGOmHyG/8
         6+1PuoN1LDpcx9h3Z2UH4tnUp6sjX+4R6EHOur1ikwOBa+uIr1IONOxaAnAIHEh7pZRi
         rbzGUz6swsm0d+3q+g+0w//7M4VarYr/Yf89gHoJyduUVdLkZaOQZRI1s3l8w5R1hYPl
         nBeA==
X-Forwarded-Encrypted: i=1; AJvYcCU6S1n2IUx42AMycixfDpiuVfETG9wdsWMdKH8HdQrCIG6jRasB/XxH6u2+ONwkDbwqA3y+vqd/gsYeVuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeueShvYoEk8DpK/RQsEJ+NWw/saukUhSTaW0tV67EKJdSPT68
	Sl3s2yh140AhuQAmv6aL9XuwB6s7+zbWSj0kVb+wo8mQ9V7vlCgyYClMEjA2ajoi38fgvCMMhxR
	mzS9Ldm7GyU50DM88pr8hq+d/dv+5XnpN65Rnx7Cw5Vo+ZYNqkftRb5rRGKu/Bg==
X-Gm-Gg: ASbGncsWa4esf8dfZTeSIfYg/i80YTqAIyPShBbkYuRB2X/0UNLWtgyY2xahuwl205w
	tsh4CfSi5siGpry0ftopiyp5sGZZNXOqzMuZVL9sLEGJPZmUMtAyF3Q3vzqPq/3SEqNLYZj1xd1
	Fc6dBbHn6g+qmCLvSoXeclaA9No8MNpVczBC1pwxfzRcKw42fF6rht5DwuU1TlRSh59fvD50pjp
	lvmgD7cMWgAbt5v6wBi0Kx7dds6Q5XyA/JE3/SVcKLoZYYH54ncrQus+tTZLyGO+D4KgJimzGFA
	CzT/3Vt9ZLU=
X-Received: by 2002:a5d:64c3:0:b0:391:2932:e67b with SMTP id ffacd0b85a97d-39132dacfdbmr18967111f8f.35.1741712350841;
        Tue, 11 Mar 2025 09:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFthIkbIza4asy8rbMgye5BDrJXoQTmIsJn6D/IMOoIcmgMxFtoxcwjFBwF1vhjSSm/3R/XiQ==
X-Received: by 2002:a5d:64c3:0:b0:391:2932:e67b with SMTP id ffacd0b85a97d-39132dacfdbmr18967090f8f.35.1741712350383;
        Tue, 11 Mar 2025 09:59:10 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c101febsm18182505f8f.81.2025.03.11.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:59:09 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Gerd Hoffmann <kraxel@redhat.com>, Juergen Gross
 <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>, Paul Durrant
 <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH resend] x86/boot: Drop CRC-32 checksum and the build
 tool that generates it
In-Reply-To: <20250307164801.885261-2-ardb+git@google.com>
References: <20250307164801.885261-2-ardb+git@google.com>
Date: Tue, 11 Mar 2025 17:59:08 +0100
Message-ID: <87bju7o65f.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb+git@google.com> writes:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> Apart from some sanity checks on the size of setup.bin, the only
> remaining task carried out by the arch/x86/boot/tools/build.c build tool
> is generating the CRC-32 checksum of the bzImage. This feature was added
> in commit
>
>   7d6e737c8d2698b6 ("x86: add a crc32 checksum to the kernel image.")
>
> without any motivation (or any commit log text, for that matter).

Doing some history digging, it seems this was done for Xen:
https://lore.kernel.org/lkml/1202936100-30859-1-git-send-email-ijc@hellion.org.uk/T/#m263fdcf0ff3f31ca8e5cd619aa81c7735fa8be91

Let me Cc: a few Xen folks for visibility.

>  This
> checksum is not verified by any known bootloader, and given that
>
> a) the checksum of the entire bzImage is reported by most tools (zlib,
>    rhash) as 0xffffffff and not 0x0 as documented,
> b) the checksum is corrupted when the image is signed for secure boot,
>    which means that no distro ships x86 images with valid CRCs,

Note that at least Fedora/RHEL/... distros ship keyless HMAC hash
alongside vmlinuz binary, e.g. on my Fedora40:

$ cat /boot/.vmlinuz-6.12.6-100.fc40.x86_64.hmac
19aec080fbd05c5de42db486653a5d9e9d69b59ac8d216ea89850ccf1f538c08ff4ada450989ddf1be81e23fd3c99253939d0a2153d3fd270cc1ed561c04294e  vmlinuz-6.12.6-100.fc40.x86_64

and this is created _after_ SB signing. AFAIU, the need for this is
coming from FIPS requirements; this makes me wornder if the CRC-32 is an
early implementation of the same thing.

>
> it seems quite unlikely that this checksum is being used, so let's just
> drop it, along with the tool that generates it.
>
> Instead, use simple file concatenation and truncation to combine the two
> pieces into bzImage, and replace the checks on the size of the setup
> block with a couple of ASSERT()s in the linker script.
>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/arch/x86/boot.rst        |  10 -
>  arch/x86/boot/Makefile                 |   7 +-
>  arch/x86/boot/compressed/vmlinux.lds.S |   3 +-
>  arch/x86/boot/setup.ld                 |   2 +
>  arch/x86/boot/tools/.gitignore         |   2 -
>  arch/x86/boot/tools/build.c            | 247 --------------------
>  6 files changed, 5 insertions(+), 266 deletions(-)
>
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 76f53d3450e7..77e6163288db 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -1038,16 +1038,6 @@ Offset/size:	0x000c/4
>    This field contains maximal allowed type for setup_data and setup_indirect structs.
>  
>  
> -The Image Checksum
> -==================
> -
> -From boot protocol version 2.08 onwards the CRC-32 is calculated over
> -the entire file using the characteristic polynomial 0x04C11DB7 and an
> -initial remainder of 0xffffffff.  The checksum is appended to the
> -file; therefore the CRC of the file up to the limit specified in the
> -syssize field of the header is always 0.
> -
> -
>  The Kernel Command Line
>  =======================
>  
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9cc0ff6e9067..8589471b65a1 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -35,7 +35,6 @@ setup-y		+= video-vesa.o
>  setup-y		+= video-bios.o
>  
>  targets		+= $(setup-y)
> -hostprogs	:= tools/build
>  hostprogs	+= mkcpustr
>  
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include \
> @@ -61,11 +60,9 @@ KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>  $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
>  
>  quiet_cmd_image = BUILD   $@
> -silent_redirect_image = >/dev/null
> -cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
> -			       $(obj)/zoffset.h $@ $($(quiet)redirect_image)
> +      cmd_image = cp $< $@; truncate -s %4K $@; cat $(obj)/vmlinux.bin >>$@
>  
> -$(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
> +$(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,image)
>  	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
>  
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..48d0b5184557 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -48,8 +48,7 @@ SECTIONS
>  		*(.data)
>  		*(.data.*)
>  
> -		/* Add 4 bytes of extra space for a CRC-32 checksum */
> -		. = ALIGN(. + 4, 0x200);
> +		. = ALIGN(0x200);
>  		_edata = . ;
>  	}
>  	. = ALIGN(L1_CACHE_BYTES);
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 3a2d1360abb0..e1d594a60204 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -45,6 +45,8 @@ SECTIONS
>  
>  		setup_size = ALIGN(ABSOLUTE(.), 4096);
>  		setup_sects = ABSOLUTE(setup_size / 512);
> +		ASSERT(setup_sects >= 5, "The setup must be at least 5 sectors in size");
> +		ASSERT(setup_sects <= 64, "The setup must be at most 64 sectors in size");
>  	}
>  
>  	. = ALIGN(16);
> diff --git a/arch/x86/boot/tools/.gitignore b/arch/x86/boot/tools/.gitignore
> deleted file mode 100644
> index ae91f4d0d78b..000000000000
> --- a/arch/x86/boot/tools/.gitignore
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -build
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> deleted file mode 100644
> index 10311d77c67f..000000000000
> --- a/arch/x86/boot/tools/build.c
> +++ /dev/null
> @@ -1,247 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *  Copyright (C) 1997 Martin Mares
> - *  Copyright (C) 2007 H. Peter Anvin
> - */
> -
> -/*
> - * This file builds a disk-image from three different files:
> - *
> - * - setup: 8086 machine code, sets up system parm
> - * - system: 80386 code for actual system
> - * - zoffset.h: header with ZO_* defines
> - *
> - * It does some checking that all files are of the correct type, and writes
> - * the result to the specified destination, removing headers and padding to
> - * the right amount. It also writes some system data to stdout.
> - */
> -
> -/*
> - * Changes by tytso to allow root device specification
> - * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
> - * Cross compiling fixes by Gertjan van Wingerde, July 1996
> - * Rewritten by Martin Mares, April 1997
> - * Substantially overhauled by H. Peter Anvin, April 2007
> - */
> -
> -#include <stdio.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <stdarg.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/mman.h>
> -#include <tools/le_byteshift.h>
> -
> -typedef unsigned char  u8;
> -typedef unsigned short u16;
> -typedef unsigned int   u32;
> -
> -/* Minimal number of setup sectors */
> -#define SETUP_SECT_MIN 5
> -#define SETUP_SECT_MAX 64
> -
> -/* This must be large enough to hold the entire setup */
> -u8 buf[SETUP_SECT_MAX*512];
> -
> -static unsigned long _edata;
> -
> -/*----------------------------------------------------------------------*/
> -
> -static const u32 crctab32[] = {
> -	0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419,
> -	0x706af48f, 0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4,
> -	0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07,
> -	0x90bf1d91, 0x1db71064, 0x6ab020f2, 0xf3b97148, 0x84be41de,
> -	0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7, 0x136c9856,
> -	0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9,
> -	0xfa0f3d63, 0x8d080df5, 0x3b6e20c8, 0x4c69105e, 0xd56041e4,
> -	0xa2677172, 0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,
> -	0x35b5a8fa, 0x42b2986c, 0xdbbbc9d6, 0xacbcf940, 0x32d86ce3,
> -	0x45df5c75, 0xdcd60dcf, 0xabd13d59, 0x26d930ac, 0x51de003a,
> -	0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423, 0xcfba9599,
> -	0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
> -	0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d, 0x76dc4190,
> -	0x01db7106, 0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f,
> -	0x9fbfe4a5, 0xe8b8d433, 0x7807c9a2, 0x0f00f934, 0x9609a88e,
> -	0xe10e9818, 0x7f6a0dbb, 0x086d3d2d, 0x91646c97, 0xe6635c01,
> -	0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e, 0x6c0695ed,
> -	0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
> -	0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3,
> -	0xfbd44c65, 0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2,
> -	0x4adfa541, 0x3dd895d7, 0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a,
> -	0x346ed9fc, 0xad678846, 0xda60b8d0, 0x44042d73, 0x33031de5,
> -	0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa, 0xbe0b1010,
> -	0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
> -	0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17,
> -	0x2eb40d81, 0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6,
> -	0x03b6e20c, 0x74b1d29a, 0xead54739, 0x9dd277af, 0x04db2615,
> -	0x73dc1683, 0xe3630b12, 0x94643b84, 0x0d6d6a3e, 0x7a6a5aa8,
> -	0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1, 0xf00f9344,
> -	0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
> -	0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a,
> -	0x67dd4acc, 0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5,
> -	0xd6d6a3e8, 0xa1d1937e, 0x38d8c2c4, 0x4fdff252, 0xd1bb67f1,
> -	0xa6bc5767, 0x3fb506dd, 0x48b2364b, 0xd80d2bda, 0xaf0a1b4c,
> -	0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55, 0x316e8eef,
> -	0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
> -	0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe,
> -	0xb2bd0b28, 0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31,
> -	0x2cd99e8b, 0x5bdeae1d, 0x9b64c2b0, 0xec63f226, 0x756aa39c,
> -	0x026d930a, 0x9c0906a9, 0xeb0e363f, 0x72076785, 0x05005713,
> -	0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38, 0x92d28e9b,
> -	0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
> -	0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1,
> -	0x18b74777, 0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c,
> -	0x8f659eff, 0xf862ae69, 0x616bffd3, 0x166ccf45, 0xa00ae278,
> -	0xd70dd2ee, 0x4e048354, 0x3903b3c2, 0xa7672661, 0xd06016f7,
> -	0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc, 0x40df0b66,
> -	0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
> -	0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605,
> -	0xcdd70693, 0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8,
> -	0x5d681b02, 0x2a6f2b94, 0xb40bbe37, 0xc30c8ea1, 0x5a05df1b,
> -	0x2d02ef8d
> -};
> -
> -static u32 partial_crc32_one(u8 c, u32 crc)
> -{
> -	return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
> -}
> -
> -static u32 partial_crc32(const u8 *s, int len, u32 crc)
> -{
> -	while (len--)
> -		crc = partial_crc32_one(*s++, crc);
> -	return crc;
> -}
> -
> -static void die(const char * str, ...)
> -{
> -	va_list args;
> -	va_start(args, str);
> -	vfprintf(stderr, str, args);
> -	va_end(args);
> -	fputc('\n', stderr);
> -	exit(1);
> -}
> -
> -static void usage(void)
> -{
> -	die("Usage: build setup system zoffset.h image");
> -}
> -
> -/*
> - * Parse zoffset.h and find the entry points. We could just #include zoffset.h
> - * but that would mean tools/build would have to be rebuilt every time. It's
> - * not as if parsing it is hard...
> - */
> -#define PARSE_ZOFS(p, sym) do { \
> -	if (!strncmp(p, "#define ZO_" #sym " ", 11+sizeof(#sym)))	\
> -		sym = strtoul(p + 11 + sizeof(#sym), NULL, 16);		\
> -} while (0)
> -
> -static void parse_zoffset(char *fname)
> -{
> -	FILE *file;
> -	char *p;
> -	int c;
> -
> -	file = fopen(fname, "r");
> -	if (!file)
> -		die("Unable to open `%s': %m", fname);
> -	c = fread(buf, 1, sizeof(buf) - 1, file);
> -	if (ferror(file))
> -		die("read-error on `zoffset.h'");
> -	fclose(file);
> -	buf[c] = 0;
> -
> -	p = (char *)buf;
> -
> -	while (p && *p) {
> -		PARSE_ZOFS(p, _edata);
> -
> -		p = strchr(p, '\n');
> -		while (p && (*p == '\r' || *p == '\n'))
> -			p++;
> -	}
> -}
> -
> -int main(int argc, char ** argv)
> -{
> -	unsigned int i, sz, setup_sectors;
> -	int c;
> -	struct stat sb;
> -	FILE *file, *dest;
> -	int fd;
> -	void *kernel;
> -	u32 crc = 0xffffffffUL;
> -
> -	if (argc != 5)
> -		usage();
> -	parse_zoffset(argv[3]);
> -
> -	dest = fopen(argv[4], "w");
> -	if (!dest)
> -		die("Unable to write `%s': %m", argv[4]);
> -
> -	/* Copy the setup code */
> -	file = fopen(argv[1], "r");
> -	if (!file)
> -		die("Unable to open `%s': %m", argv[1]);
> -	c = fread(buf, 1, sizeof(buf), file);
> -	if (ferror(file))
> -		die("read-error on `setup'");
> -	if (c < 1024)
> -		die("The setup must be at least 1024 bytes");
> -	if (get_unaligned_le16(&buf[510]) != 0xAA55)
> -		die("Boot block hasn't got boot flag (0xAA55)");
> -	fclose(file);
> -
> -	/* Pad unused space with zeros */
> -	setup_sectors = (c + 4095) / 4096;
> -	setup_sectors *= 8;
> -	if (setup_sectors < SETUP_SECT_MIN)
> -		setup_sectors = SETUP_SECT_MIN;
> -	i = setup_sectors*512;
> -	memset(buf+c, 0, i-c);
> -
> -	/* Open and stat the kernel file */
> -	fd = open(argv[2], O_RDONLY);
> -	if (fd < 0)
> -		die("Unable to open `%s': %m", argv[2]);
> -	if (fstat(fd, &sb))
> -		die("Unable to stat `%s': %m", argv[2]);
> -	if (_edata != sb.st_size)
> -		die("Unexpected file size `%s': %u != %u", argv[2], _edata,
> -		    sb.st_size);
> -	sz = _edata - 4;
> -	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
> -	if (kernel == MAP_FAILED)
> -		die("Unable to mmap '%s': %m", argv[2]);
> -
> -	crc = partial_crc32(buf, i, crc);
> -	if (fwrite(buf, 1, i, dest) != i)
> -		die("Writing setup failed");
> -
> -	/* Copy the kernel code */
> -	crc = partial_crc32(kernel, sz, crc);
> -	if (fwrite(kernel, 1, sz, dest) != sz)
> -		die("Writing kernel failed");
> -
> -	/* Write the CRC */
> -	put_unaligned_le32(crc, buf);
> -	if (fwrite(buf, 1, 4, dest) != 4)
> -		die("Writing CRC failed");
> -
> -	/* Catch any delayed write failures */
> -	if (fclose(dest))
> -		die("Writing image failed");
> -
> -	close(fd);
> -
> -	/* Everything is OK */
> -	return 0;
> -}

-- 
Vitaly


