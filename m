Return-Path: <linux-kernel+bounces-442691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0D9EE060
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F1F281C87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3F204F96;
	Thu, 12 Dec 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7dxJk8e"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144B25949C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989296; cv=none; b=u+R+lo28TxgcGMzgw7E/i84jiRlshSjgr5JbbD1hFm1Fgk/71rqPQHO3Xe1BASYg48Hp9wkYfv4sx4ti4l3cZJ0D9m+Z4liMdL73LvmaFJNZBg/Twxvi/fGMDwem9v3AdiJDi60OPYk3T6I0XGzFCIRSs4STFoJDc1g7fQofswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989296; c=relaxed/simple;
	bh=EUBobYXQZiLD4hslG+oQmMMJV6Yr4KWXctI4rJhc3uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMw/pgI+D3Jt8Ugj26UnaenI3BBc5j1PzUWaPxR7DmnKI36wYl6Br+97nTQhuyXxeBDrRgFa0yabH1abZQlV+meK5cS1xU0ygIJDbHu3CccCLLW8zoPXWR1uwvvvdCrtBS0dkGb6PyanswwxbL59rfF0mgsbCfmZfYWB3KJge4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7dxJk8e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43618283dedso2440395e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733989292; x=1734594092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCiBP5LajWp59TfXrN2BswKGn4PoDtGZIDcfjDmBxic=;
        b=l7dxJk8eEg49CYUTbDMGcQMGe7k/qbngkAWCNOAsCArmtviGGD5dCu2fstFNMTgZjI
         xRnbdVtYBe+dJmYF8kvGdtkhf/62ngP+ED1W1cmRbL7nkI2bAimeaRQ+asNUkWNlkHwT
         7JpDKveXeVy2X+nfe30kIcJKjiRXWL/wHTS83WEBiSdvedE51p6UyYi6Kax4JKObNNbm
         AawCZDeCfJdXsr1vGG2GRPkqqjCluAaKyAFq7wfktfKtoj9Gs7jJeNGSimCrKMVsl09q
         7kj56wKDRBVV3dVRpxL5VwwOkUhVL3UOD7T9NDGwqYaJtWSXSrqi4C0QRX8rXif1i1mD
         tqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733989292; x=1734594092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCiBP5LajWp59TfXrN2BswKGn4PoDtGZIDcfjDmBxic=;
        b=bQUpHgF+y/wFrB9dYDCy1gq0lVaQZ2RCyNxUKn8+OFm/xrOEBMTc39spHfSmwiVW9Z
         GfHpVnhgA9xZtRKKz0Pjiti7lk79MHBnhH2Fj7sPYE+Dhu41X4ay6UM4Y1x1C7Mvf9Fr
         CGfpiMsf8y1H5FVDRHcLVwC8Qv244ExrWuglmULd9+13svISixRi5V2ETm9KvJ3tV+w0
         EZJ37trMe8STzIGUxNQpqJbjh480MrEzPeL+ttAlMYIzZmi4DnioF/s5ZAb7FxNeFd6O
         j6nlQs4/c9glV7hS9pUwvVSOSFQLpHeuzTfKJhsM9d4X7vWFIs4aWXrwHX1TFXWMF0Zl
         PSYw==
X-Forwarded-Encrypted: i=1; AJvYcCUsFizCKJiV6g0QS+9hNq8U19z5VXjoGeZhu2Skxkf+IQd7V482rdb9FlUUU4XWH1B+3GMPRWpV+g16CPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOfBYZ3LTEKmsfbnW0Qwiy2b7bJAL0WQGtC9uw2ZlV4TJcOBQ
	8vkYc5GppLG63KxMIxYiwhkM6sUr8Pipuw9gwxN3bQnOBDNegp3tj6LYv5tyhsQ=
X-Gm-Gg: ASbGncvNy2xiOk5yyDlfp2ymdWeq2/Fd8zdy9ktT4mQWaO0fhukWM9mJd/jEeFpkkis
	ufQE8MhughaPW7PFg6930jZv9K3wjASQq7NY0h9+JEMYQNJlZ19XdwgutDq8IsdKmai4btLWkb6
	BopGKGsEuLmZVZUGqm7Rg8DXNUBWGSRF2lapex/kLkvlKRgc2o2lf+c1Jgl5N/c0+F7iEHemLNT
	F08qLEc6KbGt00zoxPd5Ame+WyYG/IZTlFf3TE3OpunMNQ8fWZiZTXDW9X4gA==
X-Google-Smtp-Source: AGHT+IEUBdFsdH3/zl9+1ecjQiu8FDvSqp8rn5L2vqkxpaQDJnW7Z4na4oHc4eFvwzw41wm+iZtfZg==
X-Received: by 2002:a05:6000:156e:b0:385:f7d9:99f5 with SMTP id ffacd0b85a97d-387876c4827mr1605674f8f.51.1733989292439;
        Wed, 11 Dec 2024 23:41:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251df6bsm3167261f8f.105.2024.12.11.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:41:31 -0800 (PST)
Date: Thu, 12 Dec 2024 10:41:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <816f862e-762d-4880-9285-5a803e657e66@stanley.mountain>
References: <20241204160014.1171469-1-jfalempe@redhat.com>
 <20241204160014.1171469-3-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204160014.1171469-3-jfalempe@redhat.com>

This patch breaks "make oldconfig" for me.  It just gets into an endless
loop of:

  Default DRM Client
  choice[1-0?]: 0
  Default DRM Client
  choice[1-0?]: 0
  Default DRM Client
  choice[1-0?]: 0
  Default DRM Client
  choice[1-0?]: 0
  ...

I don't have to type anything, it just spams that forever.  It's weird
that it's 1-0 instead of 0-1.  Does that means something?  I don't know
much about Kconfig.

I'm using this arm64 randconfig as a base.  I type "make oldconfig" and
press enter until it gets to "Default DRM Client" and then it starts
scrolling endlessly.
https://download.01.org/0day-ci/archive/20241212/202412121555.Fp663tyH-lkp@intel.com/config

regards,
dan carpenter

