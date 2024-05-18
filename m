Return-Path: <linux-kernel+bounces-182888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D895F8C9163
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AEB2818E9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701613FE46;
	Sat, 18 May 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9Ar3D1x"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68517BBF;
	Sat, 18 May 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716039888; cv=none; b=EHIkOtbyBmJ3kGQuSYMwIkL+OhXaxEZ/16Im1aYmbyFHOSk6UiAdVICakk11TgJtekkulZox48iBW8oo10N7vCxVncSCAfECEhu8LprNZbtztJKMzj9A2s5HNiVMWmSDZp7EgMny7XjhVvXJHgS6UlDwy6csw+rU753KTt17NYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716039888; c=relaxed/simple;
	bh=gp5ecGd/vox+YzD8rCxC/+qOZWzTSc3PVPkyeqd5XUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2thBEGVJ1llytLXyFlQHrrG07lrN3mVNlk/ZdmGjDQyVgyZ2Mzk2E2EvgvCbMebh2RjOO5zOpHjQRSXzS3T6nuxFOOdXW4TwjloZ1nFGZM52IYFSG7G6CnOSX9E6/TCwRI1UTv4hnDbRPCLzNygW2N3HZCarHOM3uvOtcn9gnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9Ar3D1x; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed96772f92so34852665ad.0;
        Sat, 18 May 2024 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716039886; x=1716644686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iV38s3ZQJx3Kgselwge3nkBx0x14PzQSCscFqdNdozk=;
        b=i9Ar3D1xGdeIvioR6lsc7BQUSyQbqtLCv6tEutuHdhZQ26WbBVUa7UQVpfzXpSr+jO
         LuLbjRPumurIt1ehN/Y+X/Zivk94dAp6fluLqcVgXWMcAHXvVOpEQACYLNG+R5o7Djdj
         /jEdpLrlfdjMJ3qZFrVLCLeRHHflkMbCNJTxiGlwPg7etqK3r9F17MAHoxrBN00BYpHK
         Wxigmzj+ck9LznwtYb6NbaMVmX/1CQBEBeKTnB9XPOCFU7hnMixpaSW87cDJqQLoSMD9
         XOeHnJa+iHVDEsnFNZyl3Xn5VJTFnwLZK+x7yvKcz62yYZGXmXEcwwrmbGxWVuQhLX+h
         DGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716039886; x=1716644686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV38s3ZQJx3Kgselwge3nkBx0x14PzQSCscFqdNdozk=;
        b=bA69aAJaHe6ep2FkThkW02iBtsudAzf2/yZS0nElHZjqSU0xLpqB4I93QWwm28bf7t
         9RrGDR+sdNQ+Adr2+HT+voHSi4mnHoprT7QrWwcdBOlPxIUeCRyl3vt1FVwm7knVlmjB
         p0TcsU/uu6fGyqIc1iiZAxcdFsQpUVfgw85g9Els6FH+ojnjFbNsHwsxPDJSJEK8yfWg
         GjAzGvPTxQnq3/AM7Lnx3hUtTIE+ni72KM9RuG1IhlPTp8ohyTew5AB37rvdvlXbvO+L
         hGVTmmM6W7Q8Vuj6rg+i4niSnB5B32uixPkPE0xwNy9O65GF3VHccldukmVaxIgVcsBT
         6uOw==
X-Forwarded-Encrypted: i=1; AJvYcCVR36+yiPnJfzHIkWtNmHlTp/3ZayOKES6VtWXE9DA6QFVJTGskyVTLNpOahKg1S2fIuoFi/zoQV2tYO466eZRkh1XhEYRWsaQzFsxODOd9rE5K0fTVkx4zrHyzSPMLwCzKCFE0csp+
X-Gm-Message-State: AOJu0Yw+/8r0nmgRhClr4/yRoxMsk346qSwD8/C9eguVQaCnCiUPfscp
	Fivybc63BP6wLaxA/djJuU1TsSMRgGpCd2+CtvwoGIz1xIVZWEvz58LwcQ==
X-Google-Smtp-Source: AGHT+IHcBr2qrfJZ1Mp5jBSDRfEqOGVjO7WJ8kAO3F6084tG6wYfwsoNSkZgikEHWvRdyHQWsHbK8w==
X-Received: by 2002:a05:6a20:2447:b0:1aa:5ca9:c565 with SMTP id adf61e73a8af0-1afde0a8dc5mr28212863637.8.1716039886438;
        Sat, 18 May 2024 06:44:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13823asm173999915ad.263.2024.05.18.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 06:44:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 May 2024 06:44:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <2119a681-7e02-4ab4-9ea5-102ba2924771@roeck-us.net>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>

On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > Report an error when an attempt to register a clkdev entry results in a
> > truncated string so the problem can be easily spotted.
> > 
> > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> With this patch in the mainline kernel, I get
> 
> 10000000.clock-controller:corepll: device ID is greater than 24
> sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
> sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
> ...
> platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> 
> when trying to boot sifive_u in qemu.
> 
> Apparently, "10000000.clock-controller" is too long. Any suggestion on
> how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> for clk_hw_register_clkdev() is not or no longer a good idea.
> What else should be used instead ?
> 

Copying regzbot.

#regzbot ^introduced 8d532528ff6a
#regzbot title sifive_u boot failure
#regzbot ignore-activity

