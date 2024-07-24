Return-Path: <linux-kernel+bounces-261297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D2293B566
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1158A2826AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E015FA67;
	Wed, 24 Jul 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKUQCHk2"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB215EFA3;
	Wed, 24 Jul 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840313; cv=none; b=Da1HUmm1tb6MhSVjcX5GE1xroEUkGgMZA27CYR97YPYbarFUpf7zdonT7ef3trfQlEn9PH2CuHlleRMf1y7yxNnUPS7Wb31ssuYg5L3DZRWHU5pR3YJRtjz12odY2Q28WUHC0OuVcJHcbzIr2zC+I7pibCC27maC0ziO66wHy0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840313; c=relaxed/simple;
	bh=qoZkMnh5RBx0RSWEkJSoSEXbAC+KiIn5meJHy4Noy3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZN0e4iW3HtHA++UyYktbwKYAnCrAx6jsc6JCXJ0uk4YeUOxCVB0T6APCeoU1yj7M03Y7iXzuc/kzuYMVCw9soAT83jxpRRJtFJRyAZNBPRc/3NbCX+lSbfcc8KiiwVfj3ADq9wNHCEA7jAN+GZfsGg9H8m+2fJqFc4rOI8BUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKUQCHk2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-369cb9f086aso2722296f8f.0;
        Wed, 24 Jul 2024 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721840310; x=1722445110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0ehM3meCwqPiDPhpWbCbP7i9znvpSX8RvjFc9Xbyvo=;
        b=jKUQCHk2oOxmmJjvWs3p/uOb8Vi50+EZtFNVM55ELechYkkd37hv7QfW2abfP14Dqc
         904O2N8GB1XjPSfIAcrBtFXT7eDCIWmKmEarxeB+8WckISF2xGNsVqCle3F6ZOu5oud1
         dcFjwgrhrXlL6K8ULT/YolVFNayFa0P9KBPRrdtbiv5z2QFPMhzd4ANuaoNTE/XtsIXo
         JzcnF0jAVxWCSXUZPXfzwNiY6xw6P+n5IK+6dS+1FURAG9S/lHg5eIADOA/OHelhx0oW
         o8aIDRiCGbIGTNzaQoNnQ9H9UCfwvSQchCo0jiyNJckARyQ5/eLkPPgq3sA/Q3YIGJgD
         volQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840310; x=1722445110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0ehM3meCwqPiDPhpWbCbP7i9znvpSX8RvjFc9Xbyvo=;
        b=c9S2/ZlGpCamtSH7x31LWtWjnt1H6/ZCZCHPypB1r0jrh+eOwdQbE0cu9GQ4sLcyLW
         IpCdQ98jV4vl0L/T/yMoqiDE3qTWUn5w1Qybt2eTdypOXjUy+PEPAikuXtio05XsPUzs
         J5S7OzPdoOaczmu3sfV62O+bLznfB+qIjJRpwVgwwSCXggxojn0sDtF4ehuuciPQzxi8
         utgoWPaPgD3bvs7X+Zm7X2c8CuX6Ep7jusMuTWglyhEM3vxUhBv3L846brLClZW9258Z
         4lPDBnHBo4PhhxTb1VQPoCieJi+hs5rGLvoz6yKZiMSFC4OEHxET0MoAHqDH7FiLNdT9
         FdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX7rVZ7xFwCGMKpLRsDLFfkR7AjHiLTp/LBuU45mRpP9HmPQhPKqrFboS6CdoZSbBwsmEbVJHmOdmqsO/UPnc3NaCVfoPvSfBk3r08iaENC+ZBZp8xq40n5d8VjwWjc2VUBqJqCkZw
X-Gm-Message-State: AOJu0YxtZfr4UCr6kBv3Ethdj4o/L7IZzfyzNv6S5o08U6NxYwLn7Y8e
	izcfEJojbb63/jsbsAHTLGiKBn7/BA4OfjpV4HFES51CsVPKACDA+R4t3UY7SsScm2n+Y2WTb8j
	Ebgjn8fd1PrqqeKlkfaanVXsUbv4CAw==
X-Google-Smtp-Source: AGHT+IG/y+ELWONJv1f+yyugtY74Q9fThbVV/8ZVwZS86C4ZlAma9KEJJ+Yh34hP1uXhPMa83SpijXDrG2w29wXDtAY=
X-Received: by 2002:a05:6000:110b:b0:367:8fee:443b with SMTP id
 ffacd0b85a97d-36b31b4cc21mr186316f8f.41.1721840309941; Wed, 24 Jul 2024
 09:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000045457e061df061c3@google.com>
