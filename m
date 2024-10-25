Return-Path: <linux-kernel+bounces-382180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3CA9B0A72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446F6282D70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9C20BB2C;
	Fri, 25 Oct 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gW8dV9sJ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F11FB8A9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875490; cv=none; b=D8/MNB+EzSZUBNKaMC6VZsOWthP3TS27lIVQk1ABFo4zM7XZoNFIeRksFIcfN+W/Ttx3oc6EC+7+WxsoWEQRAPjC3YEfB1KwghOepmotsKnYNc2+HpWiQg1d53rEKFYteTpuh24QuJt5YfVD7+aKcONDggYAYc4+Z/1wPyN8HSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875490; c=relaxed/simple;
	bh=gBji1iKPogbN1GllzSKm4KJasKl61k+qGo9SkmDkjUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdhXYrJXo2LEE8agQLhuoPwdOuJl1vZHvt/L0+Wbfcg4FWDWI+tH8pDb3N9AExnGG0TNHsrlkq8q1w3nBxu4o2OnEBryRFlWovUgz5HMLe1Su5xdk4ykIQLmy46CT8H6uxJg8cBZrKTS6gYjFYbFEkvgf3bMeyVJOdSFfVQTyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gW8dV9sJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb51f39394so24023911fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729875486; x=1730480286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnNtZV1Nj+ZplC7sJE1rA3hnVfsCt9+YnjfLdsGByNU=;
        b=gW8dV9sJE7yjrghuytA4Sy0fU0VQMXerKOu+Ds5SE+EmyYrtzByJyfqa6s3lVfQJDj
         eR0llIN/SseBGC1SLPX//HLsFSvNfsMkvNn4Pt6o+eAaFGvhyhKS2uocZQbeXniT8AZV
         31arHGjVEAp+s7xyoLarJFsQn3qC3n/Xr4gBNjw8gui17u8t3IfLBUEC78384JrLTWW5
         8PkdmwnQo06HJSmA/GTd5AmLPvnS7bm1d5dq02cXfoFDqJ4GNh3Ci8u6Y2P/HhFntawY
         hTa5ITfWIRuhFZLoxwoHh8B0glRU6lAo16YupPtzsny7qX4gbCNQPofbjLa42IRF6ti4
         1CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875486; x=1730480286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnNtZV1Nj+ZplC7sJE1rA3hnVfsCt9+YnjfLdsGByNU=;
        b=J/ZIqQXLfCj1SBLOOdqEQ0E46W5GisSlQKViBsHADAUYa40Os+TWe8xDL7y5AqLmFG
         B/9Wx7W0+Obf9/MfVLCQspLibGRgzbJAJrYfMwN/qfgpG4MSSsg4SW/8aTuTbj/lOIsp
         2Oc7HRG4nI57hoR987QUhQYxtFKG1CnSH/cWre7+5aWlZoqVXOW8Zq20xcoVE+JPVCIk
         BLJs2nB8ZZwKDjik96WwOOQ13pXgmcDhHEnwfx2FoM7z01yy/EZa9suhpAfxaMUbe2if
         6umcmJn9wpYom9T0+fLgvwmDN+0dyXujNBO/6NZDnhPj1eGBQI03+LhPVpEDYI7CWY9A
         IMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuGCSx3/j4wk7epnwHlcaA89vH+ZXJKM27sza9P//tG0eAqoy1UaCE96Tjz1FB+tcVzP+z38tgLH8AyVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLr64iSWCPLRQZHtKBy9Xi8pS0cjHcoJjleJE9H+x/v2yi66Ut
	BkxRwRON2miv19A3fNkAK6iHqxbRrDPZKG4SDlsLqgTW1WQf4fm8w/7oAErNX8LVbCdYOTIGPiK
	LQgLql0K6o8pbDI0L+eMjqnSXEsmJngQNvOEN0A==
