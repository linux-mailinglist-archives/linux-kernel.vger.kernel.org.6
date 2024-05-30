Return-Path: <linux-kernel+bounces-195527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28F8D4E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B3B21785
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78917625C;
	Thu, 30 May 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UY6jCxw7"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3471E4AD
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079662; cv=none; b=TLkVFSjWHVfcyPwvQyWw+l9SJleK0TArTx3YB4ixqpFziSxzslEc9yF1/hmaqnE52Ue4dsqdzquAX7aUKq6M7isSl66Tmtm32UB/QCTGrvqxSOc8RcK5isg4Qi9wqLtwb1I2tej9Bc+IesC7B1l9gCnTiQ6m/KsS6q9BfPEwAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079662; c=relaxed/simple;
	bh=Lr42HS19H39Jg+IU3og7cv+Dzp46hLgy1NFduKRJYvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaor8YAAq+E5PMRh2jTpWn1YDo8JgFrRu9egtOJ3sU/skvDT5uTls8L8RUxNcrZ7Wxjy1U9HW1dD2cKcoC6ou/iHo17hWZSge7BQg0juXWXwDz8EnHLZetH7UudSTibMH+Va7CtbLcSClhpIN2k+OKTxJulXeqCcvzhOiTg4X/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UY6jCxw7; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso445552eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717079658; x=1717684458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC6nWvS6ksIVK7SPyvfcXHHq7DHpEEdDXC/BUNLhAHQ=;
        b=UY6jCxw7Lk1SQALETVI3z3POLOF6PdPDSnAN43zIlY5TkXy4wIM3rWAXkor8WPVTW0
         +FDYyWld50d4vnD/69LIADvwYkaT1fTtXtkY/uZCsbzvI6k4Bv0wEZDR4qGCilGLnSjL
         j75mk4HFvQcfZSHt2trFBc3rUmnIDQBWgBPWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079658; x=1717684458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC6nWvS6ksIVK7SPyvfcXHHq7DHpEEdDXC/BUNLhAHQ=;
        b=P83xcQvjERpqqghgbK1351nQbj4JKezRT+hMhCj0oT2NHBT6JpY3mEqdC6BSgr1htT
         k7kgIhL+CShQaUqYLmi5HJOFaBFowcHsduBO6dC/vUwVkMLWFomlhP4lApI8K1SlwJjW
         pf4TUumNTCn6EX1hlz5itvT6nZyDTvfKchPu0YH97mI3f2hXfVo/MycqIMszejHxRg8N
         4Se9OuvgLL0OytHf+CtQVzowpcac0lfrRKZIenlfhRX1biCUPYD24DiJRgeTVJ7T13tj
         P0cR94mFcY1vS0/tkAiqw7wm/kJwLUy9GhGW6cCqP63U489ngF9Ij7IzrNjHiygty9Cz
         ccKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyqEOzKmzmzj4DFyh7qJGFQ2JmSbFJF7p4L+3YW8q/I+OOG0sPHRC5xrhMUylAXlqJ4Xdg622ZY3q66avFSgqQMpiLPO8EgqDZ4/VJ
X-Gm-Message-State: AOJu0Ywg2GIIaZEffEWqmyGLG3yUqdzhc3fFJ0MZPqIrifi6IhIvbi4G
	5a5igc2X03YlTysP19qH9OO6ohbNHGcP1RqUNm289vJD6Ep6I+3Y8BLYHF9gHmCozNPW6w1hyMQ
	=
X-Google-Smtp-Source: AGHT+IFKOJj07p3zTaGwYZm8PZRvqYYULVBVfJVNBLSUTU8bwpN+PGX/iYaFeBUCoV4+nrQIVujFjg==
X-Received: by 2002:a05:6358:5292:b0:186:1abe:611e with SMTP id e5c5f4694b2df-199b986158amr222045755d.30.1717079657948;
        Thu, 30 May 2024 07:34:17 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad933dba20sm25768816d6.37.2024.05.30.07.34.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:34:16 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43dfe020675so363481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:34:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMsRIGdY+2Xt8ttkrprk/KhM71fm6WSrwDOgpwRBSh+DS8+sSWJt3SWyf9H9xmg3mMxBqSPaq/rK8ZVnmEwTAWw6xxZya8i0YyBbIs
X-Received: by 2002:a05:622a:544e:b0:43a:b51c:46ca with SMTP id
 d75a77b69052e-43feb5182fdmr2765661cf.29.1717079656252; Thu, 30 May 2024
 07:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org> <20240529-edp-panel-drop-v2-1-fcfc457fc8dd@linaro.org>
In-Reply-To: <20240529-edp-panel-drop-v2-1-fcfc457fc8dd@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 07:33:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uw+KYQQ2xFLhNdWSW0sNX9uV_zSAVO2uBWY4JEcaO2bA@mail.gmail.com>
Message-ID: <CAD=FV=Uw+KYQQ2xFLhNdWSW0sNX9uV_zSAVO2uBWY4JEcaO2bA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/panel-edp: add fat warning against adding new
 panel compatibles
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 4:52=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Add a fat warning against adding new panel compatibles to the panel-edp
> driver. All new users of the eDP panels are supposed to use the generic
> "edp-panel" compatible device on the AUX bus. The remaining compatibles
> are either used by the existing DT or were used previously and are
> retained for backwards compatibility.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 6db277efcbb7..95b25ec67168 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1776,7 +1776,23 @@ static const struct of_device_id platform_of_match=
[] =3D {
>         {
>                 /* Must be first */
>                 .compatible =3D "edp-panel",
> -       }, {
> +       },
> +       /*
> +        * Do not add panels to the list below unless they cannot be hand=
led by
> +        * the generic edp-panel compatible.
> +        *
> +        * The only two valid reasons are:
> +        * - because of the panel issues (e.g. broken EDID or broken
> +        *   identification),
> +        * - because the platform which uses the panel didn't wire up the=
 AUX
> +        *   bus properly.
> +        *
> +        * In all other cases the platform should use the aux-bus and dec=
lare
> +        * the panel using the 'edp-panel' compatible as a device on the =
AUX
> +        * bus. The lack of the aux-bus support is not a valid case. Plat=
forms
> +        * are urged to be converted to declaring panels in a proper way.

I'm still at least slightly confused by the wording. What is "the lack
of the aux-bus support". I guess this is different from the valid
reason of "the platform which uses the panel didn't wire up the AUX
bus properly" but I'm not sure how. Maybe you can explain?

I guess I'd write it like this:

    /*
     * Do not add panels to the list below unless they cannot be handled by
     * the generic edp-panel compatible.
     *
     * The only two valid reasons are:
     * - because of the panel issues (e.g. broken EDID or broken
     *   identification).
     * - because the platform which uses the panel didn't wire up the AUX
     *   bus properly. NOTE that, though this is a marginally valid reason,
     *   some justification needs to be made for why the platform can't
     *   wire up the AUX bus properly.
     *
     * In all other cases the platform should use the aux-bus and declare
     * the panel using the 'edp-panel' compatible as a device on the AUX
     * bus.
     */

What do you think? In any case, it probably doesn't matter much. The
important thing is some sort of warning here telling people not to add
to the table. In that sense:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