In-Reply-To: <00000000000045457e061df061c3@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 24 Jul 2024 18:58:18 +0200
Message-ID: <CA+fCnZf+7Z1=khHu8vKDpRyqCu9=ajNVRwzhHiumt6UMqBDCtA@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in raw_ioctl (2)
To: Alexander Potapenko <glider@google.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: multipart/mixed; boundary="00000000000008e577061e01304d"

--00000000000008e577061e01304d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:55=E2=80=AFPM syzbot
<syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1197b6b598000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6bfb33a8ad104=
58f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D17ca2339e34a1d8=
63aad
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1626b995980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1572eb2198000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8543636ba6c/dis=
k-2c9b3512.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/403c612b7ac5/vmlinu=
x-2c9b3512.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/88dc686d170a/b=
zImage-2c9b3512.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/inst=
rumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:45
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _copy_to_user+0xbc/0x110 lib/usercopy.c:45
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  raw_ioctl_ep0_read drivers/usb/gadget/legacy/raw_gadget.c:786 [inline]
>  raw_ioctl+0x3d2e/0x5440 drivers/usb/gadget/legacy/raw_gadget.c:1315
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
>  x64_sys_call+0x1a06/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3985 [inline]
>  slab_alloc_node mm/slub.c:4028 [inline]
>  __do_kmalloc_node mm/slub.c:4148 [inline]
>  __kmalloc_noprof+0x661/0xf30 mm/slub.c:4161
>  kmalloc_noprof include/linux/slab.h:685 [inline]
>  raw_alloc_io_data drivers/usb/gadget/legacy/raw_gadget.c:675 [inline]
>  raw_ioctl_ep0_read drivers/usb/gadget/legacy/raw_gadget.c:778 [inline]
>  raw_ioctl+0x3bcb/0x5440 drivers/usb/gadget/legacy/raw_gadget.c:1315
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
>  x64_sys_call+0x1a06/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Bytes 0-4095 of 4096 are uninitialized
> Memory access of size 4096 starts at ffff888116edb000
> Data copied to user address 00007ffefdca74d8
>
> CPU: 0 PID: 5057 Comm: syz-executor289 Not tainted 6.10.0-syzkaller-11185=
-g2c9b3512402e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/27/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Hi Alex,

This appears to be some kind of a bug in KMSAN.

I applied a debugging patch that prints the data submitted by ath9k,
tracks the data being copied to Raw Gadget, and prints the data copied
to userspace by Raw Gadget (attached). I see that the submitted and
the copied data match (at least, the first 8 bytes). I also see that
the data is copied from ath9k to Raw Gadget as intended. So the data
should be initialized. However, somehow, KMSAN doesn't track that.

The bug is reproducible via the C reproducer, but you have to keep it
running for a minute or so. The output with the debugging patch is
somewhat messy due to multiple threads being involved, but you can
start unveiling it backwards from the kernel address printed in the
KMSAN report.

Thanks!

