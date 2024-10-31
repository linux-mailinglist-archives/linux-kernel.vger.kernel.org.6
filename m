Return-Path: <linux-kernel+bounces-390841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11819B7F02
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D171C21A11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703501BBBE8;
	Thu, 31 Oct 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjCQfAot"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F44136E30
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389713; cv=none; b=eMu6A6MqIbVgLmoZHQdFf5yePn33fl9f4mhlzh4BKbhWL5/cfqK62FLPmldb8yWCPC8P+ahMjjsgAgBI0UIbjHy0Pw57Y+fSUysnUZkmCzSp1DbiYERz1ACxnP9czT6nFI0+yIYF7gghLdNx6aAGRRjslXXfXTg325lHkDooFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389713; c=relaxed/simple;
	bh=/3ietdAT2zfd/2RT4o3MkbHwYwQJuHSE9kSdiqLPMoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2ld8u8OTWnROmiWUOiPleACWJJ4jpftfQ//mGX2TRdJfvunEotoVaOmDuYhZciUFjAaZKXM/kuJfNiCJ/p9phCiYvuCQcCHQBQfsu6b4MmacGH7Nthz9EUXDYo38PlzViMc3If1eI0FThB54ASpcKO+eOCVfjd7ZlsWUnY72oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WjCQfAot; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c77459558so9712135ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730389710; x=1730994510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjC3nMAIlVM1q3lt2DpIHub8eL6Pw0tLQHd/8IGv3WE=;
        b=WjCQfAot0Ux63PisQ9DgwVRm9Epcx54STDoVM5QgcULpb+cGpIX0X4o8lFzV9yTS2B
         RJ3pdhDUfpp16UsEul7q9Nx03E9SrxQkZx1rArHJnHhUo3bc87i0mBlJcIecAZyrUqgh
         6Kr63n5O6K0v5PYCpLqd9i1mw4gV+N+59oyCtnGSc76/BRihuCl1q0oSMVKr091D+24D
         EwdtvqYDHbk0voQGL3zwXjN8iUb5hLFy7qmSTt6w7X6jJnINB9NKcuHUnDIsgjKLK/Tj
         ohx1gSdzMlQmLgsqtIDhim9TMKD3wrusNkm3q7ETieZ/wos+kQaZPmb9NhrxJ7d2CkgV
         FDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389710; x=1730994510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjC3nMAIlVM1q3lt2DpIHub8eL6Pw0tLQHd/8IGv3WE=;
        b=X60JxvDcGubvwJMP0Bg2g5DGyBiMmO5HqDApzr8060fSMPok/7Qk+QsRYenopvti90
         VmrDRQGjtIVlM/t41E0Apa2ZhWBTpQ79NMv0gsA2HZ5n2hy1/vaa5fWdViUITPUAHCZG
         siRgZcNqmqjpGUazfxAq8nxZAYEV7W+3Z0zLxjUt38YY+ApifXeLBU9HPIb6fpqDcphG
         DvAgNKcKERbZw1acts7s6kYMkneYHNh/2Wn/xO5Zk28qNivd1zdXRzSpQ75qCjJF/f3W
         Zd68iBixk71b435y8Zrg10XNrb5KTKMCIIReRrJBDinUt8fM7u9duJaN03I6co86LuPj
         1f9g==
X-Forwarded-Encrypted: i=1; AJvYcCUr451OWhVEJSBORMEJx2z1f+EbTgCzdlxiALIK5sV1/UGQrj4u0qBFncuz1akS/Vaa5e6xxspWGUoKxBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhRN152/sxWC2smlAmZBi4f9CS+vir5a478/WPsa8zPjf5s8D
	idvpkzSNDH0pFawTm53epP4Q2k9ZUFS5v/4bCACuiLFXUJgxfFVS6le9U9cGDrfWzIAC3lfhbpr
	FuQq0uZxvj9mYgV+ObwRttWbOI1f7OkWrVfFgzQ==
X-Google-Smtp-Source: AGHT+IHSfDKRii2NwhyNl5yN1Hcn8F5/2hI6zBGdTVZhAkhVitVIhKYO47+S571JKu4USELXFc3aJNzy7hxcwlEDOmc=
X-Received: by 2002:a17:902:e54b:b0:20c:8b02:f9f7 with SMTP id
 d9443c01a7336-210f7711e6amr85424115ad.60.1730389709967; Thu, 31 Oct 2024
 08:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
In-Reply-To: <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 17:48:24 +0200
Message-ID: <CAA8EJpopyzeVXMzZAiakEmJ9S=29FKt43AHypSYyOuo_NbSJbw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Johan Hovold <johan@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 10:23, Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> > The assignment of the of_node to the aux bridge needs to mark the
> > of_node as reused as well, otherwise resource providers like pinctrl will
> > report a gpio as already requested by a different device when both pinconf
> > and gpios property are present.
>
> I don't think you need a gpio property for that to happen, right? And
> this causes probe to fail IIRC?

No, just having a pinctrl property in the bridge device is enough.
Without this fix when the aux subdevice is being bound to the driver,
the pinctrl_bind_pins() will attempt to bind pins, which are already
in use by the actual bridge device.

>
> > Fix that by using the device_set_of_node_from_dev() helper instead.
> >
> > Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
>
> This is not the commit that introduced the issue.
>
> > Cc: stable@vger.kernel.org      # 6.8
>
> I assume there are no existing devicetrees that need this since then we
> would have heard about it sooner. Do we still need to backport it?
>
> When exactly are you hitting this?
>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v2:
> > - Re-worded commit to be more explicit of what it fixes, as Johan suggested
> > - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
> > - Added Fixes tag and cc'ed stable
> > - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
>
> Patch itself looks good now.
>
> Johan



-- 
With best wishes
Dmitry

