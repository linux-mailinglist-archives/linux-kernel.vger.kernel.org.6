Return-Path: <linux-kernel+bounces-408989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F9F9C862E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B6B2D7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429181F76D2;
	Thu, 14 Nov 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWczNwvo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8071F26D2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576416; cv=none; b=HZLUy16tGKJBMRxn7hVpVqomS9U8OuLXe3WWpjKhSQVrCrBb009rQRN6mcU2ciY4r+AQHenzRWuMXtF79p8wmb9z7hexOnloYnUXaUEvlIh7bixoWRKsHogAwHSs5x1v0pN1het7qajPuHQ1eOr8DinK/qG0MJYNY7PdKQkn6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576416; c=relaxed/simple;
	bh=RVRmyPOQUtCwdEMnZ4ivPRmJ3eueanQ/bXMHHdB/nV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL0SA54m7SYbIFzUaCdqUYXAlVz202PIl/0d0bzd87mhmYMq7Tbj7Yop2lMLLXiFfD3rThRfVui0/vRFF+hyy70iPSzZL26Pjj1M9lPlWRu+kt2EuUUqdfrZkytqEOH3gvfaYtGM9j/3HWUKZJMAc/JEnctVn8scD5m7udwTo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWczNwvo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso2993765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731576413; x=1732181213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCTvx8T9mnRQzljaKVspAbsUZKT1CG0NwqFkm9WlBfc=;
        b=lWczNwvo6MLVT03lkA4PgAxkw3wY5rs+dew5fFiVSZmVDlBqbTbnBUqvK80PBGYtqX
         NEQmLbJpgHYBLD40903ZUE/MzhYRU32epC4yEsYb6SrxKGpkO6Bw9jfyTJDtVJVAAORk
         Mj3dBFWtmS47GKcMT8S24iSjcBKur8iS+V+DlzPueKBk69vYsUThAxZK4Z3w/TS679v0
         xDtVmjDWa0sSXo3dzf9dlWCNEENk/jD7C4wXsagyD/i0xWNzyMbJiOo13FopELikz2/S
         atKA0gb3jCqf70MURzdc8mGElhDZCOxyqzFfsMWqNxecpmScy5k21uJlqCJMOd8NTa9s
         O5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576413; x=1732181213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCTvx8T9mnRQzljaKVspAbsUZKT1CG0NwqFkm9WlBfc=;
        b=KJ+pxkUD78xa6B8VoUWloCx+oxSlM4Y0QRfo2GGgLTRUpdIq2pKIcrJtX74NOtCKWl
         fBSyb+KNVoImBNYbfgpxJrXWlwtoWDpmhIPKiaCNsD1q14bP3ASRfdp7bIgfdzW6AfdK
         IggOl3Il4fAGFQtuguZnEHANHRN3CWTQt/F5IEaFJDEMqRo/dYiKR8Q6HKRPLIEvNEAx
         msMguMneA3mZce/PMHEIGozNX73PI+pQbXcntgzj0rexSsj//w24r4n9lHxzLaDPOvuZ
         /0WCA0f71WLeXr75iI1B3BfTkXUND693IarRqjplZxwRBi9M7oV8Ji+0oVAbek82NAPh
         mwrw==
X-Forwarded-Encrypted: i=1; AJvYcCVPI3rs6DbuH5Z1LBBD1Bx0vZLEu3B/hK5Afa+dX+xkx31kCM5+N/dwgeJ3Z1wG6jZziwJ1hmTHj0uz82Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9A3dlijjoXJE/K7WhXd4Duwfq2Z06n0nVqUZaLQ1SA0kXVLVY
	enYNgpdChwfQ1c1D5p5GC4VzYTAD8WvowKV8iRO43VtyJ8HH6KoS+AzgdgZYnw4=
X-Google-Smtp-Source: AGHT+IGdySIXa9beofzpJLtb1EoXYIYxWpYJO9XaQFrJeQj6+O5OPLwg2HQ84siv6pKXWdYlJ0KRWA==
X-Received: by 2002:a05:600c:1c2a:b0:432:7c30:abf3 with SMTP id 5b1f17b1804b1-432d974a829mr22722795e9.7.1731576413154;
        Thu, 14 Nov 2024 01:26:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab806e1sm13852835e9.20.2024.11.14.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:26:52 -0800 (PST)
Date: Thu, 14 Nov 2024 12:26:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>

On Thu, Nov 14, 2024 at 06:19:12PM +0900, Max Staudt wrote:
> Hi Dan,
> 
> On 11/14/24 18:03, Dan Carpenter wrote:
> > This code is printing hex values to the &local_txbuf buffer and it's
> > using the snprintf() function to try prevent buffer overflows.  The
> > problem is that it's not passing the correct limit to the snprintf()
> > function so the limit doesn't do anything.  On each iteration we print
> > two digits so the remaining size should also decrease by two, but
> > instead it passes the sizeof() the entire buffer each time.
> 
> D'oh, silly mistake. Thank you for finding it!
> 
> 
> IMHO the correct fix isn't further counting and checking within the snprintf
> loop. Instead, the buffer is correctly sized for a payload of up to 8 bytes,
> and what we should do is to initially establish that frame->len is indeed no
> larger than 8 bytes. So, something like
> 
> if (frame->len > 8) {
> 	netdev_err(elm->dev, "The CAN stack handed us a frame with len > 8 bytes.
> Dropped packet.\n");
> }
> 
> This check would go into can327_netdev_start_xmit(), and then a comment at
> your current patch's location to remind of this.

So far, so good.  But it sounds like you've already written this patch in your
head.  Can you just send this and give me Reported-by credit?

> Also, snprintf() can be
> simplified to sprintf(), since it is fully predictable in this case.
> 

I don't love transitions from snprintf() to sprintf() but I won't complain.

> 
> It's also possible that the CAN stack already checks frame->len, in which
> case I'd just add comments to can327. I haven't dug into the code now -
> maybe the maintainers know?

No idea.  Can is quite difficult to parse from a static checker point of view
because of how it casts skb->data to a struct validates that everything is
correct and then passes it around as skb->data.  #opaque.  Smatch always treats
skb->data as untrusted, which is mostly a problem on the send path but with can
it's a problem throughout.

> 
> 
> I can whip something up next week.

Excelent, thanks.

regards,
dan carpenter


