Return-Path: <linux-kernel+bounces-313932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099096AC82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2556A1F26467
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959D18733B;
	Tue,  3 Sep 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGtoiBTa"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5071EC01E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403765; cv=none; b=T+9XalAWcuADlvch3SSr8HctwK/SttqCt+6cfAhhu5xs5ArMiRU304fdeEQMJqJwDlEmHaFPxeqrUAQEUIzDoJbonaBn6sZdTUEfGgR7gNjy2F9eae4qKKe6jiNuemKGUmMWvnisBeBLJvkG88kHaapTQUcWOX6ScFd0JCjeKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403765; c=relaxed/simple;
	bh=TtyX2gK5m3nn23OtYeDlMe0JllQ4/PmVqk0mkdxmM0g=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsHnpOxwjB82lfPd9jx7rH8VStLWj3rt8Ebavk5vPTMoFEmzhfl3IEYNSFzS7J/WjChCN7LEpsR0uk0DXQ1GlPOF6444EBY+Ca1wBQ2o5EBNA6VLCrpXtUzpCZTWatC/YPi+/NnByoUqnPJ3jV/q6QdRAGNLS1SDbsKqyjt5WJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GGtoiBTa; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c35b72f943so1315046d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725403763; x=1726008563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhkZOEeJ95CcasGDNkmg/phbGBaUk1oIC37JjrClemw=;
        b=GGtoiBTa2PTnMt5qsv43WUG9RdNGUP9XPM1q8sr9xgQRol07+bG+QW2+Ri8SBjndyE
         39rIBUWhWiH9auxXqu2QyaNOdimkqZaQmRoTBgJWO+P25alTBOOa+lPq9hg8qblXMGci
         cR+MBD57s0alrU9EjH6ewGjBGpk8wPv8MJP1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403763; x=1726008563;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhkZOEeJ95CcasGDNkmg/phbGBaUk1oIC37JjrClemw=;
        b=lAh2WCl6OzbkY+WsN5ew6RAuoODCfqqZMj86PoH1EG8LFVcA+M0VhCBGKO7xDNlTRy
         C+jiQ6EndjoIlFzw/tniPsm1C3UFlzn5o3vodVg6wQ7wh3nPFqysRfcR7Lpa/jL+u0Bl
         B/E6IYTJW2Idsfj6cnMdepfJ9QF+wS5r5WLxNs63vlJ2tTt2zBV5r43cXVvbjQIfYBoO
         EMl2fnoD1fevIMGAtztCKvDV7HKxZboAApJaIB722TXDg5f6bvuctFqqrIk4Bi5R50xS
         etPtgDFjkCfXPcrb/mwgTbUtg3spYhDvDzkiKBsNUdWEGY3WfbzYUyKLsejyF93E1d6q
         s3ng==
X-Forwarded-Encrypted: i=1; AJvYcCUA5H30QdxKH/wtfvmCMUeqV+sEKwNu3K9pA2NlYsP04tqQRCXQDenjnN+lrfQy/0C5ahmxmcS4SNqiDr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlrfpM1WlpOyIrb18Ry+hO++aV8nRHtYQOIENWB2uhCThwHUX
	0QAgtgIfQqriRwd3kq9uSaJ65kOfJZqOCfaHu0LdppusGVDZCrd7tFWk6xB7UUO3Ekls85wJV7a
	2JRgzRqnPXwdP9oIoENFyD+HX93IjOkWZzEkH
X-Google-Smtp-Source: AGHT+IF34ocTupB91QqHAUN7muZ3pQu7SJrIS8QiPpHwQnzTFwdvCLem6xytcCmScWzLqSwtal0se6zIR4RyUsc0prs=
X-Received: by 2002:a05:6214:1c44:b0:6c4:d2f9:644e with SMTP id
 6a1803df08f44-6c518e03025mr2177666d6.12.1725403763196; Tue, 03 Sep 2024
 15:49:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Sep 2024 18:49:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtWdsZrFxfjYLgaG@smile.fi.intel.com>
References: <20240901040658.157425-1-swboyd@chromium.org> <20240901040658.157425-12-swboyd@chromium.org>
 <ZtWdsZrFxfjYLgaG@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 3 Sep 2024 18:49:22 -0400
Message-ID: <CAE-0n52Hupp-ANE2ggeGCRZSM+xmrJt-Q5+5Cb7=C-mxykbz0g@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] device property: Add remote endpoint to devcon matcher
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

Quoting Andy Shevchenko (2024-09-02 04:12:49)
> On Sat, Aug 31, 2024 at 09:06:49PM -0700, Stephen Boyd wrote:
>
> Is it possible to move these Cc:s after --- line below?

Ok.

>
> >  /**
> >   * devcon_match_fn_t - device connection match function
> >   * @fwnode: Remote connection's device node
> > + * @endpoint: Remote connection's endpoint node
> >   * @con_id: Identifier for the connection
> >   * @data: Match function caller specific data
> >   *
> >   * Implement a callback with this function signature to search a fwnode's
> >   * connections for a match with a function like device_connection_find_match().
> >   * This function will be called possibly multiple times, once for each
> > - * connection. The match function should inspect the @fwnode to look for a
> > - * match. The @con_id and @data provided are the same as the @con_id and @data
> > - * arguments passed to the functions that take a devcon_match_fn_t argument.
> > + * connection. The match function should inspect the connection's @fwnode
> > + * and/or @endpoint to look for a match. The @con_id and @data provided are the
> > + * same as the @con_id and @data arguments passed to the functions that take a
> > + * devcon_match_fn_t argument.
>
> So, struct fwnode_handle is a single-linked list. Can we utilise that instead
> of adding a new parameter? I.o.w. do those objects (@fwnode and @endpoint) have
> anything in common and can be chained?

No, we can't use that. We need to know which endpoint in the remote
fwnode is connected to the fwnode we're searching from. This is how we
know which typec mux structure is associated with which type-c port so
we can drive DP there. We might have two endpoints connected to the same
fwnode and then we wouldn't be able to differentiate the endpoint and
the typec mux to configure.

>
> >   * Note: This function can be called multiple times.
>
> What does this mean? Is it idempotent? Or what is the effect of being called
> multiple times?

I've removed this note now.

