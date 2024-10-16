Return-Path: <linux-kernel+bounces-368790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AF9A14FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6171C22656
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DC1D3181;
	Wed, 16 Oct 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="lW0IonHC"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355D1D2B37
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114836; cv=none; b=kmlzVdtKFFKMPOdZ8oucxvcS9kz2Z6Rv25iGadj5+1XPstk0ZTEt71ohmUpARROUo+f3s5JigIDAl8+o13jNklaVM7jlZK6ALVhgZZoDLbxzuqBxbFAu0o4KyS9iLJw6El+mJ8mCTwz1WwFog9JyahEYVfiRJwf+bag9JYWxrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114836; c=relaxed/simple;
	bh=wfvdwbqhSSF47yDMIkeJXITavFjKyTiIRpRSxc4gHJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtCgYd5sUCkScMYiCeV7j/6N22q14an+P4BBJjxWGG4RG/Cq9HnXHlyfVfJSwUfwspkdH6AQ6Pg8TKkfj7Rwo5XbfkCJTi6GxCtdf+zMoigwmlEyXPQ8+C/m9MG7CsTPYiLWht8BtWIKYPTUP3pi+CmA2DQMEjeIm2fr9B7IbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=lW0IonHC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso261835e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1729114832; x=1729719632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK/FMBO41F0k5XVWKFVW2dU30aEpK/ecSDxmrBc+uhE=;
        b=lW0IonHCK57Zy6zpC9ZK/nXP3OWlah+MT8POeJYS+707z+NJ2QOVjPagPzVWdB4OOO
         7U0yOAiryTY5tP0GM9c6xkIg6ETsTMshQpHBNfsz/qhjBL3+YdJkUFcQ3PPeE3GeFcd2
         9OxXhOSetbZtaWB9rMwqtumDiu2eKf1Kl9ZhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114832; x=1729719632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK/FMBO41F0k5XVWKFVW2dU30aEpK/ecSDxmrBc+uhE=;
        b=v6JOgiaaV17sc+NuWHOdZpsQ+/f76wtWV+wsHIAHdHPlHNJopPI/aUfUaRzzFJxgbL
         FvchfEyWSYK8efnbA5N20F1ypPd2npDte3JZNw7mB28wDsBq/30ySvvL4n4rB926qCJu
         gWNagQy1ul1qdlBcI+wMdvG/r7blglCU3eq5jvqyJ8eNfP66SEcWH8uZi4R0IavyQmGJ
         nYFBxyStLArhWUZ2E+jVTsbIYHn95B5e9RaPtCHzTKQBYEyOGIhbFUabGenccJuq+RF+
         OnfQmeCyUGzCdJWfa8rs4lYajc/q0k1kt278/GiyHTaZ4x+vmxnCMvi1vuNcyS3BrY3L
         j6fA==
X-Forwarded-Encrypted: i=1; AJvYcCUhZ8ghELoELFDNGs6BpIhHO2la50HftyMOaheW4qH7TDVn/Y5kN7Vjlvq6ihCzeFkJPurV5YAeQy2Mkfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2cP5/amKsw8Ws+5OZb20HgiQwMbn6DLvdXB6uU6ZM1pJ4QRo
	wDuWsRKggLwV83V4ifaKB2PZKc6gg4r+TDYfv7x7jyQcQlGdgmIH/QW1jNYxRn42mG3FktOXey2
	s38j6vOG1qHJhvPqLNRCYs658YMjT7csIKLCB
X-Google-Smtp-Source: AGHT+IHm+rppT2jBLrv4MJVazg4/+Wq/0WmR8zBCpedbjekw1BVdrrjEVCQASyp+Ge+wyK6mNgZuORoIrxTa5tX2vRE=
X-Received: by 2002:a05:6512:3e1f:b0:539:fa3d:a73 with SMTP id
 2adb3069b0e04-539fa3d0be6mr6343173e87.39.1729114831422; Wed, 16 Oct 2024
 14:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719160913.342027-1-apatel@ventanamicro.com> <20240719160913.342027-7-apatel@ventanamicro.com>
In-Reply-To: <20240719160913.342027-7-apatel@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Wed, 16 Oct 2024 14:40:20 -0700
Message-ID: <CAOnJCUKugAua2ooQL5tJCNFr27pCrsQ53YJuKEs11UYJdVkAPw@mail.gmail.com>
Subject: Re: [PATCH 06/13] RISC-V: KVM: Don't setup SGEI for zero guest
 external interrupts
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:09=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> No need to setup SGEI local interrupt when there are zero guest
> external interrupts (i.e. zero HW IMSIC guest files).
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/aia.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 17ae4a7c0e94..8ffae0330c89 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -499,6 +499,10 @@ static int aia_hgei_init(void)
>                         hgctrl->free_bitmap =3D 0;
>         }
>
> +       /* Skip SGEI interrupt setup for zero guest external interrupts *=
/
> +       if (!kvm_riscv_aia_nr_hgei)
> +               goto skip_sgei_interrupt;
> +
>         /* Find INTC irq domain */
>         domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
>                                           DOMAIN_BUS_ANY);
> @@ -522,11 +526,16 @@ static int aia_hgei_init(void)
>                 return rc;
>         }
>
> +skip_sgei_interrupt:
>         return 0;
>  }
>
>  static void aia_hgei_exit(void)
>  {
> +       /* Do nothing for zero guest external interrupts */
> +       if (!kvm_riscv_aia_nr_hgei)
> +               return;
> +
>         /* Free per-CPU SGEI interrupt */
>         free_percpu_irq(hgei_parent_irq, &aia_hgei);
>  }
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish

