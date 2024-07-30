Return-Path: <linux-kernel+bounces-267606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833794134A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A852815EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFFD19F499;
	Tue, 30 Jul 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbV3KGiG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A5173;
	Tue, 30 Jul 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346676; cv=none; b=r0mylDt79Yg8ZkMPbGyt+7uF0OLTCTG34WwhtMY8g1jYMmRxPkBju2nnDXlqmbMG/ALwlmVcSH0Ab8ABkZujwcdPx1b06jBkzG7QuLO4y29BU9pTYDYgJEjxdCm43X1Q2MEmpR0tHg3oJuA3ivJe4SbuOkWw0UnoFUim9qL9Wiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346676; c=relaxed/simple;
	bh=Rr3vidpsu5UyMdBK7jyALJcyDuzhQ/AJBZI4kY2lJew=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GGiGgx6CeGwTdI+zwVuARQICB5epILFRhM/iVJsQKRzs95+aXy2JLEVzaX1+8+6Fkvl/QrBfBYBY3e8dbtI4m/Aj2+1vJ4B4DLfQBMpBzxE21s7fXJ7P3rb4wWWgDkVgYgSmELeQbHchQu5sH+poyT2fTl5H9MOKDkazmd9OQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbV3KGiG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722346674; x=1753882674;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rr3vidpsu5UyMdBK7jyALJcyDuzhQ/AJBZI4kY2lJew=;
  b=fbV3KGiGowPe1CLFnLo494MuZNNgvdhRhKxYuqORFSyOoRXISC696DZI
   e/BmqPVJjiknR7nWChcsrnK+i+2ynndsb6W0Lpu8XsfnjzNcQbe//+DMT
   9s3c9Jq/rnLApMcU+Jp0hd0eT5Nk3uaRud5xmlm+41OeMxocgE+P1Tr9M
   ZORu6VZUyL8p9sSmU/F6FyA5SKVPyG2QdQ8PJ3kVV3tcka5sBZ4NJ6VsW
   yhEi+5DyNX8tU9Ea5f/9m0XAYOpIs7Y+GMc1EFwuVK5d7d20fRTo8/UC/
   oZUcSmKi30eOyDtf3PvawqyskQYeCYUIyQsBXIp8B1UyMwqD87vEppn/b
   A==;
X-CSE-ConnectionGUID: spF115GuT+u+9NJ73Ai+ww==
X-CSE-MsgGUID: ze4kacEvQxSSpNHz60K2BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20044749"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20044749"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:37:53 -0700
X-CSE-ConnectionGUID: 4WHkeHtZREG6+/6jIuWtUQ==
X-CSE-MsgGUID: 8+ZaQ76AQ9i2YjunzuJbgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54382102"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:37:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Jul 2024 16:37:45 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] platform/x86: ideapad-laptop: add a mutex to
 synchronize VPC commands
In-Reply-To: <f26782fa1194ad11ed5d9ba121a804e59b58b026.1721898747.git.soyer@irl.hu>
Message-ID: <29153152-79de-c637-eede-0b36ce4b5222@linux.intel.com>
References: <cover.1721898747.git.soyer@irl.hu> <f26782fa1194ad11ed5d9ba121a804e59b58b026.1721898747.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jul 2024, Gergo Koteles wrote:

> Calling VPC commands consists of several VPCW and VPCR ACPI calls.
> These calls and their results can get mixed up if they are called
> simultaneously from different threads, like acpi notify handler,
> sysfs, debugfs, notification chain.
> 
> Add a mutex to synchronize VPC commands.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

What commit does this fix? I was going to add a Fixes tag myself while 
applying this but wasn't sure if it should be the ACPI concurrency commit 
e2ffcda16290 or the change introducing lenovo-ymc driver?

Also, I'd prefer to not take the move patch (PATCH 3/4) now so I could 
take this through fixes branch since it causes a real issue if I remember 
the earlier discussions right? Do you think there's any issue if I take 
only patches 1, 2, and 4? They seemed to apply without conflicts when I 
tried to apply the entire series and then cherrypicked the last patch 
dropping the third patch.

The code movement patch could go through for-next fixes branch is then 
merged into it (or after one kernel cycle).


-- 
 i.


