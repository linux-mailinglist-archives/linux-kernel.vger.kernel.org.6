Return-Path: <linux-kernel+bounces-249926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9E92F1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2E2866B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F641A00F7;
	Thu, 11 Jul 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4VMFwRi"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856342AB5;
	Thu, 11 Jul 2024 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735785; cv=none; b=ZcO9vaQ2bMIoYrsqOPqitvRPzxs4rt2lBLQzFqavwFDpgZQECgTND6c770PjCJAFI+k+XpO9JwHMf5Tq/7f/yd8oThIJGufzVprKG4y65bRatlwKfDO7Zw0Hy0MHmI+GK9vEpeRfVc+IaRU7UWotlSma6uuzfQfz4DXCEmA69aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735785; c=relaxed/simple;
	bh=W5Inl5jmmqDgsqYU4cWad24rVvPOEXg8O1plVzdBZQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxM22uioTxKroDC2ddvYAKaB2+TsUEFce89+9Uw+yrVyL725p+mZwy6EK3gfgW6KXpaF8gYAOiWqsdtOh1HsZcYv1gRi6cclEj9b9xwYweqvavaBVmGLTvk+n2E2BTx0aXNbG0Gca7Uh/F38CFPgg+KhZxfeWT7hJQjwCYBBpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4VMFwRi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so15371871fa.0;
        Thu, 11 Jul 2024 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720735782; x=1721340582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBJ0y3g1ruClksG7c8rC7Ii3NaLmFEryT+9N6mGNKtI=;
        b=A4VMFwRiTAn/EQqf1xq6IGi13bIMQoFsKWkEWhXC/hhxq5H4BrtiFEVklm3Irb15W1
         QPLFrf8q+I1suDF1RyQmVyrJybD6idOmsWodvdHIm2V+M1gfbW4kxwDaOyg+nJexc0M3
         FGF/uzXRffSxYRX4RI3vv2+RZc/WHRg2oYU1Q3h1XxSBPZjUG6CtCwxZuLU1ILO9jUhV
         5SZNYbpWknqt6YmkVVwTqWY3A0uzne8SkEFkgd2iTvJwojdmXd5KVoemeWevT6k+OQZa
         xCe4qL/iwg30cMEtTUK7mu/vOVxcsU657XdSPrViA2pqFtvWpP1CmfbS6iXURDzl8c4x
         Ec1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735782; x=1721340582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBJ0y3g1ruClksG7c8rC7Ii3NaLmFEryT+9N6mGNKtI=;
        b=T0Odcis8Gy0/mj2VDxJOn0bNxcCD+sQ9cHqSWTOc3DWNLYthvx9+Ctmox+ks+tLRey
         n0hLw1v/V28AjHIpvaLhYyEIzv3lBGQj9SFOkqOCqFZJEBwMCPON2udwkxaVCdpKwTGo
         SsL9KgkdzLMFNEjf5LyL7s0olejgd6AiYLs+e8aUvt0mkfNsnZ0/BGimN6hlbplVpdR5
         cO+/V8x/WFGBFecsEo0h7KtkrpZYdRI4lJ4B6piWdqPhJw8FU/fLSaIozv4VtUZ/h5Nl
         D0BCsRTxYK1sX5LKWGu/QqJezri4tcvyr2KTOAzdiHl3tVJoIdGP59t1gnMfHH4FMTjq
         KkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0EtbLHFO9LNX00rqakIxrKnSpb84xyQ1f/ffoAjMsn8A2do52bjSYW50ffrY2fxpMvbUdo+TjvdZlaNL51q6+4evnPYT2ximIX/WJWyUm4JjUbTmGaO6gG3iGIxqP5SqkUNf72D0lAA==
X-Gm-Message-State: AOJu0YwjxRsgxMQUWtwSVNfuSgre5HNpg/K4/gY3MxiOKT11uvhkDInq
	Yex9PcPR+qsgoFEG/zo9a5r7Q2Obue10fuTNndTZH4smaEDwi3JfBb6+TN6jB0FwCzEZtTkq2dV
	snQ29xzMS6U5DaDvJYyvGnSKnAg==
X-Google-Smtp-Source: AGHT+IH9Ai9bYIEYD8w0b32hmLEFwAiKQ3UxPHulvoySXmj8ntnjYdf509mA6eeQGNEfme8k5ZSedfSwv9yzk9A1wPE=
X-Received: by 2002:a2e:8297:0:b0:2ec:5b17:29a2 with SMTP id
 38308e7fff4ca-2eeb318aaf4mr57430711fa.32.1720735781263; Thu, 11 Jul 2024
 15:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org> <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org> <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
 <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org> <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
 <875xtd48ps.fsf@geanix.com> <CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>
 <D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org>
In-Reply-To: <D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Fri, 12 Jul 2024 00:09:01 +0200
Message-ID: <CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Michael Walle <mwalle@kernel.org>
Cc: Esben Haabendal <esben@geanix.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Jaime Liao <jaimeliao@mxic.com.tw>, leoyu@mxic.com.tw, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, Julien Su <juliensu@mxic.com.tw>, 
	Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 21:57, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi Erez,
>
> No top posting please, see also
> https://subspace.kernel.org/etiquette.html

It was a single question. Which I think can be answered in one reply.
In cases where there are different parts in the mail, it makes sense
to avoid top posting.
I do not believe we need to be pedantic.
The guidance is not holy, it is aimed to make communication more comprehensive.

>
> On Thu Jul 11, 2024 at 8:57 PM CEST, Erez wrote:
> > Yes, I think we should.
> >
> > Reading the specification provided publicly by Macronix.
> > For all the JEDEC IDs with the no SFDP flag in drivers/mtd/spi-nor/macronix.c
> > All of them have a new version or a new chip with the same JEDEC ID
> > that supports SFDP.
> > There are 2 chips that Macronix does not provide spec. in public.
> > I can ask Macronix technical support on these 2 chips.
>
> We don't add flashes we cannot test.

I did not suggest adding anything new.
I refer to the list of chips we already have in drivers/mtd/spi-nor/macronix.c
I presume someone tested them before adding them to the list in the past.
And probably the old chip did not have the SFDP table back then.

What I checked with the chip specifications is that all Macronix chips
since 2010 have SFDP.

The situation today is that all Macronix chips that are NOT in the
Macronix table work based on the SFDP table.
But new chips that use a JEDEC found in the Macronix table, skip the
SFDP table and
 use the setting of the old chip.

So I suggest we read the SFDP table for all Macronix chips.
Old Macronix chips that do not have SFDP will use the setting from the
Macronix table. i.e backward compatible.
While new chips which do have an SFDP table will work with the new
setting we find in the table.

Of course, we might have issues in parsing the SFDP table itself.
So we fix them as developers report and send chip ID and part number
with the SFDP table content.
I do not see the point of "hiding" with the old setting.
Anyhow, as we do not like the IDs table and keep it for backward-compatible,
  so it only makes sense we should use the SFDP table as much as possible.

My check was to ensure Tudor that all Macronix chips have SFDP whether
they are in the IDs table or not
 and we are not wasting a no-op on a chip which can not have an SFDP table.

All I suggest is we add the new 'SPI_NOR_TRY_SFDP' flag, to all Macronix chips..
Which will try to read the SFDP to any Macronix chip.

Erez

>
> -michael

