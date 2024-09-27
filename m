Return-Path: <linux-kernel+bounces-341641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6B9882E6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0160A1C21417
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6345189B9C;
	Fri, 27 Sep 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJtlKNma"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB72188900
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434670; cv=none; b=Ue50YF1y3T6kTjLkqtiuoDDvqfiUyH4VFx2nAqcEB8nk7Ej96Ktfvl6gBxblU2/AWrrOzNxNBpJo4Bz8TzBE7ouY27AtwgOX5Do446fyMxNaGqSfshZWBTb3I8XBEYEFwKNHsPOr+r7XcJlT8W7diuz0vn3NdYMCIvOgzWzX7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434670; c=relaxed/simple;
	bh=YZgFpq1hQ/M4LJjPWGkx0QMYy3YqeF3F35HN/4OvKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trCrtkh9MwutzwPqbohdB2lAGg4gh09nt4QLcxQtzstC6muIGetgm8JRlgiRgTrjnHMmSxZrIYmA/aRxFVpnNaKBiUzzDBtp+iXrzwX25LNWy3BWJBkf2iAl+nexB5pLqS43y8Tk7eWZbn8EByXZnMshZ4F/scpKaJXahW9Boqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JJtlKNma; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccd50faafso1339554f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727434666; x=1728039466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/gJ4n0/JEYirGmCXA4CFRFlIdN6B2ALRebGpyiobAM=;
        b=JJtlKNmawHljZstS0Z3osOAC+gN6Mrc9auqZkw36ZLb0NMVwuwcyB0eKA6aeVKSyyu
         Ew4o35UjCVHP+8R+cOqMJ4jfh9KbfCnJtxODZeys/VEUYEVw9NrIne5TflLiH1ikNVJ0
         zd0Knuh8iR5Ew4MfRwwjv+2hJrwdZ8ovmVFkldesGOxkbPKbh2JOeDGCuXDL0p7/I+IQ
         Wn/UAbT7E580pN9BGvJLXht7upnPZSpPuXY7cgHy5JYjyYdrzPt4RligdAla2yNziXEK
         OfMHgZGexUIlWcf8h0TK4hyeyM5zDRxNRkvD4cLjF/v1sLOCaZcnXzcoS3UvrMvkAozk
         T9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727434666; x=1728039466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/gJ4n0/JEYirGmCXA4CFRFlIdN6B2ALRebGpyiobAM=;
        b=BfxYblP41yfkaT6c0KUrMg310T92tZAfEe4LC+iZU/Nzo6F8gnMX01Bq3hTqzh7V6d
         DtJHerWhUK7vbRSX8zytDr/61seq2jeLK3bXiUgkcQQRwezDhip1E2PmX01k3gzUyouh
         Hl6TzMeHQ1jPceJjB62a+yIiwgBuEcvN5HGstB7RDszCTkgezeZMAFYI2x+TFZOx4hsF
         ndqBZLeKZRpDh0KhK/BOKDj09ZRhAQzOKvZ+H2txYPHS8/wnxsUn+ZmQEUSMFaAwJEi2
         lMOxGsWh++KoLa3yjTI8TY9r0r0iw8jhgPrZXlkt1siAAWZJfHSiyIjYe1m9U03e6SCf
         f01g==
X-Forwarded-Encrypted: i=1; AJvYcCXm0LGVPSoH6Y8u5iQ6pxRLj3nHTweKuh65YbusYBQ+8K0pFJixeOJzD55fC67GTxjkPTaDQjDcMLp8DXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qjQPPueFsVPHJdzEGlyIYQYbX2GqghxaCnlXm4xjBD6kV6sW
	B1Ugvw9l1L5080rMPXoxMsX+6CYTKvUOn/ZFT9wJOIzCxykvuTV3MEoHZ3mI1FY=
X-Google-Smtp-Source: AGHT+IHsZ8uZoC2TgFmkkqu47kPVnjvWS2f0IprjIc68V9e4dQg9h3d3zvuwcxMOX7+Ce+bYc8+VpA==
X-Received: by 2002:adf:e6c7:0:b0:371:8ea0:e63b with SMTP id ffacd0b85a97d-37cd5b2cdefmr1948803f8f.52.1727434665802;
        Fri, 27 Sep 2024 03:57:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de10e8sm22572925e9.13.2024.09.27.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:57:45 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:57:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: i2c: max96717: clean up on error in
 max96717_subdev_init()
Message-ID: <4b187b7e-7223-48f2-add4-bbc167ab7c4e@stanley.mountain>
References: <23251b8e-c148-44ef-bc9b-f39cecc4fb12@stanley.mountain>
 <8d281bcbc504abaa9838ff666a36515cf7e57239.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d281bcbc504abaa9838ff666a36515cf7e57239.camel@collabora.com>

On Fri, Sep 27, 2024 at 12:47:03PM +0200, Julien Massot wrote:
> Hi,
> On Thu, 2024-09-12 at 11:51 +0300, Dan Carpenter wrote:
> > Call v4l2_ctrl_handler_free() to clean up from
> > v4l2_ctrl_handler_init().
> > 
> > Fixes: 50f222455793 ("media: i2c: add MAX96717 driver")
> 
> The right commit to fix is:
> Fixes: 19b5e5511ca4f ("media: i2c: max96717: add test pattern ctrl")
> 
> Since there was no control to free in the initial driver.
> 
> Reviewed-by: Julien Massot <julien.massot@collabora.com>
> 

Yep.  You're right.  That makes more sense.  I'll resend.

regards,
dan carpenter


