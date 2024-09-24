Return-Path: <linux-kernel+bounces-336699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C41983F85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA3281084
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B71487FE;
	Tue, 24 Sep 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtuGKMV2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04E14830D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163794; cv=none; b=cZm4oXbPxPHp+qaSV3sOljbnFTS5a+io+hU0loh94FXhBkmfijijV0QWLqDscxr+IJPK0xZY3ufbwAgCf/MC6C+GN3A5Hjon0ujB0FlvqDR38ahiI3MrqAX6Z88mLeCJhMPfYidwgUyvMFJWND2I4CT01E7/y/ZOfD4yWrMgHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163794; c=relaxed/simple;
	bh=kjTCESWnozCNSO+5LxU4Dr2NZahYWHk5AXqlWRQen54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv3rJgKHqtXZPsi2/I1lXKeKrc+fPbuZD8ZvZtBButH4qoSgwa65YWIjU3l97kQyKHk8oO+Trb+rtV9KMyQ2uAe7FWrQ0UIo5FfGxREnOy0vmz1LRWe95dJ/lS2TaX85LzntHFfRnDCyTZxYbKRWdVUcX9hya8MVcXvVvcYbw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtuGKMV2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53659867cbdso7329402e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727163789; x=1727768589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4AE3wT085nmxLHX+pXqyuEkqB9MSe4BJ3vsxOltPm0=;
        b=AtuGKMV22o08HvhV00HTWp+aaMtEXvAXgvPSj3PSaY76YkJqhz+cSIZiDkrjEYdA9S
         0WzMM7FDs5QXaT0tuYDCpjSspkfxPR0BuNtOmKrL5zuOqRvzOmXggX961M6xL7r6K426
         nb1dGL276nTTvITh2U+eH/UY1xODD39wOoWRC71I+BX0TMP1oIV64uG+sUVnDHnZAU7I
         KZ1w+VbLtAqNk9SB5IYDtX8ZnoduDXFPVl3cjG7rLyT8/VSvCtw94j+pJQOm/ujZ0Qi8
         SOCBUwwCgi8f3vE/HTnbfWsR03KN6jQrFJ04zUPaYHrkXqVyhAp5t/Dihsl8Moyumsnt
         y+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163789; x=1727768589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4AE3wT085nmxLHX+pXqyuEkqB9MSe4BJ3vsxOltPm0=;
        b=EDAxpO8PN1DH77YRkRXjxZ+nwr0jOBsZk2uIsozwESxQcr7cheZuee1KqqfjKHcTri
         b2RoFoVF/VmLHY3rPTFfmsGkRw7Q7lozcWI8CtnM9AXmyBt++fzDw3GZa3Skey3/La5h
         SmG6u84iRTC07mNpydYwJoBzu4QDg/CFJ/lT0F9iDP1yPz/p5BgjChCGMatKcl84fqFJ
         5DUuVNKgFg7TJIy5ltj9sTVX7B0klUBGSow7hynefXCsQYH9j8Naqjgbx0g3B/lVN9tg
         ZuanQmNLnKOWDJmuPkmFH1+mUepNn/O05c+DfJkUYSZawWWqo7tZsZc+saQ/L74+D70E
         6jvg==
X-Forwarded-Encrypted: i=1; AJvYcCUEYayuneTq3Th0GUGOPH16B3jtVF81C5R4qlDk172IyQzm7SdXg+nEHwSXTufSW6WLtCJ/S+Wvb2x5MsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6Nv5MgI4tj21FyuyV7Bhs9m9cYmHYWA0ekTy7NUmbdVFqvlY
	0ebaW7dja3J4+9eLIO0ygi91cjSQ2mkLrzt2mb5Jox8sb5Y6059ensJhYfQ5vgOO72fWWitoxp+
	oGcPgRQNnsjN9FEsk8JfhwdvVUUfgyHEeiWQSDQ==
X-Google-Smtp-Source: AGHT+IGtM+ap0Bn1i9jACAwLBdGvwwbEYgZPkKvWofN4DPWUUPOGUFpOvQIXuOiqye/dyccJwkvrUhqRM2fBBjeGj6s=
X-Received: by 2002:a05:6512:31d5:b0:530:dfab:9315 with SMTP id
 2adb3069b0e04-536ac2d91bemr10172249e87.10.1727163789373; Tue, 24 Sep 2024
 00:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912142447.981590-1-quic_mojha@quicinc.com>
In-Reply-To: <20240912142447.981590-1-quic_mojha@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Sep 2024 09:42:58 +0200
Message-ID: <CACRpkdZxu34btYm-ibkgEqWfau97DjuKGib=-xd-WYL2PN_KYA@mail.gmail.com>
Subject: Re: [RFC PATCH] pinmux: Use sequential access to access desc->pinmux data
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:25=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:

> When two client of the same gpio call pinctrl_select_state() for the
> same functionality, we are seeing NULL pointer issue while accessing
> desc->mux_owner.

Uh-oh it looks like a very real issue, weird that we didn't run into
it earlier.

I guess we were not parallelizing probe so much in the past so it
didn't happen for that reason.

>         /* Set owner */
>         pindesc->pctldev =3D pctldev;
> +#ifdef CONFIG_PINMUX
> +       spin_lock_init(&pindesc->lock);
> +#endif

Can we rename it "mux_lock" so it is clear what it is locking?

> @@ -115,6 +115,7 @@ static int pin_request(struct pinctrl_dev *pctldev,
>         struct pin_desc *desc;
>         const struct pinmux_ops *ops =3D pctldev->desc->pmxops;
>         int status =3D -EINVAL;
> +       unsigned long flags;
>
>         desc =3D pin_desc_get(pctldev, pin);
>         if (desc =3D=3D NULL) {
> @@ -127,6 +128,7 @@ static int pin_request(struct pinctrl_dev *pctldev,
>         dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
>                 pin, desc->name, owner);
>
> +       spin_lock_irqsave(&desc->lock, flags);

Could you please rewrite all of these using scoped guards as that
avoids a lot of possible bugs?

#include <linux/cleanup.h>

guard(spinlock_irqsave)(&desc->mux_lock);

This means the lock will be released when you exit the
function .

tighter locks around a block of code are possible with:
scoped_guard(spinlock_irqsave, &desc->mux_lock) { ... }

It also removes the need to define a flags variable.

Yours,
Linus Walleij

