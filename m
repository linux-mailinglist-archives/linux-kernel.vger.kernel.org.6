Return-Path: <linux-kernel+bounces-395446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D99BBDF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5399C1F22990
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA61C4A0A;
	Mon,  4 Nov 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcnrM6M/"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C41E89C;
	Mon,  4 Nov 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748505; cv=none; b=FntqYk53hCn9FxJMrSJdNmm/SA9Fn+IS/SdvWqE3OAUEngdbdNHV8fh7WdlxQ7wPAbAKxz1PQ/j/XhgiAmNxhDsmlHXg2JqT1Z/cPRCcod93D4kn2gOmmJaDP6v+tcz1xYdVBCg8AJEwCjXFSYriouFM/gcYXmOhW98TxYSKNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748505; c=relaxed/simple;
	bh=kY8rhl1u8JXsgPMEsKOkYjiyyMTZiXz/kDPAj9DOkhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTFwbEMnbYYYSDs32SH/HKds5BilNSSiaFfzpaDR3aoercMrBW/UAtCqYX0uNEP4dyDZ5Wy8qOXOYHNnwv+bfULtgTC5EF0cjS633FM6GYSz+ILMAVmgGtymgfOIChs5fLIzWuRRDIafSwpY1uIri/p4eC55K0KqW5jb+3srqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcnrM6M/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc27fdc30so2430913eaf.2;
        Mon, 04 Nov 2024 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730748503; x=1731353303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzNSBwfqv5RMOk+iTL2p4n+4xz8bY6vzv1XRWCkFoUw=;
        b=fcnrM6M/B/A6T9174ZZhVFy+8bzgvhsF8ISwqMb1r6GML1HyFbfODVt0d3DdVb9sWK
         YA5Ljh7OtyRUsOCsHif7yHOO4znHcbIbgNQOMniMCRH/L5fLv59Rxiwhqd0MefjOrAH3
         2SBHb/A1xaP9NUmc+NQqPYessM7xEiQ4WIAQri9sokoDlXrOcg5SvXkpaWfkb72gcAj2
         1wygQJHQzYZ0iudpwaGIUaeVjEgOBu8/8KT5l48v9Qykyj21JJOgPMu1HRw+X/XOpbmV
         uNUyrvbUlEibDf+hNRtHT2wU0G2RbIhhsuUWMZWGB1r6Me4qI95hq/JCxJlxfu6FkUy9
         nffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730748503; x=1731353303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzNSBwfqv5RMOk+iTL2p4n+4xz8bY6vzv1XRWCkFoUw=;
        b=CYihLbP/n3Qx/JTs70FxeBtg3B7jZEs04ugL/qOId/bUFYWSupDVFcKT0rns/ahGtR
         FIhx/BhcnnhdPQRNQQC+J0KvigfPmI0yItEYDdjIFVUSruFbZ9toLMTDsXTBA+DEIhmE
         n8CVYO2t8Im621hybb1/BDhMQVCHJFSDSYtW9sjKU/Xp0m2Sd3n1ogAAkTTnSBAXLU2W
         MUeZGNBz6flhd9TarHlb74Wn6I2zoE+RjrXtG0Ab7K7zzs0ALevJRT/aQprCH3LfqiuZ
         J82S8mm3l68FTZplN+RKxo9l0zji4b5hax8Cdyxw8bC7TxZzccJ0Lib1Wnkxz6Voe8bn
         yl6g==
X-Forwarded-Encrypted: i=1; AJvYcCWsJ2d0uZWXCpye/afO/hwAS4IQVWaP0Snf1soi6op8XMnbk72fA2/PMbxda4+wjZ5DMMhy3/CBc+Vca6Ro@vger.kernel.org, AJvYcCXrpOGudEH9DACAVrKoNXzLqq48VZKpDXzyW8JD35ccGvuy7BNFB/eUoQLo77WTbAch7H5jVr49duqd@vger.kernel.org
X-Gm-Message-State: AOJu0YyTf5FDG8Yq+8JEjltrjzN7yAYnRDYMh+fa5ivonOmG6tLScSXH
	ZB5Ei+aBfHWyQqKlbbM6FsTJrYAYGroFcppm5vyZd/ZkOANiLuk4BjJ/4E7I9xk2o7OdVj6I7wU
	J557tA3SI8SwB7WQeOdxbFhZXZQ0=
X-Google-Smtp-Source: AGHT+IGIG32r9in+QfMAZeroaZPlTVZht5B6vJdC60syp76/vE/ZoshB2cvJMG3UXj+CkQFMi/mJ7Er8nRgBVNx+lZY=
X-Received: by 2002:a05:6820:1885:b0:5ee:bb2:bdd4 with SMTP id
 006d021491bc7-5ee0bb2c243mr4053231eaf.1.1730748502801; Mon, 04 Nov 2024
 11:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
 <20241025125110.1347757-4-valentina.fernandezalanis@microchip.com>
 <CABb+yY3cDD-E-P1MPKQjdX7R2XVVKjwXUW-BANWcz-9aR6kskA@mail.gmail.com> <ee8b10e3-ccd2-409e-82d0-612107f3fe26@microchip.com>
In-Reply-To: <ee8b10e3-ccd2-409e-82d0-612107f3fe26@microchip.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 4 Nov 2024 13:28:11 -0600
Message-ID: <CABb+yY1Oy-vdXSQBQHoqzsK8xpXXfHw5ZQ5Q6gjv0gdFK2hwDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mailbox: add Microchip IPC support
To: Valentina.FernandezAlanis@microchip.com
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	peterlin@andestech.com, Conor.Dooley@microchip.com, conor+dt@kernel.org, 
	ycliang@andestech.com, dminus@andestech.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, robh@kernel.org, krzk+dt@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:01=E2=80=AFPM <Valentina.FernandezAlanis@microchip=
.com> wrote:
>
> On 03/11/2024 00:23, Jassi Brar wrote:

> Regarding the EXPORT function, I understand that it=E2=80=99s also possib=
le to
> retrieve con_priv from mbox_chan in the client. However, I felt it would
> be cleaner to export the function to obtain the channel ID directly,
> rather than declaring the struct ipc_chan_info in a header file to make
> it accessible to the client.
>
> If necessary, I can remove the function and instead expose struct
> ipc_chan_info in linux/mailbox/mchp-ipc.h.
>
Yes please avoid EXPORT at any cost. They are only acceptable when no
other means exist.

> >
> >> +static struct platform_driver mchp_ipc_driver =3D {
> >> +       .driver =3D {
> >> +               .name =3D "microchip_ipc",
> >> +               .of_match_table =3D mchp_ipc_of_match,
> >> +       },
> >> +       .probe =3D mchp_ipc_probe,
> > The driver could be built as a module, so please provide .remove()
> > even if you never intend to unload it.
> In this particular case, there is nothing specific to implement in the
> .remove() function because all resources allocated in the .probe()
> function are managed using devm_*

OK.

