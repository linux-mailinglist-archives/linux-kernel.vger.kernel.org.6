Return-Path: <linux-kernel+bounces-195057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A28D46F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E2F284005
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052F14F9E4;
	Thu, 30 May 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n53RGcdd"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C21C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057240; cv=none; b=mubSAQmNq1yoMTgKGP7SdZG8sPveG/6nCvQxQFSvaTFBRG9t2ntTr0YX/TgyCiHGF9XQZ37puGv1BmjjMLvQl7OktDWkZHwbfpSfSo0njJHazMMt0J3A9V02z0qU6MWGShk5Zypnzf1x8y2oVrp1gVVMOHEd6fR5Upes0uoA73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057240; c=relaxed/simple;
	bh=vEnZFoXzjb5fBRfSjDYm+6RD7lbH9qdIx1YqZQzgPFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ookvj7HnsXrPCInlVS+ixWMgakZXk5tZtNHThLDoccpdjJtWGQvp7hyG7fC3kvzk8jdmsu1IO7vuL3jBQatHlvp9pq5YHC4nWx9AidWoqXvNRKh5+UjhOt4Q3VLtknVnf0Fg/BT2HZPn9fu3gi3yBfH/ol1Lu8je6IHbMD3ibWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n53RGcdd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so5768821fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717057237; x=1717662037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1Um35u1qvZuMCq7uXC40E27zn7y41HWRYxq0E1YCHA=;
        b=n53RGcddqCt2QoB6iP+krQmvEPipBTEr0Mt1HUv4OkwrCAzOE+Rp69aa5jXljbnhh7
         i2YHXiZR/7UQXMk8zUVtqy91ksmwXgrc1D42NvS4G9D0Gae5W1g2r39pDUlm5n+OAZCc
         lZgtXzSff9mPJoz6w2opQalNIgLBAQn6IaGcHuquUsRs00v5NsjTW0jqEDhwTZKs9g0V
         wjQG6Hi2ga/N7EpkL/KmD8NQYCHTlThRAXaMk3Re0evyzWAbfHqvQhl7QBvNNmjxINJL
         b6dmHed5ZEDDvzD3mm/u4JOgH5Lg1AvaZR3AaDLDaDo9urNxU4myvUlMCV38OqmRrZSk
         hSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057237; x=1717662037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1Um35u1qvZuMCq7uXC40E27zn7y41HWRYxq0E1YCHA=;
        b=Zw4lOlX/2Z4PCk3jSlV1St3kuNGdP9om1Aap5O9j+KyNHHK/7g59kmAxXo/iIcmr5S
         RLWYb9CzHekxbczb9D+Quw1wJljvR1QkxQoVtH5lnnZ9UTSpJ6yRXPCZu9N2pAebZ1t2
         zf0jarAI87zlTJEtFuqgWxaul11KVB4UPYXEoO08/0xPeD0th+f4O2TVBzpmxDYCbXPB
         DrMvLEZPzipXiUmB+dz8ERqlUMd45DXNJ2BC05gjDSmwvpQwwROSYRFJiMPEMfVQLTsL
         yBuDedsEGjbwjGIw4hTdKvC8FbKvZMsSIX+UfcF19axN63Qtr7t+zIzSt3OvcBx/cTdN
         6XrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStOP1vTW8l90O6NLmP52LaIE0qcR6vw9D0X0MtcY581Ee5konuL/mpIQMggDjcI0P6nrjQnf3gfGxQ7IFOh+p6RJy5Ib2LiyjyUZw
X-Gm-Message-State: AOJu0YyOhP/NthDnxCwYwItoHlWhBzcD/rH/eL2JgCrI3EWkBxuW8IBD
	IU6nEU+lozb398Hg4XXcCqmfpLsM5Ku5T1Cu9PVgYoY6q+woMfyJUXw0qOh3ObY=
X-Google-Smtp-Source: AGHT+IG3/pKyXe6kjvzBTBZ+kW9if7vnYQBxUVROYSW9nUw+zsQXQ7KKovh+kC7NueTuWgD/hjgJPA==
X-Received: by 2002:a2e:b60c:0:b0:2ea:83fb:3e1f with SMTP id 38308e7fff4ca-2ea848844demr7697071fa.37.1717057237335;
        Thu, 30 May 2024 01:20:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea847fbb25sm1282741fa.118.2024.05.30.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:20:36 -0700 (PDT)
Date: Thu, 30 May 2024 11:20:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ricard Wanderlof <ricardw@axis.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] drm: bridge: adv7511: Accept audio sample widths of 32
 bits via I2S
Message-ID: <777om4a55azemxmnjnzjeuymtaeg7fvygijnl6uiyfruey63i7@anpkpyotbbhd>
References: <91472c14-3aeb-766a-1716-8219af6e8782@axis.com>
 <m7sghjgqtm45yjkpzrekeab7doojagxjts7vmw23a3tqtjltdj@v2oencka3uer>
 <adac6043-19f1-e965-e9eb-f3f1eaa6e067@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adac6043-19f1-e965-e9eb-f3f1eaa6e067@axis.com>

On Thu, May 30, 2024 at 09:17:03AM +0200, Ricard Wanderlof wrote:
> 
> On Tue, 28 May 2024, Dmitry Baryshkov wrote:
> 
> > On Tue, May 28, 2024 at 12:04:49PM +0200, Ricard Wanderlof wrote:
> > > 
> > > Even though data is truncated to 24 bits, the I2S interface does
> > > accept 32 bit data (the slot widths according to the data sheet
> > > can be 16 or 32 bits) so let the hw_params callback reflect this,
> > > even if the lowest 8 bits are not used when 32 bits are specified.
> > ...
> > > ---
> > >  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > What about:
> > 
> > Fixes: ae053fa234f4 ("drm: bridge: adv7511: Support I2S IEC958 encoded PCM format")
> > 
> > ?
> 
> IMHO, commit ae053fa234f4 doesn't break anything, so there's nothing to be 
> fixed. It adds S/PDIF support, which uses a 32 bit format, but the 32 bit 
> format was not supported at all prior to that commit.

Agreed, let's keep it out of the question.

> 
> I don't really have a problem adding the Fixes tag if you think it's 
> useful, but it doesn't seem quite right to me.
> 
> /Ricard
> -- 
> Ricard Wolf Wanderlof                           ricardw(at)axis.com
> Axis Communications AB, Lund, Sweden            www.axis.com
> Phone +46 46 272 2016                           Fax +46 46 13 61 30

-- 
With best wishes
Dmitry

