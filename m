Return-Path: <linux-kernel+bounces-168641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9708BBB26
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910AF1C211C8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72482110F;
	Sat,  4 May 2024 12:18:17 +0000 (UTC)
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B05234;
	Sat,  4 May 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825097; cv=none; b=o+9I3LGfflJ5FXbSTK95CPc4x6KmU9lCaLDf6PL++8nEiJZovgMg27zLLZvXqrfHI0bbUsgx4DBXbk8XZD+2CYuvsxTh6iPtrGAf8koDVhsROtNlST9ioo0BQGHviS2uWXhPc/9oRdth83/TLQl+Gr6Eh7fRBHg0i9ve1cCp1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825097; c=relaxed/simple;
	bh=CsIZ8ETxiJAGv+CnlYM534fFITb1mczKbTdqGZHPBfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzcqIEHByDVKV7G18LBTpyWBpnxWNQsBUhs6YcTZ1w8NI+p2fA8uAJYsS1qnC6jK7hOMN5Dvx+wHiYpSivMIDjsvnSmEGFD1Wng34RAreTWUQlL7icB+AHoW+J90CLPMwhAt+UlpGgEw7BRrYrazdMzxOYOPi3ZLWRTsPd0GBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from [2.211.228.80] (helo=marius.localnet)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mail@mariuszachmann.de>)
	id 1s3EHT-00FLNS-C6;
	Sat, 04 May 2024 14:14:19 +0200
From: Marius Zachmann <mail@mariuszachmann.de>
To: linux-hwmon@vger.kernel.org, Aleksa Savic <savicaleksa83@gmail.com>
Cc: Jonas Malaco <jonas@protocubo.io>, Aleksa Savic <savicaleksa83@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/3] hwmon: (corsair-cpro) Use a separate buffer for sending
 commands
Date: Sat, 04 May 2024 14:14:18 +0200
Message-ID: <6041245.lOV4Wx5bFT@marius>
In-Reply-To: <20240504092504.24158-2-savicaleksa83@gmail.com>
References:
 <20240504092504.24158-1-savicaleksa83@gmail.com>
 <20240504092504.24158-2-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Con-Id: 241080
X-Con-U: 0-mail

On 04.05.24 at 11:25:01 MESZ, Aleksa Savic wrote
> Introduce cmd_buffer, a separate buffer for storing only
> the command that is sent to the device. Before this separation,
> the existing buffer was shared for both the command and the
> report received in ccp_raw_event(), which was copied into it.
> 
> However, because of hidraw, the raw event parsing may be triggered
> in the middle of sending a command, resulting in outputting gibberish
> to the device. Using a separate buffer resolves this.
> 
> Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  drivers/hwmon/corsair-cpro.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index a284a02839fb..8d85f66f8143 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -79,6 +79,7 @@ struct ccp_device {
>  	struct device *hwmon_dev;
>  	struct completion wait_input_report;
>  	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
> +	u8 *cmd_buffer;
>  	u8 *buffer;
>  	int target[6];
>  	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
> @@ -111,15 +112,15 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
>  	unsigned long t;
>  	int ret;
>  
> -	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> -	ccp->buffer[0] = command;
> -	ccp->buffer[1] = byte1;
> -	ccp->buffer[2] = byte2;
> -	ccp->buffer[3] = byte3;
> +	memset(ccp->cmd_buffer, 0x00, OUT_BUFFER_SIZE);
> +	ccp->cmd_buffer[0] = command;
> +	ccp->cmd_buffer[1] = byte1;
> +	ccp->cmd_buffer[2] = byte2;
> +	ccp->cmd_buffer[3] = byte3;
>  
>  	reinit_completion(&ccp->wait_input_report);
>  
> -	ret = hid_hw_output_report(ccp->hdev, ccp->buffer, OUT_BUFFER_SIZE);
> +	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -492,7 +493,11 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (!ccp)
>  		return -ENOMEM;
>  
> -	ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
> +	ccp->cmd_buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
> +	if (!ccp->cmd_buffer)
> +		return -ENOMEM;
> +
> +	ccp->buffer = devm_kmalloc(&hdev->dev, IN_BUFFER_SIZE, GFP_KERNEL);
>  	if (!ccp->buffer)
>  		return -ENOMEM;
>  
> 

Thank you!
Acked-by: Marius Zachmann <mail@mariuszachmann.de>



