Return-Path: <linux-kernel+bounces-176261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63C8C2C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D431F22FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3D13CFA4;
	Fri, 10 May 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vg7jpKrZ"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E0481BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378036; cv=none; b=aE8R2Ui8zSJKnZqOs3kKYav4V5bluXn+1YYNN4uuwpO+aOB3HSdGS+xYXJCnIkGN6pP2z/zZa0u2ZiW3pRdUiHdsed9r+y274hr0Bw/asy/xuT8Eta9+CcY7LxqLn7l3kfK/ELpxhy1S4LdkqGtcCnTKnCrtpMfj4inOVW015kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378036; c=relaxed/simple;
	bh=WI908szRHCH1XNL6Uf3+xanagydATcFvI/XQegG64Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulJZnAQFumwFlREkUxXfwYOxB8dH967ZzVTOXDYG3iPwBIcYV78L4bMzxVQyK0xDlraYoss+0glk5+o7Me4kZj53vDp9LCDGXNonkqQEjGBWJt8oGmLgthYBkd7U/lkJbQ+8amhE/4+oEWmEP2iIcAjTo7AtKDT7qkI1lcvwrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vg7jpKrZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a0ce3e823fso15951226d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715378033; x=1715982833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/extV98TSdFy/1bGvQt4l7C040wMqG+QLoAthDMEcc=;
        b=Vg7jpKrZbVGxn4ndrTL5lNLXBXaqFwdHijsyUhBosdgW4GiFq/STjzhlA75o9ieN23
         ysUnQBRJ/O65/3lnuv7eEYU/FTal0vX7goUi+OF+qCXohDPco7vFs0b6Fh8ZlvnMwhkz
         CDkNNp0bY486RDDvEmwREgm/yl+Ga9X8uiw1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378033; x=1715982833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/extV98TSdFy/1bGvQt4l7C040wMqG+QLoAthDMEcc=;
        b=onwTO8FdxD+WeKHMzEcJ0aUJ9FBLMMBWlEL6ShaTGT5NetTOZQqC+WG76mOlWAlGzi
         kSt1DcraQE8pGrjCI8l988fbxMPgXuRYdLWB0n39NFflYNpJ9yIqrkgbgw43HED4vsAX
         PrXInS2Scfv/BNwLdUlMI7QpD6HvVhyQsSjB50WS3Em15u5Li/KReyFuHp/cg8CBrMGt
         k72E59gs3/D0a2ubwOcdCWaZt84Lbf9L+QzEGGQD/kH7+TObPe9e1G5qhd4TCiqK0VSt
         Xs5b0NI9phlOLC3CgS6GHiHZE4SScuXdYA9GBLjlXj1gyQxN1xkOat+435B/z0YobfVM
         tPfw==
X-Forwarded-Encrypted: i=1; AJvYcCUfDTBF+b9u+PKclYx1DLeMyOWWn/o1ypRTjbVIeJiYvwGHTTWvzJgcGcJvyYnvv0WmpceBcwKhctVT4Zw3+79WwD9nKWWgBHXZVVEp
X-Gm-Message-State: AOJu0YwGfTceBuWJbR1ZhcUHKP3HD78UGnlZdQfx0oxcz9HpcHNgpAgW
	YWgNfae34jYkZAbKxZpOOJ1Kjk7sigYcZj3WxBsGAmvt5PqML/zu3lXLyS1a6zTLdjBNF/wgvF8
	=
X-Google-Smtp-Source: AGHT+IHkQ4LLsixzFsn5dZ9gVHZpxp6utfBC142vhx5ePJwIOwpEgD3sGq5LusOgNt3j6YCWL58BuA==
X-Received: by 2002:a05:6214:3913:b0:6a0:b705:27db with SMTP id 6a1803df08f44-6a16819ec5bmr35566426d6.13.1715378033485;
        Fri, 10 May 2024 14:53:53 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f18656esm20700386d6.53.2024.05.10.14.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:53:53 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43df9ac3ebcso98801cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:53:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqCwD3v5RMoGakeRcC2xwcF9mNC4sVwg3LNre+J7Duv1HM4Jpw0nKVeTQ2WL0u6hwpqfiKlmqkUpUbkiHYGCz+LvFE7b3YhGoJZD/C
X-Received: by 2002:a05:622a:192a:b0:439:d5e3:1f31 with SMTP id
 d75a77b69052e-43e094b27d5mr781411cf.4.1715377636922; Fri, 10 May 2024
 14:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-6-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-6-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:47:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uu2=6c_3Q44BK384cgSLX=++_bBbg6=CCqBaXnqcEK=g@mail.gmail.com>
Message-ID: <CAD=FV=Uu2=6c_3Q44BK384cgSLX=++_bBbg6=CCqBaXnqcEK=g@mail.gmail.com>
Subject: Re: [PATCH RFC 6/7] drm/panel: lg-sw43408: add missing error handling
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
> Add missing error handling for the mipi_dsi_ functions that actually
> return error code instead of silently ignoring it.
>
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-lg-sw43408.c | 33 ++++++++++++++++++++++++++=
------
>  1 file changed, 27 insertions(+), 6 deletions(-)

Looks right to me. Only slight nit would be that I'd put this as the
first patch in the series to make it obvious to anyone backporting it
to older kernels that it doesn't have any dependencies on the earlier
patches in the series. It's fairly obvious so this isn't a huge deal,
but still could be nice.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

