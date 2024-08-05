Return-Path: <linux-kernel+bounces-274345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3660947706
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE932281241
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D4143738;
	Mon,  5 Aug 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDIgjAjy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BD2A8FE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845769; cv=none; b=XylGJBp8bv5PbhUFX1VVjfkRIfLx8HX9+9iArM4t5YrBGvUcTV25a2/GEQyFkhKFjC1R/jaauneOlZSG/Pie3FGTMiCKSEe7+hNIlHR29MOVDr1MlDH6x6+shAzrkJdxsAHMLnK75xvO9nM239EsO//3ZOHFTknstYZOgufTXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845769; c=relaxed/simple;
	bh=s0l4BMr1B1oQ2wxQZMWmEy5Qxbcv4jHmonN6e/ZZ7AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5Fl0HjsGRqwpaWZSthvDQddSQhAtKe7ir39jqVJ2BtMV/NwfUbQlSu09NcBuoJ2+QCqPdTkV2l+DiQj2bmfIC1Y7q0kSfqriqx1q5ULoY/nbFjoNG5mT1Qv9Eh0y2m8jYsocLTXl6DkN0aDJDNwR/5STIpju/J0gOGiiiGlAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yDIgjAjy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc14d6689so9986254e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722845766; x=1723450566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0l4BMr1B1oQ2wxQZMWmEy5Qxbcv4jHmonN6e/ZZ7AY=;
        b=yDIgjAjy2jskhaKJnwLbZya2F7nWUrMUEgiw4WPSAheYOhzlDdQ74/Ray9LU0urbR0
         L77Mlj/pjBYNE3Rj5Czj4vnBZZMGPdFOO1Pw5OZV1SviknB1yQhvucpGd3tho9kfqlEz
         1t3Ql+yG+mzwCH/ni8/BX6eOZ19fMrpAjOgGEexZg77ZTu/aKlFry/MlBb0BVBXhm8C+
         sm8AZCiGdB1z6v8CMPbjwJrPvR+J2nBQvXTxZvtx/CxB9nIPOZ7d5j06ZR3buMm4QxlL
         xl4k1kf+3E/VRFnQuQ3bDdW2pMroX6MbFLn573CNqj/Pb2HStWsgcDqw7RcA4/GUv1GW
         Cdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845766; x=1723450566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0l4BMr1B1oQ2wxQZMWmEy5Qxbcv4jHmonN6e/ZZ7AY=;
        b=RRxsbOvMLGYcWahLIrFJ0lHjUrnawKLnyM/qbtaf642G8/KcFqwIiv+O5tfrOIwTqR
         qW9ViffQa4JA7abRUlzH9WW0WCQza0qcgYlv++zK0ZtNcHPLdxS65UsmUg0EVMN2JEbU
         wzekmnAaM/zFBq067R8SQTK0O2BJsgW9QOxP7IeXZQCXIr67L02tnVcA1NnrwDUQzi8T
         0LhiWfHKQpOTL19npaYTI6HbJLrVA3kTUQu+xCectamzVu9o0ZltwanHwktT540ZoSFv
         Bjfilbj0ZLvNyfYo+RpTmA8jdspbklWBOGxn5avfOwvRB7ztRLHYuabgZwliKofZXNQx
         Q/hQ==
X-Gm-Message-State: AOJu0YyQc97ryKfdVwJgOlPrLeXtJp6ASlkHYseZ357PgHoQuMKpCSZo
	/Q4/A3dgxiQ/e6biU5HVKpBflLVp3Qx2cTfZddhOUGCdfeXVqbTH6q5oYVs1Q5dmRYLZCv/4i/f
	AzGiJxtx/0T17MVegam5j8HadHr7tqPPn+WHOsA==
X-Google-Smtp-Source: AGHT+IGUexCj6VshdbtjSrODpd0QaUTYrmwGB1cyypCiKha5sXzPdSUyZ0My5KvmjU1qwV/Qlke5GN0U/8cR6eEqqxQ=
X-Received: by 2002:a05:6512:3e7:b0:530:c212:4a5a with SMTP id
 2adb3069b0e04-530c2124e52mr4492808e87.22.1722845765730; Mon, 05 Aug 2024
 01:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrAZ2cUow_z838tp@google.com>
In-Reply-To: <ZrAZ2cUow_z838tp@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 10:15:54 +0200
Message-ID: <CACRpkdatVEunoi=Erm9jYpBxKv+yMpjFUJGck+dd-VRbTJEz=A@mail.gmail.com>
Subject: Re: [PATCH] Input: cyttsp4 - remove driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:16=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The cyttsp4 touchscreen driver was contributed in 2013 and since then
> has seen no updates. The driver uses platform data (no device tree
> support) and there are no users of it in the mainline kernel. There were
> occasional fixes to it for issues either found by static code analysis
> tools or via visual inspection, but otherwise the driver is completely
> untested.
>
> Remove the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

