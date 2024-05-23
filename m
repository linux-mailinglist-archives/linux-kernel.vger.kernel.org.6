Return-Path: <linux-kernel+bounces-186969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 560EA8CCB55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48A91F217D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104152F9B;
	Thu, 23 May 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="07LItYxu"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58521C683
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438075; cv=none; b=QxQyVx3pDJCt26mE/hgcp6qWejeVB2HXv7+dIHNxFmz8bUYPBJZRZzSiLr3yWAzfBDHtBCRhvLgung4wTEewQqUGVVsOOrCkUZjZBYeQfqSxGEhvg6WMdCxXUhXyFsb3mu6M8rUKVFFDQZfvP6b7LVeucyOpqCut/bfAz70NQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438075; c=relaxed/simple;
	bh=s9ZgicV1PjoevC+4gWQjK7VslQEcpMpC2CLKAba9f7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1azsD6+Bq3O8UtV2zcLfaqAplwDvNQeMDjZwKtDFtbWP2LUCZbApPpwS5JOG/T7GYMdLJAnwXKl6PR7R+nU0JvVF+CWtasVKbpfH3RRbsWmv0gej8OEkKIQmY4ZhDuR3aVMPNUxKglo8kuGsYyPEvmQpR8n+gGIy8KkvH/hyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=07LItYxu; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c5d26045bso24084615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1716438072; x=1717042872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqFpxyZ6rzHfXC3E6CAF1RLsqjtlBkIgyPwQJ8CpBcU=;
        b=07LItYxuLo1+G181kEWAN2HT5hoO41kCLOZOBYOKvTVxMeYPAqUbzWjD2TdDMfbY0B
         gOUS+/3YAUkmmqmygc6aP596I1nkgwHxY3+0GWT5KRL9j5NFk/dGuEO7isG7nbfKa39H
         o+o2NK1Lw1MF/DiE1C1XvgiuI0upKhyKm6NYGXRqwFFwI333rqc4U+2gxLV2uQrO8FU1
         ggvLsMdzgShzgoHFfcbuZT2bOjeVsx8T1K/913dsp6tCilFz2e9HAT9Hd1VMYt8kT29W
         F9Hi0X9vsSnjhgF82+hexs9DdPxtdz3LRZXoZF6la8jR2UzXo7mOFlteQ/d0u7ytzbLE
         O/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438072; x=1717042872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqFpxyZ6rzHfXC3E6CAF1RLsqjtlBkIgyPwQJ8CpBcU=;
        b=VbNyuKjxp4e7oIIec/EE5DbBmdB51mFInP5js5zq7pGZFeL17+1WukquqNHWfATDnF
         pbf612HLTOeJQw6lDCLaF245WsF5fTUClPxtILJPPYbi0XPIYYtaUxUZIT8+GOcp1ZQi
         UVVX9h93yOUWQ9Nl0Z93UDlNBMafAFe90LdQWmeUcCmHjIYUnpcdEANCgLWwc4c397nP
         39lopC2T5NtTTQcekgkyN/L192Np068iGXI6juzD8ke0cF9W4mQRC/kH0KZCLCARsEwz
         uFj65JHmmC1HlEiJ7OjQ/a2z4eMsgGQ4ykBmpitXguRk6qGSKhyfWRYq+PHMfjEdafA2
         lgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvU0b19V8aAS32+paQ+I9CrQmHzrZv/1MEpc+maUPlpm9TUUI2Xa0TOyGxo9ve9mzPCSoV6ek5cEoubj8womdptXIeYZ3Lh77cSkvu
X-Gm-Message-State: AOJu0YxiGBhguh5p2Gecfnb0d9vV1Y5/bpivT17yeOQWzJE9Uq1TeWeF
	E8rVYr+5E2VaHjvid4lTIikbXMSzbU9LKObtN+T3C9mRFejEwGq6efdE6TJSytZpTCg/Y5CoBdI
	Bsd8T8kHDqfxwEJV9852a8X2TMTVY/UewRHSSlg==
X-Google-Smtp-Source: AGHT+IGApx7/JOvBCBD2391AMJlV4TfZRvcEeIjNXruuf/n6lKOYxnvBWSiCRptaBp2oOw/22seBN0MnLs4UqP49bUw=
X-Received: by 2002:a05:6e02:1c21:b0:36c:cda:e2fc with SMTP id
 e9e14a558f8ab-371faf4ee77mr40735325ab.16.1716438072560; Wed, 22 May 2024
 21:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522184953.28531-3-palmer@rivosinc.com>
In-Reply-To: <20240522184953.28531-3-palmer@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 23 May 2024 09:51:01 +0530
Message-ID: <CAAhSdy2UFh+BYX=gMVPZRJivLxhatZOqBpOuKef0cc0OvrSAGA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: riscv-imsic: Fixup riscv_ipi_set_virq_range() conflict
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:26=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> There was a semantic conflict between 21a8f8a0eb35 ("irqchip: Add RISC-V
> incoming MSI controller early driver") and dc892fb44322 ("riscv: Use
> IPIs for remote cache/TLB flushes by default") due to an API change.
> This manifests as a build failure post-merge.
>
> Reported-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Link: https://lore.kernel.org/all/mhng-10b71228-cf3e-42ca-9abf-5464b15093=
f1@palmer-ri-x1c9/
> Fixes: 0bfbc914d943 ("Merge tag 'riscv-for-linus-6.10-mw1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/riscv/linux")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Sorry I wasn't clear about this one, but looks like it got dropped as
> part of the merge.  I'm happy to pick this up via the RISC-V tree if
> folks want, but I'll keep it stashed off to the side for now as it's
> just touching irqchip.  I'm planning on sending some more stuff on
> Friday morning, so just LMK.
> ---
>  drivers/irqchip/irq-riscv-imsic-early.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/ir=
q-riscv-imsic-early.c
> index 886418ec06cb..4fbb37074d29 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
>                 return virq < 0 ? virq : -ENOMEM;
>
>         /* Set vIRQ range */
> -       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
> +       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
>
>         /* Announce that IMSIC is providing IPIs */
>         pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwno=
de, IMSIC_IPI_ID);
> --
> 2.45.0
>

