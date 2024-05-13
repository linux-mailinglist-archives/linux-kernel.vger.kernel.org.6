Return-Path: <linux-kernel+bounces-177059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E908C3987
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A541F213F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4AA3D;
	Mon, 13 May 2024 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT+o56Bb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF1629;
	Mon, 13 May 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715559011; cv=none; b=Y0WHMyYIk682TdxSE8rlUx8RDGf94A8qcY7zMuDp2KT2gVQqgxhWA6iwuIL89OHDfROsyL2CLKRmF28u4wrrYHiMqN2zI0YmkGUQSfZVDE5f8mY8Dq9RDsEkiXq+gv0EhN+NnbfqVVcAMTYONhn7ZfbNuPt1mVXt4/J9+lNYSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715559011; c=relaxed/simple;
	bh=1rnXFaB5PAE3KiQ9IJ/4t7ETSvkPGrQhxcvtxXUhKu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwxU3/FI0/eUZ+2MoyMuE20gA/1aYwsTQ06+me42QBcRb8Vre3sjnEUWVivc1O+Gl4sTUXvp1PkVnMhepWsxsmdiOjjoaMu0eZBcDC6mGwjK+nsPxGSILrCCRIJXEkRqp7aF8ns53v80AWT9/Tyf0d70Q0CuES0rzpWhuXPQxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT+o56Bb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so873469b3a.0;
        Sun, 12 May 2024 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715559009; x=1716163809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=s7IIP5c5pH2CkTBCz4kuXSomX+nzbP39MgrfG+xI/h0=;
        b=KT+o56BbPsLqtg3HSxYA1Uc55MnGmCNtV/b9S3HDT5r0i6qOl+2AqtubMlUqh1uP8u
         FMqkdgFkqJ+2HEp+1iFpB3N0sjKXV8qx45KC1A2SB5siuaXhIeklJ8mNh0YlxcLnNjda
         6SscMovit61QKTLuBrk+9NvZ56PzjkJxj2pPxz7HTHAkpDtGpKFsn35H3/ZPr8BvBdeF
         8LMVptaUGLlQ5uQMYPazh909SfvX+on+29jfhGMvCh9o3hCdVsSvTfQja4FhXFQ6kCk8
         PXZ7/enVbziWHNFQMDiKSD+hIFfyN+IOq858W2bwr5w8VwmiftFdMJzdJ14EUmGsBLnW
         x7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715559009; x=1716163809;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7IIP5c5pH2CkTBCz4kuXSomX+nzbP39MgrfG+xI/h0=;
        b=d4v3Z/mQNrFs4ehh6Fe/8lROktcI6LkBVXl74NciiTjwZO+F8cVOMowRH+AdK1dWsk
         j6lY4f2EkZfAzfyNCuXB9rbUgIPYvo3BeQ9tOOFRWmIjROeYi6W+NsGY+8l+Ugr8+Tfo
         MF8r7fyLxq+i1juL4VVGOUMV7oPe/1p4xweLZCkx2S7DvhD+eX4vBO6UxmYDT3z/3C2E
         jHcPToYGP92GL6A1QTxu9XzHEB8Q4cfYIIKOpk2Ifr7i7rIDIJY4hGBHguC09GjrFssl
         MODgQIjOA+tMLI6LbxzGsW+gCZiNL+ugFM0baaCM0z6PhQLGNVzKGCqgLob/KQUDcCbE
         HCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvenCgWoinTMBW7bExaw6TbCzRzjqBwI7Cld/mCotEYMc4e7Gkx8NdulNoNidMSuEFOJA/csq2ERZCqvS6Gvh7+035km/T9F4X5Jp+bQfCOErmoJzJuiHUFwXrYvED1dX7QOGGWqC7Omk=
X-Gm-Message-State: AOJu0YxYDomQt/6b0SWMGTs5dJ1/sVegGWGQtZ9PI0y7bPHYfOQ8VTDa
	mx+P0FYN1R9xklZNq5U/9fzhAh8/i/lifoRaVA+v3jhjcii594BC
