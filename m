Return-Path: <linux-kernel+bounces-572893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A709A6CFF9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A24188C23F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378CC139CF2;
	Sun, 23 Mar 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Lr6qR7id"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD941C6BE;
	Sun, 23 Mar 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742746569; cv=none; b=G8bsV53zGQBgrhkA1wz72ldfIRsAqREBDtTY5E3gzDHnyHgHvStj6MP5psgabwCvw7NbfUogsmiMiNJO31FcUjcvTaj/Me+yPc18/b2ckOOI7icLJQwLT32/ms8AE3k09On4C9H6GlYq6WBAQ0FEjTiJ59QOVSCmZIKe+fsdNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742746569; c=relaxed/simple;
	bh=AN8zpoPBBziBsV9oHPMDwPkDlWKzqzZZXmcgIGgo2R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxwfHquL+G5XBf36yRnuuTHLg+Zm9Lo/3MDJ3YgRWL4KxzgFUwdzMBlOl6WTsi6GgbyBtsdTGhMsHSfUYcMAT51Z4iPUGyzcWsJMsEKXQbLSZMN0oAfw1lODakrXRIM+EIajUsZ5NbwATd/Nd9fiHQg5/WtR4pVY53jALq2aXaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Lr6qR7id; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742746565;
	bh=AN8zpoPBBziBsV9oHPMDwPkDlWKzqzZZXmcgIGgo2R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr6qR7idAydPZMaYtIFDnnfL4/2X46ef8P5bA/qiuOIkFAzR7IAyhqc3ZV1nb3XBB
	 Jc17Kk0UPPmwa1Th29mLd0SDNHQm17nALL59u3WiSCC35TAO3vPL2a3J1GHFGcf6SH
	 a7VljaSqnaV/ZLmmxnjRWCz8GcX/Vx01mE4ewS/4=
Date: Sun, 23 Mar 2025 17:16:04 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
Message-ID: <16e078d4-e735-41f6-934f-c893fb469dfc@t-8ch.de>
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>

On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
> The ChromeOS embedded controller (EC) supports closed loop fan speed
> control, so add the fan target attribute under hwmon framework, such
> that kernel can expose reading and specifying the desired fan RPM for
> fans connected to the EC.
> 
> When probing the cros_ec hwmon module, we also check the supported
> command version of setting target fan RPM. This commit implements the
> version 0 of getting the target fan RPM, which can only read the target
> RPM of the first fan. This commit also implements the version 1 of
> setting the target fan RPM to each fan respectively.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
> ChromeOS embedded controller (EC) supports closed-loop fan control. We
> anticipate to have the fan related control from the kernel side, so this
> series register the HWMON_F_TARGET attribute, and implement the read and
> write function for setting/reading the target fan RPM from the EC side.
> ---
> Changes in v3:
> - Drop support of v0 setting target fan RPM, thus also simplify
>   implementations.
> - Align coding style to existing code, including using if-else rather
>   than switch-case, and ensure little endian conversion from read data.
> - Only log warning for failed probing get fan target command version
>   instead of fail the whole driver.
> - Link to v2: https://lore.kernel.org/r/20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org
> 
> Changes in v2:
> - Squash the read, write, and register of fan target attribute to 1
>   commit, as they are the same topic.
> - Probe the supported command version from EC for setting the target fan
>   RPM, and perform the set fan target RPM based on the supported
>   version.
> - Update the used variable type to kernel types (i.e., u32).
> - Link to v1: https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 90 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 5 deletions(-)

<snip>

> +static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index,
> +				     u16 val)
> +{
> +	struct ec_params_pwm_set_fan_target_rpm_v1 req = {
> +		.rpm = val,
> +		.fan_idx = index,
> +	};
> +	int ret;
> +
> +	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_TARGET_RPM, &req,
> +			  sizeof(req), NULL, 0);

This setting does not seem to survive system suspend.
A PM handler is necessary.

> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +

<snip>

