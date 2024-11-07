Return-Path: <linux-kernel+bounces-399716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124679C0356
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56BB2883A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B91F4FD1;
	Thu,  7 Nov 2024 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5DJKX/U"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026C1F4283
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977496; cv=none; b=Kcz1mwl+yuAeH0HrMY+6Tw47kosVBl8gR335iu1BLrZ58ET++SUGQ1m+vtWmFFb2rRJObZeFDRPwGXbDLNIjGc/6Ezg8d+Mthu00QxMR22UCRauLX5krIRdej4PL2UXcGtNZ6AoZws+i9qFjOQvYP3yLlQHec6Xbksd6GII0p9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977496; c=relaxed/simple;
	bh=YaWRgF2u/OB8BOO9Ky4swyutztuJYU0ZGNwM/rxID2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvydAfn3wjdCRwA6w8bVLElIsHdbDs4scOk8qIZDvgFwLGsK4pdOIieVBBfre2MNzoqhQ3qLI7Qc0RBs0EMGWhjyEqT/C9Ym4gGlpw++SoPz3H88ex/t4ba8TgOcfy6xRX7QuqltE0QblDoEn3Zu8bUHQ2nzAvtbQJwGMf9ms1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C5DJKX/U; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e8607c2aso773753e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730977492; x=1731582292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97Z9cUNlRY1G+rj+mYLxjk3fEnv8B0bcbZiw6A4H9UE=;
        b=C5DJKX/Uzr01CXQ1q4s6LrL0nKkKjai6L/9qdLa/t32g2mNSnq29QlTYnkS4K3xrpX
         Edqbdx0Um58W+Z9mzzpx39cH5CimGmoT2Xsg+st/4nTaSrDJHm7JBDH/N9BQ3PqLbQYe
         sfDSNRrQ9hooIVPSMmxUhhUU8QW1iWevKLJNsHcFtfTy0mGh2g+Q32rDpch+i4P8C+mS
         GeKD6Cc6y5TS1/xan8p9f0F4bK3MpdyRZ5ZMN6/SrjXtIy4vNRofr7+LGbfRpoMKIuBw
         YU8ZpPcbXyEw1dFHCAOjhgAWUGyLQDn2jck+48T6kVJNaWJ7kUzm9coqcnqTDfLBNrFl
         KyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977492; x=1731582292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97Z9cUNlRY1G+rj+mYLxjk3fEnv8B0bcbZiw6A4H9UE=;
        b=XQnmfnmKgApQTG0k7DahMvQxFq7uh8Bl01DmYUH5BwbXxEehNMSluEKKwKBZGAiDJw
         KeVZPP6cJER5y7AVnuPumEyUzNa73wWonnVSPhsX1/gpKOeHg+ht4YkLOc83cTYqfvab
         gxTO+6rMcP3YfdOY1PxBUZfLUazLxdGpao6uDztd8rQSCqERfmQvP9CuDtDXmtOnJsUa
         FJfFwGKWKg9p6r+uZq2hlu7D17ZxR4mqrPh+krUPIR+QOqynYW29EV83yVMPFQ3ojFu3
         fQ4zyFS8yhPP43hdMUNHcgSI+g2dNFLQ/Gt4KwTiiM//onIZyjL0IomuFUQDsrkGVKnj
         E4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOqwhmy/6atK7b2dGb8D6w3sOBBsSOlDZxRnoI4GDuQENBUuAXDcpZkqMKTTCOPvzjiyLcCOGWxH/flLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6qODgCPtb1SaioJm0l9lNrNw6wxmeobWaTCIrTMWRT4kNHi8
	GRM74bO2h34TzHr0juSs99RMo7BFQQy2SzFUxNzuBRklehXxrFYR4J2xf93kUlY=
X-Google-Smtp-Source: AGHT+IG3i2yOcInk4O9i79Yu7N13Bws+H6x2ZM6abFXy/dLgoxf8tc81hhjN4TeDqpsr42xb78YR/w==
X-Received: by 2002:a05:6512:2385:b0:539:e14b:309c with SMTP id 2adb3069b0e04-53b348cb1c6mr22316161e87.19.1730977491786;
        Thu, 07 Nov 2024 03:04:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8268577esm169312e87.70.2024.11.07.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:04:50 -0800 (PST)
Date: Thu, 7 Nov 2024 13:04:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Heikki Krogerus <heikki.krogeurs@linux.intel.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 1/2] usb: typec: ucsi: glink: fix off-by-one in
 connector_status
Message-ID: <a5a6zh5vmdsqyhfy3qdlirqxzhdu44a6ika3uoks5txm3ljm3m@2fht2vmgragv>
References: <20241106-ucsi-glue-fixes-v1-0-d0183d78c522@linaro.org>
 <20241106-ucsi-glue-fixes-v1-1-d0183d78c522@linaro.org>
 <2024110708-spud-clapping-4ae6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110708-spud-clapping-4ae6@gregkh>

On Thu, Nov 07, 2024 at 06:17:17AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 06, 2024 at 05:45:54PM +0200, Dmitry Baryshkov wrote:
> > UCSI connector's indices start from 1 up to 3, PMIC_GLINK_MAX_PORTS.
> > Correct the condition in the pmic_glink_ucsi_connector_status()
> > callback, fixing Type-C orientation reporting for the third USB-C
> > connector.
> > 
> > Fixes: 76716fd5bf09 ("usb: typec: ucsi: glink: move GPIO reading into connector_status callback")
> > Reported-by: Abel Vesa <abel.vesa@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.

I will resend it with CC:stable later today.

> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

-- 
With best wishes
Dmitry