--00000000000008e577061e01304d
Content-Type: text/x-patch; charset="US-ASCII"; name="ath9k.patch"
Content-Disposition: attachment; filename="ath9k.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz033g5w0>
X-Attachment-Id: f_lz033g5w0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg5ay9oaWZfdXNiLmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoOWsvaGlmX3VzYi5jCmluZGV4IDBjNzg0MWY5NTIy
OC4uZTQxOTU0YTk4Mjk0IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRo
OWsvaGlmX3VzYi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg5ay9oaWZfdXNi
LmMKQEAgLTEwODMsNiArMTA4Myw3IEBAIHN0YXRpYyBpbnQgYXRoOWtfaGlmX3VzYl9kb3dubG9h
ZF9mdyhzdHJ1Y3QgaGlmX2RldmljZV91c2IgKmhpZl9kZXYpCiAJCXRyYW5zZmVyID0gbWluX3Qo
c2l6ZV90LCBsZW4sIDQwOTYpOwogCQltZW1jcHkoYnVmLCBkYXRhLCB0cmFuc2Zlcik7CiAKK3By
X2VycigiISBhdGg5azogdHJhbnNmZXIgPSAlZCwgYnVmID0gJXB4LCBieXRlcyA9ICVseFxuIiwg
KGludCl0cmFuc2ZlciwgYnVmLCAqKHVuc2lnbmVkIGxvbmcgKilidWYpOwogCQllcnIgPSB1c2Jf
Y29udHJvbF9tc2coaGlmX2Rldi0+dWRldiwKIAkJCQkgICAgICB1c2Jfc25kY3RybHBpcGUoaGlm
X2Rldi0+dWRldiwgMCksCiAJCQkJICAgICAgRklSTVdBUkVfRE9XTkxPQUQsIDB4NDAgfCBVU0Jf
RElSX09VVCwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvcmF3X2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2xlZ2FjeS9yYXdfZ2FkZ2V0LmMKaW5kZXggMzk5ZmNh
MzJhOGFjLi4wYWYyMGFjNTY2MDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdh
Y3kvcmF3X2dhZGdldC5jCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvcmF3X2dhZGdl
dC5jCkBAIC03ODMsNiArNzgzLDkgQEAgc3RhdGljIGludCByYXdfaW9jdGxfZXAwX3JlYWQoc3Ry
dWN0IHJhd19kZXYgKmRldiwgdW5zaWduZWQgbG9uZyB2YWx1ZSkKIAkJZ290byBmcmVlOwogCiAJ
bGVuZ3RoID0gbWluKGlvLmxlbmd0aCwgKHVuc2lnbmVkIGludClyZXQpOworY3VycmVudC0+a21z
YW5fY3R4LmFsbG93X3JlcG9ydGluZyA9IGZhbHNlOworaWYgKGxlbmd0aCA+PSA4KSBwcl9lcnIo
IiEgZXAwX3JlYWQ6IGxlbmd0aCA9ICV1LCBkYXRhID0gJXB4LCBieXRlcyA9ICVseFxuIiwgbGVu
Z3RoLCBkYXRhLCAqKHVuc2lnbmVkIGxvbmcgKilkYXRhKTsKK2N1cnJlbnQtPmttc2FuX2N0eC5h
bGxvd19yZXBvcnRpbmcgPSB0cnVlOwogCWlmIChjb3B5X3RvX3VzZXIoKHZvaWQgX191c2VyICop
KHZhbHVlICsgc2l6ZW9mKGlvKSksIGRhdGEsIGxlbmd0aCkpCiAJCXJldCA9IC1FRkFVTFQ7CiAJ
ZWxzZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9kdW1teV9oY2QuYyBiL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvZHVtbXlfaGNkLmMKaW5kZXggZjM3YjBkODM4NmMxLi4xNjkw
ZTQ5MDZjNDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvZHVtbXlfaGNkLmMK
KysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9kdW1teV9oY2QuYwpAQCAtMTM1MCw3ICsxMzUw
LDEwIEBAIHN0YXRpYyBpbnQgZHVtbXlfcGVyZm9ybV90cmFuc2ZlcihzdHJ1Y3QgdXJiICp1cmIs
IHN0cnVjdCBkdW1teV9yZXF1ZXN0ICpyZXEsCiAJCWlmICh0b19ob3N0KQogCQkJbWVtY3B5KHVi
dWYsIHJidWYsIGxlbik7CiAJCWVsc2UKK3sKK3ByX2VycigiISBkdW1teTogbWVtY3B5KCVweCwg
JXB4LCAldSlcbiIsIHJidWYsIHVidWYsIGxlbik7CiAJCQltZW1jcHkocmJ1ZiwgdWJ1ZiwgbGVu
KTsKK30KIAkJcmV0dXJuIGxlbjsKIAl9CiAKQEAgLTEzNzksNyArMTM4MiwxMCBAQCBzdGF0aWMg
aW50IGR1bW15X3BlcmZvcm1fdHJhbnNmZXIoc3RydWN0IHVyYiAqdXJiLCBzdHJ1Y3QgZHVtbXlf
cmVxdWVzdCAqcmVxLAogCQlpZiAodG9faG9zdCkKIAkJCW1lbWNweSh1YnVmLCByYnVmLCB0aGlz
X3NnKTsKIAkJZWxzZQoreworcHJfZXJyKCIhIGR1bW15OiBtZW1jcHkoJXB4LCAlcHgsICV1KVxu
IiwgcmJ1ZiwgdWJ1ZiwgbGVuKTsKIAkJCW1lbWNweShyYnVmLCB1YnVmLCB0aGlzX3NnKTsKK30K
IAkJbGVuIC09IHRoaXNfc2c7CiAKIAkJaWYgKCFsZW4pCg==
--00000000000008e577061e01304d--

