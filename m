Return-Path: <linux-kernel+bounces-432565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A79E4D07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87422282A23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0B18FDAF;
	Thu,  5 Dec 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfG7WXkx"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F44C83
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733372832; cv=none; b=HE8IKUJ6Btv80TP+cz69g6dAN6r4rK9dEZRHX1R6jHqBWJkXPyQ/1shsM62LuGIyJeq77Gve7P6ZCxO0Xhxk+dbtAHj3np6XSCB2ZrQDmQEZVhcfXTM5+cwZE57pgQJVPUPPNwWUxtq7mbxhQ45I4i8Reo1C7OSfeomV3LsfoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733372832; c=relaxed/simple;
	bh=hGG58PPNUdG6yFsy5c8QvSogOQV4k5XxMtrE/57gdpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Y7up7OgSqs8hVrJluc12W6PJBxG70Z4ibST/Y9gbxGouXZjXAQ8CCUAzKUz7gFhJqgArTIWiyLU0CFK1Po6GAtLnua5P0Bay9wnAtfaq1TUcHmbDnVSQEUWRkWSYcMefue8Lm9vkoePhif6KokL/7CyCyVqvXsW1hdyNRqRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfG7WXkx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so3519961fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 20:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733372829; x=1733977629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hGG58PPNUdG6yFsy5c8QvSogOQV4k5XxMtrE/57gdpk=;
        b=MfG7WXkxInhCO/eMLN6jpGwC/Dj6Q+OsLruyVxpYOg5l5jzpqXfrK9W+U5J2WK5rkH
         nkyIxOuHaQ1bZxUg9OCMdiOrumXAlGY57ejpGKx+utSfFZz1wTKMQdvy8ZwYihHUH5cP
         yFbt3HaoDGi6gCjNa7eKHlLOTZcj0u4NVmqgFuYpZwdbhTvj0N6RHF4LHw/kV7JRUo2U
         r018GhaiPlUaljDRm+MuOeKE1Ms/ZvtxB1QrielNRyjMxQNd1XWpi3zjV9OADhzzwySl
         qVsNCyD4OoFL+aucgLLROf7pMjhiZC9tzvrU1JblxZz1ofXijxucmQY6HWxySc77AbJM
         WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733372829; x=1733977629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGG58PPNUdG6yFsy5c8QvSogOQV4k5XxMtrE/57gdpk=;
        b=cO9HWzJLSPMQUbWZF98os7hKpiRrfEKv28uOTnby/W9KkOiGGTum8IcWjd+C96QdeS
         Br1JswHyCPwz4MXzve3VHJF4TBD4cPtYQXiHEGJ+x+2oYx3b5EKb3lnhlw/wvlw1GYxR
         ftX7f/4xYI1NDKMnBA+35l2akCgVx9Dm9rVdHeucStAqdI5mOebVLXKVJ38O2fv1bXXM
         D6zVXUqLee5Ap+2Fpldn86dJ7vH5mDJyrs/F+YD1QHEPA2RU9SK7gZrFkBqoFuXEWUo2
         pElkAE4QhXlHbRy3LxIA2E90WAeXuIMpi37nw4/0/uGY/gAFqOUEAD3biusrJ4NryNyS
         7V5A==
X-Forwarded-Encrypted: i=1; AJvYcCXCUcSwonivZDdvpNKACCLGofSKr0BFaQQzIRoJqHgEOYaWQLsi6MTcSjlX3szVZigUa/cBEKyuxwVesRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnymQUZl23+Toahg3LCR4kmyrtiRuLwv1EIrZG2vTyMpdIRQLs
	IANqZhzfl27cW9vIRf2EqSmSUBXX2OQ2PFbMoZiAlT61KKUlmZqMptkdCzCgztqRLyXCSI/rLRj
	0R6b/hS1Zx7Kc7PeITcngKjeIx+E=
X-Gm-Gg: ASbGncvYwrhMSSHqao5iNGeTqQd8vVmJdiTf/2ALaTaHxxRKWI9XJl3IxalTR+K7Zzv
	0jZtkkwXfyYIAG3BA6EW1amV6Yk0y9isjUKn/wr/FFd6esM/7VvTvpV1uie+gQg==
X-Google-Smtp-Source: AGHT+IGwq7mHQY6OyBNEWfVMfyb2cdRLN/ZLgtIRU53T6xPRl/DZ+46JSQtVSZqp9f+QMloMtKsfVEqih2zUDNpYWgY=
X-Received: by 2002:a05:651c:885:b0:300:259b:58b6 with SMTP id
 38308e7fff4ca-300259b5c69mr270441fa.5.1733372828750; Wed, 04 Dec 2024
 20:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007150904.9840-1-advaitdhamorikar@gmail.com> <rr7pp6a77tmur62vu2xdpasokokta7g6kcgjcd4iydmzyqpd5e@z45genf4gsv3>
In-Reply-To: <rr7pp6a77tmur62vu2xdpasokokta7g6kcgjcd4iydmzyqpd5e@z45genf4gsv3>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Thu, 5 Dec 2024 09:56:57 +0530
Message-ID: <CAJ7bep+Hc4Uw1WUBANtR7UGfVrDVyFe_0iPJ=ja=EczO6kk9Nw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/atmel_hlcdc: Fix uninitialized variable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Just a gentle ping, this patch was never applied.
Is there something more that needs to be done?

Thanks and regards,
Advait

On Mon, 14 Oct 2024 at 13:08, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Oct 07, 2024 at 08:39:04PM +0530, Advait Dhamorikar wrote:
> > atmel_hlcdc_plane_update_buffers: may use an uninitialized
> > sr variable when the if condition remains unsatisfied.
> > The variable may contain an arbitrary value left from earlier computations.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes: https://lore.kernel.org/r/202409240320.MZPgi3Up-lkp@intel.com/
> > Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
>
> Fixes: d498771b0b83 ("drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops")
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> --
> With best wishes
> Dmitry

