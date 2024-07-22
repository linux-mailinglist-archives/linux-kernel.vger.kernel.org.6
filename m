Return-Path: <linux-kernel+bounces-258370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87328938722
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E11C20B19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77668BEA;
	Mon, 22 Jul 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UqVoU5D4"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5B4C7D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610449; cv=none; b=eqa6jddk7a6XJgMIDXjvx78GC+i15eKPsWwHPEjYSzFWt4Ewx4hrIGUGSQzkiAAUj5O+vWtMo+Rkf0JHRw6DhWRHgruGQrYeId03H7tIsncsUIsudTkKdggaKkot1adsj63567H7ERGtmPyUvfkZL8ddcaGaDXrt94M4cJnhR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610449; c=relaxed/simple;
	bh=TSmfXgnydARLwr7mv0kzl+RBgKIwOhswaVDeCGIIVsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF9jc+reX+vW8qZQjGOc3L7iLpvEL76Dc8C+S8OYxOSjkxCR2WwTs4QyF5InpHtE6+pnrKp1kbK1NvRP2wLHwbcWBjbNPeSPp2PWohI7Qux6VhbEgvGnPlUiZSxSEMBoDncu2APhzvCZ0Ajw10TAHOobX40SjY5nYCHkWbYR3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UqVoU5D4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f0e7faafcso233602585a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721610445; x=1722215245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAHiE58iDMnOq7mpXPmqVzhRum0LLcYC2L+ZB58l620=;
        b=UqVoU5D4q4F3vw9mqbZxyGwMLKlzaY87cl2DV8Gnw1eiwWMk3yfXuyjmdBR2SIxOZA
         sncd2HrnE3LFegeDK4Sav1jlmcDG6En7b2hJG9JZfnd31ShVSIeD1pXjw9UZI0ViETzt
         UOCHW6iYE6VDWLxNZMju+0CNrvjHfBPg0FkMsVM9QfPH5GBy3EkB4kaC8H5LjfEDJs03
         gTrUS0s2X9ZqnJsQ1ICy208uCXUhBrGyMBD9Od6AV4yYLAtFvlXYgqLU7+JcDNkrIzTj
         2PABlgugPMsF6q3yCcBobwX0LR0DKr4WBYn3EPFmCIYNS4+DhaPgbFm7vcBPVGBf8vAX
         J8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721610445; x=1722215245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAHiE58iDMnOq7mpXPmqVzhRum0LLcYC2L+ZB58l620=;
        b=Azcdi6D+xIzAOMK+BjUKU6JLbGlM/lAQ492XXH8fsPoHeSXon7NgC9/X7pa8wLa9Ax
         L08tN6Qi67tA/gFVfeZx1EclEspYffcI/hV8b76yioqp5CSxzLA3Mq0/hEU6YaLzASt0
         AP4GsNc5JZFZJkgzTaUKmAhy+kZ/1YonkjCHtd+SUTeIOeR18S0w4vePecU46EFyGDuj
         Zbxdmsh3fqo+TmX2ulKnY3QJnQaU5kyttbyezINrt1VloXWcsaSnWQyiU/HZ9n/CQfpm
         wfzrzFGAnIZ4c1ZE48P8nIghmvbPbJCwHjCazmTWK069J/6iuUjx1GOZu/1YasPhLkmB
         SRLg==
X-Forwarded-Encrypted: i=1; AJvYcCWwMqS1vl88EXGCKoC9yj1GdTiS1+Y5MVWXpgg2nxkTlHHbcoOpMW4idB8AIL2T0p/8FJqnxx1mLVxK/bKCl5PujqDx4ruUAnDKdSVT
X-Gm-Message-State: AOJu0Yzcl9Y22rQGYawst5UkjnkKLavSznfQGsdJNyQQz0rUnF2BKOm6
	/LKoAIgYwd1xHOHPgeE7qqx+iv/i0M4Laxwo8rQgfzNdAO474049sypI9Nrm4g==
X-Google-Smtp-Source: AGHT+IH9pnVMRWIV3YKK+JwL6olh4K3erV80NpJ3mXsnmlqGMvAHvjzn6pvEYnaMSnwmCMPoU9uY+Q==
X-Received: by 2002:a05:620a:3954:b0:79f:4b5:3697 with SMTP id af79cd13be357-7a1a667f968mr641629585a.63.1721610445036;
        Sun, 21 Jul 2024 18:07:25 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::179c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198ff997esm308267985a.56.2024.07.21.18.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 18:07:24 -0700 (PDT)
Date: Sun, 21 Jul 2024 21:07:21 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
Message-ID: <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
References: <20240721192048.3530097-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721192048.3530097-2-crwulff@gmail.com>

On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> From: Chris Wulff <crwulff@gmail.com>
> 
> Make sure the descriptor has been set before looking at maxpacket.
> This fixes a null pointer panic in this case.
> 
> This may happen if the gadget doesn't properly set up the endpoint
> for the current speed, or the gadget descriptors are malformed and
> the descriptor for the speed/endpoint are not found.

If that happens, doesn't it mean there's a bug in the gadget driver?  
And if there's a bug, don't we want to be told about it by a big 
impossible-to-miss error message, so the bug can be fixed?

> Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wulff <crwulff@gmail.com>
> ---
>  drivers/usb/gadget/udc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 2dfae7a17b3f..36a5d5935889 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -118,7 +118,7 @@ int usb_ep_enable(struct usb_ep *ep)
>  		goto out;
>  
>  	/* UDC drivers can't handle endpoints with maxpacket size 0 */
> -	if (usb_endpoint_maxp(ep->desc) == 0) {
> +	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
>  		/*
>  		 * We should log an error message here, but we can't call
>  		 * dev_err() because there's no way to find the gadget

This will just hide the error.  That's not good.

Alan Stern

