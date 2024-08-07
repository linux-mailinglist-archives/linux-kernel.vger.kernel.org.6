Return-Path: <linux-kernel+bounces-278659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5994B343
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C4528264F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D41553A7;
	Wed,  7 Aug 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VrSZYn+i"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B94653A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071246; cv=none; b=cavibTEty6TEvMtADr1bYn39HRjitqqw9mDfLxN9XMjtFpyRf6mCJHIB9mETbHgOtL4XBKzCnihLi2EhSEP2TLXJ6rxb6jerAMbdggzqMEXlrw3CbwI0O7Ucq5nO4tIpQyjeF46YNk1YdjSH5woTezokJKP1kWLwVUpm3X1JiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071246; c=relaxed/simple;
	bh=5tmPSPCRnxVg29p1f1upnHy4D5hR9Iee8d1TUGOrTcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prZANuduuN7uh7dh16g8vJeoUc7yidPUzAF0/xbSLHGAbqcSfl4wSmtQlGBN1O88LK3C8jkmwhdtneIEBGWWuFZQA8nc8lKkjFo6+BzDVyeUG9qPhSvIXs7Vlv8j7rFQ9W7rVtpMGXiottOij4i8qo8Bue2pN8VCuYhg8C79pmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VrSZYn+i; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso49830166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723071243; x=1723676043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK3hwGrnj/zKkxZtckbcBC2CUlwS0OkjbgptQLHblIw=;
        b=VrSZYn+im0y35jXpnZI0Bz9+MnmlTTMrSVlxhhbNtJPFu1HRkrFy1Ie+vp4rZ0NMCT
         Hx4s/gKQHTg41D+tOXnhFAzdSgRNu08AUDkZTrsgq/4gdPwzflZNIC67uIgT6i3P40Rd
         8wEAxPYntuDdJh9gEkP77oPOTdI/AALM2JyPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071243; x=1723676043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK3hwGrnj/zKkxZtckbcBC2CUlwS0OkjbgptQLHblIw=;
        b=PATHPuwjeGztUJlWXb0GxsCsnejDv8NzVz+F4KdXDUNtKuYNetBIK6MlZZhTdbE4ua
         UoaMI7WtxtSs1x4TmihlPwPqWphqu1VfQduW1oWvesY49iy/wUTAVL6l1E6tkY1qv6J9
         00Ji0UCKo1EIPPrquyEOKe0nReUxk1CWcw51go1IGbz5wjhJQh4xyhHUweUKf28Qu2RQ
         tCWUNe3GJR9yt7fMCZxf/5shq2yWaJV5hNWBisbwVCTcNeDlDYRUhDvsN8jVlS+rrx40
         5BUxApCDnIkFWk92JkxSx8VwOb569KgMQ8n1NzZiWD2o41L3MpJiAJGEvHOYix7buTrU
         BNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/X/IEVfiNz7ZHzP/n6Gs04RlRjvOFFDDfV6ua29xb0MfXHYpfQeBGUkoifvZqb2Mz2BJCp85/e5X5dGkW+Pnd1qv02+d5PFhL8KMN
X-Gm-Message-State: AOJu0YzcGU+nncjxX7/7dUxhRm4K1PQrpltQmekYVgzlh2ozoWenkUxn
	4OYZCdM1B3jg1/kcfuwGVuLZqQFq7fr9No7tO+V02irqb4drWDX4y7pPxRi8BxP7a8N+hNNm3aS
	pMw==
X-Google-Smtp-Source: AGHT+IH4HPeEs1ztjiG4bHhm8QQmnBUWNR25poXGKb3i/CQuGK4Zf/lph2jQQ1h4BQ6PLZ/eQVvfVQ==
X-Received: by 2002:a17:907:1b1c:b0:a7d:e84c:a9ed with SMTP id a640c23a62f3a-a8090f038acmr684166b.65.1723071242893;
        Wed, 07 Aug 2024 15:54:02 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8067efcf0fsm189684066b.145.2024.08.07.15.54.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:54:02 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428063f4d71so14645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:54:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIYIMymsMxiJyFMyQn4s/sAPeaz0/i+QASwI7UumYMpAwbsc3vJtbaGxwSvQZ3Sa8rXaeIgXJmdXOUGiJpIR46Exr/JCCOCkSKWqrq
X-Received: by 2002:a05:600c:3d09:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-4290aa7b8f8mr276815e9.1.1723071241590; Wed, 07 Aug 2024
 15:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806135949.468636-1-tejasvipin76@gmail.com> <20240806135949.468636-2-tejasvipin76@gmail.com>
In-Reply-To: <20240806135949.468636-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Aug 2024 15:53:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vh6J9nHFpvy8Tj0OWj9fYWuuRSy=P-t+SzvyAN21Agmg@mail.gmail.com>
Message-ID: <CAD=FV=Vh6J9nHFpvy8Tj0OWj9fYWuuRSy=P-t+SzvyAN21Agmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 6, 2024 at 7:00=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Add more functions that can benefit from being multi style and mark
> older variants as deprecated to eventually convert all mipi_dsi functions
> to multi style.
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 194 +++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  10 ++
>  2 files changed, 204 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If nobody else has any comments, I'll plan to apply this midway
through next week.

