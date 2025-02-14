Return-Path: <linux-kernel+bounces-515331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02528A3634B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73693B18EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F62676DF;
	Fri, 14 Feb 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHkaS6kK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE528635A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551119; cv=none; b=PLoiZJU5W2VURK8/99kvh1w8PLVS+wd04rjBTwWlxQE4z5OV0gOw+pY5KVTKxtk4to/g7iBI3xFRivGyg4OzsLisVGnI+mT4LF1VkikrwknCJykr/rUB71JUjYqi7djcIT1vib7JbuxGiIoxSUY3+zzvXVW3T/Vc2o9XR3A12B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551119; c=relaxed/simple;
	bh=VKYl3Nsn2NimvcdgEDGnOcpoDd1TswHbuLrWgbVs/kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K97MiyeY5ldfXGIvFHrhx8E6OuK5dtOE36var964aiKjlURdiHrKhaTu3J8zMIu+UvlNJ2W7tw8aSgLwOZYOTJxPqNAWqJ81bX8ydtpcBaF1rGbxeDGl4pdgDAPNAtosPn3jFLqml+qlAhcxcLM7kq9hSvukNGg32NdTbQIaxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZHkaS6kK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54527a7270eso953090e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739551113; x=1740155913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiENR5Ei6ZKv4VQ0yGfBeOiN7n/8XjskxjvRSd0fnk0=;
        b=ZHkaS6kKKrjfplzU15q5GzsXrI4iG7SCvN9j0xg1/bCCAv8W1dbHyBlwHVIOM3gdfs
         im4BgYgntpokCNaybS4I6yzKu7FVs+7tg5ZqPDmLWYfh6tXw/K7v6VRjp2YRM+FpPIVn
         g5wLSF6+cZoC6i7khRr7owRy4qzwVrqEZtkhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551113; x=1740155913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiENR5Ei6ZKv4VQ0yGfBeOiN7n/8XjskxjvRSd0fnk0=;
        b=QXCHi2i7iR24Kd9Amg9mOJACG1tSpQsSlGz5+i/6RIEjvxeRkKyyYF3KEHXgEpVcq8
         r0mCzSgo5MMIyfxrCKQI3PFBaddR4CsnvIyjeyF0BtzL2HELpyHyLMceQIIRz4duz5Ch
         c14LTzvFkTh0YirJprpqI6iNSbN/CH//JKVWTdm/GkPeqaE1ypChyRRvDSQ/B8RLbzXj
         AhOtd94PRO585G5V3D52oCxEUPQA9P2JbY7C0AGNii1VK3LpWcJ/uZhr4+ZeBAEJvD4P
         1XYj/o+UMzNuvHwxgeR0F5Hse9K/o+g7YFjDqzcBs4ZSXYUGLYpuVP07Br7H7AXZdtAO
         T5+g==
X-Forwarded-Encrypted: i=1; AJvYcCVXmNYdnIAt5pmUOuE9PFn6QVVPKuw79BHGu7afAZJ8qJ5EtqRDecKKo1wfmG5hkEYCg4w3LvEfmMyBxVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZPeVI95u20OuiXuWIqAjtUZi/y6cj3NsPQk5S2iJDTYu1v6j
	IxowN8FqDy19MIfKJzDiFlJXJX8ZOngLsoM6cLGLhmbKk+iLDOZgZvXKbXFoSsr8g7kwm/UXnOr
	xJg==
X-Gm-Gg: ASbGncvwEw7SHTD6MWWbEKRUOUHeppZ+ApARbTuwp96PWKlsHirYQoJPgowPAm2o5ob
	+SNBzlVmTz7fMrkQVAz/Tjia2ep1sWnUiJpFusOsNWiquyxyhovX3vERD9PAiOay/YrfAlHDXLZ
	xN60nj6p9N/xYxXeSblhrToaxqXTa8PzSThpFBTUdTnpWr/b1fq7b3G9v79abk0ohKvhwyAYjcT
	/+mTpwFHws0FdU2FBI30o7kH8gXhdBhMwpswR2cnX6q6mSjlcNrl4j1sWVNvLlXzCCuKTLNhorY
	ZHkDrIMcnZQnnMuZp7njkj277pYDhHpzmGsYaDLSQ0OGqvnjeqhsXJfw/Z8=
X-Google-Smtp-Source: AGHT+IFkEIukqamkIlk1pwOLJ4fIcxN1a6zVfQtJzAk4NuLMFDMKpz4GRJZXPBTsv4yRiqVo3u6JDA==
X-Received: by 2002:a05:6512:1394:b0:545:f70:8aa7 with SMTP id 2adb3069b0e04-5451818942dmr4844769e87.32.1739551113313;
        Fri, 14 Feb 2025 08:38:33 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452f676aa5sm51974e87.50.2025.02.14.08.38.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:38:32 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-309025ec288so21426961fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:38:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRWRyYOAN/zUZb+bGjT90VwSSpJFUeSmppuUJS825lDn6Hqt+6a0XbeA62h2HFbN8oeYotQ7WxaUhLbag=@vger.kernel.org
X-Received: by 2002:a2e:9246:0:b0:300:330d:a5c4 with SMTP id
 38308e7fff4ca-30927a49b85mr626221fa.10.1739551108840; Fri, 14 Feb 2025
 08:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org> <20250213-bridge-connector-v3-37-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-37-e71598f49c8f@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 08:38:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uwq3BZNmESmB0Ra5y-jJCb5bi-UTLknrRhVsUbuVbvCA@mail.gmail.com>
X-Gm-Features: AWEUYZkDTyh9KPW7vj9obdMVUza9a_l0OTDPgjC_IVV9XEkSBuB7Tzn1y-D7bMw
Message-ID: <CAD=FV=Uwq3BZNmESmB0Ra5y-jJCb5bi-UTLknrRhVsUbuVbvCA@mail.gmail.com>
Subject: Re: [PATCH v3 37/37] drm/bridge: ti-sn65dsi86: Use bridge_state crtc pointer
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 6:45=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The TI sn65dsi86 driver follows the drm_encoder->crtc pointer that is
> deprecated and shouldn't be used by atomic drivers.
>
> This was due to the fact that we did't have any other alternative to
> retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
> in the bridge state, so we can move to atomic callbacks and drop that
> deprecated pointer usage.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 58 +++++++++++++++++++++++------=
------
>  1 file changed, 39 insertions(+), 19 deletions(-)

While I'm not an expert on all the concepts addressed in this series,
the patch does look reasonable to me from the point of view of
ti-sn65dsi86. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I can confirm that on sc7180-trogdor-coachz that the display still
comes up after this patch:

Tested-by: Douglas Anderson <dianders@chromium.org>

