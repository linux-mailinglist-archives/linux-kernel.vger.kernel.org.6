Return-Path: <linux-kernel+bounces-278660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E394B345
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DE01F222FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB52154BEB;
	Wed,  7 Aug 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AOJvN7oU"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EC4653A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071252; cv=none; b=uxxkm6QbiYD8qGQkEYyqrtKGJ9HbCfmyl7Zg/X1tYjQ7/NI19pCTuMhamavltMYnbAoJ97AYwZPKzLd8AvvTjAHXUqsSYHfYeQeEoqfNGNwRB78Bft/YmGKddGoXJ75Gf0uL5UGEDK8WRleTfGwhBgbt7hXLpqOBNtraMDTh328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071252; c=relaxed/simple;
	bh=5tmPSPCRnxVg29p1f1upnHy4D5hR9Iee8d1TUGOrTcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB0u3Ub8j24Ak3t3Bxmq+xl+/GCxkrrL5IOlm+leKpyvafIrVTH41XrTHnokc9N3H9LU03q2P/bPlMolGr0XEo8eulyqp2TptJB9GcwtHtvQkkpeCtB1NIuWHp2nwZnhriL5Fh8rnamwWhF30V2KJbvmQwbSEZXd3yki6jTM6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AOJvN7oU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447d6edc6b1so2222051cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723071248; x=1723676048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK3hwGrnj/zKkxZtckbcBC2CUlwS0OkjbgptQLHblIw=;
        b=AOJvN7oUGTp6sHNkjgkui4bCCizIU/lZtNPm8sugbSV+THZFmsa3n/wkOQiCPJmHsZ
         5m/YFtS53slVHXUI7ZXNaKCobrB6ZKz8c3hrxsPb8WYhIuzDurevkQoNjCHeTuL7Vd0T
         g7RPXCiYwDPItOlq1VIYjmAFPVRgjXCx/enmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071248; x=1723676048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK3hwGrnj/zKkxZtckbcBC2CUlwS0OkjbgptQLHblIw=;
        b=k4lqLeYx2LO4496bJmx2DktKS8jFcGg4QUtsbEFy+ytKJcDwwSaQrXtoL0UUbJ2Dyt
         UaJqHAXdpGmdfMGdxCuLgCdNWD6xlUOIL07JkS0eymAEOdBxAG9HDsiONCNrMhiGSy/G
         QSVny3C0/dQlQNnayr3GyngjSlT59TiEsNWnR0SpCZ96MIaNa9Y7wEsjKQoxPnj1RzLM
         YQ1VruTvK0GjkO6Kdz2BLw3P+tLLxQL7+DrVeCUpOrhkkhkMJldDA0hXvxiK9HUJxrUU
         yZFe1/6HdIVYv8I0gS7Mb4R3AcBs3UWLDdbIGvxpn1KuUxQvlLst5EREJzrYdqznQwLa
         QZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCViRNsbUJqMCaMARsRn1nvpTwamsOY3rJtKMUNeVNgtGdxy9KEhMw/ky+s4yE4KwG02MMTK2Ei5F1wtK+23iKkn9uMortV214ikOOPn
X-Gm-Message-State: AOJu0YyVGruFFGMGeIXmYf0EOivcFAjcf8t4Dpx/5nti5ewnj7szKRBV
	ccTbT2JjCC0wronkRl8CkIsTnY5w0CjxLdZZEg1Z5xkvLNO4q5JPlqddVZ0/lh6x2+XgRZBv7QM
	vfg==
X-Google-Smtp-Source: AGHT+IGag95DRfT6qG9nHy54Am6E6v7qIGTUMc2tZKXnFB/NN5UkYW1dmbqzVWY5ag7vSjjXlHiZig==
X-Received: by 2002:a05:6214:4901:b0:6b4:f644:9d87 with SMTP id 6a1803df08f44-6bd6bcdf64amr2596136d6.21.1723071247954;
        Wed, 07 Aug 2024 15:54:07 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c87e858sm60625526d6.135.2024.08.07.15.54.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:54:07 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45029af1408so54481cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:54:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwkXmbjBlpgdTHCmJO/5sO7D6UwipwozTXw/cgQosX2jaA4WSiU98CcpJO7/9YrBhfD+SRd9Xl0zkYolu6jVJBOlljE+84wv+6tIsS
X-Received: by 2002:a05:622a:652:b0:447:eaaa:c852 with SMTP id
 d75a77b69052e-451d384a4d7mr540481cf.23.1723071246934; Wed, 07 Aug 2024
 15:54:06 -0700 (PDT)
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

