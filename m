Return-Path: <linux-kernel+bounces-219011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C606D90C8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B2A1F213D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CB20D494;
	Tue, 18 Jun 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IZYP2lbU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B920D485
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704826; cv=none; b=fSUMEVAJr6oI6+txgVxjnSQstYNcOGQr5jLNb6H97Ud03N1g8rZWbo/KRhvpZL/5tIFyTgewDVo+PRF783gZr1WRFu/OXN4BOxvr9UvVpwh0yjwAQWOp7431Um31EmdBe3oHmgBX+T4Zg5m3Qn7ktlER0GutTgNlEDrBRy50XPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704826; c=relaxed/simple;
	bh=MPZfkhMcXHUtq5cnaXvPFbwUglZVGv4j83dGgH+XUwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG8xeP7zXvIFO9Ga85UOWUMfhNrMmiz0PNoHXQ+q69hlnMMU9a5gPeTcS1frMBFlp+RHtZF5pzkAY2cEGIcwEQRAeGq8ZdkuZDPsBSEQ0MaC/1lLSTgVKX6wrvMTjSjYtAIDBqAsjvCr1+LK3YS8r0KMfnALqH/TEzp6AHDxLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IZYP2lbU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041e39a5beso3844140b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718704824; x=1719309624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZR8CcgURsRbvnUXkE0a3SupFeWf/zFWGzZmoJybLWM=;
        b=IZYP2lbUqJJTNBWORi2y60gGAu/tlZnsXJqmLyiEItap9gHr52HlKCEmkTeTNgjB4s
         MrVmUJvzr+5fZzw9f5LvTJHTQf5Wwekqs2ND0iCIo/o/aud2Yjwlm+rhq/0dxn7oPLJh
         2invlnVfEPWT3p7WUqPKjj23I0oDY/lFGXyRwq6DqPjexZDGZOLIJfdRgfgVsesRPgr8
         TunpxAojokVZdyVYjn7MFZp32Yn/IW7asepdKDdC/5XrCCPPRF3zRpwsZrjNh/QfU8QM
         RetLQcwUB+/U91pcQaodfHGCs9eu3kim8pgcTEBqPBzS+/v2Zmv5iM23CiXbU9aglYTj
         x5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704824; x=1719309624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZR8CcgURsRbvnUXkE0a3SupFeWf/zFWGzZmoJybLWM=;
        b=em+kbWMJd97pexbmOpKEvaYmG5yxwNVp0OKd3b0FiR1peQhv5LYL3v2JKkV4OYyU1C
         nZWmJMH8NWJUHPUlIfXMQMuPfbB4WTdHYjkybQell4BD7gpNLcLxsqedhOy2e4z/MOvS
         5musjfwaBU0M0UmGpJpylo1Hsa1KXaHfy3mldZUB9crWHEpZsVsr1HItVtk7KLQTFpVU
         +vw3gc/6iFq649dI+WQ1clxv++qHx9iEa4XKYve2TLwyhrz1ChJ2K8DXgoYgwQNQPpGl
         qG5ldlTYo6anUMGuIbp5A62+zC/lCWyhwe8p3rTbHXP5ncWkcQKDh3PjpVwCDMA3e/Sd
         5j/w==
X-Forwarded-Encrypted: i=1; AJvYcCUDw3GTvyGUjuCfvz6U74Ns83GR/j+XiEvmP+HYje74oYDlMPcCeTFbxDpidxNA1ZRaSN33jyZqrzZemYgBJYtmN1cgaXCkmhNMtDSs
X-Gm-Message-State: AOJu0YzSaFW9t7qDGTLjt30o/H1y41mMAABOSjgt3xYzQmU5XuvkHx5n
	op89DbNZrYKpnoJ8SFjEuqNZJy56nYtuaP02Qxf1fHn1c7+uBQLfsqa+XvCvNTo/i3QmFIIOvfy
	J3icJNJaqBlHnKZ0XR7STf7TbJfltaytPSyx1XA==
