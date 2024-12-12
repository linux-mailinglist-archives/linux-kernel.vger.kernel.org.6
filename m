Return-Path: <linux-kernel+bounces-443091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7889EE6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B431886D30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59872135D5;
	Thu, 12 Dec 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaVziD81"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915B211271
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007521; cv=none; b=UbKLQVZjwftw/wCz0qJVZPKdgSuhZdDrtiSVGG6pZC83xRSdG606ybbudySoKRhjLO5/FbikwyvSl0aUuM+H03MYMvUgeBqFEsbidEoDfAGUdiaSbHlYHvLoD9taBLw6YEAMVTibLeYRh6o4uzNPUg1eTzF4q926EJRHuby9/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007521; c=relaxed/simple;
	bh=a1c+csz78lwGyO+6sWEuvcLVxfOtf9ra7N4OQm7xEfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eskKroeod8iKiYf9P135ugQCUNZ5g54z+pV5h6f/Xfaff9xaq3SkYMuwufn7mNgklMchz6HChcd1uvTi9m+U3fE/7ExJpPbUmxm/p1a8Xzpr2KzWdr7IZF0iGinUunMO6q+ezVsby1v3wW66qhoeoqX1HpDu9z/zjBK3SeLAOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaVziD81; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434e69857d9so3617875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734007518; x=1734612318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0MIlrd8hgKTeaMZkhqf3o5F9gaR/A/34B2prwrX9Lc=;
        b=CaVziD815998e6WExfp1njY4vMIzDEljtLeVj7vNyv939K77cnXT0tophhnVUMHZJW
         xY53SholZrTDWgeliaSI7OGBf+PRx4gV3yy8oDX5SfALR7HmtFD4dPKjNylrtRidFd15
         aEijEwwa1LH/q9uP7pD37azOn9/nRNRk9ps5Q7qSA6UM396z/Li7Aq9eItpbC2Cfo0v0
         YFuU2F4Lb/l1MSwVym/h/hJdHhmxhA9FNQXe0luRy2IVcfov8IDf1WrWqG1olAzlyeKH
         nUzqKGpOPTedbpYtVzDHCCH43wRLN6v+hq33vIS6mdSOkJQFpi5DONNwmbmDPsxvdf/z
         9/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007518; x=1734612318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0MIlrd8hgKTeaMZkhqf3o5F9gaR/A/34B2prwrX9Lc=;
        b=dPUW8cmOxI070XhCphrEiqHSvbMoSSD19cveVnR4CbHKiDfdhA9/iHPhvGBu1nlJRG
         hJgtnQCJZNyKCuF3UI7maRBac9HtVm27fQXBwvnDy4ufirKp4rUrXF9vqSG2NQPA2AWO
         r9bMDDyR4tqYpBKvm/c1CaUmC0UGVJTN0/Vc19BpL2q5hsLD/QaSCT1qwMWpsbD1ikgv
         cdjNNYLBWk388WQlzhn6XzTJczARoiwJMrnGZGrMi2xrPPgIzj1CFPcp+ypn21YQ/mLq
         ijLT40LrRNJ1Qikla0rLrFzCz5Snzt6bAbwajB5E0y54yahg+s6ChCX127PWVVpwaXLJ
         iwng==
X-Forwarded-Encrypted: i=1; AJvYcCX2qC7mmQxYbQ++kBcf3PnzK3Fo1DUAwQT3SOPi2MtnvFdC5dtytdQ7JUZPHuw5oum0ZsL1EebNNPn+4tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxorDaGQ8wBHe1hIvE/UA2kR+CEdIg+Fth7qgVhJSAbFFUz/PSy
	i92we2H93jQppYErHT3lB7Ng87dfH899xrscjLjLvRzt+g3IG3Yc11SjnNV7oME=
X-Gm-Gg: ASbGncufL/Imt6607E0p9HUl9O+PoKtQfh03HCcQo0c4NWPqsaHfus19Sns3aN8DO2z
	fMeqGwX4CoieNSDRet1aK4BmEQgrJtc4XzKKyyK4iGHoKd9vHFYUhw5d/smYLVpt5sLTSainZTt
	q1mAed6LV1vy4GasiIlmGH4+lDlI4Kn3fIZBqYtgv728Y0UH88voGn1uBZOJ9Xr/4ph+Iq8vE4F
	G58wnN0CnTDRjI0xThlA4Boxy3nJGim4+UAmwwZmQBgnX3bV3q9Lh3lvu6F7g==
X-Google-Smtp-Source: AGHT+IEyNpazD7YeXxHYvPwjQS+Xs0/1F2YZVhWJvmtRAVKWT7Dsk7UichfBnzoTMoxDG9nSIZeQ6Q==
X-Received: by 2002:a05:600c:34c6:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-4362310c025mr22321795e9.12.1734007516330;
        Thu, 12 Dec 2024 04:45:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625716e5csm15409365e9.36.2024.12.12.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:45:15 -0800 (PST)
Date: Thu, 12 Dec 2024 15:45:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/vc4: unlock on error in
 vc4_hvs_get_fifo_frame_count()
Message-ID: <92dfd6cd-2e10-4606-9502-3619c4b265a0@stanley.mountain>
References: <02c87d9c-76b8-4d93-b0da-0e4f7d4952ae@stanley.mountain>
 <CAPY8ntD9XzrzrhX=1XojjcZmRm60KLc39HZq0bJ9cEq0J7nQ9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntD9XzrzrhX=1XojjcZmRm60KLc39HZq0bJ9cEq0J7nQ9g@mail.gmail.com>

On Thu, Dec 12, 2024 at 11:54:28AM +0000, Dave Stevenson wrote:
> I don't know how others feel.

These days we have "warning: this statement may fall through
[-Wimplicit-fallthrough=]" which triggers a build failure so fallthrough
bugs are pretty rare.

But I only care about *your* opinion, Dave.  Everyone else can bounce.

I'll send a v2 which adds the break.

regards,
dan carpenter

