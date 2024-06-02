Return-Path: <linux-kernel+bounces-198430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA18D7823
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C6E1C20920
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0FB76EEA;
	Sun,  2 Jun 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIE1Ikuw"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653131F60A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360739; cv=none; b=blTzlYidR20ts5C9osNJgmeZG7L2uWaEQXYoEFYwbw9SvSCtWWn2YcH4ZoZXPUEWMfSe4+DPhra3t9jvzmQRYH7mZKc9Fz+eIusjBbAGc08pcTsa5M1VZvRoDc3UCZVqQrapUMX+y2uKwb+/AXRLEJHthf0ATrPeY70wb/64HsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360739; c=relaxed/simple;
	bh=w7XyO3jj/A8PkJsMTyeQc63HNZlDPGHvtED/1g3cN0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLdgdxAg4e6rnUb3EeL4pEOPmFGqzwSKFs21vdpw65plFgsO32udaLtNC7QDJRYcO+gyHQlL9GI0L1yCcoENhnA8XiQVixpvs3ZLf7OC05ng6PCFvnDzun3r4B9w5skgudoLyR5gpHlRHQYP5AmmXGqLwbfwa2ZMNflpdi9folY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIE1Ikuw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so16385e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360736; x=1717965536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfldORuTjlVpAnJ3Ucw4knFWPlGKfdDgSo69+8PCJyE=;
        b=nIE1IkuwnO+9f5vj75oTJchav2sH0xcWBR8N4DeC5VEaXOARDnRp+K8vnY6Q6n9zI1
         U0+p5bKvevcIUpM0SCUOFcKKesJcoXYKSdyGP6aO0KpR3lhYhDmGttiOsAz6FNKvjYt1
         UULP5b9leFOriIGH/I7SkX48bYrlCUs7LI2h2ENc6gOkuNhcWwkLZfUT5vAAGNNFckEg
         iOoJMEb17hKJN1k5B0D308uXDcuWfIGjAU4RsLO9UgwiKZqCCUEg34ojwmLm9dpFO0xy
         onl7y/T91SzGYc9mIhwXz2NTx3iYlvZuGnC+2LfZe6/HMwM3x+yKFSYIzPihljaMWnTL
         7opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360736; x=1717965536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfldORuTjlVpAnJ3Ucw4knFWPlGKfdDgSo69+8PCJyE=;
        b=tkSrdIyRAuwTDXlR498SDlHctRkpXRdJb/F2Emky3+PkBn+I8nVY/HDCh2GjsXvi20
         FCapU4R94YrUJf+qR5yzlf9RXzuA9vnoTjxCNyxi2/FJPmRpzj6E2tnel5VdNecJfETa
         mQ6/WmIHxh+TxJnH7KXBJtLzUADu5KigkdGUZxSzesBWKIW5NukgNglKWbXIuewLRv0z
         bQQfWb2OEOWANErOUcohg5cSPJXO88CpVm2naCWMGTfva9QqWYTAy7NR4XIgh7Ok8hgV
         1UEiUmhbkKTaiBlIr8+bE/tltsaXVx+YJ+btrUPwTl/QKlWYUKKIfvaN05hW8DPFPV28
         4HJA==
X-Forwarded-Encrypted: i=1; AJvYcCUNVJi47or37CxG+5ubbY06jYJOa4CuPv3R9nBdLnAZYZD8F3i2CObvbolslF+vUJE5eGlMEiXQjhxkUsCV6+ngSt9JxKTpgeSnjypq
X-Gm-Message-State: AOJu0YyHCqMFRWLPVKOxNeS5gr7xyNy9pC5Ldo6s9cfvwuqAl8ZFzvIj
	DRWCpBWrAyhZv1dHZs/L0BaaQXkP8HGRJR29VsN8i0p0wx4tFFGgpdg82hSy04kb/2uHr/iT+25
	T8l0Bn2pAwtlarp5r0m7lqWcDFo14RsPWGcR7
X-Google-Smtp-Source: AGHT+IFFroboW96WPdvdwnL4DyxgbhQ5ulmPuS+yGKYAppow/rIDCpVjA8jHAiaBb0HM8OYqH+auJiagPkOKXUL7hhs=
X-Received: by 2002:a05:600c:1d27:b0:421:328e:99db with SMTP id
 5b1f17b1804b1-421358b2ea5mr2182435e9.1.1717360735443; Sun, 02 Jun 2024
 13:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com> <20240602200332.3e531ff1@yea>
