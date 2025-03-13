Return-Path: <linux-kernel+bounces-559958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D012EA5FB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC43F1696A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112582690F0;
	Thu, 13 Mar 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JeJ7S+2E"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E1267F77;
	Thu, 13 Mar 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883072; cv=none; b=uV99exeYS9Y4cpt2dPhDtTTUtxEPkIG0G6YjI9NPOsRcG72gMHIC/F07l5MDIoYvKE7BzZh21HSvulOafK8Q1YwNYrEzY8PYPGH/8A//ASHcjIMRcn8LFdHLZuIfewRqAzmPd1ana086pxZTxPFgf/vj6VKDpOuo6t54GOwlzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883072; c=relaxed/simple;
	bh=Qukw+Dbpf77fOn6Kq4jSk8A0o1PHU9Moj+IMqcryrGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZm2y32cxdaYqctKui+pPQQQ+lMR41hLfAqww2CzevhDavo/kihNddG/aHQ2fAExd/g8Grzlc30SfL5/c5+h+Jt279R8Ecppb5ZKFEYPZmebuXnn00NBcLknUVbvTjvsSMFqzEOGLaBZJoqJHFDxKkNIt8CjVPIFf06nF/GiYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JeJ7S+2E; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741883068;
	bh=Qukw+Dbpf77fOn6Kq4jSk8A0o1PHU9Moj+IMqcryrGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeJ7S+2EFqV4tuX1Y058rQF8a0kWQYKi8UEtSY6kj+y2mwk9GqKU7GLB9SwCJ/YK/
	 v2L1G1fUz3vkC/TSXhyQiuRRrg3KO8HL1rTjjyhBo8+HpjX3ypV6/m0JkCDanSuIFc
	 /xhwernHvbp5DjLlHlRyvAXxaKOrBuJtbI3+l0D4=
Date: Thu, 13 Mar 2025 17:24:28 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
Message-ID: <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>

On 2025-03-13 12:47:43+0800, Sung-Chi Li wrote:
> Implement the functionality of reading the target fan RPM setting from
> ChromeOS embedded controller under framework.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)

int32_t is a userspace type. In the kernel use i32, or even better u32.

> +{
> +	int ret;
> +	struct ec_response_pwm_get_fan_rpm r;

Switch the variable declarations around.
Also call the request "req".

> +
> +	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0, &r, sizeof(r));
> +	if (ret < 0)
> +		return ret;
> +
> +	*speed = le32_to_cpu(r.rpm);

r.rpm is not marked as __le32, I'm not sure if sparse will complain
about the usage of le32_to_cpu().

> +	return 0;
> +}
> +
>  static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
>  {
>  	unsigned int offset;
> @@ -95,6 +108,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  {
>  	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
>  	int ret = -EOPNOTSUPP;
> +	int32_t target_rpm;

Also u32.

>  	u16 speed;
>  	u8 temp;
>  
> @@ -111,6 +125,10 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
>  			if (ret == 0)
>  				*val = cros_ec_hwmon_is_error_fan(speed);
> +		} else if (attr == hwmon_fan_target) {
> +			ret = cros_ec_hwmon_read_fan_target(priv->cros_ec, channel, &target_rpm);
> +			if (ret == 0)
> +				*val = target_rpm;
>  		}
>  	} else if (type == hwmon_temp) {
>  		if (attr == hwmon_temp_input) {
> 
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 

