Return-Path: <linux-kernel+bounces-513974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341EAA350E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FB77A31FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9CD2698A7;
	Thu, 13 Feb 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbtQrp8m"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FC269839
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484298; cv=none; b=YYf18OSHhx8Zda9fCP63GgBYrmv1X8wNsC1FnNJPjSlH1RtFcRn6aq75XC6F1tA5+NKpMN7bNRoq5MkDHJrMGyRfXAvA4qiqZBnnVbwwc7lLy8UyP1ylk0T2vsRT7BHEkUwy0jjbgeM8Z5BmAEHN4EkCsp096peypqQC/74YXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484298; c=relaxed/simple;
	bh=8yAMqL0L6BD7uVErtuAjmRBz3/oIM31YGuqXSiMObR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/G+II4PH5BqtqnOrNIVlj30mfYMSJXhW7PAYYd1ywD66uJ1koJqqS5VW5dIE5j0avJiVxHYOaMiAF6t83aB6jXGcsW4tLAL0wiFE364yy+wIMDvOLpbLqlIOAF7dIEHaite3vRSWJN/9ZY4vxbl47haL9fri0SV9sqOiIys6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kbtQrp8m; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5450cf3ef63so1445900e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739484294; x=1740089094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+QFpNrmD21zq76Z6YLs3X2SVk3vG63A4LruZcgFYZE=;
        b=kbtQrp8mg4aJkl++T/nIu32leQ33eIXBnAvkCGzl7AU/UFneG3vsy9KF9vb1fp08s7
         XzYAJfT54sHz2v/ds+sKb8EV+rKVuMHHsghC/xGOlHc9Nq7wCzzQjce+/MsmR1g+3Gzu
         LEa/XWizWUkVls9hjhuV0fNcseTuKilX5cANwuLUt5+SCKoh1+IIlHMFfAhYXOoiSqUA
         GtCVzCSAHDPMOYKI37gIFX3+81kpCauZTcgY5xK6EQdYpHYMgpZvzMb/dhnnexpAilrz
         LnA3VI3pGTxYxVzlKaPyZSUKONaZyS6yngYDNqQZ8V/S3xhMwKsK3M2qOi7T8VfPFKR8
         t6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484294; x=1740089094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+QFpNrmD21zq76Z6YLs3X2SVk3vG63A4LruZcgFYZE=;
        b=RPwZAv1A5neHajtyHDtoL+cyIr64XwROkKna/dWWOGrSPvsqAisuPR7fhSktNyqinZ
         ZVwFnycRSJq4Jbl0ZPuVXAV5JMFgZ2hYWM7if1uwm+d4d9YA1wJ9aaLiPDX8gTKsM9jh
         ybWPPbBRoVNjVIRD6RaZ4xenOG/14fk2tKtsVedyXkoi/xT75OqcfIFjKPT4LZS1nmv7
         fA7FDJjtp//eXkNh32uQN2t29UigMFX2ox9+0khnchOYKox0yrwWV9Mo8XlEVMn6oePx
         8N5QZ63R2lmHT4q0VAYVfh4hHNNDYxF8n4r8pOHNgYlvuoEZzVPw97hf/21MJtTIYbTK
         rOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0oU02m0pvQx6AZKzopcd9v9pgjC5wLPA6zY9oXMCU39XJ084ZznkrkI6N6Th3ixbKPidtkttTyN6Kdzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOAuYh1KIDeC7F7AbNAQ6PlTRBJfjVeObvt3KJwoehMqz5K8C
	Yv90KUvPdwzXKq3sbKwTuVOY90746jQpGWhOnPXlbi9Uk3gPOZ1pdb5SJSPb69E=
X-Gm-Gg: ASbGncvvOJHP0hlAJrfsvjKAbFxaIld82++a41/p5Lll9AsonKJ1uo3WMv1x1tft1z3
	F887jVe+m7c9Rv+OYfST0ESPiBrNcO65vJfxbDdNZbuwCA5fKzp8TFHeat8NXFPHvpLsv9dz43a
	GYGCNXJJI2QYB/HN8BZHngzgzx5dOtClZeuEr91qkUpDJNC87vFm8psSNQrKGdIhp9FHap2DtfY
	/qp64KvbyHvhJkRmtatp6d/4OoEHgTmbx1Hyqb111JbrJSAdsC2sxIMnZMm0MXJFy9Mv8rPpCj3
	VA/X/Tz9FyDJpQ82ygJDk0bdSgksNUeKEIPHsZ1pDpx1XU08nft4iQqcuKVVKnkqpaM3LH0=
