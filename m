Return-Path: <linux-kernel+bounces-294376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF1958CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA79B21069
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D51BDA9A;
	Tue, 20 Aug 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4ne9org"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9F1B86FA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173979; cv=none; b=m9xiTqeSYnmxo6NWnyPmOlaj/4I02QTtDjUAnAKg358ASu691BHcWW/MD/ZFFtg/xXxIRNcbuChkpNxoxkhDuFCnQMiqyA1gqne42IOCBFo7d9fTR8N2jfE44d5Lp6hfPstKZ80lIBNOzlP8r662jFSC4loU9F6Gscb3RlnyuU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173979; c=relaxed/simple;
	bh=XdOxPTcpa9GhR0x1RxpvIyQuwRfTAKkoPNe3BAG2ReM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpX47XSZ/wh7m5jH0RsC0zybwu7sD4UOjVolWHkuk6r4H6piMRmCOOwH9cTy8wuFZj6g1z1Rf7UVqyM3b7TyRBeuiF1dpNg5pG8F56bgywhgQCAU/RA5ZEOrpu+iy4wmBU150u0MOgVKThApzVCrFaZexsDQg9YcgPiYjuIcJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y4ne9org; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d42da3e9so377673485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724173976; x=1724778776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Az1A9NMBsWL3/7vKt/sApr3R4UF7scT2PZ3fQljPcaU=;
        b=Y4ne9orgDHt6eOerqA15sPK1fQzMDjHMhKt8gk1JaOuJox/gr1snIuGV5KLjwquEnH
         9uEXhX1/tILUfvU6LH/dJmR9Uin9izskdk0K6N2EFfC9Tt248T99izMfJhpe/yJE5GLx
         j7ZqrbB5qY67CE/AEasNamuNNLoTpgEI8uDQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724173976; x=1724778776;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Az1A9NMBsWL3/7vKt/sApr3R4UF7scT2PZ3fQljPcaU=;
        b=E9E/iMfMhXudF2t/MipSQI4/7e3wJmswyBInkJT/geJ72YeZlbthg5LvxYhfOhhUlH
         FUc3UnwXgly+ijex4gnGAodAOb/gEmJ9lZAb3yHhxtujdXFaYYqaLA+jlRq5SqOQvlDR
         GpRwGn44XQTw4gy83i2Oz2QRTwz7FjbPZUkCgIp8biVid4vjmg4ORLR0EMgzWlhAmp53
         Bh2tfo/Wol3YfEfztGjI+D8b6jzdVUIp4WHUu9g+JBoKziVJIc36qu1ZcLshh/xVSY/7
         JA4Pxwsa7GpEn2rrRdW5zq74+Kgty62jYvBjtfF/DkexriSBtFKtIPURzjUppbVwlNHL
         MeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL6FSwnTXKWEnDywbFdPx77mO/Zqa7nKIDKlvox7ohOI22aiNDps7WvJZ4k7T7VC3vMXHeYJcs2jtRvPyX6wyKhtqgKdumL5pF/KxK
X-Gm-Message-State: AOJu0Yxcdw2a8qxr4MdzvgYbivofNrV9O0OUAovVCFIKRqXO7wxNEyUF
	K3FMKftaNm0Qcku+aCh/q/L3KCNCyU5eC5/BCH5QJr21lrRVvuuU5YsXmIAX7QqLWhMfMVUjDuE
	VKMFS+nvxUq3TwSMnB/6NG9yje//zdEJj06KrLqB/X4S7q9o=
X-Google-Smtp-Source: AGHT+IFkHKjFejZjAs941sgh7G6biMuTuBjyP76WiW4rgqwMwtsqslDT56RN+7cjrZMCdxIwmDbG7BvU7jfkGLOLSTI=
X-Received: by 2002:a05:620a:4245:b0:79f:5d5:1bc1 with SMTP id
 af79cd13be357-7a669685ff7mr335452285a.58.1724173976423; Tue, 20 Aug 2024
 10:12:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 10:12:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsRrWfoPPVGC4Dqy@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-3-swboyd@chromium.org>
 <ZsRrWfoPPVGC4Dqy@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 20 Aug 2024 10:12:55 -0700
Message-ID: <CAE-0n536OWtoOoRSM=6u=wA75A+0WtBktiY=6Y6VjKKTQWPcNw@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] drm/bridge: Verify lane assignment is going to
 work during atomic_check
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Andy Shevchenko (2024-08-20 03:09:29)
> On Mon, Aug 19, 2024 at 03:38:16PM -0700, Stephen Boyd wrote:
> > Verify during drm_atomic_bridge_check() that the lane assignment set in
> > a bridge's atomic_check() callback is going to be satisfied by the
> > previous bridge. If the next bridge is requiring something besides the
> > default 1:1 lane assignment on its input then there must be an output
> > lane assignment on the previous bridge's output. Otherwise the next
> > bridge won't get the lanes assigned that it needs.
>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Robert Foss <rfoss@kernel.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: <dri-devel@lists.freedesktop.org>
> > Cc: Pin-yen Lin <treapking@chromium.org>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Yeah, I really think that the appearance of this thousandth time in the Git
> history has almost no value and just pollutes the commit message makes it not
> very well readable. The only outcome is exercising the compression algo used
> by Git.

I'll leave the decision up to the maintainers.

>
> ...
>
> > +     /*
> > +      * Ensure this bridge is aware that the next bridge wants to
> > +      * reassign lanes.
> > +      */
> > +     for (i = 0; i < num_input_lanes; i++)
> > +             if (i != input_lanes[i].logical && !num_output_lanes)
> > +                     return -ENOTSUPP;
>
> Besides missing {} this code is internal to the Linux kernel. Is it okay?
>

ENOTSUPP is used by select_bus_fmt_recursive() so I simply followed that
style.

