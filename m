Return-Path: <linux-kernel+bounces-177988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA1F8C472D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1E1F22F24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268543BBE5;
	Mon, 13 May 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4rwJRdl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4883C060;
	Mon, 13 May 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626291; cv=none; b=YTvul4+eXB/fQlDolHZSSDk/kNuded0F4AAeDSQ6Laq+fBzBhI3MQw5aY3SqdEwpz0wi+CaIo7IC2sHX7JlzQdTiv2S7rwkAurY+9B5KZKKdiLt+9uTLDh4Q1D3IJhTpc2fk9hRvdPhusSi0RlfjCF2j8qouQqGrKpI6A4Rkrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626291; c=relaxed/simple;
	bh=uKk5RVSZilQekGUDZr4YfLhpn3Ugc+p7LNsMzPoKt0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc/lbHIuqCht4y9qiZJ+5K7t2dUNBIgwNbgxSMj5sqOB5ULCrKLroBaA66oHpESDmyW1RSdSd9i0A5g4A4u2+CPTTCRcjhtEDxB1zcPkIqCd6mlJKIDnBOknaLmoPVX2vg6BDgD73353RE9QDMWxvsRw9PvGIDsuDNJvNzo/q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4rwJRdl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f0537e39b3so21762395ad.3;
        Mon, 13 May 2024 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715626289; x=1716231089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=12tRDbW2LR3lXqoHnvqV+BbKjSxGZDFRPqS/M7r5LC8=;
        b=a4rwJRdlN7KCwb/7xrGc7DiBu9jm4LOJP5AeBXkAK6s1iyZ3f/+B5dzJDC/ryJnlqc
         iVsscIEZPmtvn/80YGqDsYyr7D+ziqHOCaoaCWn4RFeWe5YQBLjynzQlZyHiO6a2JhMJ
         KY/oooygNYPU8iYe3K52ryez9Oa65CsKRCC9Nvl9sMZdu7VeEbmmNIDl9GnsjJli2EwX
         e9qLc/0c6pdu6dh+WkDE0OhMpmj++bsjEOcAfxv2felE2k3P7BzALzIg25pRJCex3/j6
         zfAEHTtkiTE4tV9Vny4vlEfvq43q/XpHAh32pJJmzyEXZHwAo/ygdfySzA2Yfx2lTofy
         dqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626289; x=1716231089;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12tRDbW2LR3lXqoHnvqV+BbKjSxGZDFRPqS/M7r5LC8=;
        b=Yhq0mH3JymPpExVT5qoKxPKPyGy9/dE8hGpM1FeuIKUOYQzIqIG7iB5jE+x9sy3fHj
         C9vELU9Wv668ZgD9JkSjXFbZ91THMPB4nEYp4rVXg3SQNAkN/xAqJl1ON6ia99qdme+w
         sTCbzLGgWc+EZFmjMBRbe/nKHDCY4KiGxeuf92Xd+597MMKsICYomMFOT2iBbZFfd2r9
         DBXr7SU8dpJ7E1cQorHsZasWB44gMOeIZw3L2hgZkCaZsc+Aikqo6CGohyy6guC2wUDl
         mlWHNXQrNShXtVdBbH+BNhRciGnyFrMY/0ZyTMSnUl/S6T9Q4BOaVGKudPZE3Ca7wcqF
         u/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWvxevf1EDMFQTA/nxXc+BfmtkW2QLNXg235eOuyfYmPGOHyfjWJiEmQ6kIrnu8HehVCciuq2WiuHJ2fIRKeC7mzrR4yf13Q8c9uTDuK290hPTZyNyzhD3FaE7PoPP61/6mYfjAdsSHFJA=
X-Gm-Message-State: AOJu0Yx+tX6tQJ0PBN3fp+hgYSNYXzr+KbqD4BID1Mbtpq3puii0WiOh
	Dcbja89EAGBw4tiHxKiYahpbDBYYZBtfGjbVVxFkyaOubtLMqD8Bnq2GYw==
X-Google-Smtp-Source: AGHT+IE5H2ntTWNIcfw0/E8oc7PquNxbP5jf8+dNmHH6q3dFnOxKpScULF1kRldn6o90sUIFVSmFJw==
X-Received: by 2002:a17:902:d543:b0:1ee:90a0:bbb2 with SMTP id d9443c01a7336-1ef43d1aea0mr131949225ad.17.1715626288583;
        Mon, 13 May 2024 11:51:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2565b6sm82342895ad.295.2024.05.13.11.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 11:51:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e5d5843-e91a-4c0e-a7a7-fbda55301265@roeck-us.net>
Date: Mon, 13 May 2024 11:51:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (corsair-cpro) Add firmware and bootloader
 information
