Return-Path: <linux-kernel+bounces-521438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B26A3BD5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C2B189B1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD811DF726;
	Wed, 19 Feb 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUKlXN2f"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5681C5F1B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965594; cv=none; b=Eh6huZIwFAtb0ZkWwnrrCIGr7dGkaySPtGIAotN33TrZDCR8+61lnAHPFLtxKUJOaYNUXYkhtowUTwViMIub1MKlz8/DAUxhRNViYBI/bKQEqGA7xlDmDKM2CzLtv6BfOMKItf0F6lZr1ytRT4hfVviolQBG3YlSIRiF7Eo37ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965594; c=relaxed/simple;
	bh=W5u1FrXnUB5o2ySGCDV+bt2qhFs4I8vgtzJs7ugYWFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEBqmUWxLotQM3KQyo/+GsSxIwcJVtGSDt8z5TaDV6An7OXKPvoeK2l+/2cTgcaftH8QYcjbohKPadNO+XJREc0AvTqYH4DWvirycaBGbXRxc74y+yOPHe8MthD/lhFEEw1Ne+QjGZIrL1GJVqrv45F7wKMDDuInxUgBNZVJXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUKlXN2f; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-866faa61728so3985922241.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739965592; x=1740570392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HAi+JPAWVvmwhTEypy4+thacQq13MfYR6lEe+X0Q8c=;
        b=bUKlXN2fmNTmjGisVZM7kb0RubGXqzQz3RJgwR6z3z5V7nmjVnypJqcPW2I+9yn2hK
         FdNc7WF5l/X6kF7GQHBeekKVh0J3Ipnj8AfX1eV/CEaE1fcf5n2BB3y49njcnvJvdJfw
         3CUV45bIP8+hdry0HG+4w0N41d016/rgx/xQEaXX9p8HFnSDTzJZLJpKWWg3CzZMd60c
         rxYqBJjnKz8ZQoF0lZoY5ImfnTttBgzfHSC83FTNmq1POT1YwhBIbdbnj6fIorYNulQZ
         0lZc6+jVUCITR3jPehKhpD038mlMoH7Yt4wbztthRyiiY5pubJWCAlDFxIezVRzt4UIZ
         nAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965592; x=1740570392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HAi+JPAWVvmwhTEypy4+thacQq13MfYR6lEe+X0Q8c=;
        b=C+g6GAzo19tAv3TtQsGUeE8Zxv0wz7VDR3u3qnQMRJALrKdfFDS6VPHBv3PpgW4zH0
         HCe4l0ztKkeKvX0YYVdvROvNElVqTafnEf9TDmaV1JjEU1HLhaBpAPY5vzroCE5Cwg3s
         cBytYT3OuNb8pJ7ygtZbiIaguRDOxdALAtmwrpgXyvEgtvAMhYOv5eYZnamK4miFh/2e
         3KXmsUA5qBoOlr4gVt7AmtyFKIgrlLdFeiSl/aqi7jG5bJ8zTkmTXikoKsDLx+GU12jz
         nENpqrsGd6++I8hy1/djiQ0dSLvCq/P/Kw11CAr8XcrOuG0zXv4OeqwJ8lev0bP0Uuwx
         Y4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUJFsIksCERG3gIoaBqSJRZAibkiLhQ3YH076IJd5FRGM2DI51C6K1DHGrxFMjLGtZCwotuyZpMcqvjZMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzENfeFqhheNxY2+VLn1fY+jwkNfjFXTIuPiVxTj+AYAUw1q3S/
	82AYZN69O/mn79jQ952nTbPVxuI44dV6ZOpso/g0omU86QsN9VPUnDualDBYmotMf7k/F0rZ9fk
	DsUH3FG9iD4l6sUFxNc+mbeMw4zjRTYYrSPdwQg==
X-Gm-Gg: ASbGncux7gIxr9gB431I3dTGg4WLo3gzA0TgtLwLWBTbxm3MPQQL0/r0K6J5Xx+by82
	Np/7Z5Fb0+GNXRh4JwxLPe9kuZZ+sZANlaxNswIai+M2LirjnQlzK1eZB+8h84RJQas5bIGoD9U
	c=
X-Google-Smtp-Source: AGHT+IEZMwel+bdv06rxq65I3rJQXcMsB1FE/5DSKjDmaNs3ziyhRih3YYHUPsKR/IZQx53GRqU+Jzw+0+WRrQS8RNc=
X-Received: by 2002:a05:6102:3f9e:b0:4bc:de7e:415d with SMTP id
 ada2fe7eead31-4be85c05531mr1674046137.13.1739965591759; Wed, 19 Feb 2025
 03:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206155234.095034647@linuxfoundation.org> <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com> <2025021739-jackpot-lip-09f9@gregkh>
In-Reply-To: <2025021739-jackpot-lip-09f9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Feb 2025 17:16:19 +0530
X-Gm-Features: AWEUYZlyd4o7hzsRTR-wDg8_BLL7BUQwlm0UHAZOQ22uI97jC6UQqnJWmLWSRIs
Message-ID: <CA+G9fYtJzD8+BkyBZEss9Vvv2f=8tJUcSyWDGjyOshj1D5hMyA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org, 
	Pankaj Raghav <p.raghav@samsung.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 17:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 17, 2025 at 05:00:43PM +0530, Naresh Kamboju wrote:
