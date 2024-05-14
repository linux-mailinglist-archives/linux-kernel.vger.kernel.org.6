Return-Path: <linux-kernel+bounces-178357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A258C4C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145821F21ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C6101CA;
	Tue, 14 May 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBM9TtdZ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2EE541
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669786; cv=none; b=Dle+GeFxamhEnY7UCwiwGEvNntsGSfwRH5RCey+hX3Q/gEacV+WpBQp+w4aNFuQOvJ2h8FyW7lvuVH5fULjVJSFVJ3caGc/lYC5KRaD5GOa07eFAwz5h9JvXHQ1D4hs7VY5pB79uFSe6R0iNJ21DFy+2aEQQ7nhJ7aWH+lRKNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669786; c=relaxed/simple;
	bh=kDb0TWDdZL71YLB5umWKkZwh3jpUzm39KDlFCcL+eRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf14cL/XlYsoPgy4kaMBos2Gf3bRMS98NtsuMpagIdwDLJqwsJwCrZvpQJ9YefaJf9UQrW9IfqRteqINMlSgwyRLVZqlOgaLrByWWwc4Qy+YOQf4kRKn6KEnVdYBv8sI9Yc3Ph9Yv3EzK4uKUfsfBwcqzgUATLtTkbgGVDJTpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBM9TtdZ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso5034899276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715669784; x=1716274584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v437HTtmd0Eobt8bZsNnd8lfEPszKL1Tp4e8h6Bn+yg=;
        b=fBM9TtdZ1GosciEn4lwomuT2cxdC9zMUaJpJc/TA3Vx2RSpnADq2Xvn6c3gKpjGXML
         J8BYUHvGvKtVWl0joNEJ6f4EDAp02fZZxQMZW3NWTlJH/bVAupAniosolKAhfDwzBB7k
         HPi7jCZu2ccgwDPkzsNuHXbfP57X8Gt5pKIPLeNpzLw2cclzBSBy0eOOCxh3pLKumNRD
         VNjQRTcDGfk4MgrQEDuJTVTKFdRwN6SimTRyNBCfMhZOGYrdmGMfC71hmxYONOjZ4ix5
         WR5q70kQy0w2/HTMhDPfXK93KvoEzezCJFTrvgmotYQ3kREUcTqVavXMgyA87E8p/5YY
         4y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715669784; x=1716274584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v437HTtmd0Eobt8bZsNnd8lfEPszKL1Tp4e8h6Bn+yg=;
        b=Zg90QVvjd24Z4IMIhDMRXSVaiT6wpEUptZWbDSGUncqGWxgbateRzSX83IQDOkauXX
         efRX05iQ/B+AgNX1PACI5vlUZxST5Azr7GgL0UvzhFUe1PsTcGYR/hZMUNZJnOZLvrxX
         IQd1piFc6TyS2qkrEU2fPwCr4NwGueFzY7P/CRKb10GVZt35FkJllg/wOcThSxTRXomY
         bQ5BjZANl7ErEu8uGehcQIwJRGKSPpForm/6rSbfIA329bBLokN9Kqo5AQkEk6LgMSBb
         BgZF4dcaOlhQskrGCRCrWHUSuERPpVrmq85wL9jdFUIp/gaqJqWEOoMQDg1O+WjkDhsp
         YPnw==
X-Forwarded-Encrypted: i=1; AJvYcCVwp8UIYw+u4AWPBi8mf6lA0PS9oBEdidtjhP2kQWalPQNc9rRsqcYkydSbXmPRgAfuGP9t0ifLe2NtQyuIDwo5dCUC4g4FdiOZAS66
X-Gm-Message-State: AOJu0YzaMUkzIxWj4PkDwlPeAXiqs9bmCWH2aHi9UXbTXSlhCDiHkDh3
	mWyJyiUeXFKXgRRu9gFcZRNLZOoqWjFK/p6Pz0GugQ85vCMxLrFuWC8QAvUnJenWrdD2TjdKJmG
	dBSbwJyKNGkFq1oyUODEq3yCPVeaMcnmjztQm+S33qWbJM6IIOuU=
X-Google-Smtp-Source: AGHT+IFh/wFaFmdGHkHg3NyYesn4kttpR5GJBs/iETSMhlNi6fPweaEUkkZJZvlSTyQ52rECQA1N3gnLKFbvp2PA5LQ=
X-Received: by 2002:a5b:40d:0:b0:de5:9e29:b5bd with SMTP id
 3f1490d57ef6-dee4f33396bmr9939038276.64.1715669784141; Mon, 13 May 2024
 23:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510065342.36191-1-warthog618@gmail.com> <171534996897.34114.8159265536879918834.b4-ty@linaro.org>
 <20240514033656.GA24922@rigel>
In-Reply-To: <20240514033656.GA24922@rigel>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 14 May 2024 08:56:13 +0200
Message-ID: <CACMJSetivWMXNu9dJyMeJTfYSsQaez_7kSHce-5NJL6=72Rd0g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: fix uninitialised kfifo
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 05:37, Kent Gibson <warthog618@gmail.com> wrote:
>
> On Fri, May 10, 2024 at 04:06:16PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> >
> > On Fri, 10 May 2024 14:53:42 +0800, Kent Gibson wrote:
> > > If a line is requested with debounce, and that results in debouncing
> > > in software, and the line is subsequently reconfigured to enable edge
> > > detection then the allocation of the kfifo to contain edge events is
> > > overlooked.  This results in events being written to and read from an
> > > unitialised kfifo.  Read events are returned to userspace.
> > >
> > > Initialise the kfifo in the case where the software debounce is
> > > already active.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] gpiolib: cdev: fix uninitialised kfifo
> >       commit: 3c1625fe5a2e0d68cd7b68156f02c1b5de09a161
> >
>
> I've got a patch series to tidy this up and catch any similar errors
> earlier going forward.
> It is of course based on this patch, but that isn't in gpio/for-next yet.
> How should I proceed?
>
> Cheers,
> Kent.

Pull in current master into gpio/for-next, apply your series, make
sure it works and then wait until v6.10-rc1 is tagged because I won't
be picking up anything during merge window.

Bart

