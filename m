Return-Path: <linux-kernel+bounces-559975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63289A5FBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF537A3CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366313BAF1;
	Thu, 13 Mar 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWd7Cop5"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33713126C03
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883571; cv=none; b=BanHVSTrzJk5Ee5ck4CHFhQHtcHV+YYnVVK4YBqSoeMMFt/i+ANVLTv/LpZqe97HEm1UD+lzP6JxFvpFvVSRD3hlwdM8TdLxAfa2UeHhlYj1GXANxBi/xYuxXiEaezTHJiQlGSwMEUuoTDdtvL/oRvMynk+sq9aDhZD2rOVQ7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883571; c=relaxed/simple;
	bh=3veIpjO8FY9cGq7h4dDd4e1jM0+O2U93qbLKOByNvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnEIjPMIfnancmYr8jx510LBkV0KSAOaHPH4fIro163Zkg3NtQMmhhTVGV0GDQAIP3iRMeltRs/3HCv3MBUPGB7rRmQSjqKwIBWNZ7I3JpiGKAUQW7QzCf5n1HOChCF5HsBraA3lWTStLUZxapJhbpOoPZz6vQ+F3/IY6Wlf5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWd7Cop5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso8443375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883567; x=1742488367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pk/Fm7AsuFr4JJo8BZ86u/lcrGPbAwJL5zM3d+jgaXU=;
        b=JWd7Cop5QoaU7zfiVwkD+hpbVl4RYkzVRDKcdDUCpjSwQHB3S1G4m58i4qnMQkywk2
         G4anDUyJv4nf9BAiG8a+yGBV3J+97k459owgXH///x0XQ9kb0Z9nLQBV9X7/j3mRPtAT
         SajuhL4V7elPEuSDX4ZUiAE+uyODZ8ZjXYKpDPUXdn1oqHBO2OSXLAT6XHsipA/8RIsY
         o9dlV/6pvvJOxfHqsGJFgYaMIm+pGUpxxVrToIQG67OYrgwAvl4oRrqHRAICkN+mLO0n
         5b+w3joM+qfKjM+hYFZC/FFhbL0YuOqCQtnANOwnHbNreWvuAmGSFCSarzl16JTSYySU
         f8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883567; x=1742488367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk/Fm7AsuFr4JJo8BZ86u/lcrGPbAwJL5zM3d+jgaXU=;
        b=if+dZ4C0AZazlgSk/Zusw4wo0HN5vxf9HEJZeROXUkCqHj3MgAdF5ZjG8lLAbbV5Xg
         IYdVDjwQbB5uU/IBOqAoVRgKMvGuiTcn2mzlu2yOaHDxgBrtYHYKF7Od6jOIpRuks3oD
         5tnfn5tK1SQbOBK4Q3GVlbxLKFdUKFAI+2LHZwqopxhuUuf0OxuxiMMXwaz5JHnn0n5n
         rgh/zLwjqUIY/moWpTodZb7qZfaC50XntdAHx5rSxyUcf7R7wERhI8HYU0ywXOQtPgaZ
         CubLAaGxNyLRiPShGy81IWrKO+4+6KztjIyWfSuYc09s4MR+eYI/raKre2746ylUdRwK
         fWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9pmuIIXJp9+CUE3vSYSxy0gVlh8TiSa3i4KoBn5GIv7OdNcAfEoYm/cK/3xBaVhZDVB2uwqRfpZ17iTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/jgGy91jnZtm2B4WVzdZERunYsEIQ7wjdLN9XejJ1HaoZp6u
	3gUSkzASswtbIH6iYvBetWdyJSNidEPYe8y9Ygq7oEkfvfOHNNTkcTJ1e8uZ
X-Gm-Gg: ASbGnctPL9qhcu7p3q1g5qZYVjB3SjHmronTKHxoDiUY11dtMcGT7xxiMj+egLVrNFx
	xMGlNjscJETP0hsahECp2c1DSh1KZkSgKrQHTRL3EJM9ySwtupOgXPQZKY0nKefJzzlIt0J5XRO
	QZexLICh8ZiI0LqzAeFvZ9rFPH/TeJ/1JVE5n6QEEVrVByLrYAlraW7IIQBRS3VorU0+stwq2oG
	wyKcmsGMDS0y5rHQqDQQDURtrK815oO18Vusj+b1TWllXqCchR26XzNnRsN9IFrv4V+1jsW6mCC
	cf+pPd5JD+xRBmYxprI+8jnbUzOa3CmY0VvFqDGfhuiGD+uN0UDItHsxBqZ+