X-Google-Smtp-Source: AGHT+IFOsJQ/Humlfu8J95P2B+ISmf4D6Tr3+B6BkN50O9jDmOfTI9Er8NpOzVeRmXif1kCWw7g8HA==
X-Received: by 2002:a05:6512:1318:b0:545:e2e:844a with SMTP id 2adb3069b0e04-5451ddd7917mr1733274e87.38.1739484294366;
        Thu, 13 Feb 2025 14:04:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cd51sm297424e87.198.2025.02.13.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:04:53 -0800 (PST)
Date: Fri, 14 Feb 2025 00:04:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] thermal: qcom-spmi-temp-alarm: Add temp alarm data
 struct based on HW subtype
Message-ID: <rfpnkedb26mtaalwmklepn7fres6tvz356qbmu3xpgliqdtfyh@2qj2nmgcu25t>
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
 <20250213210403.3396392-3-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213210403.3396392-3-anjelique.melendez@oss.qualcomm.com>

On Thu, Feb 13, 2025 at 01:04:01PM -0800, Anjelique Melendez wrote:
> Currently multiple if/else statements are used in functions to decipher
> between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
> refactor the driver so that SPMI temp alarm chips will have reference to a
> spmi_temp_alarm_data struct which defines data and function callbacks
> based on the HW subtype.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 143 +++++++++++++-------
>  1 file changed, 95 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index b2077ff9fe73..af71d4238340 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -31,7 +31,6 @@
>  
>  #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
>  #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
> -#define STATUS_GEN2_STATE_SHIFT		4
>  
>  #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
>  #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
> @@ -68,10 +67,20 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
>  /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
>  #define DEFAULT_TEMP			37000
>  
> +struct qpnp_tm_chip;
> +
> +struct spmi_temp_alarm_data {
> +	const struct thermal_zone_device_ops *ops;
> +	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
> +	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
> +	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
> +};
> +
>  struct qpnp_tm_chip {
>  	struct regmap			*map;
>  	struct device			*dev;
>  	struct thermal_zone_device	*tz_dev;
> +	const struct spmi_temp_alarm_data *data;
>  	unsigned int			subtype;
>  	unsigned int			dig_revision;
>  	long				temp;
> @@ -82,14 +91,11 @@ struct qpnp_tm_chip {
>  	struct mutex			lock;
>  	bool				initialized;
>  	bool				require_s2_shutdown;
> +	long				temp_thresh_map[STAGE_COUNT];
>  
>  	struct iio_channel		*adc;
> -	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
>  };
>  
> -/* This array maps from GEN2 alarm state to GEN1 alarm stage */
> -static const unsigned int alarm_state_map[8] = {0, 1, 1, 2, 2, 3, 3, 3};
> -

Don't move the code / data without a need, it complicates review.

>  static int qpnp_tm_read(struct qpnp_tm_chip *chip, u16 addr, u8 *data)
>  {
>  	unsigned int val;
> @@ -118,34 +124,51 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
>   */
>  static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
>  {
> -	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
> -	    stage > STAGE_COUNT)
> +	if (stage == 0 || stage > STAGE_COUNT)
>  		return 0;
>  
> -	return (*chip->temp_map)[chip->thresh][stage - 1];
> +	return chip->temp_thresh_map[stage - 1];
>  }
>  
>  /**
>   * qpnp_tm_get_temp_stage() - return over-temperature stage
>   * @chip:		Pointer to the qpnp_tm chip
>   *
> - * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
> + * Return: stage on success, or errno on failure.
>   */
>  static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
>  {
> +	u8 reg = 0;
>  	int ret;
> +
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return FIELD_GET(STATUS_GEN1_STAGE_MASK, reg);
> +}
> +
> +/* This array maps from GEN2 alarm state to GEN1 alarm stage */
> +static const unsigned int alarm_state_map[8] = {0, 1, 1, 2, 2, 3, 3, 3};
> +
> +/**
> + * qpnp_tm_get_gen2_temp_stage() - return over-temperature stage
> + * @chip:		Pointer to the qpnp_tm chip
> + *
> + * Return: stage on success, or errno on failure.
> + */
> +static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
> +{
>  	u8 reg = 0;
> +	int ret;
>  
>  	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
> -		ret = reg & STATUS_GEN1_STAGE_MASK;
> -	else
> -		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
> +	ret = FIELD_GET(STATUS_GEN2_STATE_MASK, reg);
>  
> -	return ret;
> +	return alarm_state_map[ret];
>  }
>  
>  /*
> @@ -154,23 +177,16 @@ static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
>   */
>  static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
>  {
> -	unsigned int stage, stage_new, stage_old;
> +	unsigned int stage_new, stage_old;
>  	int ret;
>  
>  	WARN_ON(!mutex_is_locked(&chip->lock));
>  
> -	ret = qpnp_tm_get_temp_stage(chip);
> +	ret = chip->data->get_temp_stage(chip);
>  	if (ret < 0)
>  		return ret;
> -	stage = ret;
> -
> -	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
> -		stage_new = stage;
> -		stage_old = chip->stage;
> -	} else {
> -		stage_new = alarm_state_map[stage];
> -		stage_old = alarm_state_map[chip->stage];
> -	}
> +	stage_new = ret;
> +	stage_old = chip->stage;
>  
>  	if (stage_new > stage_old) {
>  		/* increasing stage, use lower bound */
> @@ -182,7 +198,7 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
>  				- TEMP_STAGE_HYSTERESIS;
>  	}
>  
> -	chip->stage = stage;
> +	chip->stage = stage_new;
>  
>  	return 0;
>  }
> @@ -222,8 +238,8 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
>  static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>  					     int temp)
>  {
> -	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
> -	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
> +	long stage2_threshold_min = (*chip->data->temp_map)[THRESH_MIN][1];
> +	long stage2_threshold_max = (*chip->data->temp_map)[THRESH_MAX][1];
>  	bool disable_s2_shutdown = false;
>  	u8 reg;
>  
> @@ -258,6 +274,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>  	}
>  
>  skip:
> +	memcpy(chip->temp_thresh_map, chip->data->temp_map[chip->thresh],
> +		sizeof(chip->temp_thresh_map));
>  	reg |= chip->thresh;
>  	if (disable_s2_shutdown && !chip->require_s2_shutdown)
>  		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
> @@ -295,6 +313,42 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
> +{
> +	int crit_temp, ret;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> +	if (ret)
> +		crit_temp = THERMAL_TEMP_INVALID;
> +
> +	mutex_lock(&chip->lock);
> +
> +	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +}
> +
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
> +	.ops = &qpnp_tm_sensor_ops,
> +	.temp_map = &temp_map_gen1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
> +	.get_temp_stage = qpnp_tm_get_temp_stage,
> +};
> +
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
> +	.ops = &qpnp_tm_sensor_ops,
> +	.temp_map = &temp_map_gen1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
> +	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
> +};
> +
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
> +	.ops = &qpnp_tm_sensor_ops,

