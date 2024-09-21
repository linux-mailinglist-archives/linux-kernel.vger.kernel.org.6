Return-Path: <linux-kernel+bounces-334950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC597DEBD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131CFB20E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86796F30F;
	Sat, 21 Sep 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tq2NgKX7"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEB57CB1
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726949716; cv=none; b=EIIitFVxCB3yRZmXaNK3C8nKAssx71mOIxd6f+bsjlrBcpw8rXJfyuVGYEmJhiMWt35PONazB4tntXYLMyFkRnJPOrj8To1GSOC4nU9kfToTXQzrG31uaMY1xk4EaDnT8UPRI4QjtXFnfHw9R73jqDWv7pY10St5FIrE/v2Y4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726949716; c=relaxed/simple;
	bh=prM7Jh3/RSa4WvCCypCz+hxvItKPSvkA8jI3EkhkLDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgJ7DRZfuwUlxMVtuKUAK1Eg1cpWgZwFv9aaLp7mSa1AFqiFB02iKcxnNzzuJ+wkvTPANfsbOHmjK4jDvuxWLGWe2clb1gBElS4r6J/SOgkiWWGms2jU87E8hVRfF36hsWbIv/gzYmOpbeUGE3PT4wc/+wP8CO0jZH8wa/CP3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tq2NgKX7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so35586631fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726949712; x=1727554512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aueuoJk8vYdpJXqJjsbRBhB3fAkdhN+RWgn2HXmxoVk=;
        b=Tq2NgKX7XNRwhYwUUh7Hj0vxeIWMf0/G+35hN5Ti/7Pn5X03O18PZRIbknEQM5FF1Z
         w2IPVrw66Ntjz3DsKGoL5V4FdBIHtUsIv7ehQ2xfQsh0fjaB3aCd/SP0CH5YnEWdSkIm
         AnAx2mYvSNqb2mBXi/jon+IRREWibiGWUTfELkwKodH8Cw+G+hZiOltY2BkU7uQPm0xm
         /vRYU/5vC6JWsFKukRxRqMATl2UFZF5zvwMb+XZmCAV/lL6t1Wk7oHr2nxAZxfGAnqfR
         KtNAaOqahZXhsLviBhwKZA2sVZ5e9oiyBql4/qvJMhH/QbWBBaLGRzzeJOGixPLfA0Lm
         4OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726949712; x=1727554512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aueuoJk8vYdpJXqJjsbRBhB3fAkdhN+RWgn2HXmxoVk=;
        b=Tj0nbtzfnPw6ElOcXe1vvIIaN3nDCLkt8Bz9sOJbaRikW72FXu3oETofgsC7BNQY0T
         QU3A5g8OnK3vgD3Ph4JP4b9BOh2BYd+tCr29UBxVCga+rJc0//yh25J+H4TGehS4UYvC
         xm1/W6naNWb/u7mLUxV7w4N3XJX7/vLxISsTXuaoJQFRUfLS98+XvOgwrJLFYpNtHznZ
         jZvseXHq/QzY4ha+Ual4+p4yoa3Zi+mGN0Mt/WIqjawheuR/ku+dPZpEk8fRj1OuvMXl
         RvmrKWil8yocfZZrEWNlX/5z2UcnAxnkgrBtifiK8qzVRkQ3f0ZKfD+6JQmlpLdBzUcj
         LoRg==
X-Forwarded-Encrypted: i=1; AJvYcCVm+MNXSU+UFDODOtOpkbZm1OMeh6Bl9X3gf+sf43gc882W4GgTB30kL2zSrxhTafadf16ZuX2Vi2t8K+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21+BqOi5z0cJEUCqU1/7SHyyecqX0BYCG2T19iMw03/Uh3zbM
	O9JaJgXpF4I5EVZX5Koe8ek/zaILMlcU5P5pDUMXOMJywZ0aaVZuSRRS5E06RCmff0GyLlo4y9J
	VmWo=
X-Google-Smtp-Source: AGHT+IHE5Sz8PqI/4vvidVBPG6WlaqRCeC69ObQhJbeRe8p7Zgb72JR7dTMXYN9ujLUIFJd21mXWyg==
X-Received: by 2002:a05:6512:3b85:b0:52f:d090:6da6 with SMTP id 2adb3069b0e04-536ac338a52mr3756292e87.55.1726949712328;
        Sat, 21 Sep 2024 13:15:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704db0bsm2706147e87.114.2024.09.21.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:15:11 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:15:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: Re: fw_devlinks preventing a panel driver from probing
Message-ID: <34mewzvfyjsvyud3lzy6swxs7sr64xkgrbkxtvyw3czvoerct7@7guo32ehwa52>
References: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>

On Mon, Sep 16, 2024 at 02:51:57PM GMT, Tomi Valkeinen wrote:
> Hi,
> 
> We have an issue where two devices have dependencies to each other,
> according to drivers/base/core.c's fw_devlinks, and this prevents them from
> probing. I've been adding debugging to the core.c, but so far I don't quite
> grasp the issue, so I thought to ask. Maybe someone can instantly say that
> this just won't work...

Well, just 2c from my side. I consider that fw_devlink adds devlinks for
of-graph nodes to be a bug. It doesn't know about the actual direction
of dependencies between corresponding devices or about the actual
relationship between drivers. It results in a loop which is then broken
in some way. Sometimes this works. Sometimes it doesn't. Sometimes this
hides actual dependencies between devices. I tried reverting offending
parts of devlink, but this attempt failed.

> 
> If I understand the fw_devlink code correctly, in a normal case the links
> formed with media graphs are marked as a cycle (FWLINK_FLAG_CYCLE), and then
> ignored as far as probing goes.
> 
> What we see here is that when using a single-link OLDI panel, the panel
> driver's probe never gets called, as it depends on the OLDI, and the link
> between the panel and the OLDI is not a cycle.

I think in your case you should be able to fix the issue by using the
FWNODE_FLAG_NOT_DEVICE, which is intented to be used in such cases. You
have a dependency on DT node which doesn't have backing device.

> 
> The DSS driver probes, but the probe fails as it requires all the panel
> devices to have been probed (and thus registered to the DRM framework)
> before it can finish its setup.
> 
-- 
With best wishes
Dmitry

