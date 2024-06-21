Return-Path: <linux-kernel+bounces-225156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CAE912CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92931C238E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4816A942;
	Fri, 21 Jun 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="iQVgpBg+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80D16A936
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992814; cv=none; b=SqXUlAf75bPbVrquh9PDXZ9wyguflMWpZbycAB+8LF0dyGDjQKTlEVJ91308nW/uInW5uYgqJpngdPQJMvbBJwlUmYSIr+mPpmb4CdPtyG79UDyQMIeWywb5L0Zb5X6i3J3T6SdJuP/NlldXR5tPda/pApaB1fOj80js3bm3uRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992814; c=relaxed/simple;
	bh=V4euiQgGx4pOlMV3eIVI7255pZV+a5w1+ggJ68bkuuY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tg9xP6mJ+trZYZ4tRCO75psGmL9ggqVimcZRRydolGmiZl8DZcDemFs3mEYXXxbjv5GCTjjWGmSaB/urx5ybeIbTM3/g5fwWovR2v68YlwRbqZjNWBStaKxVtkLdDpW7yR2ntgLYLrrVgNaUycerq2a5goLxqcV4CGn3XMdNcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=iQVgpBg+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42172ed3597so13947615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1718992810; x=1719597610; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcW2S4JnM/18YUMxiJvbZaNnlkBv83HxD2e/gGhKLxA=;
        b=iQVgpBg+i9rFywdnUfMAtC/adt6637SVe8giSiZNjVaqwWMY+S761P/4OpXUy9uJ2P
         lyB2ACBdOAaKWzy2SqMsrZn/S/i0jBp/RXWLDh5pRGn9491dpvuxu3f3w2Za3ayY77yp
         KGbWCq4bLYlhofVioEvzH3f0rVrsXXia/5q39C4vrGKvTl8nUQXIGEzKrIBqjzXUQvG2
         4Mo8Lu0h3gm1hqyBhepixKootR+1B8Zr5r62nCvGnBS1hHrZ+XO5XTij3MRcQmioCNx7
         UTv9gF94+sFlWD+ZzRFdu2tpWSlDMWh0ZmTjILu2poHUhKZoJCyxPgPAZowDXHIR1M2A
         QmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718992810; x=1719597610;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcW2S4JnM/18YUMxiJvbZaNnlkBv83HxD2e/gGhKLxA=;
        b=BPo8rxA0pXtgMswfhkxZJO39gQsdQVGf/euYiYf5Kj6i8Xlvoo6KWHP76oi83wVo74
         VN8QBzs4iRT3Z0qo5LmFBaSSmTZQ03QsuvSvXSeHery6Hf+4fhyXOCl0IILr0v+MiZlA
         DrJVi7uZzlp5ELbXlxNtvN7X21kaP1u7iQsc1BtSr2qmp5MVfvLkAJ5mrJXzyV9EmDeb
         8g0IaJsXyo9olrCsjcCYxFJx9s/kby80Et8/27zxkHHovlYlJPKAnGUxHjbE2TCTxfVq
         xdkRyhTlZPlwLPyeq3V9S53ihtd/4auyv11yfLbIODhz/LkuTijX7a51CLOcMm62gGDC
         SC6w==
X-Forwarded-Encrypted: i=1; AJvYcCXGUw10omvMm1fnpvvffG9btprK8SE+r1wUrEFiNAfghVyjb8AW3EIIxXvhjCG3/sSHf5nifEfzTj/WanLgUltemnU09UXF8fqbXHX/
X-Gm-Message-State: AOJu0YwkhtMbu7zRcmtlsisUiUSZJ1EnJim6klOloNCwCgXLliuYqgCL
	yHNY9lQI0/fJkKeR09ni5ZOTJzku8FFTxH1BXG73Yel8BEh7072DQ03DeH1Y2ms=
X-Google-Smtp-Source: AGHT+IHJZWd1LTX+rQA6S+wz85uWg7nnYgT+DKEAOy8tWyIz+TJ8SRQ7NPvaMSgBbS6QqFs2pP71fA==
X-Received: by 2002:a05:600c:1d28:b0:421:5a2a:3cca with SMTP id 5b1f17b1804b1-4248630f4a7mr4623265e9.10.1718992810372;
        Fri, 21 Jun 2024 11:00:10 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d59asm40748835e9.9.2024.06.21.11.00.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 11:00:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2] RISC-V: Provide the frequency of time CSR via hwprobe
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240621113143.35827-1-cuiyunhui@bytedance.com>
Date: Fri, 21 Jun 2024 18:59:59 +0100
Cc: Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Evan Green <evan@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 costa.shul@redhat.com,
 Andy Chiu <andy.chiu@sifive.com>,
 samitolvanen@google.com,
 linux-doc@vger.kernel.org,
 linux-riscv <linux-riscv@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <705FA6B0-53E6-4CF0-B840-D51EC871B596@jrtc27.com>
References: <20240621113143.35827-1-cuiyunhui@bytedance.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 21 Jun 2024, at 12:31, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>=20
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> A handful of user-visible behavior is based on the frequency of the
> time CSR.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
> Documentation/arch/riscv/hwprobe.rst  | 2 ++
> arch/riscv/include/asm/hwprobe.h      | 2 +-
> arch/riscv/include/uapi/asm/hwprobe.h | 1 +
> arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
> 4 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arch/riscv/hwprobe.rst =
b/Documentation/arch/riscv/hwprobe.rst
> index fc015b452ebf..c07f159d8906 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -229,3 +229,5 @@ The following keys are defined:
>=20
> * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int =
which
>   represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of =
`mtime`.

This still says mtime.

Jess

> diff --git a/arch/riscv/include/asm/hwprobe.h =
b/arch/riscv/include/asm/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>=20
> #include <uapi/asm/hwprobe.h>
>=20
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>=20
> static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h =
b/arch/riscv/include/uapi/asm/hwprobe.h
> index 7b95fadbea2a..18754341ff14 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -73,6 +73,7 @@ struct riscv_hwprobe {
> #define RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
> #define RISCV_HWPROBE_MISALIGNED_MASK (7 << 0)
> #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
> +#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ 7
> /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>=20
> /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c =
b/arch/riscv/kernel/sys_hwprobe.c
> index 83fcc939df67..fc3b40fb9def 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -8,6 +8,7 @@
> #include <asm/cacheflush.h>
> #include <asm/cpufeature.h>
> #include <asm/hwprobe.h>
> +#include <asm/delay.h>
> #include <asm/sbi.h>
> #include <asm/switch_to.h>
> #include <asm/uaccess.h>
> @@ -226,6 +227,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> pair->value =3D riscv_cboz_block_size;
> break;
>=20
> + case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
> + pair->value =3D riscv_timebase;
> + break;
> +
> /*
> * For forward compatibility, unknown keys don't fail the whole
> * call, but get their element key set to -1 and value set to 0
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


