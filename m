Return-Path: <linux-kernel+bounces-407365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA89C6C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B5B2867F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01E1FB8B3;
	Wed, 13 Nov 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKwGEJf1"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5581F9A8E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492660; cv=none; b=glwLRCl9kUCkavwMmiRpBaj5Xm05XLHCnpxU01OCpAykMaZPqloe+CBGTv1f0698MMTyGnjfysCeWgF1u7MRqRd2NhH0+e1IQfpmguEeyYMdJFVsEzaVEtjWqzgtGkF/IKyQ6NfEfGs+ESdQWOz6uUkhRVy89ZVgNPlmiRRfrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492660; c=relaxed/simple;
	bh=svp+5bW/5855obVVtWRajkCPG6F79wYW9r9nPNbVKBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DshO4B2ZQal8D9D9I3+P4R/BEyxFqRT43A3e+R4JY7dPa+L0kYtLC6kLV164ZazkoalKAGL+4iATKj0nc6LOrhSLrkrt9GTwIz6Qlu1xYlwBu7YEMZmWOG/zhO9EQ4m6KOTov0BeIdXxX1+SzLoh6q5PcQzusfaBgfPaWVnO4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKwGEJf1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e3cdbc25a0so67388157b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731492657; x=1732097457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svp+5bW/5855obVVtWRajkCPG6F79wYW9r9nPNbVKBE=;
        b=jKwGEJf14KL1XJG/i82iP+LmwwhwcvwgHt+QFsF2cQq1HaFLbnjEAgDrYztUVwm5cD
         FVC5k0qDxQOiMfy+HgA3F59m4DXk1MDkOvuvmRpCp7rtF7D7JOHR7bc+8ZELH/EBNPLG
         vC1TnuWT7HdWTvQePJaviLkZhRL4amE7B4LOnCLA9mONVBkpx847eXGUx83h0ckmDwRG
         0TQk6YWRUw6S/rgTxdEn6lxI9YRxnZm23x3O52wAjuXBRYfOjuc6KPEHUuoh8APewLOB
         72baiGtjb5ZeRKr/BBv6EOQizQDWwDF142PhoGV2ZwIVNGMY/eKp/LIYsFGsqGIs6LHg
         FYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492657; x=1732097457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svp+5bW/5855obVVtWRajkCPG6F79wYW9r9nPNbVKBE=;
        b=ZdWQ0Z3nlVxHwTRlEXBtUaVWriyOHoBWJ3wbaWczHajAYCo4udbKsw/hTfdjw+/pxF
         45mXi8UGbXFEbzo7ILSKrHODfV/YrLxAKvseKRZ84ifo0UZ4Gf2ZDfO4bL9+cnWUV5XL
         Aor2rY0khc/DeAZwjo6zKvwXMeOkbD+Z2EONdSt+UCP5vor1Rj4hkT/Txaf3v/wBqAD7
         gdQt3B1MpnPJH4A78HDojtVpNqX4ZJcGoxGtcAUdb8bnygZfCM4bhb/BvH5bwG9u0f16
         2prLlhZAM+JoBV6GKU9D8gQ/6yDQ5lZtyGTor9oKPW11WK/LlO9baRI6vBPeZFO+m/1h
         UiPw==
X-Forwarded-Encrypted: i=1; AJvYcCX0mAtJBt8XJ/g5tMDUJKrTuhB4Vs2QBhJLIHJjTOCxB+ixzE+Io79z5Glvh+UHGnAE60XDIUJPU/I6iFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/piPe3UGVZQCmZMjychhCr7i+2yhH6CgWF94oWaO3M5C5+By
	unMXZ7fHTpM8FDljUArqsJDGMsYHjNnwl+hvowh0kEE1VTmT1Bwfo3eI1xjyK64dF7xmJRaa/Xr
	ebW4PgMzq4WQH8ZVivKrFxZJGWThk2TwbuBE=
X-Google-Smtp-Source: AGHT+IEmwfBtDsJXCpjTjW9tEez5MUnlTdPs/uC/B2JiXS/bSuHkFLh1/9E0LypLApqn/DGMjXSr1bAHqNJOVnmB0dA=
X-Received: by 2002:a05:690c:d81:b0:6ea:3e6d:2b01 with SMTP id
 00721157ae682-6eadddb0f9cmr186414837b3.19.1731492657358; Wed, 13 Nov 2024
 02:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
 <20241108163455.885-4-SkyLake.Huang@mediatek.com> <dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
 <87ikssu3qq.fsf@bootlin.com> <12f4d28f3efb7fe319ec919df92145c4ad24da01.camel@mediatek.com>
 <87h68bsdv6.fsf@bootlin.com>
