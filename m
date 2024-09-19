Return-Path: <linux-kernel+bounces-333563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1C897CAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029091F22B24
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C2719F462;
	Thu, 19 Sep 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4uOaozM"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B519CCF4
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755138; cv=none; b=pSts7Va7cyIrRwSSKaRqqAk5fLD+DCad5Kux7HSMBzJYdCWN033d/RZxCYAdqbesmpZzzNVP/MUqHtC+Z/njGJcvKyKLkizdRwwdCsvCWfBIETJLHJV36OX2mFUgohj67zZ2EfTwGaipFeQU+o1n/QxiCIB72N2sIQe2UW0Q54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755138; c=relaxed/simple;
	bh=OBMZFiSFeqPzc7tA+aLdTFmnHzZvhEh/w3mVNRKd4Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs71z8oALnKe6SyObFm7tkLFqDEcA/HRsCHLQkNrvFkujB8KFc0iOTsk+bA4nRScKd0DvQiF22w+TLlLbVaAxv/KXeenMZqbXHdcQnalxUo3HQYS3sF+6SnTZClCgwL46GgTI/Xu/UNkAsQ3tAiBtgnOgOfYL3Pftm44v2fqjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4uOaozM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e2855479so657968b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726755136; x=1727359936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFIZiu1sb50Hbu3DGjuHeiukNHEC0OWMePQLB5+Qbuk=;
        b=K4uOaozMnMxuv3i8oQF7l9hs4GGxzSFDYGukRuG/T4h1HQbDI0MMaVa1pEqJBpbqaE
         /t4VSv1pOuFgK59PPs9IHC+FSPpJwsY5xxVK8Rno4EHD1R4OGN6K7zmOlBJWGAuF56/o
         T6AxMv0KPEkHYOh/P23TpLlycgh5xJT2cTTVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755136; x=1727359936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFIZiu1sb50Hbu3DGjuHeiukNHEC0OWMePQLB5+Qbuk=;
        b=LWnvmM/mIwhAbd6mu7WQLfy0gLQWwSIGk59mQO08rGEopllaEYRkO4UxozBwW/rit0
         tgxjqqxkOQA9mwdr0GWrJ1XowCb5YE06S//Z95/ZoeRopAM3bjvUEeTpH2Dp3c8Q7EBL
         VRIGjdTwsMFzu71m/p7O6O5S4h4O/WVFAEL4ltpNeFMlSKkFJHzbVyH/jJj21/fbmU9T
         jUhGUb9MWBdLVGcIW390MGBSxXboOdcxLPb6AAcmsP/XwTECV9wDEeSgQMIbyFcozPgy
         B9nib0++fX9J2FzoXa0MqHMGfb8yaNkrJEAXiMslhp9o7phCwepPxjJ6DeU37rRags3n
         BwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVybxDp0nCOYm4KeSKEKyiElhnfT4jU7/KEMbKkhq31sk+NXDyTBSA4hzitj5PuKT27gpENOlch66Byj5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdPcqr5h58yTpVPS2ySWgu1kulZQO5e9hIOduz1V/dGN+2S2K
	UOX0X2hsl+5wIFeC8l0wrFG16wa4Mo/m8usEempN5w0iMeYVuWy67IkpMw9lmCJHssEj3CCh06v
	187Bft2/3V3lzgNOb701qE98yAFD9cS/a6Xif
X-Google-Smtp-Source: AGHT+IHi3h8nkgewOmL9EThNc6Ua+K8uhF3/NmaTMOdnTIdVNreIwUrwPJkjJA9lZ3rTWfyL8KVEOM3TVLVBg+lsIxI=
X-Received: by 2002:a05:6a00:1ac9:b0:714:2dc9:fbaf with SMTP id
 d2e1a72fcca58-719261e73c0mr35498586b3a.18.1726755136577; Thu, 19 Sep 2024
 07:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com> <20240918152136.3395170-24-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-24-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:49 +0200
Message-ID: <CAFLszTiPO5zb6F7j2YiJgRj0BiKwoqmNik1irTXaBy5KHzZz+Q@mail.gmail.com>
Subject: Re: [PATCH v4 23/35] drivers/arm: Implement acpi_fill_madt
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Fill the MADT table in the GICV3 driver and armv8 CPU driver to
> drop SoC specific code. While the GIC only needs devicetree
> data, the CPU driver needs additional information stored in
> the cpu_plat struct.
>
> While on it update the only board making use of the existing
> drivers and writing ACPI MADT in mainboard code.
>
> TEST: Booted on QEMU sbsa-ref using GICV3 driver model generated MADT.
>       Booted on QEMU raspb4 using GICV2 driver model generated MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> Changelog v4:
> - Read everything from the DT
> - Export armv8_cpu_fill_madt() to use it in other CPU drivers
> - Depend on IRQ
>
> ---
>  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
>  drivers/cpu/Kconfig       |  1 +
>  drivers/cpu/armv8_cpu.c   | 80 ++++++++++++++++++++++++++++++++++-
>  drivers/cpu/armv8_cpu.h   | 10 +++++
>  4 files changed, 178 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I'm still not sure why you are using u64 instead of ulong?

