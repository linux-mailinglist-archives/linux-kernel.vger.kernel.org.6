Return-Path: <linux-kernel+bounces-196167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302EA8D5849
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA958285921
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD48F9E4;
	Fri, 31 May 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYAXI2me"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295285234;
	Fri, 31 May 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119794; cv=none; b=tCpxIQt4iEDQMhzlQS8s0f5YjQ18j6jc9iHvDpDoxA3u90wJzCKLscekl7xligqjdEKANRi0sLbPNqSwwfZqHkrYkTBrRcBrOgjnld5DiAMZ1BiRo66PGf/CUhGEfS19/gLHGiMoKHe4NnWf6GdvjGNatcViObS9wKvK1Rt9axc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119794; c=relaxed/simple;
	bh=gayPJsOWp4Fcpeui9tfmQJneqTunc1QXKItLF50AT04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvU43uuxB1cQ1cBFwebVlIr4eG0zj828m2Q8XQMm6+k7rjd62CXpf1hVaWYG8oAOL9Q28Qpv0YbX3G+CDm7I2q+AWtONlqP+7dDEV1HOGTDO1AwIwtC5pGK2a5jOg28ukogM8JF5pbL8WZRJEvYppHPAjA4JtjvtkL4+9CLBwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYAXI2me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E2CC32789;
	Fri, 31 May 2024 01:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119793;
	bh=gayPJsOWp4Fcpeui9tfmQJneqTunc1QXKItLF50AT04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fYAXI2meZ5JK+wf8EHAa8W8sRCGrrTD0QNrGhOuQSdIzCgAd8fnPpz96/i7YyAWnm
	 os39adGByKAuYkmtCAcv6IluFX5LQnmFz52WrDTrUuYwbmB7dWtp4TgbtiAC1+KVQ9
	 L6LhWqG6uYkUeB8ND3H1PzmOduj6r9VIMztkA1KvLJlKg/RLPPNZx4D1LaLtLcbouE
	 bseTQjs9/et9eNm6SBzSOohb3o4Sd907cTZSTy0IlOAYCIVtGutfJyGpHZnNZzDusF
	 IfK527/0htbytgV3N7a7jauSXDH13ZKvIa/calBfO5IwHGGpfJo49b+YI814Sdt2lY
	 QH30A/KDalvNw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so2624182a12.0;
        Thu, 30 May 2024 18:43:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmakY65As4dAMN02zhJCrkOyOCzdctJwxlfIUmNtezX4LgsUPbQvXgfepOTxFd4MpwrC8uvoGEMjj+r2NRjPPinkSlIsYB9EpLf0vekwEEQKfbrxYA8IBVE6cWc0UprJaO1xTgQvowWw==
X-Gm-Message-State: AOJu0YxeROqxK0X6RmnnqeM9ThvbLtikbqBtsAyHc99XHjJI833SBtdL
	hCWa0b6o1bVF9enJGxIz9jt+Fv4F3z6U5qadpzsXvjcm1nKrPTwGzoqBxRvpBE/WwREHsdU8J4J
	T1AtqLp4aWqLwqgYqVmH04iMfIeE=
X-Google-Smtp-Source: AGHT+IGA06cT5oNVVAof3ajmceIaL3u0EFu5Ya5KQd6z+if9VJ7W4G3j+QdFSZh4WuDJL+vmceLnEsUhQi3CQwHAKi8=
X-Received: by 2002:a50:99d5:0:b0:578:62f7:2881 with SMTP id
 4fb4d7f45d1cf-57a193fd230mr2692616a12.0.1717119792140; Thu, 30 May 2024
 18:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR20MB4953BA3638A0839FCB0EF86BBBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953BA3638A0839FCB0EF86BBBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 31 May 2024 09:43:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu8WUkjOOzH4MZvinZv=0cgF988c7HyzP5jw0p3w+MWQ@mail.gmail.com>
Message-ID: <CAJF2gTRu8WUkjOOzH4MZvinZv=0cgF988c7HyzP5jw0p3w+MWQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: thead: th1520: Add PMU event node
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:19=E2=80=AFPM Inochi Amaoto <inochiama@outlook.co=
m> wrote:
>
> T-HEAD th1520 uses standard C910 chip and its pmu is already supported
> by OpenSBI.
>
> Add the pmu event description for T-HEAD th1520 SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://www.xrvm.com/product/xuantie/4240217381324001280?spm=3Dxrvm=
27140568.0.0.7f979b29nzIa1m
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 81 +++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index d2fa25839012..3c9974062c20 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -122,6 +122,87 @@ l2_cache: l2-cache {
>                 };
>         };
>
> +       pmu {
> +               compatible =3D "riscv,pmu";
> +               riscv,event-to-mhpmcounters =3D
> +                       <0x00003 0x00003 0x0007fff8>,
> +                       <0x00004 0x00004 0x0007fff8>,
> +                       <0x00005 0x00005 0x0007fff8>,
> +                       <0x00006 0x00006 0x0007fff8>,
> +                       <0x00007 0x00007 0x0007fff8>,
> +                       <0x00008 0x00008 0x0007fff8>,
> +                       <0x00009 0x00009 0x0007fff8>,
> +                       <0x0000a 0x0000a 0x0007fff8>,
> +                       <0x10000 0x10000 0x0007fff8>,
> +                       <0x10001 0x10001 0x0007fff8>,
> +                       <0x10002 0x10002 0x0007fff8>,
> +                       <0x10003 0x10003 0x0007fff8>,
> +                       <0x10010 0x10010 0x0007fff8>,
> +                       <0x10011 0x10011 0x0007fff8>,
> +                       <0x10012 0x10012 0x0007fff8>,
> +                       <0x10013 0x10013 0x0007fff8>;
> +               riscv,event-to-mhpmevent =3D
> +                       <0x00003 0x00000000 0x00000001>,
> +                       <0x00004 0x00000000 0x00000002>,
> +                       <0x00006 0x00000000 0x00000006>,
> +                       <0x00005 0x00000000 0x00000007>,
> +                       <0x00007 0x00000000 0x00000008>,
> +                       <0x00008 0x00000000 0x00000009>,
> +                       <0x00009 0x00000000 0x0000000a>,
> +                       <0x0000a 0x00000000 0x0000000b>,
> +                       <0x10000 0x00000000 0x0000000c>,
> +                       <0x10001 0x00000000 0x0000000d>,
> +                       <0x10002 0x00000000 0x0000000e>,
> +                       <0x10003 0x00000000 0x0000000f>,
> +                       <0x10010 0x00000000 0x00000010>,
> +                       <0x10011 0x00000000 0x00000011>,
> +                       <0x10012 0x00000000 0x00000012>,
> +                       <0x10013 0x00000000 0x00000013>;
> +               riscv,raw-event-to-mhpmcounters =3D
> +                       <0x00000000 0x00000001 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000002 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000003 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000004 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000005 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000006 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000007 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000008 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000009 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000a 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000010 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000011 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000012 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000013 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000014 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000015 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000016 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000017 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000018 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000019 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001a 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001b 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001c 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001d 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001e 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001f 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000020 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000021 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000022 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000023 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000024 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000025 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000026 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000027 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000028 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000029 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000002a 0xffffffff 0xffffffff 0x00=
07fff8>;
> +       };
> +
>         osc: oscillator {
>                 compatible =3D "fixed-clock";
>                 clock-output-names =3D "osc_24m";
> --
> 2.45.1
>
LGTM! Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

