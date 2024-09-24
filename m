Return-Path: <linux-kernel+bounces-337773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB5984EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB62FB22724
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D301865EC;
	Tue, 24 Sep 2024 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSX0DJj2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98E1862BD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219364; cv=none; b=cB4ZBPv7/ouORuXU1Samm7cKqszMWN+0CQlJpBAkoCPSIiu+y191GShPUE7fv9DbIAIQiixbclwKf7WYY6QOs5E2JL5Ayt0TjDkQulJrAVQlYeGutUQJ3Xw2M56uVzz81MKD3wXnlJK4YOq9tRBegR94YSDOX71r6troKJ2Y2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219364; c=relaxed/simple;
	bh=kowvC9R9jBTu45HuAqt64IesAQgR7/WalGu0h5+PXCM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f8RwuPZUDU3zVEoFXnB0pC1fxAN5xOlps/NEOw3AKL6fvrfqnbZ5G9RvYy1Df6NwPooMGPyPQMNWXCqvVrGBPxeBC951rJdnh6q6T0Zz/DCkqoyDYRXOMzPInmZxgCxxMtObccQbpj41gn++yHzfSqkOhxuO9Mgye0matFutNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSX0DJj2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso7823614a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727219361; x=1727824161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kowvC9R9jBTu45HuAqt64IesAQgR7/WalGu0h5+PXCM=;
        b=YSX0DJj2gxE+/xV9ModsnWmSjwct3OqnSnXdBKVwJzM8X1COeWGZgN8EN+cu3Fm6Yy
         4z7YT++yTAP/8eGRrC5yPMV1fr+9KoHvl+kUlEpg6bgnwRYY9NBzuPOEnrCcwVydlran
         RIuGiQ+0DwmBAghun/qb8qD+ETXKgxY+VjgDJQDgG7Tbl0zk+V1HCkpvkcFeykxRnQWZ
         pTgeTU8pHUkj9hTBt28k4g38W9OJsx4iM4VqnyYamQJHqTaIj7Gc+Fba2m8qFeVIHpdE
         ZvFmi0pKA4KITIhJupdktkel1lGkbfZGQpQXcfiRH2AbBWTduyoMI1Z2SCgriy0gychl
         ASaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219361; x=1727824161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kowvC9R9jBTu45HuAqt64IesAQgR7/WalGu0h5+PXCM=;
        b=VkfjChuWwJxLUtflWY1L6rjjIbHp1RrAVDpufe6q1mQelasIEe0vy7uhZJivURkzY+
         kY8jx1bx4LaQx/ntY+/frVfCs0aksVF2oDqBt+eGOemHb7joVABM3jsipR2IKoSoeYIG
         Dr4vdJXSxT+2J7Ogu7JwYfUoNws7EpTYr3ZkGffqRxq8bUBD3hwPS2BuGHwcUF1I61e0
         3Rse9COyW1tyVgrOuXF8P4/YUg6yHMWKYX7NY9YrJQyysMJ764vzmXcsbKyiRGgHMsTu
         Of8L/WzTHrF9RSjr6ErSCGFtIXkxQnkIpUOOvjUUAxyFDc8DNKTYYafm4hFTEZKb2aL3
         nUcg==
X-Forwarded-Encrypted: i=1; AJvYcCX4vi6jMDPHhkrxrtfHffW6IA5BoX84cib5+5LjXLaAPQalbg84TVGElGxZqASgc82V3hVxlNaQogCYOnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrwCvtZeJuvE6Rt4iJy2h/8/j41Yqllt+5qDVIP1Cr8d5u2la
	FIZW1GmbeYa3WuW8cZ0SAm0EWKkRiLH1nrLKtqbXhHndkkmtfbzs
X-Google-Smtp-Source: AGHT+IHuiaSDjdVX6F7MH936QQbsxEk978FDfJaEkC8FUk2CLXkE6N1gEN1JYlkhbmMB/VMGDZFIag==
X-Received: by 2002:a17:907:7b9f:b0:a8a:7027:c015 with SMTP id a640c23a62f3a-a93a0664dd9mr72255166b.56.1727219360517;
        Tue, 24 Sep 2024 16:09:20 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f51e73sm142199566b.72.2024.09.24.16.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:09:19 -0700 (PDT)
Message-ID: <d84eb269efa4b37a3dd3e0f61620df753c1c583f.camel@gmail.com>
Subject: Re: [PATCH 2/4] soc: marvell: rvu-pf: Add PF to AF mailbox
 communication support.
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com, 
	ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org, 
	nikita.shubin@maquefel.me, vkoul@kernel.org, cyy@cyyself.name, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com
Date: Wed, 25 Sep 2024 01:09:28 +0200
In-Reply-To: <20240920112318.2722488-3-agaur@marvell.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-3-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Anshumali,

thanks for explanation!

On Fri, 2024-09-20 at 16:53 +0530, Anshumali Gaur wrote:
> Resource provisioning for virtual functions (VFs) is done by RVU admin
> function (AF). RVU PF and AF shares a memory region which can be used
> for communication. This patch adds support for mailbox communication
> between PF and AF, notification of messages is via IRQs.
>=20
> Example mailbox messages types and structures can be found at
> drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>=20
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 263 +++++++++++++++++++++=
++-
> =C2=A0drivers/soc/marvell/rvu_gen_pf/gen_pf.h | 124 +++++++++++
> =C2=A02 files changed, 386 insertions(+), 1 deletion(-)

--=20
Alexander Sverdlin.


