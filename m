Return-Path: <linux-kernel+bounces-426851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C519DF96C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA661620C4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701602C190;
	Mon,  2 Dec 2024 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3rEm5Uz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D361CAA4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109204; cv=none; b=E4U80orNXLKtf8hI/pJnRfQYmNnThj42mlCPpAtYBXwkzuizeoOh7oHi/UlDi2hekzx+1sOjSw9ptwbHh839/EAx+4WvXxqFwOycyXfPSRzU7pYkYJ0+zVcmDpAFIM5I7E7fMUzLXcpTCIhXQ0O/nHb4qQggIGOTZkaOKuXVRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109204; c=relaxed/simple;
	bh=vvOvkkmvQxCXN/Yw0/g0LpmxEILEkMdlYWM/tbBpvoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVdnRN4em1GnRnnfeQt9nQ5xadkQXT9alu6PgjR/PwYNS34J/miK8wzJqE6ruP2GOtF7TNQILac0Bg4dcfn8BG5twEwPhzFg4WFsOwbE+6B4GlummO7eK82BrDfOmTOVMvcxh8nO9iNFAshfwPyscnI20Em1h2jBF+tLfZvltHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3rEm5Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82FEC4CEDC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733109204;
	bh=vvOvkkmvQxCXN/Yw0/g0LpmxEILEkMdlYWM/tbBpvoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3rEm5UzXo75Lg1yT3h8F6599xSfQniF25YtLge3dCB6pD6kqEm/bSWDKAusuvpMf
	 qcwGL05+ZwBvlXHJ6274/Ook1tH7os/JyOT7cdfthpAAvr0eiigxUG2yb3Hdqk6ZBf
	 a87TuWz5eotZ5x1eB9lgL/jdIL53ZG3CSq2T99vLaQR1EKcJy/kU2z3HzegKZ4yZKu
	 Rh89HYKgnKxkbeeTLylDb5OECN+BfMOyaegEO1Lr7IUfFox3NWL43jYcTgQZlAs7qM
	 MQChEQ9JGMnkdZ+4WeEBz44E/AbjwDtvX9Z43grNtj72FaiH1vojhqFfn94zEx9yvG
	 Drx6Wtvje7vWg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso561998766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:13:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcb2N6fVcE8iCAN0kMJyRM+UHZ0kwBhChV5SEVBmAY0+iczLmcrEaN5itXSgHMNe/QFngBDVYPY/hrFiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGQUDsoObxXEA4LbeKHzOITCEDimGqGOw4aGwxFiL513Knc3J
	0rdlT7RhLpdJ04xMQgvMonYlHwKfVeXKITaRmmnZFUpRnFQ8bM3Y68lFByk0O+WJATW8XtoYiNg
	SHUvt8hKZ0cAX8qiYESxS4nWVTHg=
X-Google-Smtp-Source: AGHT+IFZxZsnSNv8yx3WcuO8sUGy0MIknomAbCoWEFjYbCCWVlRkR3FhSurrsZS7Q7tp548+dvNbZ6XVTzKeIcOzvUE=
X-Received: by 2002:a17:906:3d29:b0:aa5:152c:1995 with SMTP id
 a640c23a62f3a-aa581028f89mr1545398066b.45.1733109203201; Sun, 01 Dec 2024
 19:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108162039.9818-1-00107082@163.com>
In-Reply-To: <20241108162039.9818-1-00107082@163.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 2 Dec 2024 11:13:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H41aOaekpbfMTas0K1afCyg+XEKayMvS2L8xma87uB6DQ@mail.gmail.com>
Message-ID: <CAAhV-H41aOaekpbfMTas0K1afCyg+XEKayMvS2L8xma87uB6DQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] loongarch/irq: use seq_put_decimal_ull_width() for
 decimal values
To: David Wang <00107082@163.com>
Cc: kernel@xen0n.name, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sat, Nov 9, 2024 at 12:20=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
> Performance improvement for reading /proc/interrupts on arch loongarch
>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  arch/loongarch/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 9afc2d8b3414..86664adfb3cf 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -82,7 +82,7 @@ void show_ipi_list(struct seq_file *p, int prec)
>         for (i =3D 0; i < NR_IPI; i++) {
>                 seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >=3D 4=
 ? " " : "");
>                 for_each_online_cpu(cpu)
> -                       seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi=
_irqs[i]);
> +                       seq_put_decimal_ull_width(p, " ", per_cpu(irq_sta=
t, cpu).ipi_irqs[i], 10);
>                 seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]=
);
>         }
>  }
> --
> 2.39.2
>

