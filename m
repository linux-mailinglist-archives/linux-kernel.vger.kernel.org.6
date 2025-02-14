Return-Path: <linux-kernel+bounces-515375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0401BA363E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC173B076C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD4267B6C;
	Fri, 14 Feb 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdO9VUY7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6A267B0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552799; cv=none; b=TV0gXozhakj/9/l5G8pe2FTSFmyZS4R/F6SiZGf517iCx+uCZiZy72b7fLclyaXkW6DfhKJ7S3RrAWuod46Oxh7El6YkKNuwoIjDd5ZYrfUY2wpOzmGtYB13YDUF4Rgf/EN+VdVT7B659Q7zg2Fi5rJRxQLXZJ58dipy729mIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552799; c=relaxed/simple;
	bh=x1rJ2BabnpFv+3StHsYJ7G+koKBHBopT3/7GAr+Q32Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCBssjkt6vZroaAElXmZ9ipt4axI72bSE71SraHcvld/qWDBokKZvmm94Y92tGFlEpbSx3JUZhj+et6bBmBtR1oioiKgs2ugQdkDcI/dnLjUD69MzFoDETihPI4QNTVZu1dzrSzWXzcO1pzZ066ay0nXfPp709Og/2RrQMbW/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UdO9VUY7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so507490666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739552794; x=1740157594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1rJ2BabnpFv+3StHsYJ7G+koKBHBopT3/7GAr+Q32Q=;
        b=UdO9VUY7M3YHIA8FQdZ/xtFYqNFs506KaHCnAK9O/6LHhjlN4rS6YrsK7ePfx0/BLz
         ztbkCwXZD3EHMj+JCQowIxbxFrERJRzJjI3p6LoY+S9poF0zsMBPjWJGCthVmqH9dBAQ
         JppPdQzvPcwUdAaXSb485QdqAUCmQVNxCQBdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552794; x=1740157594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1rJ2BabnpFv+3StHsYJ7G+koKBHBopT3/7GAr+Q32Q=;
        b=RcNTZnTDuqcW8zLrFKY1rQN8eWuF/PChGUm1FehK7szw/lZ9QtaVvBqAn6mTo1872/
         WrcDBYEfqCctzXx1zdXRNufb1raFW4tqk17mRDUjBE9hxTUFEMzzA5A55K3GUMQ6SNCE
         517XvnhswdImoKnAe8eJZyNSth1Uo7zweCJvWSVPAGejXg+fYlu1CfWBpV/q0l6eaTbr
         0HbnFug0VzAP2DoNMydPVs65mVlQ9GneuokXZnES/t4egBWGvUPPK2l2GAbDQsmNpxjl
         dG35uqAuyKxKYrLZ5DLM2Q2pJOsCc8CZK2KX2CGdpRW23zMuQZliNX1IQZ4m9JckOEjH
         HZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/p/V+d13rIjWehYGLkecomg+rLGR94SZHJecj20egX6uF0iM1OUncbvIUhNwNkJia6MKGUAF2sWUb1VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBladXtt5zmeXyt9Ux52SC4zvNMSkiUiGBgZ4WforQljeZIfT
	pe7BueOcDHGE0WSXTo1vaiCcrqikacsL1jzs3HRxPIZ5kVFVsk8P2ojm/KSTZkhlUbYgFeZDuH1
	OJ0mP
X-Gm-Gg: ASbGnctDypaYzv56tAABRWNogrsEfPD/UluielQF9ihOCqiZReKoLjm2b7oKPByvlFz
	lG4rBb9WQZTw+DhRDJ/2DgcTwHYFVWyxxI1H9js58VJiQAa1aB8lXE+ssrGXdp8BeIB4L98kk1/
	J86uD3+gqeR/hHUj8nELRfgtYA0CUFuuxXqhGBeWDM03niZD7P/KiDdVjmArMtAmfzKfLW7k7QR
	FKgQo3wPk14I664CbDS2rHk5IDeLFlW5kxcDhgX2daJkk7++99T1puZBl2EObvtZ2olgyH8y/FE
	D1JmPCVoQv1HFLs6CiEh1nJASMXN2supczW0sYFJAxn6Ayn2KLz69WQ=
X-Google-Smtp-Source: AGHT+IEeio5SnTZZyf3n591d7ALVrZCce0D+HsUaJtBDAH0HtWBbzirLpUaY10ovPLWTlDKJDnKx7A==
X-Received: by 2002:a17:907:2d9f:b0:ab7:e91c:77ef with SMTP id a640c23a62f3a-aba4ebac38emr832286366b.24.1739552794452;
        Fri, 14 Feb 2025 09:06:34 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb4d3ef3c0sm38452366b.41.2025.02.14.09.06.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:06:33 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5deb1b8e1bcso4370566a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:06:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYfSfsWAlELPkA4TC+lCDj1hZjPJt10ChFdctkCDi7JCB6pMnd3D8oz4vQe204ivT/Jo7BI8CPVT73YrE=@vger.kernel.org
X-Received: by 2002:a2e:890d:0:b0:308:eb58:6586 with SMTP id
 38308e7fff4ca-30927b1ad9fmr526231fa.24.1739552438401; Fri, 14 Feb 2025
 09:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org> <20250213-bridge-connector-v3-4-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-4-e71598f49c8f@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 09:00:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UB4NoTaNfV4w4GE6tmHZbGdUKCx6Yscpxo2YQRA4Th0A@mail.gmail.com>
X-Gm-Features: AWEUYZnlF56_MlEcpLFHOcXd4DY1qENmIJ2J2sK12MuHSNIiD9o59vM9X2CDylA
Message-ID: <CAD=FV=UB4NoTaNfV4w4GE6tmHZbGdUKCx6Yscpxo2YQRA4Th0A@mail.gmail.com>
Subject: Re: [PATCH v3 04/37] drm/bridge: Pass full state to atomic_disable
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 6:44=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> It's pretty inconvenient to access the full atomic state from
> drm_bridges, so let's change the atomic_disable hook prototype to pass
> it directly.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

From the point of view of ti-sn65dsi86:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