> ---
>  drivers/platform/x86/ideapad-laptop.c | 64 ++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 8398774cdfe2..3c24e3d99cd2 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -155,6 +155,7 @@ struct ideapad_rfk_priv {
>  
>  struct ideapad_private {
>  	struct acpi_device *adev;
> +	struct mutex vpc_mutex; /* protects the VPC calls */
>  	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
>  	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
>  	struct platform_device *platform_device;
> @@ -437,6 +438,8 @@ static int debugfs_status_show(struct seq_file *s, void *data)
>  	struct ideapad_private *priv = s->private;
>  	unsigned long value;
>  
> +	guard(mutex)(&priv->vpc_mutex);
> +
>  	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
>  		seq_printf(s, "Backlight max:  %lu\n", value);
>  	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
> @@ -555,7 +558,8 @@ static ssize_t camera_power_show(struct device *dev,
>  	unsigned long result;
>  	int err;
>  
> -	err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
>  	if (err)
>  		return err;
>  
> @@ -574,7 +578,8 @@ static ssize_t camera_power_store(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
>  	if (err)
>  		return err;
>  
> @@ -627,7 +632,8 @@ static ssize_t fan_mode_show(struct device *dev,
>  	unsigned long result;
>  	int err;
>  
> -	err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
>  	if (err)
>  		return err;
>  
> @@ -649,7 +655,8 @@ static ssize_t fan_mode_store(struct device *dev,
>  	if (state > 4 || state == 3)
>  		return -EINVAL;
>  
> -	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
>  	if (err)
>  		return err;
>  
> @@ -734,7 +741,8 @@ static ssize_t touchpad_show(struct device *dev,
>  	unsigned long result;
>  	int err;
>  
> -	err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
>  	if (err)
>  		return err;
>  
> @@ -755,7 +763,8 @@ static ssize_t touchpad_store(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
>  	if (err)
>  		return err;
>  
> @@ -1148,6 +1157,8 @@ static int ideapad_rfk_set(void *data, bool blocked)
>  	struct ideapad_rfk_priv *priv = data;
>  	int opcode = ideapad_rfk_data[priv->dev].opcode;
>  
> +	guard(mutex)(&priv->priv->vpc_mutex);
> +
>  	return write_ec_cmd(priv->priv->adev->handle, opcode, !blocked);
>  }
>  
> @@ -1161,6 +1172,8 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
>  	int i;
>  
>  	if (priv->features.hw_rfkill_switch) {
> +		guard(mutex)(&priv->vpc_mutex);
> +
>  		if (read_ec_data(priv->adev->handle, VPCCMD_R_RF, &hw_blocked))
>  			return;
>  		hw_blocked = !hw_blocked;
> @@ -1334,8 +1347,9 @@ static void ideapad_input_novokey(struct ideapad_private *priv)
>  {
>  	unsigned long long_pressed;
>  
> -	if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
> -		return;
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
> +			return;
>  
>  	if (long_pressed)
>  		ideapad_input_report(priv, 17);
> @@ -1347,8 +1361,9 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
>  {
>  	unsigned long bit, value;
>  
> -	if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
> -		return;
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
> +			return;
>  
>  	for_each_set_bit (bit, &value, 16) {
>  		switch (bit) {
> @@ -1381,6 +1396,8 @@ static int ideapad_backlight_get_brightness(struct backlight_device *blightdev)
>  	unsigned long now;
>  	int err;
>  
> +	guard(mutex)(&priv->vpc_mutex);
> +
>  	err = read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
>  	if (err)
>  		return err;
> @@ -1393,6 +1410,8 @@ static int ideapad_backlight_update_status(struct backlight_device *blightdev)
>  	struct ideapad_private *priv = bl_get_data(blightdev);
>  	int err;
>  
> +	guard(mutex)(&priv->vpc_mutex);
> +
>  	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_BL,
>  			   blightdev->props.brightness);
>  	if (err)
> @@ -1470,6 +1489,8 @@ static void ideapad_backlight_notify_power(struct ideapad_private *priv)
>  	if (!blightdev)
>  		return;
>  
> +	guard(mutex)(&priv->vpc_mutex);
> +
>  	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
>  		return;
>  
> @@ -1482,7 +1503,8 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
>  
>  	/* if we control brightness via acpi video driver */
>  	if (!priv->blightdev)
> -		read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
> +		scoped_guard(mutex, &priv->vpc_mutex)
> +			read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
>  	else
>  		backlight_force_update(priv->blightdev, BACKLIGHT_UPDATE_HOTKEY);
>  }
> @@ -1707,7 +1729,8 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
>  	int ret;
>  
>  	/* Without reading from EC touchpad LED doesn't switch state */
> -	ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
>  	if (ret)
>  		return;
>  
> @@ -1767,7 +1790,8 @@ static void ideapad_laptop_trigger_ec(void)
>  	if (!priv->features.ymc_ec_trigger)
>  		return;
>  
> -	ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
> +	scoped_guard(mutex, &priv->vpc_mutex)
> +		ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
>  	if (ret)
>  		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
>  }
> @@ -1813,11 +1837,13 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
>  	struct ideapad_private *priv = data;
>  	unsigned long vpc1, vpc2, bit;
>  
> -	if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
> -		return;
> +	scoped_guard(mutex, &priv->vpc_mutex) {
> +		if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
> +			return;
>  
> -	if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
> -		return;
> +		if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
> +			return;
> +	}
>  
>  	vpc1 = (vpc2 << 8) | vpc1;
>  
> @@ -2124,6 +2150,10 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>  	priv->adev = adev;
>  	priv->platform_device = pdev;
>  
> +	err = devm_mutex_init(&pdev->dev, &priv->vpc_mutex);
> +	if (err)
> +		return err;
> +
>  	ideapad_check_features(priv);
>  
>  	err = ideapad_sysfs_init(priv);
> 

