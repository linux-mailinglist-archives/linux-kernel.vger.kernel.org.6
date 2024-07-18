Return-Path: <linux-kernel+bounces-255795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AF8934554
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71461C2156F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FDE10F2;
	Thu, 18 Jul 2024 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cs1xMgtU"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B3139F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721261899; cv=none; b=uRh9jZ1jbcoE4K7EYX88bnL6zvdnwy+QCpy/8JHn896ttNb6fBCGP4cNGKZlBRwUC3bIm1YQ+WMRFHPErxNkntIIvd2Kkhez6QKdvaV7gSXK8rOJnG8S+kmTHfvUtt1sdHvlCHaMRB9UjrtyogSR3ixDC0MSL0VLZADCvHM/bWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721261899; c=relaxed/simple;
	bh=LDZP5PjnqCXHTDVJyKWG9YjKqovok23dIPj9ME9VSZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA9Gt1GRb/+2cNgfbHTe5wrHwUlk8wzYRUfqntG5iJZNc/Po/iI9xQjm8v27lfclGs+3C9dmQL2G5VilnURTSfQOPqkSHnChC/zpKuflxKpz0G5UqLOT4dHeBwXVVY+rjeUq4kUNAO0YNGRakyj7K5mOpzCGL1iJ8pxX5n99rKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cs1xMgtU; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so267031276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721261896; x=1721866696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR5TgSXxmEkVnQyI32oZApsa806xibThRKsCEzfjQ2s=;
        b=Cs1xMgtUAuzNnmdLvpW8Og71KU0tYqR6Bq6KOIa/CMDlZFSgUmn8uteqERj+WBaeW/
         65OW6Y45HIpGtKtfJyWmuPGtwQ5zEclrMUw3LnGFP0zMocI/66KxeoKFBwYYn/7XIlck
         5HpSLbOZOYUT4oZW+FB+g4bSziuo4QGDGjxV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721261896; x=1721866696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR5TgSXxmEkVnQyI32oZApsa806xibThRKsCEzfjQ2s=;
        b=iyGRyPPYFu2bhVNPGcUgt7GLz3ldB7tmBfqSrnENdyiYNgi14JPZLM++xfKvmZlQ3k
         Yjvzr3Vyg1SWr1uHwgYZ+hE63EXxC95rJW1KLn46IMorW5HpC9hhnV49kRgSfK9ZBOGh
         /T87EhCz/4khY0CrnA56NHQhHaZ487NkiSd9SNrXjFL4UhSkq1sS1qz5IxJqDMhh0sOl
         2ZIUNjwLBodAyn1LzJH5sM6+2oqCYKssuIBtAqZE7Pplarf/cQf6C7Udma1xcfrkb51d
         Xzg41j7eaFG3bzEYjZd3vLj+hBOGaOFs3ovyivkwv5QO4xFSgALt7PqyRwjvhbwYKHbb
         Iw9g==
X-Forwarded-Encrypted: i=1; AJvYcCXi8n61ozVP8U7/sIjdgvcDhfyk1LolZkf6PFiZ0iCebIcGyz1ko06HJZKVouYrxItSmXWKO2cDipb+OEVla1SLwUC0+zcLnn4aJMOd
X-Gm-Message-State: AOJu0YxOrwxwscyQEZt1tOZOLCrToydcJKiHgD+e5c2943FMUkrugBef
	WKAdV7K50mlfDyhQxO4NiYVtjJINfvkhQwAGcFPm9li6NSSgH5L2XuHBSHbaea9qAwp4JGAB+vM
	=
X-Google-Smtp-Source: AGHT+IEmk/H+gZvV+BD2vN0aebiV/Wm4bpa1gA3Ls9qgw0c/6pYKZQ/dSl0vhZ1a77tuJjyDYDdupQ==
X-Received: by 2002:a05:6902:2b08:b0:e03:41c8:4fbf with SMTP id 3f1490d57ef6-e05feae1051mr1410809276.15.1721261896480;
        Wed, 17 Jul 2024 17:18:16 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c4ba0e0sm3447886d6.28.2024.07.17.17.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:18:15 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447f8aa87bfso156611cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:18:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2J9NpdrM9KveCJu5lkFgTd82v9xL6XJ/XZtxrzS8J1QoJJlYCcC4ect7jXbHRGfItmXA6QFRZY2U0nISrjtC5rAhuOAl/cxTlMXF0
X-Received: by 2002:a05:622a:2506:b0:447:f5de:bd18 with SMTP id
 d75a77b69052e-44f925cad76mr430051cf.9.1721261894932; Wed, 17 Jul 2024
 17:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717215847.5310-1-robdclark@gmail.com>
In-Reply-To: <20240717215847.5310-1-robdclark@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jul 2024 17:17:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XCOKJHJ-yzENpvm_MD34tMR5LRy2m2jYdcWzZXP4pfXQ@mail.gmail.com>
Message-ID: <CAD=FV=XCOKJHJ-yzENpvm_MD34tMR5LRy2m2jYdcWzZXP4pfXQ@mail.gmail.com>
Subject: Re: [RFC] drm/panel/simple-edp: Add Samsung ATNA45DC02
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 17, 2024 at 2:58=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Just a guess on the panel timings, but they appear to work.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> This adds the panel I have on my lenovo yoga slim 7x laptop.  I couldn't
> find any datasheet so timings is just a guess.  But AFAICT everything
> works fine.
>
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

Given that this is a Samsung ATNA<mumble>, is there any chance it's an
OLED panel? Should it be supported with the Samsung OLED panel driver
like this:

https://lore.kernel.org/r/20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3=
@linaro.org

-Doug

