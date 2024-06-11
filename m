Return-Path: <linux-kernel+bounces-210228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B3904118
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93F2B2341D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B783C092;
	Tue, 11 Jun 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHJCxLgj"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B873B2A2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122933; cv=none; b=DpEhgftZk6z+Hx8yXrV3RqYxTTLYVd65T5kjWleyiwoEg9pUF/WlE9kz7cyLHG44RvZnMGXSeHYLdBr2B0ig80jvA10ZsUap0RQSO/klW8MS7GV5DgkBpsol3qHncLhpkrKnX6tMA7jasOQuKQ+4oqfy+AqKlOWmTx6OLS4CQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122933; c=relaxed/simple;
	bh=Za4eT6Zh4nstNKeeM5l0obbQ8cEcGiiwE8dcwpGXF/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpxAxC5KJTQaU58kfd1QTBBMXPb+dNgUXLaMyfxttIRdMCRylXCQvl6VXx4x7CcFTLTGQdUqDs7KZ8Q6LnGPEVA0pGkIjHh34ctZCanKuVO6mgMkXxwrdG3xhe3x8Ak8j3W1CL+Z3AfVGu9KeVn/eROsCP+fbrACYkDnq3LOw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gHJCxLgj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfa6e0add60so5753305276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718122928; x=1718727728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQxvDf5UzR5oDkZoOHfjVzcIFa7H1tAgUbuPebpZYkA=;
        b=gHJCxLgj8t4sOzuFnGRcfsurUmL+7orfz/FW49AGQo85qlY/ITEo7FG+fBQ00Me9VQ
         t+27sgf6TZTPEj7SQBx8TzEGWTNo2LxCMSaCRStFqLOuKmr79h1YAlp315DxMGsR5CxY
         a8+eXhGNhf4uouX+udhAh6+Q3mxutkuGuYCnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122928; x=1718727728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQxvDf5UzR5oDkZoOHfjVzcIFa7H1tAgUbuPebpZYkA=;
        b=EYVSmyLWBGuWOk46m7QJBEMGT/romqmBfQ6thsPTrw0aPTRHHSBM0lAROg9TIbe0cL
         SlYtS2wHMo3tK8jRRjcYHMr0X2aI4ziS6O+FBYGxJ6e23+cB3XTFU/z9Dse70QabV8yh
         cFEDbm3N7ImTxL8xiiDJP3ZdcZSIyDkib8xEsuKrxU7etNgHzgFPyT3/ak7YvPw6WF7s
         VZKIE0a3XLO5tHt0fk1bcVqe/9d79wAX++h9MtYBDPCmITxrTBjXFxQAJdP9lzwxxb6k
         hLoT/yutYi8oZAr2Q6bngQHh3tG2zRBUsuhM2TPjPVBxvQsgi5zauZFOsaY6AOOsw3K+
         WSZA==
X-Forwarded-Encrypted: i=1; AJvYcCXd1M/urQ6F+wIp4ABmBms9agTRmrpQt713XpqI7lepOsVrU0gzr6020T76oBSWkGY6ZuJhX9loL0T5uYkjBj05n7yziXEs3Wz02tmv
X-Gm-Message-State: AOJu0Yx15etZDkUt+fGyodr7CRork/bvUHfJhc/hCnIQ8BgS3vkXwF+d
	k+Q1oC46plLkCii3SWyZN8HzoKpUthT+S5Setm0W6Ydzga61mQmCASkR1ul4VjBVfP/cQNgdrXM
	=
X-Google-Smtp-Source: AGHT+IFNe6HaKZ3Vobj1O3N4mOvAjyFE0e0N2ssdCCSdyWVRYwpbrs0+1q8KfqJ9vfF7D8HTGV3QOA==
X-Received: by 2002:a25:d347:0:b0:dfa:febf:5a72 with SMTP id 3f1490d57ef6-dfafebf5d04mr10870275276.38.1718122927930;
        Tue, 11 Jun 2024 09:22:07 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44155eec71fsm3041671cf.57.2024.06.11.09.22.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 09:22:07 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4405dffca81so218191cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:22:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRGr3j/JiYuTN7vjRFSVFjd+CMih2IN87FC/usbTr+F3VPyh6k/Ao6svqDjr8c4c9Zn/PryB6uBZb+D6v38HS8JvXSGK3qlXsTU/4Z
X-Received: by 2002:a05:622a:2b47:b0:441:5420:6d3b with SMTP id
 d75a77b69052e-44154206e67mr2028121cf.2.1718122925584; Tue, 11 Jun 2024
 09:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b7c19ec-536f-4f28-a68f-b03c1b51b99b@gmail.com>
In-Reply-To: <1b7c19ec-536f-4f28-a68f-b03c1b51b99b@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Jun 2024 09:21:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPQWUy4n75sPSxnzFi9RMTR2THmsL+VOd1PPG5paZN_w@mail.gmail.com>
Message-ID: <CAD=FV=VPQWUy4n75sPSxnzFi9RMTR2THmsL+VOd1PPG5paZN_w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel : himax-hx83102: fix incorrect argument to mipi_dsi_msleep
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 11, 2024 at 7:05=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> mipi_dsi_msleep expects struct mipi_dsi_multi_context to be passed as a
> value and not as a reference.
>
> Fixes: a2ab7cb169da ("drm/panel: himax-hx83102: use wrapped MIPI DCS func=
tions")
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>

Should be no blank line between "Fixes" and "Signed-off-by"

> ---
>
> Changes in v2:
>     - Add Fixes tag
>
> v1: https://lore.kernel.org/all/d9f4546f-c2f9-456d-ba75-85cc195dd9b8@gmai=
l.com/
>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I notice you didn't CC me, even though I authored the broken commit.
Presumably get_maintainer should have suggested you CC me?


> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/dr=
m/panel/panel-himax-hx83102.c
> index 6009a3fe1b8f..ab00fd92cce0 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -479,7 +479,7 @@ static int hx83102_disable(struct drm_panel *panel)
>         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>         mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>
> -       mipi_dsi_msleep(&dsi_ctx, 150);
> +       mipi_dsi_msleep(dsi_ctx, 150);

So while your fix is correct, it's not really enough. I swore that I
compile tested my change and, sure enough, the bad code compile tests
fine. This is because the macro mipi_dsi_msleep() fell into a macro
trap. :( Specifically, we have:

#define mipi_dsi_msleep(ctx, delay)        \
        do {                               \
                if (!ctx.accum_err)        \
                        msleep(delay);     \
        } while (0)

Let's look at "if (!ctx.accum_err)". Before your patch, that translated to:

if (!&dsi_ctx.accum_err)

...adding extra parentheses for order of operations, that is:

 if (!&(dsi_ctx.accum_err))

...in other words it's testing whether the address of the "accum_err"
is NULL. That's not a syntax error, but _really_ not what was meant.

We really need to fix the macro trap by changing it like this:

-               if (!ctx.accum_err)     \
+               if (!(ctx).accum_err)   \

When you do that, though, you find that half the users of the macro
were using it wrong since every other "_multi_" function passes the
address. IMO while fixing the macro trap we should just change this to
pass the address and then fix up all the callers.

This is a serious enough problem (thanks for noticing it) that I'm
happy to send out patches, but also I'm fine if you want to tackle it.
If I don't see anything from you in a day or two I'll send out
patches.

Thanks!

-Doug

