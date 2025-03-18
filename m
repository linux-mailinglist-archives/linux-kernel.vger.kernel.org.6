Return-Path: <linux-kernel+bounces-566010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2410A67214
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E25819A75D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE88EAC6;
	Tue, 18 Mar 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUIpqbiP"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAD209F4D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295721; cv=none; b=jDRGNdwnGCaWKYAqBEcCn1TcBe/BuPhyLuT9WGDGXfFXFlF8PcF4eP6t0OXtx/eu9hxqXMijkLka2L9BjaG5L0IUvVQff/HzevjvuVX9weVtWc7/ktO6xrrjaaeMJqGTd8Cs1QbiBOCcaAN3xLktcKCywxSrmVFCfI+p63ATqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295721; c=relaxed/simple;
	bh=GVX9slFJMODz4a8wem080O/vqUfxzkd3EO7gX3oSxtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8XAIl8/YzzHWy+cfau+hZTbMC61NgUmvQw2aglq8P+aOpH1uQB1zDGW+UsUuFLrF89a7CcSkLOod6ZWwbMe8qnOSJ4Ec/yHlE46mlEY7q8/TI+kT/uyoneKbhL56n4gICULEkq4uhi0cxHkNgrMdVk365PszhRTCeUxEKCw8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUIpqbiP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d43b3b4c32so169565ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742295715; x=1742900515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyOTlkMLLq1XbPf3HPBV8cNbeM65vB0jFdFuOYLkhJY=;
        b=uUIpqbiPgmmR0pKzekj/pz/GqtGq6xjazYrSkWBuiMvoGBlU4nYElTuZ3SI+VjQOAt
         oUFDSaaiH3rud3mgwb6msNEga0R3GEvGbeEgc+qsTnniCn66J+myoDBXnNme6kKbhV+G
         I/6TBb5QLv/I0VQvFOJuVcOSxtkmUHuUF0oe1G31rssB6DcRHJs/I5N/V08FWuIO8HFL
         DhpX68vL21INhx+QVCR1YClLW8A/nSdqBghjz3lEgPG7wd7nfyVuUtsR3dH5L/OnmVrt
         iMC48na3lWmNBNS7I93uYzhKiPQxlBtxpEinzsxuKTePCKOEkPtv0QRcApzbyoos9nHt
         Utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295715; x=1742900515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyOTlkMLLq1XbPf3HPBV8cNbeM65vB0jFdFuOYLkhJY=;
        b=fQHNv02Mxhas1v/aM2HUpTWYl3XjSzIFFCWr+9qGn5nG9Hf8JrFFbj4vX092pye1Hu
         onbVk3FWRyfOFjS6gPQjTSLeMX/f6AoQvpu/fGQ3LJv9PtrrvVKQ9GXZAMnMSgfNtlHR
         2/DJ22IXDAsymY8zvbaHG1zN4LG9LiMW0ORaMbxjfTBxFJpunld3AIZ5+YC9Bv+vViSZ
         1e9xMvUVhxikIp9dDHBDeFMh9EltmLsAfQtv4CkaBTB7bMYPe5Xn8/MP5pUxgLQ7Qdms
         odwk1pTQr40HTD4/aHi5Grdb6jUhrSkwQU49ALNS86yowt1cptpAnWXjwUtmUPLdld1C
         3lmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5J6a/fbI01npNW5GAJn0uL48BHyTzibs7gSctrQJ9z5lPfpZTuLwTesqXMgMmWQMK0SjFquPxq9/QURQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKSR2plO4feyGCzTc5DhZs27zXJiI1XqYYqcCPSXDll3j3QiX
	XvHk/Pvv2ad1MpCfXjP68BnAsZt2EqfWcYRIRx1qUcPZ1dULicMcpZ/UlCv2JGJoxhWI0svPQ3+
	jxtKRtOa8YudG8l/UTP3h7GkXHy2RhzSthtTL
X-Gm-Gg: ASbGnctDcsxuWXL7dP0VVoaYPQqzmIBMHxuPt5kgUOrL8499Dv+Vpf4+wFaXSMY4TTe
	53zvRO53vbgLMDHkTDCSsQxQCY1w3m7uWcAsWSC+hMTrCEkj51HdZ04ZFseNvAA20f/1HNOueaH
	kWS8w/h45WSEFk15AmTC3+6w0gjRYQLxdIlYhdumNU54jmp1t6poGgHA==
