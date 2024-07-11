Return-Path: <linux-kernel+bounces-249845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0F92F0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DD8B2140C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B519EEC5;
	Thu, 11 Jul 2024 21:05:51 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721D2836A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731951; cv=none; b=as845AiPIWztbe/nsOe6XPiUVF3Bw2IOBns96U9/fmMHDkGs15d+lBGPN70e9ZdCdh4fJ+HUuj/7M706hggHYuTqrQdN2mn13GdOm0sPR5/gv3w8Kxi5q0TsbEQOWS4sr5uPtkKVA+2IEK8OfszxpoohXGMAHTM5Cmeugw+SEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731951; c=relaxed/simple;
	bh=3E0gw8xZNZBcKBZ5ftCmrShsMbwKFLPy3qBKIy5L2qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgrKJ3/6RViDzolXAbGSMEc1TswiqBa3TCvdwTwRAVFHnOVbOtcvf7RtIUGHXResYF1tOi5aCwFBBB9wQtnfh/ElqNrnKdiq22rMN4Gm1w/FblumtVnlXnIam2iWEsCawACs1ieNL6Z3lRva1jIOAZgIGhl8Lg6Vz4JHIIEoI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-651da7c1531so13490387b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731947; x=1721336747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k86+4SfRSUfiHslr+mDimkcGpY1JjNeuf0o8H3HX8vw=;
        b=UuN6kvSDO0XftQnDuTcCOWy2+RpY9VdaIW2rSaSJUKwrgVdrkOhFSl2bHGqWTDIuJi
         05aVX2bgY+Vdy9XGSoKmYRgZSE0Egct2LX8+rH0FN4dxJqkiLKyn21mUV/DuGwcdWvE8
         XmMwXv8VDbPpeHEoX/fogSzhXTRPrp7cH/6kRpwNwE33jYaIp3HlXkLPFZdrT6/W7ybH
         D+k9mYQfuFNAOidouL0N1HodGKUxp7mD4XfVfFPYro4yTPwryqfC7qzDjUM42MM3aKPA
         bwHlxFFBbMizD1k9C00fRGA+9m66ELkVylO7NKI47pL4F4qyB/cQaYjleDNLL0E3jmbF
         FDBA==
X-Forwarded-Encrypted: i=1; AJvYcCWIc/q1n0qX9ZtAKNcMpjme2/KLppjkazg5lKbYwrB+x0vzPUbx+UNwDXGut7YAykvq8CwHHIR/6FxkV2SNBoO8VHxrPfyEVf+TRT2z
X-Gm-Message-State: AOJu0YyipJgYhRQ1BEc0ja3AbW7vNvvQAjCyehGqu2XFKilZJXR3YZx0
	qBI5TNGDSIqdEWexmDYbBRdN0cibJODEaxMDjHxNTvsn+48Yjh1v7e93tYSq
X-Google-Smtp-Source: AGHT+IH8/INBMYrnJkFxTvK0pJ/+EkuLyaIFhiR7m5rrDXVh5pIeYC71bv4Eo3GLaKSpIn2sS/5vzA==
X-Received: by 2002:a0d:dcc1:0:b0:647:eaea:f4de with SMTP id 00721157ae682-658f11a56d1mr92699657b3.47.1720731947138;
        Thu, 11 Jul 2024 14:05:47 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e69d999csm12326417b3.107.2024.07.11.14.05.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:05:46 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03a581276eso1205250276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:05:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURi+tiHP7wMrzBrbfrQogNdxUiweAQjrBHLSotnFKXVn6Iuf80Cb4ltejTEM0wupSa4UvhvB5tuf/4NMKWVik9EJP3ti0nSVwtsWiP
X-Received: by 2002:a5b:d1:0:b0:e03:aa99:66d2 with SMTP id 3f1490d57ef6-e041b078519mr10915431276.33.1720731946075;
 Thu, 11 Jul 2024 14:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711132001.2792-1-baojun.xu@ti.com>
In-Reply-To: <20240711132001.2792-1-baojun.xu@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jul 2024 23:05:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUw+KEGuAOWApfiLJF6b1M8pkoX+u+Q2dEVMqjV0_K34g@mail.gmail.com>
Message-ID: <CAMuHMdUw+KEGuAOWApfiLJF6b1M8pkoX+u+Q2dEVMqjV0_K34g@mail.gmail.com>
Subject: Re: [PATCH v9] ALSA: hda/tas2781: Add tas2781 hda SPI driver
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, 
	lgirdwood@gmail.com, perex@perex.cz, pierre-louis.bossart@linux.intel.com, 
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com, 
	v-hampiholi@ti.com, v-po@ti.com, niranjan.hy@ti.com, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com, 
	broonie@kernel.org, soyer@irl.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baojun,

On Thu, Jul 11, 2024 at 3:22=E2=80=AFPM Baojun Xu <baojun.xu@ti.com> wrote:
> This patch was used to add TAS2781 devices on SPI support in sound/pci/hd=
a.
> It use ACPI node descript about parameters of TAS2781 on SPI, it like:
>     Scope (_SB.PC00.SPI0)
>     {
>         Device (GSPK)
>         {
>             Name (_HID, "TXNW2781")  // _HID: Hardware ID
>             Method (_CRS, 0, NotSerialized)
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     SpiSerialBusV2 (...)
>                     SpiSerialBusV2 (...)
>                 }
>             }
>         }
>     }
>
> And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> added into system as a single SPI device, so TAS2781 SPI driver will
> probe twice for every single SPI device. And driver will also parser
> mono DSP firmware binary and RCA binary for itself.
> The code support Realtek as the primary codec.
>
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> --- /dev/null
> +++ b/sound/pci/hda/tas2781_hda_spi.c

Thanks for your patch!

> +/* fixed m68k compiling issue: mapping table can save code field */
> +static const struct blktyp_devidx_map ppc3_tas2781_mapping_table[] =3D {

> +/* fixed m68k compiling issue: mapping table can save code field */
> +static unsigned char map_dev_idx(struct tasdevice_fw *tas_fmw,
> +       struct tasdev_blk *block)

> +/* Block parser function. */
> +static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
> +       struct tasdev_blk *block, const struct firmware *fmw, int offset)
> +{

> +       /*
> +        * Fixed m68k compiling issue:
> +        * 1. mapping table can save code field.
> +        * 2. storing the dev_idx as a member of block can reduce unneces=
sary
> +        *    time and system resource comsumption of dev_idx mapping eve=
ry
> +        *    time the block data writing to the dsp.
> +        */

Do we really need more copies of this?
See sound/soc/codecs/tas2781-fmwlib.c.

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

