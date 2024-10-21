Return-Path: <linux-kernel+bounces-373791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AD9A5CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCEB1C2185E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9521D1721;
	Mon, 21 Oct 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EVUYjl+z"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E41D0F69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495565; cv=none; b=b5vAvjMT/PHIAgHOF50lAAwgGFJolGG7GRkfbq1IYlCMTL5P9fDCJ3n+2cj12Kb+hH+fT5e+ERoZ9j/l4NCbGgpuQ0hYnZ+tcKfXudfQH0+JTJBz4GH6n2ldbdgcXCseDvRhiAQVpSP8sN1uwW7RhzeHWLC2Xyq+iZ9Thy2m9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495565; c=relaxed/simple;
	bh=G3VWgEKJi01ZdmdbVMurfUduDugtTzi0L1djoFQtduk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JblMlGaCiSn/xU+ZNvHEQ8ZKw/KbBwJsHWoTl22PRJjUOmOBL/KNn8HssdnIHBNIqQBdykjOliSmwJT+XUMIqIgaM0rK2btxaBNlZIkjICHrXBO3TOWBwvAmuAkmnM9akXuU9bm7krmOFGIl+kpOxXxPe5jo2oj89EzSmOFjKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EVUYjl+z; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so3390692a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729495563; x=1730100363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riSNOYHYyitn4HEz/ZUed6KwnUQgSADxWxrkcSLcPik=;
        b=EVUYjl+ztFpbNrf7WMChhgh3MK+mbXLr4v6ty4+mdwBI4dcE5w8FyGyOuH1hNv1tqU
         fUo94Z3mSE5LUMlzm1EjdWbAng1hxCynR9wXfnTXXOuHWosqSwjo/MLooy+or2lVQGkE
         in2/oMycmV9B+4B/Bbf2tiZS7pggBxW+VwEciykWMKSC8DHfatJGA6UzdpeDSGE58PjE
         GxrHtk29wQrm7/RA+uqxe2OYUpWAZKNcLOvpNVa35CVO4nrO+R0i+fbKBL9ZbIkRghqW
         EpNK+Hwmda2olU5myqhURtca2xZnal29drHEgsiuBKKqI6geITRNKsI1NXhCI7ff0alJ
         RVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495563; x=1730100363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riSNOYHYyitn4HEz/ZUed6KwnUQgSADxWxrkcSLcPik=;
        b=p0wIn5z80hQMUQd/FHXyFnfF6fVKyy7TXuRtk97Wg+KzZZtw7YQw3OP/jUGCNr5enY
         iwNaE1dNg/7Mm38Lk4w7G3vSti9A+w9BIWUFO9XGuwsC0h/1ksMNSMHnujOw4oE0svHH
         /FtOcuVY0uBwoaC1lLZobCbpeuJpEq4mLat/dnG3MKpz3qyB7gr5iJXU4JJyn1fATh5B
         ZwwRvcqHLG+3pJz+0P6xjBzZi+eoKNaFfbaQvfqT7aU+k2npht3xNhsrJXTDdyAwKvlv
         yUc463vMP7IYesVgOnBgNgTW5cKJyNlcghhy4A225hjDLu4SESd2jJOFquhkWBp2/ULS
         7a+A==
X-Forwarded-Encrypted: i=1; AJvYcCVEEpsUqoWW+3B6xvr38+AQPyliYRatWW7bfc25C8wQ1LwSBv2ksHueWBTQkVxlh+qTbastevv97WFX7P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9yvATAk+2KGuaJKO9JDr+NSOa3kKKOeYQT//kz8gGeSb3xtP
	ewOdSCrQ1shHtHYX9LDe7v9Y/vjNz++1Jenha7s/4kPaTC2Ywddwmuuh+/mXu5fHeLN8/nKBXLA
	DlCOFsKN6TvC375F3Ji4qPTNiBdSk9/XX4DIkLDFehWtQPKTU
X-Google-Smtp-Source: AGHT+IFGf1Ktyy7MxB4aZc49mV0SYrg6hPff5eb+EBA6A4nZiQcncUr0r8w5/JXdPXS+OeuWFF4VbOJd2GiWctXxM+4=
X-Received: by 2002:a05:6300:44:b0:1d8:b8da:d658 with SMTP id
 adf61e73a8af0-1d92c501706mr13794945637.27.1729495562919; Mon, 21 Oct 2024
 00:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007122350.75285-1-brgl@bgdev.pl>
In-Reply-To: <20241007122350.75285-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 21 Oct 2024 09:25:48 +0200
Message-ID: <CAMRc=MeVQVeXdMTk-ZjabkEv58VN=2vchcy3LZ24pEwwN1DTpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: rawnand: davinci: order headers alphabetically
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 2:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> For better readability, put all includes in alphabetical order.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/mtd/nand/raw/davinci_nand.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/d=
avinci_nand.c
> index 392678143a36..5510b39c0b98 100644
> --- a/drivers/mtd/nand/raw/davinci_nand.c
> +++ b/drivers/mtd/nand/raw/davinci_nand.c
> @@ -10,15 +10,15 @@
>   *   Dirk Behme <Dirk.Behme@gmail.com>
>   */
>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/err.h>
>  #include <linux/iopoll.h>
> -#include <linux/mtd/rawnand.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/slab.h>
> +#include <linux/mtd/rawnand.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
>
>  #define NRCSR_OFFSET           0x00
>  #define NANDFCR_OFFSET         0x60
> --
> 2.43.0
>

It's been two weeks so gentle ping.

Bart

