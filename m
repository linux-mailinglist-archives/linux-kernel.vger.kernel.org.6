Return-Path: <linux-kernel+bounces-196733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C378D609A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C8D1F24198
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAA157496;
	Fri, 31 May 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ppd2+7hU"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8BB15575A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154753; cv=none; b=skjIaWXM+ARvXT/bnNslSMKiruZlFCD6yiGVA3soJrzU/JNtfqNyCd1WFpLtybERTmoc2B+oTPDj9uYTDPRZWKw6pHoFxklW+/i8o7AAD/RsylCMWjS0gMcJl74Cx1KQiv4G82yi13x9kNRUKV0ev1Pb5XJugF0KC8ayOzqDl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154753; c=relaxed/simple;
	bh=PTcYzuOXIlbRXgshrnBY0/SLFiYOVAKnmSmP2I+XI48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSZPj0WP0RjHCEIfLkH2jFlP5m3LBYXyw0eGn9G/sA4jMXjRDVS8HAuxUs6u8DvoMaCLYCu73svFtbd1x8BgsDezJdI9aNzCTjGgOs5JmCLBj+fUB4sm3lEHUMVh0j8in9fQfUeL09hwX/4WCpQnXIOCDeKdcmMIzApqfqejoTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ppd2+7hU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-374823e1c2bso5590485ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717154750; x=1717759550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRu+fvt96wDh21HWdZk+AUFYcHjCXJ/UFo9OhBPmYL4=;
        b=ppd2+7hUDcVX+OqQVYDt/gOrV3Ych2vIDHqsq/VJGLEMQLSxadOLha38PrzIb2nMhq
         GSd1F5hpyOaN/aVIp5wzxtoLWzqTRRAJvznVf4zGd9QqRYopUaYt8AjPmF0gNsx9+QXF
         Xdfhpn+GOWY41auXSJ18PcHrLQ5lakkp/d0cE7EzuR7qlGvpfZXIir0U6JDD/Eu71772
         xnfNlMcfur3vXZZa526DQRPn4hc+IYgOJNAou1V5dsbFmInswVZDrRQOYjZF1h/JiM5c
         IKbHRnfeRjVV7lB1VLNWBnABw40Lmtuf+S2s8tmna2efutfUCrSJIZg4OcXQA/GCg5L3
         s3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154750; x=1717759550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRu+fvt96wDh21HWdZk+AUFYcHjCXJ/UFo9OhBPmYL4=;
        b=Nz9ENaMUfiMwNCgyE3ziFhXwt0uWb7dw0ZyY4htl9krC4JzABZeP38kWnR0ChOEQwo
         xG2KmH3OU6lbiZ/zjeDOpt9LtVFlzUPRuFLQcgbUNfcnMdPl9rGBt1mmh4hhUSviYaso
         /NA7/TWLQOmnkHbyhasftUsgbJjXdInJpKYUg1A90deWntVDAF9pycLJr4PjUdDbCRug
         l0Xpzdn+zvDjjRPLqo6wKPQ0Xyeinf7Wk2M+LwnToKyf53j2OeMFSbUnLHaiAIS0ZUtX
         6C2h9Pw+4MuCBBOZnFscMoqss34jGTLB9UbSSzAo8dsH0Mnzb/smbwLgO2TaKHiHAzuE
         RqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh7C0vFdvFduu3XSLMMU42+FdLF1lKSdjFTdeSCseYh43lNJhaLcFtPOg5YwnsHsJix7nQVbA4JM5XBMuW6XVm8d3K4FvWEbkVqkGd
X-Gm-Message-State: AOJu0YxzF4gjSTyds8Pq5sIHqAah/fnY2rXeeGTMAsOlB7XpY4QtqJHO
	avQ5zslR+z0uA5iNxo/PTBEXS+wHDNAZmza2basnliUp9r1NmJ/w+s+3kZ0NHTLSORMV4a0nZdY
	+jGmhuberNFAntnf3Stg8LnPYuPkUVT0InQWRcg==
X-Google-Smtp-Source: AGHT+IERmtusbSx5VguMq+IRGISAME3Fo9I1nHszmWxBFaYwO8ur28ukLLI5CchbhXRWskUNyQH3RjcBWJXIgZMDsHc=
X-Received: by 2002:a05:6e02:b27:b0:374:6472:d923 with SMTP id
 e9e14a558f8ab-3748b8fd182mr18921045ab.0.1717154750045; Fri, 31 May 2024
 04:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090639.237119-1-apatel@ventanamicro.com>
In-Reply-To: <20240411090639.237119-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 May 2024 16:55:37 +0530
Message-ID: <CAAhSdy3+q1aLgTro5N_UerXjaW7fTGxjpOPKkyR+-GMru-gZMw@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM RISC-V HW IMSIC guest files
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:36=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series extends the HWACCEL and AUTO modes of AIA in-kernel irqchip
> to use HW IMSIC guest files whenever underlying host supports it.
>
> This series depends upon the "Linux RISC-V AIA support" series which
> is already queued for Linux-6.10.
> (Refer, https://lore.kernel.org/lkml/20240307140307.646078-1-apatel@venta=
namicro.com/)
>
> These patches can also be found in the riscv_kvm_aia_hwaccel_v1 branch
> at: https://github.com/avpatel/linux.git
>
> Anup Patel (2):
>   RISC-V: KVM: Share APLIC and IMSIC defines with irqchip drivers
>   RISC-V: KVM: Use IMSIC guest files when available

Queued this series for Linux-6.11

Regards,
Anup

>
>  arch/riscv/include/asm/kvm_aia_aplic.h | 58 --------------------------
>  arch/riscv/include/asm/kvm_aia_imsic.h | 38 -----------------
>  arch/riscv/kvm/aia.c                   | 35 +++++++++-------
>  arch/riscv/kvm/aia_aplic.c             |  2 +-
>  arch/riscv/kvm/aia_device.c            |  2 +-
>  arch/riscv/kvm/aia_imsic.c             |  2 +-
>  6 files changed, 24 insertions(+), 113 deletions(-)
>  delete mode 100644 arch/riscv/include/asm/kvm_aia_aplic.h
>  delete mode 100644 arch/riscv/include/asm/kvm_aia_imsic.h
>
> --
> 2.34.1
>