X-Google-Smtp-Source: AGHT+IG/hk48lJj+8hPeuQY7ZauK3kX+fOhVWAQsxMsK5NG87kEnNFiSO3KeVKBv0+Muv22DdhY3yg==
X-Received: by 2002:a05:600c:1c83:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-43d1d8e7dc9mr2479425e9.25.1741883567071;
        Thu, 13 Mar 2025 09:32:47 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b12f3sm26084425e9.4.2025.03.13.09.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:32:46 -0700 (PDT)
Date: Thu, 13 Mar 2025 17:32:44 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Add return value to request_control
Message-ID: <Z9MIrOJ-8NQjtwLA@egonzo>
References: <20250222202301.3729-1-dpenkler@gmail.com>
 <f7521c95-e69c-4618-b078-283c156ca594@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7521c95-e69c-4618-b078-283c156ca594@stanley.mountain>

On Tue, Feb 25, 2025 at 11:59:56AM +0300, Dan Carpenter wrote:
> On Sat, Feb 22, 2025 at 09:23:01PM +0100, Dave Penkler wrote:
> > A number of drivers are unable to release control due to
> > hardware or software limitations. As request_control was defined
> > as void - no error could be signalled. Some drivers also did
> > not implement request_control correctly by setting
> > controller_in_charge instead of system_controller.
> > 
> > This patch changes the prototype of request_control to int
> > and adds the appropriate checking and returns. In the case
> > that a board cannot release control EPERM is returned. The
> > faulty implementations have been corrected.
> > 
> 
> This patch is hard to read because it does several things:
> 1) It changes the functions from returning void to int.
>    This is the overwhelming noisiest part of the patch so
>    it's hard to even see the other changes in amongst the
>    noise.
> 2) Returns -EPERM if request_control is false.
> 3) Changes some stuff like SET_DIR_WRITE(priv); and
>    ENABLE_IRQ(priv->irq_SRQ, IRQ_TYPE_EDGE_FALLING);  I can't tell if
>    that's related or not.
> 
> You'll need to do it in two or three patches.  The first thing is to
> just change the void to int.  That's a simple mechanical change.  The
> only worry is if some functions are returning an error code on failure
> and I don't know the answer to that.  (That would break git bisect so it
> would be against the rules, even if it's fixed in patch 2 and 3).
> 
> The actual logic changes will hopefully be easier to understand when the
> diff is smaller.
> 
> > -static void agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
> > +static int agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
> >  
> >  {
> >  	struct agilent_82350b_priv *a_priv = board->private_data;
> > +	int retval;
> >  
> >  	if (request_control) {
> >  		a_priv->card_mode_bits |= CM_SYSTEM_CONTROLLER_BIT;
> > @@ -354,7 +355,9 @@ static void agilent_82350b_request_system_control(gpib_board_t *board, int reque
> >  			writeb(0, a_priv->gpib_base + INTERNAL_CONFIG_REG);
> >  	}
> >  	writeb(a_priv->card_mode_bits, a_priv->gpib_base + CARD_MODE_REG);
> > -	tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
> > +	retval = tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
> > +
> > +	return retval;
> 
> Get rid of the retval variable.  This should be:
> 
> 	return tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
> 
> > diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
> > index fd2874c2fff4..3d51a093fc8b 100644
> > --- a/drivers/staging/gpib/common/iblib.c
> > +++ b/drivers/staging/gpib/common/iblib.c
> > @@ -418,12 +418,19 @@ int ibsic(gpib_board_t *board, unsigned int usec_duration)
> >  	return 0;
> >  }
> >  
> > -	/* FIXME make int */
> > -void ibrsc(gpib_board_t *board, int request_control)
> > +int ibrsc(gpib_board_t *board, int request_control)
> >  {
> > -	board->master = request_control != 0;
> > +	int retval;
> > +
> >  	if (board->interface->request_system_control)
> > -		board->interface->request_system_control(board, request_control);
> > +		retval = board->interface->request_system_control(board, request_control);
> > +	else
> > +		retval = -EPERM;
> > +
> > +	if (!retval)
> > +		board->master = request_control != 0;
> > +
> > +	return retval;
> >  }
> >  
> 
> It would be better to reverse some of these conditions are return earlier
> where it's possible.  (Always do failure handling, not success handling).
> 
> int ibrsc(gpib_board_t *board, int request_control)
> {
>         int ret;
> 
>         if (!board->interface->request_system_control)
>                 return -EPERM;
>         ret = board->interface->request_system_control(board, request_control);
>         if (ret)
>                 return ret;
> 
>         board->master = !request_control;
> 
>         return 0;
> }
> 
> regards,
> dan carpenter
Thanks Dan.
I will submit separate patches once Greg has merged a new baseline.
-dave

