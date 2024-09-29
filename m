Return-Path: <linux-kernel+bounces-342795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D7989310
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2881F22F97
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453D3BBCB;
	Sun, 29 Sep 2024 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqe0AsNO"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42422746C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585316; cv=none; b=e521qk3jSgHyngcYL5ICFVRQjdEsRCOMHe3NPRj61bwDDuWFXM5Li5LWL7CTyciwzTtL4i+AmAUYkfXKOmiJPiry8n1G0d5xpyU0w5k3OhLLlr6oJA8Od8zvjOkgbOa/W1ghRxKxck0S4fC4ZgiAQm6RBSsK7NcAT2snrw7MmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585316; c=relaxed/simple;
	bh=suYtdGMrf8gXS9Lg1zozJYPSn11TWqtqHu72IHOg2hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si42qbRG8aSXGYI5Fyt4RYtQwyWuDmM/2sUB9lZzwNEf67Fe44/kYtQwRaJdwbGyIG4KagrA0jDAXwFO2cOAEMnZUO9Eym30TdxlbMhUDrAzYicpGexCrAoL6Cncuq2ZIMRrUgs/0e2zz2PyqlQEllxUsAO4RU9ILgqLQ7BkeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqe0AsNO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so1986907a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727585314; x=1728190114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWrD7X/oPMrBV4weUIcS2c9sSIBuVmfEZgNzrgvH6AU=;
        b=hqe0AsNOlvXWt6l0K8HD0Qu3qh8cBYpWhn9a+U2nNBBDe7aJ46gNHUNtNqfDBMPjtz
         jiZfX1Y9T+eHMhQKQ2zHOqsBpaSyytQ+ryovscOgmw+fdLVJ4eo+kbjrfcZDUEmlvvTG
         qkyQzIRRSOpftsBf6L3aLnJQANAuMqHT9ANFLx/TeTEl1qL/MQiKzAdJjTx/lyWtrqgV
         ghGR+ix9IvNRv7KihyDPcMY0zuWW5RGAHkGLpZX9UhkDFY0UuwANYskZaHwnnrUuoD/6
         tb9KUUpR4tHojIfgMLhZZcvsiH01TMR4JgiYF2cebswmVZsUDD8xA2ANXR7duzYgQo/z
         In+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585314; x=1728190114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWrD7X/oPMrBV4weUIcS2c9sSIBuVmfEZgNzrgvH6AU=;
        b=c8vCX3IzMEFVXz/mPsmjg2XHOMOCGrDuJjsSH0wXSlXsj8owtoUqyTXXLlhB52rlUX
         C7wsttjXCsCQOqJibiUCasixH3AxR7PrQk9cipFYN2ZwuykXah5CCJ6kNaVdjL8ugFye
         TgHougqW/sudlvJmYngGK/oe/8dmzvRatBPBwE8IMGsYaf6nJJDv32Zo3rysiyqAxrXp
         PcxJE9wXgL2p2DQERWR+fIVPWjsGWqr3EWEmWNdkLdB9ts+U9wy18MlJ5qOhknoDRBya
         M0Ixv3IhS8QfMBGpp/2Dt0WZAfpZeGUeO64iSRGkSxMhxY2MWdBmfOW07AK4cekYAycX
         fTZA==
X-Gm-Message-State: AOJu0Yxo418OMgU3hyDs9ZPUtbDmsya5PgCGFHNZhYfhcSv9Dbu/BBhk
	CaXoIRWHBccA/piMi74r9X8qB/QLEQMYLqY+MtnmaMSkMkFZC0lE4KNbOa+m
X-Google-Smtp-Source: AGHT+IFy/e26TBCwFmk+gzvB+a8vG++Als6ioPWI4et3ZTR76n7seW8EyK2QEAHFJ/rMFtk9dq521Q==
X-Received: by 2002:a17:90b:118b:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2e0b8e8b856mr9080218a91.28.1727585313694;
        Sat, 28 Sep 2024 21:48:33 -0700 (PDT)
