Return-Path: <linux-kernel+bounces-347649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70998D8B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7642F283DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05B1D26E2;
	Wed,  2 Oct 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7FoxIkh"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502D1D2706
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877608; cv=none; b=DVZXwJNcj5xN8nf/xqTSTCtP0udSEYt3du0QIQH7D/15x2Eik4x/jxBoc4IpRWQpqFMW7tR9AENutWH1nf9s8kmTEBSTDA5kibcTqURAhyvA2jvEbNz9efjDVVMDwt+3iVyimNmTPdI0Yj2SopOwooNNwKE31sFcRiCPQ5Ww/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877608; c=relaxed/simple;
	bh=IAfOxs+MmT/GnEakCW2nbON7Y/GmcDUpYfP7wK60w48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEAuRL9uc3qsW7DT8zbNsRKWmN5CCLFbONsat1/wctNi+gGumljqIhsrzhdsi6+hRIp9ordJsnDko8V0aQD985C7SDGcHjhsk52Oe1lf6Qo9y9FQv/ml7miEafJl5MKu3c6fYw52P/JileKHKNE4cEHio3SbjeBNtoArqCltaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7FoxIkh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so45370071fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727877604; x=1728482404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAfOxs+MmT/GnEakCW2nbON7Y/GmcDUpYfP7wK60w48=;
        b=r7FoxIkh1N0aMKg1mxNgfRkvsb66Uscruxz421Sz7m1pE6B1qh9AvmM+0SQ2AGcK7g
         AZk+54AISYTB3jzhhd3voXSHg0zBdmwnM00jHKNfdAr0UNFwxoPtjr2DbYB4GRPEd6Mk
         zEsIWlYXvL+GxMehIBMvyKHf2fv7epGyNIOmPXiL8aeSiKeLo1TyfxBwWSameYfx9FaI
         A+qElqpoH/oYsZzZCJvZyp1GZbNs49zU1CCfEAC8X7zx3OfWbaoPhAoT1cugNzW6T+w1
         5EAMSeK9crA7x1e8BEYhW++8uJAumKTWpQIck/IHxROYJ3Kh4kb04M4pXVHnOLImcCbt
         dcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877604; x=1728482404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAfOxs+MmT/GnEakCW2nbON7Y/GmcDUpYfP7wK60w48=;
        b=mAKF/pPaQ/2PPDvZeipOzPcv2hWkWW5G5QeCeKXu9vSELrZIpsVsYDaRU4vyt8MZ+h
         A9diADDdF+Mcnwdfbegm/tkB/GPcLzMvaPsuoqpOF9QdUpUYZx1h5ic+x3pMQf86iid0
         eCyLa2+zeT/F7hKhhLkdaWyYTuWUbYiklqjDBoWi/nffh5YApJR7Zu6UDAvIzeDWjzQJ
         SE3i/vucF/qP9EyK0tFVSUEf2Wr+Kj2pObmWOqN0+yHj7gLJb991Q7J40DHkVUSXlAyd
         Ev6R0LLNvgUVzplWhzgT+uMw3gEd/4Y5N52sQ9lkEhnzQ7pDTG4k7ezLhHjuGF/pZsc6
         svAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1RyCL67yEV4s2+UpssDMT3HzCwd5nxL+oTcFhJrUub4Gr5moFytpGqhfVOvTl992GU2TwJuyfI2MFlRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VLL3zplsHFqe1tveLt5AkavlCstPHSGGViez295lzlSF4/8G
	hQBf9m/WgCcyHoWof8GJqVKLiOIEvW/tZm2fZYsnawY7/waJduLfDLGYo5ethtMcHFAo9btPUxk
	V9FKH19obssEhVDwuBlH2hhpA/4h1l949X5TIOA==
X-Google-Smtp-Source: AGHT+IGKpyD86o51/mH1jmT3XyTXXQ04eUmkZrdRnPAbt4xNVnFa0ctf59clyoNk8jd6v51p1J6gAo/K0SkEmpgV3uY=
X-Received: by 2002:a05:6512:224a:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-539a0677474mr2946120e87.25.1727877604149; Wed, 02 Oct 2024
 07:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001221931.9309-1-ansuelsmth@gmail.com> <20241001221931.9309-5-ansuelsmth@gmail.com>
In-Reply-To: <20241001221931.9309-5-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:59:53 +0200
Message-ID: <CACRpkdarPcHnZOrhq1r+-DyWbGWL00tPjLohEac+tZZu_f=Uow@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mmc: block: attach partitions fwnode if found in mmc-card
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	INAGAKI Hiroshi <musashino.open@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Riyan Dhiman <riyandhiman14@gmail.com>, Jorge Ramirez-Ortiz <jorge@foundries.io>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Li Zhijian <lizhijian@fujitsu.com>, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:

> Attach partitions fwnode if found in mmc-card and register disk with it.
>
> This permits block partition to reference the node and register a
> partition table defined in DT for the special case for embedded device
> that doesn't have a partition table flashed but have an hardcoded
> partition table passed from the system.
>
> JEDEC BOOT partition boot0/boot1 are supported but in DT we refer with
> the JEDEC name of boot1 and boot2 to better adhere to documentation.
>
> Also JEDEC GP partition gp0/1/2/3 are supported but in DT we refer with
> the JEDEC name of gp1/2/3/4 to better adhere to documentration.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

This looks very useful and avoids a lot of out-of-tree hacks.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

