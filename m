Return-Path: <linux-kernel+bounces-170700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F18BDAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA121282846
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA26BFA2;
	Tue,  7 May 2024 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="UorOpD1i"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD16BB54
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060467; cv=none; b=JcV5WtDpMD0YD6yn05ivXh9DkE746mQhkR6RaNFGfCRGTsvKF8YFwCDOdG5WKHD3ErNZ8dNnR3ZGzedmvuTPJvvpGAC19+tbh7Qc2STPGS7xp5gjOalY54nbIVD95ZtdK932L2QES7OoU0k22GUCLxrjyh7QZ7MCDAJTBLCyKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060467; c=relaxed/simple;
	bh=D4o1CLUq2EDo5+AiUzh8I5j1GGqs1kgDvmYuoQvgUeI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TVKh96/dL78dWnsCRxm2wF1A9qAOX5mUHSVPk8clIXO3KrbmbhLc0pHhWTmrn3+JycY5Le2Iyglj6p6KbYxBdKujLZk+Vfa1TnlpH8H0dA3D6D7LwZOt+fhAgfEiBbTJIO0LQ3nB3eSC1X/nlSX6igGxJO+8akothcqwijBcdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=UorOpD1i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so1735684f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 22:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1715060463; x=1715665263; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kbiGw1I98ggTGFKbaoTCIzpEx78I5vq+dQ9nXNzCpI=;
        b=UorOpD1i8kHjbRXPhwiMMvq/t/NuqaFOp9hseyLY3ykdpBk6CKDnsna/Z0OzxHY/9k
         iclVuqHbVvb84c6oCe1CxfsBpijtkuNoHXW1V4NEoVTqK+Rk7mszl770+njMlriVHKOk
         /uzDrpKJvIriz0PQL4ghNF1ixb8K/9hoplZyWW0GLsdEBbs0HS0YHeJOvQ4r9gIOhXlz
         QNQEkhsBTXOAn/ZxV2IkSF6pXaVEuiT9sIMU8fFmNkMHeSAmXn4nYalCyyhEVAx+AkBO
         gwMDQI86Qhf0VKt4ef3mDfjVGZ+mGAf626o4UZhDgsFDqZbJ0Myrh/ZV4qRaUT33meGi
         DHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715060463; x=1715665263;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kbiGw1I98ggTGFKbaoTCIzpEx78I5vq+dQ9nXNzCpI=;
        b=Fkn3YyuDBiJAq24ua//kQYVJmzmNdbhNOPpXqr72tsunqbcivRn4CmEuHQdrkzH8WI
         8ajPxKXkMf+nQd/myI7dBlT1NWoD35fBRB5hKvxwQkh75n1Iek2zAFWSpW+59tOLM9t5
         l/hMbOr24+f41d3uc+uI0X20K22CGkW0s3DtTgSUWSkkZpD1HEY3z/6cfoin0LMm0IZm
         rep7LlnySGPJtheRJkKt4DdO5g++JsybCRAhocWEPQLctR2LOS80eCqb9aSM5PAlgYzh
         Wd30RZwN+y4x8ZpXBVs6foe50vd9sJ2yQ6L6C2gOD2ibwvN/q6uV9Vz5SSNE11yeXOOk
         ceKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcg9pP/kZNvbM48FwF3jGF90k+7PuaL2GbDURWIj0lmJneY2H5opOxs79fNCx2QcBkvYGHX/3o15vDKhv469uhK9xs9SIwEut4HSqs
X-Gm-Message-State: AOJu0YzimdK7NAYS3OiYkCnI+03JxUCDCHKFKGsCWMa/5Rjd4s1xhfk3
	7P95eMedQgYuzQ729rpwkqnBE0vaQ4Y6CFjkt6Mx+oAFY/lCEugMbmKgvmNQrh4=
X-Google-Smtp-Source: AGHT+IHa+esdspnEOsUVcm0d3XG+402oGNO03Ku//0E0dzUqeLQ+nfmICyWShJi63tMEMr3wfdEZ2A==
X-Received: by 2002:a5d:4044:0:b0:349:f220:a1cd with SMTP id w4-20020a5d4044000000b00349f220a1cdmr10272654wrp.27.1715060463126;
        Mon, 06 May 2024 22:41:03 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d4903000000b0034dbbcf01f5sm12014714wrq.42.2024.05.06.22.41.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2024 22:41:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 4/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
 Kconfig option
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240506-compile_kernel_with_extensions-v1-4-5c25c134c097@rivosinc.com>
Date: Tue, 7 May 2024 06:40:52 +0100
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>,
 Song Liu <song@kernel.org>,
 Xi Wang <xi.wang@gmail.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11F5B269-05DD-448E-9F85-878E84A5654F@jrtc27.com>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
 <20240506-compile_kernel_with_extensions-v1-4-5c25c134c097@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 7 May 2024, at 02:40, Charlie Jenkins <charlie@rivosinc.com> wrote:
>=20
> Svpbmt would not benefit from having =
PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
> so just rename RISCV_ISA_SVPBMT to =
PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
> and move the definition to Kconfig.isa.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> arch/riscv/Kconfig     | 17 -----------------
> arch/riscv/Kconfig.isa | 17 +++++++++++++++++
> 2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 9c3a4347953b..22303a3ab59e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -484,23 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
> help
>  Allows early patching of the kernel for special errata
>=20
> -config RISCV_ISA_SVPBMT
> - bool "Svpbmt extension support for supervisor mode page-based memory =
types"
> - depends on 64BIT && MMU
> - depends on RISCV_ALTERNATIVE
> - default y
> - help
> -   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> -   page-based memory types) in the kernel when it is detected at =
boot.
> -
> -   The memory type for a page contains a combination of attributes
> -   that indicate the cacheability, idempotency, and ordering
> -   properties for access to that page.
> -
> -   The Svpbmt extension is only available on 64-bit cpus.
> -
> -   If you don't know what to do here, say Y.
> -
> config TOOLCHAIN_HAS_ZBB
> bool
> default y
> diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
> index 37585bcd763e..50e217dc5719 100644
> --- a/arch/riscv/Kconfig.isa
> +++ b/arch/riscv/Kconfig.isa
> @@ -168,3 +168,20 @@ config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
>  not support Svnapot.
>=20
> endchoice
> +
> +config RISCV_ISA_SVPBMT

Hi Charlie,
Despite the subject and body you haven=E2=80=99t renamed it in this =
patch?

Jess

> + bool "Svpbmt extension support for supervisor mode page-based memory =
types"
> + depends on 64BIT && MMU
> + depends on RISCV_ALTERNATIVE
> + default y
> + help
> +   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> +   page-based memory types) in the kernel when it is detected at =
boot.
> +
> +   The memory type for a page contains a combination of attributes
> +   that indicate the cacheability, idempotency, and ordering
> +   properties for access to that page.
> +
> +   The Svpbmt extension is only available on 64-bit cpus.
> +
> +   If you don't know what to do here, say Y.
>=20
> --=20
> 2.44.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