In-Reply-To: <87h68bsdv6.fsf@bootlin.com>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Wed, 13 Nov 2024 18:10:20 +0800
Message-ID: <CAJsYDVLYE1=sAj5Pvni17xQ=4akFCA+UqtuB5RKq77HxL4ux9w@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: SkyLake Huang <SkyLake.Huang@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>, 
	"kernel@sberdevices.ru" <kernel@sberdevices.ru>, "d-gole@ti.com" <d-gole@ti.com>, 
	"dev@kicherer.org" <dev@kicherer.org>, "vigneshr@ti.com" <vigneshr@ti.com>, "richard@nod.at" <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all!

On Wed, Nov 13, 2024 at 5:05=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> On 12/11/2024 at 11:25:25 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=A4=
) <SkyLake.Huang@mediatek.com> wrote:
>
> > On Tue, 2024-11-12 at 11:48 +0100, Miquel Raynal wrote:
> >> External email : Please do not click links or open attachments until
> >> you have verified the sender or the content.
> >>
> >>
> >> Hi Sky,
> >>
> >> On 12/11/2024 at 10:08:31 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=
=A4) <
> >> SkyLake.Huang@mediatek.com> wrote:
> >>
> >> > Hi Miquel/Martin,
> >> > About this driver, including F35SQA001G/F35SQA002G parts, I'm
> >> > concerned
> >> > that the driver will always use 32H for update_cache operations,
> >> > which
> >> > means it's not compitable with those SPI controller who can't
> >> > transmit
> >> > 2048 bytes (most small-density SPI-NAND's page size nowadays) at
> >> > one
> >> > time.
> >> >
> >> > The following controller's driver seems that they can't transmit
> >> > 2048
> >> > bytes in one transmission:
> >> > - spi-amd.c: 64 bytes (AMD_SPI_MAX_DATA)
> >> > - spi-amlogic-spifc-a1.c: 512 bytes (SPIFC_A1_BUFFER_SIZE)
> >> > - spi-fsl-qspi.c: 1KB
> >> > - spi-hisi-sfc-v3xx.c: 64*6 bytes
> >> > - spi-intel.c: 64 bytes (INTEL_SPI_FIFO_SZ)
> >> > - spi-microchip-core-qspi.c: 256 bytesc (MAX_DATA_CMD_LEN)
> >> > - spi-nxp-fspi.c: TX:1KB, RX: 512B in FIFO mode
> >> > - spi-wpcm-fiu.c: 4B
> >>
> >> I believe most of these drivers are still able to send one page of
> >> data
> >> without toggling the CS (which is what actually matters, I believe).
> >> If
> >> they were broken, they would be broken with all spi memory devices,
> >> not
> >> only Foresee's.
> >>
> > Hi Miquel,
> > I think it's not about toggling the CS?
> >
> > If a SPI controller tries to execute write page and it's capable to
> > send only 1KB in one transmission, it should transmit data in two
> > steps: 1st 34H (random program load x4) and 2nd 34H. However, when
> > F35SQA002G executes 2nd 34H command, it needs to execute 32H first, and

I don't think that's what the datasheet means. I think it needs
02h/32h as the first
command to write page cache, and the subsequent page cache writing can
be done using 84h/34h before the final page program happens. Otherwise the
84h/34h command is just completely broken and useless.
If it actually is broken, we do need additional guards in spinand_write_cac=
he_op
to abort when spi_mem_dirmap_write doesn't return exactly nbytes as request=
ed.

> > it will clear data transmitted by 1st 34H in NAND flash's cache. This
> > will cause data corruption. Other SPI-NANDs doesn't need to execute 32H
> > before 34H.
>
> Is it really what happens? I'd instead expect the spi controller to
> send:
> - 34h
> - 1k data
> - 1k data
> ...
>
> Why should we repeat the command while we are in the I/O phase?

Several SPI-MEM controller don't allow software controlled CS, or for some
other reasons are unable to execute a longer spi-mem op.
spi_mem_dirmap_write returns the actual request size it's able to make,
and spinand_write_to_cache_op use a while loop to split one update_cache
request into multiple ones.

This only works using the Random Program Load instruction (84h/34h)
which preserves the previous written data in the flash data cache.
All current supported flashes are exclusively using 84h/34h as the command
to write the page cache.

Load Program Data(02h/32h) will clear the entire page cache. As a
result, when a request is split as described above, the previous written
data will be cleared, breaking the page cache writing procedure.

We can change write_to_cache_op to use Load Program Data on the
first request. If that doesn't finish writing, use Random Program Load
on subsequent data loading.
--=20
Regards,
Chuanhong Guo

