Return-Path: <linux-kernel+bounces-368609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B729A1239
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A951F23209
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AC2141A1;
	Wed, 16 Oct 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R3JkJPB4"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70218B498
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105437; cv=none; b=sqZra9RFmiN/v6tTJzy3vExkj1QpmL1HrIwSr+96kWJWW8pBD7h0Rr3giXP3H7AZxot4HO7BmKBHD/bpqclscAPZUnvjiX/YMxDAOYhxFGeAeZlEMKOWLs6leHax/UZDRvIC6W7IdqzJdTc7pIzebtRxpAhKNLIoadwVak9zeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105437; c=relaxed/simple;
	bh=IdGPXBYuC+gFWtEcqOsuKc1VFFYBfDflbDi3vzbNnYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tt6Vnm4ImU9pNJJrw8689i3q/Hnm2LTWySSeXUe4MUsa9m/X8b53Z+6AHpLAPNwTqn88CxNAhGWK5fR0k6q4/xhBMQrWdICjHXWN9Pq8xdT1bijILVz024mhk48VoQ4W0RAyrqqPMuuf8FD3lS1RmDmDAVPKyQm8U0ZnFOBHC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R3JkJPB4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3b450320aso855705ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729105433; x=1729710233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxyFXAuH+mgf3dl67t38IiOCtsPnCcipqPsettp6piQ=;
        b=R3JkJPB4pNIN4SIXZGpVy8KAk/U2/3+wcfCfjeBT4pUb4yeHnPfrtaPmumrof7m+jd
         R6i4g2nth/WJYVWLNdKm3E7QgTPdNzmfYeDCRgKy9Kis2Nr7u1UeOY/B+djl0adNc724
         4DU5B6/qRqaiskPDuoQN1ZDTdWeLvTZBEECuLuVwRVZuPJQj3MN4Xra/9Hn8s/Zl/3qh
         NG+bOR8uZYrGsiRBOxz1UAtdvToXPYzzLimM89eOpcAlbvIge46uh8Sgl9bLl3h2NXvO
         ntuLjS7XvvGMsFf+DWlyeevYdo0KAnRNm8c+rmExXsrummjaYVjiDMRuU0KTyCPfHv8R
         I1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105433; x=1729710233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxyFXAuH+mgf3dl67t38IiOCtsPnCcipqPsettp6piQ=;
        b=cWUj4g6P88SLnGZuSdY597CR/Jcotxob413MOOSWJowJmINFo7LfLWo/bOqS0Nj4lF
         OylteGuTT+g/PHpLSpU6v2NyRZAZze9ZCHfZSvOiGtFHuIsbrHNMIdlUb66paV9+qiCI
         PxPk2VycKvoCq87MFr1Da5v6LyrMyP1vDTxO+4F8Un7AlwWST59imejuNqigTznENnHz
         iBmI9MO1XgRO9sikLsgFPgHYK+cqcjvHZDAwZHUMBQf0awzQaovpXbrAJh3Ufjn5NqYA
         yErqZjTY6fsIPdNtkmDPhkiJ6ptiNfH/IvOz+0etmDoLyNM5yzFi5HwKNsu4/ByH2NGv
         jTjA==
X-Forwarded-Encrypted: i=1; AJvYcCWtCObbV45Encymb7TS7xxpWlWCi/COZOt1hNuemmvsGjeCP9Y6a8nIT6zffleS/UFKz+ujzGh+oHWcgUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CK2KWOKCTG0sImYWtuBvCxfjPewR8T0MUnJcP6xhjP+79yYz
	0luVmqm93T0hPTngr+xVicneMweY3D4mZWzUdpiOLLPcxVLIdw//cpdboXXcg5A=
X-Google-Smtp-Source: AGHT+IFN4BQomLzr5kcRH/fIUJNMPAHP7KDnpJqCP2efyNjSfr3q1aTjpUQkcj+hd8dhGj91RZQEZw==
X-Received: by 2002:a05:6e02:1c21:b0:3a0:bc39:2d72 with SMTP id e9e14a558f8ab-3a3dc4cc8a8mr49777475ab.12.1729105433066;
        Wed, 16 Oct 2024 12:03:53 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c403csm3651632a12.35.2024.10.16.12.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:03:52 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: apatel@ventanamicro.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [01/13] RISC-V: KVM: Order the object files alphabetically
Date: Wed, 16 Oct 2024 12:03:49 -0700
Message-Id: <20241016190349.640640-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-2-apatel@ventanamicro.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Order the object files alphabetically in the Makefile so that
> it is very predictable inserting new object files in the future.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/Makefile | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index c2cacfbc06a0..c1eac0d093de 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -9,27 +9,29 @@ include $(srctree)/virt/kvm/Makefile.kvm
>  
>  obj-$(CONFIG_KVM) += kvm.o
>  
> +# Ordered alphabetically
> +kvm-y += aia.o
> +kvm-y += aia_aplic.o
> +kvm-y += aia_device.o
> +kvm-y += aia_imsic.o
>  kvm-y += main.o
> -kvm-y += vm.o
> -kvm-y += vmid.o
> -kvm-y += tlb.o
>  kvm-y += mmu.o
> +kvm-y += tlb.o
>  kvm-y += vcpu.o
>  kvm-y += vcpu_exit.o
>  kvm-y += vcpu_fp.o
> -kvm-y += vcpu_vector.o
>  kvm-y += vcpu_insn.o
>  kvm-y += vcpu_onereg.o
> -kvm-y += vcpu_switch.o
> +kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
>  kvm-y += vcpu_sbi.o
> -kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
>  kvm-y += vcpu_sbi_base.o
> -kvm-y += vcpu_sbi_replace.o
>  kvm-y += vcpu_sbi_hsm.o
> +kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
> +kvm-y += vcpu_sbi_replace.o
>  kvm-y += vcpu_sbi_sta.o
> +kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
> +kvm-y += vcpu_switch.o
>  kvm-y += vcpu_timer.o
> -kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o vcpu_sbi_pmu.o
> -kvm-y += aia.o
> -kvm-y += aia_device.o
> -kvm-y += aia_aplic.o
> -kvm-y += aia_imsic.o
> +kvm-y += vcpu_vector.o
> +kvm-y += vm.o
> +kvm-y += vmid.o
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

