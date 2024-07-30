Return-Path: <linux-kernel+bounces-266727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D99405F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D00E1C2262E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87CC1494A9;
	Tue, 30 Jul 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAQkNdMA"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F415FA88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310370; cv=none; b=s3CPkSzfZazrQ6ilnb2QzWAElxglqyytfNYn9MiSqJ0xZmCSb+TIHB/EMm9q/T6ElzHRxjhX7sW2VJVqr07WnQI2eQDIfyXxFINQyJ+HTUtWx8C59AmzjUhW/jbD7dqyur0odMUWBFrjY0SVP5Cp2FBl/spe8gn5dwCt7eFJbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310370; c=relaxed/simple;
	bh=1XeAmzR2V7+9aHSE37LPW+quEIbVxSrVQ9+bwtQsikc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is/loiJbUYHgf6yGTffugwrW0vehfx0IHprH9u6poVDCJL1XkvtgkwIKPxmvfZ6eTbarPvN80/MXKo5OeTdcz5WQWVqCmGtz863325qazCmtEAjojl9DH+GqhFVsoMMDAQ2lvG3oXVZm0jagm01Ocl3F+bzYS4NAeLYjrIewo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAQkNdMA; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39aeccc6377so11639295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722310368; x=1722915168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZxYjy+8c1DX8w4TRv5DjsopaICxGAlzENWzIqd4frY=;
        b=yAQkNdMAPcJw4mrjTGnpHaXq58P4jLFAjud7BUtnkpCbZerx4d+7qCHtO8h6TBhFge
         L9brB5ltQxfmQ96THHBd3AuAwYDK5SRCPfDC6+X8Fz32/3fTKQGw9xWcv2PwTAK5EoxO
         PIS8JEf6jSrTlMndVkJSyxZ3B1Q57W78inJGyXM242/y4VJYXXR3Dmjx16TXhH3lPcX5
         pfoc6hGlyPJ9xTjRBkjP5I5gMpP4OIgBNaNXz3AYxMMHWWG5kdbXCdCmQVGW4yCbDxqN
         UN+K0bp5rr2mIGnZXyEvfM+vvHbnbyvB0j4hKbYZOT7pzYuLrlNxwcxlVKqXH+bTBY9d
         VsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722310368; x=1722915168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZxYjy+8c1DX8w4TRv5DjsopaICxGAlzENWzIqd4frY=;
        b=jYaTsUaV4mHICITWUg2Jtkn9zOz+xbvII5N7A8ey/5+WHMl5OiO0OvauVxJmGObM4i
         bQ65mVqUtPL3tocw3q+MLaNo+vdgO4Uzg71/V0fo6RcT84pFIyixhVrePUXerp8Enrou
         hGjZDq3r8RZXP2a6IfSIS5jQA1/Uu9vvfKBDDAJfV37vEM+DKkwSZGYjCywaDH+uNVcW
         y7AoGHvHcshS0tOq8XGrQbMIrPl7YQhWtlCnGp1ZxD2bDw+SiK2y/UAnFiZvcdwsnpqo
         lCY/qow7nQd79rED6QWB87NHg5DwdcGb0JH/07DU1X3ejm3Bb10Rv0a2XnDbLRQKmgd3
         r8ow==
X-Forwarded-Encrypted: i=1; AJvYcCUb7ClYYYK5KjViylhfzK6ftDe69Ih0WdxmjCqfsd/F21HwtOETh6pvKoUZzGYlUxcvq7SC82gWrvfry4Y67wnO5jSD+IQc3OFHc1ms
X-Gm-Message-State: AOJu0YyFM8lyYPKGJ0PLF/K8lmOrnFUpy1/Y5W7j5U+5S3C+l+K8JKBd
	/6k0fbDnvCszVpuIjvlWtgwFxpA4t1aa6wnXrwMWWf+p1vZJbMSaILJF8IXhholsV855Y66t0B+
	a
X-Google-Smtp-Source: AGHT+IHY1oLjH13UjFco6GEaqPBNW80+DzO4U71s2pzOLDm6DDp6LzyR1CoAl6dkFRbHg8xDKgcRwA==
X-Received: by 2002:a05:6e02:20e9:b0:396:e92:851f with SMTP id e9e14a558f8ab-39aec2d1682mr123103735ab.4.1722310367630;
        Mon, 29 Jul 2024 20:32:47 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817da8bsm7929408a12.27.2024.07.29.20.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:32:46 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:02:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM
 domains
Message-ID: <20240730033242.4ajotym33bheativ@vireshk-i7>
References: <20240711131637.opzrayksfadimgq4@vireshk-i7>
 <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7>
 <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7>
 <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
 <20240725112519.d6ec7obtclsf3ace@vireshk-i7>
 <CAPDyKFqTtqYEFfaHq-jbxnp5gD7qm9TbLrah=k=VD2TRArvU8A@mail.gmail.com>
 <20240729060550.crgrmbnlv66645w2@vireshk-i7>
 <CAPDyKFosi4dhf36iNaNgGN6RHLDunL1nEwD+A_aW2khxER59nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFosi4dhf36iNaNgGN6RHLDunL1nEwD+A_aW2khxER59nQ@mail.gmail.com>

On 29-07-24, 22:30, Ulf Hansson wrote:
> In regards to the clocks, I assume this is handled correctly too, as
> the clocks are per device clocks that don't belong to the genpd.

It would be if the clk node is present in the device's node. I was talking about
a clock node in the genpd's table earlier. If that is ever the case, we will end
up programming the wrong clk here.

> That's right, but why do we want to call dev_pm_opp_set_opp() for the
> multiple PM domain case then? It makes the behaviour inconsistent.

To have a common path for all required OPP device types, irrespective of the
fact that the required OPP device is a genpd or not. And we are talking about a
required OPP of a separate device here, it must be set via this call only,
technically speaking.

Genpd makes it a little complex, and I agree to that. But I strongly feel this
code needs to be generic and not genpd specific. The OPP core should have as
less genpd specific code as possible. It must handle all device types with a
single code path.

-- 
viresh

