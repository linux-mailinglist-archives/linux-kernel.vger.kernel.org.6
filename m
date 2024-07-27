Return-Path: <linux-kernel+bounces-264213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D9793E03E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7C1C210C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1B185E4E;
	Sat, 27 Jul 2024 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKZ7iXv7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DB17F4EC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099575; cv=none; b=a6MDxGwP7JUP1Yc6ft/DTnrEEgFRIQi0glsUpwhUt6hTZEGVfMZeRH1JjU4vQfPvJPSTTZjYBjZHFGYXQQBVLB3opcXWgN7EaZvM8dunwN0e0RyhshvN3573wdCY7LmqxtTponWpWyrqvn3QMpE7EnwaSuzxbyH5ivRBHSXEo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099575; c=relaxed/simple;
	bh=10M1rd0S0FluUN+xNvAjTZsGuD88h1gL6815ad9VQRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuzras2RTW/IVJzzHDtDONPR1l4n4VPW/VKZzt9Ssk37ORzAa8jW6ybP5nJPMknvZXNOfyBfOCX6BiUytkmGKvAvMaJ5WLRdGIX6+p6DVRxbdjEL+1numpJEkTy/SYoFzgbBvO5kaghHy4ignIEBlmzgEzpu/LvaEHGpus/sjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKZ7iXv7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so33393631fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722099572; x=1722704372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gk5GM3ctrLM0FMWDo1AQm58vDMFpTA2WEvE44P/cxM=;
        b=AKZ7iXv7K0wuoND0WTAo2bviiUF0ldhoc7eSYZQQH6pab4Y4uvAVfIzzfbX9+L7kDv
         AeQCQd+Q6VcpKbvRknh3nF6bmAnOg2LeTZNxb+qJ5XGZ1tnDVQVU6wUYOu016jC6PIn7
         b0GpZdOuab3ItOEfHFzC2H4Qvfg3KRpxNu4aqu1gIzVQB2jn9lPYo5FBkCXTFk66Ycz2
         kDBnsV853Ua98ohe2IZsPu1mQ45V5aPMhLRduF1ka6TCj7q3Y+OMs6FBL3yT7uCrr6CI
         ImmzuEciLo72QCK9otdyMKgtSQL2th5gtAc87cnWoWwQEnMSNUagdGevhRiupYlhHMQf
         FoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099572; x=1722704372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gk5GM3ctrLM0FMWDo1AQm58vDMFpTA2WEvE44P/cxM=;
        b=CZJy4tYaHnbld7xbbesMO+nlSeYhOtLfMozGcPD9J65Iw4V5lkxLo32yX9RHXSIOfI
         hRQoUXekDFjCDnJoElAoxvvwfZWZq0eEV1j4eE/DP6cN8FVETNL42SsXYUtK8XhWyduA
         NGFG/8HOtRjEHcSWZG7HyhknAHcvyn5n9cbxPj6aJ5IbiPiZpOFX7HYaV9ggGKoHcekr
         sJJ9ne9dQK69yXC+kya3dgSRi9IK9ZFesBhM5JUMF3agkpxttJAZUnzatgbrgVGuvT34
         azsowFGAdXtTt7z0r2fTRrplmbRxPEBVIy7BGkOU6RrBDjPXTrd8v4RegULcK0noijAB
         hztA==
X-Forwarded-Encrypted: i=1; AJvYcCXLOw0jQ5SdunzEC5GsrsiUtv8AvXN6lzQbiKuplCLSfj3S2APa4MOg/jw5rXWSjP4NW7JeaDdzID+4AQxg3EL9I5AoBWeonJ9qrCWV
X-Gm-Message-State: AOJu0YxpbESphn2Wj5s+D15NU5SjExWObWV1cFnsad/aFp6RPc+VB+qt
	fN2YzHegayy9AGf7uPBjXvd3apHI8nqY1Sq3Uu6lslK20mxgUVITeUHEaYewLL8=
X-Google-Smtp-Source: AGHT+IE3fVok8jVWIevkO7VjdQYKIoF1cWveKICmqrEYsXNGTEAHv63UrD9YRX8c3o9qZ0t5jmM1fQ==
X-Received: by 2002:a2e:9350:0:b0:2f0:2760:407c with SMTP id 38308e7fff4ca-2f12ee42005mr18468581fa.30.1722099571545;
        Sat, 27 Jul 2024 09:59:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0df8csm7343871fa.15.2024.07.27.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:59:31 -0700 (PDT)
Date: Sat, 27 Jul 2024 19:59:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, dianders@chromium.org, 
	hsinyi@google.com, airlied@gmail.com, daniel@ffwll.ch, jagan@edgeble.ai, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Move the sending location of
 the 11/29 command
Message-ID: <gq5fcttutomphgfrwrtloqzczia3uc5qpont3lrowocan2xjc5@ubfabhsh3mfl>
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>

On Thu, Jul 25, 2024 at 04:32:44PM GMT, Zhaoxiong Lv wrote:
> Move the 11/29 command from enable() to init() function
> 
> As mentioned in the patch:
> https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> Our DSI host has different modes in prepare() and enable()
> functions. prepare() is in LP mode and enable() is in HS mode.
> Since the 11/29 command must also be sent in LP mode,
> so we also move 11/29 command to the init() function.
> 
> After moving the 11/29 command to the init() function,
> we no longer need additional delay judgment, so we delete
> variables "exit_sleep_to_display_on_delay_ms" and
> "display_on_delay_ms".

Won't this result in a garbage being displayed on the panel during
startup?

> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 59 ++++++++++---------
>  1 file changed, 32 insertions(+), 27 deletions(-)


