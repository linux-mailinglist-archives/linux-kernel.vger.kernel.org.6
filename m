Return-Path: <linux-kernel+bounces-291080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ABF955D03
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDD1B212C6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C817E76D;
	Sun, 18 Aug 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="2vakvEdL"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535832F4A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723992434; cv=none; b=EQIvd9TYFTHMSVVxceCvti7oX5aQqIUpeF1BKnhLQlqpPDAqAc7z4d4Mn2JxxvDCIvpOqC8udxXMTy5F1Q+BMgxlv17KQmC6VRkDRGowQQFJ4M8k5CSMTIMWVIHQra2SGx5eZ4KWLAaHUj1FxEP2aOF/5tT9HVH/vJtsMZdis9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723992434; c=relaxed/simple;
	bh=YxbSvn5cUDl78h8CIcje/7YQx17KEfYP8gRIXN7rHr8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=KxS23ddJsyNyb7q5dsFoLg0GjHuBPo1vkldWQgUVhkaHTVspsOUsJqBErVHqLc8XnZrbyyVWdOYDthgBPmzyKl0Lwr51CnuXlM1S4zTOm58eXHBskLkenlu4apVKkBmEA7dYAlPGwK4GYL2hZ4TT4dE1zbCINsKjsGR++9Y5LPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=2vakvEdL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso2781363a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1723992431; x=1724597231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0Go8AiJdek7lWgXbzWIQti4cldN0KMyV85X7iQ7LZM=;
        b=2vakvEdLvubvG86B+vRMbqfjnMSDPbgzyUiCOi2+Fvwml9U3mrHRL7Slbls1EDMMXc
         mBnqu91KvQUUFP+urox8YoiHOnuorR4se19bvVA6zCcaO/e0rr+vIRHAU3hXjFr78fiT
         20EXAXnkGPZqmavQFhivLphkiaGyV2pklFCuqZVLnjPoesN18MmV3T0pb/WFfyz1+Cvq
         in9XRw+VnJgEoqy5NZMEp444giG6sY/pNBy2qD/+fTQpb+iHrUfXvcxQIL2lGLYo9cFD
         fu+k5uUk7BIhvyiL88lxMPTmkMr1W97hxrnSfRg0tbLn+3+UDt51l1EPaJBSiNTf7iQj
         JsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723992431; x=1724597231;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0Go8AiJdek7lWgXbzWIQti4cldN0KMyV85X7iQ7LZM=;
        b=brZ1mao3kdH+fvahSaKF4FAcN2BGwoyxjk876UTPxv4IhbFMA209/8ZzxV10bI4k3/
         0lY65gFjLhGCrgUK11um0g6d0Jhl8U1Z5K8dIIqhx40yPMJQg9XT3Jm7kPrln/ysJ8/0
         3q69kTCZlVoKKFq45NZBwtETtyO75ll/OWYwQhgjTnQ89JiK4L2NqPDs6GNGw+JynYry
         GDrJruXWkBVgHMNCxr26NzTqVmTKngqpYxM6GH9x6Dp7ZYR84PBeZGO4mZGtfw6U9rc0
         tBl2qRKTkG3CjSPf58TvHFwGywE7OehHAG2kLYgdtMoPcjNGrOryXrANqDnXJ5Pg0/63
         fpFg==
X-Gm-Message-State: AOJu0YzW70bV0yKyjuqrGo0cdn+SpRniVqHhqfa4QDMuISXUTl5XuqU9
	XpS91fJO5+NpiEG9w2pHikW6EX8XPaUeaLWXITPK/NejsXuAvm/azDWRp4/Ow/i3OTOJ5Ve6OpC
	2
X-Google-Smtp-Source: AGHT+IFPsZCr0YUiUpr/DaFMboUHyjc9cdjktUKCX4FN+D2Lradt6LfpdkLAoK6RZRWM1coGNNq1GA==
X-Received: by 2002:a17:90a:fe93:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2d3dfc7b35bmr10124972a91.24.1723992431051;
        Sun, 18 Aug 2024 07:47:11 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e83ebaa1sm5346974a91.17.2024.08.18.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 07:47:10 -0700 (PDT)
Date: Sun, 18 Aug 2024 07:47:10 -0700 (PDT)
X-Google-Original-Date: Sun, 18 Aug 2024 07:47:04 PDT (-0700)
Subject:     Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  apatel@ventanamicro.com, tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
  samuel.holland@sifive.com, aou@eecs.berkeley.edu
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Renner Berthing <emil.renner.berthing@canonical.com>
Message-ID: <mhng-e2f36a06-7e9e-47bb-8120-126f1a4441f5@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 07:56:32 PDT (-0700), Renner Berthing wrote:
> Hi Anup,
>
> As described in the thread below[1] I haven't been able to boot my
> boards based on the Allwinner D1 SoC since 6.9 where you converted the
> SiFive PLIC driver to a platform driver.
>
> This is clearly a regression and there haven't really been much progress
> on fixing the issue since then, so here is the revert that fixes it.
>
> If no other fix is found before 6.11 I suggest we apply this.
>
> [1]: https://lore.kernel.org/linux-riscv/CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com/
>
> /Emil
>
> Emil Renner Berthing (9):
>   Revert "irqchip/sifive-plic: Chain to parent IRQ after handlers are
>     ready"
>   Revert "irqchip/sifive-plic: Avoid explicit cpumask allocation on
>     stack"
>   Revert "irqchip/sifive-plic: Improve locking safety by using
>     irqsave/irqrestore"
>   Revert "irqchip/sifive-plic: Parse number of interrupts and contexts
>     early in plic_probe()"
>   Revert "irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain
>     creation failure"
>   Revert "irqchip/sifive-plic: Use riscv_get_intc_hwnode() to get parent
>     fwnode"
>   Revert "irqchip/sifive-plic: Use devm_xyz() for managed allocation"
>   Revert "irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()"
>   Revert "irqchip/sifive-plic: Convert PLIC driver into a platform
>     driver"
>
>  drivers/irqchip/irq-sifive-plic.c | 296 ++++++++++++------------------
>  1 file changed, 117 insertions(+), 179 deletions(-)

I'm still only testing on the QEMU-emulated platforms, but this isn't 
regressing over there so

Tested-by: Palmer Dabbelt <palmer@rivosinc.com> # QEMU

Thanks!

