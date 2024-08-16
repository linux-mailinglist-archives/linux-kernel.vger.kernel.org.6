Return-Path: <linux-kernel+bounces-290184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434E95507A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FBDB2103F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307F1C2326;
	Fri, 16 Aug 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="NNfvw5Af"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC91AC8BE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831470; cv=none; b=d0F4btpiESkLIFOGq5HgCgwvTD1qQHCTNjrur03UDl0bVTjhozD352Bcl5GqiBgRcGIud0osbfle/9gU42XP8pF4Y+1jd2uCZ48K2IU/vYJVJyIay32R6oIdecsvTx5eGnAbegH1Itz53+yjw3tyk74AS/yCAl6gyUGr9JMMUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831470; c=relaxed/simple;
	bh=2tFCf7rQisInyLTwaCJ+Xvn/VK9qntx0HG8Thy4hMA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb71UhqeigafEdIpGb0B0LTreUyN+FDP0RWCB6dvxqKljoz5bfaZnLrN+c0DwI3dmb18l0dM9PFD3srRVb3xzkJPp0MI6gTHsxC8pmu9hCMGLJJZwwmI63HVo66hFRPnrF/PsGuFU9LHt15YmehbvQU4F9tt07UiQIWFmesgMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=NNfvw5Af; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-26fde6117cfso1478436fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1723831467; x=1724436267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5JvIQmtD2C0JJ83zdFuIe41gWHt/MNwUc1aExjpQsk=;
        b=NNfvw5Af2lfZrVXSX0Ct9/Po9IkFUwqY8OUa5DR7+ZcoQruiVCHLGcvbm/iB3Xhk2P
         yrrIrQHQWARSCVJ31TWyQmv6ERTcInnPsanTeKGKiAjStuf+fa2uN4FsBZFR4WoAh1fO
         Rb8KD/4qET3uSYIZAEoVBa9xZEDXmYtP/RO3BqIMG4IwdRDFBei7RPGZM9Lxm3B7eU3A
         QCLLtmxWY9yVvWxRbO3KO18EvWtRGO2zDXzlh0WRUGEy6EkwVx8d1tB3V8Er3eTbyeIn
         Y7ZWZHt2zJO0j9YTxnT/NKxPOWLg1l3hb9foE0JAj84KgaImhECxlJZUYoHFKfhHZHA6
         gCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831467; x=1724436267;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5JvIQmtD2C0JJ83zdFuIe41gWHt/MNwUc1aExjpQsk=;
        b=ZV9OR5+zx9GgVbGFVgCwiI1jdrK4R6iIakXD+HDF1DnfWObzEgxfrdwe71HEIEecYW
         fUpHToSDvPygDAledLhhjtHodGDKe3Vfh1yZLwrec+EPdiAa0DEXyKmWk6cIPAs8jBBb
         dd/L3W1bi9oqKPhz0wTSJtBFrc6Hcr0lZwt/CsC31Mw8NE1p3ZrgaP4FjzvWgdWgM0Nm
         b58R9PAlGl2gcq0HTZ0U4oWSE6xFg0t9Vj2N+asJ2qPnPS7eMHuN915zODFyQJ5XyICa
         HjW4fDfP6xCPzqoVleAEpYK+bIbFWwyKjs9JnbRz88Of0ebOnG74UimJbzTrH+cJXRq3
         r/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVDRt9ocCFLjv6RlZ15pDPjup6KEm/dBjeXti3JwUUN67vIUgJywfQAFor60FtS9CRuIgpbHnWS2le4gMsG47JoPhE3J9Z4tkoOo+9D
X-Gm-Message-State: AOJu0YzfcIMZuF/6QvkdesAFhI7O7qHjQkgh8IjXYYhcnHDze5Tyxftl
	LOYxzcpTdKXMR7mramOp+VGLGlK9Yll7TlvSc6/f/XWIiP6mQbSlhKTGCIk7af4=
X-Google-Smtp-Source: AGHT+IHati2YAs6007YVCqJh7zzRfzYuKvZLZCqgFGLXZ7Kn7Ta7mdUOztJD+fP+78/HCzzJ/h71gA==
X-Received: by 2002:a05:6870:b506:b0:270:16d3:40b3 with SMTP id 586e51a60fabf-27033fb918bmr388477fac.16.1723831467286;
        Fri, 16 Aug 2024 11:04:27 -0700 (PDT)
Received: from mail.minyard.net (65-36-24-217.dyn.grandenetworks.net. [65.36.24.217])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-270046a500fsm1012570fac.24.2024.08.16.11.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:04:26 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:04:23 -0500
From: Corey Minyard <corey@minyard.net>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Exit early when there is a SMBus error
Message-ID: <Zr+Up+94gmPEHwcJ@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20240816065458.117986-1-iivanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816065458.117986-1-iivanov@suse.de>

