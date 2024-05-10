Return-Path: <linux-kernel+bounces-176254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A299F8C2C10
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585BA1F21CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE413CF92;
	Fri, 10 May 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3SiguoT"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F113CF85
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377594; cv=none; b=noVh0qjOQ3c2Sz+xZUWH1GGNQTPMt1sJzsAadj+v5rmVwaxoup//FnP/2UZAvDiPNDVLzRWPxEdKmNys1465hKaBc0gxaq9TgVrieM6wOl03tsThXy3ndH6bGMyB44bFp00ql/HY37TsrxzXVXqydP7osgiKis6GVkFfJoAdj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377594; c=relaxed/simple;
	bh=UCWb/BigwkR50o/nRi0sPh4T9acKc47cIx4rKSb2SHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtClsJ41tKVemeQ6ssXXNnpGVFQkLNaOSadjZiIsWbb3AG7iq5soLkvblJHmhKxkTzYmW2WHcpSEuQsmkaPHAQlWYFticjcIKCspa2QD9tjOIe2sOzvOONFIQQu5RbV0kMygk5sxBRxJr3VwZ4kPS5Xsyu16DocX6FRHWF9h+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j3SiguoT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8c9046bso197582685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715377591; x=1715982391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Svr4jT9bdrpFXgOEkVqTf+8fIAlHYmRmltVZYBHBIQc=;
        b=j3SiguoTotsZQTsGnhAywyzS7FgX6sA7ovdb1N8h0FPJgNmOMAJW1taq1D4ZnUxb34
         /JUZXYB5r2GGuEH8s6wjZqHAufVqDHB1GayUEVXvueTyRNJHV+02gtgowg1Ju+wX5iPf
         2Xtd6OVRIdWKeElz0VGruWa2ZkR73FuosiVY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377591; x=1715982391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Svr4jT9bdrpFXgOEkVqTf+8fIAlHYmRmltVZYBHBIQc=;
        b=K/u7/yJVR/geguUByMskn5hw94KBsV154xBDJObFJ24bGjjI23MSSFjTBmu17YVzzy
         QWKygzhOyOmT7/mVXr9tdmuhfgee+2f77Ml0B3IfLH3BIPjbzYTDRe95AG6f5zS2Ui2g
         Mk42RB0tUeL1tojZga0RjAkRSKcYO7EZoQKPjh7BnmKY217cNllvjammPE1VHX1KBTkT
         J5HbjxO0ebgZjo9F+IgVILTC25NSnWCWQqkcH/yPF2pBXPX9lb0pBav4ZUu3pddrZLjT
         r5qTgOqffRzyL1W6CwG64knH9rwD0+vIGomgPKR2XRMFo9wzZk9KaCg2gHaQSbu6q6N1
         Ipsw==
X-Forwarded-Encrypted: i=1; AJvYcCXv3HUldebO1rqjHsgPEO6UXezMgPpuZIu0hh/lcAHoby4XDqoNQUartt2BJAgBxEbMCwi1+rOjabK8Wnfe9XbslvvcQ4EU5Id5NtZl
X-Gm-Message-State: AOJu0YyB7Bi4gjRdAYTKBoaj7L5JFnIbg0B4x16vAk2TPTCc22yMDNru
	UpwXMrW25pOi/ZW5J7EWwbVZu2CTyTeIIUFVOyjA0cTUvRLGGz5J76esjX0v1tGmVwoCaH68+5U
	=
X-Google-Smtp-Source: AGHT+IEAF1cP+rP2iu4Ra6Lxdcd4qe0CiozvlFzZnuGyfhk4U7QbMp5jNs09XfqbZWNNQ0Nrmdwbww==
X-Received: by 2002:a05:620a:844:b0:792:8ec4:74a0 with SMTP id af79cd13be357-792c75aef63mr386350185a.41.1715377590899;
        Fri, 10 May 2024 14:46:30 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf277f6fsm218009285a.14.2024.05.10.14.46.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:46:30 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-439b1c72676so41751cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWjjKqX28FWbSThl3iEvsXfZ3mBZ/5XFTpAsKxI1z7seqqZxZ5FDPEtSC/CRo7RYfeYbFzKAqPh63nfbObWKkSp3ZDepxJ12N1/ofh
X-Received: by 2002:a05:622a:510e:b0:437:b572:6d with SMTP id
 d75a77b69052e-43e0a2240ccmr150251cf.21.1715377589421; Fri, 10 May 2024
 14:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-3-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-3-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:46:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkCr62jBtvTmYASxEBT8oOv7yZq=XjDCtEsOxgyQwV4Q@mail.gmail.com>
Message-ID: <CAD=FV=UkCr62jBtvTmYASxEBT8oOv7yZq=XjDCtEsOxgyQwV4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] drm/panel: ilitek-ili9882t: use wrapped MIPI DCS functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 9, 2024 at 3:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> @@ -424,20 +420,14 @@ static inline struct ili9882t *to_ili9882t(struct d=
rm_panel *panel)
>
>  static int ili9882t_enter_sleep_mode(struct ili9882t *ili)
>  {
> -       struct mipi_dsi_device *dsi =3D ili->dsi;
> -       int ret;
> -
> -       dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D ili->dsi };
>
> -       ret =3D mipi_dsi_dcs_set_display_off(dsi);
> -       if (ret < 0)
> -               return ret;
> +       ili->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> -       if (ret < 0)
> -               return ret;
> +       mipi_dsi_dcs_set_display_off_multi(&ctx);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
>
> -       return 0;
> +       return ctx.accum_err;
>  }

nit: Same comments I had on patch #2 (boe-tv101wum-nl6) about inlining
this to the caller. Here it's even better since the caller already has
a multi_context...

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