> > On Sat, 8 Feb 2025 at 16:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 6 Feb 2025 at 21:36, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 6.6.76 release.
> > > > There are 389 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Sat, 08 Feb 2025 15:51:12 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.76-rc2.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > >
> > > There are three different regressions found and reporting here,
> > > We are working on bisecting and investigating these issues,
> >
> > We observed a kernel warning on QEMU-ARM64 and FVP while running the
> > newly added selftest: arm64: check_hugetlb_options. This issue appears
> > on 6.6.76 onward and 6.12.13 onward, as reported in the stable review [1].
> > However, the test case passes successfully on stable 6.13.
> >
> > The selftests: arm64: check_hugetlb_options test was introduced following
> > the recent upgrade of kselftest test sources to the stable 6.13 branch.
> > As you are aware, LKFT runs the latest kselftest sources (from stable
> > 6.13.x) on 6.12.x, 6.6.x, and older kernels for validation purposes.
> >
> > >From Anders' bisection results, we identified that the missing patch on
> > 6.12 is likely causing this regression:
> >
> > First fixed commit:
> > [25c17c4b55def92a01e3eecc9c775a6ee25ca20f]
> > hugetlb: arm64: add MTE support
> >
> > Could you confirm whether this patch is eligible for backporting to
> > 6.12 and 6.6 kernels?
> > If backporting is not an option, we will need to skip running this
> > test case on older kernels.
>
> The test case itself should properly "skip" if the feature is not
> present in the kernel.  Why not fix that up instead?

The reported test gets PASS at the end, but generates kernel warning
while running the test case (always reproducible) on 6.12 and 6.6.

The reported warning was not seen on stable 6.13.

# Test log:

# selftests: arm64: check_hugetlb_options
# 1..12
# ok 1 Check hugetlb memory with private mapping, sync error mode,
mmap memory and tag check off
# ok 2 Check hugetlb memory with private mapping, no error mode, mmap
memory and tag check off
# ok 3 Check hugetlb memory with private mapping, sync error mode,
mmap memory and tag check on
# ok 4 Check hugetlb memory with private mapping, sync error mode,
mmap/mprotect memory and tag check on
# ok 5 Check hugetlb memory with private mapping, async error mode,
mmap memory and tag check on
# ok 6 Check hugetlb memory with private mapping, async error mode,
mmap/mprotect memory and tag check on
# ok 7 Check clear PROT_MTE flags with private mapping, sync error
mode and mmap memory
# ok 8 Check clear PROT_MTE flags with private mapping and sync error
mode and mmap/mprotect memory
# ok 9 Check child hugetlb memory with private mapping, precise mode
and mmap memory
------------[ cut here ]------------
[   96.920028] WARNING: CPU: 1 PID: 3611 at
arch/arm64/mm/copypage.c:29 copy_highpage
(arch/arm64/include/asm/mte.h:87)
[   96.922100] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
[   96.925603] CPU: 1 PID: 3611 Comm: check_hugetlb_o Not tainted 6.6.76-rc2 #1
[   96.926956] Hardware name: linux,dummy-virt (DT)
[   96.927695] pstate: 43402009 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   96.928687] pc : copy_highpage (arch/arm64/include/asm/mte.h:87)
[   96.929037] lr : copy_highpage
(arch/arm64/include/asm/alternative-macros.h:232
arch/arm64/include/asm/cpufeature.h:443
arch/arm64/include/asm/cpufeature.h:504
arch/arm64/include/asm/cpufeature.h:814 arch/arm64/mm/copypage.c:27)
[   96.929399] sp : ffff800088aa3ab0
[   96.930232] x29: ffff800088aa3ab0 x28: 00000000000001ff x27: 0000000000000000
[   96.930784] x26: 0000000000000000 x25: 0000ffff9b800000 x24: 0000ffff9b9ff000
[   96.931402] x23: fffffc0003257fc0 x22: ffff0000c95ff000 x21: ffff0000c93ff000
[   96.932054] x20: fffffc0003257fc0 x19: fffffc000324ffc0 x18: 0000ffff9b800000
[   96.933357] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   96.934091] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   96.935095] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   96.935982] x8 : 0bfffc0001800000 x7 : 0000000000000000 x6 : 0000000000000000
[   96.936536] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   96.937089] x2 : 0000000000000000 x1 : ffff0000c9600000 x0 : ffff0000c9400080
[   96.939431] Call trace:
[   96.939920] copy_highpage (arch/arm64/include/asm/mte.h:87)
[   96.940443] copy_user_highpage (arch/arm64/mm/copypage.c:40)
[   96.940963] copy_user_large_folio (mm/memory.c:5977 mm/memory.c:6109)
[   96.941535] hugetlb_wp (mm/hugetlb.c:5701)
[   96.941948] hugetlb_fault (mm/hugetlb.c:6237)
[   96.942344] handle_mm_fault (mm/memory.c:5330)
[   96.942794] do_page_fault (arch/arm64/mm/fault.c:513
arch/arm64/mm/fault.c:626)
[   96.943341] do_mem_abort (arch/arm64/mm/fault.c:846)
[   96.943797] el0_da (arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:547)
[   96.944229] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
[   96.944765] el0t_64_sync (arch/arm64/kernel/entry.S:599)
[ 96.945383] ---[ end trace 0000000000000000 ]---#
ok 10 Check child hugetlb memory with private mapping, precise mode
and mmap memory
# ok 11 Check child hugetlb memory with private mapping, precise mode
and mmap/mprotect memory
# ok 12 Check child hugetlb memory with private mapping, precise mode
and mmap/mprotect memory
# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: arm64: check_hugetlb_options

Links:
 - https://lore.kernel.org/all/CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com/

>
> thanks,
>
> greg k-h

- Naresh

