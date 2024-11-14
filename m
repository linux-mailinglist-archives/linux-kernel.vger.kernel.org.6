Return-Path: <linux-kernel+bounces-409939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA789C93AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C3B28620A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589291AE016;
	Thu, 14 Nov 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c8uvZJRs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A31ADFE3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618096; cv=none; b=EdsLYs6oe8yB9Qj2iVbZZOuvlKv0dms1xEpGEQrtk9phDuprde3wneFQ0cMTZkV2en5Smq9GiWhdB90USQVc+1d0w5ybXpsJPxryDVSWLHnvXn8K81lx/BpP2NIThf0CWgumda6EE8N2TZWtNdDpcBs83cU43/R/g1O+YYtP0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618096; c=relaxed/simple;
	bh=WdnN9RkWEY0znd0mQ0/IW3+fPe1D/YjFWy/FwIstxpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD04xMLybcD02vqf8J7dJkWojS6V78WACs3hfilea2mcCqWt9wpQZ0XddJIPoZfC/VbJLh//1ZejZGq9WzRalk4y65QYveG2BflGpV/tQf0jl+lwWb3ZPl9C8O1Q70ai1RnVQHX3tMwsZ2pUD0XPhuwzBwXsFc5F6znUcTl2Y4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c8uvZJRs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1151103e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731618092; x=1732222892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnUKVo16ukwoIjQKD09CO7Jp33xMIiEIYirHJ325zac=;
        b=c8uvZJRsrd4NQ1QWbo9IPuo4mj6CSwl+HV12FHe32jq/HP4/oGr5KyGh12TRpWzDCe
         jFew1JhSFs0sMyWnDJnhG3d+BZwiP7n0iILk+JNxnld3W9Wp2OyzvJkqZy6qJ2wL3TAE
         7k0wkxIJUHVBGG9bo5/VoW76IPtVDClxhwMB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731618092; x=1732222892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnUKVo16ukwoIjQKD09CO7Jp33xMIiEIYirHJ325zac=;
        b=hAQerZszki5e/zL2/8G/CiT0aDfbOltGwlYxDfo7pGRvUJB6bUFrKoUxZGw/JNfw3C
         cZdGX5/hd9Y/9uRHT1w/tkjqHvdS9u0rgxL8wV0/lYAOrvU4V59yCTu4T+c4Y7K/xvWl
         K3sYHt/ijEMkx9hMgy+51Mckbt0PG2kDVYSjnCUrgrTJIbx2rb1p6KGCQz+F6TMCg7N0
         lkqw6KEJud8POfEmclrN9UUBKTVX0h/UnVsGQHzVugNtQ7/WwJBqWaA8CIZ/bvL0xqme
         oKXQQu9sTtGU6WRzIfLfPHuYYbwEmPKlupV2joAmy/VouYE18se7m3JJ+BVY2tEh1v7t
         zQlA==
X-Forwarded-Encrypted: i=1; AJvYcCVZgze0WSX894FPJn5qEc7jIgQwxnSHYkca+a/D7h54YfgEh2zT5ftHhuKI8TzWEH6dC55RFIzOV9bFdwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49G78iFMMZaf3sWmpj7eLQhZA/w0euOxRdovWfyaH+SRp1M7k
	g6RIbTOZBpZWjv2f2B15DHKFPW+4jcoAZ+hkrJhxSQp3FKTe0HsAtjNwKb5WJ0gl+uMnkYMSKlP
	C2g==
X-Google-Smtp-Source: AGHT+IHlrOeA6RMmPoov1BwyKZaHHI3GdteVwbTTACHN5EcUWMsFDRZceL3kFG6bKY/R83aJO5xPGw==
X-Received: by 2002:a05:6512:3d2a:b0:53d:a5f7:ae76 with SMTP id 2adb3069b0e04-53dab298a91mr103059e87.12.1731618091773;
        Thu, 14 Nov 2024 13:01:31 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f9c0dsm314640e87.35.2024.11.14.13.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 13:01:30 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so11745251fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:01:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXimsaepWsS+IwhXnm+zZQZXn119+1RFLKDvvKV+1ALeVOeQ4OjTpzGCbGohLutwdsZCCNBkftJvaxvduI=@vger.kernel.org
X-Received: by 2002:a05:651c:88a:b0:2fe:fec7:8adf with SMTP id
 38308e7fff4ca-2ff609be35fmr1805451fa.38.1731618089985; Thu, 14 Nov 2024
 13:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113090022.332586-1-yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20241113090022.332586-1-yelangyan@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Nov 2024 13:01:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V_jYygpcCcU0H7UOL2AY5vbg-y0UpJczwWBKyc4+L8kA@mail.gmail.com>
Message-ID: <CAD=FV=V_jYygpcCcU0H7UOL2AY5vbg-y0UpJczwWBKyc4+L8kA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add KDB KD116N2130B12
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 13, 2024 at 1:00=E2=80=AFAM Langyan Ye
<yelangyan@huaqin.corp-partner.google.com> wrote:
>
> Add support for the KDB KD116N2130B12, pleace the EDID here for
> subsequent reference.
> 00 ff ff ff ff ff ff 00 2c 82 07 17 00 00 00 00
> 1c 21 01 04 95 1a 0e 78 0a 63 25 99 5b 5d 96 26
> 18 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 87 1b 56 88 50 00 0e 30 28 20
> 55 00 00 90 10 00 00 18 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
> 00 4b 44 31 31 36 4e 32 31 33 30 42 31 32 00 17
>
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 012dfbcb9475..5355acd52f0b 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1978,6 +1978,12 @@ static const struct panel_delay delay_200_500_e50_=
po2e200 =3D {
>         .powered_on_to_enable =3D 200,
>  };
>
> +static const struct panel_delay delay_200_150_e50 =3D {
> +       .hpd_absent =3D 200,
> +       .unprepare =3D 150,
> +       .enable =3D 50,
> +};
> +
>  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, =
_delay, _name) \
>  { \
>         .ident =3D { \
> @@ -2134,6 +2140,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv=
_a010.delay, "116N21-30NV-A010"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116=
N29-30NK-A005"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "1=
16N29-30NK-C007"),
> +       EDP_PANEL_ENTRY('K', 'D', 'B', 0x1707, &delay_200_150_e50, "KD116=
N2130B12"),

In the future, please post patches against upstream Linux. For
panel-edp.c, you'd ideally want to post against
drm-misc/drm-misc-next. Specifically, in upstream the entry right
before your new one should have been "'K', 'D', 'B', 0x1212", not
"'K', 'D', 'B', 0x1120". That's been upstream for the last 6 months...

In any case, I'll resolve the conflict this time since it's trivial.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add KDB KD116N2130B12
      commit: ae4a812a64dad3fd4f7bbcd7af215cb68af8cf8c

-Doug

