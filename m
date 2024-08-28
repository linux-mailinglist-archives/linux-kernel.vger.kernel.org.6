Return-Path: <linux-kernel+bounces-305132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4A9629F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2712281C63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954C189B91;
	Wed, 28 Aug 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARHgpekO"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC1188CC8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854343; cv=none; b=TuJWSrplJwbeUrkFkVrQl+nJW6nVM1eW58LcbYC8He8pu8fq51BITIr+rkGBrd68YTC1y363w22pLygn+cJFf3uiPOAkugih4Y0YVbqjKqJ8ceRci/5uj+Rk+38PukVLYeJlkYD/hmW+CpFLr/HrqeCvzc+AY5tjZp+MFSBmoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854343; c=relaxed/simple;
	bh=yeb0hXQ+hAEFUQKfRJad92+EuV7jrYPXxhHm8CrSlm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFfJaYV8Z02WOqf4ml024jvLNNt/5gcuaFDmKhvfQ99B26/UNDmo3rbIzSgXRID/hos3jr93kIAuYW0ew1Wef4wNCPwCUReWvkr2GNkp5GvSRJoBJcOtSx/iMz02KoC2SoBEld/E/xSIeSPt1CbBAIliHEk0bnhRMSL5oBjgX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARHgpekO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf705959f1so6454836d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724854337; x=1725459137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuabzWElUzzHdL1Mbm0egMjDIW45P3GOeFaGyaG57xY=;
        b=ARHgpekOGxjeTNhOPCEdL0KEDAPlaxbs2bgSVh+JUnJ4NS2DjoHGCbyWp1AH+KTWZG
         0w/9xAYAQP6Jm3927Lbl/ZbqLu5OoPTnovypMpMpsZHcILT/wsiZCm9Ek9dhto8jHstg
         SnnWOnDeVjm8dQ+36Lv6SN0/TYbr6PN1fkK/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854337; x=1725459137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuabzWElUzzHdL1Mbm0egMjDIW45P3GOeFaGyaG57xY=;
        b=MiQc9lFo3EfwnaFeda7U2h2e+qBcLwujwanfzYsf3Ma3QwPvMvvza/SqrttARt03tR
         dHznA88DyLT02EH4EeIu0eBptdey0laQFgAB3NZWZCwpH8o87NmDGWpcHw/fEPA2OpDT
         Qgdz0+iTRreVfoBH0AOq063OpNBKLZ1UTLh0MMPeGCcYmOO78IyvdquZ5ElH7kyymEgO
         PgoNckqJYwlP8umb2tM8+qzeq+82TuXP7m2bXzO9j4WH79x3Xq9iQO/OKdtVpApp/6Dn
         NDE/i+osiQvzdATV9Da+yfIE9zKWIrRVDp1JcmwQBu0LLeucqyzNXWMay6fJ1nG3kZbN
         gfcg==
X-Forwarded-Encrypted: i=1; AJvYcCXAJDxLuyDxhFPxxuiZMtF9mpZmEFW6BnWaBxkhWYJj+8go55Y6hjizZeuSBoOrEHm8RcsALsHRrgmSerA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAbgwA59DhDo6+7hOJkXxBIMR3EA99vf2mOSsT6E1C6xrvvyf
	U4OGLuDO1vc0P962jcLPUI25v2UNrg6x9+3g3FC01PWhSD0wxrkOGXKLtoj59p6JPbpqQhpyXAQ
	=
X-Google-Smtp-Source: AGHT+IFVBqVtE1F+AJrGvZf5JgTlQs2oYswmVAV6klnd986fMB2cVuUvQU007r+LAfMw+564ao9PBg==
X-Received: by 2002:a05:6214:5f01:b0:6c3:32d5:e94f with SMTP id 6a1803df08f44-6c335db4a80mr43850596d6.26.1724854336896;
        Wed, 28 Aug 2024 07:12:16 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcddadsm65950906d6.121.2024.08.28.07.12.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:12:16 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so5475176d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:12:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcXab26uSuaLwl/svuia7lkMNyxVxBzgyI17yrMYqDpS9+rj4Kcz96VsUYl+Gqw3w3LeQfyijmW2Ycl4Q=@vger.kernel.org
X-Received: by 2002:ad4:5147:0:b0:6c1:80d3:8d2b with SMTP id
 6a1803df08f44-6c335d62c8bmr34636536d6.18.1724854335299; Wed, 28 Aug 2024
 07:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-topic-sdm450-upstream-tbx605f-panel-v2-0-0a039d064e13@linaro.org>
 <20240828-topic-sdm450-upstream-tbx605f-panel-v2-2-0a039d064e13@linaro.org>
In-Reply-To: <20240828-topic-sdm450-upstream-tbx605f-panel-v2-2-0a039d064e13@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Aug 2024 07:11:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqmdjrM3jgpGEX=DqrJLYySpgQ9w+zK0mR=os_5wA35g@mail.gmail.com>
Message-ID: <CAD=FV=WqmdjrM3jgpGEX=DqrJLYySpgQ9w+zK0mR=os_5wA35g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 2:22=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> +static int boe_tv101wum_ll2_off(struct boe_tv101wum_ll2 *ctx)
> +{
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> +
> +       dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +
> +       mipi_dsi_msleep(&dsi_ctx, 70);
> +
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +
> +       mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5a);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5a);
> +
> +       mipi_dsi_msleep(&dsi_ctx, 150);
> +
> +       return dsi_ctx.accum_err;
> +}

optional nit: now that the single caller of this function isn't
looking at the error code, you could make boe_tv101wum_ll2_off()
return "void".

In any case, this looks good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

