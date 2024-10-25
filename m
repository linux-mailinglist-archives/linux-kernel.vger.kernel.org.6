Return-Path: <linux-kernel+bounces-381084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC19AFA22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BA81C20F52
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00A1B0F14;
	Fri, 25 Oct 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYs7q0Xf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52131A4F2F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838222; cv=none; b=ostB4zLZIvPsbUZwVHTVsg6dKEu9TE3o0uh5pd9W1+4uXgmSqDd1LMK42Xh6uLHitkVn0WV7yFP/WBmESDbIw/uqcKzJb4GXsHIGPUsM/FWuYo2e4+dMn5c4nNVI5d/bBhfEksgsP0x2ZGIlybByudd877cTHTqAx54Bp/u17NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838222; c=relaxed/simple;
	bh=76iF+HoeaObIOvzYVxcE5SrRSGI44xQ5VLVhbj7HBHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNmshJcMANpdwr37A9PqYF7ZsacGUTq1khDuysvouZQOBRb5YDeYRRvd7sxxsfoIke32wstuoLsnrywE5AqE+E0IzAw5o9lTRMCpDcvY0siffnscQ/gE7mLGb7pX8c0Um0lC6sHB7f9Ht6Iks8Gu+MxPJ57t+q58v3XqEFup+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GYs7q0Xf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1730203e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729838217; x=1730443017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Db9W0DcUi/dDjwgp0S1+zwbk/KalyyaD0ylTsRWE1NQ=;
        b=GYs7q0XfOvlwoMF2SSTCedPhsAh7B7f9WmfNIzEBNIfbaxwQysPvEIo+uAvfDNREJZ
         TqF9NMvUuH7870whJdZ4kcIMipDYedq8cOJYlhclHzaf+5tCb7RR+eYIyE41Q1a5gGDC
         AvgDCYwlkhd2gjcVGRJhGF4rlq63LBT4qx/yjbBRSmLedTVua6qTqgKRGZA7mqLFeSJl
         /NzaGK2Kw2eOs8xygTqcsyWA8/XJwP6/CrfXGlDkJBkRxaIuLrxTHn/iyBJJuKQTQV6d
         xLCGJerYbznOao6iPX8eq23hub15ckbvAa9kSkBzShWq7NEmK64FXnjYqZo4HxtmEP8R
         rIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729838217; x=1730443017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db9W0DcUi/dDjwgp0S1+zwbk/KalyyaD0ylTsRWE1NQ=;
        b=noFzZzTBE/99tqAolYRSgRSuY1WIK9NmBm2XF7e67N2/E3I0emB5oHTzgcQ37bv5Mi
         pQFd204Z/Gc/hMWBSaFuIzmP1ZUBaSJAw5JKHlQuNZp8IC5sUjXtlvz/6xVZguaT8Qsr
         h1hHtwX1a2ScileXpOHRfPyqEfvv3eafHA3OKA60gF64zKtGr5NUwZFQd7CHeqZ+jaZd
         CGqSaRmFo3nHnq4xj+zxSQdo4kUvmBT4wVGmKtYgwuRCfDA3c3DFG0KU6zFQNNET6e6n
         PFQZKgWak/Unnur+++rnnb9MV30xKx1lqfomwboVuPv3Mq0kwAK4ouoCoPkoM/JUJWTH
         q9GA==
X-Forwarded-Encrypted: i=1; AJvYcCXssMXeErBaOJeDFLWnfk1R8FhhQbMesx9xAyz+xANyHG37AT/CYvpjgJ+i2OfnsQ3JgtBriAWZDDRT/oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7nvFqokwKJosC4pJ/lPc5GHq4DXQFyaNzeqDgX3zlHTxO576
	E4N5f7yGkOgs8JSkWzRCVJqXCNyZP/rih6Q5tLbrdCBOe8VYicOOdVIJABx7R4o=
X-Google-Smtp-Source: AGHT+IHWV57T+/9EhAWqxTiykSOfZ5lc9WHgI9sMVd6VKkCShvL2exL1I+UVy6hyP0AKb8v0iecgSw==
X-Received: by 2002:a05:6512:3e0d:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-53b1a2fe533mr5111135e87.9.1729838216924;
        Thu, 24 Oct 2024 23:36:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a53csm72820e87.55.2024.10.24.23.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:36:54 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:36:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 13/18] dt-bindings: usb-switch: Extend for DisplayPort
 altmode
Message-ID: <yatu2snt2w7lrveftlfbkw6yfvso3jbsma5v6jij4rn7v37hjt@ww42wer6bytj>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-14-swboyd@chromium.org>
 <27acewh6h2xcwp63z5o3tgrjmimf4d3mftpnmkvhdhv273zgsp@i6i5ke4btdqx>
 <CAE-0n53S2dFz74_rgx22_1i_bbEC6kj1SL5LAEq_F2wrdCgBNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53S2dFz74_rgx22_1i_bbEC6kj1SL5LAEq_F2wrdCgBNg@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:43:35PM -0400, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2024-09-19 03:40:19)
> > On Sat, Aug 31, 2024 at 09:06:51PM GMT, Stephen Boyd wrote:
> > > diff --git a/Documentation/devicetree/bindings/usb/usb-switch.yaml b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> > > index f5dc7e23b134..816f295f322f 100644
> > > --- a/Documentation/devicetree/bindings/usb/usb-switch.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> > > @@ -52,6 +52,14 @@ properties:
> > >            endpoint:
> > >              $ref: '#/$defs/usbc-in-endpoint'
> > >
> > > +      port@2:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: '#/$defs/dp-endpoint'
> >
> > Is it a separate port or is it an endpoint of the same upstream-facing
> > (non-connector-facing) SS port?
> 
> I don't quite follow this comment. This is an input DP endpoint/port.

This is the question: is this a separate port or just an endpoint on the
port?

> 
> >
> > > +
> > >  oneOf:
> > >    - required:
> > >        - port
> > > @@ -65,6 +73,19 @@ $defs:
> > >      $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > >      description: Super Speed (SS) output endpoint to a type-c connector
> > >      unevaluatedProperties: false
> > > +    properties:
> > > +      data-lanes:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +        description: |
> > > +          An array of physical USB Type-C data lane indexes.
> > > +          - 0 is SSRX1 lane
> > > +          - 1 is SSTX1 lane
> > > +          - 2 is SSTX2 lane
> > > +          - 3 is SSRX2 lane
> > > +        minItems: 4
> > > +        maxItems: 4
> > > +        items:
> > > +          maximum: 3
> >
> > What is the usecase to delare less than 4 lanes going to the USB-C
> > connector?
> 
> I'm not aware of any usecase. The 'maximum: 3' is the max value in the
> cell, i.e. 0, 1, 2, or 3.

-- 
With best wishes
Dmitry

