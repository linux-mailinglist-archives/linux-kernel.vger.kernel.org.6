Return-Path: <linux-kernel+bounces-177865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7978C4584
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EC02871BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091C1BF2A;
	Mon, 13 May 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5DikCJu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB01AACA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619622; cv=none; b=FmmsQLNlUt3kjjlx3020ojOlwmYHKDHGmivlN779qzKjHJrZ9vzEQN1uek0+eVLj8HHEtCgUlal8VrBW7X+rxcYfwc2bGfPkIuuV8XqlAj52HLItQEgiDhSglALSyO+rGzTebuKOt6ccmbFGUCD1LxPwycRV7obZlzXTcBF/hz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619622; c=relaxed/simple;
	bh=YYFNmagXwYenMvrQZeHGqPcSeLkOUSvA17gfwuU2HIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ph7ErhsqfKZWbRhqWIQnjs29ob9v57wk1qR09j5BXKE6DrX9ckgqx1uu7YK1NA0uXooFOup5e+XjcBo8YStWFaRWc/jqNvaMxPy+qyuOwyxbZJhjgZOpPnsAFvIcwsm3RFZysc7aCrdkWNFC1TFXhyaIr0R9fzixeWB34wHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p5DikCJu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-520f9d559f6so5362066e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715619618; x=1716224418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VvJAKTAjtjf+05qkCH0L1zTjltbF2Wcxv3NsnRIjV0=;
        b=p5DikCJuiFCnmXlk/H5jyNSTdvXiMiEyWs2UXNcgz/WxYKL99VImcD2tk8TWv2trdn
         xqzfiTELOf8zar40aWxwTLL/N6MbtnMI+f4CW3luUYNTvXsL456aKDbydKoi5ZAhVAK+
         YRc3eUaohbOBSUwvUj/uEiMgNXKvSZ5i8wjvoYiroRAbu1341CPFZRU2fsffaq1eU5Gh
         mtmBQLDSFqOdOmshXb/2oNGl+p9Cv0+gcnyynH0RjqWGCxoXSVwQRmzKJhFTnihq38/W
         Qzj0Fb7oX3OcHXYFj5pxYgGiD5ec89AVCW5HpQFj6n7Mvrcdfe0lUvUrzzAhNln63QSu
         GXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619618; x=1716224418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VvJAKTAjtjf+05qkCH0L1zTjltbF2Wcxv3NsnRIjV0=;
        b=cjLoisBtFlSo/PhSjGUIGkYyVtUOOx2Ua4qZ5oO7CZOEGVY5lvjlKDJfUBtde3nyZm
         ts9DzcDKpV05sj8/qB6HF5WpdZPS9jxkEe4wN0dMkfxqbPFXoFG/ZmiL0s4iM0Rx1eUD
         /Yb9zReo3g7XYgqSYjBd1b7sEmZvPMZ4APFF0aH7tCr9GCFy8kZnp+LqnCSNplWGzxWu
         Ui42SPYIZhKz3iXFEQxYl41LRpFNOsxY6+MN31leo80L63ZY9BBdDZ5stnMw10+nkXyC
         89mhZSBx6htkEkza3NLS4V/MHmpCdcMdCGS1s91COblwId6i9XADAD4vZTcdsXkUPn2t
         fRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+HYkVCCX4HepZVWYEDpAX6mbYWICrpwkm2r0vaGV+3hjcHB1lkspzUJefxFkFsq03rCZ1DBj0hbPztDYBa6lxfOnOecKOSsb3kcl+
X-Gm-Message-State: AOJu0Yzk+cMLky8UiB+Cq8NVC2zFUaLpZKezA0ZRN9/WffJQmk4LB0Tu
	tJdlE5HVxTuYPhSPqny2lFjayC0QoQDqI2JNb1zuzq31S4Q+RH7mQPBlNWPxbYM=
X-Google-Smtp-Source: AGHT+IE1mwrThPnIipbuTaOPXZfA9vT+nYi8u59/SRJqtpAcxW7ICkkb44kAR6TosurkezVDg5IVjw==
X-Received: by 2002:ac2:4437:0:b0:519:2d60:d71b with SMTP id 2adb3069b0e04-5220fb748e2mr6498931e87.22.1715619618592;
        Mon, 13 May 2024 10:00:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d898fsm1828634e87.208.2024.05.13.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:00:18 -0700 (PDT)
Date: Mon, 13 May 2024 20:00:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, Jani Nikula <jani.nikula@linux.intel.com>, 
	Hsin-Yi Wang <hsinyi@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, Joel Selvaraj <jo@jsfamily.in>, 
	Brian Norris <briannorris@chromium.org>, Ritesh Kumar <quic_riteshk@quicinc.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] drm/panel: novatek-nt36672e: Switch to
 mipi_dsi_dcs_write_seq_multi()
Message-ID: <ejpuzvwdzjtakhmunl3247lhnygdfxhbt36hpcqtytx5kifni7@ctfmhbr3ch6f>
References: <20240508205222.2251854-1-dianders@chromium.org>
 <20240508135148.v4.6.I3c08a7d02c467d2bc88da14e513ea4c8649fce45@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508135148.v4.6.I3c08a7d02c467d2bc88da14e513ea4c8649fce45@changeid>

On Wed, May 08, 2024 at 01:51:48PM -0700, Douglas Anderson wrote:
> This is a mechanical conversion of the novatek-nt36672e driver to use
> the new mipi_dsi_dcs_write_seq_multi(). The new function is easier for
> clients to understand and using it also causes smaller code to be
> generated. Specifically:
> 
> $ scripts/bloat-o-meter \
>   ...after/panel-novatek-nt36672e.ko \
>   ...ctx/panel-novatek-nt36672e.ko
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-988 (-988)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init                6236    5248    -988
> Total: Before=10651, After=9663, chg -9.28%
> 
> Cc: Ritesh Kumar <quic_riteshk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This change is only compile tested. I don't use this panel myself but
> arbitrarily picked it as an example to look at when working on the
> MIPI DSI macros.
> 
> NOTE: as of the posting of v4 this change still has no tags. Without
> any tags (Reviewed-by/Tested-by/Acked-by) I won't actually land this
> change even if the rest of the series lands.
> 
> (no changes since v3)
> 
> Changes in v3:
> - Fix spacing of init function.
> 
> Changes in v2:
> - New
> 
>  .../gpu/drm/panel/panel-novatek-nt36672e.c    | 576 +++++++++---------
>  1 file changed, 289 insertions(+), 287 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

