Return-Path: <linux-kernel+bounces-390890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E962C9B7FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD329281361
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465E1B1D63;
	Thu, 31 Oct 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6VHh3kS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FD19DF49
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391231; cv=none; b=su85ch0s0DYcWQ9Pz2nqpOK+ZO7N9h8D63ucs6rGXywGG+fBcVCi738KCoFiP0QiKkzP2cDEjFWtB7qLpoc5I03xmNcb9l04S7tjDc9AYQLHv8Ub9SD4TfmD2Q2doy3m3lFjg0Y/ojTwRIjd6JH4m8QknryOYgJ3hHoUN3jKiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391231; c=relaxed/simple;
	bh=VvHPgknTQfkkPRYxQDkWVhBjIcD9nECdjixWNWNz9Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osYL5VZOmIYPZ+ZUu/krRsJ3dcWwEXoVc6jTIgjJjhUBQLdrtrPZw0/Gh4OQK0cWerhqy0/uxuhbjJDEE4dxo3/g7BHLjMp5LELf7iaPGCeiHIq5zqy24PE8ePo/qfDMHP/lhNYUEIfUyFGo+7c7VgtI+4flemHdTiyWrhiP+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6VHh3kS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so9084565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730391228; x=1730996028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CakDXS6c1DhzA9TEtNxJdDyagqdPs+BWOzw82gUl7A=;
        b=T6VHh3kSDIeLX3z+/Y5FEvnArpPXyc9rZr8sFFYNiFMhwNi9VelXgEHU2L21BvnCzx
         tBq1Fl6g1ORkjvkCt91gr/qsEwcUfp5LFrXOCz8uEMPtLwmbKt/ObLLk/QTq9HTNys++
         51al8Y5aNalXGxFiyS5/ygYB8KQ78BPpYifdvkTIB361rK6K3EyxO744LIuQE/e9otCp
         U+KepFKqabzRwTsmX4icFIJ5oHijaxKyDXyR8x0UneSxU9wslgyeT7Row8D0u43+TbHn
         KHn9DPfWr1MSrP8iRMQPhewlJjpQYGeg0odkQ9mca/D+Qmb+XAvXWdyZe84HIfVgzNd+
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391228; x=1730996028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CakDXS6c1DhzA9TEtNxJdDyagqdPs+BWOzw82gUl7A=;
        b=dMllAyqmhAvcbyJiS/DtBRg5EbG/bzC3k1+KDp95eelwk7X4PoIES4di+KreLvNNxa
         TRYteY1MVDdTAvTc2uK1w9mk1HO5nS9ie0od9eYaJZijPI+jA6yzQ2F2kZzqfaBgdHuL
         A/NmBQ9gOF7WClhHY8eXErqWtzvvJKyUBECUN+cp6UbedoAnxwYhO7InrDCGBgbSrbGG
         RkpMKN1nqd2+YfSegsku6of8ZJj5PLmdR7G92zLu0Q7IdK+h/TKqlWqO1ofShIWfDkMi
         bPn3JGyyTyk3m6Bikot1KEmMXeUEzatoWCIXiTqpcoDu97AaFO3Xv7cWgffv/X9kSmdr
         l5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYE87y/4pKjQVq3awZUVo85yphZz7EaVpxbTaLm1ojdiUOd9kKh9PEMvtX8BIBtX70LiaF7mVXaj5WPWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQt/6U5+QBrFHF/LaFTftgQzBRPyaWjYwztYdZmZP+AYiGzoua
	ZKlNWisS5wXuxxxRiaZllb5zJ4hLDFIRD4UjRqiNgHq22sdsZV91uggGKCfNFdZ95LIv5570htG
	W
X-Google-Smtp-Source: AGHT+IHCYxSGmVXNdG6HbEGSCE6KOxPf10odxndDOKvnEQsVM7GhMv1g4/6VDhU24xOmBDFWwJuNug==
X-Received: by 2002:a05:600c:a04:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-431bb8a01dfmr66125375e9.0.1730391227625;
        Thu, 31 Oct 2024 09:13:47 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852fdsm31030365e9.34.2024.10.31.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:13:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:13:45 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ZyOsuTr4XBU3ogRx@linaro.org>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
 <ZyOOwEPB9NLNtL4N@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOOwEPB9NLNtL4N@hovoldconsulting.com>

On 24-10-31 15:05:52, Johan Hovold wrote:
> On Mon, Oct 21, 2024 at 09:23:24AM +0200, Johan Hovold wrote:
> > On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> > > The assignment of the of_node to the aux bridge needs to mark the
> > > of_node as reused as well, otherwise resource providers like pinctrl will
> > > report a gpio as already requested by a different device when both pinconf
> > > and gpios property are present.
> > 
> > I don't think you need a gpio property for that to happen, right? And
> > this causes probe to fail IIRC?

Yes, I think this is actually because of the pinctrl property in the node,
so no gpio needed.

Yes, probe fails.

> > 
> > > Fix that by using the device_set_of_node_from_dev() helper instead.
> > > 
> > > Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> > 
> > This is not the commit that introduced the issue.

The proper fixes tag here is actually:

Fixes: 2a04739139b2 ("drm/bridge: add transparent bridge helper")

> > 
> > > Cc: stable@vger.kernel.org      # 6.8

> > 
> > I assume there are no existing devicetrees that need this since then we
> > would have heard about it sooner. Do we still need to backport it?

None of the DTs I managed to scan seem to have this problem.

Maybe backporting it is not worth it then.

> > 
> > When exactly are you hitting this?

Here is one of the examples.

[    5.768283] x1e80100-tlmm f100000.pinctrl: error -EINVAL: pin-185 (aux_bridge.aux_bridge.3)
[    5.768289] x1e80100-tlmm f100000.pinctrl: error -EINVAL: could not request pin 185 (GPIO_185) from group gpio185 on device f100000.pinctrl
[    5.768293] aux_bridge.aux_bridge aux_bridge.aux_bridge.3: Error applying setting, reverse things back

> 
> Abel, even if Neil decided to give me the finger here, please answer the
> above so that it's recorded in the archives at least.
> 
> Johan
> 

Sorry for not replying in time before the patch was merge.

Abel.

