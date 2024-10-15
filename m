Return-Path: <linux-kernel+bounces-365179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9B99DEA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DDB282F95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8600018A6A7;
	Tue, 15 Oct 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="muNHin34"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829113F435
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974716; cv=none; b=hArXckYK0WjOGHBoheo7uwxizOTBqPQuzVmL/y4DSq3Lio9WGvbsF+4kNXQrfLb+cVIwoSVc4ChnC/S3cn5qQcJug8fFvbKvkJkBgzXPyTAfUL76qwfckRVlx3PFOW2T8eQ0T5ekd89gPzI5tymTM/XroLdwgK8ImWskgMDqruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974716; c=relaxed/simple;
	bh=cygSbdL1l01PDza4eT3vUI2V72T4WMHSiJjgEk2Kvzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvamtp6sNCHTTIVzo6pE0VOz9ifPgbarJfJMDZTNDKPpePI4DMscYUWOLpTQrqL7axQ3Wy4jeU6rVhxZgo/C8FcfJaGHNjWQPWvTCa2xNuDHMABCmoM8WRJuDjH16zuqAJH7HBXa6oNX/LiYlN2SBACY/O9/B0WESxJvZ+pio7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=muNHin34; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8354d853f91so195144039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1728974715; x=1729579515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTOjdDeupMvfI1VTnlp57mS+VDL1wc+Sjs4FCRiPhYg=;
        b=muNHin34gOp/KOx28BzPv57yrdXSBdo6cbeKyAzwkHCwr/E8ZyFFe2VI+nEijv0GM/
         ddwIXm+eLXio1vkeDenYw4BHacTC+bom652aaVzCrHYboXd/e3weWq9VHZkiAmbTlOi1
         i0K+sMeXDopwjkZciqXhGqvDHqRHEFDpqSVL506lkXy3uM0HQb9Mm7SOwD8VeXiRbMMW
         qZjwpIjLd8aDhpkcHEp+cC1SZOIXXyysi3fHDq7NVcNExv9lr0yina9fCvhSu0gcyFRQ
         yIlGl22hfHg/9WwlIj9wWmMPGtJNbA9MBZMy14/iqTZnKSwuoxU+xhpnCc3CqS/EYnxG
         p+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728974715; x=1729579515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTOjdDeupMvfI1VTnlp57mS+VDL1wc+Sjs4FCRiPhYg=;
        b=Snx9B5U9C/X09ZgfuUm67oQgQo77aY9oxRIvU2+tjAA2Xk22IPoLXrm92teG0cIZus
         1nF8+QyikvsR7yzOf1be0T/YjpQ2O9buaRmETgpgIcW5WDhP9lSL1ZPHcsxAtDLE++X1
         +ItnsUxwYvPDaGukXaeRZbQamSc9R+Y7XRjA/kmDg2mxn6Z4y0fMgJGZ/QzmRQTI4BMq
         Uzc9Oq8VaQQCa2zsMsXh/lY1G0QpYgrvjEOSYj8Lq6354ac3xa+/VetVwxtj6lavHHA1
         FR+VaXDMA8tgEaxdsk+qkJcyUDZKLsTTBTX24QR/ycYKEV/RTdjSK+6mIIhGO9aDykVt
         pnzg==
X-Forwarded-Encrypted: i=1; AJvYcCVaqVYmQrd9SpYaGGnWWeBzqrNIZ33mS2UueLMj79q8JkQ4sZmTSKxG5HgGsFIyMO1XBFVf2zXQSDfb9jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfu+OcH9cGIRme1p8Q0GNlmSGcuRm8njKp1RA5njYRuizzXY0a
	1cRxXg3OctuAQVTnYBd4ZsdhfYBYIpoZ4jAht3B5k4r355imP0jX+r/8ubtpqRV5xOpq9+frUmY
	+rTYREiy6nhlhYuAU26kHZ82yAn+YZ7zKAcVRaQ==
X-Google-Smtp-Source: AGHT+IF+6ytBf2/P7xS3z4FPEZJZLcGyWg4N3M08mx1lsLaOIO9RQVHctNrSJxlvVx8vLnBAocKVchobXr+NRQLS1Xg=
X-Received: by 2002:a05:6e02:3b0a:b0:3a1:a57a:40a1 with SMTP id
 e9e14a558f8ab-3a3b5f233a9mr120319715ab.5.1728974714838; Mon, 14 Oct 2024
 23:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919160126.44487-1-cyan.yang@sifive.com>
In-Reply-To: <20240919160126.44487-1-cyan.yang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 15 Oct 2024 12:15:04 +0530
Message-ID: <CAAhSdy3x680G2cXqam0uc1kAAg_Cd1tFhBVygOrLZ0bL9ztDBg@mail.gmail.com>
Subject: Re: [PATCH] RISCV: KVM: use raw_spinlock for critical section in imsic
To: Cyan Yang <cyan.yang@sifive.com>
Cc: atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 9:32=E2=80=AFPM Cyan Yang <cyan.yang@sifive.com> wr=
ote:
>
> For the external interrupt updating procedure in imsic, there was a
> spinlock to protect it already. But since it should not be preempted in
> any cases, we should turn to use raw_spinlock to prevent any preemption
> in case PREEMPT_RT was enabled.
>
> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
> Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/aia_imsic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index 0a1e85932..a8085cd82 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -55,7 +55,7 @@ struct imsic {
>         /* IMSIC SW-file */
>         struct imsic_mrif *swfile;
>         phys_addr_t swfile_pa;
> -       spinlock_t swfile_extirq_lock;
> +       raw_spinlock_t swfile_extirq_lock;
>  };
>
>  #define imsic_vs_csr_read(__c)                 \
> @@ -622,7 +622,7 @@ static void imsic_swfile_extirq_update(struct kvm_vcp=
u *vcpu)
>          * interruptions between reading topei and updating pending statu=
s.
>          */
>
> -       spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
> +       raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>
>         if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
>             imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
> @@ -630,7 +630,7 @@ static void imsic_swfile_extirq_update(struct kvm_vcp=
u *vcpu)
>         else
>                 kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
>
> -       spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
> +       raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
>  }
>
>  static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
> @@ -1051,7 +1051,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *=
vcpu)
>         }
>         imsic->swfile =3D page_to_virt(swfile_page);
>         imsic->swfile_pa =3D page_to_phys(swfile_page);
> -       spin_lock_init(&imsic->swfile_extirq_lock);
> +       raw_spin_lock_init(&imsic->swfile_extirq_lock);
>
>         /* Setup IO device */
>         kvm_iodevice_init(&imsic->iodev, &imsic_iodoev_ops);
> --
> 2.39.5 (Apple Git-154)
>

