Return-Path: <linux-kernel+bounces-332571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1597BB51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E831C23E58
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6918A92C;
	Wed, 18 Sep 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fjmgh40+"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C718A6D0
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657836; cv=none; b=dEoSH5tlVeVxLX3y+kUyvqsPYVkH53N5FMWfYxBoxtwM0Zx4rvRHickRs1Mj6ck7Z6qX9uO9Bbse5kRW5qUYJYN7vqMXMp5VaHqerh565NO2LQnCp/Ol5W1JeFSvu/2/v7peKi/O3cSW3wSVYs35lYUrP+AcfAAcbd1znFNMz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657836; c=relaxed/simple;
	bh=SRZbVG1IhzLF4gQfRB4AzzHyFJqyHn5f75uQWWvm/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdlc1fbcWLLi4kd0hqDT6Dp6fOk+eTkNDsjuVk7jIBbiEpx/dV1t3584sinPOZN+ZJ2HmuyGoqKCDCrFvYqJopauGprRdSvDdGK17oPSShwAi7qgM6LVxTuz52vwzZLRda548SBspgPln2iUGQwxmXypOd7//kD/krzRZdof7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fjmgh40+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1275794a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726657833; x=1727262633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZbVG1IhzLF4gQfRB4AzzHyFJqyHn5f75uQWWvm/bw=;
        b=Fjmgh40+ftP0oBAoV7wb1YbtRSnDqe9C0uXoNOnnJ970IqMO+QImfcycKVE5p+DeAI
         /Or5sgPa9iHtmC2w4NGyAAKhwFrc6I/LKIYr+d0sdiwvY4kHdctIbDEv/nH8vWoownX/
         HDts95D3XQGxzZ9cR2miNweCtLYuSEfgbtbqqESxqbMszQkJWVFkzpU6wocLqPf/E/ef
         SSdFd5EMR8mYLeD/OCwP0X9pEvDnvjH1AgNYJwgbJraHWjAfB+++yqtjNbPeoJqGAh5X
         RbUfbiV8k7Y9Vy6TjKUZLLnES1k4EYsKkifzT2mPzF3d1h/e64CHW8roAmB/wRql6U+q
         UDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726657833; x=1727262633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRZbVG1IhzLF4gQfRB4AzzHyFJqyHn5f75uQWWvm/bw=;
        b=u/Wezo7X0NZCYlLy3M9BNRZ0z/oMmoNv6VniPP5H6ySbftwulgTLn8wqELOiRd/8Ml
         GWLa+5CkY81a15XICtcF53MueLVWL9eW7DHOov+N41xS6NLmRtQ3Ivl6iHt6BhLpcgUS
         RcVkaUfl2x1Yvkn+z+ivoHisKJVBT/pqMLyr7gxRnyfhc0xp+wMj+5WBbiSAZTGNBPTf
         a+AnDsqV/AeWb6MokxU3ZsnxssbsaE2edxknRZ9ARhGlVduGEQ95ZVrH4XlHr/aUPm7v
         o83NJn+yHyYBmfFXK68VdqnftpCSA9rSQq4wRNNguAGc7aGYDnpHxRhSMxD0OHAA1d5T
         dn7w==
X-Forwarded-Encrypted: i=1; AJvYcCVmaqrNySz4trLT26mvxBuCpJnUb7SzmtjLuZ4mt66urFtYWyxf+456s3mvvIPv9bXzomqT74gfS+ErKJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GeTieERNgu1J7+aHfLF79Vwr3hfqt5p9+Gfb5gpNMbFC7FrF
	3IxuZqCRVLPJX08xU/CS++9oMmNCgLCqsaOfYKHozENU6yMZtSHBE90W12Aw9FwJE7npN5l8CCj
	299a8gH8VNuByzbxvkFni4QxrzPFhDwF3eqkadQ==
X-Google-Smtp-Source: AGHT+IGBXJ07Gt78CUwOdJRwkknc9yCkL5BLIwG3FEocWciml96gp0ZI/zuYvW05MNno9h9wE8tMmu/6bWIym7WiaKI=
X-Received: by 2002:a05:6402:520e:b0:5c2:5248:a929 with SMTP id
 4fb4d7f45d1cf-5c41435c3d2mr27093336a12.7.1726657832550; Wed, 18 Sep 2024
 04:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel> <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel> <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
In-Reply-To: <20240918-039d1e3bebf2231bd452a5ad@orel>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Sep 2024 12:10:21 +0100
Message-ID: <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
	Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 07:06, Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Tue, Sep 17, 2024 at 06:45:21PM GMT, Heinrich Schuchardt wrote:
> ...
> > When thinking about the migration of virtual machines shouldn't QEMU be in
> > control of the initial state of vcpus instead of KVM?
> >
>
> Thinking about this more, I'm inclined to agree. Initial state and reset
> state should be traits of the VMM (potentially influenced by the user)
> rather than KVM.

Mmm. IIRC the way this works on Arm at least is that at some point
post-reset and before running the VM we do a QEMU->kernel state
sync, which means that whatever the kernel does with the CPU state
doesn't matter, only what QEMU's idea of reset is. Looking at the
source I think the way this happens is that kvm_cpu_synchronize_post_reset()
arranges to do a kvm_arch_put_registers(). (For Arm we have to do
some fiddling around to make sure our CPU state is in the right
place for that put_registers to DTRT, which is what kvm_arm_reset_vcpu()
is doing, but that's a consequence of the way we chose to handle
migration and in particular migration of system registers rather than
something necessarily every architecture wants to be doing.)

This also works for reset of the vCPU on a guest-reboot. We don't
tell KVM to reset the vCPU, we just set up the vCPU state on the
QEMU side and then do a QEMU->kernel state sync of it.

-- PMM

