Return-Path: <linux-kernel+bounces-393622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F19BA33B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B457F1C20F66
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4503EB673;
	Sun,  3 Nov 2024 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYh9FfDN"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419C4C91;
	Sun,  3 Nov 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730593395; cv=none; b=XQ+vOzYea3sws9dZ87mWmLHKLL92eJ+BG+ZpFmSzzRh6k88jOZNRmudrjrBWZTxZLDSMFyE7uv27mJr5aexprS4TLTjzL3zj02e7Zi+2hdUgkiAxDKVbrQdbir2lKB+/qgFLbMFlR/7LxFB/9sWfv74l1EE3x59qFXY0Clx6VPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730593395; c=relaxed/simple;
	bh=JOZss1uzrgy96RicxBsQfsth0zz7FF1zuMrJ1I5c9sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7+tbTdOWivWxz+K3xPd6EAU0mbjENpLyVzDw3W8yYNKN1qBobcgDzZ7pP08NP+J79eFnSgoGKtVbQsS84NYMoRv93r4ipwcuabkF94D36cSmfBZ2BgIBSiFAp88APInE5iTEKEtNef3cVoUobzsvpeTYUswcofXnntr4zhCk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYh9FfDN; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fa17a79dso1826806b6e.1;
        Sat, 02 Nov 2024 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730593393; x=1731198193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy+oQJ2GEMRpNjhFn1LJw929fydtHkD4JsoP5UMnHEE=;
        b=NYh9FfDNg/XNlWQBSlioikSk8CE4WHifeuJ0YP5nlCjJAAa/kj1ssJ48drZL/nwdH0
         zZrd8OD1tQ+yzDy+D1byViUFNiTet4YYJSJ65tyjILW3lyjMiew5SDSk7vtVJkt+DLG2
         GXq8zsZelrkHQiU6C5J3WXhdYP02ADEtHqZT5sG7+6qbZRwsaBxCp6rg0ZEAMaMc/dhg
         JuA6i0fym5mwXbkzdKA7iUsfRiAfHwdl1TLOhnJtNi+99+vn86jfFP2KL4pV9F06lflU
         kMGvgjnPMBvvOmA/q3jml5e2NNzlS+zroKzqEby+IxDnqY0kewXSVe+ytYDJt0C5pSIu
         0kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730593393; x=1731198193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cy+oQJ2GEMRpNjhFn1LJw929fydtHkD4JsoP5UMnHEE=;
        b=kBZBlgHw0qZVGBTNC5IqLKvIxibvHahK7xvSIvhFXDfIFuLxiLGjrbfs3w/NKmXR9C
         gfSTqTVm7z47lJjTsLjoiT21O8pGX0aRtbKEd7SJuEQAMu867tEe4dEqZavr6t4VKlxy
         mT77agSfjNVk7zOnQXdsngoN4VbpvPoLcgqq8Zaa7rpDEpjQC8rlO84GktWeAn7Nuazy
         HwkMbqIfjmba37ebrClfljTvINQbiRHsXHkaIOOq8VQvyXkXG20k9K6N4lddCZh54vaU
         9mxDZvUByHjO32HIY/sIUfVLUqTHaLRB5aSLm7QMc49w06cVZQJQ6xO1AcqcPW8zRzHx
         Wa+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWN5RfvyF00S/TkN18IqQoN2ghtb/TiIMj1L+UTiOacx6I5bUysTSUqnChm1Ue5J8GxgMiTnZvByVn@vger.kernel.org, AJvYcCUoLM58Q9UsGEE3OUxwEXRn7sTEJWq5N4iUlr8BWFDVABXDyFLN1bTVNrlqFXcZMXdI9HBEj5zXe7P+mrNj@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpWajjP4GrFd1aTOQeFWaZ12XCjVDblgwT6ZgJBKepJQUMLkw
	B9Kah/NejZ4T1JsVO/0Qwb9IOyWYJ5JYfdhKIooCoTxB675vQlBNo3Ixe4HAPS0d9HjN53FZihu
	GuR6edFWdgyt5Jl9s6Rk5SLEEWok=
X-Google-Smtp-Source: AGHT+IH1/AqKguweEOJ8EZHcTlXSXIH8nwkWs4syLgX8RZ0uDmap1bE6uGoyjAxjUn7dGn0O2qZi1jtZGw0jSkQ9ph0=
X-Received: by 2002:a05:6808:2f0e:b0:3e2:9e62:37d5 with SMTP id
 5614622812f47-3e65834f25dmr15244041b6e.5.1730593393243; Sat, 02 Nov 2024
 17:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com> <20241025125110.1347757-4-valentina.fernandezalanis@microchip.com>