Received: from rigel (14-202-6-222.static.tpgi.com.au. [14.202.6.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06ccf0505sm8636950a91.0.2024.09.28.21.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 21:48:33 -0700 (PDT)
Date: Sun, 29 Sep 2024 12:48:28 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v5 8/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <20240929044828.GA21440@rigel>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <657876d1321467a2b23060ac15924aed8c423390.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <657876d1321467a2b23060ac15924aed8c423390.1726819463.git.u.kleine-koenig@baylibre.com>

On Fri, Sep 20, 2024 at 10:58:04AM +0200, Uwe Kleine-König wrote:
> With this change each pwmchip defining the new-style waveform callbacks
> can be accessed from userspace via a character device. Compared to the
> sysfs-API this is faster (on a stm32mp157 applying a new configuration
> takes approx 25% only) and allows to pass the whole configuration in a
> single ioctl allowing atomic application.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/core.c       | 291 +++++++++++++++++++++++++++++++++++++--
>  include/linux/pwm.h      |   3 +
>  include/uapi/linux/pwm.h |  32 +++++
>  3 files changed, 311 insertions(+), 15 deletions(-)
>  create mode 100644 include/uapi/linux/pwm.h
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ed620e35db61..3c25e0ac682c 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -23,6 +23,8 @@
>
>  #include <dt-bindings/pwm/pwm.h>
>
> +#include <uapi/linux/pwm.h>
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/pwm.h>
>
> @@ -1915,20 +1917,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  }
>  EXPORT_SYMBOL_GPL(pwm_get);
>
> -/**
> - * pwm_put() - release a PWM device
> - * @pwm: PWM device
> - */
> -void pwm_put(struct pwm_device *pwm)
> +static void __pwm_put(struct pwm_device *pwm)
>  {
> -	struct pwm_chip *chip;
> -
> -	if (!pwm)
> -		return;
> -
> -	chip = pwm->chip;
> -
> -	guard(mutex)(&pwm_lock);
> +	struct pwm_chip *chip = pwm->chip;
>
>  	/*
>  	 * Trigger a warning if a consumer called pwm_put() twice.
> @@ -1949,6 +1940,20 @@ void pwm_put(struct pwm_device *pwm)
>
>  	module_put(chip->owner);
>  }
> +
> +/**
> + * pwm_put() - release a PWM device
> + * @pwm: PWM device
> + */
> +void pwm_put(struct pwm_device *pwm)
> +{
> +	if (!pwm)
> +		return;
> +
> +	guard(mutex)(&pwm_lock);
> +
> +	__pwm_put(pwm);
> +}
>  EXPORT_SYMBOL_GPL(pwm_put);
>
>  static void devm_pwm_release(void *pwm)
> @@ -2018,6 +2023,249 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
>
> +struct pwm_cdev_data {
> +	struct pwm_chip *chip;
> +	struct pwm_device *pwm[];
> +};
> +
> +static int pwm_cdev_open(struct inode *inode, struct file *file)
> +{
> +	struct pwm_chip *chip = container_of(inode->i_cdev, struct pwm_chip, cdev);
> +	struct pwm_cdev_data *cdata;
> +
> +	guard(mutex)(&pwm_lock);
> +
> +	if (!chip->operational)
> +		return -ENXIO;
> +
> +	cdata = kzalloc(struct_size(cdata, pwm, chip->npwm), GFP_KERNEL);
> +	if (!cdata)
> +		return -ENOMEM;
> +
> +	cdata->chip = chip;
> +
> +	file->private_data = cdata;
> +
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int pwm_cdev_release(struct inode *inode, struct file *file)
> +{
> +	struct pwm_cdev_data *cdata = file->private_data;
> +	unsigned int i;
> +
> +	for (i = 0; i < cdata->chip->npwm; ++i) {
> +		if (cdata->pwm[i])
> +			pwm_put(cdata->pwm[i]);
> +	}
> +	kfree(cdata);
> +
> +	return 0;
> +}
> +
> +static int pwm_cdev_request(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> +{
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	if (hwpwm >= chip->npwm)
> +		return -EINVAL;
> +
> +	if (!cdata->pwm[hwpwm]) {
> +		struct pwm_device *pwm = &chip->pwms[hwpwm];
> +		int ret;
> +
> +		ret = pwm_device_request(pwm, "pwm-cdev");
> +		if (ret < 0)
> +			return ret;
> +
> +		cdata->pwm[hwpwm] = pwm;
> +	}
> +
> +	return 0;
> +}
> +

Allow the user to specify the consumer label as part of the request rather
than hard coding it to "pwm-cdev"?

> +static int pwm_cdev_free(struct pwm_cdev_data *cdata, unsigned int hwpwm)
> +{
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	if (hwpwm >= chip->npwm)
> +		return -EINVAL;
> +
> +	if (cdata->pwm[hwpwm]) {
> +		struct pwm_device *pwm = cdata->pwm[hwpwm];
> +
> +		__pwm_put(pwm);
> +
> +		cdata->pwm[hwpwm] = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pwm_device *pwm_cdev_get_requested_pwm(struct pwm_cdev_data *cdata,
> +						     u32 hwpwm)
> +{
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	if (hwpwm >= chip->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (cdata->pwm[hwpwm])
> +		return cdata->pwm[hwpwm];
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	int ret = 0;
> +	struct pwm_cdev_data *cdata = file->private_data;
> +	struct pwm_chip *chip = cdata->chip;
> +
> +	guard(mutex)(&pwm_lock);
> +

Coarse grain locking of the whole of pwm for the duration, where some
calls my sleep, feels excessive. Is it really necessary for all of the
ioctls?

> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	switch (cmd) {
> +	case PWM_IOCTL_REQUEST:
> +		{
> +			unsigned int hwpwm = arg;
> +
> +			return pwm_cdev_request(cdata, hwpwm);
> +		}
> +		break;
> +
> +	case PWM_IOCTL_FREE:
> +		{
> +			unsigned int hwpwm = arg;
> +
> +			return pwm_cdev_free(cdata, hwpwm);
> +		}
> +		break;
> +
> +	case PWM_IOCTL_ROUNDWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf,
> +					     (struct pwmchip_waveform __user *)arg,
> +					     sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.__pad != 0)
> +				return -EINVAL;
> +
> +			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
> +			if (IS_ERR(pwm))
> +				return PTR_ERR(pwm);
> +
> +			wf = (struct pwm_waveform) {
> +				.period_length_ns = cwf.period_length_ns,
> +				.duty_length_ns = cwf.duty_length_ns,
> +				.duty_offset_ns = cwf.duty_offset_ns,
> +			};
> +
> +			ret = pwm_round_waveform_might_sleep(pwm, &wf);
> +			if (ret)
> +				return ret;
> +
> +			cwf = (struct pwmchip_waveform) {
> +				.hwpwm = cwf.hwpwm,
> +				.period_length_ns = wf.period_length_ns,
> +				.duty_length_ns = wf.duty_length_ns,
> +				.duty_offset_ns = wf.duty_offset_ns,
> +			};
> +
> +			return copy_to_user((struct pwmchip_waveform __user *)arg,
> +					    &cwf, sizeof(cwf));
> +		}
> +		break;
> +
> +	case PWM_IOCTL_GETWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf,
> +					     (struct pwmchip_waveform __user *)arg,
> +					     sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.__pad != 0)
> +				return -EINVAL;
> +
> +			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
> +			if (IS_ERR(pwm))
> +				return PTR_ERR(pwm);
> +
> +			ret = pwm_get_waveform_might_sleep(pwm, &wf);
> +			if (ret)
> +				return ret;
> +
> +			cwf.period_length_ns = wf.period_length_ns;
> +			cwf.duty_length_ns = wf.duty_length_ns;
> +			cwf.duty_offset_ns = wf.duty_offset_ns;
> +
> +			return copy_to_user((struct pwmchip_waveform __user *)arg,
> +					    &cwf, sizeof(cwf));
> +		}
> +		break;
> +
> +	case PWM_IOCTL_SETROUNDEDWF:
> +	case PWM_IOCTL_SETEXACTWF:
> +		{
> +			struct pwmchip_waveform cwf;
> +			struct pwm_waveform wf;
> +			struct pwm_device *pwm;
> +
> +			ret = copy_from_user(&cwf,
> +					     (struct pwmchip_waveform __user *)arg,
> +					     sizeof(cwf));
> +			if (ret)
> +				return -EFAULT;
> +
> +			if (cwf.__pad != 0)
> +				return -EINVAL;
> +
> +			wf = (struct pwm_waveform){
> +				.period_length_ns = cwf.period_length_ns,
> +				.duty_length_ns = cwf.duty_length_ns,
> +				.duty_offset_ns = cwf.duty_offset_ns,
> +			};
> +
> +			if (!pwm_wf_valid(&wf))
> +				return -EINVAL;
> +
> +			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
> +			if (IS_ERR(pwm))
> +				return PTR_ERR(pwm);
> +
> +			return pwm_set_waveform_might_sleep(pwm, &wf,
> +							    cmd == PWM_IOCTL_SETEXACTWF);
> +		}
> +		break;
> +
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static const struct file_operations pwm_cdev_fileops = {
> +	.open = pwm_cdev_open,
> +	.release = pwm_cdev_release,
> +	.owner = THIS_MODULE,
> +	.llseek = no_llseek,
> +	.unlocked_ioctl = pwm_cdev_ioctl,
> +};
> +
> +static dev_t pwm_devt;
> +
>  /**
>   * __pwmchip_add() - register a new PWM chip
>   * @chip: the PWM chip to add
> @@ -2070,7 +2318,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>  	scoped_guard(pwmchip, chip)
>  		chip->operational = true;
>
> -	ret = device_add(&chip->dev);
> +	if (chip->id < 256 && chip->ops->write_waveform)
> +		chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);
> +
> +	cdev_init(&chip->cdev, &pwm_cdev_fileops);
> +	chip->cdev.owner = owner;
> +
> +	ret = cdev_device_add(&chip->cdev, &chip->dev);
>  	if (ret)
>  		goto err_device_add;
>
> @@ -2121,7 +2375,7 @@ void pwmchip_remove(struct pwm_chip *chip)
>  		idr_remove(&pwm_chips, chip->id);
>  	}
>
> -	device_del(&chip->dev);
> +	cdev_device_del(&chip->cdev, &chip->dev);
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_remove);
>
> @@ -2262,9 +2516,16 @@ static int __init pwm_init(void)
>  {
>  	int ret;
>
> +	ret = alloc_chrdev_region(&pwm_devt, 0, 256, "pwm");
> +	if (ret) {
> +		pr_warn("Failed to initialize chrdev region for PWM usage\n");
> +		return ret;
> +	}
> +
>  	ret = class_register(&pwm_class);
>  	if (ret) {
>  		pr_err("Failed to initialize PWM class (%pe)\n", ERR_PTR(ret));
> +		unregister_chrdev_region(pwm_devt, 256);
>  		return ret;
>  	}
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index c3d9ddeafa65..f43dbfaef1a1 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_PWM_H
>  #define __LINUX_PWM_H
>
> +#include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> @@ -304,6 +305,7 @@ struct pwm_ops {
>  /**
>   * struct pwm_chip - abstract a PWM controller
>   * @dev: device providing the PWMs
> + * @cdev: &struct cdev for this device
>   * @ops: callbacks for this PWM controller
>   * @owner: module providing this chip
>   * @id: unique number of this PWM chip
> @@ -318,6 +320,7 @@ struct pwm_ops {
>   */
>  struct pwm_chip {
>  	struct device dev;
> +	struct cdev cdev;
>  	const struct pwm_ops *ops;
>  	struct module *owner;
>  	unsigned int id;
> diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
> new file mode 100644
> index 000000000000..0a9cdaa0fe37
> --- /dev/null
> +++ b/include/uapi/linux/pwm.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_PWM_H_
> +#define _UAPI_PWM_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct pwmchip_waveform - Describe a PWM waveform for a pwm_chip's PWM channel
> + * @hwpwm: per-chip relative index of the PWM device
> + * @__pad: padding, must be zero
> + * @period_length_ns: duration of the repeating period
> + * @duty_length_ns: duration of the active part in each period
> + * @duty_offset_ns: offset of the rising edge from a period's start
> + */

While you have added some documentation, this is still lacking compared
to the corresponding in include/linux/pwm.h.  e.g. zeroing
period_length_ns to disable a PWM...

> +struct pwmchip_waveform {
> +	__u32 hwpwm;
> +	__u32 __pad;
> +	__u64 period_length_ns;
> +	__u64 duty_length_ns;
> +	__u64 duty_offset_ns;
> +};
> +
> +#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
> +#define PWM_IOCTL_FREE		_IO(0x75, 2)
> +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
> +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> +

A brief description of the ioctls and their semantics would be handy,
either here or as full blown documentation in
linux/Documentation/userspace-api/pwm/...

PWMs are automatically released when the pwmchip file is closed?
And the state of the PWM line after release (or _FREE) is indeterminate?

Is it possible that the underlying PWM chip be removed while the user has
the pwmchip open and/or has pwm devices requested?

Provide some ioctls to aid discoverability, e.g. for pwm chips exposing the
npwms, module name.  For pwm devices the label, if the PWM is requested and
the consumer's label (similar to the GPIO chipinfo and lineinfo)?
Unless that information otherwise exposed to userspace?

Cheers,
Kent.


