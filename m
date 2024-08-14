Return-Path: <linux-kernel+bounces-286352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A29519F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B6B22575
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB31AED49;
	Wed, 14 Aug 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSN26Vae"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECC1AED47
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635166; cv=none; b=K05fMxPHYPnz7wZpAI9kNLUpknTfc4O/T+5CatJ6RG6ixvRPbWxGazuBdxqKt+uw19nZWRmDTYvgqJyHD5k4h+HqVoONWfvhalaGyJtMTq5wihzOxkUqFscdGwM4FzcYGZLyxhFpCYnlFTHo4iqwJaqKyL2ypfzOJUS7z0YkmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635166; c=relaxed/simple;
	bh=Q6INoOsKAoKQ6mKNN8/pzE1KcZaYtIJB5EmRTEmk8yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXksOk7UR7MeD7VvHKFFAH2UA0JIGgCWRT9H2rD/6GMFWPKNy+sGAK4OVSHpqYd4jdV9IkQDHd5yBvkkocbdyEKgf+VLjSSZ2t/JKjOknKqiWGvhsCAm3/lV7V/ITUeXLHY9Y1x0JszroabwS84esfpKc3Jg31MmE5CKUilPEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSN26Vae; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0b9589a72dso5889984276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723635163; x=1724239963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6INoOsKAoKQ6mKNN8/pzE1KcZaYtIJB5EmRTEmk8yE=;
        b=eSN26VaenUq/NkOOnUsz/g47fJC0s4BHTtXg/e//KbTU9u7ubA2LdyONQ/AIgjjHW0
         h/Wn3Pn1WWL0dBmATGckzTLzKTV1gOu23Fz75zU0yiVVpXgaaNGFjMwAs415SXDBhGfn
         yrkD05WjIZ0I+gNDFeVmLMjHU6eYJk0KWxmKH7MAnu3i2gyOQNRcA1VVXJhyheLkixsv
         lIoBw6uLXxUFxZI4cfKVKJxpyVmwMYtDHPXIeRM2m//UabNQYY+nLBj9SEfnYGP9Qk/h
         C7K4/k2kiWbqowobY8NxZHnUEM1p5azlUzb0Ae9HP1iuhN4v4GfRAWbfkdxlOgaz2kzn
         fD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635163; x=1724239963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6INoOsKAoKQ6mKNN8/pzE1KcZaYtIJB5EmRTEmk8yE=;
        b=krbmNV4ymzvfyGyy6iZp2SLWTTo9YF08CZBwMoZn41y4rEIR3O+eLk9nwY2khz9v8O
         9NYBIsYFVLc0EqkpxSL/FoPWOOoVh3iERoY8M2Myd7bWFqNDMCup4HAwSxiKNXrNuyPS
         Yc5QJMOKzymv+raeeejaxniOoa6FlOmq+j2tW1ONiPpf83yPR3ERaxI5GaNQ/EmRkLNt
         K1Co4AQxwbrG4CvnFt1c1FpZmXhRuvUCMQTqBZPk3DL3g5QCaVBfxjJEDyBngN0FVBQ/
         z8P9GL5NcsWRr9Hai6WHm5DBb+S1BdwkCcdCq9vzIeNXZksmCjJmgo9vp5ZbW4aUe9o9
         s/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUFWS42Ht0nKNAQpoQhPq9zZ0Okx9i8oIa3q+BpkoYqFk/hj26AZ/+GQbqk/KzXq6ISY8mZvpiqa/KQRdt86wNAEQicKdYrZsfzgr4
X-Gm-Message-State: AOJu0YzFNkHL6hHNMucOteeSjUrlPUxRjBfL6aCvYfkzfx1JLiPYlVX5
	BqG+aWP8KruIkrNJRX9v1SSniR5DLm2q13kvi8zyFXZguSr0/bS3JLbG3qhZbP75UFuJOA0qIyA
	XOj09rCwXET7AwNva64IBrP+M497GjrxVpjuAxg==
X-Google-Smtp-Source: AGHT+IEVYMlVLZl1GJHYSgxm7olBwvP5eRzOw4TjS/5Exafj4XCBFHcDqZGPBvS0sv3Vrq+Nr2AT7fwfqo9yleqL0TM=
X-Received: by 2002:a25:bcc4:0:b0:e11:5f3c:1324 with SMTP id
 3f1490d57ef6-e115f3c18c5mr963371276.57.1723635163293; Wed, 14 Aug 2024
 04:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808042858.2768309-1-make24@iscas.ac.cn> <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
 <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com> <CAPDyKFqd=haDWB3tATZ_E1BMpCReNh=hLa5qPGATc3h1NUx09A@mail.gmail.com>
 <20240814105847.tise4jzneszdxetb@pengutronix.de>
In-Reply-To: <20240814105847.tise4jzneszdxetb@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 13:32:07 +0200
Message-ID: <CAPDyKFpcyP5t447twkKeRkyPQ-D3ucdOPLQ_kS4X7TJv2mR=4Q@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Ma Ke <make24@iscas.ac.cn>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Peng Fan <peng.fan@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Marek Vasut <marex@denx.de>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, imx@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 12:58, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 24-08-13, Ulf Hansson wrote:
> > On Thu, 8 Aug 2024 at 08:53, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Thu, Aug 8, 2024, at 08:12, Marco Felsch wrote:
> > > >
> > > > On 24-08-08, Ma Ke wrote:
> > > >> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> > > >> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev
> > > >> is either error or NULL.
> > > >>
> > > >> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> > > >> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> > > >> then used, which leads to NULL pointer dereference.
> > > >
> > > > Argh.. there are other users of this API getting this wrong too. This
> > > > make me wonder why dev_pm_domain_attach_by_name() return NULL instead of
> > > > the error code returned by of_property_match_string().
> > > >
> > > > IMHO to fix once and for all users we should fix the return code of
> > > > dev_pm_domain_attach_by_name().
> > >
> > > Agreed, in general any use of IS_ERR_OR_NULL() indicates that there
> > > is a bad API that should be fixed instead, and this is probably the
> > > case for genpd_dev_pm_attach_by_id().
> > >
> > > One common use that is widely accepted is returning NULL when
> > > a subsystem is completely disabled. In this case an IS_ERR()
> > > check returns false on a NULL pointer and the returned structure
> > > should be opaque so callers are unable to dereference that
> > > NULL pointer.
> > >
> > > genpd_dev_pm_attach_by_{id,name}() is documented to also return
> > > a NULL pointer when no PM domain is needed, but they return
> > > a normal 'struct device' that can easily be used in an unsafe
> > > way after checking for IS_ERR().
> > >
> > > Fortunately it seems that there are only a few callers at the
> > > moment, so coming up with a safer interface is still possible.
> >
> > I am not sure it's worth the effort, but I may be wrong.
> >
> > It's been a bit tricky to keep the interfaces above consistent with
> > the legacy interface (dev_pm_domain_attach()). Moreover, we need a way
> > to allow a PM domain to be optional. By returning NULL (or 0), we are
> > telling the consumer that there is no PM domain described that we can
> > attach the device to.
>
> Other subsystems like GPIO, regulator have a ..._optional API for this,
> could this be an option?

If we were in a position of re-implementing the interfaces from
scratch, then probably yes. At this point, I am not so sure the curns
to have it are worth the benefit.

Keep in mind that the legacy dev_pm_domain_attach() is already
optional and it's used by common bus level code.

Kind regards
Uffe

