Return-Path: <linux-kernel+bounces-321197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD59715BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408C6284459
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DFF1B4C51;
	Mon,  9 Sep 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="AlcHAGvZ"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C11B3F18
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879351; cv=none; b=Ik5x/9zozt+IfA3UuQDtt61zihqH4hn9r6PfL64fYUY+H3+aragKgwzZaPTZB3Du2AzQB428651BueVa3b1ilhJ9yQylohVVB5HVtx5IDLIjdfJ3FV7kGatqVSk1nL3B21F+/n74+NDiBFZFn3a29xWreVX/SYDUmNxT0XByhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879351; c=relaxed/simple;
	bh=ttG0Dc2cxHV6jC9XbhBxyS8Gni7TD3M7WalD4kpSCiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5pe5b/VB84vRyAdLiRQLf5QW0Mbrys4a+ZG8u95FzPeQY28MkGv814t+tV8t+hDvopsfpQ55DKumLtG9xzoxiwYqiAv/ujxYKvOvRtDbgd2CSglHdXJQ0gKkmPjjp8Kpn0C4NocEQLYSP9y5TLxrm3GPl/zD1yMpZVahl16wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=AlcHAGvZ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a109bc459so176631639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1725879349; x=1726484149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRenQZpsyYsPRZFrE6Z8exC8VyrPgR2I0N0/8AA/xzs=;
        b=AlcHAGvZZm4jryZBfXcMXgWJhgJzAXPOB/X7gmRnj9Z67AC8hVFALGsA4LsWCohMVV
         CLZv9QCrGwLGvwBQN2bprffAUvI4jAKUVzoFDtnAADb2PEQt6U4YrILDvhb3PhtZhy2A
         bubSoEb5koWfNn9G1web8HBDn0UvBGtYIOdig/K8KS9ovr0ATpimXDowPd35ZT9U2Ob4
         zDsfOrL/XZjd/jgKf+IIWJMzBkfPlVpCZr1pH7FN/pXF1AjWBoFKTGx4kjDZ6tZI3kK2
         qMM1OwLRuy+OA5cI1983KpK9f2tJs/jHoBdAIpGrDBtTekFu/68yf3mdJDvCddgonUgt
         3iiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725879349; x=1726484149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRenQZpsyYsPRZFrE6Z8exC8VyrPgR2I0N0/8AA/xzs=;
        b=IfD6V755L6ZzCL6yxTSnhRzcpJrJZrviDMQtRYn1mugsG4RQLRDmU/Nk0LnivnkMQN
         k37CReTYMex/2xng+//kfpkOLBJj8VVMynY43KuEMuz7TJ4mVglEJTITMjZXEF7yd+bT
         xlH+dJXSwrcWCCaMn0Ei/OFxx6MhijUMtx2DqfPXPwAWYxZQo6AokolB7Q01gVPDxflf
         KP4Z6fZGiih9CNSPT51RBYnVuIo56VvQdUl3fOmOHPgK7DtBj5rWq1eNKCYyLC/OWzmv
         2rjSJ2b8ydr5mVMvEiBXHSqedyQM1uy3TfzsZmdhfmsCD6vO5rah5ZUxo9fV4vdbv3sw
         hn7w==
X-Forwarded-Encrypted: i=1; AJvYcCUet6mOimjVd4t7a7/TV5I3Dvq+PVSMiNhn+hWTDsPDCzqwJedoAV5f6ghxMPEBoG+Kn0pYYWd9oI4J8b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRcmCStGg/7uySsUhT1jyDEYinYBsnjAg1WQt4hISVIh4kNXe
	0MJX7v9rI+rceb/AtT2ieZ+ZuLlk8NU/FsM5LFZkAtBZDsRr+zLDZyT1wi0DGCjVjM8WCziPXz2
	TYyG5rZfl2yYWF3JTT6tog/IKfQSHp+jbihLdsA==
X-Google-Smtp-Source: AGHT+IEUDJyXv2vNFFv9EShn4mJ8cnVFxPmnwZrvxExgRhOCxti541uhxlyRmn9HiGjbpDSnGCkrSVIPWa00MTMLvv0=
X-Received: by 2002:a05:6e02:b49:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-3a04ede83d8mr89419445ab.12.1725879348819; Mon, 09 Sep 2024
 03:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909085610.46625-2-ajones@ventanamicro.com>
In-Reply-To: <20240909085610.46625-2-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 9 Sep 2024 16:25:36 +0530
Message-ID: <CAAhSdy2dS=97YVLBvKsA-GjPKXZTpoGUhahj0_ocTpuB=UBNKQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-imsic: Fix output text of base address
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:26=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> The "per-CPU IDs ... at base ..." info log is outputting a physical
> address, not a PPN.
>
> Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support =
for platform devices")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> index 11723a763c10..c5ec66e0bfd3 100644
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -340,7 +340,7 @@ int imsic_irqdomain_init(void)
>                 imsic->fwnode, global->hart_index_bits, global->guest_ind=
ex_bits);
>         pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n",
>                 imsic->fwnode, global->group_index_bits, global->group_in=
dex_shift);
> -       pr_info("%pfwP: per-CPU IDs %d at base PPN %pa\n",
> +       pr_info("%pfwP: per-CPU IDs %d at base address %pa\n",
>                 imsic->fwnode, global->nr_ids, &global->base_addr);
>         pr_info("%pfwP: total %d interrupts available\n",
>                 imsic->fwnode, num_possible_cpus() * (global->nr_ids - 1)=
);
> --
> 2.46.0
>

