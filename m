Return-Path: <linux-kernel+bounces-238377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32097924995
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E689E28296F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85DD20124F;
	Tue,  2 Jul 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH4Zj0MO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A11E531;
	Tue,  2 Jul 2024 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953320; cv=none; b=VQBhTTxLQw44mIBfPclzvqf4ThQQ9AtFS7S59n9TER+AO5CqUSw0URfjzP8DWAuMFKhGaPO3lX/JT8P3gGfDThM+ozisvuQeNV9hZuURMheodLbthPlTvTWUiw8EzRseo9tdsF/5uc8NfgmP++CXB/uLlr3jNvvpGaEFGV00k+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953320; c=relaxed/simple;
	bh=XSP7UcJ2D5LrCSQQ6xjlc13J4cCPY/UwXaVdyrjho+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGC/f3O7Si37kaTGcgahpwKrxip19D1EtErIrb/g2fk4ktdusbccQ7liPyrv8pOEavwrgcs06f2D5AMU8ToZ+CcccHMFn0k8IF9iZFkkhgZ7tE4oHkuqMR2bW4q5zOp18zrrJoc00Vb2PptDPGI7FAGjbLezDF5kJNjckQBEhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH4Zj0MO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7A8C4AF0E;
	Tue,  2 Jul 2024 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719953319;
	bh=XSP7UcJ2D5LrCSQQ6xjlc13J4cCPY/UwXaVdyrjho+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SH4Zj0MO6dwU6JylDy31rRaLEqDce+H018fT6jImpUKeGTaYI+cAwrvCpQv7jNukU
	 DIOiRTwdKru2xYPSjKYdKhHB7rZKt8vUXY6G1c70s+QEGIxlmK6DCU6FjIOIvog/SB
	 wOzNDcjfAJljOYDKUjavpmfTfoYpt9tGbfl7Pjlvtu2z5ZM+MCNJ//4eDHBfQHgtRO
	 pG4GKxCd/fjeC1PKAJQ33c9YugXGP4u3RsLbZ1cqgl0nErK9C0O7HdcLVccJUcsmco
	 MWD1NUjYBVWF+oy6M4surPdcGYtyuBITfy5h/+oya/8VaZqYEUg6xs9mr7KPZrk33u
	 Bc42wZOp/CcMQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e96d4986bso791e87.3;
        Tue, 02 Jul 2024 13:48:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEOS0E9gh0KbnJgkWUzUHkjbGoOjCGPpkCm3Xle1NVEgp34Xqmph9Xv+ognxVEy9eVbaMa9a5wfpUfcTl4YHDmX6//Hr8FYMll+8qYfidJahi3EgcjDmBlu2GSLmcM1VOQGx1CJieU0w==
X-Gm-Message-State: AOJu0YwORVhQ05WwRHVmA8Y6oErUJi+kC/z8dayPEmePjm77NaTaDQHh
	DBI3JTWX8LdIr7kr0VtyzTTaUiM+VTr/Qvm8jM6YXOuFTw/71C1x31/bCHDTYuz7+DpycTxgd3P
	r0oBuhVspuseSOefegJfyGxbFzA==
X-Google-Smtp-Source: AGHT+IF5h+XH9Vo4eaNorGEHLOkNM/85fqjWjFjU4KS8+4jdTSMWo0Xm7m4AuM80pi3ahYssXlzXXvKAi8m1a2Z04X8=
X-Received: by 2002:a05:6512:158b:b0:52c:df8c:72cc with SMTP id
 2adb3069b0e04-52e82703ecbmr6879482e87.43.1719953317947; Tue, 02 Jul 2024
 13:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de> <86zfqzhgys.wl-maz@kernel.org>
In-Reply-To: <86zfqzhgys.wl-maz@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Jul 2024 14:48:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_QZHMJGHqw8vFA5CspuouvY_U=+NobYQ52DcwPQx-2w@mail.gmail.com>
Message-ID: <CAL_Jsq+_QZHMJGHqw8vFA5CspuouvY_U=+NobYQ52DcwPQx-2w@mail.gmail.com>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
To: Marc Zyngier <maz@kernel.org>, Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: apatel@ventanamicro.com, DTML <devicetree@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, 
	Matthew Leaman <matthew@a-eon.biz>, Darren Stevens <darren@stevens-zone.net>, 
	Christian Zigotzky <info@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:54=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sun, 30 Jun 2024 11:21:55 +0100,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >
> > Hello,
> >
> > There is an issue with the identification of ATA drives with our
> > P.A. Semi Nemo boards [1] after the
> > commit "of/irq: Factor out parsing of interrupt-map parent
> > phandle+args from of_irq_parse_raw()" [2].
>
> [snip]
>
> My earlier request for valuable debug information still stands. But
> while you're at it, can you please give the following hack a go?
>
>         M.
>
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -282,8 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_p=
handle_args *out_irq)
>
>                         oldimap =3D imap;
>                         imap =3D of_irq_parse_imap_parent(oldimap, imaple=
n, out_irq);
> -                       if (!imap)
> -                               goto fail;
> +                       if (!imap) {
> +                               match =3D 0;
> +                               break;
> +                       }

AFAICT reading the DT, I don't think this would fix it. imap should
only be null if malformed. This case to me looks like interrupt-map
has the correct cell sizes, but just never matches to do the mapping.
So maybe imaplen is off and that causes us to end up here, but if
there's an error I don't see it. A boot with DEBUG enabled in
drivers/of/irq.c would help.

>
>                         match &=3D of_device_is_available(out_irq->np);
>                         if (match)
>
> This may not be the final workaround even if it solves your boot
> problem, but will at least give us a hint at what is going wrong.
>
> I have the fuzzy feeling that we may be able to lob this broken system
> as part of the of_irq_imap_abusers[] array, which would solve things
> pretty "neatly".

I think this would work and would consolidate the work-arounds. It
would need either "pasemi,rootbus" or "pa-pxp" added to the list.

Rob

