Return-Path: <linux-kernel+bounces-179576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E38C619A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B51BB243A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB87444C88;
	Wed, 15 May 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxHewemv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF140446AD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757605; cv=none; b=HY58gW/MXxd6XXC9np4PxFcOkGoZTSCVuD/4O1XZTF5T2x985nO2rAQ9DTGRRe8kpg5qkKKOYtjbOXzXI2GIPexUnhkiyKlgmW0HDD37M1ccD+UhJ7UCz3w0KXFsaX7sejuIPoayXJHyr50oOV5RoXA1x+tU2vgenoeuk2jSOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757605; c=relaxed/simple;
	bh=UrQpKGbOOg+j3V5gFRHRGwgFt0fiIcqplbYRMxsH9uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzTI9RwPx2diHQ9hWG0LL8xocgt+rwTx1RTo0y5nu76UGIhoyipt539QSOmmZeAOvJGTRklgR1COPcKg+zd54tG4LVafqns8ODYHHJCBHe9K5W8eSIymMYB+BXbrQ9RpeR83wKTvFQtJ2sktLbGu4+6GrB1lEJ0n4XOQUaWC8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxHewemv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB0BC116B1
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715757604;
	bh=UrQpKGbOOg+j3V5gFRHRGwgFt0fiIcqplbYRMxsH9uQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QxHewemvHPJf7qz+BJNh9ddTjkvQ5+kDxQDgCNsF7XVnZnFL7MgZths0xFW1lMdpg
	 NAZ0r0DxNaIaj5zY+mKl/l7tgvJzQCosBYkZloG/8kusnGl+uvNHYwCMQi2kbi1Rmy
	 cyUI7db8vL9H2r/vKrNpFx7bPZdu6HFb+rUuOj1bdcVZUIwKmrHlX6rv09BA/XRXE6
	 7fdvBP4f9nOrNi0bWX+OcfALs5UNz9kkrQtuHWU5XfcgMPpmnlG7kKsE+zs0OryZ7T
	 dyWTo9uKkTRUgWSEIi4TjJCCH1te+DpDlKwX7fDnHF/ZMcUJ4kRbJcc5Cz8eDg1XgD
	 V/KAofisAZt7Q==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52192578b95so7597718e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+uXcd6Hpg2MqrGhkW+aIvZclonVdIg9fAQlWxgZILZivL/75lauwPYrBXRDFi0iGbAlZazkp90YGlBPLHhw3+C4jlpQrkENiwW6fK
X-Gm-Message-State: AOJu0Yz43JJGJvIhnA/8VKLOfmtMSDRoDYXAOFna8uBkDF/7/Mo8j4mD
	OgYvjEhgC2YNoPxy8TA2KpQ610bPHIUDi6VgvM3StbxwKhs78I/8kxiDaPwv5KSdV5/Ej4kQSGF
	3dXkT4BzEtzMuypBi6Zu1g0nFT2k=
X-Google-Smtp-Source: AGHT+IEPJO8gVpct2Q5WwNj2wvN8zQEAI6qm5VhiD8TRumNyrXPFMB/C4glgYbAiyD8s16TnZuw+9uFyD2FHMpZqD4Y=
X-Received: by 2002:a05:6512:238e:b0:523:8cc2:e01a with SMTP id
 2adb3069b0e04-5238cc2e125mr1200355e87.2.1715757602884; Wed, 15 May 2024
 00:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509013727.648600-1-samuel.holland@sifive.com>
 <CAMj1kXFfWKh-oM8q11eEF94mPOENHxW+fdvkYLSbUDs0ZG8Sow@mail.gmail.com> <c65023fd-5f35-40f0-947d-377088919af3@sifive.com>
In-Reply-To: <c65023fd-5f35-40f0-947d-377088919af3@sifive.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 15 May 2024 09:19:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2h9MkPtaVcgUBvpK6e1NpzMfXN5GFdUmGSe2DNmg3VQ@mail.gmail.com>
Message-ID: <CAMj1kXE2h9MkPtaVcgUBvpK6e1NpzMfXN5GFdUmGSe2DNmg3VQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not select ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>, kernel test robot <lkp@intel.com>, Andrew Davis <afd@ti.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 00:48, Samuel Holland <samuel.holland@sifive.com> wrote:
>
> Hello Ard,
>
> On 2024-05-09 2:39 AM, Ard Biesheuvel wrote:
> > On Thu, 9 May 2024 at 03:37, Samuel Holland <samuel.holland@sifive.com> wrote:
> >>
> >> On 32-bit ARM, conversions between `double` and `long long` require
> >> runtime library support. Since the kernel does not currently provide
> >> this library support, the amdgpu driver fails to build:
> >>
> >>   ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> >>   ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> >>
> >> As Arnd reports, there are likely no 32-bit ARM platforms which can use
> >> the amdgpu driver anyway, due to lack of features like 64-bit
> >> prefetchable BARs. Since amdgpu is currently the only real user of
> >> ARCH_HAS_KERNEL_FPU_SUPPORT, drop support for this option instead of
> >> bothering to implement the library functions.
> >>
> >> Fixes: 12624fe2d707 ("ARM: implement ARCH_HAS_KERNEL_FPU_SUPPORT")
> >
> > This commit is not in mainline yet. Could we just drop the original
> > patch instead?
>
> No, like I mentioned in the original thread, later patches in the series (for
> example bbce5cac4f5a ("lib/raid6: use CC_FLAGS_FPU for NEON CFLAGS")) depend on
> CC_FLAGS_FPU being defined for both arm and arm64.
>
> arm can't select ARCH_HAS_KERNEL_FPU_SUPPORT because the contract of that option
> is not fully implemented, but in my opinion it doesn't hurt to keep the part
> that is implemented.
>

Fair enough. But that still doesn't mean we have to add the 'select
ARCH_HAS_KERNEL_FPU_SUPPORT' only to back it out again.

