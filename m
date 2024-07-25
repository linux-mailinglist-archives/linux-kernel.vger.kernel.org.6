Return-Path: <linux-kernel+bounces-261626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40E93BA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5ED1F23029
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B763D0;
	Thu, 25 Jul 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lS3IR5Hq"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE832599
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869584; cv=none; b=AnGPS6knkZNUAlqqxSmJ7p6nbPEGFM1uSm49dniPylCYV3Q3jacscw+M0MRVk2pHuxil35cuQ86RtzpCtWTjeZu9VqIJfvQi+AEkFAevU6c6/vbZeK/Pkuomo2T++VBWXSDTcJcyDZ8dYPn6FKfEcG8/em25Z7O037v2QigWGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869584; c=relaxed/simple;
	bh=TB3Hm6XGbDPgJII4XztCnvOepjpz+iOC6LrCU/y/ZPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAc2OMkdJIfo8/b6+kBEGTjWOZ9oVMGTaZiXtBhsMFQ/WScRD0g1ISpZFyNij6H4XbkZwsyBYDuS21qXY1l3wQyiRjFBl0TwtxuTiBKFrMmiGeUiPEZmLPmdpmpmOXaoreJiic/oJxayrGJpERl1W9wCnRqkjwadQ9Y7WpG9VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lS3IR5Hq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b29539d86so3899217b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721869582; x=1722474382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB3Hm6XGbDPgJII4XztCnvOepjpz+iOC6LrCU/y/ZPM=;
        b=lS3IR5HqhWfIYa++7rheKl0hzgWUpgEDVF9gecKmvuauZBqQlpkcFMqtuH3NSyJIsX
         JsPl0P8ruIa+BBF0MKwAQWU1P8qG/d02hP07tNVf+sxTDG2n6z53OnN/GX2WYd7FA62J
         KWosg+nCObovqeRDgzDGCQrfW4gc/evvPEj4HuT45nQyxoHOHEcatXqS8jgT7NrvlVUF
         yncoQih/nKl/O9hBRUNu/p37oiZwotrnJY5+6zGE+yWO/+/ji69O2R0vwJmCElSMFGCE
         SgEYqdto1VJS6CEOVebbGCYpygqzM0NDUBO5SO0YIjWXfRs0p7eNb65l7RBKCXIoWAKk
         XIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721869582; x=1722474382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB3Hm6XGbDPgJII4XztCnvOepjpz+iOC6LrCU/y/ZPM=;
        b=dEWNSl71Qv9sE3jjLo0b0j8yvt0zN73UR2jkM4iwtJ4uqgvcqnuRObCipsK2ctEBFD
         oidqmw8UQ5l8JJKixeuGkA2LnHGYB5kQw5FA0+I/V5yDlLqDkNYuKxPpflRsYidlSWCr
         5dA4CazbP4QJ2aOCN28zTdumvOJUzweJkdue1NIjhc78aTA6LdRrOaJb63nTNPQYUdfy
         vJF/xrESif25PghkpMFooEtEgoZKLNP92D+ulIbhFoUlG+enSZorMmh6n1rJ5izm8TIn
         an4y/mTl98Sga9aMXI+YXITIopyaIanyTDzjTytNhk7m7p2wndHjWcRwd7g5zCTABeSn
         3Kjg==
X-Forwarded-Encrypted: i=1; AJvYcCVcW6o+KKjVofNwLc3yqOmfkd/D5U7JjIfkJi1zmX50zIhEa5DRSKQOcig7vxQGoaOVHPzSzyMKeq1SZjV63uEeKV1j95z1FrvvGb6N
X-Gm-Message-State: AOJu0YyhSM41LfPdHT6ZbUjFWchKI/zmHhIb5Wq7lNAjrddtVrtIV/gu
	eVAO7yrPHHsrCav1QiJZ60g+kcRYElIAFwbe9Cbk6ofLr30sEmn/Lr4MAzjC3Qbv1zZ5z31bVrE
	ONzbczArUJPzNU6Q5nwRlJ7LAC8xmieMMS0XOrA==
X-Google-Smtp-Source: AGHT+IEOV7O5I0pX0ll/iJ+MoyJB63BQHQXFPzbiOz03qd8h58aQ5h7oPXvbm2HxBtsw/y3yAhYUHuLdyclrxpZ+OBY=
X-Received: by 2002:a0d:e306:0:b0:618:2381:2404 with SMTP id
 00721157ae682-675b8336633mr3139137b3.44.1721869581819; Wed, 24 Jul 2024
 18:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724153125eucas1p26cded41c82d3a851a7a4d845a81a3e29@eucas1p2.samsung.com>
 <CAPLW+4nYfVytXnpDs02QQGms59dL+=pAv7NMNPK6Ymsemmi_cw@mail.gmail.com> <20240724153118.914714-1-m.majewski2@samsung.com>
In-Reply-To: <20240724153118.914714-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jul 2024 20:06:10 -0500
Message-ID: <CAPLW+4mg6XG=NzpKZ-j4L_djpYgaRv3rWJh5=ny3me3bngsLxg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add initial Exynos 850 support to the thermal driver
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:31=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> > Btw, I'm
> > curious what is the reason for implementing TMU? Do you have some use
> > cases where it's needed?
>
> Not really AFAIK? Mostly because we have the hardware, are familiar with
> this driver, and have some time to do this :)

No complaints from my side! Wish more folks were working on this
platform :) Please let me know if I can assist you in any way. Hope in
v2 you can account for the TMU clock I enabled in [1], and test it.

Thanks!

[1] https://lore.kernel.org/linux-samsung-soc/20240723163311.28654-1-semen.=
protsenko@linaro.org/

