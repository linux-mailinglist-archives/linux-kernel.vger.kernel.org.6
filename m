Return-Path: <linux-kernel+bounces-392053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C299B8F27
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746281C213A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5A165F0C;
	Fri,  1 Nov 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwvrrQ5B"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AD156F28
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456850; cv=none; b=jdDT9jSSB2vi6iiZtY3+muXHX3hLxr7UPeybhUcX8L9iJL1oNdvoHRShw+UoYTRupDsyGk/MyrrYKjdFI2GdaYR0tfzLHkF0H8pTwSb0TFzC4YcR7btIzz8lXpQ+k0VYPYlQ9PkWl9nq+B6u6I/dIWnwibp5gF/5xfuG2S8qFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456850; c=relaxed/simple;
	bh=AQ33NGaaKbdR0lgiKDXQGQz44vhAz1nJx1iagWYm798=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUQGyOWtMhSczMefTm4gA3GZdBuWX91Q5rY60IlSGEr+ce8OStcXku0+m/Wb1gHPu7Nd98exWwm5GhFcPB39RFyV6KRD37lK3lE4d7w6aU7IcYNvkrnvOsYLAIcNYWut2Uf1C/BlC/xBaxCeeCtusz62otb1MYZAneRaxoUp/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwvrrQ5B; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38ebcc0abso20996017b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730456846; x=1731061646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss7HqrCAEiDCK7gqRMfrbIK/DUBAZAaK1W9KPoORIq8=;
        b=lwvrrQ5BtK9ap77sW05uF0+S0xUWQnOukb2bv+TghvK9rCN2U5LnogI/avFmULw5DQ
         +0xHDx4/PwQF2Sbaeii4p8LVukkakfkJd4meUpOJxh0X9dd1sW0giTK9DzhJv00iYLUN
         2gjvv2pw6CrICoIBz6VFOsmu4ZTtCTN7X/g9iQNU9ex7KiJm2H0LSKkEu3pximEC+Fh0
         cKqO79F7opIR2crbtI+dGI2O9VMT/WXVyIJXqXNAXm6sfDkVEGF5KHq+7GcaJ01cGWkv
         9C+C48BhMrcSL/YVEJAg6XAeFZpPjNG1w69ciSC8qYaa0Yp0+ZANu1+TSlo/CEjvRZg2
         coQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730456846; x=1731061646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ss7HqrCAEiDCK7gqRMfrbIK/DUBAZAaK1W9KPoORIq8=;
        b=qamepCA7lJwW1IO/hW1NWJaPh9YmKelfrLq4aKdVVDe/vLX3TYhs/uUnnJf0Ui9neb
         6QDgQ5LtB+sWfhoToT48Uxz4f0qleFFioyh685X5pYLNq6ymoGfBMaUDu4TuvFesAcfN
         z6Hoi2BPezwgDoUfKUzIQLryostc/oDEGaVdgM4J//c2Pjffhu3qLud224Bva7PdcskM
         RePEAs7HZjNP6BT/xw2WEZPcI4youaGQnvohND1RsfemWCm0XCejWQKY1StiX/wjYCWN
         HwLTouAN/IdHLfDhvuqJouOxhEjkWjRUA5TColDmEZhVSP0Nn6MYxrFoeUwB7QP6cHhV
         fUkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTxmzJwelzyKmSsU250A+9Y6pMg4oAGuC5MZrhFRm0w6kNih6kmr4Mo/RrjcuuoOcSX3Yzebw9Y/0C3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeqPohWP5ZdhFarqBTjHl8W5nJ4YYy9Muj8yIu5728p95rAbw
	EbIP+mTd+ZJzskD0wNMVG80gt03i51fH08SXsJOz+lm8ggTbUSBDA7/xXnIDu01kSHKw048Wyxy
	zkEtO8HQ/n+v9QTvb2emmIG8JAhxdgx9BZtSRhA==
X-Google-Smtp-Source: AGHT+IHqsmm863M+Us1qtGisvRlwff+vHDuYIqJfop4OczcmkVIeT6lVuYCgjUig4zLqPpFZkem2bNxaAPeuwbz870I=
X-Received: by 2002:a05:690c:fcb:b0:6e2:e22:12d9 with SMTP id
 00721157ae682-6e9d8aa1115mr220680307b3.35.1730456846182; Fri, 01 Nov 2024
 03:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev> <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
 <751a4ab5-acbf-4e57-8cf4-51ab10206cc9@linux.dev> <ZyOvAqnuxbNnGWli@hovoldconsulting.com>
 <30fefafc-d19a-40cb-bcb1-3c586ba8e67e@linux.dev> <20241101092049.GJ2473@pendragon.ideasonboard.com>
In-Reply-To: <20241101092049.GJ2473@pendragon.ideasonboard.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 1 Nov 2024 12:27:15 +0200
Message-ID: <CAA8EJprEDV2JViB9kQS2H1p=NgF+PcataEejC97DBo=aU5g5kw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, Johan Hovold <johan@kernel.org>, neil.armstrong@linaro.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Abel Vesa <abel.vesa@linaro.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:20, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Nov 01, 2024 at 11:49:07AM +0800, Sui Jingfeng wrote:
> >
> > On 2024/11/1 00:23, Johan Hovold wrote:
> > > On Thu, Oct 31, 2024 at 11:06:38PM +0800, Sui Jingfeng wrote:
> > >
> > >> But I think Johan do need more times to understand what exactly
> > >> the real problem is. We do need times to investigate new method.
> > > No, I know perfectly well what the (immediate) problem is here (I was
> > > the one adding support for the of_node_reused flag some years back).
> > >
> > > I just wanted to make sure that the commit message was correct and
> > > complete before merging (and also to figure out whether this particular
> > > patch needed to be backported).
> >
> > Well under such a design, having the child device sharing the 'OF' device
> > node with it parent device means that one parent device can *only*
> > create one AUX bridge child device.
> >
> > Since If you create two or more child AUX bridge, *all* of them will
> > call devm_drm_of_get_bridge(&auxdev->dev, auxdev->dev.of_node, 0, 0),
> > then we will *contend* the same next bridge resource.
> >
> > Because of the 'auxdev->dev.of_node' is same for all its instance.
> > While other display bridges seems don't has such limitations.
>
> Brainstorming a bit, I wonder if we could create a swnode for the
> auxiliary device, instead of reusing the parent's OF node.

This will break bridge lookup which is performed by following the OF
graph links. So the aux bridges should use corresponding of_node or
fwnode.

> This would
> require switching the DRM OF-based APIs to fwnode, but that's easy and
> mostly a mechanical change.

-- 
With best wishes
Dmitry

