Return-Path: <linux-kernel+bounces-515869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD62A36A08
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E568170A18
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232F770FE;
	Sat, 15 Feb 2025 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LYXh5m9a"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BFD74E09
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580152; cv=none; b=c0mtFc2h6WdSzWcFnc0PWCo1qnpODrNdglS07q5pPqanTq2cQhfTzUh/z6QqrtrxCIlodYmFb5X3kI9xJ8WwGoOVdaLVF7SPnUDhsO+svT8/mYTrAZROAkhC3I98hf0VljQzJKIdWcpZvJvGawayzh3BkVW0LWAvxtOdBZR0xOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580152; c=relaxed/simple;
	bh=8A9VukIKZjL5+y0kfyvQdLBGzqyRaXOD7xTAsHPas4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exGx/AOwFTuaEbMbDkXzp8CgJOCq8Q8m4HeHSHZeGlxUT6NZYl5AOh5uZ2hCKKKiPxXjkSK11w6pm8B0M6iJmOogyzkAVBjxX3/W2c/fJQbOsLJKDGj+5AHJN6MMC6AlHvy1/eXvl+Oyap8sI1zo30DfWYRPcxgM/cEKKES90yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LYXh5m9a; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30762598511so27020641fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739580148; x=1740184948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/J1cbeKvcU3X1p/IOGIvH8IpZAtkyHcUrQchvpscnI=;
        b=LYXh5m9aocNR8pre82m7VG2lYnwQgeGsU2ccgzNgsk2lZnH8rjBWOnnJsscUIYzDs6
         cVlnbm4+6enakNfkxU4Yr26aVo5euvmJ9AloRHHeL+YMiKr2M6U9IeN8A01sMEgulhT8
         8b3xMA3FLUCKa+jYu81JyhIjipfbP8+cLAVwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580148; x=1740184948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/J1cbeKvcU3X1p/IOGIvH8IpZAtkyHcUrQchvpscnI=;
        b=J55e629V2G5s7thOaQrTYm2xTvKkrKvrc+cBjiERFk2MTCv1WKZBdYTFkxdo2kifGb
         mRA/cSpWHNMq4ac/FOM2KAxgGRcOAYV+9jJJ/H1uAXe9ssmgxkvyeEQkutWQdIEkxCWY
         zK/DhiyUdyO0huNzV9gMplLgCvOxjvbuxlgW/Sb2KDr7VvUUSzA45JW4KUPABYs4mA5k
         y96hmIJiYPioEgPVr06jb6uYKFqwef3B2qi1WLKLW4GZVNnVnIonTPPKp8GdfNcvjHBo
         KbsPRqRAjCHjPRFuOqF2nrS+XxgetRpqsqE9xiuCVatcT/XPvVrplorOfAdXILouX5e6
         Z3tw==
X-Forwarded-Encrypted: i=1; AJvYcCWHsu4PSrhp0S7AhYiUYT9XU4rpPcOhtnYWwLxOfp3NGC2laZG+wLlixitdihv9EhiG0MSzu98klP81huc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ndVcP8+0+UDgedOK0ck85rut9Xs7u/Ubh908rrydlMJu0DoD
	/CyYoc4JupKSi8+k7znlvLu+8eBvteEwIF59/3HXMxVKFNE1bNIlLSn6g6haziT8e0OSPqqirFG
	kantZ
X-Gm-Gg: ASbGncvBxB2V7fqyVcOfjVe6j6OwDoOyb/TkqXnTmWgOP+9dJhTRlnhf9aVkTXA/NAZ
	3EOvUrtBr7INeb8lVxGcyv3raBAgtaVbwY9YaFG66JK1BJrF6qYMdEnprbh41G9fWK+lZ/Daa1y
	AkbWQ4pU1/NgmaEPWQOjfF8AdX/cF2/wi9w54oZRdhKQX06/R++bbpvWig2tTQeW+J121gohHAo
	5pEzUjHKgOW/f5mINqBQRsGrntAp+Nn7ApVnKLwNcRfTvZo4AX0ZW604VIGyr86KnatbIg+LroC
	GGSBPjvCCV6emrUeKmEy/4xxoXQxSVzQCjf+5xq2GB4u1z+CcafwZHg=
X-Google-Smtp-Source: AGHT+IFK/PzvKeSNcbvn1PdjPV3MvSwxo29EFtwH9Dh+cBgyYSNE03QYYHfPBHNXHdRaAdUD7oIclA==
X-Received: by 2002:a2e:91c6:0:b0:300:1ea5:1655 with SMTP id 38308e7fff4ca-30927a47351mr5082371fa.15.1739580147687;
        Fri, 14 Feb 2025 16:42:27 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c536bsm7506651fa.21.2025.02.14.16.42.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 16:42:26 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so779686e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:42:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwnkg+MYiLckGAj/GlBxF7Axrqd+8+k7hbD3c9uiaLsOA7te+ulDz/v74/wjS/ZauF3sEGNFpsizlP8DE=@vger.kernel.org
X-Received: by 2002:a05:6512:3b0d:b0:544:13e0:d5b4 with SMTP id
 2adb3069b0e04-5452fe26478mr426302e87.10.1739580146459; Fri, 14 Feb 2025
 16:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214172958.81258-1-tejasvipin76@gmail.com> <20250214172958.81258-2-tejasvipin76@gmail.com>
In-Reply-To: <20250214172958.81258-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 16:42:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=URp_SJ8RBhwgX1sW22EvscMA9y1OZUSu_F-79DrTFRXg@mail.gmail.com>
X-Gm-Features: AWEUYZlc1dsZ7mE3BumU_xd1MLx_j1s_3MrYKpaZYO9q40UxvaVtfpj_5FGNv1c
Message-ID: <CAD=FV=URp_SJ8RBhwgX1sW22EvscMA9y1OZUSu_F-79DrTFRXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mipi-dsi: Replace mipi_dsi_dcs_set_tear_off with
 its multi version
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2025 at 9:30=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> mipi_dsi_dcs_set_tear_off can heavily benefit from being converted
> to a multi style function as it is often called in the context of
> similar functions.

Given that it has one caller, the wording "heavily benefit" and "often
called" is a bit of a stretch.


> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -346,7 +346,6 @@ int mipi_dsi_dcs_set_column_address(struct mipi_dsi_d=
evice *dsi, u16 start,
>                                     u16 end);
>  int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start=
,
>                                   u16 end);
> -int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi);
>  int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
>                              enum mipi_dsi_dcs_tear_mode mode);
>  int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format=
);
> @@ -379,6 +378,7 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_=
dsi_multi_context *ctx,
>                                          u16 start, u16 end);
>  void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context =
*ctx,
>                                           u16 scanline);
> +void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx)=
;

This patch can't land as-is since it breaks bisection. In other words,
if someone has the first patch but not the second then it won't
compile because there will still be a user of
mipi_dsi_dcs_set_tear_off() but you've removed it. If they have the
second patch but not the first then it won't compile because
mipi_dsi_dcs_set_tear_off_multi() hasn't been introduced yet. You have
two options:

1. Turn your 2 patches into 3 patches. The first patch would need to
still provide the old function, the second patch would stay as-is, and
the third patch would remove the wrapper.

2. Just squash the two patches together.


If I were picking, I'd pick #2. While it's nice to separate out
patches, this is not a very complex case and adding code just to
delete it two patches later is a bit silly. That being said, it's a
tradeoff so if someone else has strong opinions I wouldn't object to
taking path #1.


-Doug

