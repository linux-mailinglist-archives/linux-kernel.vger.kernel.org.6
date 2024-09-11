Return-Path: <linux-kernel+bounces-324926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B89752BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267201F241DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C718858A;
	Wed, 11 Sep 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz8Rupya"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8B24A08;
	Wed, 11 Sep 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058685; cv=none; b=UevM97EXOiAD4jq4zcA80Tv/mJADtYiRBed4/q3pCiQ+yfXX1sHmnBxZayGVua68bgPeXVAU7hYUHbrY/+phu9KKmTFkPHL1WKDHDskHZ4H3wiJeH39j76whqZfTrvnZDOfE6GjoBTiXB3mJ+X6/M6e/O9qdePBoBBgkXwsqJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058685; c=relaxed/simple;
	bh=wAqGuvvGqbO55Yo+QzEmp24+Ib/odfN2T/Btz5ueTHE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYpY+9QmFhJJGdgVbaBcrsMF/uP1TuV7IXBrNZ4ZC2APNO+ZrUtY9kGrvVB17ypuj2LxbvKqWHytRBFcJdyve5VBJKoVnegvWIiXCGmOhRu9GN2QvX3IUs6PUOj61WCPS7wdG1QIim1eR/YCJo9ph7ndCMWX3oMZKljeUiVrwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz8Rupya; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso34848715e9.2;
        Wed, 11 Sep 2024 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726058682; x=1726663482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZwLFQBJrbFbsqZC7edL4g6mJGq/UozkTcAaIn3Kphw=;
        b=hz8RupyagbGerRcv8a1UuEaS8Hs8aUknvaqRHTNvNPVI7vo9GY3p/89GmUlmxl2POv
         xmMgzAkYkutAqlBUcYo1nXONniTkYF5et0W2BvOIjCxzRLCS6Igaz0qj9iBHWcf9faeq
         4JZkXj4W9PCgZIdzJlZEMFjk75voDVBZ2WUmNhV7dbLL7T1owr5McXnhR8wzWiyJEioe
         SZzTt+EvKSp+A0p7OkVB7lQ834PebM+nOI74AhgQVexFo2GGpuo4tyvHn/gjXYHu3LUE
         YoHY4rbLOX5dXO4qgsPKcShVVtaNMHG8ZyVBjuzaHg/LuizxxBEHZriSlOQtyi/aHhd7
         YHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726058682; x=1726663482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZwLFQBJrbFbsqZC7edL4g6mJGq/UozkTcAaIn3Kphw=;
        b=iRXouQbJ0aR0K5FPgyc/4axgPT0mjQ+GWoLhHbOOd5AtvskNTTSKo3QjitMOOUakTD
         QQGs5qeOjndf/3M4dsurHPEWOmLw/1O9Mz7BP4hXjHJlKqT+KRXj7dMkbqnvvUmHkUoM
         C7FM2T/MNiCut7EfiLEsCVLY3PCsblX1S/IttawhmgEjTzm11nCbrydgro1tJJYRUnLI
         jgBkluvzRUC2vD/cRJoEuSgpntH5D5NBkP7TMdIeDeBewQCzu/3AdecRMZPpzDW0a+Kb
         5323zO5dG2CGtHW2Pdubby53xcnbsPW9IFJpELVrVFTg25Wbh9dtOGirI1FTOxMaUfiR
         h4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaDhCdF9WnCPlxWmg/WnP6dgoUNxBPkryzUKEiKXgFepNRynP2IOISE5CX3Z9u/rz40LdGhjsuw8NGHWwP@vger.kernel.org, AJvYcCXNu4pTqvxgQ94gUKBH9TQWgXhHtGcsQOMxZQgWMZ/96pGoUvVq3tfQ9i91lk2W0BklJz9KoIXvXPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WuVUw9F3L8XXSvsvkniVje4IYiIN0U7AfJSKCrrMbTVeQFdV
	x6D3oKqTvBkooVnXMAiOmnFROlP3y4kj8n/AEmUioxpfD2BgyRj0AubyQXGc
X-Google-Smtp-Source: AGHT+IG0IgCJfySwnQ347sCXytkzXb5iTo/AY9vI25hVLlgnZ3SiDgOdJp9TnKw+Op+rExODDzRYww==
X-Received: by 2002:adf:f6c1:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-378895c27a0mr10715747f8f.10.1726058681807;
        Wed, 11 Sep 2024 05:44:41 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665108sm11472019f8f.28.2024.09.11.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:44:41 -0700 (PDT)
Message-ID: <11d30fc473e6581bfcaa91d13ee5b5827c2801e9.camel@gmail.com>
Subject: Re: [PATCH] clk: ep93xx: add module license
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nikita Shubin
 <nikita.shubin@maquefel.me>,  linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Sep 2024 14:44:49 +0200
In-Reply-To: <20240911121909.2505018-1-arnd@kernel.org>
References: <20240911121909.2505018-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnd!

On Wed, 2024-09-11 at 12:18 +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When configured as a lodable module, this driver produces
> a build time warning:
>=20
> ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/clk-ep93xx.o
>=20
> All all three tags for license, author and description based
> on the header.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/clk/clk-ep93xx.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> I had to add this to get a clean build with the ep93xx
> series.
>=20
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> index 4727c06a59ba..26317623d9d5 100644
> --- a/drivers/clk/clk-ep93xx.c
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -844,3 +844,7 @@ static struct auxiliary_driver ep93xx_clk_driver =3D =
{
> =C2=A0	.id_table	=3D ep93xx_clk_ids,
> =C2=A0};
> =C2=A0module_auxiliary_driver(ep93xx_clk_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nikita Shubin <nikita.shubin@maquefel.me>");
> +MODULE_DESCRIPTION("Clock control for Cirrus EP93xx chips");

--=20
Alexander Sverdlin.


