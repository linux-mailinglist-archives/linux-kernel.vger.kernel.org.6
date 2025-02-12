Return-Path: <linux-kernel+bounces-511341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DAA329A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336EA3A43D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035B21171B;
	Wed, 12 Feb 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tqqb0g9h"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE920F078
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373308; cv=none; b=BWdoBAWubeibVW5014RhB36LnKKHFmSvN6MwtHOfqVU2VFPQd0IAD3uWlv1VGlRq69jCsrlRrL/e52LV6t0Sr8tF2rVry3yCNxxDCkr1QuNlMynIvjhccZkTyGeoXZTnnVDFu0tFLl6Svb7PnWdGwDVeTo2Tr4cYU1InQ7r72rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373308; c=relaxed/simple;
	bh=HzR0A/uGmbxhFBeAPx1D1BEakbEylPhwBWP9W3rkLGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7cYTjfB7ICTZ/Icph+AF3RLkf0QiClEeRkSZAex4tarKm2dSQX/SyGqj0eU9KKB4ATgLmlYtkWwM17am4tldEFUqxDPFbCrUZ210bs+46uxTQV4d9s4aBQefEQ4yF8vbe0NkTaKMQYmBM06SKRYzuD8qD9hPLzXS0w5MRbiDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tqqb0g9h; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30795988ebeso69749921fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739373305; x=1739978105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbeFhgjlAz4HP0qajS/kFL0VJiSyjCShat9G6ecggLw=;
        b=Tqqb0g9hgvQoJnlxioj10Qssnwq9rCDvgEEUV9zXpcu7EkslLTPan1mbV9jRveTxYL
         zCn54VDVgIKOZWR40ioUyCf5WXVvYmsa1jZFh2Tp9rq6zDp5oXOZjErsH+vuwQJ6Uzud
         49ON3Ec6d6nRmWIA4+JjX1d/6+iTV1FoPt6YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373305; x=1739978105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbeFhgjlAz4HP0qajS/kFL0VJiSyjCShat9G6ecggLw=;
        b=l28eI/1Mm3DLPIicu9fV4VSbcGLk8T6jHV/xSwvc07jIrm8gYlRVrVnEYFBkM+ia6J
         PpGUcnAR1NtUaNa6qGWkXArnnXWJSnkCfa99Q8pyv60nUGn5yjJzsEYknWHAg3cD1BtJ
         LdCB4q9KbizRna0XMcup58n4kb34AHKOUMzXhDHHAE8qYTvmxaaMJfBz0rhecIfuIg6R
         iDtpmcwOBEck2nasOdZ0PqnIvg/3ajVHugktAiE0pdIPCmuWlS46Qz4+DfITS0rrqGmG
         u5blyWYwxZMV5js+/JPXBmD8QGvzRm+4Igpy/wPZ7vVdu1qsLTKoCQFYp24ILCTC6TY3
         mCXw==
X-Forwarded-Encrypted: i=1; AJvYcCUzd1dp2JCAs1ooVPqlgqXY2gKmEfIuRmQxPYlIiQEDS6+ZFcDs+SFt5KipAgwWZFJsIE9n4lDYXeti474=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR21NtKtUelEz0Pz7pYkR5qs9yiq/Bo6OIpqTLNS4PD8a99UWI
	tzFiIznLvvYgQJTKiAhrhzgPjX3xo0paNfo0DXALhdisancGLR/SfmsjNwroDQyfRV4uMN5TAHr
	KieDd
X-Gm-Gg: ASbGnct5FynCu85TR6A31FMedGiVCyxOfY7zZ57Ys7cwv8Xr+VpfsFDe1DugeSKFj+6
	XGisWrILN3865cHsZcWA7gQNhNYzMR4gqT6aslzC1lvwlYemy5dBU7aJm/iBa2n2HcCubMVfEbr
	lmlk9Ob5K3QJujOEFCImXPkbqCBfRsgJpf6iNpi6ToDzC5lXxA5rRPdQpcmD2S+o4XzU4ajv3dp
	Xyd3LSBJ3GJKjf0n8QRA+YEGwXSB9ejP1SvOOTPTD2OEXks5mXfyIU2DAUcTDDsTND3Vj4PIYCK
	gYvvjwQgJdo5GTH4Y+2HHupamBlE32lbnUwfak0nwBAoF90onUzROGU=
