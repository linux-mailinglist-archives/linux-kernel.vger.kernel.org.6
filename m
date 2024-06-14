Return-Path: <linux-kernel+bounces-215265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924DD909069
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494651F21CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C319DF41;
	Fri, 14 Jun 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="lNuW0Y5b"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D116DEB8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382788; cv=none; b=XaXKvL4nE6BLK1A2rph9GDryMaPnZM1qWBHA/8ce1GwQ4j1myxcK7LJg9Ojs38T+vmY3+eJoNvXCZnrZTaJPaXIvU/6BEPnHN75j9lmCwtgfbm3n+xrOIuPMV+gYmTtkA3D13ZdgYsWRMNUehLsnmeKGfl1D0SQHWBhuKwxT6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382788; c=relaxed/simple;
	bh=Ce7aQQMMm7to8UHvxdl22nE43n7aWPIstOM/RKSjPnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L69+uOwWZHoNxZC0R/wMTPIU3VeIfYE2Xs8k/ZlmxVm2CAgp4K86TYe38GHjAZ+mZ05m8MJRGLXABW2oXr8PYfk2u+Qyap2Qa5orF3o9OCWvFtohF5IFUkOX/yANpYEI5Gvqv9ZAPletSYG5rVGCKMILAFDKHBEGgJmINLwUsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=lNuW0Y5b; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so1867232a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1718382786; x=1718987586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmANL2aAdKz6zDNX67dUWd/cwt7M50wQJ2zAXtthGTw=;
        b=lNuW0Y5b4W0WDuWkLXhclqE59b63A9+9Y0+xDYMMzpX58vX9RtseD5aL0tTG5El1oi
         oMW22vQQRF440pOlNL4fstdNSNskhHYuEpxUOIjxpca1q/xo9eh6zh/5xjk1gbgwlUYC
         1FBc7OO39jtYdOsml5JnPH9vQygGr2j19UMJt+ny+pRr9XaUqqccuoVUBkeKmfx5LZF9
         smBfUq2AOPeWus2B6GUzoZvvKEN7Vtt9ob+7yAEUUaIVXtHL6UOzIAjjj28lYQAwmzsE
         bAIymYQ26l1LYwcNtrO/pgXrqbuA0xOYolMHHzZPd/6vu3cRS7f8IGbhVyViURcuKjv8
         ufdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382786; x=1718987586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmANL2aAdKz6zDNX67dUWd/cwt7M50wQJ2zAXtthGTw=;
        b=jyjW0P5SRr1/aTfo90fJU/S3+/f0qmZMEHTYE6pzakeBqcC0QI96EoWkNCAYerG3zW
         fM36enyHFrN0sgmY4v/xvJnoD+l+tbLdOWXaT/iwid0UYbMV0DXA18jClrBuq/gAuCEa
         w5bakzzAHyUC/ui1K/KmqfJp0B65pjWZpQkGg2IsMusORfBF47vXIYbnLXRJ+/7phBci
         o6Fhs8YH/pJFnZqgs3RYhIqyhcx2ADNUf9G3fraL3WryNCMIPeS0MjdsdyBA4k2UlyNy
         2fh19zYeIxA2Ux/Va1cHcRwrrHwkHBdbr9mm5oW6Z/XsaLjcpq/NSBp9yINuw2haOPRL
         /tkA==
X-Forwarded-Encrypted: i=1; AJvYcCUNaHWlMS+xaItqRSnTKapGhBywCAICGrdZg18Blw9VHHPLlzhytyHcwDQ20uppa1L9mWHJIb7mdOrzQGpQ5WD+0m9cHqCwbYQwMw0W
X-Gm-Message-State: AOJu0Ywqe0l6aoNAK5klT/Nfr380ruRza4MjXX6F0WJ/LNE6aGr0hqy0
	x023E3nAeJ+6hKvv8CSPjhdpmH527v1jycQrUmyeFXFOBRtrB5mKO2m+yAk5Obk/s7o2SNf2pko
	iCZi/6eu42/xiIm+rHShaH8xm3jCtdHSnuIhqCA==
X-Google-Smtp-Source: AGHT+IEsB3qM/Oj0kPu1JXFIcCWyvaMDZToK1L7g/QZz8kOHLrMykq6jJMeOHC666aJoGrouLk9SPQrV4Ei7lkVn1oc=
X-Received: by 2002:a17:90a:af90:b0:2c3:195b:dc36 with SMTP id
 98e67ed59e1d1-2c4db12bb3fmr3373710a91.10.1718382786244; Fri, 14 Jun 2024
 09:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614151955.1949-1-jszhang@kernel.org>
In-Reply-To: <20240614151955.1949-1-jszhang@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 14 Jun 2024 22:02:54 +0530
Message-ID: <CAAhSdy0b16f8JAZ3r=drSuRA+hmWfGgAcX_scnH+=OOaaUh+dw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Remove asmlinkage
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:03=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> The two functions riscv_intc_aia_irq() and riscv_intc_irq()
> are only called by C functions.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>
> Hi riscv maintainers and all,
>
> Related question:
>
> I believe the asmlinkage in riscv is a nop, is it OK to
> remove asmlinkage from all riscv code?
>
> Anyway, no matter what will be the decision, it's correct to
> remove asmlinkage in riscv intc driver as this patch does.
>
> thanks
>
>  drivers/irqchip/irq-riscv-intc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 4f3a12383a1e..47f3200476da 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -26,7 +26,7 @@ static unsigned int riscv_intc_nr_irqs __ro_after_init =
=3D BITS_PER_LONG;
>  static unsigned int riscv_intc_custom_base __ro_after_init =3D BITS_PER_=
LONG;
>  static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
>
> -static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> +static void riscv_intc_irq(struct pt_regs *regs)
>  {
>         unsigned long cause =3D regs->cause & ~CAUSE_IRQ_FLAG;
>
> @@ -34,7 +34,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *r=
egs)
>                 pr_warn_ratelimited("Failed to handle interrupt (cause: %=
ld)\n", cause);
>  }
>
> -static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
> +static void riscv_intc_aia_irq(struct pt_regs *regs)
>  {
>         unsigned long topi;
>
> --
> 2.43.0
>

Yes, these asmlinkage can be removed.

Previously, we used to call these handlers from low-level trap handlers
which is not true anymore.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

