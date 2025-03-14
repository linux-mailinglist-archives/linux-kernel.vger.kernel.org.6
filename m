Return-Path: <linux-kernel+bounces-561566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D23A6138C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FF416EFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496C200B8B;
	Fri, 14 Mar 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlMdNslb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158D1FDE0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962021; cv=none; b=U32rbh6AhMTkAsoYH3L2rPaY/b3kaA3u8GkLUFIpd9EKaKfMuU4KVMPei3l7kr7suXXYcG2a4PdZuwreE0LoNtk54OSLl9wwL+ZevSLsJ/yUhHHuw0okzWoJ+4FestkHMJkvDSm+KY5h6ZoHrpmZG1Xdo0GH8HRHOazodMxFg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962021; c=relaxed/simple;
	bh=kRhdEUvvxSRAdiVGiBUpZ7FMN0dgxdJPqQ5CZb4PqU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeTP2pYGGOOxXBpaZmlkP9x1kH40HwPo1UuRA+4yl36E8fwLRvRSdgbJkbCiH7oirrzcuH9gdMrML2P7R2h3EJSjg5kq5/Eeu0TfmO/mm09XTj2OPH4mZiF99xcMtNjtHvWfVTjYy5qFKjAiPcdZY8C3KqCKjFmQIGvqotVzEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VlMdNslb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso23629851fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741962015; x=1742566815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfJ1nD4qQC39uy7AdzGWyBQGMKQmzTpkBSOlo3nuQF4=;
        b=VlMdNslbOOF7cdpB1nxtpG08sifntuYqEL/gToPiGdYyXTV/WsWaLSN4QCTK9HlZOE
         9aczZSs6Kf6tnZdm91a//XQqS9vSFUgmZI/fUCduCKVPuIzCLhQPIiQvLkGVfPWJl+az
         MHIRIflvfGiE2TiZlLUbAtdZImRBY7szCoLrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962015; x=1742566815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfJ1nD4qQC39uy7AdzGWyBQGMKQmzTpkBSOlo3nuQF4=;
        b=PLZ8LdPw9b6SEltZM1usEOWp3yRPfWjKi7F6e8Xyf5NW+G9FaJoja3WIvLPRuE31rp
         5jokeiv7ZgmfHZ+2SXBXL5QVKbSW0yj4zHJqNGtWch4yWTmrF6rGeLJTd7afQuK/MNoo
         jnvZbD2MkekA792BlwrcSwkXpWBoESIsQXrJgKkqilzogPShL9Tmf295hMFyBCqoGsDA
         orfuWHpQWLqgImWdSNvF7EXn7gPxsHGmVtGFml6v/4NS+VfcbqblXIiZo3a2+upyLism
         XR9iSqr6hqY1x8g7H9od96D8dlDBo8GkqghUh3TSbRtrrvF22E9OrAqaBAy24VBou19W
         m8aA==
X-Forwarded-Encrypted: i=1; AJvYcCU6gb5LDnHAYS9rdKy51+W6ge2lpouwJXsx/IEmxHbvXgmFaeN97l5g1RZZ74LtxjeWN0hGTIKWShhvz2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8Q9WHfviX0npv3VO/LYUOupOJswdiSQuFjjMOCee0APJkYWN
	0GttnQUSyopCVyAYMbkAIz+XG5JRkx5mxx6/4Zbdjy4kHeeDtzxipcOmBfSAKr7hZkpJGnWTgY2
	Z6kmi
X-Gm-Gg: ASbGncs0wbGQylao8SfmJFd2Wq9oUdhfFLfRKDbhPRvBCXMCz1KG8WMdHbUIw6IjLPE
	98hH7lDPW7jUjgxviGFSQXesSU6BCAx4wuBp0HLzfEMn1GDU+Pa5HvxsNVyHRMoQXuOxZM8N32z
	oXVo4J7vcgHLdqDRfbjPfIxFu9FXoKBkO9HW/5UvI3jxUq5XUEii1mzrhWWrvMvDgKaumVeWUol
	JJ0Cdrd4kCIY83zX4fpQwbeBgCVjmxVy9P9M79AP0vSJNrvRhCxyItG47S8rGG7k+23KSQ3tKi+
	W40ZbqmJ8PwL/UZzTJvfZaVFx7IlyThIOmVV7A6JegD7zcKfoLMFvyjZSRVvuzB3PVbD7JnqIes
	CWbXgjkfxUe4f
X-Google-Smtp-Source: AGHT+IGGWPoK44lF+5mOE9dz4lWVIW2EX5K79eW1/Dbsa3a2cTUrKOLwjpSh/ChHzXHjhCIeinAk8w==
X-Received: by 2002:a05:6512:118f:b0:549:8ed4:fb4f with SMTP id 2adb3069b0e04-549c3913b55mr889657e87.23.1741962014730;
        Fri, 14 Mar 2025 07:20:14 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a6cc1sm529592e87.211.2025.03.14.07.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:20:14 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso20629291fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:20:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDcmXmSN/44T9xsbCxHOtBnictvOl3wz7D+6uHzoQzOvHvEjBU4mE3brbKlpuvJ2yuCiggwGhp1s7EpfE=@vger.kernel.org
X-Received: by 2002:a2e:b538:0:b0:30c:1079:7538 with SMTP id
 38308e7fff4ca-30c4a877b83mr8366601fa.21.1741962012535; Fri, 14 Mar 2025
 07:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-b4-mipi-synaptic-v1-1-a64ccb5e5c66@redhat.com>
In-Reply-To: <20250314-b4-mipi-synaptic-v1-1-a64ccb5e5c66@redhat.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Mar 2025 07:20:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUN7CcnjURs6xfVAFqvZ1WR86y8nQm=OMcrV_hYjq5RQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jpd9pNZVZeD6Ojnhn1MRoN3TYYAWDeFHObuLfxuTus8fvqg1YTzmRnYBBs
Message-ID: <CAD=FV=XUN7CcnjURs6xfVAFqvZ1WR86y8nQm=OMcrV_hYjq5RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 13, 2025 at 9:47=E2=80=AFPM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
> @@ -181,24 +162,15 @@ static int r63353_panel_prepare(struct drm_panel *p=
anel)
>  static int r63353_panel_deactivate(struct r63353_panel *rpanel)
>  {
>         struct mipi_dsi_device *dsi =3D rpanel->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
> -       ret =3D mipi_dsi_dcs_set_display_off(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display OFF (%d)\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>
> -       usleep_range(5000, 10000);
> +       mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
>
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>
> -       return 0;
> +       return dsi_ctx.accum_err;

nit: the one caller of r63353_panel_deactivate() doesn't actually look
at the error code, so this could be a function that returns "void".
That was true even before your patch, though. I wouldn't mind a
followup patch that fixed this. ;-)

In any case, the patch looks reasonable to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Happy for someone else to apply it if they want. If not, I'll snooze
this for ~a week to give others a chance to comment and then plan to
push to drm-misc-next.


-Doug

