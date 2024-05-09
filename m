Return-Path: <linux-kernel+bounces-173972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033418C0880
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB31F22547
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C02DF78;
	Thu,  9 May 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b9VmarQQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70010A11
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214804; cv=none; b=TTdSWv4hQIjfIrIa9JJJpTzT/EJlvFdi+/loa/W59Esq/HocbVr06/OIQZIteKoSyq2I79ds2ue2shwyY5uhguNU+yE5J01rqI/DBsJQVA2E7qaABfLeWzsQNjPQoMb4Z7nDw8C/oG18eR9w4q8JLIVTqFh5DA3bc8GhaAsJnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214804; c=relaxed/simple;
	bh=WG4czILDt53siornOU9hqky9v48XQnah+U0TvgVsuW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5HWoOvs4XjsFn4FLjLWg1j5ly3aHCZbTUzdXMG9WBjOfj60e5mPz6ksvz+7rR0sFz3DBBlKPo10anJFCZWrg0FTwIyoX6UC5gdGzMixHjAabK537Lp+qZedYJVQqCTziJWr8tV5CvMctumf2dnpxgL3G4ciIie0FLeRWA/2aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b9VmarQQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f457853950so1040949b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715214802; x=1715819602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryuqORYcPz0+pc/IX1bINOqGn4QcbQeAD0aN/YcW+a0=;
        b=b9VmarQQmGnZVwlYYCKI1dKEuvGy6FeHSO5htSh5d9qy7KlDT0YIsLFCAidN0xFEV0
         AmaiMfbxBsPhFMG7lJRwPtKGIriYreDkLdf0eLAJZjV4JfylpYcuYvI9wQZpCkWqkID3
         Kn/jwuYWE0gHBXXhn90mfmkrdf6kDiW44fyWel0vuH7Rsziv5omqhKnAyOP/tCAQbQyS
         AZRzQcfTj1qnZtcc96LGO8OMcxm0bU2Tgzb5iGEVL8cTWWFmSnhHBy9USAsCLMEvAmk+
         0wYZCbhE6QGS/WXtGgQYDTghTNGxLDHKIIWMCq1OUzrFJfX5iXRAge7zav/1HV7y6/Qv
         ozHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214802; x=1715819602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryuqORYcPz0+pc/IX1bINOqGn4QcbQeAD0aN/YcW+a0=;
        b=Rg+7muS1zLETSZq/DsZQdDCXy21rVhVEpxoA1x/Xjo5ClsCyxT+7rFtBqs18ZsLDM5
         ChgWqVxdZx1Uvg2xz6T05NC7rPOz5YF1j/Y2S5BEVq1pwWtzAXmwyGxgLr7+oULckeWt
         AlscXcYOGHM+k6sXDT0rG9suBqJPt/T3+rfF7bJ27dC4SzhK2KMMwCqWrWRokXoNl9QP
         R8dMxtMhigbAvM6qri3/5pkK81+By+kFkRKX+qzo8oOy+SnKRSKNcdEK4+RkVFyKlTP/
         f/yA7Jkcg6rKRIlr6g6nZO/TKI2fl+cusZWt2kySTnrwegeVXlv/8IM5jQrG05S0LXos
         9jUA==
X-Forwarded-Encrypted: i=1; AJvYcCVV0B59ICPFvOXC7/Us2d+/B3MwNY6cGxCXCQdOmwhifQjdlN++xs8buXwlFYG9euANz/XEau28fsxDP2ZR434o9rNzCaTw9x71Q47j
X-Gm-Message-State: AOJu0YxBA4+boW1J6MmJkDAGNC1H+nmFMXWMVxXSp3iF9uyR2VXoFPQ/
	vXxWUxPlUP5dM69UHbGtOuVaUIi7gOWAFhvoJnML5iTXw1BY+PuN7DiLSqsE49M=
X-Google-Smtp-Source: AGHT+IHdropjLT7GTh0X7WVpcuGcFXvciZz0PPopuVK7WREz89rBGsBlLrTpoRWlSn9JTjqGGz8pew==
X-Received: by 2002:a17:90a:d50b:b0:2a5:be1a:6831 with SMTP id 98e67ed59e1d1-2b65fe213cfmr1805609a91.19.1715214801866;
        Wed, 08 May 2024 17:33:21 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:4144:6911:574f:fec1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ac21sm169379a91.30.2024.05.08.17.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 17:33:21 -0700 (PDT)
