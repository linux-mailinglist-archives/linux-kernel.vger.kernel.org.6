Return-Path: <linux-kernel+bounces-303523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D303960D68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097CD2837EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAE1C4620;
	Tue, 27 Aug 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHdNKQgj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4D33E8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768336; cv=none; b=qkZ+matHrkHEZq5we803JumRuXSIqb34k1HKBo1qcNC+MKItkHP9M+Cu/nndSN7TVlj+EqYPYMZQyMq/7Cp0rlP0RSGLeW9oglfZRgD3lSp51VyFAZqMnD8zoIEIfNgHX30zUJC1fnDIg2llA9wwcwTGcH+uFkwSnGWxkFtRNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768336; c=relaxed/simple;
	bh=15ORNTWxPQZbHScIg0ExMWBB3te8D8b3ZSi/1xE+1x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUJN4ROz0zrQQob29Uy58kEG9yzWxDgHFBcsSkmdthdQhfPN02mL3Zp12Utjxo/Pi1goyd0Cc2Gz3rmTH8oWw4nH+Jt8YeyuzriWCZrLhuaiN3IoW+5IOhYaJ47eW4EGq2rQZ2oWSh9OWMjwCjLTQWIrU3yCViCVSl+bNH80V9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHdNKQgj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71456acebe8so2499686b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768334; x=1725373134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JSMiJ5fVqnyKb+9n4eHykIt/ocg8tbqo6X0nAPTgvIk=;
        b=DHdNKQgjqXSm94ZR8hy48pah60m/RGVbgXxlve/w3A4RJrmA+SfAhQ/1k36mY4+aPX
         Zsx6bhGDCR0U2I+caLfAPnMuWW3oKbvBS4W/HOalYM7Il24FUoWf7JZhgeeV2iOuUv6o
         YRjxOcAYF5B+V6kAghEPsYqmSNzzbTISL7JYgeodbdRj0jlfUitP31+gDe9Ww1u4BwRM
         D+WeugzkJSOvtjZK6XqCVbASejX+uIkUszSP3mixRjAjQvoH9XKIJ4ZPxT0cUHkrNlR6
         3P/RjWGQEDm5BwkFgd+wcXJb6O3NEQkCXodO+w8gv9N71qg7WqauEfpHphw+wBp3XuDu
         MCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768334; x=1725373134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSMiJ5fVqnyKb+9n4eHykIt/ocg8tbqo6X0nAPTgvIk=;
        b=kebUbK9eKtXVz3bJBaX/M9lMgimhGMwxl008oVMOz8BKfIEf19BFNwycNIDkEjKBH9
         MMwljcqm4sq5PyA9f1t3qPjoDSuyb7z5Gf9Qqq2TbB10H/8i3shotG7NA+eIxT+hypmj
         +6147swLZmuIXn5LYFeyU4GZkxI2BVP7fekoPuSOJvoPGwlu/Nna3NYglV8oCMdpN0+i
         WQwTAzHvpCmFZgODEX4+hVXlQDtJePtgR/H9ufC9cPcCIPSEGu5Uoj9iQNJYwlqF6D91
         SGc0QGTbjpwJY//Qt1A/RmdiI5grZrG6FbUHNvY16L6099ssUU+Ti5JjbdjpoIJ6/Nfh
         s8wA==
X-Forwarded-Encrypted: i=1; AJvYcCXfqAT/d614qgCYZgXGApOvTvExTCU9VU37r4mmNX31s5i5crAJAiAKo7QYNq6RAWDVEB+15ZW/CJ3o37g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygf2rjU02Qw3TXWmqpHs/9bhkYU05cl2f8/FuFEZcb/pDds1XP
	MI8ze/y57DUs4md3CjuXAYEk+vpdeE+e6XDv7J2MGbmxNEPJFkCga1ukYaiL
X-Google-Smtp-Source: AGHT+IFC8drrJmM4s4TDlAOrYOIKUf05TrbsTxNGNy/4YT441AzNhYGWwAjlpKQO3LwwXX8KcqVrdQ==
X-Received: by 2002:a05:6a21:3987:b0:1c0:e629:3926 with SMTP id adf61e73a8af0-1cc89d6bb9amr15486459637.16.1724768334086;
        Tue, 27 Aug 2024 07:18:54 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.235.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6136fc523sm12117848a91.9.2024.08.27.07.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:18:53 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:47:24 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: kernel@puri.sm, neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	quic_jesszhan@quicinc.com, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: mantix: Transition to multi-context write
 sequence
Message-ID: <Zs3f9LIS1PenwMMX@embed-PC.myguest.virtualbox.org>
References: <20240826160328.12685-1-abhishektamboli9@gmail.com>
 <ZszDipyk1Ey8M0JZ@qwark.sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZszDipyk1Ey8M0JZ@qwark.sigxcpu.org>

On Mon, Aug 26, 2024 at 08:03:54PM +0200, Guido Günther wrote:
> Hi Abhishektamboli,
> 
> I think this was already handled in
> 
> https://lore.kernel.org/dri-devel/20240820091556.1032726-2-tejasvipin76@gmail.com/
> 
> and applied
> 
> https://lore.kernel.org/dri-devel/172414629205.2571141.13215409630895562248.b4-ty@linaro.org/#t
> 
Hi Guido,
Thanks for letting me know.

Regards,
Abhishek
> 
> On Mon, Aug 26, 2024 at 09:33:28PM +0530, Abhishek Tamboli wrote:
> > Replace deprecated 'mipi_dsi_generic_write_seq()' macro
> > to 'mipi_dsi_generic_write_seq_multi()' macro in mantix_init_sequence
> > function.
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >  .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> > index ea4a6bf6d35b..f276c65cc9bb 100644
> > --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> > +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> > @@ -49,22 +49,25 @@ static int mantix_init_sequence(struct mantix *ctx)
> >  {
> >  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> >  	struct device *dev = ctx->dev;
> > +	struct mipi_dsi_multi_context dsi_ctx = {
> > +		.dsi = dsi
> > +	};
> > 
> >  	/*
> >  	 * Init sequence was supplied by the panel vendor.
> >  	 */
> > -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> > 
> > -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
> > -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> > -	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0xA9, 0x00);
> > 
> > -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> > -	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
> >  	msleep(20);
> > 
> > -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
> > -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
> > +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> >  	msleep(20);
> > 
> >  	dev_dbg(dev, "Panel init sequence done\n");
> > --
> > 2.34.1
> > 

