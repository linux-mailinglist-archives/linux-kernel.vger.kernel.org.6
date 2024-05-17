Return-Path: <linux-kernel+bounces-182668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7026D8C8E42
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96ECF1C211F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288BE1411FD;
	Fri, 17 May 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM+yHknU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871C14036E;
	Fri, 17 May 2024 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983757; cv=none; b=lcQJzA8tyNu7fxXKxBSAindpDEGBMFrdcTQBdJxZfXjo7VXUbLI0VI+pIfOkopdAD4qISbnIxbtmH9c1VOKqZ06TcjXdbdTjPwP5T/+FIjbVk4/4kzy9xcXLOWJBcIscHnXXEJURPwHSWoBTFfoyqt6ClxrkObyEuTUjeQuS6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983757; c=relaxed/simple;
	bh=p7VQrt0hVF85r4m78hml7+feoryJV2oP7cwJcWERmvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU9oKna+3mHsSkInmCZsyapx/wY+aa8hqLLez/KZ0N2yfrPKYx+QPZgfgeXhUUe/Z89v2mZZKzVo7MZQ1IrW1H7mThgjT7sJpS0wOuI6jAb4JK7dX06c5EQTWi98WXfaETpmr4B5iHk3DuzUcgzwMsuFejYoB7xn/69EutBdPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM+yHknU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eca195a7c8so23346935ad.2;
        Fri, 17 May 2024 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715983755; x=1716588555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5FbSn9s1tKydRJA9pzDZNSE1X7qwTwIhhD2Dj3Awq0=;
        b=SM+yHknURpFs2EbRKkYkhrH9x2qJvdMc5A5w4GxKJH7OUEf28FgRVVn+E/ouC6i5au
         9sezYq8hdpaHlSVoEJt2npad3JtT1unPx8mjiCTXAFni8aB1E8mIyjU0obnbTNPYQ66y
         aPSiE7p4sNTD7jxHUM2Aj2tKYsLw2ZIK4znszpgsgRX6UtgBOX6qZu9/ta5ymCRxXyQ/
         U/xcXFwITscLrOIMo+Os5BnxheaS8zdlguzvy+Ewg6epr5k5/rW1MOwCZObZDxT10WQ0
         FxmQeh82Fhi86rzReFbw2Pd2Ccr6EPS2uJesTA08pvEB7XFRxx4UOVbFwrQtxwQ3QfO7
         7L3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715983755; x=1716588555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5FbSn9s1tKydRJA9pzDZNSE1X7qwTwIhhD2Dj3Awq0=;
        b=n6DsLGKvYTHJa6XjcGf/KNJHh3HLw7o3Ny89q+XlsVHs2aUBf8GIE7gQr9P/cc4Pxa
         XJhToNuLY8IwFb9+zqwtDULCAQXHkLfjelHe6GkWiFS/WPqNdX+FLsYfSBzHWRUWPUtw
         UafBRtkHpYJCUdk/zV0zVCPYZV9Fk9QmQWRtGfWTLuyJW9xFGD+pFgyF+jP9OUvZJeJ8
         8wrgkw8MryvDBxsQqBjyinuwbGCXAYDOTOktLJBVlYKBxIqYB8kiY6RG0A6Py6XBocAa
         Kq3VpTEx6qVaxjkBKFYyaiHE47NsUoKbgTEaQZBxKqevFyel+lLWQYw7EiQI29Cc/8Yh
         8ISg==
X-Forwarded-Encrypted: i=1; AJvYcCXL6n9+YAdKaPIhmAznu3zpfEo3wqUpPrqwL0tdp2nS8R8Y/hPnGnb7zxOfR9RNlXXT0+R07ZU0BPFQe2MJwYP4jV/AflP36GDigaTvUkTUt+iaUWlI57hSnJG2Qs1Tcg23ucuI9o1y
X-Gm-Message-State: AOJu0YyTW0QUiMqWPR9GS9lKSxi61sk3AYsybBAJ/Y/255XBzGdalvTm
	TSiXLJRD7h3xSUN+Gt1coR2BdIPlx7IMaxhL3fO6zSRvJA3AaYVC
X-Google-Smtp-Source: AGHT+IHw0SSxGbgWgUfIQ48u5aCrMJ6NxXHY/lsXY2qPFDOykt16gP2/9vDERX5jfEkmQg6e7+nhmA==
X-Received: by 2002:a05:6a00:845:b0:6f4:4723:98b3 with SMTP id d2e1a72fcca58-6f4e02ada39mr25737638b3a.13.1715983754717;
        Fri, 17 May 2024 15:09:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0f7fsm15181332b3a.120.2024.05.17.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 15:09:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 May 2024 15:09:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>

Hi,

On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> Report an error when an attempt to register a clkdev entry results in a
> truncated string so the problem can be easily spotted.
> 
> Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

With this patch in the mainline kernel, I get

10000000.clock-controller:corepll: device ID is greater than 24
sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
..
platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready

when trying to boot sifive_u in qemu.

Apparently, "10000000.clock-controller" is too long. Any suggestion on
how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
for clk_hw_register_clkdev() is not or no longer a good idea.
What else should be used instead ?

Thanks,
Guenter

