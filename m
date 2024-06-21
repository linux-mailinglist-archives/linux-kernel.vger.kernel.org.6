Return-Path: <linux-kernel+bounces-225260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC361912E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614171F2138B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29016D303;
	Fri, 21 Jun 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYjh5UiL"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811216A927
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000172; cv=none; b=ui1mL0p6Se0c56iV8T1CHF4cQri+Ku+plgW/Qjf4Zyii/N7Cq35cixPmMSxno/wcnm+Dau5/EemfTbtQOR8KjSmJ5KOL/Hz0SKJZlQQ9GWfNY67TQZwAT+8jZ7EtxBMTA82ek3j0yn8V7Y1GWcwVngNQbcuXzdboXEdyQ4Fofb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000172; c=relaxed/simple;
	bh=xLxrckKxenRWojAVtNotEwtfDdxzK9gUNGs+uK81Eo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayAmDWd/rMPtofp+BUL8xKNNGDtp9TNeYY2/TCmwnb5hBedU0O1+0BfoNnNEaPxvWbw5hTIKglht7VaziDEROzcOr/hmmGOkPP6Qj6tX0N0YC5VxJZ40XpFieWYSBPGkrVnPJ2ltjedgSZ5QATaX3fY3pp6jw1c6lNFgDQLdcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MYjh5UiL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-444cd0ee46aso1745331cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719000169; x=1719604969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/uBKlDZ6s/NosH2EbtFFnSeeJIPIQZN1klDMiCHdsc=;
        b=MYjh5UiLSKQ9QSNp2s0TDYbL/Ebq7cZGYi2VEbrO92CJpalLsuJLrlHvtZgP4hbGJs
         YP69eMyxDQgI0QhR2ansCmUD7lt/CDXnU+nRVM6eJFhKfFeSRKjCrEUDuILU1fvaZSQ/
         b8YI+Li9izKd3WVVQ7kGsMm1IKMcUBPQsIxz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719000169; x=1719604969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/uBKlDZ6s/NosH2EbtFFnSeeJIPIQZN1klDMiCHdsc=;
        b=QdZqsXU007o0tVyl4K9iCisDK41eUbwb6A1R4rFm7FYGB99ACN80jewNwaFPQ/goK0
         DJ3EntPm0GnkHCiMf+SHHkjfRqdOpUzGLnegCJgD6I/mPwhbcUWEHa5wa4rKSVi40/t3
         Kp4iyWM3UinWmMGecAk0GS+9FME5hVESIzVh4pgARenAGtppF4ImaOQN5UpIXpbM/0DZ
         Ek5s6Hz0i4Hd4PDmvqLSw1gl7xX8KOy0/uf+ylx2flbFwQxjexXse3hplTA7K6Txb8BH
         gI/DRE1DXk7aeXFZFIk+/bENsYKx57Tttf9SdmgZhgCdZi+ITti4j6gsnlAqIJf5rB6U
         R7zw==
X-Forwarded-Encrypted: i=1; AJvYcCVP1ynvLPW150Pz/bJgY+tEkVwL5IACAMaKMyZM+iD8n3RS92Vk412iP4kMcCQedy6gsUL4Wbv49ZsaGaEYJYdlS43Sh48atd47zh8c
X-Gm-Message-State: AOJu0YzOF5sAvwksNdOcZxY4GjECmVUhI3JYrO3HgMSble7D5sKRE2Z4
	VSt88w6J+1TMdjPuhj6BBhyTxF+/5ESCQNUVAKrLwOJx/6KaUZ7IHqdxc4M4D0umGp5IAsYmPb0
	=
X-Google-Smtp-Source: AGHT+IEkzeyob5RALDSXFW9dpI2AGOr7t6DG55Lf4Sgp/2zvLrwwP9ufCN9WGmxiNZMI4hfipbESbw==
X-Received: by 2002:ac8:5a52:0:b0:444:a628:6a1b with SMTP id d75a77b69052e-444a7a1e0f0mr99906061cf.10.1719000165428;
        Fri, 21 Jun 2024 13:02:45 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444cec59d0esm67511cf.72.2024.06.21.13.02.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 13:02:44 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4405dffca81so280461cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:02:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkj74A+m9dcCrHbWBhZg1PRHtnNpyRuELhnijotTKIGastf+Wwb35k7PEAHmBk2p3zIi115ITO7XuYOvlGxeMFF15+CoOPxqHM3KJ4
X-Received: by 2002:ac8:7d49:0:b0:441:55ac:c490 with SMTP id
 d75a77b69052e-444ce362ac9mr242691cf.20.1719000164202; Fri, 21 Jun 2024
 13:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621131648.131667-1-tejasvipin76@gmail.com>
In-Reply-To: <20240621131648.131667-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Jun 2024 13:02:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WDA8LTpr84zfTqefFwxpbKC+rVo1BsSAVGVHReC3X0=w@mail.gmail.com>
Message-ID: <CAD=FV=WDA8LTpr84zfTqefFwxpbKC+rVo1BsSAVGVHReC3X0=w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: asus-z00t-tm5p5-n35596: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 6:17=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> asus-z00t-tm5p5-n35596 panel.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 140 ++++++++----------
>  1 file changed, 59 insertions(+), 81 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

