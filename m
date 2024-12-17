Return-Path: <linux-kernel+bounces-449568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9D9F50E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D591713E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726131FBE80;
	Tue, 17 Dec 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="alRyg0p0"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B781FBCAE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452057; cv=none; b=oVVgjkrXEyCivhm3fJukc4nh/clE5LMiSl9Z+3oFP54+EL2vNf+fHerKHpQyGpNmChOAUnye1Evs3ATmxn+GgwJBhQGKEsQCo7XgDm+VtUcTwdt6lvNixAyy5HcrwG6PKbnCIaHyMDfMn2Nu38AOW24nHbJxXEO3JK31edf7XpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452057; c=relaxed/simple;
	bh=J6QwD7x+lm5XadIBl1uLohp69xgLjMMyXU1tNM/lWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM8WM/n8KqSjMTGJ0tdJCd/R8LiTG2HYH98owlHJy6ybFrySG/dEfm0xxxZX/4C2qEyB3BzHBKp4pVqo/2Y+X4TCCcxpCOiXLdKrXFnz9725BvwuO9Go2zALGLks6n5ob8qY6MKvk+BHt9/82tw+GcbQ7KNuhlxkotCwGQnfpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=alRyg0p0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467838e75ffso68110551cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1734452055; x=1735056855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3Rccgquk3pMB0e8JLxIrtXCYyTNacSqTIXQ+I+xU6k=;
        b=alRyg0p0eHkzRig8i/llDqD5OHw4O0W9NCPLdS58FsCVY5l8WPkKQVcUHowOt8Lqvv
         ckxpSQNtc/Si53S84tmV/mQ4zSnGiVi+pn1aeMYkqZmOUeitXCtacuAxQ4mPivZelgwJ
         iRbKDZcsRZSeZ7PoZf3WWUBxulwQy+rz48VuGRH0LEUO0Mnli+xYBYu00/cy4EwvaR5w
         zPbaxlFceemxWvlISPIMWyyt2fr7sSYYPhkt8pcO8u7p+oq4lpCELX6QWOGdJXO/Vwpj
         yJ1MyIxYNPlhRACjG9G/YGzrU7TThO/ZMVJcQYtGLmh5xKdU4l6prlMHrj9i9MZ9YZx2
         dO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452055; x=1735056855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3Rccgquk3pMB0e8JLxIrtXCYyTNacSqTIXQ+I+xU6k=;
        b=DO63hlCXjB1ZlKLieS8dgRH+LznXL/RJEM4emDhp3Jtx24KJQ5nZF67z3q93diiOK5
         1NvYV/m1G/sLoBllJYW+YSnUv9/KWx+/N+IWzGlC6QFr6JOMtTno3rNf7tfp7oQr0y3o
         5xFHO07Gl8MS+8iDqvVd4S2I1pViAQ5S6Ougem9JHakSC2DTdU6bVOoO6l+yUk61lo5H
         i4vUGCKeXdVfldWJkJ7Qvaj+d8Sr3xwpHqyiADruWgpKOQdL5N7ZqPFfGdDjp0E4Mb4M
         rNJOppKkwqTaqq7I+25acBkV3R3OyWOK4e1ZlLD48mIx/7Wvrn3yaJ7X5pntigG5da0a
         f5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVbOIURjPPwwkCwyN8FqSi0dB5snmAIuXof8TRJbfZ+6mT8WVwY6CwWS5sF9RFZoo6mAihdE4jsl6vm0mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNX1rnj7oQpGrakTleywaKNy7M6E2gOmqSuvLgsVRk5nTZ8bp
	zb+uqS9GfQG5wHn6IVz9g50O8sMwdw8ojt85o8Wdf9npx1xgA0p7hNm8HEI8eA==
X-Gm-Gg: ASbGnculzZbIILzWk70Kj0b0b3IBaCr1hDW0c8PfFRkb95fDYqTyuDr2bpfm2HkQhiT
	S6KZVD3ave/2UDvey7AczLSxQTM84Q80pcGuqz46jN0Dw3rhmxzNvD2M1NCfYMpA5IQ8ZMdqxaS
	J9b1Sed8BVnA3m+VQUxkhpu3LqPhk9iaamyvVoswBKvCZ+TZlWYzmytH7e46zZTN/vRUMcyJYcO
	q/VIW4KHis0I9fWDYOATgI+NrD3pA4hKThMuX/c5+2eh7yxcGTmAHxg0Q==
X-Google-Smtp-Source: AGHT+IFoPz5nV0F70qkjNPbX4NA7B77WNReqNOXg8KtZoNW+iEe5zl1EB6kQNtekItrIEdv6nU0pbQ==
X-Received: by 2002:ac8:5741:0:b0:467:6cd9:3093 with SMTP id d75a77b69052e-467a582a976mr334266611cf.46.1734452054891;
        Tue, 17 Dec 2024 08:14:14 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::ba54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e84db6sm40614951cf.54.2024.12.17.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:14:14 -0800 (PST)
Date: Tue, 17 Dec 2024 11:14:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ma Ke <make_ruc2021@163.com>
Cc: gregkh@linuxfoundation.org, mka@chromium.org,
	christophe.jaillet@wanadoo.fr, quic_ugoswami@quicinc.com,
	oneukum@suse.com, stanley_chang@realtek.com,
	javier.carrasco@wolfvision.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: fix reference leak in usb_new_device()
Message-ID: <ccc1083b-5ae8-490b-b357-52e162ba0a1f@rowland.harvard.edu>
References: <20241217035353.2891942-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217035353.2891942-1-make_ruc2021@163.com>

On Tue, Dec 17, 2024 at 11:53:52AM +0800, Ma Ke wrote:
> When device_add(&udev->dev) failed, calling put_device() to explicitly
> release udev->dev. Otherwise, it could cause double free problem.

If you're worried that the same object might be freed more than once 
(double free), how can calling put_device() help?  Won't that cause 
udev->dev to be freed a third time?

> Found by code review.

In your code review, did you check to see whether the routine which 
calls usb_new_device() will do the put_device() when an error occurs?

> Cc: stable@vger.kernel.org
> Fixes: 9f8b17e643fe ("USB: make usbdevices export their device nodes instead of using a separate class")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/usb/core/hub.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4b93c0bd1d4b..05b778d2ad63 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2651,6 +2651,7 @@ int usb_new_device(struct usb_device *udev)
>  	err = device_add(&udev->dev);
>  	if (err) {
>  		dev_err(&udev->dev, "can't device_add, error %d\n", err);
> +		put_device(&udev->dev);
>  		goto fail;
>  	}
>  
> @@ -2683,6 +2684,9 @@ int usb_new_device(struct usb_device *udev)
>  	pm_runtime_put_sync_autosuspend(&udev->dev);
>  	return err;
>  
> +out_del_dev:
> +	device_del(&udev->dev);
> +	put_device(&udev->dev);

You added a new statement label but you did not add any jumps to that 
label.  As a result, these two lines will never be executed.

Alan Stern

>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
>  	pm_runtime_disable(&udev->dev);
> -- 
> 2.25.1
> 

