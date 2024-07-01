Return-Path: <linux-kernel+bounces-236102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41D91DD68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2541C1F2212E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3A13AD04;
	Mon,  1 Jul 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwGzwM+5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36652F29;
	Mon,  1 Jul 2024 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831822; cv=none; b=F7G7WzmlBWbPgdTr5lmFWa9s4XYnLGHKbKQTBrPfC+H0tOG/WiaA8Djo7S7uGykCS3NSwM7dtHaKlYSq5PzhfMikxMxTg03dRXb4+pjjtpFHOp5K8KY7ttino8y2hUigGYXISwAYqTUcbpgmKZnUMjds1W+EnOPk2gfKzeuZlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831822; c=relaxed/simple;
	bh=qqZmjCpo5232y3o5lsDCc1JbC2eeUqONBtr6F00VKRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPR57p81af7koIXK+XSKNYF8PyKTSjtDyXyriwXtMgVhmgMYqJX5dKl+M6RKUDzV7ACRfbzoaH1STj1g2K3gixkyHPbeZT1Sj1JrItokBfMnyzFv9vv0CnuXET/XZJOAcy/5Kh96U4eKaz61XouhFfRHXebneYYv7ao3Aqoe5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwGzwM+5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a732cb4ea31so327096266b.0;
        Mon, 01 Jul 2024 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831819; x=1720436619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqZmjCpo5232y3o5lsDCc1JbC2eeUqONBtr6F00VKRk=;
        b=NwGzwM+5SPXk1gVgR1j0AT04BKexUsEtOehqoPgu7YCF6z6gDipoYMZH/2bU0mw9nE
         uRGCMvGt0H4aEKpFrtR9b1ONFFphOh4zKenVEDBLq/JzxUcHja0nfWgG4QWYoE4PGVYB
         Riy8c2O4i9ze7jmbzWXk62oGY/zigaIDvJBhOcQjrFogp+tZjZOq2FY8bsLyPE0x816b
         vUNpL17xp35nU28Mvg5zSY5Y0he8NgMGe2yiHP+EOs2VqKPGgpL5/2Hck+kLH43ipL+p
         Knkcu1tvhcctzuajySv9pyXPA88NPDWZmNYNxKBiH/ZaVl63WZKS1DoKzQo2RYsbYmKD
         IVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831819; x=1720436619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqZmjCpo5232y3o5lsDCc1JbC2eeUqONBtr6F00VKRk=;
        b=jHrU+WgpEDq6WvecPV+RT3rPJ4OC3ZJTiqgO9YOyVkaLm9tcUW4YxVUoROeoeOIyW+
         5fTHfS9AZdOFE5x/o1alQeUYhi8B7r8y0RxdVpujKLiNuYybCuujFcMK+TU5/zNUr84/
         ThKPa/3Sb5Ojq3b5TeL0FUEDjb57q7+mqkpSNxceX2ympotDC72RsdD2C1uJl/0w/4gJ
         V8RbkqQ69osUdqEdkRLDOcUeg3DbNHvyvs4inzMS/teN5PAgGoIqWWLKzydiKAvGmlOt
         67GmK+Jl/FbWxCnrHEi0eys2dPgkwVdW1/NSVed9ubERvo7vUJvcZpvOMjPuhf96MtO3
         5LSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSKhM8MNCwh8Ka/BfHpRHatHodkdlghuI6EjAdqcYHOkFHx1k/qXBgVnIiFgNjPXS7O8aPOyScb8oZrziU1hD2hVqtCP5/m1xV8k5DQtItFtF1I9bN/nylENZWhQwHlOp/hCfM+CaGHw==
X-Gm-Message-State: AOJu0YyQqEAj1norUeyHbBGVxqSt0dp7IY3sOdLT0EEk8Q3koKSE83bn
	HeUuoiHwJC/3paIRX5nbU5azrnvac43JRjTEjCwwmZxvTn3AAsLYUCpwyogDNVP/Ps4bDTvFI05
	WPgeEnklSYndwWMWsJkC4fZqZlg==
X-Google-Smtp-Source: AGHT+IHOLmypry9Z0LFXcuZ6zHoIhxdWJqXsqXi74RhD63ls/P3HArXrSTuTghZhvH07hjRgqQc9cqnm0cTt631Q4fs=
X-Received: by 2002:a17:906:154c:b0:a72:7bc0:efed with SMTP id
 a640c23a62f3a-a751388f6dbmr448175066b.13.1719831819095; Mon, 01 Jul 2024
 04:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org> <04f5162d-8a95-45ce-a891-3f711b27a469@linaro.org>
In-Reply-To: <04f5162d-8a95-45ce-a891-3f711b27a469@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 1 Jul 2024 13:03:01 +0200
Message-ID: <CANeKEMPAng8K1Gbab-MXP0KodS=r1Bzstsvg4zadWdu1O7wqWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 12:23, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 7/1/24 11:15 AM, Tudor Ambarus wrote:
> >
> >
> > On 7/1/24 10:46 AM, Erez wrote:
> >> When using mx25l12805d, we do not read SFDP.
> >> As it uses the no-SFDP flags.
> >> When using mx25l12833f hardware with mx25l12805d driver, it did not
> >> try to read the SFDP.
> >> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> >> driver fetch the SFDP.
> >>
> >> Secondly SFDP does not contain OTP information.
> >>
> >> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> >> While mx25l12833f has two OTP regions of 512 KiB.
> >>
> >> How do we handle it?
> >
> > You would first try to parse SFDP and initialize the flash based on
> > SFDP. If there's no SFDP then you fallback to the flags declared at
> > flash declaration. Esben had a try recently, see [1]. I don't know if
> > there's any progress in that direction.
> >
>
> And you can then decide which OTP org to use based on whether SFDP is
> present or not.

That can work, but sound like a hack.
Is that really that important to hack?
Just for OTP, that very few use?
And if in the future Macronix adds a newer one with the same JEDEC ID,
but a different OTP size?
Macronix does not consult with the Linux Kernel on these matters.

Anyhow as I do not have the hardware anymore, I can not do more
changes and test them.

Erez


>
> > Also, you haven't mentioned anything about the testing. Do you have the
> > flash?
> >
> > [1]
> > https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/

