Return-Path: <linux-kernel+bounces-337420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E89849E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F6428261F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A01ABEB3;
	Tue, 24 Sep 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="boL5Kmal"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C21AB6E8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196203; cv=none; b=fI+5mZgSKT5GLL2mlOH4mCRq6yel46M11qYx+XZ+b65Z5aznnZsUsr/l+xwtQl0TlstSfLUTOT6WjdUpJTv/L2HFkZohhCICH3miFqYsmrCPNRyZh7Vgcq/ljmx0GW0wlqa/yCJQD4oIRl9QbLPc6w4g61ckkLqCcnaIYCdE2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196203; c=relaxed/simple;
	bh=AQ5FbSaFdj5aS9AX4RLJpwEbWTt6zgq69+MLk0UjZ4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIM2K1w6iP0KhfAYeADNDtiXOJfi7UAUfMQhghHqu9xJ22e7B3K60pEhQo4IMQA/c3GHwUPj4pCrIvyttHtcku1k3ZczzhldMqMQ/pDHsxjykdN5KAXk5wyYR+mKfsV6hEpIFxU10cmTsy8zE0nJ/u4JmvrhIcoykxXxB9/69lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=boL5Kmal; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75de9a503so54210441fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727196196; x=1727800996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDJg0Z3yMGG86SOrzW7+HRJsv8BrsQ6fZkBLLbiSg1k=;
        b=boL5KmallsPTopEgvGbLClmAqWytSS0v4X1AsfJ36s6h9nFs3M437WNm8NJYy7F6OJ
         a6rT+dSG9rvyMKDjpNHIj1O+OF8VmmoVLlTECpBOIlAAK1hf/Hgf160qTKlWR+LWLZCx
         IaOQJj9CswHCoMu4Xft7rEPiShEWJ+Zq4wgpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196196; x=1727800996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDJg0Z3yMGG86SOrzW7+HRJsv8BrsQ6fZkBLLbiSg1k=;
        b=saTSbOmFGR586UgbO9F93rUMOpP5XWPmVJsMRYg+PIWxJ5OdNJwEWkjdXqZjAmxPxq
         YLiEokvFJVOHahS14tpBVU3WVoPl4KCS0IPOvxfbCJvsjC78z4Y4Z2HrqSy84vPK0DNz
         S5MfZKc16dqsXEoe/ry7ERfDCi0nqAAe7N4eqijTzu57vS2IWYXmSXp59DNXs5n7q8II
         dY59dy78hwRTnmWB/UIbF1S9bWW6lNEklCBQfi0BW9GP43WqT5W5g8mg0J9bQ6W2raLd
         YsiK32kVj5MGCZc+9LmJmRU0z1AsvTVIcNPuqadJ4312KA9ehNJDRKbiLDC/Ag33whX0
         nxmg==
X-Forwarded-Encrypted: i=1; AJvYcCUcvP2aM+7TS7nWQbVHlBQnQYVjSp91Dg9+OyJI68zWTUyW82vY87zVX+bmu91JzVbP7PmMcNXHOgFYQsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxrSxqeMcqOsqX7jkWQchSbL9kacMTHthTrDLMQiZZq3/qgL1
	omvcCJDTTZzn2q5L7DYdyWI1xI+c90gL5quiEfX1z9TaYBZf4aHOijt2zH1E2Ee+3DSWvt5XTyB
	dtcaW
X-Google-Smtp-Source: AGHT+IEbtwl/TyP7RlRHNDEOwE0mjSdsqVBat95x//rCHVHFoDargTv8c9/a5LQSYXg0AE+EOTHJMQ==
X-Received: by 2002:a05:6512:33cb:b0:52f:c5c0:2879 with SMTP id 2adb3069b0e04-536ac32e504mr8482925e87.41.1727196196215;
        Tue, 24 Sep 2024 09:43:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85ee671sm277070e87.73.2024.09.24.09.43.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:43:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-536584f6c84so7111808e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVt8OdE7p+olSPgq8wU6e2Y6wTUtjDpvFAG9mMppG3QGB5ikbGSxaSMAJ+iieW0j0C8UfZDsqwL5rytR8M=@vger.kernel.org
X-Received: by 2002:a05:6512:138b:b0:52f:c833:861a with SMTP id
 2adb3069b0e04-536ac3400b5mr8400144e87.51.1727196193748; Tue, 24 Sep 2024
 09:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924035231.1163670-1-treapking@chromium.org> <20240924035231.1163670-2-treapking@chromium.org>
In-Reply-To: <20240924035231.1163670-2-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 24 Sep 2024 09:42:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VEMkociw5gyVOtVCPmCyf1b0G7owsAm=o-LxB33YUnjg@mail.gmail.com>
Message-ID: <CAD=FV=VEMkociw5gyVOtVCPmCyf1b0G7owsAm=o-LxB33YUnjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: anx7625: Drop EDID cache on bridge power off
To: Pin-yen Lin <treapking@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 23, 2024 at 8:53=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> The bridge might miss the display change events when it's powered off.
> This happens when a user changes the external monitor when the system
> is suspended and the embedded controller doesn't not wake AP up.
>
> It's also observed that one DP-to-HDMI bridge doesn't work correctly
> when there is no EDID read after it is powered on.
>
> Drop the cache to force an EDID read after system resume to fix this.
>
> Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP=
")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
>  1 file changed, 1 insertion(+)

I'm not totally sure if it matters, but I wonder if you should change
this to only delete the EDID cache if you're in DP mode and not eDP
mode? For eDP mode the panel is not allowed to change and re-reading
it needlessly seems like it would slow down things like
suspend/resume. I think this would only matter if someone were using
eDP panels in the "old" way (not under the aux-bus) because we don't
set the "DRM_BRIDGE_OP_EDID" when we see "aux-bus", so maybe we don't
care that much but still...

Other than that, I know that there have been discussions in the past
about EDID caches but I can't quite remember all the details. I know
that panel-edp.c still caches it, so we must have concluded that it's
at least fine/reasonable for panels. I don't remember whether caching
is encouraged / suggested for external displays, though. Do you happen
to know if it even makes a difference there (in other words, do you
actually see multiple calls to read the EDID when you plug in a DP
display)?

-Doug