In-Reply-To: <20240602200332.3e531ff1@yea>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 2 Jun 2024 14:38:18 -0600
Message-ID: <CAOUHufY=pTHTkz1acsvo-Ox-xVR7_3gaCDftVWj6bz1kzW=v=w@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 12:03=E2=80=AFPM Erhard Furtner <erhard_f@mailbox.or=
g> wrote:
>
> On Sat, 1 Jun 2024 00:01:48 -0600
> Yu Zhao <yuzhao@google.com> wrote:
>
> > Hi Erhard,
> >
> > The OOM kills on both kernel versions seem to be reasonable to me.
> >
> > Your system has 2GB memory and it uses zswap with zsmalloc (which is
> > good since it can allocate from the highmem zone) and zstd/lzo (which
> > doesn't matter much). Somehow -- I couldn't figure out why -- it
> > splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:
> >
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> > [    0.000000]   Normal   empty
> > [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> >
> > The kernel can't allocate from the highmem zone -- only userspace and
> > zsmalloc can. OOM kills were due to the low memory conditions in the
> > DMA zone where the kernel itself failed to allocate from.
> >
> > Do you know a kernel version that doesn't have OOM kills while running
> > the same workload? If so, could you send that .config to me? If not,
> > could you try disabling CONFIG_HIGHMEM? (It might not help but I'm out
> > of ideas at the moment.)
> >
> > Thanks!
>
> Hi Yu!
>
> Thanks for looking into this.
>
> The reason for this 0.25GB DMA / 1.75GB highmem split is beyond my knowle=
dge. I can only tell this much that it's like this at least since kernel v4=
.14.x (dmesg of an old bugreport of mine at https://bugzilla.kernel.org/sho=
w_bug.cgi?id=3D201723), I guess earlier kernel versions too.
>
> Without CONFIG_HIGHMEM the memory layout looks like this:
>
> Total memory =3D 768MB; using 2048kB for hash table
> [...]
> Top of RAM: 0x30000000, Total RAM: 0x30000000
> Memory hole size: 0MB
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x000000002fffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x000000002fffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x000000002fffffff]
> percpu: Embedded 29 pages/cpu s28448 r8192 d82144 u118784
> pcpu-alloc: s28448 r8192 d82144 u118784 alloc=3D29*4096
> pcpu-alloc: [0] 0 [0] 1
> Kernel command line: ro root=3D/dev/sda5 slub_debug=3DFZP page_poison=3D1=
 netconsole=3D6666@192.168.2.8/eth0,6666@192.168.2.3/A8:A1:59:16:4F:EA debu=
g
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> Built 1 zonelists, mobility grouping on.  Total pages: 194880
> mem auto-init: stack:all(pattern), heap alloc:off, heap free:off
> Kernel virtual memory layout:
>   * 0xffbdf000..0xfffff000  : fixmap
>   * 0xff8f4000..0xffbdf000  : early ioremap
>   * 0xf1000000..0xff8f4000  : vmalloc & ioremap
>   * 0xb0000000..0xc0000000  : modules
> Memory: 761868K/786432K available (7760K kernel code, 524K rwdata, 4528K =
rodata, 1100K init, 253K bss, 24564K reserved, 0K cma-reserved)
> [...]
>
> With only 768 MB RAM and 2048K hashtable I get pretty much the same "kswa=
pd0: page allocation failure: order:0, mode:0xcc0(GFP_KERNEL),nodemask=3D(n=
ull),cpuset=3D/,mems_allowed=3D0" as with the HIGHMEM enabled kernel at
> running "stress-ng --vm 2 --vm-bytes 1930M --verify -v".
>
> I tried the workload on v6.6.32 LTS where the issue shows up too. But v6.=
1.92 LTS seems ok! Triple checked v6.1.92 to be sure.
>
> Attached please find kernel v6.9.3 dmesg (without HIGHMEM) and kernel v6.=
1.92 .config.

Thanks.

I compared the .config between v6.8.9 (you attached previously) and
v6.1.92 -- I didn't see any major differences (both have ZONE_DMA,
HIGHMEM, MGLRU and zswap/zsmalloc). Either there is something broken
between v6.1.92 and v6.6.32 (as you mentioned above), or it's just a
kernel allocation bloat which puts the DMA zone (0.25GB) under too
heavy pressure. The latter isn't uncommon when upgrading to a newer
version of the kernel.

Could you please attach the dmesg from v6.1.92? I want to compare the
dmegs between the two kernel versions as well -- that might provide
some hints.

