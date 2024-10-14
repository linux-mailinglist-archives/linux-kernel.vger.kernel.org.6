Return-Path: <linux-kernel+bounces-363932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAC99C8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7995B2CD38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9C19D889;
	Mon, 14 Oct 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n5G7NUt2"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B06156C69
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904729; cv=none; b=OvWv67hJWFSrysl/ZWc178svoFvzjSj0MclZGotZPL9lzO9LIBNmWYvfbpYk6EgBsRl618f02xN1fIxI0tBK2Wa1HIASW/fc3uMZzCkE3eq9IbLMK7gh8WZh2T4r+gLw4bCUU6E01/RdjPVnH5HsXGH7/mFA0AWd26TDLXkCA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904729; c=relaxed/simple;
	bh=9aHry6VBkjZcEIo50VZB8AKNQPDK82Co3aN9mgWk1Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ctsmzlfyce+SXUtX8HgCE17jfH9ZjwnkJYrkgva9MKGutCputbzk0i4h53L6MeMer2ilKWIuGSUfyxYVFRG4mUW1HcW529kRkynuhXJsacY9SA58gPmx87bANZDLiHLlff2QjlrvnNUrDpOTfzAT4XXm1NPe3flfm+HD/iY2uT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n5G7NUt2; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8502a496-f83d-470c-a84d-081a7c7e2cae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728904725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qvk+SQkpm0adFfLZoGHx2leIDXBWldvO8V7DbQkvxs=;
	b=n5G7NUt2rY0D9drJF1pLyBXmQKgvHIGv5vdjiHstPGP1rQ21liZbQc1Gk4kV+xyL/Mjzvp
	3nGtgV/JKi2iWzk75HFKoftKVRTv8dJSQJjIrP4J4wX5ES3BWFqb5wfQq2ETKqaVx4a4Pd
	EHtGvi7LxdJallR4j3G5KH0U4DhamVo=
Date: Mon, 14 Oct 2024 12:18:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] eth: fbnic: Add devlink dev flash support
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Simon Horman <horms@kernel.org>,
 Sanman Pradhan <sanmanpradhan@meta.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241012023646.3124717-1-lee@trager.us>
 <20241012023646.3124717-3-lee@trager.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241012023646.3124717-3-lee@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/10/2024 03:34, Lee Trager wrote:
