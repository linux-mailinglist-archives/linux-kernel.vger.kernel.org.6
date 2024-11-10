Return-Path: <linux-kernel+bounces-403294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162319C33B5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1381F210B6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C915C603;
	Sun, 10 Nov 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA4FEtr/"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475B4C3D0
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254659; cv=none; b=tWLn38u41qP59+44t2AxwgJRDAB0boVED2/chyFyyVctRBTLq+1h9fAtWwjYT2G9/m6MwAQMl5x+mUI8wbrjYoXXT3L7J1HZ1sGJigVu7xlCQGfW30+oeT8KTrNvx6u6mvd5A0ZcAQJv1b/1dEsl4UMBQl+SIVmE6+gIC2FQW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254659; c=relaxed/simple;
	bh=nHRE6WZmDmxm6cz61isRvnuji8FzBy90v8oGifTA5xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTNxcLUummE9zBVeAVfuqkMh0/6jOxbOidoy9mesff7tEm4NQpweBubrUgt6oJ70hIGnpRQ+uE6jsNwwimhXXrVrAzKfQ66LauhsEFK1yyRdgUko0rryRXr9NakQxQvCMPmWhHWQ+ntgBkLvtBcU5YzvUVffQBy2RE5SV864qY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SA4FEtr/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ea051d04caso29041987b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731254657; x=1731859457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CNLnBAFHpBPWxzZ1Zk0tYkCjdbAVe0IGKVgCD+DJas=;
        b=SA4FEtr/hzopnkH7U967oNgO5QdWCwEzBdNTjM7HdX2oEE2c0qSSEzfQ9osztVD+6E
         ZFged5bpCgktz9KPnP9wDA/wOwcemRnhiVPK1U0AQVPN3WnedZNC83WcHQvuLd9Aukke
         LbiS5Thpo0GlLCCQvLT1Gw3tdkBhsHM8ylbu5z8BH2rRqMm/on9VCtxGiCZGRrdQvx1J
         NE1x5NRJVXZmG0AeQ3A6c4D2VUTQYXYE/MKrC5rKl3ZBT1g/TTiCrCWFO9uEYszeqUio
         vn8bBs6AabFkWDhSgqkFWkV5FmH+A99kjr4jet3xXvo+gt30AmxHdz8GzDZdng2AK1RC
         4C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254657; x=1731859457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CNLnBAFHpBPWxzZ1Zk0tYkCjdbAVe0IGKVgCD+DJas=;
        b=U0i4YWws4Wtr18+fyShZ05m2jeHW2KuSgGkwKhUZDf+FPAdS/V4IHJ5/xhvJ0RhsOD
         cB+jMyVzOyx47ZkmUlftBpHx4mA4zBir89Q5SLBtG2fS2mqBn6zOtbF6QJqnBznRmbdx
         UeUCT3wfA2i0jWHICnY5k5uMPtKqiVkW5+xylvHbl9UXMp+Kyfuvp8asBAu/+cs3gFmB
         EQdk58Q1T/ZqCR8H44Zig1nu2lgvW1gVMigXnMYLkRSFnvdzWXJ3FYxcEYE49Ic9HrJu
         mLyqFX9WhPPaqqsrmD8hwKUsqhL/B3OFMd62uQxlFGv4/Vns/G/41v5U6SQmdYZK2a8S
         NJJw==
X-Forwarded-Encrypted: i=1; AJvYcCUtLfrATHl9zvzcrkOY7OTFpxBQi8dXlB8VvHH72F4YHm+kpcoU01EBl4hD98qYdwbh0SCUa0ryKrGvTRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yway0hMZ5ZlXlm3hRtneOUrLiAXtqmGMYRm7wjx63yFmyk6WErd
	MRkvNVwuTTPRzmsmT92GszuvvP5qqaSlsPnwIIQjDGAG6e6jKPIiDrCLMV79ZQT2N1N0oM97diP
	TcXWRiztSx0+dY6deUkR4Yz43rMyVvuuig8rd
X-Google-Smtp-Source: AGHT+IHYOc+K90gPkGm8yETeFrM7lrTDeWTKOwf1O8X62M9lupAJjFOOS+Dl9aJoc/4r3l5hr7bVY/C4FysxiRvsleM=
X-Received: by 2002:a05:690c:3501:b0:6dd:d0fa:159e with SMTP id
 00721157ae682-6eaddf8e3b9mr101861267b3.30.1731254657264; Sun, 10 Nov 2024
 08:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411091538.PGSTqUBi-lkp@intel.com>
In-Reply-To: <202411091538.PGSTqUBi-lkp@intel.com>
From: Willem de Bruijn <willemb@google.com>
Date: Sun, 10 Nov 2024 11:03:40 -0500
Message-ID: <CA+FuTScwvZDxX6OVAnde+hBCKp5P5UF74jFAL-6HEQ3v1Wg_sA@mail.gmail.com>
Subject: Re: net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer
 as NULL pointer
To: kernel test robot <lkp@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Guillaume Nault <gnault@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Howells <dhowells@redhat.com>, linux-hexagon@vger.kernel.org, bcain@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 3:00=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   da4373fbcf006deda90e5e6a87c499e0ff747572
> commit: 223f55196bbdb182a9b8de6108a0834b5e5e832e inet_diag: allow concurr=
ent operations
> date:   10 months ago
> config: hexagon-randconfig-r112-20241109 (https://download.01.org/0day-ci=
/archive/20241109/202411091538.PGSTqUBi-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5=
92c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce: (https://download.01.org/0day-ci/archive/20241109/202411091538=
.PGSTqUBi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as N=
ULL pointer
>
> vim +1511 net/ipv4/inet_diag.c
>
>   1503
>   1504  int inet_diag_register(const struct inet_diag_handler *h)
>   1505  {
>   1506          const __u16 type =3D h->idiag_type;
>   1507
>   1508          if (type >=3D IPPROTO_MAX)
>   1509                  return -EINVAL;
>   1510
> > 1511          return !cmpxchg((const struct inet_diag_handler **)&inet_=
diag_table[type],
>   1512                          NULL, h) ? 0 : -EEXIST;
>   1513  }
>   1514  EXPORT_SYMBOL_GPL(inet_diag_register);
>   1515


The code is still present in latest net-next.

But this appears specific to the hexagon architecture. Specifically to
that initialization of __oldval to 0.

define arch_cmpxchg(ptr, old, new)                             \
({                                                              \
        __typeof__(ptr) __ptr =3D (ptr);                          \
        __typeof__(*(ptr)) __old =3D (old);                       \
        __typeof__(*(ptr)) __new =3D (new);                       \
        __typeof__(*(ptr)) __oldval =3D 0;                        \

While here *ptr is of type const struct inet_diag_handler *.

Another typeof as cast seems to fix it:

+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -56,7 +56,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size=
)
        __typeof__(ptr) __ptr =3D (ptr);                          \
        __typeof__(*(ptr)) __old =3D (old);                       \
        __typeof__(*(ptr)) __new =3D (new);                       \
-       __typeof__(*(ptr)) __oldval =3D 0;                        \
+       __typeof__(*(ptr)) __oldval =3D (__typeof__(*(ptr))) 0;   \

Easily reproduced with

make LLVM=3D1 ARCH=3Dhexagon defconfig
make C=3D1 LLVM=3D1 ARCH=3Dhexagon net/ipv4/inet_diag.o