X-Google-Smtp-Source: AGHT+IHx8ALlkkaSwJ4WcPFZ7PFlSkSqM6tzPJZC5DokDwldFt2gGFu1bgX+jONtFmGJCQjSmKZTbOUyQJm+CSgTY8k=
X-Received: by 2002:a05:6a20:1592:b0:1b8:498e:4e29 with SMTP id
 adf61e73a8af0-1bae84146d7mr12687693637.52.1718704824273; Tue, 18 Jun 2024
 03:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725070549.89810-1-luxu.kernel@bytedance.com>
 <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
 <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
 <CAPYmKFvqpe48zaLKrTz085cJcO9fwL+BtHujU4p48onR1Nodfw@mail.gmail.com> <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr>
In-Reply-To: <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Tue, 18 Jun 2024 18:00:13 +0800
Message-ID: <CAPYmKFuLap8SZrcgGM36G85TYshuhMhMA1WUHt1A_VkD9JiTqQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I will send a new version later today.

Thanks,

Xu Lu

On Tue, Jun 18, 2024 at 5:45=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Xu Lu,
>
> On 24/08/2023 14:08, Xu Lu wrote:
> > On Wed, Aug 9, 2023 at 2:58=E2=80=AFPM =E6=97=AD=E8=B7=AF <luxu.kernel@=
bytedance.com> wrote:
> >> On Wed, Aug 9, 2023 at 2:05=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.=
com> wrote:
> >>> On Tue, 25 Jul 2023 00:05:49 PDT (-0700), luxu.kernel@bytedance.com w=
rote:
> >>>> When arch_local_irq_restore() is called with flags indicating irqs
> >>>> disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> >>>> implementation based on csr_set() function only sets SR_IE bit of
> >>>> CSR_STATUS when SR_IE bit of flags is high and does nothing when
> >>>> SR_IE bit of flags is low.
> >>>>
> >>>> This commit supplies csr clear operation when calling irq restore
> >>>> function with flags indicating irq disabled.
> >>>>
> >>>> Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> >>>> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> >>>> ---
> >>>>   arch/riscv/include/asm/irqflags.h | 5 ++++-
> >>>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/=
asm/irqflags.h
> >>>> index 08d4d6a5b7e9..7c31fc3c3559 100644
> >>>> --- a/arch/riscv/include/asm/irqflags.h
> >>>> +++ b/arch/riscv/include/asm/irqflags.h
> >>>> @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
> >>>>   /* set interrupt enabled status */
> >>>>   static inline void arch_local_irq_restore(unsigned long flags)
> >>>>   {
> >>>> -     csr_set(CSR_STATUS, flags & SR_IE);
> >>>> +     if (flags & SR_IE)
> >>>> +             csr_set(CSR_STATUS, SR_IE);
> >>>> +     else
> >>>> +             csr_clear(CSR_STATUS, SR_IE);
> >>> Unless I'm missing something, the original version is correct:
> >>> local_irq_restore() must be paired with a local_irq_save(), so we can
> >>> only get here with interrupts disabled.
> >> Yes, it is correct if local_irq_save() is called when irq is enabled b=
efore.
> >> The flags returned will be SR_IE. And it is safe to call local_irq_res=
tore()
> >> with flag SR_IE in any case.
> >>
> >> However, if local_irq_save() is called when irq is disabled. The SR_IE=
 bit of
> >> flag returned is clear. If some code between local_irq_save() and
> >> local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STATUS
> >> back to 1, then local_irq_restore() can not restore irq status back to=
 disabled.
> >>
> >> Here is an example in existing driver (may not belong to riscv arch) i=
n
> >> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c. The pseudo code
> >> behaves like:
> >>
> >> int rtl8723e_hw_init(struct ieee80211_hw *hw)
> >> {
> >>       int err;
> >>       unsigned long flags;
> >>       ...
> >>       local_irq_save_flags(flags);
> >>       local_irq_enable();
> >>       ...
> >>       local_irq_restore(flags);
> >>       ...
> >>       return err;
> >> }
> >>
> >>
> >>>>   }
> >>>>
> >>>>   #endif /* _ASM_RISCV_IRQFLAGS_H */
> > A gentle ping.
>
>
> This got lost but this is still correct and needed.
>
> Do you think you can respin a new version? Otherwise, I'll do it and
> keep you SoB.
>
> Thanks,
>
> Alex
>
>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

