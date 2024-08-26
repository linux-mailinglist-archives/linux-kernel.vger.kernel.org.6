Return-Path: <linux-kernel+bounces-301467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CC495F155
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15231F228E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A21170A0E;
	Mon, 26 Aug 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAY4CosI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227655898
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675485; cv=none; b=Rb1OXQcvCdlrn2ko0fwa2adYmzQe6mwvwnn9K5ytkdnJwraGWlVTcKazcqmt789bqWg5Wfg5Ujh+KgdENWB2qRwKFz7dOlWuZmx1o/bq2Pk7KZlSsapZP5Ot/3UPoGDFyEAuJZ/gO1a72RHfvEYxMkcaXTD5j5VWsJI5tL1k3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675485; c=relaxed/simple;
	bh=7VmbSA9BQ5Cg3vBjj2lP8CLaKDj5AmDkYaDy2sgx/+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWfnbl3sDpxr63tosac4qlRby1rW8ncY54zWus/T+9Lxh9YX38FkKUVW+Vw6B6+PRddgKG3tXpVWjcsF6sJahBvNfXGfhNi0nflpBWxAnOcaSYuNcBsV3qxpXQHR3BoWezGaHBcPpxlSGqtj4Kg99HJiYcPxmBKbB2Ox4FIhtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xAY4CosI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86933829dcso464969466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724675482; x=1725280282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wejgIUhOad6H+tsVw/4i6tuHGA9fJib/IK/aR/qRKMg=;
        b=xAY4CosIhBFzg37JhA0gEC7p7n1N0A6wvKO6moNoE7Z3Aj3+XCDcFfRp1bS7n+gQBI
         1xFmrP5AQWfRb3XRH5v7k37xOEsuOTI+dYPQosD4wJOnLAAxjWe53nus1AtAPuivK/av
         I8vO3FLoxAQAj+69UYPswlA5Q5YL2ZL9XlHHcRNSvmAbKR821YJ0A0Ab+Li91Sv/ZkcF
         hSMoNvPJ9wdxvgsO1h2cHld0TgO54oB+QfrKE2rJ2zKtqQmgIImxT71oQ9OuZ72dJL1C
         OvmqtiZqSFyq7ohgRP1/cLtDPBbL4T6mZ1pw3pMarMOu/rrlEai1KPxynsLmO59tDjss
         MRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675482; x=1725280282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wejgIUhOad6H+tsVw/4i6tuHGA9fJib/IK/aR/qRKMg=;
        b=nzv60qf70fZeK10rbUjJSLVqnyQt8tKHMQC6FK4SZBr24YbRNKYkeEb34nGEynvU/u
         SOMivIFbv/zVlj6jFSn8wFf5kpTxNRV06KDKonkBEcoW6f4BCKUU7CSK/8fnq4epNivp
         eK/TTUIszlL/nSg+tXqRaHYX9k23nHpNbz7oY02s+RbQTxNaSZaFZjMSpIUBgQwdBMmP
         U4Myiml1izuZ8PzOS4WWzzBfpe3vT4gVKGc8a4YkeI3bjJaA8fEczaj+187D2DLK1B74
         9fmIgf3ydJF5YydyzXysFMCY843FHe9nvrLyz8xNdWBfKTyJDH+p1kZ6AIF7BstWzNvq
         Bmxg==
X-Forwarded-Encrypted: i=1; AJvYcCWjLNLI9WyKBu8tN0n4w1BMHx0/OvjQLkO/My3JZQUSeX6hrNiVmxpGdUGw8sAQC8kmMEZoLNMIg22Ay/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvd080EubiWFXjZdpBnPvieDa3T+HxicDX3h6qY1yVmFKF2xXH
	COgCm0Spjs7knZsTSazKJwA/7Bowd1d8W8LHmk9QARran6Ne3jceJCVcTI/W/90=
X-Google-Smtp-Source: AGHT+IGY2X52ALROQjsflCObpv/1qCEB42cXIalRxExLB16O8GieTsfHBeN+ow88Yl9xS3ISqQHk5Q==
X-Received: by 2002:a17:907:e646:b0:a86:89ea:ee6c with SMTP id a640c23a62f3a-a86a52de5d5mr747313066b.30.1724675481798;
        Mon, 26 Aug 2024 05:31:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f5d5asm655984766b.217.2024.08.26.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:31:21 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:31:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Change slot number type from int to
 u32
Message-ID: <6ba02745-0a55-4f5e-a75a-a7dfbd7070a8@stanley.mountain>
References: <20240825072955.120884-1-riyandhiman14@gmail.com>
 <0289149f-3880-4e20-a22b-8540f212f1b0@stanley.mountain>
 <CAAjz0QaWLcP=VGDd_1DzJiTZe3aX12spr_a4jWfo1pUTeZUtWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0QaWLcP=VGDd_1DzJiTZe3aX12spr_a4jWfo1pUTeZUtWQ@mail.gmail.com>

On Mon, Aug 26, 2024 at 05:13:25PM +0530, Riyan Dhiman wrote:
> >
> >
> > Of course, there is a place for unsigned types in C but it's so subtle and
> > complicated to explain.  I think people wish that there was a way to make C
> > safer when there really isn't.  There is no easy answer like just declare
> > everything as u32.  It's a false hope.
> >
> 
> The reason I changed int to u32 is that the slot function was declared this
> way.
> 
> static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
> {
> u32 slot = 0;
> struct tsi148_driver *bridge;
> 
> bridge = tsi148_bridge->driver_priv;
> 
> if (!geoid) {
> slot = ioread32be(bridge->base + TSI148_LCSR_VSTAT);
> slot = slot & TSI148_LCSR_VSTAT_GA_M;
> } else {
> slot = geoid;
> }
> 
> return (int)slot;
> }
> 
> The slot is taken from the ioread32be function, which returns a u32.
> However, it gets cast to an int on return.
> If the value exceeds the int range, it could result in a strange large
> value. I didn't realize the potential bugs
> this could cause. How should cases like this be handled? Should we include
> an if condition to check if the
> slot is within the int range, something like this?
> 
> if (slot > INT_MAX) {
>     return -ERANGE;
> }
> return (int)slot;
> 
> Also, since slot will always return u32 isn't it better to declare it as
> u32 rather than int?
> 

slot is "slot = slot & TSI148_LCSR_VSTAT_GA_M;" which means it is in the 0-31
range.  The "geoid" variable is a module parameter.  These days we frown on
module parameters, and say it should be configured via sysfs instead.
It doesn't make sense for geiod to be negative or >= VME_MAX_SLOTS.  We should
check that in the probe() function.

I would declare geoid as u32, to communicate that negatives are not allowed.

Remove the cast from tsi148_slot_get() but leave the function as returning int.
No need to over engineer it.  Plus that way it matches the type of
vme_slot_num() which returns negative error codes so int is the correct type.

regards,
dan carpenter



