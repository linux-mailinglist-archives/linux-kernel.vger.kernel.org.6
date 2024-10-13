Return-Path: <linux-kernel+bounces-362720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C499B89A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AB62825EA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647C77104;
	Sun, 13 Oct 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cThjG4ho"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D317557
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728801157; cv=none; b=cwA+v8Jdm7OkqtTZV2Hm0hPylsxPzpBlKxrSJy4/Xm+yLlvMffwxLordRc9gKZ62G58/8al056vKzvszxSvMLmon0QC8rsSsvgqhp1IBloa1jOSBsOv7hjWQVYkfNQarM5JXy10tVYkddIT1v7GXX1Su8pj/Wq+Zh0GeOBicut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728801157; c=relaxed/simple;
	bh=rEva8J/ZxIhNkxuJJ8+Zz3LlZL1eEzbYOm/W2FTvO0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnTcTWZl0DIncL4F6HsVw+vD9LMAxqNh1E21nbDARStRHys0nmAVNddxdSDBgqTuKxZbBaHNPfAqKDgcDFvifukW1PadWSBnwiBDNNt1tLKvAFoAuwWNIk2wL+KY8DHqlm+OXwuGZkgMwvEZYAgJ4DjKVa7aa/Xv2QZnorbEnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cThjG4ho; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a11e7so849290a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728801154; x=1729405954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Elf4ApeyMulrVrUDxJM8t7aAJNFW1jcBJ7/MTw4NMUo=;
        b=cThjG4hoF8WOAPqOFQ0vTjXf4ibAyULj/O6ZTw7Wzpif4LvmUIr2vlLxIHCyf12fYp
         1yDtoYnvxBy8x/41R8WwQNA8jJm9LSfFDXFsOslMiA1Kcii3MNRNtvX1ulT8891Hx4uR
         pPYOzVIQbWOiIxp6LJ7/UCJ88FHHXNmznaAPdW3q5ACxf5a19QRLk5vfqmFwsTbuHwTM
         VbOiyywXW3mDxfdggX5QiJ3NIXtqnliuSI9pVkgen4PFojXG8RxrWhe/cGm5nfuMDYAf
         stMnDBM44Jg13LdmNFle6/OsQiLm0u+5TaaKuev1C6GkjCnSAgEpmMIYetMVfhwv78BT
         +VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728801154; x=1729405954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Elf4ApeyMulrVrUDxJM8t7aAJNFW1jcBJ7/MTw4NMUo=;
        b=bdIBdAO6b/3lxCV/dbwyNrw/2bODdtg2tDJBis52yv9iygA4VbBdlRvQBOJyW0DpGo
         hqJmG3gAEk2dp+bDVxq2e29bN+Fg5F3Aa3XqtrW8ullFB4D3q27BbMLI+EQgNIGF+woK
         s4g5EbHkBf5KLLl15357FhLMzlRNvWVbqe6wiFUkiVVojI6MmAz3irnMrcz62LtBQ1JW
         BGBtzCId2j6Gbe2jZIJPays8xIZ4RSDoR2W/FkwNfVggXoQ9qjGZWbJve0FwbBlIpTHq
         kAHXKDKFvHom405jcdoE5SAbO1F2n6fmByKkN0P3uohOyMaQaeu1vdcOQtQ+bDl5/uOV
         AxbA==
X-Forwarded-Encrypted: i=1; AJvYcCUeql85tn9ijRWXx6cmPHhqsHQgxSgN9h/EJZUlhbSAmV2YznEm80uUg2CSHwTrZ82LJSc7oNSKLKJWxRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSQ86bPhclyhAPtY/G2Sx3ofMOH/Qch2VEO4hllcab1bRbyI1
	56wNmPBLtq2iCekWAX1dE0l4sQ1EZXn2jqIHUqmI0jzyI1fohq/0HzJo9nd5H343e1b0aZDsb4+
	nyvJlDrm+4GqFEli4c54elu1RkLQ=
X-Google-Smtp-Source: AGHT+IGsCWNOCIE/Z7UlfEcg3zLKNwIVlZQlvq8Y0kWXZTlbnIxjKHZOiwCGlaN02bADJjP64II4Tu7Udw+O85kKdeA=
X-Received: by 2002:a05:6402:27c7:b0:5c8:8610:98b0 with SMTP id
 4fb4d7f45d1cf-5c95ac4dcfcmr2923431a12.27.1728801153900; Sat, 12 Oct 2024
 23:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011071657.3032690-1-snovitoll@gmail.com> <CACzwLxj21h7nCcS2-KA_q7ybe+5pxH0uCDwu64q_9pPsydneWQ@mail.gmail.com>
 <CA+fCnZdasETx78HOLViEQHDZV1JS7ibzTbmfPzCb--3uN+tLiQ@mail.gmail.com>