On Fri, Aug 16, 2024 at 09:54:58AM +0300, Ivan T. Ivanov wrote:
> It is pointless to continue module probing when communication
> with device is failing. This just fill logs with misleading
> messages like this:

So the BMC (or whatever is there) responds to a GET_DEVICE_ID command,
but then doesn't properly handle any other valid and mandatory commands?
And this device was added via ACPI or SMBIOS or device tree, almost
certainly.

My comments are:

1) This fix is wrong, because it may mask important things that need to
be reported.

2) Fix the source of the problem.  You can't expect software to
compensate for all bad hardware and firmware.  I'd guess the firmware
tables are pointing to something that's not a BMC.

3) It appears the response to the GET_DEVICE_ID command, though a
response is returned, is not valid.  The right way to handle this would
be to do more validation in the ssif_detect() function.  It doesn't do
any validation of the response data, and that's really what needs to be
done.

-corey

> 
> [Fri Jul 26 18:32:34 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Error fetching SSIF: -121 180453376 62, your system probably doesn't support this command so using defaults
> [Fri Jul 26 18:32:54 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Unable to clear message flags: -121 180453376 62
> [Fri Jul 26 18:33:14 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Error getting global enables: -121 180453376 62
> [Fri Jul 26 18:33:49 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
> [Fri Jul 26 18:33:50 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
> [Fri Jul 26 18:34:07 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
> [Fri Jul 26 18:34:07 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
> [Fri Jul 26 18:34:25 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
> [Fri Jul 26 18:34:25 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
> [Fri Jul 26 18:34:43 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
> [Fri Jul 26 18:34:43 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
> [Fri Jul 26 18:35:01 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
> [Fri Jul 26 18:35:01 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: BMC returned 0xff, retry get bmc device id
> [Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: device id demangle failed: -22
> [Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: IPMI message handler: Unable to get the device id: -5
> [Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Unable to register device: error -5
> [Fri Jul 26 18:35:19 2024] ipmi_ssif i2c-IPI0001:00: ipmi_ssif: Unable to start IPMI SSIF: -5
> [Fri Jul 26 18:35:19 2024] ipmi_ssif: probe of i2c-IPI0001:00 failed with error -5
> 
> Also in some of these prints uninitialized variables are used.
> So just exit early when communication with device is flawed.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 96ad571d041a..37516733e5c8 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1315,6 +1315,16 @@ static int read_response(struct i2c_client *client, unsigned char *resp)
>  	return ret;
>  }
>  
> +/* Filter SMBus communication errors from incorrect response errors */
> +static bool is_smbus_error(struct device *dev, int err)
> +{
> +	if (!err || err == -EINVAL || err == -E2BIG)
> +		return false;
> +
> +	dev_err(dev, "SMbus error: %d\n", err);
> +	return true;
> +}
> +
>  static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
>  		  int *resp_len, unsigned char *resp)
>  {
> @@ -1709,6 +1719,8 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
>  	msg[2] = 0; /* SSIF */
>  	rv = do_cmd(client, 3, msg, &len, resp);
> +	if (is_smbus_error(&client->dev, rv))
> +		goto out;
>  	if (!rv && (len >= 3) && (resp[2] == 0)) {
>  		if (len < 7) {
>  			if (ssif_dbg_probe)
> @@ -1767,6 +1779,8 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
>  	msg[2] = WDT_PRE_TIMEOUT_INT;
>  	rv = do_cmd(client, 3, msg, &len, resp);
> +	if (is_smbus_error(&client->dev, rv))
> +		goto out;
>  	if (rv || (len < 3) || (resp[2] != 0))
>  		dev_warn(&ssif_info->client->dev,
>  			 "Unable to clear message flags: %d %d %2.2x\n",
> @@ -1776,6 +1790,8 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
>  	rv = do_cmd(client, 2, msg, &len, resp);
> +	if (is_smbus_error(&client->dev, rv))
> +		goto out;
>  	if (rv || (len < 4) || (resp[2] != 0)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error getting global enables: %d %d %2.2x\n",
> @@ -1796,6 +1812,8 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
>  	msg[2] = ssif_info->global_enables | IPMI_BMC_EVT_MSG_BUFF;
>  	rv = do_cmd(client, 3, msg, &len, resp);
> +	if (is_smbus_error(&client->dev, rv))
> +		goto out;
>  	if (rv || (len < 2)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error setting global enables: %d %d %2.2x\n",
> @@ -1818,6 +1836,8 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
>  	msg[2] = ssif_info->global_enables | IPMI_BMC_RCV_MSG_INTR;
>  	rv = do_cmd(client, 3, msg, &len, resp);
> +	if (is_smbus_error(&client->dev, rv))
> +		goto out;
>  	if (rv || (len < 2)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error setting global enables: %d %d %2.2x\n",
> -- 
> 2.43.0
> 

