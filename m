Return-Path: <linux-kernel+bounces-360166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631099956B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992991F24547
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D171E7C0F;
	Thu, 10 Oct 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMDYSQBK"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D21A2645
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600219; cv=none; b=dNuF6is4b20pmP8+mFmeA34BYYMJQfRic1I5RSDOZvx2e20OlYUrcGGHpWSu/NuU1f/suTL2d6zvpscLdPAXLn5FhrslC6R29oJMiuyHxos6bUFVCXBrGZL2VNLnM1xcsvtEQNXM3BWhbRfP/z6eckDs4GyQnybhuQf+KPHb3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600219; c=relaxed/simple;
	bh=rRcI0RUw1Jag1h85kqXKMUNy1mgQSNv3nPlsJjUAN+8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4Ravx+o4baR55YntS0JraJn/8F5axLaDYSBJDxl22YKWHSUmNT5LdpJ8uSITTrffXQkKzRL4Tlf5uzE07QNQVpESzD0j57e0Ls8NjhazfJBNr7BXd5/H4Urydeagdgwvf5Lz5gf+Y9OqIXM3z2Xv8Bc7CqpKMaAwVSi1SZ0F0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMDYSQBK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1141a3a2aso102983985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728600216; x=1729205016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7kS0OwpIJ8lzGVa/z5he+FP7V/PyYuqC5d6o/YyS+0=;
        b=YMDYSQBKjIeJM0ic8v3SUwDll9eHP+RjqiIYApLoee42rh4Uho+ieUzqr8TywjinRU
         bxO3FWrZLJk2dyVOBw+cIDII1RVfY3UgOXF9YtxmIkBu8R53+p8AulLwLEm/DghWF0k8
         Kzi7ehWywrwZDWUg8FKHwxdI8rBB5VZt5q6t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600216; x=1729205016;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7kS0OwpIJ8lzGVa/z5he+FP7V/PyYuqC5d6o/YyS+0=;
        b=DYMmqhxUjpOJzAgByvWDH9cO0dP7jHhgR6mz/j/uPUhO5PLxRs5pyE9Y6LvUAmMEjf
         V02DSMu0RZlTDoaZQd7t8JXOpkioDEd4UcGBpe7tDo8Qp93b0CaUfXfmuvmpl0JOdgZ8
         SEE7zAICJU/7qMkefDP0juAHZsHz8E5zmpxMbjCvzl3QF0u3ljPbkW9CR4G/t1V6z7x0
         gbV07LhEPPJj0R5sP3AdJVe5hTKQhz56cXy7rPUCajvYf5iz8mV3+CE8Lo+aP168w0O2
         EY6Vur3oCAP07giHyILGauvv14+Yda28O3nHhhCG+A3HH3NqhjBluodlxByW0kQPk489
         VkXg==
X-Forwarded-Encrypted: i=1; AJvYcCVWWKALrZerQT5j+Tdt9Y/5XtgrgjqlDxX14k+Mocce/ZOvY4ksPVrhmQM4XwXEKRZ8ASHNuogKF7OP+Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaHFX2YDptXLME3ZFUviZ84xOBr0yQLcZvdYUCm+Afjyw2bfM
	Uv4Vgd97HD8HVm44fA8RD4dAn0AGw3scASaXwn0fbzyCodxNdMtW+gCO13iqBpNjPvB0eyghXCm
	PGJnAPOe7RvSH897mvss0wQk8L6HhpcPG9Wnd
X-Google-Smtp-Source: AGHT+IGgeD8OWkjTN2+txsFq08VyD7ih43EBc2xXYlKwMPaCKAPaVrQbOpHLD8TgOLBOWOgI5H4Qck7keHxdPo9DUQ0=
X-Received: by 2002:a05:620a:460f:b0:7a9:aba6:d012 with SMTP id
 af79cd13be357-7b11a37c515mr97106885a.22.1728600215870; Thu, 10 Oct 2024
 15:43:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Oct 2024 18:43:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27acewh6h2xcwp63z5o3tgrjmimf4d3mftpnmkvhdhv273zgsp@i6i5ke4btdqx>
References: <20240901040658.157425-1-swboyd@chromium.org> <20240901040658.157425-14-swboyd@chromium.org>
 <27acewh6h2xcwp63z5o3tgrjmimf4d3mftpnmkvhdhv273zgsp@i6i5ke4btdqx>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 10 Oct 2024 18:43:35 -0400
Message-ID: <CAE-0n53S2dFz74_rgx22_1i_bbEC6kj1SL5LAEq_F2wrdCgBNg@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] dt-bindings: usb-switch: Extend for DisplayPort altmode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-09-19 03:40:19)
> On Sat, Aug 31, 2024 at 09:06:51PM GMT, Stephen Boyd wrote:
> > diff --git a/Documentation/devicetree/bindings/usb/usb-switch.yaml b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> > index f5dc7e23b134..816f295f322f 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-switch.yaml
> > +++ b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> > @@ -52,6 +52,14 @@ properties:
> >            endpoint:
> >              $ref: '#/$defs/usbc-in-endpoint'
> >
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: '#/$defs/dp-endpoint'
>
> Is it a separate port or is it an endpoint of the same upstream-facing
> (non-connector-facing) SS port?

I don't quite follow this comment. This is an input DP endpoint/port.

>
> > +
> >  oneOf:
> >    - required:
> >        - port
> > @@ -65,6 +73,19 @@ $defs:
> >      $ref: /schemas/graph.yaml#/$defs/endpoint-base
> >      description: Super Speed (SS) output endpoint to a type-c connector
> >      unevaluatedProperties: false
> > +    properties:
> > +      data-lanes:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        description: |
> > +          An array of physical USB Type-C data lane indexes.
> > +          - 0 is SSRX1 lane
> > +          - 1 is SSTX1 lane
> > +          - 2 is SSTX2 lane
> > +          - 3 is SSRX2 lane
> > +        minItems: 4
> > +        maxItems: 4
> > +        items:
> > +          maximum: 3
>
> What is the usecase to delare less than 4 lanes going to the USB-C
> connector?

I'm not aware of any usecase. The 'maximum: 3' is the max value in the
cell, i.e. 0, 1, 2, or 3.

