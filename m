Return-Path: <linux-kernel+bounces-299640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3BC95D800
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8711C21CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693381C7B98;
	Fri, 23 Aug 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K55m7jiK"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538118CC0F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446048; cv=none; b=E0YzkkgLW8fYA8XoRO3+yHAlVX4m50hRpcdWfQEJPwxolibcUVfcY+OTcNn0Y1t6xU7Qlb9lLWCLmMf6VhKfH3oLxX8X8PlDSsBU0cOdYLROfPFyiUeCut4soW6Fuo5nDBxSomogJsz1ixO+CkuZPs/bRBADML4lOhytGrJ6Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446048; c=relaxed/simple;
	bh=0/5plbUShzyN0Lwayk1yBVoG0xyAy2FiSidykukxaik=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcZ/U5mj+S3CcILFaF9aGVchHWr//bt2DsqWGogwjttlXGP3j73YiOTL0S/whA6JqNVIOkv+JyLTEpfAdYbVpMwfRhQV3Z0vAXnU/cGPFqUBkw+t57S9e7p9ZOw2uYVNJMYtYo6NMdIIepEBsa842RxXH6H1dPa75sckMOMXhuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K55m7jiK; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5f24d9df8so1869064eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724446044; x=1725050844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZiKFaKcOy5uMCUP9iI4bnV8rWlMx58uhQ+Bp65JxBY=;
        b=K55m7jiKORwK9gNRm8ITJ8V6FL50HWA2hx3IbFO7Y7zq5rXi4LqoMas334EKg39gyE
         H9Saxz+P3kpTXLy3AVFqZqfdl5Cun+PIYiK/ZntuoPp2hg8rIX60LoUuY0Ok9YiZDlUb
         gnmS0Z+YWIQ1YLyxSjcerOOtmX3VyCnKhsHZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724446044; x=1725050844;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZiKFaKcOy5uMCUP9iI4bnV8rWlMx58uhQ+Bp65JxBY=;
        b=kkEw0CO+PAKa6HdfV431OEc8vcIleTyOryBI/7QiLkrhmw/EVoxJiscBM+FL/az+ZF
         y4w9ecNhqZ0nYbBhRxnHIP3rbsrBE7+kTbiNVScziJ73yNaVuyCA8QhcU2E9RDYtMMsj
         npYJpTDXUikSWsNiIC8C6Gdl+Paflgokx1WW51gLrAt6YFFjr91VdSh+lfDksJ1jTmjd
         n9rHDZY3Dh05byfQgVePaWXI4D+z65jzBSwQUj48JcTNifLszMfku6/97M1/QckjVGYE
         gvUocfodR97b6etY2ijBln+/6WosRehADcODrvu6QdsAm12MIrzu+KUc58HBLBR7i2iQ
         uPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3gB5vfrI5aTco2fU5JfyZ85THtMhicymP09ZT/19LYCEL3Y+N5i5n2S7dbdaa3Zb0OZHjVdYI90X27Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeikctN+6O4v5vn8pqVgMgSEuRJsWw5FqKPraXevbTy/E3RJm
	Et1cMmtPxCwSjzmYgUQjFEoMqda9N8M4vkmpzt6nn6NeoOVZZAVt8IJwSZPFEWaARvz5lzlJq3x
	DeDxltRDKQti/hxtzUfG+L17SUEboX3YdG7VJ
X-Google-Smtp-Source: AGHT+IGtmJ+gyuELHaRH+RZ4qvsU8Rp6JLHoxTqxGD2FO8wzaNQZtxGnVU0BhE1HT6iEWRSosj9gW6Yp+4g8GcNpGbY=
X-Received: by 2002:a05:6358:248b:b0:1b1:aca7:dad6 with SMTP id
 e5c5f4694b2df-1b5c3a4e8abmr336937055d.11.1724446044234; Fri, 23 Aug 2024
 13:47:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Aug 2024 13:47:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsdMoRpwv5twOwqx@tzungbi-laptop>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-16-swboyd@chromium.org>
 <ZsdMoRpwv5twOwqx@tzungbi-laptop>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 23 Aug 2024 13:47:23 -0700
Message-ID: <CAE-0n50MVaU2dmRLdLVFWT9KWPO_BK-L7eEqGRSb8TKm1KtPNQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] platform/chrome: cros_ec_typec: Add support for
 signaling DP HPD via drm_bridge
To: Tzung-Bi Shih <tzungbi@kernel.org>
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
	Thomas Zimmermann <tzimmermann@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Tzung-Bi Shih (2024-08-22 07:35:13)
> On Mon, Aug 19, 2024 at 03:38:29PM -0700, Stephen Boyd wrote:
> > +struct cros_typec_dp_bridge {
> > +     struct cros_typec_data *typec_data;
> > +     struct drm_dp_typec_bridge_dev *dev;
> > +};
>
> It looks like structs are all defined in cros_ec_typec.h.  I think this struct
> definition can be also moved there.

I put it here because it wasn't used by any other driver. Maybe I can
skip the entire struct though and add what I need directly to 'struct
cros_typec_data'.

>
> > diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
> > index deda180a646f..73d300427140 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.h
> > +++ b/drivers/platform/chrome/cros_ec_typec.h
> > @@ -27,6 +27,8 @@ struct cros_typec_altmode_node {
> >       struct list_head list;
> >  };
> >
> > +struct cros_typec_dp_bridge;
>
> If the struct definition moves here, it doesn't need to declare forward.

But then we have to forward declare 'struct cros_typec_data'? There's no
escape.

