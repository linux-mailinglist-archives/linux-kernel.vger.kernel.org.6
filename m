Return-Path: <linux-kernel+bounces-437031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604909E8E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DF81886582
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546BC215F5C;
	Mon,  9 Dec 2024 08:56:05 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990C215F5A;
	Mon,  9 Dec 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734565; cv=none; b=Fh1/ZUd/4W+T+7F2Z7x70aQpMJbIoBlUUECEfe8WbTi1QGMkBa1Rk8C4+vl46h5c2JcXrUxq/RltzUz4Lxk4QkZ8gQ7aSZbnfitZi1Q8aDGavFgQmQkdIJfWkZYpYQ22H6dfDG+Tdhtsb6+JISj2sSUNuAQ3f98WHG2HDfkxcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734565; c=relaxed/simple;
	bh=NFk5AHP1WzcwCnF1yLNTssPwFD+Hxat6kdDIFCsmMUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4wfxbcH/b8t66oi5gfDXErQ0O1M7IcNNxFqftq4JYy9MMHFOCdr/aMnrTTwOMaT8Fu9VZQRbtUj7guRm3X6wdCOZgRJ5cPsRApeOGg6ghhrN/P31B7524WJgKN3QDWbAYUEk0zr045DiKQDrjYLVTz/INwIJYPxHorHpqlxfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85b0a934a17so2686334241.1;
        Mon, 09 Dec 2024 00:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734561; x=1734339361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzbi+zwrT7LVfp++4Pd6gcn4qoo/SBJnwYE7iRP5rR8=;
        b=aiFtTj4RIYzmcN7kQUwaxQx0GGoHS6oBg9e/YDT1fnziUmviXEHOCFCEOilqXv4XAp
         ZdPtRLcu9BsHKHVzu9MuWUy2M6BLLIOpyLhg/66xXNwuBCXoRdpOykYjKWGcYBtp68up
         nAL6o+Utr1afrhg8hJ7V1uMh/UuyOuuwfI0jij15YknN5ub09FmKjO2Ek+3qJ0P/mNQ8
         qnjUX807NEEzMyYefU1AXr7riNon3g9bxeE02HbUaD3hHNZd5wxGTukwNkP19JdcGm5N
         cgdUyCu6zqwV3WqF8QvYp5XkMj8krWGIHOdfWfpjQIVjKOxXmeg3k7i49dHXb7VBUaWH
         913A==
X-Forwarded-Encrypted: i=1; AJvYcCUFKAy3RRcX7c5AQQIHgxFrI6i25n49LQBPJRMJnOXTZ5N83mIDXpZEHC5XBQiSiTr/qGJrdNM0DRw8USnh@vger.kernel.org, AJvYcCUmgK7B+JBVs1fydOrd5p/LeHO+ZpiECmGTslJmsFkQIVpj2lbLp3NwnOvkR6aNo14eEahJgP5z9I8a343C5NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZ2G9BMaiEzluR5yYMvddazm9ttd5gXZ22mde8rA+d164HG1p
	pTAh42dR4EyS8yvcdJuAYS8dgjTHVDMpZDCnMkM6j0ar9VVb+vYnwnHxvGQeVbo=
X-Gm-Gg: ASbGncsS7txEhLEKuFDVBYok0S6X9pEFStdnGaxmJOJLjbPiMmbubnSh2VsyVjAON66
	eyzX+WSlmzaUcOjZIYtMDbPiwY6TLhQXXer3tRHwr8drGvPQayfUrsfPpVa1WcnrzWkNTsmbO6M
	3sOUZbm/U/D9+5ZCDtpjuhgh2yLHWjXc3ZqpCm0f1inhJao+2j86+bPjj/UpH7T0FLRGtWD3yAg
	RSJ2UeWdr0Z0NqZIHnSUtUiemDYF2jcUBUJt8vCqhnT+YxuUcHO53og+O3dYDNx9qifTxTwy2VN
	/9Te473yH8LU
X-Google-Smtp-Source: AGHT+IHXxzNiIy7BRb20W61inpirpSwfAcjUeZRNU6HCcVmpqsggHgzPTAiwbVFExv7Bj963KqTlgA==
X-Received: by 2002:a05:6102:c0a:b0:4af:ef82:ce8d with SMTP id ada2fe7eead31-4afef82de4fmr2559213137.0.1733734561384;
        Mon, 09 Dec 2024 00:56:01 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4afde356522sm683913137.16.2024.12.09.00.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:56:00 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4aff04f17c7so607711137.0;
        Mon, 09 Dec 2024 00:56:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBRN7vpiyE5z0Hu0V1NBK106QlY6gHgiahZ4RpG2tty5ahzZkVNoWcINAkhQ713tbXIkRDU3YFUN47SlgkBL8=@vger.kernel.org, AJvYcCVykIsRgJ87NZzZ2S0SC4u+Jhy4OJzRq27o7lTJScFKoxox8kocWXxwJ0tL346Q/MT5Q+zIOcCyxWtHtqUI@vger.kernel.org
X-Received: by 2002:a05:6102:3311:b0:4af:dcf3:b384 with SMTP id
 ada2fe7eead31-4afdcf3b504mr7969626137.11.1733734560816; Mon, 09 Dec 2024
 00:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
 <f205c8ab886a4e12b2ceda6f89c873a9d921625d.1733523925.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f205c8ab886a4e12b2ceda6f89c873a9d921625d.1733523925.git.christophe.jaillet@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Dec 2024 09:55:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaJyW3bvTxRfcDavA9HaukUDGBaTWRoUtrwjy_rb2DpA@mail.gmail.com>
Message-ID: <CAMuHMdVaJyW3bvTxRfcDavA9HaukUDGBaTWRoUtrwjy_rb2DpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay: img-ascii-lcd: Constify struct img_ascii_lcd_config
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Paul Burton <paulburton@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:26=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> 'struct img_ascii_lcd_config' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>    6110     728       0    6838    1ab6 drivers/auxdisplay/img-ascii-lcd.=
o
>
> After:
> =3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>    6198     632       0    6830    1aae drivers/auxdisplay/img-ascii-lcd.=
o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

