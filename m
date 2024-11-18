Return-Path: <linux-kernel+bounces-413066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1406C9D12F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4D4B27996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C151A08B6;
	Mon, 18 Nov 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fMOQgNn7"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521819B5A9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940021; cv=none; b=R5BMfScdfZgo70bUVAPhb1RFzoZ/0mnBysP9FMGWXdAlmj227Kcp8PdYcfObSvICIk5kkvZoMnVStjzOInDwJPID7q8bTlYtJdMArg6QZRLUUGolFhhKPveOKImWYhjw4IjjctFfNbLRcpkmLtptzA+ha0X7788sy4o2jP4zJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940021; c=relaxed/simple;
	bh=0EXa1CPhmAEoX+usJWl5u8IQDS8dhCaxg2cvfbvN4g4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n4YFZskIGIn69eig9ZebqsGulnB1c+YGz9TiBWj0BGsTQya8PCbJRwxpceAGvKp6ClJETRDl965Vsk4MNcFjgwMLDsgFYmX61F/YmNZgw4tYpIfaA9l/gRS4LcEG83GObioYEG9QUBiz0r0IFzKhZWnyQ7NCmtuokQt3n2gFGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fMOQgNn7; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731940012; x=1732199212;
	bh=TJDdDjTfTxsjHsZO1nDp+Ad+deAqxZFr/XWaP/LHA0o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=fMOQgNn7JG7mbMdFTBwouURbLfYPVwo9pEwCKzhwlvxjfa0j2+JgUVYMgx7iDgE1L
	 3KeQ0ryt1BQd6uy+/5eE4hRDYgE7TYVoHHhyxhbeh+KVklZORzQh8z7vASyvgj6xgI
	 MuGgtonKeUlbiiI+tFk2HtOozt52Ux6VGgjl9jxgV+l39BPYECupA1QeV6srQ6BlzG
	 dBM+MzWOPboqi81vaqvfBjmnwLML2/1zcdDWU3J+D/0gNgxz0W+Vm6upv3aLWEnGa+
	 l8mPNL72QcB7kX43pAvu+WzbfvxIh5plVNM48Es977X9SqVoRA1K0JQrtpTlWJBl/Z
	 bKIIo26DaN6jg==
Date: Mon, 18 Nov 2024 14:26:49 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Cc: "sam@gentoo.org" <sam@gentoo.org>
Subject: Build failure with GCC 15 (-std=gnu23)
Message-ID: <4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com>
Feedback-ID: 25269289:user:proton
X-Pm-Message-ID: 1bf3c078a99314428643e5a46076ce3b4bca3ead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Whenever I try to build the kernel with upcoming GCC 15 which defaults to -=
std=3Dgnu23 I get a build failure:

```
In file included from ./include/uapi/linux/posix_types.h:5,
                 from ./include/uapi/linux/types.h:14,
                 from ./include/linux/types.h:6,
                 from ./include/uapi/linux/mei_uuid.h:12,
                 from ./include/uapi/linux/mei.h:10,
                 from ./include/linux/mod_devicetable.h:12,
                 from scripts/mod/devicetable-offsets.c:3:
./include/linux/stddef.h:11:9: error: expected identifier before =E2=80=
=98false=E2=80=99
   11 |         false   =3D 0,
./include/linux/types.h:35:33: error: two or more data types in declaration=
 specifiers
   35 | typedef _Bool                   bool;
./include/linux/types.h:35:1: warning: useless type name in empty declarati=
on
   35 | typedef _Bool                   bool;
```

This can be reproduced on older GCC versions with KCFLAGS=3D"-std=3Dgnu23"


With Clang 18 and KCFLAGS=3D"-std=3Dc23" it's an even bigger mess:

```
In file included from ./arch/x86/include/asm/jump_label.h:7,
                 from ./include/linux/jump_label.h:112,
                 from ./arch/x86/include/asm/string_64.h:6,
                 from ./arch/x86/include/asm/string.h:5,
                 from ./include/linux/string.h:64,
                 from ./include/linux/uuid.h:11,
                 from ./include/linux/mod_devicetable.h:14:
./arch/x86/include/asm/asm.h: In function =E2=80=98rip_rel_ptr=E2=80=99:
./arch/x86/include/asm/asm.h:120:9: error: implicit declaration of function=
 =E2=80=98asm=E2=80=99 [-Wimplicit-function-declaration]
  120 |         asm("leaq %c1(%%rip), %0" : "=3Dr"(p) : "i"(p));
./arch/x86/include/asm/asm.h:120:34: error: expected =E2=80=98)=E2=80=99 be=
fore =E2=80=98:=E2=80=99 token
  120 |         asm("leaq %c1(%%rip), %0" : "=3Dr"(p) : "i"(p));
./arch/x86/include/asm/asm.h: At top level:
./arch/x86/include/asm/asm.h:222:46: error: expected =E2=80=98=3D=E2=80=
=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98asm=E2=80=99
  222 | register unsigned long current_stack_pointer asm(_ASM_SP);
./arch/x86/include/asm/jump_label.h: In function =E2=80=98arch_static_branc=
h=E2=80=99:
./arch/x86/include/asm/jump_label.h:27:9: error: =E2=80=98asm=E2=80=99 unde=
clared (first use in this function)
   27 |         asm goto("1:"
./arch/x86/include/asm/jump_label.h:27:9: note: each undeclared identifier =
is reported only once for each function it appears in
./arch/x86/include/asm/jump_label.h:27:12: error: expected =E2=80=98;=
=E2=80=99 before =E2=80=98goto=E2=80=99
   27 |         asm goto("1:"
                  ;
In file included from ./include/uapi/linux/swab.h:8,
                 from ./include/linux/swab.h:5,
                 from ./include/uapi/linux/byteorder/little_endian.h:14,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from ./arch/x86/include/uapi/asm/byteorder.h:5,
                 from ./include/linux/bitfield.h:11,
                 from ./include/linux/fortify-string.h:5,
                 from ./include/linux/string.h:390:
./arch/x86/include/uapi/asm/swab.h: In function =E2=80=98__arch_swab32=
=E2=80=99:
./arch/x86/include/uapi/asm/swab.h:10:24: error: expected =E2=80=98)=
=E2=80=99 before =E2=80=98:=E2=80=99 token
   10 |         asm("bswapl %0" : "=3Dr" (val) : "0" (val));
                               )
./arch/x86/include/uapi/asm/swab.h: In function =E2=80=98__arch_swab64=
=E2=80=99:
./arch/x86/include/uapi/asm/swab.h:31:24: error: expected =E2=80=98)=
=E2=80=99 before =E2=80=98:=E2=80=99 token
   31 |         asm("bswapq %0" : "=3Dr" (val) : "0" (val));
                               )
In file included from scripts/mod/devicetable-offsets.c:2:
scripts/mod/devicetable-offsets.c: In function =E2=80=98main=E2=80=99:
./include/linux/kbuild.h:6:9: error: =E2=80=98asm=E2=80=99 undeclared (firs=
t use in this function)
    6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" =
(val))
scripts/mod/devicetable-offsets.c:5:22: note: in expansion of macro =
=E2=80=98DEFINE=E2=80=99
    5 | #define DEVID(devid) DEFINE(SIZE_##devid, sizeof(struct devid))
scripts/mod/devicetable-offsets.c:11:9: note: in expansion of macro =
=E2=80=98DEVID=E2=80=99
   11 |         DEVID(usb_device_id);
./include/linux/kbuild.h:6:13: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98volatile=E2=80=99
    6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" =
(val))
```

There is a lot more output from the compiler that i've cut off because the =
email would become way too long.

Regards,
Kostadin


