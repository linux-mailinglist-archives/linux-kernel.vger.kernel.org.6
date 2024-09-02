Return-Path: <linux-kernel+bounces-311770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2B968D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281EC1C2120B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2540819CC0B;
	Mon,  2 Sep 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="m6f7viYR"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90965680
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301381; cv=none; b=MEY138PBdYXyKmqZN+C1F+9CfBxevq88UST7Dfb2BX7SxtPIK9zJWxFy02E+Sa6yUpQu8pg0RYmssFvp1XiX2BLJx0RKRO8CGZqdTBmyGRqBxkcYvTAFq66Lvpbk9rpBBAS1LBq6qaUYWFs/4Qi262dnSDHrWUGziEBlrbgLP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301381; c=relaxed/simple;
	bh=04wvQ4AZYQ7zy0JjEYXU06FGmNxfOwFZ8NnHJdRFIQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7w2cArITiZYGUczD2ib4nIgfSXxddyQ1bXCdDAGsKGllQK8Q8lZx0IGB/qH+Uh55lB1sJSiidLuZvG0mDnfDh98WsSkBuje3Mbu43+C+Kj9RJw6mpUP+d4eCtevJUGi9UoYBJRTXv0Yh29t20SEgLVc76sNTr90nVP/RhP5rCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=m6f7viYR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1a7f1597bbso2178705276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1725301379; x=1725906179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9mM7EuXxTiEjeCHAHh7jAITe46X027w52xJShQf4f90=;
        b=m6f7viYR8ZmBhNTmnttzmL+zWWq3OYvphNwzMW2mKMShlBtgqo6HXckWUvyBXI8Y6H
         6iEVjp57uq10i9GYThzOoVGBe1VpwkdOMZBZ3EmIBrEm1aGw0FJ/RR3uGDH3becU+Sd/
         +2dqT771nFOdYm9h5LNMvY0EpxrX7MIRBVJ1/Ylxh6cLJoL4fbXtiTPeqbgpHogiO1B7
         /sHe5yI4pcVDcGdyKvB8igprvNdamhvCepOxDvkGLwi5TOYM8CHdFE3egBWRNolj0Oq4
         L2AFLBG5r20ZBWxF16lo5MfMZ/jEpQ7+yR06CEGmEFl5gXnKxHROVcGXgJs1SlFjgKS9
         x9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725301379; x=1725906179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mM7EuXxTiEjeCHAHh7jAITe46X027w52xJShQf4f90=;
        b=Izd2C/RVIYA/6/deGSS08jGWVIvx12a0M/fmpqgUUuUYfrK6ttbBfhUVCi8lKtf0d7
         DWXZp5BlUAxaCvCxqLkly/sFrPBiUD7bhb5crh1cDtvD0gImgn3WWEO6js71w7qaW+MB
         sslT1ZAP4GWflTfwLXSf7C3RBMsSBGZLaj4MrBjkL3MCJdlKPw/UQG6PHSHbUIHCT1cJ
         r6NlERuG0rybKWZExDXJe1rIjN/dUkxnlQ7QqrcD+SrQuMaEBzfhmRhnPGli0iuXdRF5
         y/t8yGrUeFW85vgXGWyEYHThSFwvtc/Bjf9Wz3iluFJqmrywVSTkAIi7HJG5c+3iys12
         MlNA==
X-Forwarded-Encrypted: i=1; AJvYcCUJAemSIV2Q7W0VPfD4lGNlyLTo3azbBhzBih64XeDVIl9TYf86k+3qc7/BsgdKa3oMD+aGDkGFoqOfXc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAjYwVgsd/LFac1fVFOKvmJNnLtETN/kujn97uZukziaNHNLs
	z5P9X292+EzRnnmWDVQ6FKsEFT7qcUoW+Wm6bduLV0I2+IoY8qbBELfYlLBDRcIYGwk3uNPLdgF
	/s2kG5BbKpT22R1YxhMvr1rR5RIfZ1veTTIqUaQ==
X-Google-Smtp-Source: AGHT+IGEFVjdUttjCxtgN/4YwFVYH8BLBCCzpnDhN+TVamcHVBhGYiwDrWnziqXXLjiYQiuUzQW6YbkCzOAG0AQ5dqg=
X-Received: by 2002:a05:6902:1b89:b0:e0b:ecb9:2094 with SMTP id
 3f1490d57ef6-e1a7a055915mr9923848276.12.1725301378889; Mon, 02 Sep 2024
 11:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-imx290-avail-v3-0-b32a12799fed@skidata.com> <20240902-imx290-avail-v3-6-b32a12799fed@skidata.com>
In-Reply-To: <20240902-imx290-avail-v3-6-b32a12799fed@skidata.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 2 Sep 2024 19:22:43 +0100
Message-ID: <CAPY8ntCCCpjohup5Aqrrt6mRXpBukKUFnQWkuwKJ=xJCW=PDog@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] media: i2c: imx290: Check for availability in probe()
To: bbara93@gmail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"

Hi Benjamin

On Mon, 2 Sept 2024 at 16:58, <bbara93@gmail.com> wrote:
>
> From: Benjamin Bara <benjamin.bara@skidata.com>
>
> Currently, the V4L2 subdevice is also created when the device is not
> available/connected. From userspace perspective, there is no visible
> difference between a working and not-working subdevice (except when
> trying it out).
>
> This commit adds a simple availability check before starting with the
> subdev initialization to error out instead.
>
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> Changes since v2:
> - the new 1/8 is split out
> - use dev_err_probe() (thx Laurent)
> ---
>  drivers/media/i2c/imx290.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 9610e9fd2059..6b292bbb0856 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -1571,6 +1571,7 @@ static int imx290_probe(struct i2c_client *client)
>  {
>         struct device *dev = &client->dev;
>         struct imx290 *imx290;
> +       u64 val;
>         int ret;
>
>         imx290 = devm_kzalloc(dev, sizeof(*imx290), GFP_KERNEL);
> @@ -1631,6 +1632,17 @@ static int imx290_probe(struct i2c_client *client)
>         pm_runtime_set_autosuspend_delay(dev, 1000);
>         pm_runtime_use_autosuspend(dev);
>
> +       /* Make sure the sensor is available before V4L2 subdev init. */
> +       ret = cci_read(imx290->regmap, IMX290_STANDBY, &val, NULL);
> +       if (ret) {
> +               ret = dev_err_probe(dev, -ENODEV, "Failed to detect sensor\n");
> +               goto err_pm;
> +       }
> +       if (val != IMX290_STANDBY_STANDBY) {

As Laurent commented on v2, this is a slightly unsafe check. If the
device isn't controlled via a regulator then there's no guarantee that
the sensor will be in standby.
The cci_read call will already have returned an error if the sensor
isn't present which will be 99.999% of the error cases.

If you want to catch the case where it's not in standby, why not put
it into standby as a recovery mechanism. It'd be a better user
experience than just bombing out of the probe.

  Dave

> +               ret = dev_err_probe(dev, -ENODEV, "Sensor is not in standby\n");
> +               goto err_pm;
> +       }
> +
>         /* Initialize the V4L2 subdev. */
>         ret = imx290_subdev_init(imx290);
>         if (ret)
>
> --
> 2.46.0
>
>

