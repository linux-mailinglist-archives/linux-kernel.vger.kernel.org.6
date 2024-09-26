Return-Path: <linux-kernel+bounces-340819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C292F987834
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A8D1F277F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDFD15B0FA;
	Thu, 26 Sep 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i0/5TG8i"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE03FF1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370957; cv=none; b=aw+85X0BIXZelEK7IB63GZ9TejHtd6xEcQWcgVlaSr99Kj4Scvz3QVTXviVBhJrYAOYutGkOSnZvVBxXaFBPOYI1ZSkyBEsDsu8RueBMI+gJGi67inZPEErojeJRk8HUv0HgzwtCN2jFnNQt+oD+LxQCv0R1SKVjw1IvrKMdSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370957; c=relaxed/simple;
	bh=8Z9QXJ2eIFePE4Q+M3ttCNU/wCNcB/FJYMIBgdLUyTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoSzvU9inL+sb3kOqNbHjAMla6a/p5jjUKWE01+KqMiEuVOXvcA1EKz3n5nEZH9KhflOvv+3BXTbavg+X2O+6mYnjhCY6W836k93WHYHt2XgXuyaZKDwkv1cSZ44p+PlyZglzNRQNfnYf5tP/AKvT3wc5e1he0TZmiPnX9mDI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i0/5TG8i; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f753375394so12313211fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727370950; x=1727975750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z9QXJ2eIFePE4Q+M3ttCNU/wCNcB/FJYMIBgdLUyTg=;
        b=i0/5TG8iulAzmQzftLWX5xSPeRo8jWLzXTzB6Ga1Nxo2hopHlRLACkhUpJq06vsLcP
         cB6wSACrMt+uet9uoGIgskjRinIQ+SjsyE9L6B0+GqjMIIvYoYM7PC3OjY8VWOmgd7bh
         +myd78KDUPEWviPeVPhs8J0bmmHZROFwzEpSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727370950; x=1727975750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z9QXJ2eIFePE4Q+M3ttCNU/wCNcB/FJYMIBgdLUyTg=;
        b=aGCu7uSeAlVJ/4ec0yV53J5xJb2rzhp1mwYX1zgz5EuVBk0yFI88cxBzgv+uQ32WtN
         9z6t3RrVt2qcIEafx63Icda8Pdus3N+0hiLB2b34pJzGUW44LmwXl+cdzICnyzv+6U+P
         ItrCob7VdqYDM4qon8tYCFKCE6AkrFiNFgpdRHgzo8+O1iqVf/SUm3zWmeY66V4aHPmC
         S1x9xj95gxvg0B0bZuY+doBZUaT3/u/sqMCpD43w0Zvm8azmFFu4HjtzyWPYLSINX5wb
         wcFCqps8qDlxq4Uc2KmJdDKjwMoJDT7PxdN7Ev56ELokeiHZmSix+gw2ZPuDT15iHnV3
         uaZg==
X-Forwarded-Encrypted: i=1; AJvYcCWkDcgRNNwL0x+f4gh1kx8TXJbHT5HJ16WFtQ1lAUq2EHWR12KvYP/0zb5ogpKOM9mPAsXJCU7UmPIXqKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSiowRHVOaShkl5ohSVS33teIKMuR0ZQ8ZJnmA2gRq12NYGwFx
	EdL2+dqEkNV+2r92TUwzVGUUIF8yXlE2HLPcWtXvYxQg1+qqICZSLOYRjg+boccCR2E/4IX6/57
	8Bg==
X-Google-Smtp-Source: AGHT+IGhQA3hV23xmckisUtgY9UK9oklQkgLNjQPcaIDnItI5bAvtSeT6BxYDAq2krs/NaOd8KzfNQ==
X-Received: by 2002:a05:651c:19a9:b0:2f6:263d:96aa with SMTP id 38308e7fff4ca-2f9d3e3ec11mr2792441fa.3.1727370950153;
        Thu, 26 Sep 2024 10:15:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d45d69a0sm166321fa.29.2024.09.26.10.15.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 10:15:49 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so14857421fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:15:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtxGboz8AQi7OSGOqRTeZ1J/wr61/6gdT2qGLpHTsL1V7cuqDC8MQk3LHordEkPMvaZG+MVSbnExl4kVM=@vger.kernel.org
X-Received: by 2002:a05:651c:2220:b0:2ef:2bb4:45d with SMTP id
 38308e7fff4ca-2f9d3e38033mr3647841fa.9.1727370947964; Thu, 26 Sep 2024
 10:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926092931.3870342-1-treapking@chromium.org> <20240926092931.3870342-2-treapking@chromium.org>
In-Reply-To: <20240926092931.3870342-2-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 26 Sep 2024 10:15:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V5Yf1shF2eKCYOxu=x48cScTh8WXkcm4Xvr1qJnSn1Kg@mail.gmail.com>
Message-ID: <CAD=FV=V5Yf1shF2eKCYOxu=x48cScTh8WXkcm4Xvr1qJnSn1Kg@mail.gmail.com>
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
> Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP=
")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I don't think it needs a re-spin, but for future reference you're
always supposed to move your own Signed-off-by to the bottom whenever
you "touch" a patch. Thus yours should be below Dmitry's tag.

In any case,

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If these haven't been applied and there's no other feedback at the end
of next week I'll plan to apply both this and the next patch to
drm-misc-fixes.


-Doug