> fbnic supports updating firmware using a PLDM image signed and distributed
> by Meta. PLDM images are written into stored flashed. Flashing does not
> interrupt operation.
> 
> On host reboot the newly flashed UEFI driver will be used. To run new
> control or cmrt firmware the NIC must be power cycled.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
>   .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
>   drivers/net/ethernet/meta/Kconfig             |   1 +
>   .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 270 +++++++++++++++++-
>   3 files changed, 281 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> index 32ff114f5c26..d6726c254818 100644
> --- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> +++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> @@ -27,3 +27,14 @@ driver takes over.
>   devlink dev info provides version information for all three components. In
>   addition to the version the hg commit hash of the build is included as a
>   separate entry.
> +
> +Upgrading Firmware
> +------------------
> +
> +fbnic supports upgrading firmware using devlink dev flash. Firmware images
> +are signed and distributed by Meta. All firmware is bundled into a single
> +PLDM image which is written into stored flash. Flashing firmware does not
> +interrupt operation.
> +
> +On host reboot the newly flashed UEFI driver will be used. To run new control
> +or cmrt firmware the NIC must be power cycled.
> diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
> index 85519690b837..f5d2c6b6399f 100644
> --- a/drivers/net/ethernet/meta/Kconfig
> +++ b/drivers/net/ethernet/meta/Kconfig
> @@ -26,6 +26,7 @@ config FBNIC
>   	select NET_DEVLINK
>   	select PAGE_POOL
>   	select PHYLINK
> +	select PLDMFW
>   	help
>   	  This driver supports Meta Platforms Host Network Interface.
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> index 0072d612215e..d487ae7f1126 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> @@ -3,6 +3,7 @@
> 
>   #include <linux/unaligned.h>
>   #include <linux/pci.h>
> +#include <linux/pldmfw.h>
>   #include <linux/types.h>
>   #include <net/devlink.h>
> 
> @@ -109,8 +110,275 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
>   	return 0;
>   }
> 
> +/**
> + * fbnic_send_package_data - Send record package data to firmware
> + * @context: PLDM FW update structure
> + * @data: pointer to the package data
> + * @length: length of the package data
> + *
> + * Send a copy of the package data associated with the PLDM record matching
> + * this device to the firmware.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */
> +static int fbnic_send_package_data(struct pldmfw *context, const u8 *data,
> +				   u16 length)
> +{
> +	struct device *dev = context->dev;
> +
> +	/* Temp placeholder required by devlink */
> +	dev_info(dev,
> +		 "Sending %u bytes of PLDM record package data to firmware\n",
> +		 length);
> +
> +	return 0;
> +}
> +
> +/**
> + * fbnic_send_component_table - Send PLDM component table to the firmware
> + * @context: PLDM FW update structure
> + * @component: The component to send
> + * @transfer_flag: Flag indication location in component tables
> + *
> + * Read relevant data from component table and forward it to the firmware.
> + * Check response to verify if the firmware indicates that it wishes to
> + * proceed with the update.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */
> +static int fbnic_send_component_table(struct pldmfw *context,
> +				      struct pldmfw_component *component,
> +				      u8 transfer_flag)
> +{
> +	struct device *dev = context->dev;
> +	u16 id = component->identifier;
> +	u8 test_string[80];
> +
> +	switch (id) {
> +	case QSPI_SECTION_CMRT:
> +	case QSPI_SECTION_CONTROL_FW:
> +	case QSPI_SECTION_OPTION_ROM:
> +		break;
> +	default:
> +		dev_err(dev, "Unknown component ID %u\n", id);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Sending PLDM component table to firmware\n");
> +
> +	/* Temp placeholder */
> +	memcpy(test_string, component->version_string,
> +	       min_t(u8, component->version_len, 79));
> +	test_string[min_t(u8, component->version_len, 79)] = 0;

Looks like this construction can be replaced with strscpy().
There were several patchsets in the tree to use strscpy(), let's follow
the pattern.

> +	dev_info(dev, "PLDMFW: Component ID: %u version %s\n",
> +		 id, test_string);
> +
> +	return 0;
> +}
> +
> +/**
> + * fbnic_flash_component - Flash a component of the QSPI
> + * @context: PLDM FW update structure
> + * @component: The component table to send to FW
> + *
> + * Map contents of component and make it available for FW to download
> + * so that it can update the contents of the QSPI Flash.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */
> +static int fbnic_flash_component(struct pldmfw *context,
> +				 struct pldmfw_component *component)
> +{
> +	const u8 *data = component->component_data;
> +	u32 size = component->component_size;
> +	struct fbnic_fw_completion *fw_cmpl;
> +	struct device *dev = context->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 id = component->identifier;
> +	const char *component_name;
> +	int retries = 2;
> +	int err;
> +
> +	struct devlink *devlink;
> +	struct fbnic_dev *fbd;
> +
> +	switch (id) {
> +	case QSPI_SECTION_CMRT:
> +		component_name = "boot1";
> +		break;
> +	case QSPI_SECTION_CONTROL_FW:
> +		component_name = "boot2";
> +		break;
> +	case QSPI_SECTION_OPTION_ROM:
> +		component_name = "option-rom";
> +		break;
> +	default:
> +		dev_err(dev, "Unknown component ID %u\n", id);
> +		return -EINVAL;
> +	}
> +
> +	fw_cmpl = kzalloc(sizeof(*fw_cmpl), GFP_KERNEL);
> +	if (!fw_cmpl)
> +		return -ENOMEM;
> +
> +	pdev = to_pci_dev(dev);
> +	fbd = pci_get_drvdata(pdev);
> +	devlink = priv_to_devlink(fbd);
> +
> +	/* Initialize completion and queue it for FW to process */
> +	fw_cmpl->msg_type = FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ;
> +	init_completion(&fw_cmpl->done);
> +
> +	fw_cmpl->fw_update.last_offset = 0;
> +	fw_cmpl->fw_update.data = data;
> +	fw_cmpl->fw_update.size = size;
> +
> +	err = fbnic_fw_xmit_fw_start_upgrade(fbd, fw_cmpl, id, size);
> +	if (err)
> +		goto cmpl_free;
> +
> +	/* Monitor completions and report status of update */
> +	while (fw_cmpl->fw_update.data) {
> +		u32 offset = fw_cmpl->fw_update.last_offset;
> +
> +		devlink_flash_update_status_notify(devlink, "Flashing",
> +						   component_name, offset,
> +						   size);
> +
> +		/* Allow 5 seconds for reply, resend and try up to 2 times */
> +		if (wait_for_completion_timeout(&fw_cmpl->done, 5 * HZ)) {
> +			reinit_completion(&fw_cmpl->done);
> +			/* If we receive a reply, reinit our retry counter */
> +			retries = 2;
> +		} else if (--retries == 0) {
> +			dev_err(fbd->dev, "Timed out waiting on update\n");
> +			err = -ETIMEDOUT;
> +			goto cmpl_cleanup;
> +		}
> +	}
> +
> +	err = fw_cmpl->result;
> +	if (err)
> +		goto cmpl_cleanup;
> +
> +	devlink_flash_update_status_notify(devlink, "Flashing",
> +					   component_name, size, size);
> +
> +cmpl_cleanup:
> +	fbd->cmpl_data = NULL;
> +cmpl_free:
> +	kfree(fw_cmpl);
> +
> +	return err;
> +}
> +

[ strip ]