Date: Wed, 8 May 2024 17:33:15 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 00/29] riscv control-flow integrity for usermode
Message-ID: <ZjwZy7bvR9h/+P3e@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:34:48PM -0700, Deepak Gupta wrote:
> Sending out v3 for cpu assisted riscv user mode control flow integrity.
> 
> v2 [9] was sent a week ago for this riscv usermode control flow integrity
> enabling. RFC patchset was (v1) early this year (January) [7].
> 
> changes in v3
> --------------
> envcfg:
> logic to pick up base envcfg had a bug where `ENVCFG_CBZE` could have been
> picked on per task basis, even though CPU didn't implement it. Fixed in
> this series.
> 
> dt-bindings:
> As suggested, split into separate commit. fixed the messaging that spec is
> in public review
> 
> arch_is_shadow_stack change:
> arch_is_shadow_stack changed to vma_is_shadow_stack
> 
> hwprobe:
> zicfiss / zicfilp if present will get enumerated in hwprobe
> 
> selftests:
> As suggested, added object and binary filenames to .gitignore
> Selftest binary anyways need to be compiled with cfi enabled compiler which
> will make sure that landing pad and shadow stack are enabled. Thus removed
> separate enable/disable tests. Cleaned up tests a bit.
> 
> changes in v2
> ---------------
> As part of testing effort, compiled a rootfs with shadow stack and landing
> pad enabled (libraries and binaries) and booted to shell. As part of long
> running tests, I have been able to run some spec 2006 benchmarks [8] (here
> link is provided only for list of benchmarks that were tested for long
> running tests, excel sheet provided here actually is for some static stats
> like code size growth on spec binaries). Thus converting from RFC to
> regular patchset.
> 
> Securing control-flow integrity for usermode requires following
> 
>     - Securing forward control flow : All callsites must reach
>       reach a target that they actually intend to reach.
> 
>     - Securing backward control flow : All function returns must
>       return to location where they were called from.
> 
> This patch series use riscv cpu extension `zicfilp` [2] to secure forward
> control flow and `zicfiss` [2] to secure backward control flow. `zicfilp`
> enforces that all indirect calls or jmps must land on a landing pad instr
> and label embedded in landing pad instr must match a value programmed in
> `x7` register (at callsite via compiler). `zicfiss` introduces shadow stack
> which can only be writeable via shadow stack instructions (sspush and
> ssamoswap) and thus can't be tampered with via inadvertent stores. More
> details about extension can be read from [2] and there are details in
> documentation as well (in this patch series).
> 
> Using config `CONFIG_RISCV_USER_CFI`, kernel support for riscv control flow
> integrity for user mode programs can be compiled in the kernel.
> 
> Enabling of control flow integrity for user programs is left to user runtime
> (specifically expected from dynamic loader). There has been a lot of earlier
> discussion on the enabling topic around x86 shadow stack enabling [3, 4, 5] and
> overall consensus had been to let dynamic loader (or usermode) to decide for
> enabling the feature.
> 
> This patch series introduces arch agnostic `prctls` to enable shadow stack
> and indirect branch tracking. And implements them on riscv. arm64 is expected
> to implement shadow stack part of these arch agnostic `prctls` [6]
> 
> Changes since last time
> ***********************
> 
> Spec changes
> ------------
> - Forward cfi spec has become much simpler. `lpad` instruction is pseudo for
>   `auipc rd, <20bit_imm>`. `lpad` checks x7 against 20bit embedded in instr.
>   Thus label width is 20bit.
> 
> - Shadow stack management instructions are reduced to
>     sspush - to push x1/x5 on shadow stack
>     sspopchk - pops from shadow stack and comapres with x1/x5.
>     ssamoswap - atomically swap value on shadow stack.
>     rdssp - reads current shadow stack pointer
> 
> - Shadow stack accesses on readonly memory always raise AMO/store page fault.
>   `sspopchk` is load but if underlying page is readonly, it'll raise a store
>   page fault. It simplifies hardware and kernel for COW handling for shadow
>   stack pages.
> 
> - riscv defines a new exception type `software check exception` and control flow
>   violations raise software check exception.
> 
> - enabling controls for shadow stack and landing are in xenvcfg CSR and controls
>   lower privilege mode enabling. As an example senvcfg controls enabling for U and
>   menvcfg controls enabling for S mode.
> 
> core mm shadow stack enabling
> -----------------------------
> Shadow stack for x86 usermode are now in mainline and thus this patch
> series builds on top of that for arch-agnostic mm related changes. Big
> thanks and shout out to Rick Edgecombe for that.
> 
> selftests
> ---------
> Created some minimal selftests to test the patch series.
> 
> 
> [1] - https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
> [2] - https://github.com/riscv/riscv-cfi
> [3] - https://lore.kernel.org/lkml/ZWHcBq0bJ+15eeKs@finisterre.sirena.org.uk/T/#mb121cd8b33d564e64234595a0ec52211479cf474
> [4] - https://lore.kernel.org/all/20220130211838.8382-1-rick.p.edgecombe@intel.com/
> [5] - https://lore.kernel.org/lkml/CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com/
> [6] - https://lore.kernel.org/linux-mm/20231122-arm64-gcs-v7-2-201c483bd775@kernel.org/
> [7] - https://lore.kernel.org/lkml/20240125062739.1339782-1-debug@rivosinc.com/
> [8] - https://docs.google.com/spreadsheets/d/1_cHGH4ctNVvFRiS7hW9dEGKtXLAJ3aX4Z_iTSa3Tw2U/edit#gid=0
> [9] - https://lore.kernel.org/lkml/20240329044459.3990638-1-debug@rivosinc.com/
> 

This is a note for people wanting to test this series.

1. Need a toolchain that has CFI support

$ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
$ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
$ make -j$(nproc)

2. QEMU

$ git clone git@github.com:deepak0414/qemu.git -b zicfilp_zicfiss_mar24_spec_v8.1.1
$ cd qemu
$ mkdir build
$ cd build
$ ../configure --target-list=riscv64-softmmu
$ make -j$(nproc)

3. OpenSBI

$ git clone git@github.com:deepak0414/opensbi.git -b cfi_spec_split_opensbi
$ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic

4. Linux

Running defconfig is fine. CFI is enabled by default if the toolchain
supports it.

$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)

5. Running

Modify your qemu command to have:
-bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
-cpu rv64,zicfilp=true,zicfiss=true

- Charlie


