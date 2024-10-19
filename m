Return-Path: <linux-kernel+bounces-372902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B719A4EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400FB1F26BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493A154BF0;
	Sat, 19 Oct 2024 15:13:41 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66A8472
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350820; cv=none; b=A9rBVzx8OTZr0O4pYm7jBRXzXK4/F+wQEDquwGgaEQiYCTVHd7rHmGAFdt+nuVGUOvHALdxXqrEh95Js54nfszbAI6G0GBDMV5q7GCQ58RoNUf2+DGrlX78KtdZq+7VblsrXLZoiIhFDiBirguhp29Q5Coq7PqW821E8Tajosk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350820; c=relaxed/simple;
	bh=T04Ci3DpcQvFUjPH9Q1Wr6AuQqtqxIqvEsyZQ2eL8Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apEqSn3tdl+ZoWfbQ9g1G7H2aA2gos7h5Uj/PGpX8vLPGY1y2Z2KDBoHDXLS4OpNz7H1zFwn0aF7S8hrpLMeCAqrpe7tytiCbI1s/EsCrdgb120uN24qjHVW56aqc7Fw8lucmY+PpEdmwCSjJVq9ihMi0NP1L7FbMByggIEIGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso4715945a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729350816; x=1729955616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KppUXjhEPV4r0T7yVwFFdc51/qjJ3J+VTbqN9GzY1Fk=;
        b=LBhEILXI8B2RqvMqTkT1mPyxZUbgr2wBD/nDvWTGr2/yrmVMNAWXCtLXn3Fpxtb5TI
         vA36EL3mpuGxsJbnGKWrBX8PqfvB9qKka4gMaoqE2+ZQoAcydexw1k3PpKRrsxRZP03g
         eTvvQ9w3tkJ8XCaOu5UirYaUP/tA6qtNOJgXV4DT+jkfhH5/qVxrZ5Qh8hlyQfN8i536
         x8upIpawcpBBp6hwC11iFnFr2wMgwPJvcS4Q22Uzh54HJXzu7uERHrFfdncXNLZnqHUP
         2tIPVNnPGm8vXvQR4H4EZR4dHS/B6Q29VgygrQrORp6Kl0EOcta75KkNGaZhAEaep0OA
         A8ag==
X-Forwarded-Encrypted: i=1; AJvYcCWMMgoFC7a/7wy2SEVnQABN91ZpolNf0daVOje9p9rPOJixnFKjurJJq3Nv8TnZtdAnQrRsmaLPvhroVSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Cgil+JYJ2ZH2RSzFs5jk5YuaQ8k4Ejl6CW9Kqm7LbIyTym/P
	9mMwVzLz7NXoH0pODaMnZHQSKTf7Xh823RMTI3BL7+pKrwHgTAwWhgB1Tc9rsEs=
X-Google-Smtp-Source: AGHT+IFaT5s8pkCxILrPSfezYiho+YnUIhEnsx73OQs7uyvUcToE9a0vVrfNQtR2jn7/XsuDW53mUQ==
X-Received: by 2002:a05:6402:35c1:b0:5c8:93fe:3f7e with SMTP id 4fb4d7f45d1cf-5c9a5a27351mr9139717a12.11.1729350815517;
        Sat, 19 Oct 2024 08:13:35 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0e6ee0sm1925599a12.66.2024.10.19.08.13.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 08:13:35 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso7075870a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:13:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfbfii6+rWxvAMsSW5RHgCF0WDHSybO7ncNCUs91O2NBqEDHsSerzAXqukYmM/ph/GmNkw8Z/GtGt2Pts=@vger.kernel.org
X-Received: by 2002:a2e:be07:0:b0:2fa:ce0d:ec34 with SMTP id
 38308e7fff4ca-2fb82b82228mr21240541fa.2.1729350485763; Sat, 19 Oct 2024
 08:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
In-Reply-To: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 19 Oct 2024 23:07:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vRDTJtQHKiGLV73Pep2PN7LHTZMRK8k+N0cseVWL6vQ@mail.gmail.com>
Message-ID: <CAGb2v66vRDTJtQHKiGLV73Pep2PN7LHTZMRK8k+N0cseVWL6vQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/display: hdmi: add drm_hdmi_connector_mode_valid()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 4:34=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Several HDMI drivers have common code pice in the .mode_valid function
> that validates RGB / 8bpc rate using the TMDS char rate callbacks.
>
> Move this code piece to the common helper and remove the need to perform
> this check manually. In case of DRM_BRIDGE_OP_HDMI bridges the check can
> be dropped in favour of performing it in drm_bridge_connector.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Makes sense, code looks like a correct substitution, and AFAICT covers
all current in tree drivers.

Whole series is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
> Dmitry Baryshkov (6):
>       drm/display: hdmi: add generic mode_valid helper
>       drm/sun4i: use drm_hdmi_connector_mode_valid()
>       drm/vc4: use drm_hdmi_connector_mode_valid()
>       drm/display: bridge_connector: use drm_bridge_connector_mode_valid(=
)
>       drm/bridge: lontium-lt9611: drop TMDS char rate check in mode_valid
>       drm/bridge: dw-hdmi-qp: replace mode_valid with tmds_char_rate
>
>  drivers/gpu/drm/bridge/lontium-lt9611.c        |  4 +---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   | 12 +++++-------
>  drivers/gpu/drm/display/drm_bridge_connector.c | 16 +++++++++++++++-
>  drivers/gpu/drm/display/drm_hdmi_helper.c      | 25 ++++++++++++++++++++=
+++++
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c         | 12 +-----------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                 |  4 +---
>  include/drm/display/drm_hdmi_helper.h          |  4 ++++
>  7 files changed, 52 insertions(+), 25 deletions(-)
> ---
> base-commit: af44b5b5776cc6ac1891393a37b1424509f07b35
> change-id: 20241018-hdmi-mode-valid-aaec4428501c
>
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>

