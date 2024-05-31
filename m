Return-Path: <linux-kernel+bounces-196300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD98D59F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D9F1F27141
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAD7B3FA;
	Fri, 31 May 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="z8G6tu6o"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7852F7A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134140; cv=none; b=rcvbT7xq4BS4JbA7J2tvzKsF6oFGHqjj7eYHIMXPZIgb58PWjWWuvwaaB7boPwTQ2Safyp+GZ/AzLPkklvJLiBzzXNzc7BWwZqJ39YdZ0WC1qtj7tMiSQggwUGwkA/kGULiVYrpx6KuKry85nXigp/cI+nqE+LPZ3fdjld3eXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134140; c=relaxed/simple;
	bh=xBhn4FqMHr7qVwz2luiXPl37K5D2EBhvaRA62rusHzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpMLHa8vcUxVPVdcoM5gmFrv6MoyHjaVcqxlN7jZwwIqga20dT61ISJCb1hpoCSk2YRa9WK7NQyW262qv2wX7i8eSkUs0qDCDbwd/WBVQH7j4dBIovjCbFO1ttbBxmwYv/hLvgduWfxsp7briNBlfc3dZ+KaOvxbtqpyvF3tVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=z8G6tu6o; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e201ab539eso72249339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717134138; x=1717738938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O7d9Ggj1euHigzWUl/7tmCoiCMPOOy96o4IjkVfxbc=;
        b=z8G6tu6oIZOcw2uW9LUlQkfHRRjrkO9n+zoSWzwm6Cuo+k13j2LRdW5Wl1yuFrrpLV
         D532b8FtzrxhC2billrlDMQUVw22BHG8gNJTpAle3+a92HMpMU08l+eqFum0I50E3dUy
         jvRb1z1zH3Cv2/jEmJfgnt+i/THZeHBRHzBH07slzbknHZPr6U080ooV9ScKXOR/Nqh7
         wjG5jIKc1PC/tE9kfth4Pg5QO6EzPyarqSakTfZd3NQd8jbAJ5VJxsvoq6HW6gJKXru5
         A1RgbulEjbjeNh+U6c9XZR1PAiYSRjKwX3jFSd/G0Eku2wHIl8r6IZMkR6X49tVbkw6Y
         hrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717134138; x=1717738938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7O7d9Ggj1euHigzWUl/7tmCoiCMPOOy96o4IjkVfxbc=;
        b=kXFW3lul/jJRF9nNk+MxgVUQZGpYFaPylFMiF4N8Ues0WuVLFIS1rLwK0OGAJtmAMm
         eBBH2gzpOWzAhAGJS6gMCnQdpZadztVCR8O3XIw1sAvEhOvQMT+jwvobsigdTEJQR5p1
         Pb6OpYoVHR/YIxIv+dzVtpj/j1Hzmh4M/0wA25VwlrthFS9T0JY+01qMRCO8Mp0lsXnn
         kqZaLI5BYlBCCKtMAyw4hrM9s32WPJplIVyFjqNIEF7UliGwEFjmyXH5k0IZ3OajbGq/
         uZ8XXPRwzQo7EJYfZqbRgTl9Am2FgvYTcbQk3X0z2URXBtt36e/1vsiR05vAZJn9/Cys
         8F+w==
X-Forwarded-Encrypted: i=1; AJvYcCVzaZ1ajY2YG3vz+DaIIpB9lOQbf1VvbnJda2wJGjylJPNzoxqCrvpUv5Oh5LaP2i1BLJqJ3C69Tuav2smjqWYZk4SfNxqGSuffG1xN
X-Gm-Message-State: AOJu0YwYO9gKWxJJajKWIODtI38aYMFOPbN6DLDE/nRHOu1oQyqJf1/b
	6YEmtx1ypilsBT+UQTTfxfEbNT8ISc+TZlS4uupZec1wycLydyWXJaGOOgXFh98/hnl6VE73dND
	fWiotMfSS728OswLoCRSBF4HRH4N8zlrIbcmywA==
X-Google-Smtp-Source: AGHT+IEtj9pGF5vtAyZZfL+KJ2BJbeEtCqJtl3SIrkwKxUBy8V/vzqXxMBy/vadTFe0iv23wkzuDXFNgfcG5jn+EYHg=
X-Received: by 2002:a05:6602:2c02:b0:7ea:cd68:d235 with SMTP id
 ca18e2360f4ac-7eafff45e66mr121858839f.18.1717134137673; Thu, 30 May 2024
 22:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff1c6771a67d660db94372ac9aaa40f51e5e0090.1716429371.git.zhouquan@iscas.ac.cn>
In-Reply-To: <ff1c6771a67d660db94372ac9aaa40f51e5e0090.1716429371.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 May 2024 11:12:05 +0530
Message-ID: <CAAhSdy1Mjx5cq0Gim3TBFSCNbCJPvMxkRSC-gW6KjFeGBrg75w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix incorrect reg_subtype labels in
 kvm_riscv_vcpu_set_reg_isa_ext function
To: zhouquan@iscas.ac.cn
Cc: atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 7:43=E2=80=AFAM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> In the function kvm_riscv_vcpu_set_reg_isa_ext, the original code
> used incorrect reg_subtype labels KVM_REG_RISCV_SBI_MULTI_EN/DIS.
> These have been corrected to KVM_REG_RISCV_ISA_MULTI_EN/DIS respectively.
> Although they are numerically equivalent, the actual processing
> will not result in errors, but it may lead to ambiguous code semantics.
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

Queued this patch for Linux-6.10-rcX fixes.

I have added an appropriate Fixes tag as well.

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_onereg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index c676275ea0a0..62874fbca29f 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -724,9 +724,9 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_=
vcpu *vcpu,
>         switch (reg_subtype) {
>         case KVM_REG_RISCV_ISA_SINGLE:
>                 return riscv_vcpu_set_isa_ext_single(vcpu, reg_num, reg_v=
al);
> -       case KVM_REG_RISCV_SBI_MULTI_EN:
> +       case KVM_REG_RISCV_ISA_MULTI_EN:
>                 return riscv_vcpu_set_isa_ext_multi(vcpu, reg_num, reg_va=
l, true);
> -       case KVM_REG_RISCV_SBI_MULTI_DIS:
> +       case KVM_REG_RISCV_ISA_MULTI_DIS:
>                 return riscv_vcpu_set_isa_ext_multi(vcpu, reg_num, reg_va=
l, false);
>         default:
>                 return -ENOENT;
>
> base-commit: 29c73fc794c83505066ee6db893b2a83ac5fac63
> --
> 2.34.1
>