X-Google-Smtp-Source: AGHT+IGkuarMMIQ+lexEInGHQT599Zcgs3u7VHe9+e328XtdhOpOUCnZpi5ObKnAGmst12pwrMUGM9L80YD5HY+KpX8=
X-Received: by 2002:a2e:d12:0:b0:2fb:3a12:a582 with SMTP id
 38308e7fff4ca-2fca8227c1emr34732541fa.23.1729875485826; Fri, 25 Oct 2024
 09:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020194734.58686-1-apatel@ventanamicro.com>
In-Reply-To: <20241020194734.58686-1-apatel@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 25 Oct 2024 22:27:54 +0530
Message-ID: <CAK9=C2VS6=azRSqXmkuFfp+65s4PUe+GbcTrYwLxQwfB4iB4_Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Accelerate KVM RISC-V when running as a guest
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:17=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> The KVM RISC-V hypervisor might be running as a guest under some other
> host hypervisor in which case the complete H-extension functionality will
> be trap-n-emulated by the host hypervisor. In this case, the KVM RISC-V
> performance can be accelerated using the SBI nested acceleration (NACL)
> extension if the host hypervisor provides it.
>
> These series extends KVM RISC-V to use SBI NACL extension whenever
> underlying SBI implementation (aka host hypervisor) provides it.
>
> These patches can also be found in the riscv_sbi_nested_v2 branch at:
> https://github.com/avpatel/linux.git
>
> To test these patches, run KVM RISC-V as Guest under latest Xvisor
> found at: https://github.com/xvisor/xvisor.git
>
> For the steps to test on Xvisor, refer the Xvisor documentation
> <xvisor_source>/docs/riscv/riscv64-qemu.txt with two small changes:
>
> 1) In step#11, make sure compressed kvm.ko, guest kernel image, and
>    kvmtool are present in the rootfs.img
> 2) In step#14, make sure AIA is available to Xvisor by using
>    "virt,aia=3Daplic-imsic" as the QEMU machine name.
>
> Changes since v1:
>  - Dropped nacl_shmem_fast() macro from PATCH8
>  - Added comments in PATCH8 about which back-to-back ncsr_xyz()
>    macros are sub-optimal
>  - Moved nacl_scratch_xyz() macros to PATCH8
>
> Anup Patel (13):
>   RISC-V: KVM: Order the object files alphabetically
>   RISC-V: KVM: Save/restore HSTATUS in C source
>   RISC-V: KVM: Save/restore SCOUNTEREN in C source
>   RISC-V: KVM: Break down the __kvm_riscv_switch_to() into macros
>   RISC-V: KVM: Replace aia_set_hvictl() with aia_hvictl_value()
>   RISC-V: KVM: Don't setup SGEI for zero guest external interrupts
>   RISC-V: Add defines for the SBI nested acceleration extension
>   RISC-V: KVM: Add common nested acceleration support
>   RISC-V: KVM: Use nacl_csr_xyz() for accessing H-extension CSRs
>   RISC-V: KVM: Use nacl_csr_xyz() for accessing AIA CSRs
>   RISC-V: KVM: Use SBI sync SRET call when available
>   RISC-V: KVM: Save trap CSRs in kvm_riscv_vcpu_enter_exit()
>   RISC-V: KVM: Use NACL HFENCEs for KVM request based HFENCEs

Queued this series for Linux-6.13

Regards,
Anup

>
>  arch/riscv/include/asm/kvm_nacl.h | 245 ++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/sbi.h      | 120 +++++++++++++++
>  arch/riscv/kvm/Makefile           |  27 ++--
>  arch/riscv/kvm/aia.c              | 114 +++++++++-----
>  arch/riscv/kvm/main.c             |  51 ++++++-
>  arch/riscv/kvm/mmu.c              |   4 +-
>  arch/riscv/kvm/nacl.c             | 152 ++++++++++++++++++
>  arch/riscv/kvm/tlb.c              |  57 ++++---
>  arch/riscv/kvm/vcpu.c             | 184 ++++++++++++++++------
>  arch/riscv/kvm/vcpu_switch.S      | 137 +++++++++++------
>  arch/riscv/kvm/vcpu_timer.c       |  28 ++--
>  11 files changed, 941 insertions(+), 178 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kvm_nacl.h
>  create mode 100644 arch/riscv/kvm/nacl.c
>
> --
> 2.43.0
>

