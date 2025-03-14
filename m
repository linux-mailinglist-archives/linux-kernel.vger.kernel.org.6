Return-Path: <linux-kernel+bounces-561238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5BA60F16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A623BBE9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6A1F462A;
	Fri, 14 Mar 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omDiJGhD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157913C3F6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948561; cv=none; b=ogPzNlVLjvCdv6l+eAKBBgH56IpPrakXIb3oz+F/70VO5qEWMUk/a6OasLFlu6ZA2L1NOZm9MHuSHJgxrViyHU6ta891ci32ot23lXQwJmq5Y1cHiccQgM0CF1SSCfRkL3cHPSMGM5B8ds/HaQ7n5VqvZyLXVU8uVTJ23uDQlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948561; c=relaxed/simple;
	bh=oNB6/brWRYGDcdPEdCxCrOD4XLyJDxlEhSU5P3Fiuf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmTLFGA/bivRQMRxJ1t95OZgk3s/+RVTm5j1/iepmJs/BgPT2jAYp3+Fa/zuUOqlDO8ajx5zldv+MuErjMVisIILnBoiUzQzr/pfFfyAhCzoFNjl1aCsWlgt7ulOsnk8keLnYeaK1FhGyNJxtSbdfLpO+lMC7ON95fejfvilTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omDiJGhD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543d8badc30so2235897e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948558; x=1742553358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBq11ylwu5R382gZxqzXZy+KZY3NpzkBPWG/tVivh9M=;
        b=omDiJGhDxS3+hUgKz1Y1jnh68d8j7Ok/WVf+jrxI8Ejn8Yip4r5u01KlomR63wMrOD
         pJT0cu5XpUWXcmotKerqrpMkYZwkjmD3nqb1tNPPasnPjTUmYKDMhtQ5Ov+Ay4ETGTEr
         cAHuDPoM3vwxx5nOC69sR8qf8fex88zpMk3765hQnpsjNqqI7FtYzuIk54SwWtOj+tAP
         fXGoulDMTPdlvoe6WCIwA1NWxgLjgXM8OQ86jdbGaAKiNrLvNI1iuxg0s19Vkrc54mQY
         vFT3Tag2hNGU2pKnt9jE8TbZbWpRu+LuXspJ1N1NNBK6In2S4uX3L9UbMYSiimQ7Hf8f
         ppXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948558; x=1742553358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBq11ylwu5R382gZxqzXZy+KZY3NpzkBPWG/tVivh9M=;
        b=h3czzE+aH+n2i1IE4C+EWkeLnBQXkItdVYDoA3GmatxTgqtPbBZQkDNVh0woJWvo9O
         7cAmO/FoFZ5ldDt4NYmm9fPiCcI8LhAMp2Ly76/WtF4+xF7BraQKkhOVh3/R63I6iZjv
         1aXnA6Ad/by9lD0G4DSszuz4LTpMXLksNSmxkBSLgxJpNYb6m6WMDaNe1Djqu9ZNsTTW
         ScYvCppali4XcftYkHCaKEL4Qm/SIeWKIioz090VBufLR8FJKcX2SHSvFRL6sHGkmesN
         itxkiSMpOF44hTtlLweevssY33uEn55ktA2CVg0o5NrIdyoUnVlZTyRjSay6qXMU8nxt
         ue7w==
X-Forwarded-Encrypted: i=1; AJvYcCXmpA5QdWB4tiBnfjYUSGFAxjySs5bxG2wTHgf8xVmdnLG6KmNY40n7eXEwEsMt1ypdWRonoteQehldyJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgutV36e8oVP1oAICIon8K6zomrblX2Sy5oRExPFq8/MhyplG
	YYShGWLqyVgardfXwQm1WnJpvxyd+nqbD43HcKpdF52w/3kPpMQ6h9Qxv7MekGZ6yu3SJbZHrJy
	/QrnWZKkJ0jaebYXEnBN/STuZKP9XdFQwBHWqMA==
X-Gm-Gg: ASbGncujxlKB+1r58FpJu3o/UXvo39HFpcVuVc3eMH7xV6Xebay7iYXjBJqMdSlQogy
	HLLjWkRKFWIlSDkojyVW7fmUHXmQS+MGN66Ekwxin+XBVF7yxi/jVDv/D8+mDkbw1QaTirwfBmL
	sXA1Azj3d4lpdycp0WyIsn1oU=
X-Google-Smtp-Source: AGHT+IFo7a8aP8LrtXsMzS05IJF+N+ZjJx5DRyPZKzboYtcGh7BYc7nkwi3Kg4DoP3cYib1OWjtVARzILEhT3JyV8rs=
X-Received: by 2002:a05:6512:2350:b0:545:2b24:c714 with SMTP id
 2adb3069b0e04-549c3911e6bmr755718e87.18.1741948557930; Fri, 14 Mar 2025
 03:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dfc15d59-7fa9-4f96-aacb-37c3df6d420d@stanley.mountain>
In-Reply-To: <dfc15d59-7fa9-4f96-aacb-37c3df6d420d@stanley.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:35:45 +0100
X-Gm-Features: AQ5f1JpewYNdVReOE7yOz7Jhb_-0BXB-6RAsfqpo9dfZwpZcAV2B4PUacGG94IY
Message-ID: <CACRpkdYkvTr9ijyEVSzevHdHFDb0iJTOzCS_3gQG0eNcpR7tcw@mail.gmail.com>
Subject: Re: [PATCH next] pinctrl: bcm281xx: Add missing assignment in bcm21664_pinctrl_lock_all()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Artur Weber <aweber.kernel@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-gpio@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:48=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:

> The next line checks if this regmap_write() failed, but it doesn't
> work because the assignment was accidentally left out.  Add the
> assignment.
>
> Fixes: 60d69769c851 ("pinctrl: bcm281xx: Add support for BCM21664 pinmux"=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied!

Yours,
Linus Walleij