In-Reply-To: <20241025125110.1347757-4-valentina.fernandezalanis@microchip.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 2 Nov 2024 19:23:01 -0500
Message-ID: <CABb+yY3cDD-E-P1MPKQjdX7R2XVVKjwXUW-BANWcz-9aR6kskA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mailbox: add Microchip IPC support
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	peterlin@andestech.com, conor.dooley@microchip.com, conor+dt@kernel.org, 
	ycliang@andestech.com, dminus@andestech.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, robh@kernel.org, krzk+dt@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 7:36=E2=80=AFAM Valentina Fernandez
<valentina.fernandezalanis@microchip.com> wrote:

....
> +
> +enum ipc_irq_type {
> +       IPC_OPS_NOT_SUPPORTED   =3D 1,
> +       IPC_MP_IRQ              =3D 2,
> +       IPC_MC_IRQ              =3D 4,
> +};
totally unused.

> +
> +/**
> + * struct mchp_ipc_probe - IPC probe message format
> + *
> + * @hw_type:           IPC implementation available in the hardware
> + * @num_channels:      number of IPC channels available in the hardware
> + *
> + * Used to retrieve information on the IPC implementation
> + * using the SBI_EXT_IPC_PROBE SBI function id.
> + */
> +struct mchp_ipc_probe {
 same as the driver.probe(), so maybe call this microchip_mbox_info

......

> +struct mchp_ipc_cluster_cfg {
> +       void *buf_base;
> +       unsigned long buf_base_addr;
> +       int irq;
> +};
> +
> +struct ipc_chan_info {
 I suggest s/ipc_chan_info/microchip_sbi_chan and hooking it to
mbox_chan.con_priv

....

> +       unsigned long buf_base_tx_addr;
> +       unsigned long buf_base_rx_addr;
> +       unsigned long msg_buf_tx_addr;
> +       unsigned long msg_buf_rx_addr;
If these are __pa(), then phys_addr_t please.

> +       int chan_aggregated_irq;
> +       int mp_irq;
> +       int mc_irq;
> +       u32 id;
> +       u32 max_msg_size;
> +};
> +
> +struct microchip_ipc {
 Maybe s/microchip_ipc/microchip_sbi_mbox ?


> +       struct device *dev;
> +       struct mbox_chan *chans;
> +       struct mchp_ipc_cluster_cfg *cluster_cfg;
> +       struct ipc_chan_info *priv;
  replace this with 'struct mbox_chan *chan' and hook
     chan[i].con_priv =3D priv[i]
  this will help avoid having to EXPORT mchp_ipc_get_chan_id


> +       void *buf_base;
> +       unsigned long buf_base_addr;
phys_addr_t buf_base_addr ?

> +       struct mbox_controller controller;
> +       u8 num_channels;
this could be dropped by directly using 'controller.num_chans'

......

> +static int mchp_ipc_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct ipc_chan_info *chan_info =3D (struct ipc_chan_info *)chan-=
>con_priv;
> +       const struct mchp_ipc_msg *msg =3D data;
> +       struct mchp_ipc_sbi_msg sbi_payload;
> +
> +       memcpy(chan_info->msg_buf_tx, msg->buf, msg->size);
> +       sbi_payload.buf_addr =3D chan_info->msg_buf_tx_addr;
> +       sbi_payload.size =3D msg->size;
> +       memcpy(chan_info->buf_base_tx, &sbi_payload, sizeof(sbi_payload))=
;
How does this work? sizeof(sbi_payload) is more than
sizeof(*chan_info->buf_base_tx)
I think buf_base_tx needs to be u8 array of max{sizeof(struct
mchp_ipc_init), sizeof(struct mchp_ipc_sbi_msg)}, if there are
alignment requirements then maybe kmalloc that size.
Similarly for buf_base_rx.

...

> +static struct platform_driver mchp_ipc_driver =3D {
> +       .driver =3D {
> +               .name =3D "microchip_ipc",
> +               .of_match_table =3D mchp_ipc_of_match,
> +       },
> +       .probe =3D mchp_ipc_probe,
The driver could be built as a module, so please provide .remove()
even if you never intend to unload it.

cheers.

