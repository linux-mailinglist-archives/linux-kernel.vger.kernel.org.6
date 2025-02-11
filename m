Return-Path: <linux-kernel+bounces-510122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4D0A31875
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D0C3A83DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67313267B06;
	Tue, 11 Feb 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKj/Wekg"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE46267714
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312221; cv=none; b=H9RycQL2STkhQm08qZzP8uyQEaDUYwTdMqw/gcECsDZ8QzHdVxl04820+weo/+kVM57eYPeR1te41Aj/J1MvxCbZLRfGK1m34vTyNcAVUF1AO52zvMiGH1M2yrvkP3EnTYhlZm+PZsfgbmO/BYUKy6DDQgyF6I+vG0FSBr2iqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312221; c=relaxed/simple;
	bh=iY0JsvzdW/s8uAAjrKofbSU3WFhveVxvUFWtiQz/Z5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlsnOD2Ct1avDevhs2PZVYqgdQyDgpA65q0khogXPF9Qsx0NvZ5d6aMmzROHrIToJuD+fztl8oMRxJLpVOXVFuKPPt4o4iaNZHn4Gy48WH86XwcnTOlYYLkwp1wnPEUCXV0AWo9+LInbD6A88SUExn53LVZVjXvKpE/cDLY9O5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PKj/Wekg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-545074b88aaso3472041e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739312217; x=1739917017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U/i0AyDpGaJpOZ3KaZQJIAbdIyIIccKfpuccmj4AeU=;
        b=PKj/WekgTAsJWKFw7OEgsNLB0lVESWozQ9uXeMT+HiURaE5Cwhsrp9KRuRZVeEGnga
         1a43b98Jj/2QlDTZRxjGXGzTHNR76CP+ldcr32ipUn6UgtNEPczgH4/gJvBJdaKMq1UO
         DZrT4waN8vVm7AfPTw5eRHjudZa2mdryQ9Czw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312217; x=1739917017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6U/i0AyDpGaJpOZ3KaZQJIAbdIyIIccKfpuccmj4AeU=;
        b=sdBUgJu+46buKl3/FOcJJURBQ10JeZCmMaXL34yESsIeDy5CevY95HyB152pcNhPO/
         ZxdkGwZLbbsqpgsoc00rfy7vzwnNTnN6//PhK4EqWx8R3fX7PCJ98Jjw1Cvf0QP/FD/9
         T44RHnGvnraYv/fl2D7Yq4ren9NfDQGLoh0WbZDHXf6gP/YoCuLCEdyc+1BUhRHFrckK
         TEanWA4ivlJNJ9Yohz5zduWDhBuHaXFITnv5qR3YyIYYCGhLcWQeAOfqZVdbmdFxZguh
         /qMvNsOxSzmva/YipagwSUWtA1Jck1FIjlawpZSVBNV0hu0y66t60SKvHB2FEaOsffjY
         MWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpBCr3hfQTI/sgcGiC0B/j8C8/PzrjBBn0s9NJke3ULaH+eNtwPUsQqg4v0ebfABDeLy9FqpjENVx1Lv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIT2fkWW2oxp97N5GvKkPMdUOy35saYwnN+zGfciqZepzZIQk
	lQ+jmY56g/MczaUIYZ+1NXWUSpCGvP6wYKjON2WeiRKETCen8IX46C5EFv72lobsCj4/Xegbzwb
	b4g==
X-Gm-Gg: ASbGncuPL2elkVYnhOu3MucDq3UCI6XyNhvlvZcgEqYJlsDXBGmkc588nqvWQK/jcOu
	H4aJdBKaNWL/8+A729d7GE/c4bJpql7a7dmD3L383CnrYavNRSVD/8DUOqaNOFMEr78LuURhHLs
	EvwOY/55Pm09oPOLIwMWYGOa4hKjwxVVWfdzbDZQz5923LQAaZPawj7PIJh/yHB3xO43joQpGiK
	HwwPsAE6iUuaz42O5MPygpYtTuq3coZ1waXR08AAtA7wjPCHHcAJEHpHXXr4IVdMxo07l1ir9hY
	y4aeU9Pcxirc+ZH18954AwcCfSuTLcU+PA64QOj0ikonUAAu8KGBDGw=
X-Google-Smtp-Source: AGHT+IEj76oBkl/F5WTevwitrbZjwkv1IZjxlyaDg+2May2ycFKszVPTvXYS7EliI++GW+Us0ZmNDw==
X-Received: by 2002:a05:6512:3988:b0:545:aa5:d455 with SMTP id 2adb3069b0e04-5451810917dmr177448e87.15.1739312217321;
        Tue, 11 Feb 2025 14:16:57 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450470b69csm1151847e87.129.2025.02.11.14.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:16:53 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-545039b6a67so3586104e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:16:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmF0QXSo0KQjlDp7x67pW3uwqdaChob9dyVbAgbWiRTaNwC3FPN/GMDIW2JGp13xRGInSb3ki40LFxFew=@vger.kernel.org
X-Received: by 2002:a05:6512:3691:b0:545:6cf:6f41 with SMTP id
 2adb3069b0e04-5451819442fmr182315e87.48.1739312210792; Tue, 11 Feb 2025
 14:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org> <20250204-bridge-connector-v2-35-35dd6c834e08@kernel.org>
In-Reply-To: <20250204-bridge-connector-v2-35-35dd6c834e08@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Feb 2025 14:16:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WXkqfWoAiqbsfWiJo259oQxMV0UrQsX=qD5nVH=Dmaqg@mail.gmail.com>
X-Gm-Features: AWEUYZmmeWZCqEjhBQK0EshkrCCF8NKprJL2-UJ0EsnsvngShwlhJQxLIfqImNM
Message-ID: <CAD=FV=WXkqfWoAiqbsfWiJo259oQxMV0UrQsX=qD5nVH=Dmaqg@mail.gmail.com>
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

On Tue, Feb 4, 2025 at 7:01=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> @@ -374,12 +377,15 @@ static int __maybe_unused ti_sn65dsi86_resume(struc=
t device *dev)
>          * panel (including the aux channel) w/out any need for an input =
clock
>          * so we can do it in resume which lets us read the EDID before
>          * pre_enable(). Without a reference clock we need the MIPI refer=
ence
>          * clock so reading early doesn't work.
>          */
> -       if (pdata->refclk)
> -               ti_sn65dsi86_enable_comms(pdata);
> +       if (pdata->refclk) {
> +               drm_modeset_lock(&pdata->bridge.base.lock, NULL);
> +               ti_sn65dsi86_enable_comms(pdata, drm_bridge_get_current_s=
tate(&pdata->bridge));
> +               drm_modeset_unlock(&pdata->bridge.base.lock);

Oh. I haven't tested yet (my device is at home, but I think there is
an easy solution to my deadlock problems. Drop the modeset locks here
and just pass NULL for the state. We only end up here if
"pdata->refclk" is not NULL. Then we only use the passed state if
"pdata->refclk" _is_ NULL.

