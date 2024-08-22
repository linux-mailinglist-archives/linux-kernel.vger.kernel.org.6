Return-Path: <linux-kernel+bounces-297002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7495B1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E701F22492
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D32175D39;
	Thu, 22 Aug 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlQ4RFet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A716EB56
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319187; cv=none; b=gxRY3E+Cwbl3zlXpTlgCD0afyH6DSdCgaxm2piGOkXEdAPh+GdzlQaHVYbkvUtDS7/yPrQQRsM3PfdsIBhYyFzJjuAAK9bOeuQt9hWzh8a7TDVDrJkhKHUjW0T0THUdRtax3hOBWooi9VIpqcTHk+XRPVWo2MG6feOb2jZO9Ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319187; c=relaxed/simple;
	bh=RDA0O88viAbVGJmVXrLsouv7DnSUUgl3x41JaEOsalk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmI1tgB5+6o3plgX27Ga7m2wMi7aEsBD5eel/Wftz2p+HeXpvF3FEsEMNV5miOPESGxucCkjlMDfIer++9OidOA4kzd+eLPK+0O/UsRMXQ36grbeUy2gVqVlH8mN1Kp48pZ3bmvhY8NJrVn/Dd59S3/EH7MCSi6JfJ84EmpfcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlQ4RFet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F9C4AF0E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724319186;
	bh=RDA0O88viAbVGJmVXrLsouv7DnSUUgl3x41JaEOsalk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dlQ4RFeteOaeMFsacIEHzB6Nu+jnWyKfh507rmQenOOdSvPt//oyc7iiXjbDM36rK
	 0Z85haW5BpaF+IlemhDQuAbJn88GP6gSzQDSMW+tYg4IIi+GVyBtCU5YFpQNj2hfPV
	 wnsVU1XK4fEoXmPRDLP+jdP0IlYN4iLDHxYeQdoOQjg7oIA5KR5A2Bz5ISaTjvGCBA
	 Ow56dO9R5Vuwcjc1lkYSyp2CYCRY2NWyPu72I0O1UuIyn29Q+SR10WsBPPT/TUG31z
	 Zc9Zi5Lqzyx7pGRdNiP/m6SaidYWqCnYo3x8g+/wY4NbXleuV7W0Qhg03S4iaQ1v4l
	 vuE3gVJWeul/Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so6123421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:33:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsjNAEsUVKLcreZr9LDa9Wud734M2y7UPoO/oO3iFL7Ol01YJpBoyvl5+igguuA19koM06NSFH2V5625g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqITczAn3czXtvbUEqI/bc8L0hp67jUNhjzpJo84qfRltYzF4
	9gXneyPg1hH+mMPNWaQpkom6hGqMI0Je653Ft1uAZ+lQP2qXk1GkcjP8IAQV+LXnhugDAQexBrV
	Wb8o+DTrNE/kGoYbbgFb1742vqJs=
X-Google-Smtp-Source: AGHT+IFdvVqadzXIUUC9/448SeOWoOZR70NaSYnTz+bRgYV3uJMinhk7Emj9fn/bdVGyQylDtgHjVxKUJGh1ErjOy7M=
X-Received: by 2002:a2e:b8c6:0:b0:2f1:929b:af03 with SMTP id
 38308e7fff4ca-2f405eeddecmr8925601fa.30.1724319185063; Thu, 22 Aug 2024
 02:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
In-Reply-To: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 22 Aug 2024 17:32:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H68HR+GGyez330=b-AiUgbHhfjrEwY0aezq+-NraJvBGw@mail.gmail.com>
Message-ID: <CAAhV-H68HR+GGyez330=b-AiUgbHhfjrEwY0aezq+-NraJvBGw@mail.gmail.com>
Subject: Re: [PATCH 0/3] LoongArch: Migrate arch_numa
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Jianmin Lv <lvjianmin@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jianmin,

On Wed, Aug 21, 2024 at 9:12=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> Hi folks,
>
> This series migrated LoongArch NUMA implementation to common arch_numa
> logic to enable devicetree based numa.
>
> Only tested against QEMU emulated NUMA system.
>
> Please review.
What's your opinion? From my point of view, there are lots of corner
cases for real machines. :)

Huacai

>
> Thanks
> - Jiaxun
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (3):
>       LoongArch: Move pcibus_to_node to pci.h
>       LoongArch: ACPI: Introduce get_cpu_for_acpi_id
>       LoongArch: Convert to arch_numa
>
>  arch/loongarch/Kconfig                |  10 +-
>  arch/loongarch/include/asm/acpi.h     |  12 +
>  arch/loongarch/include/asm/bootinfo.h |   1 -
>  arch/loongarch/include/asm/numa.h     |  50 +----
>  arch/loongarch/include/asm/pci.h      |  12 +
>  arch/loongarch/include/asm/topology.h |  18 --
>  arch/loongarch/kernel/Makefile        |   2 -
>  arch/loongarch/kernel/acpi.c          |  91 ++------
>  arch/loongarch/kernel/numa.c          | 400 ----------------------------=
------
>  arch/loongarch/kernel/setup.c         |  19 +-
>  arch/loongarch/kernel/smp.c           |  43 +---
>  arch/loongarch/mm/init.c              |  12 +-
>  12 files changed, 77 insertions(+), 593 deletions(-)
> ---
> base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
> change-id: 20240820-loongarch_archnuma-64fab779176e
>
> Best regards,
> --
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>
>

