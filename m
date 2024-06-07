Return-Path: <linux-kernel+bounces-205495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E668FFCC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94DBB264FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121515574B;
	Fri,  7 Jun 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="dz4Wbqm4"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2306153578
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744034; cv=none; b=fPIXwfGEyNvJtF+I77+iih/+bcCrJ3965/hcwTM7o7MWNIRI/49x4BPfs58AjSbUKGDKKx0IYBuBjX0e89akwpvHH1VyVJy/nutXfCsTMOd/F22JtW/rGir98EHyOPOrNklz0A8ER+K3mGwXDSgDN7FFr6gjKfXyfDJJrZuvqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744034; c=relaxed/simple;
	bh=uDKsXWnZBq8B1TZSbGrBofUZF8hvuJaCCCMe9c3tno4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8gKL0TZMd07BkgjrjVFJbPiRVTHqdh6a2S7XdsGxd+AeHoXwaUyX2A5iKAtc3eoUk5Ny6vTv38Jr3goqu2pegp6fs0SLxWu94pECCTuVxTH86mSLzgUAJkwMIYLgdub/E9ohyUEVm5oI+TRrktG7ILztdUg1tbq6AzDuBw9tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=dz4Wbqm4; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-375833acc98so1260515ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717744032; x=1718348832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CLx8I7uIS4yN2qY8IP79uDVs9k1SwxKuZrHLU/16hk=;
        b=dz4Wbqm42Bp05zD47ZT5UJX5xNZD2rHUqo2J5ey6CCNtibMXbhYzHBZhM80zEb+Ed+
         moeaEH16tN8wYgyesy/ZoccwkUTa+FLo3f8GcBTC4VEkTmeIe+0TwZP0m/l2LPkcp0sb
         MxpCYALqvOj9FGaWdZBJpDqQ9qlaHJTak7pfs6NZVlwGdE+8t3kAKd0BS15gI9WO1Xsv
         rxAWmqvR5XYIkKZkUfQ4Lkz7CO7jdHrZkG7YoRGtbQN2PXmx0zPp3BALadVJN2xhMsVN
         +72etnPkar/szOeg7ZxdkLwuoOaol71KoJHlj4ZoJXFNKjWHsxroguMsbr/6rSdDPrhm
         hqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717744032; x=1718348832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CLx8I7uIS4yN2qY8IP79uDVs9k1SwxKuZrHLU/16hk=;
        b=wvM6HI1RsBejknMlFoGxqzZkM2yTO2vHJ9PuUc8TEpTlSO3naNgOOQFlj6wKUYHJ+7
         fml2rEhTBc0M8u2OonDrltstxk9Y8Qjk22iTqkXvNCehuzO8sxtQjMO2HeqQSG9qjj9t
         Y5UXz20Xb6eGcQxTE3zXIfzRqf6voky9iFq8Bp1ahxnplNk4zj4AsAJXci3Z2yhqxX2n
         1Wzj/5UJjVLj0rKGKFzhcnO9u0HRblCmw/eR8WDWE4WjWj2mf2mlu5vkQgWnI20Q+BhP
         7sm9sj3cXwyYanWWvIOBcbDRHEqFowyT25dWobc99jM6nzBXMspkV85wiRPI+DgILWSi
         hA9g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/JhVjo4vUviwyO2cfR/Q3UdkcENKVbWKVx5FFDkjhpKXKblPL6Qfr06LML0zcRxx1RpXZ/It+P7ud8eCiB0JsffTzaJOUuN8zAlx
X-Gm-Message-State: AOJu0YxxgTquW5TaLHD5U1de4Ai/6MPt07nQfrynXAQfJJYWyP0w4RdR
	CbSUQlpMB4nBkS10XzqadX7jit3l0vhTpqGfNu5MXshdu/B8PoOPUAOEXhioWUrgM/NziFRVBAf
	HaieGfesy7dWvd4xpWf+rT+PDPgMn7sPd5fZG5w==
X-Google-Smtp-Source: AGHT+IFE09PTLjj0080/0bN8m/3yMGgMYsDcLZaSLR2FjJm1yUQBETVhznGnzF1DLd7cgzFg+hOq9wxArotyxseBiWU=
X-Received: by 2002:a05:6e02:20e8:b0:374:9e82:7b51 with SMTP id
 e9e14a558f8ab-375802fcc9bmr22082355ab.9.1717744031764; Fri, 07 Jun 2024
 00:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429092113.70695-1-betterman5240@gmail.com>
In-Reply-To: <20240429092113.70695-1-betterman5240@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Jun 2024 12:37:01 +0530
Message-ID: <CAAhSdy3HPGS48TeG5LxiECAtNyzmzsJPzo+_eicgxL28nAgoHg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V:KVM: Add AMO load/store access fault traps to
 redirect to guest
To: Yu-Wei Hsu <betterman5240@gmail.com>
Cc: atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:51=E2=80=AFPM Yu-Wei Hsu <betterman5240@gmail.com=
> wrote:
>
> When unhandled AMO load/store access fault traps are not delegated to
> VS mode (hedeleg), M mode redirects them back to S mode.
> However, upon returning from M mode,the KVM executed in HS mode terminate=
s
> VS mode software.
> KVM should redirect traps back to VS mode and let the VS mode trap handle=
r
> determine the next steps.
> This is one approach to handling access fault traps in KVM,
> not only redirecting them to VS mode or terminating it.
>
> Signed-off-by: Yu-Wei Hsu <betterman5240@gmail.com>

Overall this patch looks good to me but the patch subject and
description can further simplified as follows:

    RISC-V: KVM: Redirect AMO load/store access fault traps to guest

    The KVM RISC-V does not delegate AMO load/store access fault traps to
    VS-mode (hedeleg) so typically M-mode takes these traps and redirects
    them back to HS-mode. However, upon returning from M-mode, the KVM
    RISC-V running in HS-mode terminates VS-mode software.

    The KVM RISC-V should redirect AMO load/store access fault traps back
    to VS-mode and let the VS-mode trap handler determine the next steps.

I have taken care of the above at the time of queuing this patch.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.11

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_exit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 2415722c01b8..ef8c5e3ec8a0 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -185,6 +185,8 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct=
 kvm_run *run,
>         case EXC_INST_ILLEGAL:
>         case EXC_LOAD_MISALIGNED:
>         case EXC_STORE_MISALIGNED:
> +       case EXC_LOAD_ACCESS:
> +       case EXC_STORE_ACCESS:
>                 if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV) {
>                         kvm_riscv_vcpu_trap_redirect(vcpu, trap);
>                         ret =3D 1;
> --
> 2.25.1
>

