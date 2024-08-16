Return-Path: <linux-kernel+bounces-290384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B14955328
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D7E2836DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA891448FF;
	Fri, 16 Aug 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hLFqB+Qn"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7E143C72
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846378; cv=none; b=ImvnDESQqku4Xg4VnQ6Mbktg7Qej2SxSl6lnzVk41dH3u31HPsf8oO97+r4XC7NSbP0P/OkOiVzfI0zie8B7x2yU2bTsGlUhNtt4vhAXKfHdq+nuW49ueCP4zA/t8hVWVJmjcn1/iBuXn+OZbIwfTGb3JRNfbcmowPJYBLon8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846378; c=relaxed/simple;
	bh=27Aa5uP6ynSRq3MyGqYDRl/zOjMC3BQBnPalcqJi/4g=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt+oMp61T9TgKJ8LjW0IZYKxOtP+KsQtc7NSjsBv0GiaLgkoAwwd9DQiCWDVyF4Ab9A6ZswiBPZS2vK6PbfwLlOYuQu1x9HJ0g12NUpJZYdXUV3s4iRU0S5U9AoBwQt6bUpdozCNdHykO/9cGS1vW+tYtq5QeX04zJ4zeKrrPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hLFqB+Qn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d42da3baso173590285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723846375; x=1724451175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27Aa5uP6ynSRq3MyGqYDRl/zOjMC3BQBnPalcqJi/4g=;
        b=hLFqB+QnionPvYbUcWFM1ZBosVzWxt+Nt4ilnfGsX6dADE+MMYxUJZYXFgUtOxT+23
         OW6NvHKvay+iqVm6kQE17IJtfsu5POiNFb4mN2OLLB+kHFgs/O+mG/BKWZPA0H7M+j4W
         0033+gNq3h1RzX04CMhl9M8PpXZdGMyggWyWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723846375; x=1724451175;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Aa5uP6ynSRq3MyGqYDRl/zOjMC3BQBnPalcqJi/4g=;
        b=A9R+7JSl2kctZy0MU3XPY07XpsdMd1u1MgnaJC18AMq2d4DXiTWVkv7Dakg5GSLj5x
         SSP+MCi33QKFT6q7bbMCj+Pwl5QvnvjWa7bwkzdH7S4upgA3UIjZLQ3JekX83vOVjMs/
         E21BtRMimWx5I7TjVL1U5hApNHCJvhGrrl8QUGDH4NDv9fXwk99urxhlyTECDkostBrr
         8YvHkC0QmHd7bs9uMAzk0e4eG/O143CMWwaftg+WWRxToDIqVkzzNYaBCRV9lzDCX47q
         FAwv35+M57i6mj0M3c8O1AE9PIQ50rX+SKFFICEoHoN2c3YtlnhuAJU/qTIXYmLYRbp8
         A5Rw==
X-Gm-Message-State: AOJu0Yy7uJhPmCaqwSH99q2SYdmkcFlpGwSiSp4mo6x1LYtvDzTcLmck
	Oq1OJo3NChCvvch85BECkEDKR+Sc9jJau9pu7GgJiXg2ZfxAIAjBrfie1a4tNTz+v5M1Vz/Ejtq
	vcjU1cgmc0KtdYeR+kodurpG4mQlW2RMpE1JW
X-Google-Smtp-Source: AGHT+IEXgJVhNBbiykq2c9JLQpgdG+hj5r76CFo72LJUCN7wWKauh3tPqJtN47pGnDcVtY+0kRff3bANoaG4a/doWjY=
X-Received: by 2002:a05:6214:4a93:b0:6b7:9bc1:708a with SMTP id
 6a1803df08f44-6bf7cea2549mr55681266d6.55.1723846375483; Fri, 16 Aug 2024
 15:12:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Aug 2024 22:12:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240815003417.1175506-1-swboyd@chromium.org>
References: <20240815003417.1175506-1-swboyd@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 16 Aug 2024 22:12:54 +0000
Message-ID: <CAE-0n50J3vuSKEPM5Pum+8CiQ6_X=Q0eCzyEJLkyof0awCWjow@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] platform/chrome: Add DT USB/DP muxing/topology support
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Pin-yen Lin <treapking@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Benson Leung <bleung@chromium.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephen Boyd (2024-08-14 17:34:05)
>
> I'm thinking of working in changes so that the drm_dp_typec_bridge
> registers a 'struct typec_mux_dev' as well. If that is done then we can
> register a drm_dp_typec_bridge from the port manager and let the type-c
> framework drive the pin assignment and orientation directly instead of
> calling it from the port manager layer. To get there I need to add the
> ability for a 'struct typec_mux_dev' to associate with more than one
> typec_port (technically already done) and then make sure that the
> cros_ec_typec driver doesn't try to enable DP altmode on the type-c port
> that isn't muxed for DP. I'm working on this now but I'm sending this
> out to get some feedback because I've reached a good stopping place.
>

I've done this now, and it works well. I've extended the usb-switch.yaml
file to support a third graph endpoint for DP. And I've moved the hpd
notifying and lane remapping to be internal to the drm_dp_typec_bridge
code so that any device that registers the auxiliary device can follow
the usb-switch binding and connect the endpoint to the usb-c-connector
to get hpd notifications and pin assignment basically for free.

I'll send a v3 next week.

