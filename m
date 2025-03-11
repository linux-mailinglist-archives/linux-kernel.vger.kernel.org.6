Return-Path: <linux-kernel+bounces-556572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C1FA5CBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074601896286
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D260A3D;
	Tue, 11 Mar 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JEf4qUZd"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683886088F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713292; cv=none; b=PFs+OEHbL91JHlb+r1BXcuUUNms1f9E1bu+0UsJn3AFKgExu35yRDGbaR6wGwY+kO13AWXwoJXg4DQN7cnP4spLMB5tUV+4eLmIsJgvfZ7f1iLxLkmdKVLFdZgNg6H0RPdN03NSd/DVdo33MPtbTrQ4ogNPzs2bBl3DaHUqawv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713292; c=relaxed/simple;
	bh=fy1XI7KidWL/N7A4yZ7ZDZXGgRNTvHhVStJnHfNkKoM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kB3RjHNG+l8lo+ChJw7XOHVcL2aUklzVgRtwy/XQaebu7Z9QHUGVkWGksKgseyJTMLEGihpzvUMP8DKmG3YC9HpQYOn4/v04Ai42UkmcvHIIcRcAdBeniCR2gWjsbvphldZrxIauAdJDU6s2s4SMTM+15TbacjNYtTrYbwvXAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JEf4qUZd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52BHESU32162442
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Mar 2025 10:14:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52BHESU32162442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741713269;
	bh=PUYe5aCj0XY6FT8NU2lexUsrlsn9et2VoAjr3KFPgF8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JEf4qUZdcl+3A7A4wedFgZArpVOZeQJXWRb6s8RAis52ms36NBkrRweGIDuLpH5uA
	 hSqsk3LkInqNF8aHM1F0bVcei7dZpu1VlTxtvwXNGFvx8xTpuTjtRF7Yhuit60h97J
	 XGRp4wL2TeOcM0vmiX3ne7i+AylC+hEuljoEUug8y2y9q4RPdM6cUoywtpA6Ae06zQ
	 meN48VxOYCWJdBE8TgCH1PmLrEMiYLLqp9Jvaq/caphVDKiy5ZB11sqepmM5782SP9
	 Ar9vqQ6Vkgj8azu5f6bNEsCoBfPOgKcTel/ivt11Y6ybg9lpqRQJdS25yUKF7J7ZpQ
	 lbnSYtxL6s0hg==
Date: Tue, 11 Mar 2025 10:14:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
CC: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>, Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>, Paul Durrant <paul@xen.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_resend=5D_x86/boot=3A_Drop_CRC-32_?=
 =?US-ASCII?Q?checksum_and_the_build_tool_that_generates_it?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87bju7o65f.fsf@redhat.com>
