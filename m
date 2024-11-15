Return-Path: <linux-kernel+bounces-411005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E180F9CF18E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608842876D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADA1D514F;
	Fri, 15 Nov 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mso5/i+8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429318E047;
	Fri, 15 Nov 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688489; cv=none; b=FXV5AzQk+m4JaFjQaOEjjM6qCMgqUIpsj0AAIkgtqmViMaQhAwKuEmXzf+stoX8AcBjkW0hicOpspuNiuEWWV3BsHr3w+m4jI3TwqEPhDvevZMrDMB51nwTOYdwG6RsKAOK2it2kDpayfWIuMm2ZA5IGzNWtKbArwARd1HDZ+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688489; c=relaxed/simple;
	bh=pN91USB9btT41evusg/u00Dn9pS1764v9qVUwtiiL28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZn2lOtmhUL7zTvc6VTwnyqNBheZN2cVvuWwMZ5cl0dxnF7SViCJhI2+6zQHuID1vGMwFcUHlKLeyCKC28EgSwVVIxd/Q3ZVtuDmoEiTv4+X4Ctkz/yqCnYenC/E2JErd8ix+rHeylbqfZ9H/6OIv2OAOtkLPS5b10EMKZ52Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mso5/i+8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso1649831b3a.3;
        Fri, 15 Nov 2024 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688487; x=1732293287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePO192v5MeBsB8Bg2X5bkrbCRKqSXwPHUZ2FLXYY/3A=;
        b=Mso5/i+8DV9SO1r9835zRCEfALK/pNKiwqHPUm4W8YRPJlTQ1HRmFORPetnAuunFdX
         ZpmydZ6MYKFkkacMXx89Ir6kCxNQjkXR2y9aSQI2nGzsvEvOc2t1a+qKojEwCi78JEvz
         DEgRk/HCaxbukd2AlQz91chNGEKteQdlbPqrUJysLFmenB8uxw5eOq12Rdmac6cT/+do
         TOdNR6vBNoc2PRt80kR96PAT/jkBuNtJurqSJB27/1HAW4L6ChxOQRjEMbGrOEOuuS2+
         OWZOHnhKVeoUkbMCCoePAaFPV0GDYggF90ACK/nEEM0kv2fwkPZrtSRn9ZMmwFgMXsYu
         M8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688487; x=1732293287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePO192v5MeBsB8Bg2X5bkrbCRKqSXwPHUZ2FLXYY/3A=;
        b=fLneS4nyvR5LqSlwdeAQCpzAqGkX4QJAz+2HBf6S8hdV2SMn4yqorWIGXC0XwWvl/D
         zEDcYxLOKnp4jBCCeSFw2D5+fsUNSFuI1Xsu6s9UchhXk6x6afEta5PEjwpLBgDharYc
         MJDEYGAXuTsVjIOEb7YKSZ56ucOg9dF2MKHRDjI8FytpDhLpF/KR+KrodbX4yqBdCDEc
         5gEC69NT5oSSE0nN/CV+bOjELl4n6YmWbokKlPbO5HNAeeVsAvEK5KyLBHNK4xYh1YdV
         Oy+SmV667Z4K7/4Er5H6tM9R9ljTmGTPyZ9v6Xo7JgINOKHeuXd3ZFhT4Se3DQpqTvk/
         HvIw==
X-Forwarded-Encrypted: i=1; AJvYcCU3hOM0/tGCr8e9cfsu/DaGNB99AFmAfxaf5anQq25wHrp/swhr2GQ0xyQDa3LP/MacQSR5hGUwhtFgaA==@vger.kernel.org, AJvYcCV/qk3XMQLmnibtAopHEqQbS6RQfXe1RzE0p1mMNsiX1BrIZ47Upe6JbRDBFoAMK7pIPbLRe8TNFFVWcOxp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2/vxkerGMtbcDO84XwZBHNo5ST/bEYYGWYDrWPLXV+Y4V/O+
	Uhbg7OlMrsQLxdpvnp3shWYHBgQJFYuyQm7MQDVyFpzmyzSHOsZ0/glKhA==
X-Google-Smtp-Source: AGHT+IHYh9nt2qQ464A+2Jrwzxye3Q+x0YOEjXkqTUoyDq3s4DTPfb7TRiESIxa0NPPT0H73bTMDJQ==
X-Received: by 2002:a05:6a00:1791:b0:720:9a03:b6dc with SMTP id d2e1a72fcca58-72476cad305mr4249564b3a.18.1731688487367;
        Fri, 15 Nov 2024 08:34:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477203a4bsm1528130b3a.192.2024.11.15.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:34:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 15 Nov 2024 08:34:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <3dfa3859-cef0-4311-b0c5-ff1c04284e88@roeck-us.net>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <20fde375-a88a-4279-a849-520063217de9@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20fde375-a88a-4279-a849-520063217de9@roeck-us.net>

On Fri, Nov 15, 2024 at 08:31:29AM -0800, Guenter Roeck wrote:
> Hi Thomas,
> 
> On Wed, Nov 13, 2024 at 05:39:16AM +0100, Thomas Weiﬂschuh wrote:
> > Using an #ifdef in a C source files to have different definitions
> > of the same symbol makes the code harder to read and understand.
> > Furthermore it makes it harder to test compilation of the different
> > branches.
> > 
> > Replace the ifdeffery with IS_ENABLED() which is just a normal
> > conditional.
> > The resulting binary is still the same as before as the compiler
> > optimizes away all the unused code and definitions.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> 
> I decided to apply the patch despite my concerns about the lack
> of dummy functions. Let's see if it blows up in our face; if so,
> I'll revert it.

Ah, no, that didn't work, because if CONFIG_THERMAL=n there isn't
even an external declaration for thermal_zone_device_update().

Guenter

