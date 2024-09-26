Return-Path: <linux-kernel+bounces-340381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992AD987284
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EB8B2D986
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097881AFB37;
	Thu, 26 Sep 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRVudJuK"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231B1AF4D8;
	Thu, 26 Sep 2024 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348979; cv=none; b=jlEuRgukvwg+nBh516/PJWV2JMKF4loPI/VlwmqUXpPZ+wx/xZnaSp121Q6EbK6u2Y+Mj+N+pBHNBhHlBJ3ee70odNLFLU2l+CmDbJ+g/VJ5MuPRI0tBF/YKwa2N8paYoMqRAXLI4QwNEISSIJL4H0+l6jars5bOfcVEXLG9NP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348979; c=relaxed/simple;
	bh=xdJOq5mfTWCYDUHlESn0SZzeVA7nWwKzf6sY87yK+oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di/R7F3HbViJgqL2ijkDS1/wU9Pnv+J+Pfu0Kxod6pdViDXhSioEjmfYEKrB6rwhe7D8NlKJm1au56xONhyQ0qEuADJJRgl9fqVFh3du5ns9YpNry8qOTSfs1pyGsVexlJ5HUg6Xpmy8sFY2kBopTxRNk12Rtb84c9bASvrO1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRVudJuK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a93a1cda54dso115370766b.2;
        Thu, 26 Sep 2024 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727348976; x=1727953776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xdJOq5mfTWCYDUHlESn0SZzeVA7nWwKzf6sY87yK+oY=;
        b=hRVudJuKqnmNBXruk/a2fCULgW3VEDjWElwbBv2XvTBYl/EvZOLNxGQBguOoc0J+xp
         9tyIdJUxwBCVSc+HWFnw3wkDZGI4N3M4JLrFGFiSqRBkhS69puKrG7inLxRLMQ4Ghd9a
         zH1+111pAK0AH6kf6rckR3P1ruV5P9bRFTl0KRNvgdHLpy4I83qmfBGVHcqNl0xdT2XI
         Iw/UkhWQIbQUuhCQ2ZE93pfzqM/we/G8jsNk1kENeIEQ/Gwo2EKjJXGpcwt+sCpRZCbD
         WXF1r2ujOFYn+0RuZcHzgiaxAt9LJmbVqmgIfYHr74/9kP/8dhAZONc3drRKyghUyKdY
         qCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727348976; x=1727953776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdJOq5mfTWCYDUHlESn0SZzeVA7nWwKzf6sY87yK+oY=;
        b=VszscgJj2+jCfvCRbuEZreLn+9e/T1jsSHJLGW4sWQCuxaCFGnSkIA+FcsIUDIqA6A
         Hd6KQssI2z4BURvaXQFs6fbDmeEeRNkYNjKH+MdvKrSN1a81Fs+jqQ5KqLfCCPETueTy
         HnRQxlej+NRYBDO3nifs/+Nw7ZJlV8xxIhvYjR90iYK45Tvqz1PML4Yk1kEBJsDYJenT
         X355Yq0NQXXMhEMFsyTmkz40RaM3P6EZfIbcExuj2x+cMKDIl+cdLbNc19+WH4v5gwux
         M7xa4IWZVdez7o3pVZmI3WiQb46ZwGjXzTmEQwjOw/3AU2cVEsobf9CBQ+oipRgV8MX/
         ngXA==
X-Forwarded-Encrypted: i=1; AJvYcCVYZegMT1T3SWe4hLCZ+zwlBdzK8zVFUR5K6kadIJpEo+vVyVFeEnJpOmGtDtBT3l5zutO/qCfDOcer@vger.kernel.org, AJvYcCXbRXlBbcQKNjkTMcB6fSZ+vmHG+k8XRfCF4d0O1oGRsS2lweP2rDdlAKNNRqifnjUoGoYGWU0eYm0HzQDV@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXeDODwqyD0e5D0NM22FqVgnHPd8AmR+b2Z9OEIsECwSBjLUe
	GMGi9x74qOXEsAHkvH+svD2PVfr8DL5H7jFW/E88vNMURLhjjnQd2z98dtJJFmm5+NtCduQ3b7Y
	ZeasokyMra10F4xQBJq+fCrxpRQ==
X-Google-Smtp-Source: AGHT+IEnuM6AlAaEVv+IZdO8uASoC+b+/IGZwpjZ6p5SSkChosB3pf+ha0nvbg1erWv7n2OT4aXkiPo6BtfqS02wxNU=
X-Received: by 2002:a17:907:987:b0:a91:15dc:31ab with SMTP id
 a640c23a62f3a-a93a066eceemr488435966b.53.1727348975649; Thu, 26 Sep 2024
 04:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org> <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org> <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
 <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org> <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
 <87y13ehn6y.fsf@geanix.com>
In-Reply-To: <87y13ehn6y.fsf@geanix.com>
From: Erez <erezgeva2@gmail.com>
Date: Thu, 26 Sep 2024 13:08:59 +0200
Message-ID: <CANeKEMMcZ+Y-f8Kty_4Nk-kRu+F7ZXBbxpAG1Bd_P1vcju1mUA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Esben Haabendal <esben@geanix.com>
Cc: Michael Walle <mwalle@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 09:46, Esben Haabendal <esben@geanix.com> wrote:
>
> Erez <erezgeva2@gmail.com> writes:
>
> > On Mon, 23 Sept 2024 at 18:19, Michael Walle <mwalle@kernel.org> wrote:
> >>
> >> > > > I would gladly remove the obsolete mx25l12805d.
> >> > > Why? I don't see any need for that.
> >> > Maybe because we do not want compatibility table?
> >>
> >> I don't get this? Anyway, we do not remove support for older
> >> flashes for no reason.
> >
> > I did not insist, you asked.
> > Macronix stopped selling these chips 15 year ago.
> > How long do you want to support old chips?
>
> It is not unusual for embedded products to have a support span of more
> than 20 years. And chips such as these flashes might not be entirely new
> when the product is introduced. So dropping support for SPI-NOR flashes
> that are newer than 25-30 years is definitely a risk. Somebody out there
> might not be able to upgrade to latest kernel versions anymore, which is
> not a position we should put anyone in. With the increasing pressure to
> upgrade product for better security, we definitely should not make it
> more difficult to run newer kernel versions than absolutely necessary.

I do not insist. Nor send any patch in this direction.

Each project can define the extent of backward compatibility.
In terms of compilers, linkers and tools, i.e. build environment.
In terms of standards like the C standard we use.
In terms of network protocols.
And also what Hardware do we support.

There is no harm in asking where the boundaries are.
All projects move their boundaries all the time.
The Linux kernel is no exception.

Erez

>
> /Esben

