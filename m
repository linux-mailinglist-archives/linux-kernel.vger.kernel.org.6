Return-Path: <linux-kernel+bounces-436459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368999E8619
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F3E164844
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC91581E0;
	Sun,  8 Dec 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfHa6MCA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B614F9FF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673334; cv=none; b=KfH4JJziQ7KaqAc5cvA9P9yixAPkeoGxNPaNXC/yy+F1+dXnCrP16GelrGwup/pKAtGwLf9WOcebdxq0Bq8gDM+Kn+6KXDg5XsdwHtZdTdSl7MQQYInzj6YOwZ2guoVhhiDy60CotfjlNxGdelBayfsEk+S+9SQ/Etq9fDP3wxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673334; c=relaxed/simple;
	bh=VOJBXBT9KHP6qO77x8aTnN+lP+X2U3kOYe5lpVyrkg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2Syt8tJ2iHm+kG88beIiO63IWIu2pyRfTBp7oqwnP7KU+VkfaZ0L6906MLde3V5O7TjUc2K88VJJZs/ZIL0uKREe2700HBRIYNb1wAgTFoU7kEhglWFn7qPHgHbNyqFrUXuuQ8CltgBf3HPJy9Jo1bIZLDg3yd2o2AOb33CFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfHa6MCA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa650ccbe0eso202576166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733673331; x=1734278131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOJBXBT9KHP6qO77x8aTnN+lP+X2U3kOYe5lpVyrkg0=;
        b=RfHa6MCA5kb8/JkTonLPvs6eqMUKCrXZZUyt4Ub97Q/OB2+1ZrfSif/oxk7tchrUmV
         b9IEyBRuKUiSS0GG5OywfJize/Kru1g5wMdQOpxB96Oj8bOyW9QW+cB6iX/1pmgPhpa5
         U6OICEMS2X9SF8jl6gx8k38oxJPQ7xHCNJAK3RB4qiG2yFC5/J130f2EVWNw97L5I0sQ
         eJ191+1jtseJaOinzds4fDs8vJUwfN34rICD3vv1pqVhFGAqn9OtErXxUK5UNWx2YBYG
         4UWi3ZA8JyW7v62l0UmHD/JH96Y5mOvT1YMaS3ElipRCRsLkbvmsWIpNObso9p3cjPQh
         uLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673331; x=1734278131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOJBXBT9KHP6qO77x8aTnN+lP+X2U3kOYe5lpVyrkg0=;
        b=V0e58km7XWdRG6Xb2bH3Bb+rF2TFHvpih93XxqoLeFR/DXtSEkIJ4tNSX9VYr2B6Ie
         hN0PCNrqzEpnLyoxU61Ae3Y6H5dAxG0dI8GmD9E15t7A0V9hPsrH6mgr3tSSd/MjlsRD
         6L1SDtBju9pAo9AaMjIegxduY/0vwLHy2TP2ootWuELTk7mRl0/y8jIOly9XBGbMmMse
         xOF9wNe6PwR1OYf464mD3eRpAAXl91oV9qIMDKtxkjy7QAg/m6oDjc/xi0Ct/roKx7Fa
         rbKZgMOdx1v0pubSpBHnQncjB0F51gZs8yOF/BDwiLEd5fblSbvz2fPEJc/5oeGrS50x
         9D+g==
X-Forwarded-Encrypted: i=1; AJvYcCW+fVGyz2BGbqOYFWGQponDQ2E9KwfIgtbrxREHHIryRN+swZkB5iSzzaQ3CbY7Z3wfQsssyzWyHfoGXxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLRTyCxoUqNmifRwrkVTfJ4bR2ctITC0+w9cQLDt1PgA1No8U
	wChA6pCIBK3BXzBkgSeT6E/kYn/WqLpoDtdjZm19lv1F5eI2hkLRKj9rzax/oXTjpWa6qqV1rFn
	uqTlVQc2WOgwyDi8ClNjE2Sq0dDo=
X-Gm-Gg: ASbGnctaei0mu7itFmaROIzTi1By800/Mxu5TkOwAdevbcm/2wweol5xgEl9Aie5Z3X
	CdYAJcV50FO2z6q5oNmqhAgkFEaCs6/M=
X-Google-Smtp-Source: AGHT+IHaHReW6obouKTepWbLjlODk30vepCGJfn0QbNJ/om7EpgYxwGWH2WsfMEkpffh94gUB0TVkv4zRUwNpV3OXDw=
X-Received: by 2002:a17:906:30db:b0:aa6:61bb:17df with SMTP id
 a640c23a62f3a-aa661bb1953mr358459366b.49.1733673330984; Sun, 08 Dec 2024
 07:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208150028.325349-1-hdegoede@redhat.com>
In-Reply-To: <20241208150028.325349-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Dec 2024 17:54:54 +0200
Message-ID: <CAHp75VeoRh+SM_vr=KSf-JR5simc9PR=eUjHMAZXmzxLEYmw1w@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: intel_soc_pmic_chtdc_ti: Fix invalid
 regmap-config max_register value
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 5:00=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> The max_register =3D 128 setting in the regmap config is not valid.
>
> The Intel Dollar Cove TI PMIC has an eeprom unlock register at address 0x=
88
> and a number of EEPROM registers at 0xF?. Increase max_register to 0xff s=
o
> that these registers can be accessed.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

