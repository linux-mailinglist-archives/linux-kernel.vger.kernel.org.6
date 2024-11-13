Return-Path: <linux-kernel+bounces-408250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1419C7C93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701AA1F26AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A959205E22;
	Wed, 13 Nov 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN53rCqL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491D20125C;
	Wed, 13 Nov 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528271; cv=none; b=kbjtu3NSantw3DZe8THYeNAwtHIhzqM/M5e1Rh28zJdtHqKhT5qaDidMHgEccdq77AgzbvX7UtoBqO9mvrjZedvbQZIPMSg9oNIZlT9zHAFmdPkqFS2U0N/swk3IM75TfqERUNpFx64Tu/FZSXDJUWrCj35OxrzTus474p1XNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528271; c=relaxed/simple;
	bh=OO/csDBZnt3H01sR9vNwf0Ps8MUJZWjIvkSAdcClfug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdWtNcBlydY+Ev/iZdUZM6sx1AeE9c/iaLnBSRfaq9WuqNuU5inIGSuhJfSctPckSEmM+pHn7xoMx+eoOzFv35uuyRHJwhbue4IE/w+U177cfbZ0oQG1rLJIVZJ7jK5Fdz9lGOcbAPFhvZtExbV2GLvoK6v+e+STrSytVqPzb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN53rCqL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c70abba48so72523615ad.0;
        Wed, 13 Nov 2024 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528269; x=1732133069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VmfrEBEOwrXT4ejKwABTTLL9J9eLHOG9o0zbLKMsD8=;
        b=WN53rCqLbYMVehw8SLo3GIkidc6rwL+1WsrPcFZgARk7o2OnmHhKImEjlTRLNj0IVH
         NewgLmCmPcZfYjRxHdHQg2rH9azselJDLqu87boJ1u2larG/otceohF/juYt2YUBOm3j
         7++FSXlJsPOzPYZF6R8yod14NYlL6h6y9mMn3voKUY0L/UI7OFPzUJ2JxzRjOkYDY7ve
         qXP2J4Nb31C81oyHQDIpC+R3NzFVfZqedTVvhwrLwsfj1xuWxLAubheAZniRJJODTgbr
         ROEP4VijZTHxtXVs/52SkG4R5M7ck69w43llrYVk5S0iPHUqQV3bcKUZjTFBMlzI4DHb
         b8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528269; x=1732133069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VmfrEBEOwrXT4ejKwABTTLL9J9eLHOG9o0zbLKMsD8=;
        b=H7mbuEYIXMujcE1Eycfa26g44i2aDzppunZXB6A4wS8O0gO4fHrFAg71EPWyTP4RHD
         BukqJsvM1+KEVdWZVb56e0FDCqW0y/XODN6WSVm7vyfSr6EWZKFy6stlmnlsPm+BxC8y
         71encUey0GA0VEJlDits5p0sijZgIK53uRIGXy9XJCZyoACUBmaDicDtROq+Ow5XiMA0
         ojVY+pnpxdvOO4bNeVzkaI/QpQzwG9bFwCEHxfe7cgnkyysvUTN+b5IWdUSQp/9FpBhh
         6elb10s3XpXfpnUcIwpP6qLU97Gy3Jj/sfbN+6Ps4vPP7jYrAUBXuPAdcCNvqbw0vr9w
         Z9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3yft3eRw7x55GdC+4t3M3FGqYF8/c1jxghhOsxf42Oh5rG3JrdQA/4/3cvhuXSdzKvSrlv+WD32FYVQ==@vger.kernel.org, AJvYcCX36v8aC8ppfrTKjSL8ofrwk4sQ/cOXTn0qGv+6RS2V0D0ByS7eWZirypNGq8Fo3j2Mxw/AFQ5jKSlX9GAh@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRL5seV/9jYWoUhR6dyzojyZvAxoInxx6+XYWhEzmRWYqUKY4
	MMm+xHRyNbklpvphWZTPHV42D9JvyhcqPqQl3EgGV5IT7gV9dzr3
X-Google-Smtp-Source: AGHT+IGGs8AXKCF2M+ePKguX6/PKGZP+dYxHxuIw5JoXxbUYN0W1iHbVgBps6cVkpFGUwRTsse7hJQ==
X-Received: by 2002:a17:902:e843:b0:20c:ca83:31c7 with SMTP id d9443c01a7336-21183d7cc28mr297750885ad.54.1731528268938;
        Wed, 13 Nov 2024 12:04:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7d9esm13976103b3a.66.2024.11.13.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:04:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 13 Nov 2024 12:04:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Frank Li <Frank.Li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: tmp108: fix I3C dependency
Message-ID: <8104966f-8e46-47b8-9e20-acefb667b5cf@roeck-us.net>
References: <20241113175615.2442851-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113175615.2442851-1-arnd@kernel.org>

On Wed, Nov 13, 2024 at 06:55:33PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It's possible to build a kernel with tmp108 built-in but i3c support
> in a loadable module, but that results in a link failure:
> 
> x86_64-linux-ld: drivers/hwmon/tmp108.o: in function `p3t1085_i3c_probe':
> tmp108.c:(.text+0x5f9): undefined reference to `i3cdev_to_dev'
> 
> Add a Kconfig dependency to ensure only the working configurations
> are allowed.
> 
> Fixes: c40655e33106 ("hwmon: (tmp108) Add support for I3C device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I knew I missed something ;-).

Thanks a lot for the patch. Applied.

Guenter

