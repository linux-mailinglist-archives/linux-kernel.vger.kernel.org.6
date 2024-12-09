Return-Path: <linux-kernel+bounces-437973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F39E9B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D008166AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4099813A87C;
	Mon,  9 Dec 2024 16:01:35 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9C1369AA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760094; cv=none; b=sVP1RsQbhCKyVxLThXIZCPkret/9Eg6RvqyZJkocBOJK8R1C4VmFFLmH+r/CjWBshNX+26obs9kO++M+6rj409o1bCJsbKpn0UsPysVOw/subVa3kLXHvoKbM+H5Gf3oVv8zmV94javr/lQbihXrYxyUbq4OKKorb1tbKyNNNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760094; c=relaxed/simple;
	bh=YsmaQZZ7aHri0xZQmOreW0h9HuMwh4f8ohWOs2dBIjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1LVxeFd15K+C1n7aCtlLFNc8wGS7b2y9RYyzBgOXCA5Mx0YfEyGLTMwTRHTxwQ024EaXpE9h/CnEIZLd17XHN18euFqh7jFJrhCBn4ek6PUssmmTLw40QOdRc9437z6igs6UNIJ2cG3NRKcF9MVJsc8n5j3jqTf9QCOE+M7T2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb3daba248so846269b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760092; x=1734364892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k77S1jSFGUUPDxhYWlw8l8v/eJWaaEdCFshjetT2cAo=;
        b=U4XrOxJftA9SMAh6RajsFn+IIpLxKFoUXGb9YFv7J7yA4RU85hwfRsm0d4MbwhR1ZQ
         GYDWtAYjtmSr8U+lP5EBindn2pcgh6yqrPnHymxjyQhJZRV2gFwdCC6CDYySzc+GR/7u
         9rAWYa5XhmeDMB8irtepsjlh6INbIZ19llY3lMnT+dxWJLfLHV7D7PazRn6buGVuRAzy
         hWsJWAmplA0v2yIDqQkdF5eEuEMsYjzVdkS+xUcDKsXRimHScbhgjWMn8gWa4s4xKqYk
         YFDk9eTQhH+Nm7RDB+yi3sTHnY4BwgtTGOGqYYJjlrBOMeV5+s67wCZzM5woD9ROullt
         Naew==
X-Forwarded-Encrypted: i=1; AJvYcCUMz5R8qiRqKj8wWGTAdOjLLSj9QWFqNGm6qoYnVZSC+P20lnedkR/yh5mPuUAkyzsMLIG9xyRhaF1hW1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnUckHL2laH7NR0hhS4oQ2r4VnT6zZCY3V+82cgX86q7t/bs8
	OVJirDNDHmbg/NQVuZ5QckMFuDUeSFINnTJDwE1SWZN3MZEwNtf1X+o3TUM4JZA=
X-Gm-Gg: ASbGncuMwYhTrkohjsLCGI3AN8ctItsefb1/emNnwY1hpyupToyH7yaIUZGEKYcNrkp
	yUsbJ4JKyQ0WevFtdOEc9ZCt0Sjt8BzEqTQpULairPQjw0gBxvmo5AWldRbYiEKFhWK2LqWoR3e
	J8X/fJzh8z/xvNeJS4Z4y26SBZ6oZGOZOegX98/u+cACucLAbNn3VQSUSnsG4HFwKI1bSv9pwq5
	Gqtihy3vy6l1ogl0l8UkjOo94s9gaBbxWvrSetv3dJwOP6BXkmqtL0x+ByNbD9UZXQl+dSJOir4
	1tO8/SZXNsl6
X-Google-Smtp-Source: AGHT+IF9GkeTDniw1wo5AcGIz/gslDH8FiZwogWRd9ROVXdA91eKIgd5ya2CBeQhokeAPQLOp72qXQ==
X-Received: by 2002:a05:6808:191e:b0:3eb:66a1:9d8d with SMTP id 5614622812f47-3eb66a1a7c3mr722934b6e.11.1733760091732;
        Mon, 09 Dec 2024 08:01:31 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2be1f40dfsm395083eaf.8.2024.12.09.08.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:01:31 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71de7b11692so817363a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:01:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT9qCX+rG3jbMhPr22lWOAVrtTpYo8af1Pp+aLKD02p1YlLrS6Gx3Fx8LJd7DFTS/nnORijMHiYJam2gw=@vger.kernel.org
X-Received: by 2002:a05:6358:2812:b0:1cb:3864:9739 with SMTP id
 e5c5f4694b2df-1cb386499ecmr132991755d.25.1733760090977; Mon, 09 Dec 2024
 08:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204162128.25617-1-dpenkler@gmail.com>
In-Reply-To: <20241204162128.25617-1-dpenkler@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Dec 2024 17:01:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
Message-ID: <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, Dec 4, 2024 at 5:21=E2=80=AFPM Dave Penkler <dpenkler@gmail.com> wr=
ote:
> These drivers cast resource_type_t to void * causing the build to fail.
>
> With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned
> int which cannot be cast to a 32 bit pointer.
>
> Disable these drivers if X68_PAE is enabled
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@=
roeck-us.net/
> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation G=
PIB driver")
> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>

Thanks for your patch!

> --- a/drivers/staging/gpib/Kconfig
> +++ b/drivers/staging/gpib/Kconfig
> @@ -50,6 +50,7 @@ config GPIB_CEC_PCI
>         tristate "CEC PCI board"
>         depends on PCI
>         depends on HAS_IOPORT
> +       depends on !X86_PAE

!CONFIG_PHYS_ADDR_T_64BIT, to match the definition of phys_addr_t?

Or is this only showing up on x86?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

