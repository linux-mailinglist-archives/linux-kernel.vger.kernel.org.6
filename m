Return-Path: <linux-kernel+bounces-210140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E2903FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449CE1F2460D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C622334;
	Tue, 11 Jun 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="G1I5g/of"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258614A96
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119153; cv=none; b=onN7UJjyY2bMefNKyMoudJXzHkGIU1B/sYvQfNsGqOr81sLVsHC4d8XR0ElmtRyaXIwOl84sl/ySI/7kijdVDA986CUg9uZNoor8c7Jm+50uZOHe1ZyF8q43/ezbFrjHuP0QYgeN0gg47TadyYMentVWeNaKKHrrq13sQZ4f2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119153; c=relaxed/simple;
	bh=nZBnie7/9yW63lBsCc3eXsSO8y38QNlz/K+eQllR9WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll1H3Z/ZZL7ihyiAvYtM7HDQKYPGUNzN7V3XrY+Fej97yfCcK5jBsCZ5HEKUrDZA0ee+EtcPNmyXCsSy7SbZLXQymBECzO9/5sCzI6qXnfIZ2B7QFO6a1jA99QDYTZlvWEC0SeLSWXfftqd/46Ij/mIXL9ZsX3WG6TtjWHqCTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=G1I5g/of; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627f3265898so61485207b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1718119150; x=1718723950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M10CbUZmXB7Dee3D7sJ9T+X7/UYDjZpP4+Wii7wbA+4=;
        b=G1I5g/ofopLBTUnpl6cUM9rW6fDK11dJ03MW6Qd44pfsMa2i38oGeG2gy8jz94cHvz
         YihGr3NM7pu0Fc5Jjr8T3hYhZ/a7ANLU95XTqlq0Ep1D+uQsyDYk0pPSyk9dOpKM28M6
         VHwG+fjoaUJVuvdnTJVFSA+IGimTenrZwnqZVHlv7W3CXYDls6CUnz57Ulyug/3FggeT
         SAud/Cu4nGPJr2PyC9K951ZIRfvaUwNtA3Ib7ZLpAYSBpR2MZS+m5xpN2CFQr4Ks8qom
         dGo5sH9z4w15EbWzFZ+3Igvs36CSgcAEZ/CsrqSj7Rrz1TxWSpjclSmj4Y5KSH7M9b43
         F1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119150; x=1718723950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M10CbUZmXB7Dee3D7sJ9T+X7/UYDjZpP4+Wii7wbA+4=;
        b=UoVL03/Px6IaZq0pBwi/8VREAdnsPDqkTgC7znZB1OqNn1WGAhUQW8MOtQjqShvUhc
         sPlVeT0nQ9bOTL4ROa+j+2nfwxb9aNKQilHUdHs/mAM+v0hdJvd81m8Nha+5iCaZiPrr
         FpB487M5iKqVQQJebYtWDhW3ZE9dbmgUCw3a6P7pgncNb6f06cqvnjGvy51uvYj8qOXt
         brK0+Q05S1gtTfpRkmdKTPR0rWzDXXB+OTFhdM7NKajdAe4ScvV+36gU41uFKUE7EG8i
         X77Qnnl5sEwR+J9ea2BzqsnDZAg3Z/8d7i+P0DXxuV3BwNcZ120KBE52Ce/25Yap9T/Y
         si8A==
X-Forwarded-Encrypted: i=1; AJvYcCXMfj42Y0ISslRTo4c279fQSazipkS5nCBtlPgK8QqZih+OT3h0kounPgTaLCrF6iqYEypd2JlMNJIVT9cPH7clpXlc/+MAe7jWDH7F
X-Gm-Message-State: AOJu0YzrgJP8eCcQWYHTT5pd803nVanyJgSmSCLoQV5gqAJkt0EoF1Ya
	f+A6vlITGQQ2RayEbtHMNVSC7ul00On991Gpf8DGTnSLn2JK7yBLCIoF7n3acMxH+9qTxH0JN5W
	P6O+mXYQvHCpH4XSy3tC2I/kqKMYlAxYgHTB6yg==
X-Google-Smtp-Source: AGHT+IGZktdb+mXNwm5zMn5WZrRMM33fN6s00SSt7So0FNfjBJkDtcWY/jhchu4Ql1yDEY/OiyCWdDlQcY7P67hPaog=
X-Received: by 2002:a25:4982:0:b0:dfd:b3bb:ac11 with SMTP id
 3f1490d57ef6-dfdb3bbaedamr816466276.59.1718119149436; Tue, 11 Jun 2024
 08:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510100324.5961-1-abdulrasaqolawani@gmail.com>
In-Reply-To: <20240510100324.5961-1-abdulrasaqolawani@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 11 Jun 2024 16:18:53 +0100
Message-ID: <CAPY8ntCWoq6UMns04W6-BmYtCHggVr4xqZjOX1bcZtwyO-2EEg@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: replacing of_node_put with __free(device_node)
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Cc: sakari.ailus@linux.intel.com, jacopo@jmondi.org, mchehab@kernel.org, 
	julia.lawall@inria.fr, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi

Thanks for the patch.

The subject should be "media: i2c: ov5647:" or just "media: ov5647" as
you're only touching the one driver.

On Fri, 10 May 2024 at 11:11, Abdulrasaq Lawani
<abdulrasaqolawani@gmail.com> wrote:
>
> Replaced instance of of_node_put with __free(device_node)
> to protect against any memory leaks due to future changes
> in control flow.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
>  drivers/media/i2c/ov5647.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> index 7e1ecdf2485f..d593dba092e3 100644
> --- a/drivers/media/i2c/ov5647.c
> +++ b/drivers/media/i2c/ov5647.c
> @@ -1360,23 +1360,19 @@ static int ov5647_parse_dt(struct ov5647 *sensor, struct device_node *np)
>         struct v4l2_fwnode_endpoint bus_cfg = {
>                 .bus_type = V4L2_MBUS_CSI2_DPHY,
>         };
> -       struct device_node *ep;
> +       struct device_node *ep __free(device_node) = of_graph_get_endpoint_by_regs(np, 0, -1);

The media subsystem still requests a max line length of 80.
https://github.com/torvalds/linux/blob/master/Documentation/driver-api/media/maintainer-entry-profile.rst#coding-style-addendum
Break the line after the =

>         int ret;
>
> -       ep = of_graph_get_endpoint_by_regs(np, 0, -1);
>         if (!ep)
>                 return -EINVAL;
>
>         ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &bus_cfg);
>         if (ret)
> -               goto out;
> +               return ret;
>
>         sensor->clock_ncont = bus_cfg.bus.mipi_csi2.flags &
>                               V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
>
> -out:
> -       of_node_put(ep);
> -
>         return ret;

This could be "return 0;" as you've already returned if it was non-zero.

I know very little of this new mechanism, but it looks reasonable, and
Sakari has given it a basic blessing in a previous patch set.
With the above 3 comments addressed:
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

>  }

>
> --
> 2.34.1
>

