Return-Path: <linux-kernel+bounces-169366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322578BC7AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD7D1F218E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C446439;
	Mon,  6 May 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFDgmlKU"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010C1DA3A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977321; cv=none; b=IWOy16SBVuEtbL0LIMlfrWDtmqXDcQuM/PzsWzgoeZhw/RyJmuaEKUUm6ZCBu/aPKxIqwYNYylUc5gNEZ4Y4KHniFZ+rPH+IgIe55R+UpiOTyUe1e+GOk1FEOkh+p7EjQVSuVonIVIeREjle9mIRES7MntVja2WIdBkYMFnNU9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977321; c=relaxed/simple;
	bh=F4bCGtNldfkHhz1v+X5T6XqO5NjhSnpFKTEaXpHr2Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otz/1dl3smXkLh06PTUIhOLbUO2avqOCmGy6kBQlEMstAFLSW51trhkBFy1MMUx2ft1IqSgQ8f0E3Qhd2YiUu/3muOLQtKaGNsEk3esN19LBtElmGsRQ3Q1+V4EWhNNklBJQEXtLS+aLhSdMJGwuZXMw0mNPHrFiYaHeVIZhgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vFDgmlKU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de45dba15feso1469005276.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714977318; x=1715582118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4bCGtNldfkHhz1v+X5T6XqO5NjhSnpFKTEaXpHr2Fk=;
        b=vFDgmlKUDw8B49EuS9swfJZehSXVlfgvo7SI5QXdVPD6I6J1MBtKXhtQYvNXe32mCy
         yko3IOviRQw8Q65yfBw29ZQ3elfTX8FVu1CQYaWW9k93StbOcs+IB1zrjsjwHXw8dBvI
         T7U7VF9z9yoFnuKC+6sMjX32w0Md9sLB20cz0vocGEy4pQxbxtidi3tcLj0kJO7I3nCr
         pD4E1AaQDRgzNt3pvmPGctjQbw9Cr/qu5JFhooZ15LMZJMyNZAn+KUNk0yb7bxI+693h
         d2Cgs3yT8rQ/KqSv088hTR/LDNIMBXPthphmgD5xbGPQ87IIn2Pn6Y+dFc4yAZp7vAH1
         fb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714977318; x=1715582118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4bCGtNldfkHhz1v+X5T6XqO5NjhSnpFKTEaXpHr2Fk=;
        b=Jccvf0/3louTYYeSEOuJSyTQ0NcOuRqL6V0FVtGEZ9XV0dIIcJ2mDBNKPi6F7zonj3
         wQ/1ZfvORA9leEJUn6zJj6dmQXLv44ohkp631H2yQiJ9AmeJba/2HGOv4Ap4qjF4uoHu
         9O+UNIxVIVKQpDWnhbaX+6xWQKWkwVG7gaquM7r8GbgahUFlsTNF1bC/J/BNIhZda1Bk
         I2jRiTuLhyQfT+FWiqynZl4Ib9qXfMIUnARk9IYo9Ezo9PkS6pcx8G9/reJ6QPWPswlX
         oP9QwFDruXsFJidK14XJhkkoHn57PAKbSyd3PDFLGpfDLfBBlfUOvhKdtEvt1EqO37Bu
         2rpg==
X-Forwarded-Encrypted: i=1; AJvYcCXdDsHXJlJo3+MvpueBHWSBpgPrQaxSrBExmgyISHi56q4+UY/pBHgr9P8Hk9hbdikKu0OuLdOdNWAtfjqL82MCmJmrhZ5eOERclyrs
X-Gm-Message-State: AOJu0YwqpxiP/UXipWHex0sRm58HiirrNWWWRchsuMKocy0OsNGEBT+c
	oZFf91VtRhllnQ9NYv+Osh9MH5VfSG7WXFV9r3YaMWwPyAB7TATrGc3j+3eQbumAlmKTTi8di7O
	W755rsRsT6OPpzWbqA+UmYFqUNlKCLPu9PllMWQ==
X-Google-Smtp-Source: AGHT+IHwFBLDH7pB4BuNuBdkU/p+O0HvtvUwPbTtHfpWZ5KWh1FNTe4KBMhrRQUWSn6w8OSGytaKBjVYjoN6DHr3YUc=
X-Received: by 2002:a5b:e92:0:b0:deb:7eb7:c9ce with SMTP id
 z18-20020a5b0e92000000b00deb7eb7c9cemr1681261ybr.1.1714977318711; Sun, 05 May
 2024 23:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
In-Reply-To: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:35:07 +0200
Message-ID: <CACRpkdbxzbNedWTpA5i-45AqPc4fA+GeBGkrjrD_OgkxMZRwXw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] Add Pinctrl driver for Starfive JH8100 SoC
To: Alex Soo <yuklin.soo@starfivetech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Jianlong Huang <jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 1:14=E2=80=AFPM Alex Soo <yuklin.soo@starfivetech.co=
m> wrote:

> Starfive JH8100 SoC consists of 4 pinctrl domains - sys_east,
> sys_west, sys_gmac, and aon. This patch series adds pinctrl
> drivers for these 4 pinctrl domains and this patch series is
> depending on the JH8100 base patch series in [1] and [2].
> The relevant dt-binding documentation for each pinctrl domain has
> been updated accordingly.
>
> [1] https://lore.kernel.org/lkml/20231201121410.95298-1-jeeheng.sia@starf=
ivetech.com/
> [2] https://lore.kernel.org/lkml/20231206115000.295825-1-jeeheng.sia@star=
fivetech.com/

v3 is starting to look very nice, why is this patch set still in "RFC"?

I would like some proper review from the StarFive maintainers
at this point so we can get it finished.

Yours,
Linus Walleij