X-Google-Smtp-Source: AGHT+IEhQurkZUOjDCLCR6aX/svMLP/x01GJxn3vHhsxdJO5NhP/IMZvSX69zNS2XwIqEYqsLONLtYI2WX1kf/PROI8=
X-Received: by 2002:a92:c26d:0:b0:3d4:70cf:f380 with SMTP id
 e9e14a558f8ab-3d57f07db2emr1550895ab.5.1742295714506; Tue, 18 Mar 2025
 04:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317182107.2060739-1-czapiga@google.com> <e2e890a9-ebc4-45fb-92eb-502be027e807@linaro.org>
In-Reply-To: <e2e890a9-ebc4-45fb-92eb-502be027e807@linaro.org>
From: "Jakub \"Kuba\" Czapiga" <czapiga@google.com>
Date: Tue, 18 Mar 2025 12:01:18 +0100
X-Gm-Features: AQ5f1JqsbLmaJK8yqtKzEwiNea28ZEfKsiKImtRDuIAnjxzqfuvHz_ePZ6SiEHs
Message-ID: <CABkukdq_d0YrdUz_+3dkn3BymDMzRfXk1s58ZTMCuUwO3mbvJw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: xmc: add support for XM25QH128C and XM25QH256C
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:27=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Hi, Jakub,
>
> Do you have access to these flashes? Can you test them?

Hi Tudor,
I've checked our inventory and it seems that all our devices use
either Winbond or Macronix compatibles, so I'm not able to directly
test these chips. Looks like ODMs default to Winbond chips and all
other variants are a viable second source. I got a list of chips from
our factory team so I assumed we have some devices I can actually test
these changes on, but unfortunately that's not the case. However I
could use EM100 to emulate these chips if needed, but I think I'll
have to put these changes on hold until we actually get some devices
with these chips. Datasheets should be good enough of a reason, but
unfortunately in reality chips might function slightly differently
than described in the documentation.

> We have a minimum testing requirement before updating or adding new
> flashes, here it is:
> https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requi=
rements

Thank you, I'll perform necessary tests on all chips I have access to,
including other patches I submitted alongside this one.

> It's true that we don't have yet locking tests described, but
> contributions to the documentation is welcomed!

I'll see what I can do about this. We need locking to work correctly,
so having a good testing scenario will benefit everyone.

> On 17.03.2025 20:21, Jakub Czapiga wrote:
> > Both chips support SFDP (JESD216).
> > XM25QH128C only supports 3-bit Block-Protection with Top-Bottom
> > configuration bit.
> > XM25QH256C supports 4-bit Block-Protection with Top-Bottom configuratio=
n
> > bit on SR(6).
> >
> > Signed-off-by: Jakub Czapiga <czapiga@google.com>
> > ---
> >  drivers/mtd/spi-nor/xmc.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> > index d5a06054b0dd..963a44c3909a 100644
> > --- a/drivers/mtd/spi-nor/xmc.c
> > +++ b/drivers/mtd/spi-nor/xmc.c
> > @@ -19,7 +19,17 @@ static const struct flash_info xmc_nor_parts[] =3D {
> >               .name =3D "XM25QH128A",
> >               .size =3D SZ_16M,
> >               .no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_=
QUAD_READ,
> > -     },
> > +     }, {
> > +             .id =3D SNOR_ID(0x20, 0x40, 0x18),
> > +             .name =3D "XM25QH128C",
>
> for the next version, drop the name and add it just as a comment above
> the flash entry definition
>
> > +             .size =3D SZ_16M,
>
> if flash supports SFDP, drop the size parameter, it will trigger SFDP
> parsing.
>
> > +             .flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> > +     }, {
> > +             .id =3D SNOR_ID(0x20, 0x40, 0x19),
> > +             .name =3D "XM25QH256C",
> > +             .size =3D SZ_32M,
> > +             .flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4B=
IT_BP | SPI_NOR_TB_SR_BIT6,
>
> same here. After switching to flash init based on SFDP, please do the
> tests mentioned above.
>
> Cheers,
> ta

Best regards,
Jakub

