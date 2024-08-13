Return-Path: <linux-kernel+bounces-284555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19F95025E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E24B2427C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5491D18B480;
	Tue, 13 Aug 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBBK4K5g"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161B18991F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544618; cv=none; b=C5yy/lc2ch2VgM6xI11yBDzZdnlPJ0XCMDg8g+B5s2xedKNej4GmjPiml+zkhkwJAYKDs2pXwyxi2kchgIqD2fzmkyYkmG2VZsfDXFW2CnBOnJwyErA/INqvj4vlrTi1AotC09NJgErzppn/OqyB7yaCQVu++yrZ6Wb2pUeRoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544618; c=relaxed/simple;
	bh=SXR+0wrp3jkLlL1M88GGnn0JcEZQsqknpxVcuv87DLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCzY+JjZwForLL84NUfrJal+N+TbtKx30/zAe2LGUYF4ZtCYHj4PLlZNBm1gNdVYLglOgKAfUBPA3DBUivzxDq0LNRCbXK0y0SRkoTwki5S3weNU/eG8hD5ENmLfrx1kIS1XoM0ZAeqI9rGkOybjOcPzA4eh2E8nVrn/iFH3hLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBBK4K5g; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so70303191fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723544615; x=1724149415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXR+0wrp3jkLlL1M88GGnn0JcEZQsqknpxVcuv87DLY=;
        b=dBBK4K5g8k1eR7DQ4hb/bw7LRTFX8j58dnWblOgS2wakpblKBoLLQe5j6AffYfQVxK
         8uIQJERXlfQKERWoig1l1qUqEsHdrA2Us2qKmX55XN16W+Pe2D5aQe58jVQDo9NhQ118
         fpsQl3/kFvV9PbhRag1srK+9lBxjtklkm6jCSbGkU/XPRF6sHERyt0lWgh2aEwXcvfEf
         hK2+QB/FXdnSn3G6tOfV/Zgqcn5CF7aYJx1GTdpz3YE2EibR9aWHsBecezHwLrAQ3xq7
         Qtcy7R5Ycf79Z3irqtCYBxQXGBBeqkXGgvCmxvVd2BaVRBm1f5md0sGv4SfQg+1pt0PY
         iXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544615; x=1724149415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXR+0wrp3jkLlL1M88GGnn0JcEZQsqknpxVcuv87DLY=;
        b=wB14PlEga+dRkPQ/Hkx2oTrhzEvv5/HVhQkYXLeON1mc8IuzpD1cTJYmc+Q6AMU6I8
         IjI+7YQATdsroAgEoMfq5Aglz/KYToRPj6oZyYxoOn7cqvgBpAquHdFA/XosW0P1e+Ck
         MdgFlZn/oc1ONBfEFjpJMpe7xnonlrH6unZL2YL5TufvjSrOhYMi8D4hlitF9pN/tX42
         zQHeNTe4C1JMNAbHhnSNymRL91f1O1/j3eCl7sdleXjOH5oPWR3WPRtzEAsOLyk5XOCA
         bBpFUx56gBs9NehwL0N/WgMCsMMwpQS+xKa6uiiOW73qGTLlxEPbTCxpEXeUArWB7b56
         8OUA==
X-Forwarded-Encrypted: i=1; AJvYcCXf3ymcPTubgVq1fJ6eeFV4rMctjJQ3oH7beemL8ym0vGeokDJ1Qb5/sAh9CIJq0EswUXunm1TFcvDxpDQUmM+0QUluN6hMFal20cIo
X-Gm-Message-State: AOJu0YzjlEBhv8i/siVIVvK0LqED+PSXlgoQWxnKMPiB8BH8EVBoA600
	70l2jU8FJ7ipqaTjQ5zw5YC2Di6PzXOUxCZhLweBmEXtaZGl4bAXWcB9G+MaDsb8ARGUoYSIdJc
	QBdRO9ieRvgyI49KzRYees9h+DR074bA5inbBFQ==
X-Google-Smtp-Source: AGHT+IFjVOVWHVikFrMFJYrrlEXM/z4v/cbwHsDAT/9KwTekVhh0t3MU/2ExmVGbr2SJOIV0DRPOCvvj2rrJGQZeorA=
X-Received: by 2002:a2e:711:0:b0:2ef:c281:54f7 with SMTP id
 38308e7fff4ca-2f2b717ca70mr18026791fa.37.1723544614576; Tue, 13 Aug 2024
 03:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808042858.2768309-1-make24@iscas.ac.cn> <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
 <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com>
In-Reply-To: <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 12:22:57 +0200
Message-ID: <CAPDyKFqd=haDWB3tATZ_E1BMpCReNh=hLa5qPGATc3h1NUx09A@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ma Ke <make24@iscas.ac.cn>, Marco Felsch <m.felsch@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Peng Fan <peng.fan@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Marek Vasut <marex@denx.de>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, imx@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 08:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 8, 2024, at 08:12, Marco Felsch wrote:
> >
> > On 24-08-08, Ma Ke wrote:
> >> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> >> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev
> >> is either error or NULL.
> >>
> >> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> >> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> >> then used, which leads to NULL pointer dereference.
> >
> > Argh.. there are other users of this API getting this wrong too. This
> > make me wonder why dev_pm_domain_attach_by_name() return NULL instead of
> > the error code returned by of_property_match_string().
> >
> > IMHO to fix once and for all users we should fix the return code of
> > dev_pm_domain_attach_by_name().
>
> Agreed, in general any use of IS_ERR_OR_NULL() indicates that there
> is a bad API that should be fixed instead, and this is probably the
> case for genpd_dev_pm_attach_by_id().
>
> One common use that is widely accepted is returning NULL when
> a subsystem is completely disabled. In this case an IS_ERR()
> check returns false on a NULL pointer and the returned structure
> should be opaque so callers are unable to dereference that
> NULL pointer.
>
> genpd_dev_pm_attach_by_{id,name}() is documented to also return
> a NULL pointer when no PM domain is needed, but they return
> a normal 'struct device' that can easily be used in an unsafe
> way after checking for IS_ERR().
>
> Fortunately it seems that there are only a few callers at the
> moment, so coming up with a safer interface is still possible.

I am not sure it's worth the effort, but I may be wrong.

It's been a bit tricky to keep the interfaces above consistent with
the legacy interface (dev_pm_domain_attach()). Moreover, we need a way
to allow a PM domain to be optional. By returning NULL (or 0), we are
telling the consumer that there is no PM domain described that we can
attach the device to.

Kind regards
Uffe