To: Marius Zachmann <mail@mariuszachmann.de>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240513162328.17636-3-mail@mariuszachmann.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240513162328.17636-3-mail@mariuszachmann.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/24 09:23, Marius Zachmann wrote:
> Add support for reporting firmware and bootloader version using debugfs.
> Update documentation accordingly.
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> ---
> Changes in v3:
> - use different debugfs directory name for each device
> 
> Changes in v2:
> - better patch description
> - Documentation uses "Firmware version" and "Bootloader version"
> - removed conditional CONFIG_DEBUG_FS
> - get_fw_version gets called from ccp_debugfs_init
> - get_fw_version does print a hid_notice when an error occurs
>    instead of failing.
> ---
>   Documentation/hwmon/corsair-cpro.rst |  8 ++++
>   drivers/hwmon/corsair-cpro.c         | 71 ++++++++++++++++++++++++++++
>   2 files changed, 79 insertions(+)
> 
> diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> index 751f95476b57..15077203a2f8 100644
> --- a/Documentation/hwmon/corsair-cpro.rst
> +++ b/Documentation/hwmon/corsair-cpro.rst
> @@ -39,3 +39,11 @@ fan[1-6]_target		Sets fan speed target rpm.
>   pwm[1-6]		Sets the fan speed. Values from 0-255. Can only be read if pwm
>   			was set directly.
>   ======================= =====================================================================
> +
> +Debugfs entries
> +---------------
> +
> +======================= ===================
> +firmware_version	Firmware version
> +bootloader_version	Bootloader version
> +======================= ===================
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 3e63666a61bd..f7d321d8676e 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -10,11 +10,13 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/completion.h>
> +#include <linux/debugfs.h>
>   #include <linux/hid.h>
>   #include <linux/hwmon.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/seq_file.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> @@ -28,6 +30,8 @@
>   #define LABEL_LENGTH		11
>   #define REQ_TIMEOUT		300
>   
> +#define CTL_GET_FW_VER		0x02	/* returns the firmware version in bytes 1-3 */
> +#define CTL_GET_BL_VER		0x06	/* returns the bootloader version in bytes 1-2 */
>   #define CTL_GET_TMP_CNCT	0x10	/*
>   					 * returns in bytes 1-4 for each temp sensor:
>   					 * 0 not connected
> @@ -78,6 +82,7 @@
>   struct ccp_device {
>   	struct hid_device *hdev;
>   	struct device *hwmon_dev;
> +	struct dentry *debugfs;
>   	/* For reinitializing the completion below */
>   	spinlock_t wait_input_report_lock;
>   	struct completion wait_input_report;
> @@ -88,6 +93,8 @@ struct ccp_device {
>   	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
>   	DECLARE_BITMAP(fan_cnct, NUM_FANS);
>   	char fan_label[6][LABEL_LENGTH];
> +	u8 firmware_ver[3];
> +	u8 bootloader_ver[2];
>   };
>   
>   /* converts response error in buffer to errno */
> @@ -496,6 +503,66 @@ static int get_temp_cnct(struct ccp_device *ccp)
>   	return 0;
>   }
>   
> +/* read firmware and bootloader version */
> +static void get_fw_version(struct ccp_device *ccp)
> +{
> +	int ret;
> +
> +	ret = send_usb_cmd(ccp, CTL_GET_FW_VER, 0, 0, 0);
> +	if (ret) {
> +		hid_notice(ccp->hdev, "Failed to read firmware version.\n");

If this happens, the debugfs file should not be created, or at the very least
display something like "unavailable".

> +	} else {
> +		ccp->firmware_ver[0] = ccp->buffer[1];
> +		ccp->firmware_ver[1] = ccp->buffer[2];
> +		ccp->firmware_ver[2] = ccp->buffer[3];

That makes me wonder: What is in buffer[0] ?

> +	}
> +
> +	ret = send_usb_cmd(ccp, CTL_GET_BL_VER, 0, 0, 0);
> +	if (ret) {
> +		hid_notice(ccp->hdev, "Failed to read bootloader version.\n");

Same here.

> +	} else {
> +		ccp->bootloader_ver[0] = ccp->buffer[1];
> +		ccp->bootloader_ver[1] = ccp->buffer[2];
> +	}
> +}
> +
> +static int firmware_show(struct seq_file *seqf, void *unused)
> +{
> +	struct ccp_device *ccp = seqf->private;
> +
> +	seq_printf(seqf, "%d.%d.%d\n",
> +		   ccp->firmware_ver[0],
> +		   ccp->firmware_ver[1],
> +		   ccp->firmware_ver[2]);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(firmware);
> +
> +static int bootloader_show(struct seq_file *seqf, void *unused)
> +{
> +	struct ccp_device *ccp = seqf->private;
> +
> +	seq_printf(seqf, "%d.%d\n",
> +		   ccp->bootloader_ver[0],
> +		   ccp->bootloader_ver[1]);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(bootloader);
> +
> +static void ccp_debugfs_init(struct ccp_device *ccp)
> +{
> +	char name[32];
> +
> +	get_fw_version(ccp);
> +
> +	scnprintf(name, sizeof(name), "corsaircpro-%s", dev_name(&ccp->hdev->dev));
> +	ccp->debugfs = debugfs_create_dir(name, NULL);
> +	debugfs_create_file("firmware_version", 0444, ccp->debugfs, ccp, &firmware_fops);
> +	debugfs_create_file("bootloader_version", 0444, ccp->debugfs, ccp, &bootloader_fops);
> +}
> +
>   static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   {
>   	struct ccp_device *ccp;
> @@ -542,6 +609,9 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	ret = get_fan_cnct(ccp);
>   	if (ret)
>   		goto out_hw_close;
> +
> +	ccp_debugfs_init(ccp);
> +
>   	ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
>   							 ccp, &ccp_chip_info, NULL);
>   	if (IS_ERR(ccp->hwmon_dev)) {
> @@ -562,6 +632,7 @@ static void ccp_remove(struct hid_device *hdev)
>   {
>   	struct ccp_device *ccp = hid_get_drvdata(hdev);
>   
> +	debugfs_remove_recursive(ccp->debugfs);
>   	hwmon_device_unregister(ccp->hwmon_dev);
>   	hid_hw_close(hdev);
>   	hid_hw_stop(hdev);


