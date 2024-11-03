Return-Path: <linux-kernel+bounces-393674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3489BA3E8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B001C20C08
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169C13BAE2;
	Sun,  3 Nov 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EYyrgkGP"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358713635E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730607054; cv=none; b=GOY9S5fCn7jPo+RJ52tp33Hs0qA1lrdqfwnqk9Xi/7/BS1e3a+ioQDKTZF1NkL/SBHQLNBnj3Fkgy+4YOc2t2Vbon7bk/g6od6AFohijqlt8c0OalxSJxqP7OLZgd1ZMtmF0NakQPW3RRwR/1EEKlaHxPEvvDXR8G7z5HAqzHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730607054; c=relaxed/simple;
	bh=xTxPw0CcizNWkYCAn8c8UgrWWW+GaQdSBsCV59pgcp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAihuQ8OkHwspUClkosQhjYGNz8MlWRTAObVKO7wC8fZP0LtoVPNq//arMKvF3PxHID/WyN1+3/HgXavMCXwqmVt4S+I7dPje7LprGKMv8mBC5jtzwRHyjqJXMiNyZrB1+zwYxM852wW8imFlZL2KAgEAS2ZMPy/cXEFrFqbI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EYyrgkGP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso2567287a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 21:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730607052; x=1731211852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/iCSnN/M7HQhmE74Mj4nBBH2JpYOpk0mdmCbZW6msY=;
        b=EYyrgkGPJeKu6FZm3u1tTfIc+wTGtbVo+pRf1pLT5tC3Z/2s6pjo7kerJMyZbRt6x7
         P0AQEQB9iKowkYBqOE2oIOKGTvt3p7Q0e5EYbaok9o9UnmCmj1rbRIqchE5AnUV+pFMA
         CTk+T0Rm7+SWU02amGzxQrggdtK0rWC5KBwjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730607052; x=1731211852;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/iCSnN/M7HQhmE74Mj4nBBH2JpYOpk0mdmCbZW6msY=;
        b=JsGsjXUMSlGcMY5Cr0ImVyh2540sB8UCOAo+FoxrHOG6bE9vtEE+0gbtxhtwic5/ke
         +IPn1CpeHd7z5IbmyvDZ+K4La7U/noE5YecFh0j8iVjkBSbvG3+Jgspvn9rNipPeEemZ
         rOqWYIlJP/aMUJrs+e4DWyt5Ij8sjOlU4UPo/BrRGt8l/yHo8cKMPUmva7ZwHjTAhezO
         uaSA/nG+7nlIQBdgYNzz4GfG0F9kjrv7sWz6Fkh+RYhuZilUa/KJFRl1UAVPvjkGuWg1
         E1f1q6uW8qnHT7ufu8MbXq92nz7E3w25rPB09mOU/t2R2jyE/hBXTAXRgBZvhRLX/T8R
         fn9A==
X-Forwarded-Encrypted: i=1; AJvYcCUA+Tl5+kAnvpfkxuwU5RDK/hK4uHXYKI+fv4Jn4P9SIk7SYP+GSm5dhckYAjOIzXZpiYUqmnGjSXCkH28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNGIsW6PKwiW+kzMSDGvQZB3UvTCJfM58NVFeH5C4QrKFmHnU
	6cjAtPK+GtA/2IJ0+hS2gZcWpiqkb1O3jP9iz7E4OTs6iQbAimeLRm5Jkj+uyZGQKKvS/lzznPD
	r
X-Google-Smtp-Source: AGHT+IEhUpctNzyB3Q/oVIYxbRXEG5RJ4wFo2uHDkY11JbH34UZ1+uPmsCEyS2zgljj0ve1XBu4tPg==
X-Received: by 2002:a17:90a:510f:b0:2e2:cd65:de55 with SMTP id 98e67ed59e1d1-2e8f10723a7mr31449321a91.20.1730607052119;
        Sat, 02 Nov 2024 21:10:52 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da983f9sm5131469a91.5.2024.11.02.21.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 21:10:51 -0700 (PDT)
Date: Sat, 2 Nov 2024 21:10:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, willy@infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, mkarsten@uwaterloo.ca,
	sridhar.samudrala@intel.com
Subject: Re: [PATCH net-next v4 5/7] eventpoll: Control irq suspension for
 prefer_busy_poll
Message-ID: <Zyb3yS6Whi5Na0lg@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
	edumazet@google.com, willy@infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, mkarsten@uwaterloo.ca,
	sridhar.samudrala@intel.com
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102233925.2948-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102233925.2948-1-hdanton@sina.com>

On Sun, Nov 03, 2024 at 07:39:25AM +0800, Hillf Danton wrote:
> On Sat,  2 Nov 2024 00:52:01 +0000 Martin Karsten <mkarsten@uwaterloo.ca>
> > 
> > @@ -2005,8 +2032,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> >  			 * trying again in search of more luck.
> >  			 */
> >  			res = ep_send_events(ep, events, maxevents);
> > -			if (res)
> > +			if (res) {
> > +				ep_suspend_napi_irqs(ep);
> 
> Leave napi irq intact in case of -EINTR.

(I've added Martin and Sridhar to the CC list)

Thanks for pointing out this inconsistency. It's not a big problem,
because on receiving EINTR or another error code, the app either
retries epoll_wait or, if the app is buggy somehow and doesn't retry
epoll_wait, the timer fires and everything proceeds as normal.

However, since irqs are not suspended at other points in ep_poll
where an error code is returned, it is probably best to be
consistent and not suspend here either. We will fix this in the next
revision.

Sridhar: Since the change is very minor I plan to retain your
Reviewed-by, but if you'd like me to drop it, please let me know.

The proposed fix will look like:

if (res) {
  if (res > 0)
    ep_suspend_napi_irqs(ep);
  return res;
}


> 
> >  				return res;
> > +			}
> >  		}
> >  
> >  		if (timed_out)
> > -- 
> > 2.25.1

