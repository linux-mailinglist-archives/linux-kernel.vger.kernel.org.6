Return-Path: <linux-kernel+bounces-282408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47F94E382
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4151F21093
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F66A15F410;
	Sun, 11 Aug 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2Y7UYVG"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86579F4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723413558; cv=none; b=LV95KTIITGTQOpwWxdCe9dkYN1Hc6WyLgN45J2Lgc9LluXjwTDG805pp8oc4Hclm5WHvvibzEbHIxFzCt14KZEhynzWQlhh68yakNJFQj0HqWitcZKdlrZ0YWRQlNPM1qPyT7e20rkyg3PkNHHkWTG9DlTsMnJMMSY3weCjVk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723413558; c=relaxed/simple;
	bh=jgINCKXy1M7ipw0bUlnzEjZAtO8nuKxB6NMM8yG+mfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaYh91omzyYts8VlwBTnU4x9wmixYc9cFsHqlM92RvXs9owJzmLZrWsYWn6VDXR4MCBe53fB2l6t8ewWEFKt3mAD229FV1D/G8udySVTvZusaP4DlL2Kf2g7Kjg05eIkjsU5wjcAIYpBeGZrZCSML+vfJlUk+DFMxOuPKXUTw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E2Y7UYVG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-685cc5415e8so38252717b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723413556; x=1724018356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVeTnkNK4o+915OQ50meYfGSgzhYk12S1v4XIFKF0zo=;
        b=E2Y7UYVGyl+BMzwsue+ezNDZWVSAjbmt0jsXtenFqnwghjTaTkj6VgQ53KzxHJfGtm
         d3GzLuyYUT24HPCgo7HH0R+2DfC0LZstkDvoQXMNrWpMyz6YremUooOIXl2em37vPb3B
         VfwyEocNRW3MsTmMCRoYa/Bj2ALVPYmABQKKWZqIU/idIGAE7cLhHdND7Dol37O19LHv
         EYW1lEQgBwefIDOU6P282HcqMb55j94ii6lDM0xfeROKU5LQcw6eljldf3j7L7cMvhkU
         7be+V3613O/4yQqs7MT9b6sGqZBYFdPHnIpDEmXPTROK+d5p74JN9+Y8w85CeWzwXxRE
         TimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723413556; x=1724018356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVeTnkNK4o+915OQ50meYfGSgzhYk12S1v4XIFKF0zo=;
        b=gCZucGkl3cWqcdKV4GAmbyvyJuMddN54Dkq4leHuqRoom2E92Ogr+zZAvXyLIWvwOr
         hc2PzT1T4fw4Rppj6MFB3SF3F5BOIhvgiLmTdjrvQOhMWYUNQ5Hq7583BFO7/eaIMxpT
         VNJJDynrwM3I8WxphkZBu0D7o/FinLPpfEHk0iWauV+wfn4OBArx4piKGVum1b+0/N6M
         gOC2rp/cXgmr7P4GTohiE4AwsTifPRqf//ZHoihwp2l7Is1C35vbrad3HWzmbMwX+kSh
         OPznF7rN5KpmJ3mtx9HrCQqghiP5PJ2i3vpTrLMYmUy0oXoXRD7ocWjW2bcVuF6s73cv
         WCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUFxn1pDopNnznUZHAeIF2aZWd5/Nh5ysxmU8ogQehnJ0MzE1tNYrYioC6VzJiLLZr3tjtmShqJbZOBrRfN5baS9PzxU3bZOFU3OUBt
X-Gm-Message-State: AOJu0YyLdAX0utB5HlCkHedk6enIM9YPUPDtIXPPpYarS/O4siinWsEn
	+7wc3sO0U69jhCOv4uMGea1pjpexeCCOVxN1tXZ5Yc+wHcFse6rdb3zGo2xaNPM=
X-Google-Smtp-Source: AGHT+IG6Uf2s+cJIAuVJOZUuYMZ6RQpmyWtobeduvMQxy7djfZiGVOotbgm8Hyedt1nGUZVSRl7Fxw==
X-Received: by 2002:a05:690c:300a:b0:64b:5fcb:6847 with SMTP id 00721157ae682-69ec5d5367dmr78530547b3.16.1723413556319;
        Sun, 11 Aug 2024 14:59:16 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c044:c4f8:9353:51ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm26334915ad.89.2024.08.11.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 14:59:15 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:59:13 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: char: Export alias for RPMSG ID rpmsg-raw from
 table
Message-ID: <Zrk0MeDFI1vvsK9A@p14s>
References: <20240729164527.340590-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729164527.340590-1-afd@ti.com>

Hi Andrew,

On Mon, Jul 29, 2024 at 11:45:27AM -0500, Andrew Davis wrote:
> Module aliases are used by userspace to identify the correct module to
> load for a detected hardware. The currently supported RPMSG device IDs for
> this module include "rpmsg-raw", but the module alias is "rpmsg_chrdev".
> 
> Use the helper macro MODULE_DEVICE_TABLE(rpmsg) to export the correct
> supported IDs. And while here, to keep backwards compatibility we also add
> the other ID "rpmsg_chrdev" so that it is also still exported as an alias.
> 
> This has the side benefit of adding support for some legacy firmware
> which still uses the original "rpmsg_chrdev" ID. This was the ID used for
> this driver before it was upstreamed (as reflected by the module alias).
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index eec7642d26863..96fcdd2d7093c 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -522,8 +522,10 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
>  
>  static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
>  	{ .name	= "rpmsg-raw" },
> +	{ .name	= "rpmsg_chrdev" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_chrdev_id_table);

So you want to be able to do both "modprobe rpmsg-raw" and "modprobe
rpmsg_chrdev" ?

I'm not sure to get the aim of your patch and will need a little more details.

Thanks,
Mathieu

>  
>  static struct rpmsg_driver rpmsg_chrdev_driver = {
>  	.probe = rpmsg_chrdev_probe,
> @@ -565,6 +567,5 @@ static void rpmsg_chrdev_exit(void)
>  }
>  module_exit(rpmsg_chrdev_exit);
>  
> -MODULE_ALIAS("rpmsg:rpmsg_chrdev");
>  MODULE_DESCRIPTION("RPMSG device interface");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.39.2
> 

