Return-Path: <linux-kernel+bounces-315102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFC96BDF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9388282DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7B1DB551;
	Wed,  4 Sep 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkuI7vKz"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3711DB52D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455242; cv=none; b=kCHgycOAjyUKo0VlMJSOlL/KUO+9d+D5kCoa8UgkfoGmAVeI6gxczk+R34EcGxZPu8Ip/DErO+LuXhqeNT42vQRSfjDXVMW5m10evVZXvexfyzfBkuZgDxRhg3l0ot4LDW4StfgOapWat9oThSxGBX5/7fKa3eVSJB+dhcvNAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455242; c=relaxed/simple;
	bh=Yp/QWWcUnYtn9a07t67yG+6+r3OjEgIy2UqP+f8tBd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+1Y4BcLb6wg2OK3TTl2yTGruE+uldqRA3vkK85Cz7HvZn/VkrTMxaaUSp7hANXkjdeIsZg03j0cWjEWV7oeawlmvPpacf2xSj9Ewb2qaii0kfL0TA1VqiajsOfr3YYcH7qW+ZGBWnTavzDfgk1hR9YDVVvqUmVjxmecbxd7DDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkuI7vKz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1a74ee4c0cso5611095276.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725455239; x=1726060039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUhSLfHRjhoIJVhDz7R0s0eD+P+ExXP5AG1Qr7NiWOg=;
        b=MkuI7vKznZ6VBDH545pON9G+3eRzL1D2LHqdfnFruQHmf0TZhHvAfJDeWtww99awTG
         X/BDhPOm/UkaazfJPjhsYZ2qLBFuNkHhQzl+unZBtwrxP+lKEDtwWUA9xo8KWjSQXXcA
         YtrJItRRnvzym7FKSoooJ4DvaxdPym3bJVlj6q5mrZjcpJD68JNsmGiWfcFNqviLlCJT
         NmMINOLA64JaNiTbb6QAiukdxHfGUiSBxBSDgkcVcYqvOtq/FxNn0KqCmgWLHc3blqib
         5nH4cE+poNwCCvdTaC61XMCMPdL0ybHnZ8OuBtI2rfZK3d5PKY85OYvnni5CfxvdevIs
         SXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455239; x=1726060039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUhSLfHRjhoIJVhDz7R0s0eD+P+ExXP5AG1Qr7NiWOg=;
        b=SL2oU/kGCbdfPi2csceqTHXzwN0f6SzRQtsZdxZfUU0sSv6cIErpQTGv8wLL+tjd98
         xNFATmG5EosTKcHkL9OgNV2ClCm2BHoqIq+raaQ1LItrlAbTPaMSSTLnWfy0YRSHXBx0
         0yq8n/x83JMxtIhzm8p9+jEyRDry0OyaWaJ5iI4s9DVIdNkq8IpRfZmDv6ymK6eRzxQv
         El0ua/GK90mh7LnLOCP7dT9SmDhwbTGDRwx8wWr8+SIBI+InKsEua+cA7+IaBQmH/QFg
         jGJn3sxKgs24d4/PRGQT9f9vi2grmLKta+vRs9KWHxNvSv3XrIXZV/34kbdfDg3UBcUR
         5Adw==
X-Gm-Message-State: AOJu0YzTCt33AYAPp2ry1QzU0OyMUwiyCRfEvKNO2EqDT6AGhXCscGE1
	FF8MP9m/hU7tUTdZTQptQL+FT9a5iRrqOmXRMTBwE/5vg8RiT5LslHGTEzzgR46UjTb2ZdYLUMA
	Q5FhC8qoHBkXEsnR8cODezFYt6+sE0V4nNol/Yw==
X-Google-Smtp-Source: AGHT+IHvMqD1LwYXdzTlIAKLDmhs1tSJtpTWrw6GwziCsQQL0orKx5LBz1QjvxCzmyjwzsSJX9CRBak/RPKOCzH0CG8=
X-Received: by 2002:a05:6902:2d08:b0:dff:2ce8:cc1b with SMTP id
 3f1490d57ef6-e1a7a17a74bmr18910308276.35.1725455239383; Wed, 04 Sep 2024
 06:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902105803.2885544-1-jens.wiklander@linaro.org>
In-Reply-To: <20240902105803.2885544-1-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Sep 2024 15:06:43 +0200
Message-ID: <CAPDyKFoUW53m_KMnVfFGNnz8DKQ2J=k10+XH=RdmDTtBgu_hkw@mail.gmail.com>
Subject: Re: [PATCH v2] rpmb: fix error path in rpmb_dev_register()
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 12:58, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Until this patch was rpmb_dev_register() always freeing rdev in the
> error path. However, past device_register() it must not do that since
> the memory is now managed by the device even if it failed to register
> properly. So fix this by doing a device_put() before returning the error

/s/device_put/put_device

> code.
>
> Fixes the smatch warning:
>         drivers/misc/rpmb-core.c:204 rpmb_dev_register()
>         warn: freeing device managed memory (leak): 'rdev'
>
> Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

With the above small amendment, applied to my mmc tree for next, thanks!

Kind regards
Uffe

> ---
> Changes in v2:
> - Remove the now unused err_id_remove label in rpmb_dev_register(),
>   reported by the kernel test robot
> ---
>  drivers/misc/rpmb-core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> index c8888267c222..bc68cde1a8bf 100644
> --- a/drivers/misc/rpmb-core.c
> +++ b/drivers/misc/rpmb-core.c
> @@ -187,17 +187,15 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
>         rdev->dev.parent = dev;
>
>         ret = device_register(&rdev->dev);
> -       if (ret)
> -               goto err_id_remove;
> +       if (ret) {
> +               put_device(&rdev->dev);
> +               return ERR_PTR(ret);
> +       }
>
>         dev_dbg(&rdev->dev, "registered device\n");
>
>         return rdev;
>
> -err_id_remove:
> -       mutex_lock(&rpmb_mutex);
> -       ida_simple_remove(&rpmb_ida, rdev->id);
> -       mutex_unlock(&rpmb_mutex);
>  err_free_dev_id:
>         kfree(rdev->descr.dev_id);
>  err_free_rdev:
> --
> 2.34.1
>

