Return-Path: <linux-kernel+bounces-347627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97D98D827
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F861F23979
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730761D0BA2;
	Wed,  2 Oct 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOl5Xu5+"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4A1D0B8D;
	Wed,  2 Oct 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877391; cv=none; b=PQZGq8GBfuf3yFmBnBx0qMdFPIgG0Rt1JjE39aofL7w9D1U7x335nybVZw/4oYRr74wHD21Abj5vbjrFQCcvqH1QSgHZtGSI2xPnPTSQ77WsrJgC2d9jvQvJ/VM6ddmNi59VXIc5EjsgoiiMGwQ2yK46BVHLHaShUsn1j1mtyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877391; c=relaxed/simple;
	bh=MLhV1yTakO+32XMYkjMjsXbmyMLk9BFciEzVSlWE514=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkfdiCuKvOKOPXR/L3fAx9bweQhHSlj4mCvcaGiN078Ksy1+Gm5r/lN0y1VtK1ZysD1+idP3SWrLr4W/CXjqOM4HrVqwelT/zdSw2nH3WwVdbTCPHSsRD21A8d8upWJByX2Rl8ihhxhj69lIHzGoVGWUqT5Sz5a2hEcpCTHEBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOl5Xu5+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso5702651a12.3;
        Wed, 02 Oct 2024 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877390; x=1728482190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzr/djNTo7QM2hVJVjEP0h6sWNhcswi9fz8V8VMAXkU=;
        b=LOl5Xu5+Wza/2q63Zr/R/MxgjIOTLJDAsQT73ED5Sx0m5orjl4HBDr1YcGixzAwds0
         WQ55K0f4AzrJeHwSp5rJysaKozbNRXbbr3nBoZdMS82hnhlGbPK+UQt8C+ETJQlvDgJh
         kLgfs7UHXa1/0AXILUZsu80DekeBbHauY9kB6arS13uNuZm185ZafaINIvsXzZdsdTxV
         lGLy8QX2L8mXGsfZOF6vmMR7SvE4uf1tTOWGGgusAa1nw/I8bfhGDXwwSRGw5ALk6EcV
         Y4Aw+8PfbdFa7sMzSKYBb6J+CFtw9URLgSCf+q8SZYM+gyX1VvymLHPzb0u8pVF6eI71
         3dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877390; x=1728482190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzr/djNTo7QM2hVJVjEP0h6sWNhcswi9fz8V8VMAXkU=;
        b=YFWwT8YjjBKxpCEJzkH0fB+W9mHmzOoWyWwTncz6hjYhwdwfjFPkG1+XmfHR5+rLJe
         FkPDWNof9RG73830gCb50w8RW9zwJsVVU57LBSVnWpWYyxapXfeaTc6YjVRKd7Fzdmhl
         TrAC/4KXgCWs2a8NiUQobXc7YumW0nK10ClVDzDm+FcLz67rZRDhY3fX2JAZUuaaMUAN
         dj7tf4z7wjqFspIhPGSYuuiXJAPrRyZ/zokLpTyUGK9bhXYOZgVu1W9T4WeBxE6QdhA/
         EwjpMg59vfbopqPuK1jiVsjjOMyHaR9FclaXRWl8jVWqfu0vqPx/yRn4zqnxKs4mg+Kx
         n/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVShcVtIPuFkt3ihyEPBGnruGl346a1swBiA3+yRSzA9kWMt6kK0tHEepfflyGp4nqYsfW33D4EknBi+w==@vger.kernel.org, AJvYcCWivG9roKvTr/X0Uh8MiYABHmjiIFAMahbkMUAfDCho0YLe0BS204I8ZsXck+ca8gFapwW48pQP5oFljnSB@vger.kernel.org
X-Gm-Message-State: AOJu0YwgP3T/Nxa4zxJiR8BMKfvqYE/iL/2BgjQ4WQPKpOoRe+YrtnJt
	YdMw5+xFfRNFG/UboirJiFnke6Ee3xFnhkwLfgkSx4XHVLJXiyL/ABYDUg==
X-Google-Smtp-Source: AGHT+IHHTGva87L9xZgebLhYmMzSjcc73eLT4jmTI/EgprDny98MVzbvz8pqycw5640Mb0IhPAy0Cw==
X-Received: by 2002:a05:6a20:e615:b0:1d2:ea38:39bc with SMTP id adf61e73a8af0-1d5db145cccmr5306999637.11.1727877389783;
        Wed, 02 Oct 2024 06:56:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bb351sm9863020b3a.62.2024.10.02.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:56:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 2 Oct 2024 06:56:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (adt7470) Add missing dependency on REGMAP_I2C
Message-ID: <29ecb144-8444-49fa-a691-541b50c2b594@roeck-us.net>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
 <20241002-hwmon-select-regmap-v1-2-548d03268934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-hwmon-select-regmap-v1-2-548d03268934@gmail.com>

On Wed, Oct 02, 2024 at 03:08:09AM +0200, Javier Carrasco wrote:
> This driver requires REGMAP_I2C to be selected in order to get access to
> regmap_config and devm_regmap_init_i2c. Add the missing dependency.
> 
> Fixes: ef67959c4253 ("hwmon: (adt7470) Convert to use regmap")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