X-Google-Smtp-Source: AGHT+IGe97GjrYZPIC+YaEGMzhEjs8cNzzgp5ScgPMZTGMKcxtN7LRrEpF3nCfRIJRlQIOko7hcDZg==
X-Received: by 2002:aa7:88c6:0:b0:6f4:436d:fd1c with SMTP id d2e1a72fcca58-6f4e02d386emr9849239b3a.16.1715559008737;
        Sun, 12 May 2024 17:10:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b06sm6176469b3a.167.2024.05.12.17.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 17:10:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <85c0b346-8ab5-4cb1-ae62-d7737500eb36@roeck-us.net>
Date: Sun, 12 May 2024 17:10:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (corsair-cpro) Add firmware and bootloader
 information
To: Marius Zachmann <mail@mariuszachmann.de>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240512231251.72633-3-mail@mariuszachmann.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240512231251.72633-3-mail@mariuszachmann.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/24 16:12, Marius Zachmann wrote:
> Sorry for resending. The last email had missing subsystem in the subject.
> 

You actually sent it three times unless I lost count.
Anyway, the above comment should be after "---" because it
should not be part of the description.

> This patch adds:
> - Reading the firmware and bootloader version of the device
> - Debugfs entries: firmware_version and bootloader_version
> - Updated documentation
> 

 From Documentation/process/submitting-patches.rst:

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour.

With that in mind, something like

Add support for reporting firmware and bootloader version using debugfs.
Update documentation accordingly.

would be a more appropriate. After all, _reading_ the firmware and bootloader
version is implied in making the information available.

> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> ---
>   Documentation/hwmon/corsair-cpro.rst |  8 +++
>   drivers/hwmon/corsair-cpro.c         | 80 ++++++++++++++++++++++++++++
>   2 files changed, 88 insertions(+)
> 
> diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> index 751f95476b57..11135d7ec6b9 100644
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
> +======================= ===========================
> +firmware_version	Version of the firmware

			Firmware version

> +bootloader_version	Version of the bootloader

			Bootloader version

> +======================= ===========================
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 3e63666a61bd..4be8a98250a9 100644
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
> @@ -496,6 +503,71 @@ static int get_temp_cnct(struct ccp_device *ccp)
>   	return 0;
>   }
>   
> +/* read firmware and bootloader version */
> +static int get_fw_version(struct ccp_device *ccp)
> +{
> +	int ret;
> +
> +	ret = send_usb_cmd(ccp, CTL_GET_FW_VER, 0, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	ccp->firmware_ver[0] = ccp->buffer[1];
> +	ccp->firmware_ver[1] = ccp->buffer[2];
> +	ccp->firmware_ver[2] = ccp->buffer[3];
> +
> +	ret = send_usb_cmd(ccp, CTL_GET_BL_VER, 0, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	ccp->bootloader_ver[0] = ccp->buffer[1];
> +	ccp->bootloader_ver[1] = ccp->buffer[2];
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +

The conditional isn't needed. Yes, that may mean that the code will
be added even if CONFIG_DEBUG_FS is disabled, but that is 1) unlikely
and 2) better than not compiling the code at all and missing compile
failures.

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
> +	ccp->debugfs = debugfs_create_dir("corsaircpro", NULL);
> +	debugfs_create_file("firmware_version", 0444, ccp->debugfs, ccp, &firmware_fops);
> +	debugfs_create_file("bootloader_version", 0444, ccp->debugfs, ccp, &bootloader_fops);
> +}
> +
> +#else
> +
> +static void ccp_debugfs_init(struct ccp_device *ccp)
> +{
> +}
> +
> +#endif
> +
>   static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   {
>   	struct ccp_device *ccp;
> @@ -542,6 +614,13 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	ret = get_fan_cnct(ccp);
>   	if (ret)
>   		goto out_hw_close;
> +
> +	ret = get_fw_version(ccp);
> +	if (ret)
> +		goto out_hw_close;
> +

Why bail out ? That is only informational, and if the information isn't available
the driver would still be operational. On top of that, if debugfs isn't enabled,
the information isn't even used. That means the probe function would bail out
for no good reason.

I'd suggest to move the call to get_fw_version() into ccp_debugfs_init()
and let it fail silently. I would not mind if you add a dev_notice() message
if the call fails, but anything else seems excessive.

Thanks,
Guenter