In-Reply-To: <CA+fCnZdasETx78HOLViEQHDZV1JS7ibzTbmfPzCb--3uN+tLiQ@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 13 Oct 2024 11:33:27 +0500
Message-ID: <CACzwLxiWzNqPBp4C1VkaXZ2wDwvY3yZeetCi1TLGFipKW77drA@mail.gmail.com>
Subject: Re: [PATCH] kasan: migrate copy_user_test to kunit
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: akpm@linux-foundation.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 3:49=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Fri, Oct 11, 2024 at 11:12=E2=80=AFAM Sabyrzhan Tasbolatov
> <snovitoll@gmail.com> wrote:
> >
> > This has been tested on:
> > - x86_64 with CONFIG_KASAN_GENERIC
> > - arm64 with CONFIG_KASAN_SW_TAGS
> > - arm64 with CONFIG_KASAN_HW_TAGS
> >
> > - arm64 SW_TAGS has 1 failing test which is in the mainline,
> > will try to address it in different patch, not related to changes in th=
is PR:
> > [    9.480716]     # vmalloc_percpu: EXPECTATION FAILED at
> > mm/kasan/kasan_test_c.c:1830
> > [    9.480716]     Expected (u8)(__u8)((u64)(c_ptr) >> 56) < (u8)0xFF, =
but
> > [    9.480716]         (u8)(__u8)((u64)(c_ptr) >> 56) =3D=3D 255 (0xff)
> > [    9.480716]         (u8)0xFF =3D=3D 255 (0xff)
> > [    9.481936]     # vmalloc_percpu: EXPECTATION FAILED at
> > mm/kasan/kasan_test_c.c:1830
> > [    9.481936]     Expected (u8)(__u8)((u64)(c_ptr) >> 56) < (u8)0xFF, =
but
> > [    9.481936]         (u8)(__u8)((u64)(c_ptr) >> 56) =3D=3D 255 (0xff)
> > [    9.481936]         (u8)0xFF =3D=3D 255 (0xff)
>
> Could you share the kernel config that you use to get this failure?
> This test works for me with my config...
>

Here is config for arm64 with SW_TAGS:
https://gist.githubusercontent.com/novitoll/7ab93edca1f7d71925735075e84fc2e=
c/raw/7da07ae3c06009ad80dba87a0ba188934e31b8af/config-arm64-sw
, config for arm64 with HW_TAGS:
https://gist.githubusercontent.com/novitoll/7ab93edca1f7d71925735075e84fc2e=
c/raw/7da07ae3c06009ad80dba87a0ba188934e31b8af/config-arm64-hw

I've built them with defconfig, then chose in menuconfig KASAN,
enabled KUnit tests.

$ make CC=3Dclang LD=3Dld.lld AR=3Dllvm-ar NM=3Dllvm-nm STRIP=3Dllvm-strip
OBJCOPY=3Dllvm-objcopy \
 OBJDUMP=3Dllvm-objdump READELF=3Dllvm-readelf   HOSTCC=3Dclang HOSTCXX=3Dc=
lang++ \
 HOSTAR=3Dllvm-ar HOSTLD=3Dld.lld ARCH=3Darm64 defconfig
$ clang --version
ClangBuiltLinux clang version 14.0.6
(https://github.com/llvm/llvm-project.git
f28c006a5895fc0e329fe15fead81e37457cb1d1)
Target: x86_64-unknown-linux-gnu
Thread model: posix
$ qemu-system-aarch64 \
  -machine virt,mte=3Don \
  -cpu max \
  -smp 2 \
  -m 2048 \
  -hda $IMAGE \
  -kernel $KERNEL/arch/arm64/boot/Image \
  -append "console=3DttyAMA0 root=3D/dev/vda debug earlyprintk=3Dserial
net.iframes=3D0 slub_debug=3DUZ oops=3Dpanic panic_on_warn=3D1 panic=3D-1
ftrace_dump_on_oops=3Dorig_cpu" \
  -net user,hostfwd=3Dtcp::10023-:22 -net nic \
  -nographic \
  -pidfile vm.pid \
  2>&1

> > Here is my full console log of arm64-sw.log:
> > https://gist.githubusercontent.com/novitoll/7ab93edca1f7d71925735075e84=
fc2ec/raw/6ef05758bcc396cd2f5796a5bcb5e41a091224cf/arm64-sw.log
> >
> > - arm64 HW_TAGS has 1 failing test related to new changes
> > and AFAIU, it's known issue related to HW_TAGS:
> >
> > [ 11.167324] # copy_user_test_oob: EXPECTATION FAILED at
> > mm/kasan/kasan_test_c.c:1992
> > [ 11.167324] KASAN failure expected in "unused =3D
> > strncpy_from_user(kmem, usermem, size + 1)", but none occurred
> >
> > Here is the console log of arm64-hw.log:
> > https://gist.github.com/novitoll/7ab93edca1f7d71925735075e84fc2ec#file-=
arm64-hw-log-L11208
>
> I don't remember seeing this issue before, did you manage to figure
> out why this happens?
>

I haven't figured it out yet. All I've understood that for HW_TAGS,
KASAN_GRANULE_SIZE is MTE_GRANULE_SIZE (16),
and I've tried to tweak the buffer size in kunit test, where it's 128
- KASAN_GRANULE_SIZE,
I've also tried to understand the if branches in:

#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do { \
...
      if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) && \

, haven't made any progress on it.

I've faced a similar issue with HW_TAGS in:
https://lore.kernel.org/all/20241011035310.2982017-1-snovitoll@gmail.com/

and also see the comment from you (perhaps, not related):
https://bugzilla.kernel.org/show_bug.cgi?id=3D212205#c2

> Thank you for working on this!

Thanks, I'll address your comments in another reply.

