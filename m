Return-Path: <linux-kernel+bounces-348958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0198EE78
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4964E1F23001
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D774154BE9;
	Thu,  3 Oct 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5wI6PWx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925691474C5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956166; cv=none; b=AW81QYM4ufxL8r7IG6Kj12/0Dp5jr1iS4+tuhJJdO0hJgJ62n095d4cQ7rc+H3g+bxdg3Q5aiCGT6Df0BQthrISJIoTubNAlQTzwKW5PPZqe09YJ/HTiMUW+iXri7oRx4+Sd6gmzs+cnhoE7NrU93v40qR6yQmxQWgtWK7ZJDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956166; c=relaxed/simple;
	bh=fZgYWpqR7tQQQjR1f/FLeybwKAQDcLLRZNpCb1FQuoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FouP6pI49gWGEBcPUQImgGPbLVFI1hWsJsEJC5VFy3/wI8+yvfbTgX973jxTBP5JbHPC2Ju57SaQLe4FH1QZOSVFQUndro4fAa0DQxYGNK3t73xqM16nR5nyqwfKvtQJ/lyTTOR5H42UuCzPHID4jK228YmtPWQZHgtF+lfSH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5wI6PWx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b93887decso6681075ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956165; x=1728560965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rEnXND8D97qQAygLMCqp6WRiokIgEMKSJrNjep6zuk=;
        b=R5wI6PWxqlohvFeIxX9ncatIE4IHFQ82a22i+n+j9zFrEApiCqwQ3C2zVQLYveeETL
         pNUPCq3pT8OJTzBZrdiMrgZewVYRXJF3ep3FFdosC61CRwbrKOkyhr/aXBMy9W5NIh//
         iZC0ps+02gfirQA8H8NZeWi2yRUJxdzUbAdn37HBwOtQEbxjuFii5VTtR8Yv73lCOhwE
         k2/JwNA4LTUsN4pRe/I+KWeS2YRXS4rPVdt+D/3zZpnFU6/jufauIZoCtblazZReUX/M
         gSX/EQz8NryvCSC/8URYNmNgOkHLwkxa/MRbSZGu7kVdN/s/+dRv+aQ0JXhh+uiRFsUs
         KaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956165; x=1728560965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rEnXND8D97qQAygLMCqp6WRiokIgEMKSJrNjep6zuk=;
        b=VgHmk5yBbrrfahTNfALERmvlXzUw3e2yqV3mPdL4pOva93FHkaWErzvZSqP/MQFSXu
         It2/8rbTMrRfG2ASaibhCEgnE6TVm4FHad0yLbwbsqg8X2xJWYQ0q+llJDPZdUUMixm5
         kRyH9+5EmTSoVmvadAXGQvqjq6Dg0B6dNy6uAUvResd03N86eplUP7Ij3F6YZ5AtzbZQ
         nPqOPcTMs55cg9fk/+0iBTOC6hrq6/7zgbuxT6qkYhvb65Aq9MZSniLE8w+Am9OUt+PB
         g0N9zRGYTvy1nuX57mAYrgsthAYvkcfyHOl8qAl4SZf3X1AQd+1XZw0xT/gvzALjKprV
         cipQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWMM44EQQ8eoiddtw/kfWT6pjU69K3s10y0Fnp9MepDnemtzPiWrQyQwOM0orHUmcZPNYiFG922QW0zqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvhvC7FpPz5zE5TFsBJT0VX5pOqAkNyGiCHrozUtFOGVxqmkU
	udvm3KQu+7AjqziDnsQsKdf1PMhio09Qu3XTFFt25NFvTW/zY8Xz
X-Google-Smtp-Source: AGHT+IGvyYVk0lkfChMHakpBDtAvaCgEqSNCXnagTHFwINDsj6dSccNJTfMNT2IWCe3wGc4CFWey1Q==
X-Received: by 2002:a17:903:2451:b0:20b:983c:f0a0 with SMTP id d9443c01a7336-20bc59fc2f7mr84061655ad.31.1727956164829;
        Thu, 03 Oct 2024 04:49:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fba0:f631:4ed6:4411])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8eac1sm7543125ad.154.2024.10.03.04.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:49:24 -0700 (PDT)
Date: Thu, 3 Oct 2024 04:49:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit
 declaration of function 'i2c_transfer'
Message-ID: <Zv6EwdDybm_I0QSh@google.com>
References: <202410020735.aBI61ZYn-lkp@intel.com>
 <Zv0S3wXOzgmyFP3x@google.com>
 <CACRpkdZmKfNWF7ciHJMi4JU+_JnxjWD_kMhfxFOeydQ11Vyc4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZmKfNWF7ciHJMi4JU+_JnxjWD_kMhfxFOeydQ11Vyc4Q@mail.gmail.com>

On Wed, Oct 02, 2024 at 03:37:56PM +0200, Linus Walleij wrote:
> On Wed, Oct 2, 2024 at 11:31 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > >    drivers/input/touchscreen/cyttsp_i2c.c:118:26: warning: 'cyttsp_i2c_driver' defined but not used [-Wunused-variable]
> > >      118 | static struct i2c_driver cyttsp_i2c_driver = {
> > >          |                          ^~~~~~~~~~~~~~~~~
> > >    cc1: some warnings being treated as errors
> > >
> >
> > This is really weird: cyttsp_i2c.h includes linux/i2c.h, it has
> > dependency in Kconfig on I2C and CONFIG_I2C is present in the .config
> > referenced above, so all the declarations should be there.
> 
> I usually ask Arnd about all kind of Kconfig business when
> things get weird.
> 
> But could it be one of these awful things:
> 
> config TOUCHSCREEN_CYTTSP_I2C
>         tristate "support I2C bus connection"
> -        depends on TOUCHSCREEN_CYTTSP_CORE && I2C
> +       depends on TOUCHSCREEN_CYTTSP_CORE && (I2C=y ||
> I2C=TOUCHSCREEN_CYTTSP_CORE)
> 
> Since I2C is tristate it could be a module and then this touchscreen
> has to be a module too.

"depends" should handle this and force touchscreen be a module if I2C is
a module. Also in the provided config I2C is built-in...

Thanks.

-- 
Dmitry