X-Google-Smtp-Source: AGHT+IFD5qd/VAu4E46sMN+cXWyl/PNkmH0OZSxvmWFikLWBM5ZToXvjWtQj+OxsROSi3ud7PrXCfQ==
X-Received: by 2002:a2e:be91:0:b0:308:eb58:6581 with SMTP id 38308e7fff4ca-309035c3d57mr13322381fa.0.1739373304831;
        Wed, 12 Feb 2025 07:15:04 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de2ba9dcsm19648581fa.70.2025.02.12.07.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:15:04 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54505c79649so3861098e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:15:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5Yu5jyiTHF6YQdkCdCA1xRtL73/JO3loNPzhBsllzfbqJijiHpW0jfQoKTzFOLHIjEwrbXK+jpYTqVjw=@vger.kernel.org
X-Received: by 2002:a05:6512:3a82:b0:545:191:81db with SMTP id
 2adb3069b0e04-5451816b6f5mr1124828e87.50.1739373303596; Wed, 12 Feb 2025
 07:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org>
 <20250204-bridge-connector-v2-35-35dd6c834e08@kernel.org> <CAD=FV=WXkqfWoAiqbsfWiJo259oQxMV0UrQsX=qD5nVH=Dmaqg@mail.gmail.com>
In-Reply-To: <CAD=FV=WXkqfWoAiqbsfWiJo259oQxMV0UrQsX=qD5nVH=Dmaqg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Feb 2025 07:14:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UpiZxbeu9kF=bRfC=+YZmDj3qM+kSo5c7oRxaXTPDi6A@mail.gmail.com>
X-Gm-Features: AWEUYZmCbXkwQXYOuxiuptXgxJouhwsR1MuVeaed67REZjmWnZsAiLDy0PQkoNY
Message-ID: <CAD=FV=UpiZxbeu9kF=bRfC=+YZmDj3qM+kSo5c7oRxaXTPDi6A@mail.gmail.com>
Subject: Re: [PATCH v2 35/35] drm/bridge: ti-sn65dsi86: Use bridge_state crtc pointer
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 11, 2025 at 2:16=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Feb 4, 2025 at 7:01=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> >
> > @@ -374,12 +377,15 @@ static int __maybe_unused ti_sn65dsi86_resume(str=
uct device *dev)
> >          * panel (including the aux channel) w/out any need for an inpu=
t clock
> >          * so we can do it in resume which lets us read the EDID before
> >          * pre_enable(). Without a reference clock we need the MIPI ref=
erence
> >          * clock so reading early doesn't work.
> >          */
> > -       if (pdata->refclk)
> > -               ti_sn65dsi86_enable_comms(pdata);
> > +       if (pdata->refclk) {
> > +               drm_modeset_lock(&pdata->bridge.base.lock, NULL);
> > +               ti_sn65dsi86_enable_comms(pdata, drm_bridge_get_current=
_state(&pdata->bridge));
> > +               drm_modeset_unlock(&pdata->bridge.base.lock);
>
> Oh. I haven't tested yet (my device is at home, but I think there is
> an easy solution to my deadlock problems. Drop the modeset locks here
> and just pass NULL for the state. We only end up here if
> "pdata->refclk" is not NULL. Then we only use the passed state if
> "pdata->refclk" _is_ NULL.

I can confirm this works. At the very least I was able to boot up both
with a hardcoded panel and with "edp-panel" and both worked. Seems
like a good solution for your patch.

Long term we should probably get rid of the support for working
without a "refclk". It's theoretically possible to use the hardware
that way and some super early prototypes I worked on used that. ...but
it's a bad idea and I'm fairly certain nobody is _actually_ using it.
That means that the code for handling it is likely not tested and may
have bugs.

-Doug

