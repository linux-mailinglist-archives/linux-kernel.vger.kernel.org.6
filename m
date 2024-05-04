Return-Path: <linux-kernel+bounces-168638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77B8BBB1D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC076282A93
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8FC22F00;
	Sat,  4 May 2024 12:14:53 +0000 (UTC)
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCE1097B;
	Sat,  4 May 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824892; cv=none; b=F+3VxLkdLSE0ARYHUIdb/YwVlW7cQxxnqLe6QR6iLhkUG0Rjzt7uhWor+meQ1xSC29lZ3st0p3XUD1hhMO3lqTtfzDlU6Ds/lp9nUikumpWpyztemkXAXSDOxSwAPVRE0jj4yjg+j3HHVEwXsV5kwC1GInwJpeviDXZJTlKdK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824892; c=relaxed/simple;
	bh=VtBLvm01Gl40CEKVVLkK6MNAUa9Vo5Q0UV0wX8v4hB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsTNpjx9Hl2NyLyOhbcvn6Km/m1h1PGeZ7SZVDfmfwNUbiuKq+W9aaVe0IHSd6zKY249IJAGcOvGOTpCmjRuCUfcWRhlBw1RmgjYvAyMuhBs7fa522RiyOCkFgdtDX6YwtUsAUwiIBNoOQlVNVGljZ+lJ79qbpduxeOvtikZ7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from [2.211.228.80] (helo=marius.localnet)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mail@mariuszachmann.de>)
	id 1s3EHw-00FLhs-Iv;
	Sat, 04 May 2024 14:14:48 +0200
From: Marius Zachmann <mail@mariuszachmann.de>
To: linux-hwmon@vger.kernel.org, Aleksa Savic <savicaleksa83@gmail.com>
Cc: Jonas Malaco <jonas@protocubo.io>, Aleksa Savic <savicaleksa83@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 3/3] hwmon: (corsair-cpro) Protect ccp->wait_input_report with a
 spinlock
Date: Sat, 04 May 2024 14:14:48 +0200
Message-ID: <2182068.irdbgypaU6@marius>
In-Reply-To: <20240504092504.24158-4-savicaleksa83@gmail.com>
References:
 <20240504092504.24158-1-savicaleksa83@gmail.com>
 <20240504092504.24158-4-savicaleksa83@gmail.com>
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

On 04.05.24 at 11:25:03 MESZ, Aleksa Savic wrote
> Through hidraw, userspace can cause a status report to be sent
> from the device. The parsing in ccp_raw_event() may happen in
> parallel to a send_usb_cmd() call (which resets the completion
> for tracking the report) if it's running on a different CPU where
> bottom half interrupts are not disabled.
> 
> Add a spinlock around the complete_all() in ccp_raw_event() and
> reinit_completion() in send_usb_cmd() to prevent race issues.
> 
> Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  drivers/hwmon/corsair-cpro.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 6ab4d2478b1f..3e63666a61bd 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/types.h>
>  
>  #define USB_VENDOR_ID_CORSAIR			0x1b1c
> @@ -77,6 +78,8 @@
>  struct ccp_device {
>  	struct hid_device *hdev;
>  	struct device *hwmon_dev;
> +	/* For reinitializing the completion below */
> +	spinlock_t wait_input_report_lock;
>  	struct completion wait_input_report;
>  	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
>  	u8 *cmd_buffer;
> @@ -118,7 +121,15 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
>  	ccp->cmd_buffer[2] = byte2;
>  	ccp->cmd_buffer[3] = byte3;
>  
> +	/*
> +	 * Disable raw event parsing for a moment to safely reinitialize the
> +	 * completion. Reinit is done because hidraw could have triggered
> +	 * the raw event parsing and marked the ccp->wait_input_report
> +	 * completion as done.
> +	 */
> +	spin_lock_bh(&ccp->wait_input_report_lock);
>  	reinit_completion(&ccp->wait_input_report);
> +	spin_unlock_bh(&ccp->wait_input_report_lock);
>  
>  	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
>  	if (ret < 0)
> @@ -136,11 +147,12 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  	struct ccp_device *ccp = hid_get_drvdata(hdev);
>  
>  	/* only copy buffer when requested */
> -	if (completion_done(&ccp->wait_input_report))
> -		return 0;
> -
> -	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
> -	complete_all(&ccp->wait_input_report);
> +	spin_lock(&ccp->wait_input_report_lock);
> +	if (!completion_done(&ccp->wait_input_report)) {
> +		memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
> +		complete_all(&ccp->wait_input_report);
> +	}
> +	spin_unlock(&ccp->wait_input_report_lock);
>  
>  	return 0;
>  }
> @@ -515,7 +527,9 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	ccp->hdev = hdev;
>  	hid_set_drvdata(hdev, ccp);
> +
>  	mutex_init(&ccp->mutex);
> +	spin_lock_init(&ccp->wait_input_report_lock);
>  	init_completion(&ccp->wait_input_report);
>  
>  	hid_device_io_start(hdev);
> 

Acked-by: Marius Zachmann <mail@mariuszachmann.de>





