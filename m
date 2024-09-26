Return-Path: <linux-kernel+bounces-340094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57C986E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E87D1C227DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BE13EFF3;
	Thu, 26 Sep 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kajsb+Km"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460D1C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337937; cv=none; b=Q8eqs00U5pv2eHXDEwJC2fRixCVM40cmddVlx3IehVS464MOZSaHpQqBPliiG24hN7ncn5SHwD/6VxrKpbjd+TrvHSTjUwQUw2VrKih9vL+KHXKtQP3ArSjmGOcGa5UkEmY83Eh9KeySIpcFZflGuwTTDuwNzwPV7QTvB1KV7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337937; c=relaxed/simple;
	bh=bUXY6yWOmtpTdxj18iuqMd81YsLHeJYTQ7XXi66bsj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1XmahcsOxvk3Hz3wceKf/UQ3d5r8D5oiKB17X+fhbCWp6UKQWED+2n/W0WcaOlH2SkwlOX0ejgjm21LatZSMZ4bq5g0J25pNJk7YUAhjf0HDiYjZZtleB7uAGDFP61IcOzuBN53kEafuy1wsnogwtjg+mG4ap+XC/xIUH8yNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kajsb+Km; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6db67400db4so7829407b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727337934; x=1727942734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9FWBets92WpJ5WZa/nOYlxesuTzHoeH8VJdqXlSdzM=;
        b=kajsb+KmyYHyqWUy8acveHQSpUCtijRUyjvw/dMxXAmaCYSENQdgbtaTKwdnzXVKR1
         PDR15VqvkNJa32zXAnIMd5sTiNGp/fuzblLfFdV7yrT9q2VIWj0Z5HXmzpGZc0FX8t5j
         WaK4PAtPPOtHcBNiuSBSSPGyjWwSVL3Mb+m4f2G0JM0kTXLK1WUxLwbRmylTqIkIfAYH
         nisDRRmkDz/SEGOuOv67sEHf/kzbb+AjL/8C3TqstjrGGR9iBfoAM/KV1ptntNVPjnjV
         OBedpDxkasR6rb0i/2rkFiieoGbyoEJJ5ePmbMWPhfhyzqU1GeYcGXoWXrBvRn4x9cv9
         PrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337934; x=1727942734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9FWBets92WpJ5WZa/nOYlxesuTzHoeH8VJdqXlSdzM=;
        b=sab9sf/y/WaScjkJNI9snRW1tZdtwKDMxevR4TwpJtR0gdBPYRUB1A8HFLh4uTBeGC
         WqNUrsGUX2+Q6xCpIiH0QkryfNKQ1EJimHkBFKnWP9wQ/zaAXGj+rWqKbgm7VipJBm4K
         EX+6iJWB8cd1ddYp8bfvAc5fvqHyT5B/9UN86XG/NpapxvuXYFDxmL+n/2PC2sgF6Aws
         3xBMACltWTpwGlUttBvq2EoO0LtOxLBdzs7XW+dRWFhDGqeKY7Ppn74Nszf7XhxYKnlp
         /9Ze1F5qxf6u8TEGk5Kj2Yo7nbNa1LVON3XjcuK6naa6q7eU7b1vz8f49aIsYiynhJVb
         gyjA==
X-Forwarded-Encrypted: i=1; AJvYcCUQB0SeMxm5iPeslRMaltB+bUWMxEZIhG3HCfBxKOwoJXeFdd5F0C6XdAdg6o4eMZSBP6FtR+WMliRSzAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8aXqM7/sJpNfOFuZmu6wXEQfYOXT1bvEqwjR03M9hgPz0IOx
	i+WNRDA/kL8YbqA5D4hl6XhHnNiq2e5yqJxe4QQ5NqzJk1NJAzXVilYpQGaJRBhUOd8mlnJWNTu
	XF0tHopQmm7b/frCyzpBXKFTc3xtpvAGyVTCdrg==
X-Google-Smtp-Source: AGHT+IHN4aYzJJswa7TWE9GtZ8Qu5DXUmugZlTBtYvnKazEr7hRghRUxCKw7SCIId7wsA7FconFu6Ksp74+l6P9OlYY=
X-Received: by 2002:a05:690c:368e:b0:6dd:cb3e:7069 with SMTP id
 00721157ae682-6e21d863400mr48504937b3.24.1727337934254; Thu, 26 Sep 2024
 01:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw> <20240926074755.22176-3-Hermes.Wu@ite.com.tw>
 <ngr25a4x3s6hd3ztmj7h5y6zp3fxw3ojm4ax5wpk45iqdfkvwe@piznnnlyudmv> <3150e8e9ca754411bb0404475d149a8f@ite.com.tw>
In-Reply-To: <3150e8e9ca754411bb0404475d149a8f@ite.com.tw>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 26 Sep 2024 10:05:22 +0200
Message-ID: <CAA8EJppG01kE-USS6XYp5gRwEq-hNAUY0cBLfEcHZQgP8CRTsg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] drm/bridge: it6505: fix aux operation for edid read
To: Hermes.Wu@ite.com.tw
Cc: Kenneth.Hung@ite.com.tw, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, angelogioacchino.delregno@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 10:04, <Hermes.Wu@ite.com.tw> wrote:
>
> >On Thu, Sep 26, 2024 at 03:47:52PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >>
> >> The EDID read operation can reach the maximum size of the AUX FIFO buffer.
> >
> >And? Commit message should describe why the change is necessary and what is being done. Just providing a statement is not enough.
> >
>
> The original AUX operation treat all reads by using data registers will be limited at 4 bytes.
> AUX operation command CMD_AUX_I2C_EDID_READ using AUX FIFO is capable of reads data by 16 bytes each time.
> It can improve speed of read EDID.

improves, rather than "can improve". Please add this to the commit message.

>
>
> >>
> >> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c
> >> b/drivers/gpu/drm/bridge/ite-it6505.c
> >> index 28a8043229d3..b451d3c2ac1d 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> >> @@ -1078,8 +1078,11 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
> >>      int i, ret_size, ret = 0, request_size;
> >>
> >>      mutex_lock(&it6505->aux_lock);
> >> -    for (i = 0; i < size; i += 4) {
> >> -            request_size = min((int)size - i, 4);
> >> +    for (i = 0; i < size; ) {
> >> +            if (cmd == CMD_AUX_I2C_EDID_READ)
> >> +                    request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
> >> +            else
> >> +                    request_size = min_t(int, (int)size - i, 4);
> >>              ret_size = it6505_aux_operation(it6505, cmd, address + i,
> >>                                              buffer + i, request_size,
> >>                                              reply);
> >> @@ -1088,6 +1091,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
> >>                      goto aux_op_err;
> >>              }
> >>
> >> +            i += request_size;
> >>              ret += ret_size;
> >>      }
> >>
> >> --
> >> 2.34.1
> >>
> >
> >--
> >With best wishes
> >Dmitry
> >
>
> BR,
> Hermes
>


-- 
With best wishes
Dmitry

