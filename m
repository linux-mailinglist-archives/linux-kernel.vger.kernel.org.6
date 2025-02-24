Return-Path: <linux-kernel+bounces-529543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F7A427A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41281887A81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056D25C6E0;
	Mon, 24 Feb 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EA5OJtYe"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7D24EF78
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413801; cv=none; b=pp07PG8DwGtzlzL2b3lpRfc9lD9zpl2cwI8wG/K1fwYv0pNw+zuBemMn42jqdeJ/aABq6aEXTy5lHHrvuZBqX0lMnbwGa/i9NqhhQjqmUA79c2AVISQfaC3UwmyEmO2hIJ5qzVSF6vb3FsaUrf2OrAfd0AvNaXoh2jI5rlpcPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413801; c=relaxed/simple;
	bh=sP1m+Ua+RcKbeh+23HHa7XO1td465p/V+rsiw+jfP2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyNqiTXLUjBGYj0D/DzSFoJ2ltEhGD+yf1gUtynAE3Tze3T9V36n2DctfwG6tnSqBvSR1hyEyvK0zk2X6vpuUpKcQf6n8LyrV/xUzKfuXgEhvjgUeEFE9iU7//jE8d8w/dyqkQE2JFErOkdevD3eosOvyLVEdGD5Jxf6ytE7O3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EA5OJtYe; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53c9035003so3569676276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740413797; x=1741018597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhvYBpaOQuzZc2PPxyd2t+tuXQyCwGXIxNVGnXYPsA=;
        b=EA5OJtYemVKwg0dr+1IbZlRY21fEaMg2LlngSHgvfqrtc1bKY0cV3K3D+bURxXvVcY
         k4LN+/73wgdvvh+JTPLIcEFMsgHjk77wMOUrcg/QF9YqqMXyVQ/+nGffVXTK55hK37iE
         dAb8caOE9R6hkM4TjRSFiquOZw55mY5RI0Op/3WaT/qlcdGQuZ7q5XIvAGSylraa/8N+
         laiZRE9AI8aJG8pMovNy8AfWbUPOWyYv961O1W1fSt5CEWwfy2kPZNsSduNdbWcNpIAX
         O49uXKaaqkBZ26bsuS7mfK35CQsS3FPqHBXZ/mRbnKWTueF8nfigY2Dkux6OKusIgWRi
         d10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413797; x=1741018597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nhvYBpaOQuzZc2PPxyd2t+tuXQyCwGXIxNVGnXYPsA=;
        b=l4ISMODzjEV+kJM6j1cTXpHHf9CdRGioJ2h1kSYtffnRrSjrqdcDelpYNvlQ/PHdjy
         xjIBPUU0ztnO8FUWWNF/NkRQxQW8kYYdvH5bOwA71MRoA22HOFlGLE3jFBcAct/SzcTL
         IIemV0Sn5yFw5RQIpb9xNBEtznULCjUX73oLbcpBWPW3SUl9VuuRTg0W/iS6d7zGjVu2
         vzyou7HrskmmrtQw0qXkIxhVm5ZHdLYE8z5tkVqtAzRB0V8exlGQUOg3g8M3dL1lvDec
         qyF07/nutewpGXUgp6pZY8cO0GSRZsnoNxm6VV9lkrhvr1A4kLEwv8XHROzv+MhVgbKZ
         WMmw==
X-Forwarded-Encrypted: i=1; AJvYcCXD4WrI84UyiyQzfuO+KHvXnJd3k2DAdCKX9S7knODa4hTjAQ1l55hYGCcpgWovwBAgXIVaDQqoJU/1Ey4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KO4Kz3C20CY6VufmbAAjhdsJLCuzh+NPFYM02AREGpsbrNuh
	XeY5/W59NzZ1iKqg+crmOt54M4wW7Kr6Leq5eybpHBKNqMcXqi6cHks3s4hscBJ3qGWJQMNizOc
	+cGohGOtYp0nG7OMT/wAAizcvfIdrDpoCkCJTpQ==
X-Gm-Gg: ASbGncvpN4GaI+IBh0G4g0Wn9HozKJKwhIVPb7j/BUxbDWC5wFcHxSaJv2fLptf0a1z
	x+JvyniYcoIRB4LDKUYxu2VOmHhlqPAomWDaIjW0Y2Ls/Z91pz+o30fFn/iOjvX5dgJxeDzkqZj
	GGMIMvKz8hnklfIbp6BrgitFHFCVdGtjL9nTWm1m5V
X-Google-Smtp-Source: AGHT+IERTbcHpTFjL8xCwXbbDdtb9v5bJZbheeag9xnvtXSUhwjOQHRlR9/ILy4dAvc8ziVN20n9Ds50jV3I6NnIhrk=
X-Received: by 2002:a05:6902:1147:b0:e5e:14d4:e630 with SMTP id
 3f1490d57ef6-e5e24668e26mr11373831276.39.1740413797228; Mon, 24 Feb 2025
 08:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com> <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com> <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
 <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
In-Reply-To: <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Feb 2025 18:16:24 +0200
X-Gm-Features: AWEUYZktbuXYXa96Q3xFxeJhj1PB3sx90DPGtIUB2gMqOztio-fCDvHDs3KOcks
Message-ID: <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
> > On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> >>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> >>>> +{
> >>>> +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> >>>> +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> >>>> +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> >>>> +  int ret;
> >>>> +
> >>>> +  if (dp->hpd_status) {
> >>>> +          hibmc_dp_hpd_cfg(&priv->dp);
> >>>> +          ret = hibmc_dp_prepare(dp, mode);
> >>>> +          if (ret)
> >>>> +                  return ret;
> >>>> +
> >>>> +          hibmc_dp_display_en(dp, true);
> >>>> +  } else {
> >>>> +          hibmc_dp_display_en(dp, false);
> >>>> +          hibmc_dp_reset_link(&priv->dp);
> >>>> +  }
> >>> If I understand this correctly, you are using a separate drm_client to
> >>> enable and disable the link & display. Why is it necessary? Existing
> >>> drm_clients and userspace compositors use drm framework, they should be
> >>> able to turn the display on and off as required.
> >>>
> >> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> >> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> >> the different video modes into DP registers.
> > Why? The link training and mode programming should happen during
> > pre_enable / enable stage (legacy or atomic).
>
> Hi Dmitry,
>
> Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I

It should be userspace, who triggers the enable/disable (or it should
be the in-kernel fbdev / fbcon, which interface through the generic
drm_fbdev client).

-- 
With best wishes
Dmitry

