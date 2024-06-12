Return-Path: <linux-kernel+bounces-211627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1DC90549C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D9D1C20A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E917E46B;
	Wed, 12 Jun 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YE7ykINU"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDD17E458
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200648; cv=none; b=VP+CTu8R3BX3LaZ6GAAdWIgE+IbdlZe2Xq/M0uXjVe140r9Egud6wNPrWdzP0qTGu8X/dLnYClV2jUaibVTMLy0npQ9iFqO6ZzDnh3ntIT2A/2oSrYF7E2LsY6DcSNfSffuSWXbNveaFoRsbpNga9f7fA8QQcyZJiRabQGjuqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200648; c=relaxed/simple;
	bh=jyhRvXL5mxIq2sDB/1pJuLXD1fh2TyxluXgxap+LeUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl8Pce48XKEsTKyLv7p6PaPg6F+K0mkzVY2Eqem8pozdE1eE1oWNGIZRyA5S0dFC6dbMOP+rfvdq+5wVZJ60vvDp9RZCSI549Q8F9dFHmTl2MGG6xvhMM7Fbqd/knsB6yaisfz4n9eejiiV+C26Htdg2yDYoUncYeAyHuLnAO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YE7ykINU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79776e3e351so191769985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718200645; x=1718805445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRNaWp2aBUToWnoyQCXSeqRZnOtorjt+zh3ziOtXXN0=;
        b=YE7ykINUAOwYXFn9UV/myh9WKfJgcfAHR8Hgg3jGNQ8UcMWaCiLdIvQbJYTcmTo7yU
         aDMrCY+VXgvz3gxNo8IRn//mOhr6Ne13xOciD0z59Fdq1T1GLAxD5e7VsbzCWhPLw3pz
         gvcnx40AKSID3PBQytMbghyxjMaxV83Rh9us4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200645; x=1718805445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRNaWp2aBUToWnoyQCXSeqRZnOtorjt+zh3ziOtXXN0=;
        b=Zw9JEkUxwvzrN3pkxhHvMASE9t5pxxl3wDcBhapEvSMjOsN5Sxof8ZneelL2DbTG2O
         9qbDLPJkZjezKD8HTu5/ydkp+w7qJVTp+DRGkGnuPYk7dVKIpQtpx8XO1u6KKGYJ67UI
         HujSVZkoKNsz/T2lKoaU69STd9VELJ3Xhnv4IGT+/VtBLKQTiMEVWXpv4T1pPDDPxHBN
         QD1XOVUh7Zz+Q7vfRQAT+Ulf5WaonQFAT9tOJtqP244auBUBHmDslwQM0Inm6s5SePez
         98rVwaVyj5c8uiGBR4loBDIGWecVsXG/V5mYDLYx9Q1xSM4f7yXsxpaqt3FMSb2+1rDd
         GlaA==
X-Forwarded-Encrypted: i=1; AJvYcCV4JfHOLD5Wt6NcLGySYtjYZxBDRFFt3UFs6Rkwpd60LSZbDTNgXHlOXwVKAjWTlN4BfrjcmlQcH2GnsJ/EShP5COY5EFF9pimARAsY
X-Gm-Message-State: AOJu0Ywf6V4jkjXVh1CEPTngBGpi2RAuROjyR/i0RpXzMJvC9k3h7Gfs
	Sni4Q5Rpf3QFPX1xm5iuzwcvlps6zXe3re+cahWWEpCm0gGagdFKcQAIU6u6WMd86TjaEP8P6Jw
	=
X-Google-Smtp-Source: AGHT+IGumY7CYyx2LTTGriczlJJfQzYI23OQ7A0td65/Nie8rboHiHPf2+YCx8fKUgySqeeST7MkYQ==
X-Received: by 2002:a05:620a:3188:b0:797:ea0b:fb2d with SMTP id af79cd13be357-797f613270emr171908785a.65.1718200645070;
        Wed, 12 Jun 2024 06:57:25 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-796fcf184a6sm255899885a.97.2024.06.12.06.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 06:57:24 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4400cc0dad1so446911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuiDYBZM6uVS4yu6TZH4mrXOPMNW4KpyAOOtChI+DYgSTG/j/8TlD4iHL5ibn2E8qlxFm2/azHhiwKKH/7epMaS/cT6Q2b7D5Kvbr+
X-Received: by 2002:a05:622a:6208:b0:441:53bc:4f8f with SMTP id
 d75a77b69052e-4415a2320c8mr1678241cf.27.1718200643619; Wed, 12 Jun 2024
 06:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612133550.473279-1-tejasvipin76@gmail.com> <20240612133550.473279-2-tejasvipin76@gmail.com>
In-Reply-To: <20240612133550.473279-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 06:57:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtRfejhDEv675AEj6=SfLh_b=X2TLTt2hatTOLrikSRA@mail.gmail.com>
Message-ID: <CAD=FV=WtRfejhDEv675AEj6=SfLh_b=X2TLTt2hatTOLrikSRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel : himax-hx83102: fix incorrect argument to mipi_dsi_msleep
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, linus.walleij@linaro.org, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 6:37=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> mipi_dsi_msleep should be modified to accept ctx as a pointer and the
> function call should be adjusted accordingly.
>
> Fixes: a2ab7cb169da3 ("drm/panel: himax-hx83102: use wrapped MIPI DCS fun=
ctions")
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

