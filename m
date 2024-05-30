Return-Path: <linux-kernel+bounces-196026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57658D5633
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30472287E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9817D897;
	Thu, 30 May 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P52C71do"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53DE17C7B7
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111454; cv=none; b=H/sHkZW8UcgC6hWje2ovmXlPm1tudr6qcvV+vCCGYNMgr6YipHmxlBCeKQKvdSejenmv9//yjeMFYBNjxD/JPCN3UzOzFCHLYUdaNB5amgipDG5Nrz/zPwad45VnrRRCv/rrmpo7c94B5UYT9hoAaW1aY/LjFY2JVIJslEAaIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111454; c=relaxed/simple;
	bh=31u/vGw2CPYpYVL836bANXvOaTurmnqIhIoXVtya3nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5hrHBnmdGaBJ56QVPaXJwD/MEbYfZQ60nhUKxRcE6XHygJ1bnWN+qVXB3kqDurnDEwavIHenbXAkQIWu1g4qQVJkrSA5OBrAcC24l9BuXqWROiM2ulhN4SGWVU2vfwxG3Miul5o+GnP93chVhIZfatffUhSwSQXQWITzVxv2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P52C71do; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bda9105902so379440a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717111452; x=1717716252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8KNeqwgU441IhOlEftCeN31AWUkQGVDTw621Xo3rrs=;
        b=P52C71doocHJ5Fcn8Z0Xokdiiu+AU786sZtHqFD7ZUPjg0cTfZn8lY3SNjaG9kOUWP
         XGzAuyw9JEflovuJx9UuwvB6iwb9AduZN7iSP7ompNP3cRkNcuJnyopoPutBqyNRE1GS
         0bdWykxMsoYKoga7WIrSTOk0gZP8XKQZC8cPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111452; x=1717716252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8KNeqwgU441IhOlEftCeN31AWUkQGVDTw621Xo3rrs=;
        b=NhWku5yES/5qQqQ5EUTOFqhQjHlLU+7PhfluJoQlFKk/7seK6Z5UAnLxmqSO6uvOf6
         VO4X5Z+C4GHuYm6YOA9WR4My8QxH+edeULt/xTD4YHFttq9K5RePTsnCj2WW3BgnTO0M
         X8t1pyms2ORJ/tNIWTJlldwLrmc1RiVICjEDCXlH5/UAiyKaE54puT02QOKkiPIlYC+E
         jA9BkCEEG16aaH1pDvXyAchyl1eTtdRyq5rTOsQ80PwJSYExW0Ct2oirepEAEC24/B0R
         Z/wFFYhD1RAreQ1aUJ75dJYQX9Z+wjvfLq4Wl39mebcqBeuTovirIzi5jCzxIZTl571i
         XVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJQt1+nEbvr46vXXf/wG3e3Ny6q7Pq0WhR+6duKl61SvdELG0OBh1TaHTzLMV+9x2Pt9dGhhgm55au3nvdyEuPamAEge43SPxeCNCD
X-Gm-Message-State: AOJu0YxwhKlBQVBrAGQSXur/EyE5FgpQX1sqY+R4KCCgKqzGRS1GPqSu
	pFo99lD1fg1XTIBEpNZdMa4IuHghROKHEc/xbE/iGZ+lFj3YZSzAkdu6C/yAC+9vW/YH1jqBZWO
	v5w==
X-Google-Smtp-Source: AGHT+IFPli6gnqXt4wwZYx7OJYQnXPgwUcvTYbQ4cKF4YC9LeGO1A3og8vJxGyUsA3W4XY4wWWfPcw==
X-Received: by 2002:a17:90a:7f8c:b0:2c1:a526:820b with SMTP id 98e67ed59e1d1-2c1dc58c8c8mr209611a91.23.1717111451797;
        Thu, 30 May 2024 16:24:11 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c28425cdsm295928a91.52.2024.05.30.16.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 16:24:11 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee5f3123d8so34345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:24:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFwhsVpcC95dngbRv12IwSlTQuYNdSj6lpBO64kDOLkKqY0OgDNNe47Zkl+SHU9YKR95bHmazCxC/3Z3l/LHremJC049eNX/lrCAJx
X-Received: by 2002:a05:622a:1cc3:b0:43d:e001:69bc with SMTP id
 d75a77b69052e-43ff4f80e4cmr291431cf.17.1717111012344; Thu, 30 May 2024
 16:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org>
In-Reply-To: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 16:16:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMgAnaEaHXZJL57+66OXs0afP9vurxf_ffqkum=xqEfA@mail.gmail.com>
Message-ID: <CAD=FV=XMgAnaEaHXZJL57+66OXs0afP9vurxf_ffqkum=xqEfA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/panel-edp: remove several legacy compatibles
 used by the driver
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

On Thu, May 30, 2024 at 4:13=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> There are two ways to describe an eDP panel in device tree. The
> recommended way is to add a device on the AUX bus, ideally using the
> edp-panel compatible. The legacy way is to define a top-level platform
> device for the panel.
>
> Document that adding support for eDP panels in a legacy way is strongly
> discouraged (if not forbidden at all).
>
> While we are at it, also drop legacy compatible strings and bindings for
> five panels. These compatible strings were never used by a DT file
> present in Linux kernel and most likely were never used with the
> upstream Linux kernel.
>
> The following compatibles were never used by the devices supported by
> the upstream kernel and are a subject to possible removal:
>
> - lg,lp097qx1-spa1
> - samsung,lsn122dl01-c01
> - sharp,ld-d5116z01b
>
> I'm considering dropping them later, unless there is a good reason not
> to do so.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v3:
> - Rephrased the warning comment, following some of Doug's suggestions.
> - Link to v2: https://lore.kernel.org/r/20240529-edp-panel-drop-v2-0-fcfc=
457fc8dd@linaro.org
>
> Changes in v2:
> - Actually drop support for five panels acked by Doug Andersson
> - Link to v1: https://lore.kernel.org/r/20240523-edp-panel-drop-v1-1-045d=
62511d09@linaro.org
>
> ---
> Dmitry Baryshkov (3):
>       drm/panel-edp: add fat warning against adding new panel compatibles
>       dt-bindings: display: panel-simple: drop several eDP panels
>       drm/panel-edp: drop several legacy panels
>
>  .../bindings/display/panel/panel-simple.yaml       |  10 --
>  drivers/gpu/drm/panel/panel-edp.c                  | 192 +++------------=
------
>  2 files changed, 25 insertions(+), 177 deletions(-)

Thanks! I'm happy to apply this series or also happy if some other
drm-misc committer member wants to apply it. Probably we should wait
for a DT person to make sure that they don't have any problems with
the bindings change.


-Doug