All three data structures use &qpnp_tm_sensor_ops and
qpnp_tm_configure_trip_temp(). Plese use them directly. In case it is
necessary for the next patch, please perform this refactoring separately
with a proper explanation ("In preparation to .... peform foo and bar").

> +	.temp_map = &temp_map_gen2_v1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
> +	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
> +};
> +
>  /*
>   * This function initializes the internal temp value based on only the
>   * current thermal stage and threshold. Setup threshold control and
> @@ -305,7 +359,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  	unsigned int stage;
>  	int ret;
>  	u8 reg = 0;
> -	int crit_temp;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -316,26 +369,15 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  	chip->thresh = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
>  	chip->temp = DEFAULT_TEMP;
>  
> -	ret = qpnp_tm_get_temp_stage(chip);
> -	if (ret < 0)
> +	stage = chip->data->get_temp_stage(chip);
> +	if (stage < 0)
>  		goto out;
> -	chip->stage = ret;
> -
> -	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
> -		? chip->stage : alarm_state_map[chip->stage];
> +	chip->stage = stage;
>  
>  	if (stage)
>  		chip->temp = qpnp_tm_decode_temp(chip, stage);
>  
> -	mutex_unlock(&chip->lock);
> -
> -	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> -	if (ret)
> -		crit_temp = THERMAL_TEMP_INVALID;
> -
> -	mutex_lock(&chip->lock);
> -
> -	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +	ret = chip->data->configure_trip_temps(chip);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -439,10 +481,15 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	}
>  
>  	chip->subtype = subtype;
> -	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
> -		chip->temp_map = &temp_map_gen2_v1;
> +
> +	if (subtype == QPNP_TM_SUBTYPE_GEN1)
> +		chip->data = &spmi_temp_alarm_data;
> +	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
> +		chip->data = &spmi_temp_alarm_gen2_rev1_data;
> +	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
> +		chip->data = &spmi_temp_alarm_gen2_data;
>  	else
> -		chip->temp_map = &temp_map_gen1;
> +		return -ENODEV;
>  
>  	/*
>  	 * Register the sensor before initializing the hardware to be able to
> @@ -450,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	 * before the hardware initialization is completed.
>  	 */
>  	chip->tz_dev = devm_thermal_of_zone_register(
> -		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
> +		&pdev->dev, 0, chip, chip->data->ops);
>  	if (IS_ERR(chip->tz_dev))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
>  				     "failed to register sensor\n");
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

