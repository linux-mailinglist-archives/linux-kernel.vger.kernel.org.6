Return-Path: <linux-kernel+bounces-344107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391998A48F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7871C23180
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1E18EFDD;
	Mon, 30 Sep 2024 13:18:15 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E018E36E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702294; cv=none; b=jCdoj4cMBcz7HXx0UViouKmoNwBAwycCMbljMtg0V5n9IQtCHRIrml4qirBPuOxSPi2neNn4r/NbxYPZ+Vprcd34yAAbmBw9ODfm05Sb/sbLGInIQK68FhpxQyH7dV/JZOL9NriCvKuBBxgF56cosLoiWnLWBj04gV7DGXuz630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702294; c=relaxed/simple;
	bh=RA3FrGcSK2Dezv8DbCVV2efyGj+oWdVTw3zrLwUPPN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdFrUpaD7zLHfPy5TkVhWQCWdmdXjCTjfBd+KknGsXAH5PMK/7mqZBSDFbu1RZ6CxOLruS2Ta+959MlRQ2VZNzlqDEeBl+fPr3RcrZTO9bogQEyz126Ep+cMemXSNatN9DRX1wE/zXKJYKSjAKwjpeHXjvdejRhL9v4BIu2n27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2772f7df9so6939547b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702291; x=1728307091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKc3+v82WABsD92X9n+GzoUuPAktk6484jDkPwKqaCw=;
        b=U26NYPoIeA2Z8aJLFU7fK5B2Au3vfhV9fvjxhA59Eqi6MokDgVRkXms4jkyzIoJAqY
         GgS73WY0Or/n6cJPwk8Sk8w3n6Q2eviCat4fVw54WxdFKZEupdBgEoI3myYQBVw13dro
         UNlTv4dNTjzS085aZ8GZyFcaHNau2JsnCYCTtyJXNeMiV5i0eY1fv3gXCFeFp008KN5p
         T6N4e/4GepcxPi0KNiyf8YsSIqCez+w4t3MAHYDxItSKxz5ggkTvaC3H6gAnmIp4fukk
         UOW9SxTN87g79qOx69kLkuUyboy0LkV/qFbrD0vfJcMjGulUBhFecobpWOPXErKM7NCa
         iYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD9DaSRKNdUOmFdniGNzizjpyua9khrYz5oWnRcfziyz4knJC8mYbHhfK+HWZZABXqhVNejNL4dcZPW14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pK1k+wu2ZyvkXCH86xXHM0xjMg+AfO+KKqCXIu61YyJchTGs
	NZ6yrMzPtmmKPbGIju4Tj7tFmMPCx6WXPvktG/CnJa5uN+z7B7MEDDXhN3Mu
X-Google-Smtp-Source: AGHT+IE5L/EMCcKbbvWpOtbhMWnl+8tcPXCBjazKzoVgUfiuuI5KkMrdgP71gyNY1nqCZWJCASV+lQ==
X-Received: by 2002:a05:690c:6e03:b0:6e2:83d:dfc9 with SMTP id 00721157ae682-6e2475fa478mr89915127b3.41.1727702291142;
        Mon, 30 Sep 2024 06:18:11 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24549d250sm13687727b3.131.2024.09.30.06.18.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 06:18:10 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dde476d3dfso34258237b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXltC4bltu22Zos+ELsL3pLmaHvWptkOx7sxAWJVriVWvBaZq4up0FWbFKsPizrtV3BnDG6Oie80iglFfY=@vger.kernel.org
X-Received: by 2002:a05:690c:4392:b0:6e2:43ea:55f with SMTP id
 00721157ae682-6e2475f8bf7mr58949287b3.38.1727702290598; Mon, 30 Sep 2024
 06:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918123150.1540161-8-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240918123150.1540161-8-u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 15:17:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKT=Z6m58RzPzGOr2HaNzYAY+qikDT+HXh_p5v5aOyWQ@mail.gmail.com>
Message-ID: <CAMuHMdWKT=Z6m58RzPzGOr2HaNzYAY+qikDT+HXh_p5v5aOyWQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Robin van der Gracht <robin@protonic.nl>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:32=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

