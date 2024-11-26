Return-Path: <linux-kernel+bounces-422304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB229D975E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3EEB23C29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F71CEE8A;
	Tue, 26 Nov 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKhkOKt9"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE41BD012
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624901; cv=none; b=gbcgtFpyCWcdyUCWUFUVFpwruBZHpRajzZABo3GgdhHxmxsyyh8qOFXn9p8QnvvLqYmwAJ+Hnm17VlGxax8JrDeWguasrVq+khow3Uia4SZD9IKWzUJ2UOkCGIdfGI71bMt2sv2W97IOr2W7+fPrntH5TSKYjsodh42srrKFvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624901; c=relaxed/simple;
	bh=cPTLukRRkvaGSB00X3hsgqrDjbaD+cNjKIgDNOefcOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axArfMJ9+/+3W52o7vH34NO3XKTwP7nP9Rre4eeoCenaz0hiYEJHtIAkkn1+lMFoxJ8TK8/0XITl7pMaG0umBHOe1EOukmIm+JaoRIGs9MEQOz3+Sc0wIf877EJT19PN/ndTo3KQtYKvhttCX1+6HA/g8WMxA6nnlnKerIbh3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKhkOKt9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee676b4e20so56833667b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732624898; x=1733229698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPTLukRRkvaGSB00X3hsgqrDjbaD+cNjKIgDNOefcOk=;
        b=XKhkOKt9s0Y+ktsLJ7nOA6W8tFY9+gflqtV+KS+cspuiaN9S3hjKic5OEc5XUcud6b
         ViqsikGnTIUd27TXmq/4TDzc30czyiaQkoUom+Wganbtyg2gM4fDs3IVtjSHw4TEXIYg
         TSsV9yti2NATSuMLZlqhpZh0NQMjmurXRkoTqpnt+mch0QIS4uk6yeU3rH0bdWxUZ5Jc
         ieG5iFuXdRuyA/YFsOTp0lAPgsIrw+vcNSN7BE8gNaiLxoNgCDXeqa9WCcAsCXtmlxew
         KFMck9/sOCSWIeZyPUi3nkuZ2MWRVhNLyLzD9FrL7cu/brk0jMFpq8AZoHNopXBNVQ3p
         eNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732624898; x=1733229698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPTLukRRkvaGSB00X3hsgqrDjbaD+cNjKIgDNOefcOk=;
        b=JsqDu7kVSUNIQr5Md9J4UJkcSZet8YEiMtae09Hk2hB9kUWCcBZZ4YcIhkRokGVTMr
         76FP5yoEMUg+wrsyaHsX0jUR5TTLo5kiICtY0rpSiENq0bdDiHtvgw2A74NnUI1vzw+N
         /aGcD9O36BFvoondIHw992APvyWYJXWM454fvWH3Qk4mP5HHfO9gWysElDK4qVItmJWO
         zqloSmsl7UITIBSsL49+0RyHXCkCVCNDdsYZsjSnAAOn0yleVh7WZkHFyJ5eoxMIhk+A
         lGqjD7MFHsiYV6QsiH8s43rgCc7jmfoVFNdxYREH/vviYrazMRdYE6aeYM6nhHZw4CUF
         62eQ==
X-Gm-Message-State: AOJu0YzQ4+mVOyhDG0/qngj12ti/rsIxakM9oPX2UqRDYmhZgYFvSBiM
	Vj6SMhPBpt6LoVag55U5tICk6v/Ep0n+uLW2VG20Q4ghuLWKR4csXHOh49NsbyNmRwcwU/qnC7M
	k3NaJ63J6BQNuUbQJG8p8wW4oOATuxxpZ5z4juZCiAOs02ri9roE=
X-Gm-Gg: ASbGncu7IneTpz+6m39eJIdVLW0NAwbzb6gLKDcgmjWUDvZCobEU2o5GSCnN6uC7sff
	66fI0Vs/uYD3AdWBns5lQXTkuYAd3uj4Kb/CKEkEjq9D+YwMDbH7k3KLjuV8X36Y=
X-Google-Smtp-Source: AGHT+IF6l4+hBDV+putwVYiDk0qugPERHe+upMe++6V3UcZ5/+gbIZmfJ4RQdC8Lpth0bOqnEm38/6mER962cgmW0UQ=
X-Received: by 2002:a05:690c:2504:b0:6ea:8d6f:b1bf with SMTP id
 00721157ae682-6eee0779a6dmr182254577b3.0.1732624898603; Tue, 26 Nov 2024
 04:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124124919.3338752-1-sashal@kernel.org> <20241124124919.3338752-21-sashal@kernel.org>
In-Reply-To: <20241124124919.3338752-21-sashal@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 26 Nov 2024 13:41:27 +0100
Message-ID: <CACMJSevZVPcHaEfromwLu1mM5kXE4sVz6f92u5HKLpM65ypbeQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 21/23] USB: gadget: pxa27x_udc: Avoid using GPIOF_ACTIVE_LOW
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, daniel@zonque.org, 
	haojian.zhuang@gmail.com, robert.jarzmik@free.fr, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 13:50, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> [ Upstream commit 62d2a940f29e6aa5a1d844a90820ca6240a99b34 ]
>
> Avoid using GPIOF_ACTIVE_LOW as it's deprecated and subject to remove.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/r/20241104093609.156059-6-andriy.shevchenko@linux.intel.com
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

All these GPIOF_ACTIVE_LOW patches are not fixes and should be dropped
from stable branches.

Thanks,
Bartosz

