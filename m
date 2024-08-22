Return-Path: <linux-kernel+bounces-296612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF2D95ACC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C0F283E46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42524CE05;
	Thu, 22 Aug 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mk5QC/Nx"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27C134A8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724303531; cv=none; b=KWjOTCxs3dRqjbRfSoq2Plc9Am9djOgfgWx8BbdPN0Aua72NLcPr2/T0zuZXA1SmyHdHSZImjOlEqvOiit1B///XxFiImNRz7rI7Ew741rlsklh+zoLzASDgf8m9qwjL4/Ms4m6JTOrhlmsQCTYj35tNm5i4h3wcRY70pKmi1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724303531; c=relaxed/simple;
	bh=M1SZgw4DFujc0wbsSJr0giJJPNvF9UEkZx+8mzZwYfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tg/aV+5hwoZK8eEDsReQXaJP+xwIK0OmFoNAK0pZfuUHiNJlmuq6tPk9eTetmYeiRVN0ZsBR+cgHTnGs2n3s/MQGFS0McGr7cDaCw+pY2WVo5CzQ8o3oYzdCiDl8JAAqwAPBEhAcL8mosARNSJtfeTBJST4i2pMl3mYx9uExXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mk5QC/Nx; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-842f95d3501so258974241.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724303528; x=1724908328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2AfdT/qUVnYEmVWqwh27YziwYiSG6ZtaTZWiB/2UCU=;
        b=mk5QC/Nxa5K/zPEE/WNJApi1b7NEI43/fdtvfSqWaL+8eD+fq+WB2e0y+Lgu1XUvZG
         ajecKYXkNTsn56OXqqneJmSy9SpZLI78EGSnPSREIgpjQMD6ti5jRvqaA7FV33gojQwF
         dE+0COvwUyAe5ZnBnxn53GtyyIFO5Axv2A0FdJzVLLEesSfmuTZKf2P6uh2cdBIUht8u
         DB3OHxQ9X2RP91KvJ788ML+McV4rMM9QyWLwzWlbDh0G14UBJuf37MyvbidTDoHacrVt
         TIsPmEnjBP+Ujaji5xv3MYLduRYHVh9qlFsxu6lyPAtr8hw4v89P3wq/kgWqOWo8rqSH
         kzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724303528; x=1724908328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2AfdT/qUVnYEmVWqwh27YziwYiSG6ZtaTZWiB/2UCU=;
        b=HcZ0d/G9Eow9kJWEA4GUwQtBzQc/fFplrrSY77x2x6JpSJsAq1omPDhEvl7jhw+qX4
         O+JxyzXdTh+G2g9bW8urJnFyiA8XEaihiAiPuEtDz4izZFhhvYGp9e3WRTCIGXdfcZ37
         c14FPxCsxW5GH3X0r0qtUUXbQOlzxT7hwUUb3i3BPuFqIyggVTeGqcFxEjc0JntqNawn
         Qh+prHlgsoOUiX29BBN0IxllbNveZYOgmg1o6Fir9m5ldA37aBjZ5aZWLn3aDYpcOlqB
         v9cI/wPLs/cThdzWAnrapgZyLcRrCjtT+MXk/y4HYRhAgp5GNO51+xMzcNpnshKV98T0
         4VaA==
X-Gm-Message-State: AOJu0YyR1qyGC9qFsYahpvgJM4iMUS9DgMW1rvWZEmXnnNnOIX6GI6Ys
	4d0CK2bhQ9031qqN6uMBb7FxVqtOqlqkzSSzAGbPo5RFtDpC+chgllOSY4k/i8x0WlhzrXoNA7P
	xJmKc2ljd5hklyjM+w/hqctmKGIWx9rQPE5Arzg==
X-Google-Smtp-Source: AGHT+IE/xWmCfL8EynZ8t+uIxYk/r+mrN6h/hspk9c8WP9FVtEPbRdI2QkUqEKvc3cosufaBc/oafG+hBaPdR/iFgvA=
X-Received: by 2002:a05:6102:dce:b0:495:c34d:ab5d with SMTP id
 ada2fe7eead31-498e22d94c7mr984589137.13.1724303527859; Wed, 21 Aug 2024
 22:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org> <20240814153558.708365-4-jens.wiklander@linaro.org>
In-Reply-To: <20240814153558.708365-4-jens.wiklander@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 22 Aug 2024 10:41:56 +0530
Message-ID: <CAFA6WYM4qmfitWdVUtJoyyeV1S2mTAA4KGZ87tUhf6prMts+2w@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: add tee_device_set_dev_groups()
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 21:06, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
> attribute groups. The class specific attributes are from now on added
> via the tee_class, which currently only consist of implementation_id.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c   | 19 +++++++++++++------
>  include/linux/tee_core.h | 12 ++++++++++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d52e879b204e..d113679b1e2d 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -40,10 +40,7 @@ static const uuid_t tee_client_uuid_ns = UUID_INIT(0x58ac9ca0, 0x2086, 0x4683,
>  static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
>  static DEFINE_SPINLOCK(driver_lock);
>
> -static const struct class tee_class = {
> -       .name = "tee",
> -};
> -
> +static const struct class tee_class;
>  static dev_t tee_devt;
>
>  struct tee_context *teedev_open(struct tee_device *teedev)
> @@ -965,6 +962,13 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>  }
>  EXPORT_SYMBOL_GPL(tee_device_alloc);
>
> +void tee_device_set_dev_groups(struct tee_device *teedev,
> +                              const struct attribute_group **dev_groups)
> +{
> +       teedev->dev.groups = dev_groups;
> +}
> +EXPORT_SYMBOL_GPL(tee_device_set_dev_groups);
> +
>  static ssize_t implementation_id_show(struct device *dev,
>                                       struct device_attribute *attr, char *buf)
>  {
> @@ -983,6 +987,11 @@ static struct attribute *tee_dev_attrs[] = {
>
>  ATTRIBUTE_GROUPS(tee_dev);
>
> +static const struct class tee_class = {
> +       .name = "tee",
> +       .dev_groups = tee_dev_groups,
> +};
> +
>  /**
>   * tee_device_register() - Registers a TEE device
>   * @teedev:    Device to register
> @@ -1001,8 +1010,6 @@ int tee_device_register(struct tee_device *teedev)
>                 return -EINVAL;
>         }
>
> -       teedev->dev.groups = tee_dev_groups;
> -
>         rc = cdev_device_add(&teedev->cdev, &teedev->dev);
>         if (rc) {
>                 dev_err(&teedev->dev,
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index efd16ed52315..a38494d6b5f4 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -154,6 +154,18 @@ int tee_device_register(struct tee_device *teedev);
>   */
>  void tee_device_unregister(struct tee_device *teedev);
>
> +/**
> + * tee_device_set_dev_groups() - Set device attribute groups
> + * @teedev:    Device to register
> + * @dev_groups: Attribute groups
> + *
> + * Assigns the provided @dev_groups to the @teedev to be registered later
> + * with tee_device_register(). Calling this function is optional, but if
> + * it's called it must be called before tee_device_register().
> + */
> +void tee_device_set_dev_groups(struct tee_device *teedev,
> +                              const struct attribute_group **dev_groups);
> +
>  /**
>   * tee_session_calc_client_uuid() - Calculates client UUID for session
>   * @uuid:              Resulting UUID
> --
> 2.34.1
>

