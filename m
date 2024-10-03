Return-Path: <linux-kernel+bounces-349544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E9598F816
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD591F229BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F51AC88B;
	Thu,  3 Oct 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNo6Tz3C"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F932C8B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987340; cv=none; b=DztLtZPDOiC7KrgkgcWG/HrwatGPQO5nmRXww5YQDwnMOLMTPPNQRXuKXLlvu680+A9zw+9Fw+RsCypypbF4GllBgByv/hyZOrx9H2f1qumbCc49DvFtT8XNrSDYhwmdoZA8cQ8kL5VvoTva5MTMBbdsfrtpdNrKy+r9z7qaw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987340; c=relaxed/simple;
	bh=KIQ5hoQmSc9lrpiU2gBhZbQ64z/SMG1wirj3hv3fpDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EguzKl+DJhtPMWKE4OdfPyVv+hutZ6o37MSnjBkAPvJifE3B7/GBPjgPtNxnl52m168fnxUMyGst5bLSPApQtbkOBWVQWyy67kTxmUkI83LbEXi4vlH7HjLfJao0uRXE+wiB6UvNpRHmxrBGKUNUZvdVcGgwIoJ58yT0fVdT7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNo6Tz3C; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so2327954e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727987334; x=1728592134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYIVkNsPyt+bQBwSMHMJOZjiBjar2atE5RRCUQ3xHXI=;
        b=YNo6Tz3CXoQrDINHRMqarLsHG0x6JFIbqy/qAWlU3Ti2OswRqAV8HmlwprglUgXCKQ
         QRGHVqYvpK4V/mjM85V5wdKU7NM5twcXISxXmrs1EMi5MechttywnT5x+OuoZrEpnpYO
         7rTsI5M/15rGwAh/PHFUeTYGYxfhU5FRt24po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987334; x=1728592134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYIVkNsPyt+bQBwSMHMJOZjiBjar2atE5RRCUQ3xHXI=;
        b=eCfp3ZzsQr5D4c8j/yWULi15/jmm/tTYttFam3ELdWAtJapSWJTSF665Z1RgPXQ1z5
         332p2uyuPPitFcko3w3KjPFU4ezHMPV0LHtTlZLEOgWDgnGRCBhSH7jodwA+fp0C4bvT
         MiTWHjgMnKnamXA9+HTPsEGT3T0qG8sFFbRl5Qaa0U3J43BI70xYwXeDgbSTEFwxaJKG
         f/fkWoQyQKLzQ10jdfGJ/hPUO7XVrO9PIGPNFbpdYZu8b93LWgSCXuLllemGsuZY4Qu7
         kKZCX1bU8jNSxpJPYl6d/fwCpNbH5Q2GD1b5LBRYNTt1Ee81ovnP3/+oKTf1QI7nFdWG
         VjiA==
X-Forwarded-Encrypted: i=1; AJvYcCUwi8AuDmOJza2RLZx2zpA6tV1dpGvujFWtPI7sOGFErGi4foehGlMXLw2876ggQgfeByg7iDUjbS8Crys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONgj0r7ZcsEkAZ/TSpKLR3mEf8ZJLTQeJU4Edc+CK0faGulUq
	Z9f+oQ5UewvFEK8D2K/zTLcX1+pn0Y6/gqqLYqdqEMXjdXQ04kspcKXibrOlvXDqnxfXz+MCNW/
	g8A==
X-Google-Smtp-Source: AGHT+IGaAeovtMgdDAGxa/wOzW6iZ36nMN6UZaLPXqw1uoB3DzNOTW6EX3uViAOSeQfBidb6wragvw==
X-Received: by 2002:a05:6512:1111:b0:536:5e7d:6ab3 with SMTP id 2adb3069b0e04-539a62828cemr1481735e87.27.1727987334232;
        Thu, 03 Oct 2024 13:28:54 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8250f36sm256210e87.54.2024.10.03.13.28.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:28:53 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398e58ceebso1395582e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:28:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqF4np9NPZIOlJQKW7bRh7If7VJU/2YBM1et9LcWkFlUKv/hiyLoOewrjhIlgPgnpGyMOY6Ji03haAZBk=@vger.kernel.org
X-Received: by 2002:a05:6512:2247:b0:539:933c:51c6 with SMTP id
 2adb3069b0e04-539ac17ec4bmr91249e87.29.1727987332011; Thu, 03 Oct 2024
 13:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926092931.3870342-1-treapking@chromium.org>
 <20240926092931.3870342-2-treapking@chromium.org> <CAD=FV=V5Yf1shF2eKCYOxu=x48cScTh8WXkcm4Xvr1qJnSn1Kg@mail.gmail.com>
In-Reply-To: <CAD=FV=V5Yf1shF2eKCYOxu=x48cScTh8WXkcm4Xvr1qJnSn1Kg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:28:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URZRRoa1YNVTAx+jnfbP4tz+tn7sAaGR2-1yCWYVUoiw@mail.gmail.com>
Message-ID: <CAD=FV=URZRRoa1YNVTAx+jnfbP4tz+tn7sAaGR2-1yCWYVUoiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: anx7625: Drop EDID cache on bridge
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

On Thu, Sep 26, 2024 at 10:15=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Sep 26, 2024 at 2:29=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > The bridge might miss the display change events when it's powered off.
> > This happens when a user changes the external monitor when the system
> > is suspended and the embedded controller doesn't not wake AP up.
> >
> > It's also observed that one DP-to-HDMI bridge doesn't work correctly
> > when there is no EDID read after it is powered on.
> >
> > Drop the cache to force an EDID read after system resume to fix this.
> >
> > Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to =
DP")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> I don't think it needs a re-spin, but for future reference you're
> always supposed to move your own Signed-off-by to the bottom whenever
> you "touch" a patch. Thus yours should be below Dmitry's tag.
>
> In any case,
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> If these haven't been applied and there's no other feedback at the end
> of next week I'll plan to apply both this and the next patch to
> drm-misc-fixes.

Dang. My brain wasn't working quite right and I pushed these to
drm-misc-next instead of drm-misc-fixes. I'll assume that this is OK
because the problem fixed isn't exactly new and the patch will still
make it to mainline before too long. If this causes anyone problems
let me know and I can also land it on drm-misc-fixes.

[1/2] drm/bridge: anx7625: Drop EDID cache on bridge power off
      commit: 00ae002116a14c2e6a342c4c9ae080cdbb9b4b21

-Doug