References: <20250307164801.885261-2-ardb+git@google.com> <87bju7o65f.fsf@redhat.com>
Message-ID: <3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 11, 2025 9:59:08 AM PDT, Vitaly Kuznetsov <vkuznets@redhat=2Ecom> =
wrote:
>Ard Biesheuvel <ardb+git@google=2Ecom> writes:
>
>> From: Ard Biesheuvel <ardb@kernel=2Eorg>
>>
>> Apart from some sanity checks on the size of setup=2Ebin, the only
>> remaining task carried out by the arch/x86/boot/tools/build=2Ec build t=
ool
>> is generating the CRC-32 checksum of the bzImage=2E This feature was ad=
ded
>> in commit
>>
>>   7d6e737c8d2698b6 ("x86: add a crc32 checksum to the kernel image=2E")
>>
>> without any motivation (or any commit log text, for that matter)=2E
>
>Doing some history digging, it seems this was done for Xen:
>https://lore=2Ekernel=2Eorg/lkml/1202936100-30859-1-git-send-email-ijc@he=
llion=2Eorg=2Euk/T/#m263fdcf0ff3f31ca8e5cd619aa81c7735fa8be91
>
>Let me Cc: a few Xen folks for visibility=2E
>
>>  This
>> checksum is not verified by any known bootloader, and given that
>>
>> a) the checksum of the entire bzImage is reported by most tools (zlib,
>>    rhash) as 0xffffffff and not 0x0 as documented,
>> b) the checksum is corrupted when the image is signed for secure boot,
>>    which means that no distro ships x86 images with valid CRCs,
>
>Note that at least Fedora/RHEL/=2E=2E=2E distros ship keyless HMAC hash
>alongside vmlinuz binary, e=2Eg=2E on my Fedora40:
>
>$ cat /boot/=2Evmlinuz-6=2E12=2E6-100=2Efc40=2Ex86_64=2Ehmac
>19aec080fbd05c5de42db486653a5d9e9d69b59ac8d216ea89850ccf1f538c08ff4ada450=
989ddf1be81e23fd3c99253939d0a2153d3fd270cc1ed561c04294e  vmlinuz-6=2E12=2E6=
-100=2Efc40=2Ex86_64
>
>and this is created _after_ SB signing=2E AFAIU, the need for this is
>coming from FIPS requirements; this makes me wornder if the CRC-32 is an
>early implementation of the same thing=2E
>
>>
>> it seems quite unlikely that this checksum is being used, so let's just
>> drop it, along with the tool that generates it=2E
>>
>> Instead, use simple file concatenation and truncation to combine the tw=
o
>> pieces into bzImage, and replace the checks on the size of the setup
>> block with a couple of ASSERT()s in the linker script=2E
>>
>> Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> Cc: Gerd Hoffmann <kraxel@redhat=2Ecom>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat=2Ecom>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel=2Eorg>
>> ---
>>  Documentation/arch/x86/boot=2Erst        |  10 -
>>  arch/x86/boot/Makefile                 |   7 +-
>>  arch/x86/boot/compressed/vmlinux=2Elds=2ES |   3 +-
>>  arch/x86/boot/setup=2Eld                 |   2 +
>>  arch/x86/boot/tools/=2Egitignore         |   2 -
>>  arch/x86/boot/tools/build=2Ec            | 247 --------------------
>>  6 files changed, 5 insertions(+), 266 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/boot=2Erst b/Documentation/arch/x86=
/boot=2Erst
>> index 76f53d3450e7=2E=2E77e6163288db 100644
>> --- a/Documentation/arch/x86/boot=2Erst
>> +++ b/Documentation/arch/x86/boot=2Erst
>> @@ -1038,16 +1038,6 @@ Offset/size:	0x000c/4
>>    This field contains maximal allowed type for setup_data and setup_in=
direct structs=2E
>> =20
>> =20
>> -The Image Checksum
>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> -
>> -From boot protocol version 2=2E08 onwards the CRC-32 is calculated ove=
r
>> -the entire file using the characteristic polynomial 0x04C11DB7 and an
>> -initial remainder of 0xffffffff=2E  The checksum is appended to the
>> -file; therefore the CRC of the file up to the limit specified in the
>> -syssize field of the header is always 0=2E
>> -
>> -
>>  The Kernel Command Line
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
>> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>> index 9cc0ff6e9067=2E=2E8589471b65a1 100644
>> --- a/arch/x86/boot/Makefile
>> +++ b/arch/x86/boot/Makefile
>> @@ -35,7 +35,6 @@ setup-y		+=3D video-vesa=2Eo
>>  setup-y		+=3D video-bios=2Eo
>> =20
>>  targets		+=3D $(setup-y)
>> -hostprogs	:=3D tools/build
>>  hostprogs	+=3D mkcpustr
>> =20
>>  HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include \
>> @@ -61,11 +60,9 @@ KBUILD_CFLAGS	+=3D $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>  $(obj)/bzImage: asflags-y  :=3D $(SVGA_MODE)
>> =20
>>  quiet_cmd_image =3D BUILD   $@
>> -silent_redirect_image =3D >/dev/null
>> -cmd_image =3D $(obj)/tools/build $(obj)/setup=2Ebin $(obj)/vmlinux=2Eb=
in \
>> -			       $(obj)/zoffset=2Eh $@ $($(quiet)redirect_image)
>> +      cmd_image =3D cp $< $@; truncate -s %4K $@; cat $(obj)/vmlinux=
=2Ebin >>$@
>> =20
>> -$(obj)/bzImage: $(obj)/setup=2Ebin $(obj)/vmlinux=2Ebin $(obj)/tools/b=
uild FORCE
>> +$(obj)/bzImage: $(obj)/setup=2Ebin $(obj)/vmlinux=2Ebin FORCE
>>  	$(call if_changed,image)
>>  	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`ca=
t =2Eversion`)')'
>> =20
>> diff --git a/arch/x86/boot/compressed/vmlinux=2Elds=2ES b/arch/x86/boot=
/compressed/vmlinux=2Elds=2ES
>> index 083ec6d7722a=2E=2E48d0b5184557 100644
>> --- a/arch/x86/boot/compressed/vmlinux=2Elds=2ES
>> +++ b/arch/x86/boot/compressed/vmlinux=2Elds=2ES
>> @@ -48,8 +48,7 @@ SECTIONS
>>  		*(=2Edata)
>>  		*(=2Edata=2E*)
>> =20
>> -		/* Add 4 bytes of extra space for a CRC-32 checksum */
>> -		=2E =3D ALIGN(=2E + 4, 0x200);
>> +		=2E =3D ALIGN(0x200);
>>  		_edata =3D =2E ;
>>  	}
>>  	=2E =3D ALIGN(L1_CACHE_BYTES);
>> diff --git a/arch/x86/boot/setup=2Eld b/arch/x86/boot/setup=2Eld
>> index 3a2d1360abb0=2E=2Ee1d594a60204 100644
>> --- a/arch/x86/boot/setup=2Eld
>> +++ b/arch/x86/boot/setup=2Eld
>> @@ -45,6 +45,8 @@ SECTIONS
>> =20
>>  		setup_size =3D ALIGN(ABSOLUTE(=2E), 4096);
>>  		setup_sects =3D ABSOLUTE(setup_size / 512);
>> +		ASSERT(setup_sects >=3D 5, "The setup must be at least 5 sectors in =
size");
>> +		ASSERT(setup_sects <=3D 64, "The setup must be at most 64 sectors in=
 size");
>>  	}
>> =20
>>  	=2E =3D ALIGN(16);
>> diff --git a/arch/x86/boot/tools/=2Egitignore b/arch/x86/boot/tools/=2E=
gitignore
>> deleted file mode 100644
>> index ae91f4d0d78b=2E=2E000000000000
>> --- a/arch/x86/boot/tools/=2Egitignore
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -# SPDX-License-Identifier: GPL-2=2E0-only
>> -build
>> diff --git a/arch/x86/boot/tools/build=2Ec b/arch/x86/boot/tools/build=
=2Ec
>> deleted file mode 100644
>> index 10311d77c67f=2E=2E000000000000
>> --- a/arch/x86/boot/tools/build=2Ec
>> +++ /dev/null
>> @@ -1,247 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2=2E0
>> -/*
>> - *  Copyright (C) 1991, 1992  Linus Torvalds
>> - *  Copyright (C) 1997 Martin Mares
>> - *  Copyright (C) 2007 H=2E Peter Anvin
>> - */
>> -
>> -/*
>> - * This file builds a disk-image from three different files:
>> - *
>> - * - setup: 8086 machine code, sets up system parm
>> - * - system: 80386 code for actual system
>> - * - zoffset=2Eh: header with ZO_* defines
>> - *
>> - * It does some checking that all files are of the correct type, and w=
rites
>> - * the result to the specified destination, removing headers and paddi=
ng to
>> - * the right amount=2E It also writes some system data to stdout=2E
>> - */
>> -
>> -/*
>> - * Changes by tytso to allow root device specification
>> - * High loaded stuff by Hans Lermen & Werner Almesberger, Feb=2E 1996
>> - * Cross compiling fixes by Gertjan van Wingerde, July 1996
>> - * Rewritten by Martin Mares, April 1997
>> - * Substantially overhauled by H=2E Peter Anvin, April 2007
>> - */
>> -
>> -#include <stdio=2Eh>
>> -#include <string=2Eh>
>> -#include <stdlib=2Eh>
>> -#include <stdarg=2Eh>
>> -#include <sys/types=2Eh>
>> -#include <sys/stat=2Eh>
>> -#include <unistd=2Eh>
>> -#include <fcntl=2Eh>
>> -#include <sys/mman=2Eh>
>> -#include <tools/le_byteshift=2Eh>
>> -
>> -typedef unsigned char  u8;
>> -typedef unsigned short u16;
>> -typedef unsigned int   u32;
>> -
>> -/* Minimal number of setup sectors */
>> -#define SETUP_SECT_MIN 5
>> -#define SETUP_SECT_MAX 64
>> -
>> -/* This must be large enough to hold the entire setup */
>> -u8 buf[SETUP_SECT_MAX*512];
>> -
>> -static unsigned long _edata;
>> -
>> -/*--------------------------------------------------------------------=
--*/
>> -
>> -static const u32 crctab32[] =3D {
>> -	0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419,
>> -	0x706af48f, 0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4,
>> -	0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07,
>> -	0x90bf1d91, 0x1db71064, 0x6ab020f2, 0xf3b97148, 0x84be41de,
>> -	0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7, 0x136c9856,
>> -	0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9,
>> -	0xfa0f3d63, 0x8d080df5, 0x3b6e20c8, 0x4c69105e, 0xd56041e4,
>> -	0xa2677172, 0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,
>> -	0x35b5a8fa, 0x42b2986c, 0xdbbbc9d6, 0xacbcf940, 0x32d86ce3,
>> -	0x45df5c75, 0xdcd60dcf, 0xabd13d59, 0x26d930ac, 0x51de003a,
>> -	0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423, 0xcfba9599,
>> -	0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
>> -	0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d, 0x76dc4190,
>> -	0x01db7106, 0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f,
>> -	0x9fbfe4a5, 0xe8b8d433, 0x7807c9a2, 0x0f00f934, 0x9609a88e,
>> -	0xe10e9818, 0x7f6a0dbb, 0x086d3d2d, 0x91646c97, 0xe6635c01,
>> -	0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e, 0x6c0695ed,
>> -	0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
>> -	0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3,
>> -	0xfbd44c65, 0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2,
>> -	0x4adfa541, 0x3dd895d7, 0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a,
>> -	0x346ed9fc, 0xad678846, 0xda60b8d0, 0x44042d73, 0x33031de5,
>> -	0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa, 0xbe0b1010,
>> -	0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
>> -	0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17,
>> -	0x2eb40d81, 0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6,
>> -	0x03b6e20c, 0x74b1d29a, 0xead54739, 0x9dd277af, 0x04db2615,
>> -	0x73dc1683, 0xe3630b12, 0x94643b84, 0x0d6d6a3e, 0x7a6a5aa8,
>> -	0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1, 0xf00f9344,
>> -	0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
>> -	0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a,
>> -	0x67dd4acc, 0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5,
>> -	0xd6d6a3e8, 0xa1d1937e, 0x38d8c2c4, 0x4fdff252, 0xd1bb67f1,
>> -	0xa6bc5767, 0x3fb506dd, 0x48b2364b, 0xd80d2bda, 0xaf0a1b4c,
>> -	0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55, 0x316e8eef,
>> -	0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
>> -	0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe,
>> -	0xb2bd0b28, 0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31,
>> -	0x2cd99e8b, 0x5bdeae1d, 0x9b64c2b0, 0xec63f226, 0x756aa39c,
>> -	0x026d930a, 0x9c0906a9, 0xeb0e363f, 0x72076785, 0x05005713,
>> -	0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38, 0x92d28e9b,
>> -	0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
>> -	0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1,
>> -	0x18b74777, 0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c,
>> -	0x8f659eff, 0xf862ae69, 0x616bffd3, 0x166ccf45, 0xa00ae278,
>> -	0xd70dd2ee, 0x4e048354, 0x3903b3c2, 0xa7672661, 0xd06016f7,
>> -	0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc, 0x40df0b66,
>> -	0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
>> -	0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605,
>> -	0xcdd70693, 0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8,
>> -	0x5d681b02, 0x2a6f2b94, 0xb40bbe37, 0xc30c8ea1, 0x5a05df1b,
>> -	0x2d02ef8d
>> -};
>> -
>> -static u32 partial_crc32_one(u8 c, u32 crc)
>> -{
>> -	return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
>> -}
>> -
>> -static u32 partial_crc32(const u8 *s, int len, u32 crc)
>> -{
>> -	while (len--)
>> -		crc =3D partial_crc32_one(*s++, crc);
>> -	return crc;
>> -}
>> -
>> -static void die(const char * str, =2E=2E=2E)
>> -{
>> -	va_list args;
>> -	va_start(args, str);
>> -	vfprintf(stderr, str, args);
>> -	va_end(args);
>> -	fputc('\n', stderr);
>> -	exit(1);
>> -}
>> -
>> -static void usage(void)
>> -{
>> -	die("Usage: build setup system zoffset=2Eh image");
>> -}
>> -
>> -/*
>> - * Parse zoffset=2Eh and find the entry points=2E We could just #inclu=
de zoffset=2Eh
>> - * but that would mean tools/build would have to be rebuilt every time=
=2E It's
>> - * not as if parsing it is hard=2E=2E=2E
>> - */
>> -#define PARSE_ZOFS(p, sym) do { \
>> -	if (!strncmp(p, "#define ZO_" #sym " ", 11+sizeof(#sym)))	\
>> -		sym =3D strtoul(p + 11 + sizeof(#sym), NULL, 16);		\
>> -} while (0)
>> -
>> -static void parse_zoffset(char *fname)
>> -{
>> -	FILE *file;
>> -	char *p;
>> -	int c;
>> -
>> -	file =3D fopen(fname, "r");
>> -	if (!file)
>> -		die("Unable to open `%s': %m", fname);
>> -	c =3D fread(buf, 1, sizeof(buf) - 1, file);
>> -	if (ferror(file))
>> -		die("read-error on `zoffset=2Eh'");
>> -	fclose(file);
>> -	buf[c] =3D 0;
>> -
>> -	p =3D (char *)buf;
>> -
>> -	while (p && *p) {
>> -		PARSE_ZOFS(p, _edata);
>> -
>> -		p =3D strchr(p, '\n');
>> -		while (p && (*p =3D=3D '\r' || *p =3D=3D '\n'))
>> -			p++;
>> -	}
>> -}
>> -
>> -int main(int argc, char ** argv)
>> -{
>> -	unsigned int i, sz, setup_sectors;
>> -	int c;
>> -	struct stat sb;
>> -	FILE *file, *dest;
>> -	int fd;
>> -	void *kernel;
>> -	u32 crc =3D 0xffffffffUL;
>> -
>> -	if (argc !=3D 5)
>> -		usage();
>> -	parse_zoffset(argv[3]);
>> -
>> -	dest =3D fopen(argv[4], "w");
>> -	if (!dest)
>> -		die("Unable to write `%s': %m", argv[4]);
>> -
>> -	/* Copy the setup code */
>> -	file =3D fopen(argv[1], "r");
>> -	if (!file)
>> -		die("Unable to open `%s': %m", argv[1]);
>> -	c =3D fread(buf, 1, sizeof(buf), file);
>> -	if (ferror(file))
>> -		die("read-error on `setup'");
>> -	if (c < 1024)
>> -		die("The setup must be at least 1024 bytes");
>> -	if (get_unaligned_le16(&buf[510]) !=3D 0xAA55)
>> -		die("Boot block hasn't got boot flag (0xAA55)");
>> -	fclose(file);
>> -
>> -	/* Pad unused space with zeros */
>> -	setup_sectors =3D (c + 4095) / 4096;
>> -	setup_sectors *=3D 8;
>> -	if (setup_sectors < SETUP_SECT_MIN)
>> -		setup_sectors =3D SETUP_SECT_MIN;
>> -	i =3D setup_sectors*512;
>> -	memset(buf+c, 0, i-c);
>> -
>> -	/* Open and stat the kernel file */
>> -	fd =3D open(argv[2], O_RDONLY);
>> -	if (fd < 0)
>> -		die("Unable to open `%s': %m", argv[2]);
>> -	if (fstat(fd, &sb))
>> -		die("Unable to stat `%s': %m", argv[2]);
>> -	if (_edata !=3D sb=2Est_size)
>> -		die("Unexpected file size `%s': %u !=3D %u", argv[2], _edata,
>> -		    sb=2Est_size);
>> -	sz =3D _edata - 4;
>> -	kernel =3D mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
>> -	if (kernel =3D=3D MAP_FAILED)
>> -		die("Unable to mmap '%s': %m", argv[2]);
>> -
>> -	crc =3D partial_crc32(buf, i, crc);
>> -	if (fwrite(buf, 1, i, dest) !=3D i)
>> -		die("Writing setup failed");
>> -
>> -	/* Copy the kernel code */
>> -	crc =3D partial_crc32(kernel, sz, crc);
>> -	if (fwrite(kernel, 1, sz, dest) !=3D sz)
>> -		die("Writing kernel failed");
>> -
>> -	/* Write the CRC */
>> -	put_unaligned_le32(crc, buf);
>> -	if (fwrite(buf, 1, 4, dest) !=3D 4)
>> -		die("Writing CRC failed");
>> -
>> -	/* Catch any delayed write failures */
>> -	if (fclose(dest))
>> -		die("Writing image failed");
>> -
>> -	close(fd);
>> -
>> -	/* Everything is OK */
>> -	return 0;
>> -}
>

Please leave the bytes in question as explicit zeroes if possible=2E

