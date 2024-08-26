Return-Path: <linux-kernel+bounces-301663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D395F3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7807728132C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E318BBB8;
	Mon, 26 Aug 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hp6+avs+"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B57BB15
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682241; cv=none; b=Bdo5L5QoHIRAfywLBlg/ULHbV+nhWnkW30O/L/SP9xa1+hyLTN39h0aT+Jw50VkqcJKHv2OgphTzOKttvEE8UA86a/NPsNYoszKFr+MVWv8miKwpek9yeyshlihP7XbnfsR67w6GtiNT0DAuiVlD6+X7pHWHn8mkcYplJ4Hb7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682241; c=relaxed/simple;
	bh=UL92+vyzkc0m9kFXdIlxB4ieGvkBvNaiN0vIu3JAKQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saCZYzrTupgY+/lIa1fL61WIBUaP5wZ1isIq7erbgJVgx2vERQDnC487Vv8MJxCmtcXAdSk/RwKFh/AYSuAZncsC/ZSwKzK+f91JtqSydV4dgwpZ/lisNR96WqK0vm5znDbhHLOedX7dTAQuak5DVFdogkpJVlsiROZiXRLk20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hp6+avs+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf953cb5d3so20668696d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724682237; x=1725287037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwMj193fRnQWJj8EMVK/Yl7VxbK3hJ7E5fMVl5t23FA=;
        b=Hp6+avs+dl97CMNikd5HLzMZxCVov9rD0NUT/BWnuk5a/5Xq4sjsMeds2qPcmgps4K
         zjjs/3DwEeO7FUD9ZJRX0y8h8nZol2WMTUc5XbbgPbsr6UbbciJIPZMMC20KdhEe1KIG
         aLL1QI+mN9G+cKRScoTpEYtYf3hFLVyqMPs+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682237; x=1725287037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwMj193fRnQWJj8EMVK/Yl7VxbK3hJ7E5fMVl5t23FA=;
        b=WOAIdpaVfE62dkS98XO6IrgjnMx+8xIie7S94ZTXxIIBfCPy7JaMWLPmsoZWCGmkrh
         xddNipt8NjbMQ324YY0Yl3FXkYfou00pKljsuhLv82KFXe6zSCLhv7/yGgci9Ey9juag
         b31SAxELoz3UUckkI0US/urd0mrEtXkvkBhkKQobBNkzQqve/1hfF4BwZjJGFJUqO7oq
         BSVKdIodf1q715kzNXRyfN1mxVvZ/5U1jqCjUpP8C4G+wC7gc3lx5HrAOSh2dfzRRj/T
         5tHQXTHisqjfjeu+7qZ/eIbvFqD5N5MC0kDOLlVbOP8Etya4eDUU+Z2CQ+2qYlwzfNXe
         8XdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX88EuE9SpnulLXzrK4gqslQcrxad6eBVjprSsek/iETjyqEeB32w+cyIvliSdhpCv85jGmiNJtTOYvgzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFH4purJMeeNXivLrSdU7o/ILb6ZsIWEBHDUX2y/zwCKljuMvl
	Ogwa0IarMfzsbskT9fZXmVcq3HKXelwCa5KNoZbP0MGypuRaAC6Yoeend/gYTCHnyizY5JaB7hQ
	=
X-Google-Smtp-Source: AGHT+IFf95mAT18mgMKST/BAsaAci+PiH5sBZOhiqNWXg6JHVK65qxclLokBsMFQe76DAAeraR2XRw==
X-Received: by 2002:a05:6214:4381:b0:6bb:ab4a:dbdb with SMTP id 6a1803df08f44-6c16dc2adc4mr122340446d6.1.1724682236950;
        Mon, 26 Aug 2024 07:23:56 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd0afsm46916786d6.120.2024.08.26.07.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:23:55 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1da7cafccso252475785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:23:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsapPkqeEbdPMoC9gus+uB+xR57bKEShhPDyD4Kz8F79ZWUS2n9wNNARvYUMksUsqX1ASag9uZjhy0qkE=@vger.kernel.org
X-Received: by 2002:a05:6214:460f:b0:6c1:7508:9372 with SMTP id
 6a1803df08f44-6c1750893ecmr106950466d6.9.1724682235124; Mon, 26 Aug 2024
 07:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-drm-panel-edp-add-boe-ne140wum-n6g-v2-1-2758e8574842@linaro.org>
In-Reply-To: <20240826-drm-panel-edp-add-boe-ne140wum-n6g-v2-1-2758e8574842@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Aug 2024 07:23:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7EWhuse=74di=RVLTU6FFXQh1M_Z_a2wHDbOpeU57Gw@mail.gmail.com>
Message-ID: <CAD=FV=W7EWhuse=74di=RVLTU6FFXQh1M_Z_a2wHDbOpeU57Gw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: add BOE NE140WUM-N6G panel entry
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 26, 2024 at 5:39=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> Add an eDP panel entry for BOE NE140WUM-N6G.
>
> Due to lack of documentation, use the delay_200_500_e80 timings like
> some other BOE entries for now.
>
> The raw edid of the panel is:
>
> 00 ff ff ff ff ff ff 00 09 e5 66 0b 00 00 00 00
> 1a 20 01 04 a5 1e 13 78 07 01 5f a7 54 4c 9b 24
> 11 51 56 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
> 36 00 2e bc 10 00 00 1a 16 32 80 c8 70 b0 3c 40
> 30 20 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 1e
> 3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 45 31 34 30 57 55 4d 2d 4e 36 47 0a 00 dc
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Added raw EDID to commit message, as per Doug's reguest
> - Picked up Doug's R-b tag
> - Link to v1: https://lore.kernel.org/r/20240823-drm-panel-edp-add-boe-ne=
140wum-n6g-v1-1-7bdd3c003514@linaro.org
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Pushed to drm-misc-next:

[1/1] drm/panel-edp: add BOE NE140WUM-N6G panel entry
      commit: 51394119f640423858a2f04076d6f1c3e83fa715

