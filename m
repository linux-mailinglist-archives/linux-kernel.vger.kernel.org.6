Return-Path: <linux-kernel+bounces-177851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB08C4553
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29A51C22F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0861AACC;
	Mon, 13 May 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXfwRxrl"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040D199B0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619008; cv=none; b=hkEAMRPHwdcmQMmIC/RSq+vZZ0wkeBQWVFp9Mts1W16GcUVKBfrp7y+ZqGrUVvHbQFzUjpj4Djtt2SnRppYSZXe7fMj7Vff82N8TWYLrUWktJ1Fqs8LefpxTNpqkPNiOsm5LMYbnTwU/kW43LakFwHjaAmE+8tgZrOHknvxCDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619008; c=relaxed/simple;
	bh=XyqO5YqD0sOyGP/It50Q154O28J6XCuAIJm0bKJyWNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLOr9a3LRVOFxFN6oFx+luZUvE7/fsqvYPGn616EQzgsIro0S760FCQ+SzHNaukuYEnDhE7FSelNzs9C5crsOTenEEEl/+a64BNkShTWKuv27PjcnXR3BjP4j2MtnmEfQyq+BJ+n7yqa7/OBzqw5IpiNr4Tbv+OmnjJ8tJ8btl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XXfwRxrl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43e12244dc9so10850971cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715619005; x=1716223805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmdRKmR5GwP+S1V0WsXgEf9q8eN7ZBEpbwBCtyyE8ew=;
        b=XXfwRxrlsZ5ByySL2UuSmKrTxHeuQjBnsnWg9imtGlq9wdt5bBe71ynpLlRZ9DiK6Z
         LcGXNAriXzqA47D/mBc5uco+89yQrYyeB/Er4ZHJPpk02NmkdyRvPH2e2WBrJZ0WFCo6
         IVkDY1+x+yY/AxBKppoqkyIOdzmOlsg8V3Ams=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619005; x=1716223805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmdRKmR5GwP+S1V0WsXgEf9q8eN7ZBEpbwBCtyyE8ew=;
        b=MNLf0X75elh9Lt8LbI+4YthaeQywG66PxT2CvhVfvqrJsusE8gA3phEN9h27DYaHyx
         EGm4eH6pIr/5Ry7kh+6Jnkt5ksyMoB8zeBnK1Sb9v6e1fNiMBwyv3IZlBZ1aAtwelAMf
         arzYWKa0X/oT1MJOjMXiK/GGaTr8Nmke5T70B6bHgj80imQdNc0AMCrf569NYeG+2kvD
         TkLUsoKZQbta1QM6dwQiYtenFwXT0S9IRUYvDH/WuXfLTMQ4Uzi1U+VCJeUYRKEW2UdR
         qPwhsC73XoT9FdMUq/jT5E78arHptXSEOmjEF8aP48QjqLQKKy+fF7ixOcDLV7YCIY0s
         +Q4A==
X-Forwarded-Encrypted: i=1; AJvYcCW32SuSCCocL9+1sb1udGP5JHL44xmupxjGiSA+ynw+Zg0oie38zlMVUx4/1fQy7zwEGpX9yVvujVymRKmEfbZ4HWGpSqrxFiVkyhG4
X-Gm-Message-State: AOJu0YxzlKukdARKDI6jaXBUO+NdP9yQfS9iqk8+IfnTT+SPO077ovr0
	fc+qSbO7Nq7fIwBM22nzZHbNfVJnyOiS0wrCU4K9yzrExX3e7s5KvH/tBVgx3rw+ELnTjrsBRps
	=
X-Google-Smtp-Source: AGHT+IGylUCFHn8LI/cPuzN4MDFNb7yRjGVq0dPgR57FV1LtY7g1KPyb1plCd/4Br/RnGRyTJZVlPA==
X-Received: by 2002:ac8:594b:0:b0:43d:eeb2:db4c with SMTP id d75a77b69052e-43dfdd10196mr135789121cf.62.1715619004399;
        Mon, 13 May 2024 09:50:04 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56d58ffsm56943011cf.90.2024.05.13.09.50.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:50:03 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43df9ac3ebcso767301cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:50:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuaBWjb3CigoX7N1jD4i2QqGKZWGjiMX21wHKmhEe7QxIpuBmyBVKcmcQ6TZA0B390lzndQygRbWsSH+NTNxSkgLMZea9Ut4hLS4We
X-Received: by 2002:a05:622a:5595:b0:437:b4d9:ddc6 with SMTP id
 d75a77b69052e-43e0a22f92fmr4507621cf.27.1715619003150; Mon, 13 May 2024
 09:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org> <20240512-dsi-panels-upd-api-v2-2-e31ca14d102e@linaro.org>
In-Reply-To: <20240512-dsi-panels-upd-api-v2-2-e31ca14d102e@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 May 2024 09:49:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VU7KQohfuOi+hh1Hb+MEYHtCG=BytyK1aGrxhzv85jgw@mail.gmail.com>
Message-ID: <CAD=FV=VU7KQohfuOi+hh1Hb+MEYHtCG=BytyK1aGrxhzv85jgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/mipi-dsi: wrap more functions for streamline handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 11, 2024 at 4:00=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Follow the pattern of mipi_dsi_dcs_*_multi() and wrap several existing
> MIPI DSI functions to use the context for processing. This simplifies
> and streamlines driver code to use simpler code pattern.
>
> Note, msleep function is also wrapped in this way as it is frequently
> called inbetween other mipi_dsi_dcs_*() functions.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 210 +++++++++++++++++++++++++++++++++++=
++++++
>  include/drm/drm_mipi_dsi.h     |  21 +++++
>  2 files changed, 231 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

