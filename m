Return-Path: <linux-kernel+bounces-372014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4129A4349
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF70B20AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436D202F99;
	Fri, 18 Oct 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHkS5JbN"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32793202656
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267701; cv=none; b=diproOwpYf90+Liql7q7OscwmCNImJGLtHbWmUcQA2qEyd5a+MZx0HjAYHorCmVlZTauY4/ZqkAMe4OBbUJUyYnS757ooJ6mkyFeUpP1uHJSVZAySL54kYH5tzS0YV6lRCwMnvVfcoEkCUWlsBOr6PqpBBFC76DzWs5Bm22ZA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267701; c=relaxed/simple;
	bh=ZDSCREZ4GeJfN24LLyvFpOCH2GTNNhH1Bc4SQJJVgY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAc06zMKh3KBBWBPuZLSsG/RIQ+wzRq3uFTnV4o+0JM0DKWJtkadubPDubKApkG1r5nE0VoeI/YUikHGrceI/+h6+VfT+tGw3wX4HOZsKwIzAyhhubTRVTHOR6y+bhRZjTMr16d6Ij0k4VRpFZn6oJXmIVlSW8n6cixzklP0gpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHkS5JbN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so1745323a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729267699; x=1729872499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNR0bPGSjLyuFmU7GhxyaSTvabJeE4hQt9n77qexHMY=;
        b=KHkS5JbNjBE/Kq3qpDqAGZJnDtZ32021whGRGi+NouzVX2YQBeFJRaewBbewLm+ItH
         f++iC8HUwCnVpsuNWpECJimOYy48NuOZ0BXUvCJKx7mebFG6wwtejqR4AaWvkdWquWuw
         W714lUlcD5ZDkCZEgqgKMsjsSFfYq0MhdKnBKB+fyqHNn6NAYovN0tZ1tulrSXDGcUlv
         lMTMjZyTgLgSUZ9wE6nlKpWjhnNDKzAP19npkU1sHly9d5vNEE0yEmCkbskinR6/aZft
         AQ79rGTwQvfQ6e8yWIn5kYWxMJM4n3dpMYlA0PmPSn+e1lQ1eHW0KIsPNVJbok6xLxxv
         Malw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267699; x=1729872499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNR0bPGSjLyuFmU7GhxyaSTvabJeE4hQt9n77qexHMY=;
        b=N4zU2pJR66t1Ybi948QMS+GaFeDwUWsnZmtA2qBoPNvTLwlR6qfHk9L40J97ppdTWS
         GjcsZnmge3dc+3cfxrtrEqO02r4wrTPVPZ5LDVrgmKCcs1OhOVCoFSSjpGgcPerAwL4q
         /bjy8bLPf+Wye+O5GYzBl5u0SkQmmD6U5U9O83fwJf16Ajw7uZt4n+rBLOzzvTSRUInc
         u4IJsl5R6yzU8UqVOwc2DOPnU71VhXbMAw33GmJbH3E5HGFAAbkPsNHq0E/FmB+htAc5
         r1Pra7HoFbnN4aK4z51s7pVemk1clHt5SCUvCvWvwXL5odaB73RS5TWHWvfzlFW5tiJt
         N2/w==
X-Forwarded-Encrypted: i=1; AJvYcCVcQZf3segoBK5K3cr35Z51X26eIOilnsLywPQGVDEbD/lenhnylBxYV3mG1fyQfWLlsFm9AqGaU3T8p7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhv3pc3+Xrew6dayUi5bcqnywDhEPfy6Aak3JmxVqdcfFTs09Q
	PknTG0OPHnWEqHela7Rx0Kbb62RPdXV3dMqRIYh3Ex9ogUGU9OfczZopC/keip2X+1DDW5V0Bmb
	R
X-Google-Smtp-Source: AGHT+IF9TqiR2RO3BGwLsSjTV73hbKFyYwD80eadD15JYSLkGQjGHwgW5vg1eOfKD6I7rrg8rjsHOQ==
X-Received: by 2002:a05:6a21:1698:b0:1d8:a29b:8f6f with SMTP id adf61e73a8af0-1d92c4dfbabmr3916839637.16.1729267699273;
        Fri, 18 Oct 2024 09:08:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6af4:1971:ad72:1f9f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc2081f4sm1538199a12.2.2024.10.18.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:08:18 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:08:15 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable compile testing for K3 RemoteProc drivers
Message-ID: <ZxKH773hQ+JZ2km3@p14s>
References: <20241016164141.93401-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016164141.93401-1-afd@ti.com>

On Wed, Oct 16, 2024 at 11:41:39AM -0500, Andrew Davis wrote:
> Hello all,
> 
> This is a follow up to [0] that adds the same for the other two K3
> RemoteProc drivers. Series is based on rproc-next branch.
> 
> Thanks,
> Andrew
> 
> [0] https://lore.kernel.org/lkml/20241007132441.2732215-1-arnd@kernel.org/
> 
> Andrew Davis (2):
>   remoteproc: k3-dsp: Add compile testing support
>   remoteproc: k3-r5: Add compile testing support
>

I have applied this set.

Thanks,
Mathieu

>  drivers/remoteproc/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.2
> 

