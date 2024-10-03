Return-Path: <linux-kernel+bounces-349547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6593998F81F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1D1C21224
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353791AAE38;
	Thu,  3 Oct 2024 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l57DWyzH"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481C1A7247
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987423; cv=none; b=sxneifGRtWGr+jh6/ixPRBAlMcKQDNUhqAuQAQGeK/4NC4AiokfMJSaPJlOBMd/j44WDN8IWehy4/Ycy4oUm809XZxPUdawxrX47AZDzFLyPkbEXo4GCygzHdT1K26fbnMXwzPR/BaxHseP5m965OtmX93UAD3nOl2YmCqgJk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987423; c=relaxed/simple;
	bh=hRgxn9CmW6ICpm8Pq7WfBKxnn05S4RvHtarPm2JZP8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCGmJbgUSWkzRvRIsONihd2w7HKFvUddtSKa+u535j01qjMfDpX3qc+DplmkQsS812hc1MjwAT9MG4adX3kmLk2w8Wl1jXVCFp06yevRjaBJ1rCWh4/S3a3t+y8IRfWnWJ2ZPuwvhANsgjVCeZrZJY0J+r9fb+MuPRN4d0drDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l57DWyzH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53959a88668so1824944e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727987417; x=1728592217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KveEyJA6f8M/Ebmg+cvZ3aq6352Aa475xJFPESWp5U=;
        b=l57DWyzHduXvpWgFR0nGYU8HXUhjkaQs32kdGaCjTf8xenRiOptPTeWBHlr/6QpPjc
         DtaWihb0zO/VQr/skIiLlmy7Zf2kViDBBv+RhjnZ/uHju4uTlPE4YCPvxW3YyGR3BIYC
         egWR9/DJQal0zqGolgarpvS33LMYtO7Ulj2WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987417; x=1728592217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KveEyJA6f8M/Ebmg+cvZ3aq6352Aa475xJFPESWp5U=;
        b=f5v13mJZgptOMDdGJDtLWXY1EKppBq8lSU6Tfy9r5MJBXZ8F65iir44i5y25b+s7sW
         74UYaO5qUtOhbZ0aj9qaBjj4yF1326bv6eXinxLtIBGOSAoWxw/bOenMU6Ih6MILAedH
         aYHda5VQeqVNcjxip+Vobw4gC9b1P6BurdzfNb++4ctAp7bZA9ISx9W19Lmvt+HHb2Qg
         FemXrqAO87QmBOC+Au8uO+xa4kpJ2hrBypwgUNnq4h9I7R7Gj4rUCnUGBQnokTqo14Qj
         HugvKXFUlLvCZayZOby816n4YTk0H/pulS0I1D/zj3JAkgJl3tRfv4B6fOLG55xWOGDQ
         S/XA==
X-Forwarded-Encrypted: i=1; AJvYcCWjESWx4uqclctQPKLLQsuulmOqFh8xY2k+nAUT4ohIcoXPbFEUAEdl6I7/06pWHJHb+OnEpqrkT5Trk7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjRyq4rY9py08Gbl75YVTwMazv+pRi8D/3GaYuhe9BFOq7F68
	LIOCDmypIK+1ht8516sxvuGXL71+YG2Z0lERW3o30UNp905Dw+3UwcdRQf7nAueycaejYrdtpbx
	1IQ==
X-Google-Smtp-Source: AGHT+IEEkzpSwJ+/QOOI2QPS5Sg7D0tcCCEQjOWFDIATOmsGyvTdBZMocqzjKa11INPIBNqokAzbmg==
X-Received: by 2002:a05:6512:e98:b0:530:e323:b1cd with SMTP id 2adb3069b0e04-539ab9e16admr368871e87.40.1727987416612;
        Thu, 03 Oct 2024 13:30:16 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8251149sm252013e87.56.2024.10.03.13.30.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:30:15 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539885dd4bcso1833288e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:30:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkhSmRaH2fkh12/uDsWH/AjSsm0XJTja0HjjyeGeT0ZFnHCyDeNLJw0VuRUbvJi1sS72hQncFOCN/rEZw=@vger.kernel.org
X-Received: by 2002:a05:6512:398b:b0:530:c239:6fad with SMTP id
 2adb3069b0e04-539ab6d8fb5mr464943e87.0.1727987414575; Thu, 03 Oct 2024
 13:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926092931.3870342-1-treapking@chromium.org> <20240926092931.3870342-3-treapking@chromium.org>
In-Reply-To: <20240926092931.3870342-3-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:29:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTwjOwezAuD0_yFz01YyKBVPPTc=2bys5N+nrYJH91vQ@mail.gmail.com>
Message-ID: <CAD=FV=XTwjOwezAuD0_yFz01YyKBVPPTc=2bys5N+nrYJH91vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: it6505: Drop EDID cache on bridge
 power off
To: Pin-yen Lin <treapking@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 26, 2024 at 2:29=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
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
> Fixes: 11feaef69d0c ("drm/bridge: it6505: Add caching for EDID")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v2:
> - Collect review tags
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 ++
>  1 file changed, 2 insertions(+)

Like with patch #1, meant to push to drm-misc-fixes but ended up on
drm-misc-next. Yell if this is a problem, but I think it should be OK.

[2/2] drm/bridge: it6505: Drop EDID cache on bridge power off
      commit: 574c558ddb68591c9a4b7a95e45e935ab22c0fc6

-Doug

