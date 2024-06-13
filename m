Return-Path: <linux-kernel+bounces-213959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B11907D07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D68281680
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F667EEE7;
	Thu, 13 Jun 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIuyn12u"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBA6E5ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308729; cv=none; b=jDrdRstjaYXy/DmkS5KI1S5oNwxJ8CUYF9QMyt1QYEK8zj/q+m8wCrLGwdS9kBpJ8cKWQx4DMCdaFOzEx7oZogYffBwQV/RSIYD0UUUSV3RDzDsc7wQLR9rqnZ3Ko5ADbtMuGINo8CFrGpnrJesU5qJrtVVYZsFzBUMLn+kR/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308729; c=relaxed/simple;
	bh=8Ssi1Wk64QWUfBb7mj4mwNzyhBvvKGpbyu23BxvyHPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtemEFVleErc5POqbDUpTv4PT82WplCJfeoQCeGmAcpvMCztwUkZtlrPA5oQo9P8X4M+rci3zdmBPRFbRtcy5stlQEhHIYcpXA7UtYd6IfMIc8wj7+n9iGxDN/UeqP6TB1u0GK5oS5lrj7UvPI4dzRAARLBxJQ1vEbqjie5ClM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIuyn12u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f1c567ae4so1290497f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718308726; x=1718913526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8nD3Tx/2ajPq4oiZeg181ZjliU9kpOqAJj/ASz1bTw=;
        b=gIuyn12uaNsmCQL1WfEyhz2Fw4ZS090blHCGwLKM+y4V46dNWm7+WlA/aJHAxAXWEV
         VJyoZtPjJbGM2dSsx7uW6ka7I+viDfhQGpYspmWEJGBJb8GLbLXelaOnQCYWJJjo/rPP
         9DMd9zLJcXjOZK73XsdftQIImeqzbIAiG7hfoqlmMhQZzpk+K2lGBX2EcBy7ZdxVI/j/
         8Qo3RX5UNqthMQDyYkxIpDJHZ3cStJcMUg6VKWIGkPEdkl+hiufJIU1wzvoHrc2fCFtm
         GgW0hQYP6eTKC4oAS+BA7Wd9AMPXnHduR6NsXVT1OEkWyym0wvfWdXhhl3Z3BfmXdRGc
         n5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718308726; x=1718913526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8nD3Tx/2ajPq4oiZeg181ZjliU9kpOqAJj/ASz1bTw=;
        b=EILQc+6Xq4mTkx8U0cU5Pkc9WxhKAHdounLQDgRZJIHieDhscgp8r0MqJZa3UIngrp
         tqK2um3IZ5ekSuU8WaNYIWV6WaA6ASx8APfnyFLF6TS4iFlwuTlB7cY+OeUYz/X0fWop
         +t8/8puD1ta8lyPvYz8mMwogj6b7WvKt5UwUbe5b51uvM9ccgSHhkEJQe9/YxulMDLy+
         uC3FyJIwL3nKgJOSZkmLjr7VDYizNF/ihWpKhXGbfcvbfdQmxfBEqVbFcQzZUgrjArio
         G6N75bQax0sThGVSmXQlfxtIoosOcYxGb1k7JJ84RfHH+XIV9AdV2OsYOVzBy4Ps4GzK
         sX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCeJd1PtTWkX9oySJCnLdHqs2BkMZZ/SeaiUnM1FNsAhhNMuf0pTvAxxMra1hZdaXAmNSbYqVgHu1T4pA+TSVg1V4OuAb6vdQRohTE
X-Gm-Message-State: AOJu0YyDPC07VzXVi1ngxB/mXmuzyMHtew61FYBThjFaVewh6nVfUiF1
	NXwUlKCRzU5w3YMV+3MZ+BVxrzTK3fiHyQ37jiCnTiDKuRU1a4rrsmPEAvSigVQ=
X-Google-Smtp-Source: AGHT+IGhE54rnPxMpctAzOM52kvVqwoHNWOb3ufa5cu9POuaX89ge9H6lokYmXmoiIrQpIX/ilu++Q==
X-Received: by 2002:adf:e64c:0:b0:35f:1f3c:b632 with SMTP id ffacd0b85a97d-3607a746efbmr516075f8f.12.1718308725147;
        Thu, 13 Jun 2024 12:58:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a0fsm2545651f8f.96.2024.06.13.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:58:44 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:58:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	detule <ogjoneski@gmail.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation
 check
Message-ID: <a440cbf7-c6d5-4286-a69f-05e668522931@moroto.mountain>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>

On Thu, Jun 13, 2024 at 08:41:45PM +0100, Kieran Bingham wrote:
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 54467be8c371..67d853f5f2a0 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -804,7 +804,7 @@ int vchiq_initialise(struct vchiq_state *state, struct vchiq_instance **instance
>  	 * block forever.
>  	 */
>  	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
> -		if (state)
> +		if (vchiq_remote_initialised(state))
>  			break;
>  		usleep_range(500, 600);
>  	}

:/  In the original code, this would either break on the first iteration
or fail.  The diff looked like this:

        for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
-               state = vchiq_get_state();
                if (state)
                        break;

I feel bad for not spotting this.  A static checker which looked at
diffs could have made this work, but all of our tools look at a momement
in time instead of looking at the change over time.

regards,
dan carpenter


