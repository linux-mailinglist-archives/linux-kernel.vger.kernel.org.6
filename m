Return-Path: <linux-kernel+bounces-267763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21645941532
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FC91F24924
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE51A2C2A;
	Tue, 30 Jul 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JcfNw4pp"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A25147C86;
	Tue, 30 Jul 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352357; cv=none; b=WZU4XtdERptRc/k8iEKguqy/4AZwcK+6fWemVpXLb20LU+2IsmQaIJi/xK7JQARc0My6KB471YGYCR5juMTSd4yw5vaeeNzHlH+JgwnJGwyIFyiJridDLH9NJ4Repm5OMQ2lo+9fXmLqjhGeUH4UuhqaSskiDaB4ZQnezvMr4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352357; c=relaxed/simple;
	bh=HF2f18oaFhg6sIIwJTTNCjZbqLtBgrJ4EQ23RNDqG1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WpMk0FbfhU+g5eTK/RDZKa6OqHODY3zSy1f6aEbsjP6CJNaOzeYSY3jkVxET2L808FD90eBQ4LWKwU7Alflf2Sqrn2yNN3mzWKyZvnxsPbU9ocoHqkgomiHD1y724t0eSFrzEk6EB8QgGpTaqukMfP2DJ3MKl71ZvAwwJqtraPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JcfNw4pp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UFCQii125769;
	Tue, 30 Jul 2024 10:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722352346;
	bh=dwiMu1ISx3LU2tltj0G97p6/2zOtG4skuMq0BQlFFvw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JcfNw4ppOE026VlZmRJ8h6MtHFVz3Aa93UbQi62pNu7WgXjTs2C80XED1mDJ6hZav
	 SBFMJ1MBa5SzKRZwK2eopI6lWGidqCky0ez5CZno3nQ4I/prAJenQSNPfyW8FkB+RZ
	 8V5MwdpVVe/gmcS6ihLOG38xA2NRtHZPNhfp8MKg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UFCQ6O006169
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 10:12:26 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 10:12:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 10:12:25 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UFCPGO039423;
	Tue, 30 Jul 2024 10:12:25 -0500
Message-ID: <825ad211-e1c2-44e6-bfe9-c32273799f0d@ti.com>
Date: Tue, 30 Jul 2024 10:12:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240729080101.3859701-3-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/29/24 3:00 AM, Markus Schneider-Pargmann wrote:
> Add support for Partial-IO poweroff. In Partial-IO pins of a few modules
> can generate system wakeups while DDR memory is not powered resulting in
> a fresh boot of the system. The modules that can be wakeup sources are
> defined by the devicetree.
> 
> Only wakeup sources that are actually enabled by the user will be
> considered as a an active wakeup source. If none of the wakeup sources
> are enabled the system will do a normal poweroff. If at least one wakeup
> source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
> message from the sys_off handler. Sending this message will result in an
> immediate shutdown of the system. No execution is expected after this
> point. The code will enter an infinite loop.
> 
> The wakeup source device nodes are gathered during probe. But they are
> only resolved to the actual devices in the sys_off handler, if they
> exist. If they do not exist, they are ignored.
> 
> A short documentation about Partial-IO can be found in section 6.2.4.5
> of the TRM at
>    https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c | 160 +++++++++++++++++++++++++++++++++-----
>   drivers/firmware/ti_sci.h |  34 ++++++++
>   2 files changed, 175 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 160968301b1f..ba2e56da0215 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -99,6 +99,9 @@ struct ti_sci_desc {
>    * @node:	list head
>    * @host_id:	Host ID
>    * @users:	Number of users of this instance
> + * @nr_wakeup_sources: Number of device nodes in wakeup_source_nodes
> + * @wakeup_source_nodes: Array of all device_nodes listed as wakeup sources in
> + *			 the devicetree
>    */
>   struct ti_sci_info {
>   	struct device *dev;
> @@ -116,6 +119,9 @@ struct ti_sci_info {
>   	u8 host_id;
>   	/* protected by ti_sci_list_mutex */
>   	int users;
> +
> +	int nr_wakeup_sources;
> +	struct device_node **wakeup_source_nodes;
>   };
>   
>   #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
> @@ -392,10 +398,13 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
>   static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>   				 struct ti_sci_xfer *xfer)
>   {
> +	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
>   	int ret;
>   	int timeout;
>   	struct device *dev = info->dev;
>   	bool done_state = true;
> +	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
> +						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
>   
>   	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
>   	if (ret < 0)
> @@ -403,25 +412,27 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>   
>   	ret = 0;
>   
> -	if (system_state <= SYSTEM_RUNNING) {
> -		/* And we wait for the response. */
> -		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> -		if (!wait_for_completion_timeout(&xfer->done, timeout))
> -			ret = -ETIMEDOUT;
> -	} else {
> -		/*
> -		 * If we are !running, we cannot use wait_for_completion_timeout
> -		 * during noirq phase, so we must manually poll the completion.
> -		 */
> -		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
> -					       done_state, 1,
> -					       info->desc->max_rx_timeout_ms * 1000,
> -					       false, &xfer->done);
> -	}
> +	if (response_expected) {

If a response is not expected why not simply return above and not add even more
indention here? Also, in that case, is the call to mbox_client_txdone() needed?

> +		if (system_state <= SYSTEM_RUNNING) {
> +			/* And we wait for the response. */
> +			timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> +			if (!wait_for_completion_timeout(&xfer->done, timeout))
> +				ret = -ETIMEDOUT;
> +		} else {
> +			/*
> +			 * If we are !running, we cannot use wait_for_completion_timeout
> +			 * during noirq phase, so we must manually poll the completion.
> +			 */
> +			ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
> +						       done_state, 1,
> +						       info->desc->max_rx_timeout_ms * 1000,
> +						       false, &xfer->done);
> +		}
>   
> -	if (ret == -ETIMEDOUT)
> -		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
> -			(void *)_RET_IP_);
> +		if (ret == -ETIMEDOUT)
> +			dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
> +				(void *)_RET_IP_);
> +	}
>   
>   	/*
>   	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> @@ -3262,6 +3273,82 @@ static int tisci_reboot_handler(struct sys_off_data *data)
>   	return NOTIFY_BAD;
>   }
>   
> +/*
> + * Enter Partial-IO, which disables everything including DDR with only a small
> + * logic being active for wakeup.
> + */
> +static int tisci_enter_partial_io(struct ti_sci_info *info)
> +{
> +	struct ti_sci_msg_req_prepare_sleep *req;
> +	struct ti_sci_xfer *xfer;
> +	struct device *dev = info->dev;
> +	int ret = 0;
> +
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
> +				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
> +				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
> +	req->mode = TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
> +	req->ctx_lo = 0;
> +	req->ctx_hi = 0;
> +	req->debug_flags = 0;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "Mbox send fail %d\n", ret);
> +		goto fail;

Seems unneeded here.

> +	}
> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);

Is this safe? If we didn't wait for the transfer to complete,
the rx buffer might still be in use.

> +
> +	return ret;
> +}
> +
> +static int tisci_sys_off_handler(struct sys_off_data *data)
> +{
> +	struct ti_sci_info *info = data->cb_data;
> +	int i;
> +	int ret;
> +	bool enter_partial_io = false;
> +
> +	for (i = 0; i != info->nr_wakeup_sources; ++i) {
> +		struct platform_device *pdev =
> +			of_find_device_by_node(info->wakeup_source_nodes[i]);
> +
> +		if (!pdev)
> +			continue;
> +
> +		if (device_may_wakeup(&pdev->dev)) {
> +			dev_dbg(info->dev, "%pOFp identified as wakeup source\n",
> +				info->wakeup_source_nodes[i]);
> +			enter_partial_io = true;
> +		}
> +	}
> +
> +	if (!enter_partial_io)
> +		return NOTIFY_DONE;
> +
> +	ret = tisci_enter_partial_io(info);
> +

extra newline

> +	if (ret) {
> +		dev_err(info->dev,
> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> +			ERR_PTR(ret));
> +		emergency_restart();
> +	}
> +
> +	while (1);

Why? If we fail to turn off here, we should try other
methods, not lock the system.

> +
> +	return NOTIFY_DONE;
> +}
> +
>   /* Description for K2G */
>   static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>   	.default_host_id = 2,
> @@ -3398,6 +3485,35 @@ static int ti_sci_probe(struct platform_device *pdev)
>   		goto out;
>   	}
>   
> +	if (of_property_read_bool(dev->of_node, "ti,partial-io-wakeup-sources")) {
> +		info->nr_wakeup_sources =
> +			of_count_phandle_with_args(dev->of_node,
> +						   "ti,partial-io-wakeup-sources",
> +						   NULL);
> +		info->wakeup_source_nodes =
> +			devm_kzalloc(dev, sizeof(*info->wakeup_source_nodes),
> +				     GFP_KERNEL);
> +
> +		for (i = 0; i != info->nr_wakeup_sources; ++i) {
> +			struct device_node *devnode =
> +				of_parse_phandle(dev->of_node,
> +						 "ti,partial-io-wakeup-sources",
> +						 i);
> +			info->wakeup_source_nodes[i] = devnode;
> +		}
> +
> +		ret = devm_register_sys_off_handler(dev,
> +						    SYS_OFF_MODE_POWER_OFF,
> +						    SYS_OFF_PRIO_FIRMWARE,

So this will be done instead of PSCI sys-off? Maybe a better question,
why is this all not done in PSCI off handler in TF-A?

> +						    tisci_sys_off_handler,
> +						    info);
> +		if (ret) {
> +			dev_err(dev, "Failed to register sys_off_handler %pe\n",
> +				ERR_PTR(ret));
> +			goto out;
> +		}
> +	}
> +
>   	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
>   		 info->handle.version.abi_major, info->handle.version.abi_minor,
>   		 info->handle.version.firmware_revision,
> @@ -3407,7 +3523,13 @@ static int ti_sci_probe(struct platform_device *pdev)
>   	list_add_tail(&info->node, &ti_sci_list);
>   	mutex_unlock(&ti_sci_list_mutex);
>   
> -	return of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
> +		goto out;
> +	}

Need newline here. Also this change is fine, but seems unrelated and
might need to go in another patch.

Andrew

> +	return 0;
> +
>   out:
>   	if (!IS_ERR(info->chan_tx))
>   		mbox_free_channel(info->chan_tx);
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 5846c60220f5..ec8e6bb1791a 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -35,6 +35,9 @@
>   #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
>   #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
>   
> +/* Low Power Mode Requests */
> +#define TI_SCI_MSG_PREPARE_SLEEP	0x0300
> +
>   /* Resource Management Requests */
>   #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
>   
> @@ -545,6 +548,37 @@ struct ti_sci_msg_resp_get_clock_freq {
>   	u64 freq_hz;
>   } __packed;
>   
> +#define TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP				0x0
> +#define TISCI_MSG_VALUE_SLEEP_MODE_MCU_ONLY				0x1
> +#define TISCI_MSG_VALUE_SLEEP_MODE_STANDBY				0x2
> +/*
> + * When sending perpare_sleep with MODE_PARTIAL_IO no response will be sent,
> + * no further steps are required. */
> +#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x3
> +
> +/**
> + * struct tisci_msg_req_prepare_sleep - Request for TISCI_MSG_PREPARE_SLEEP.
> + *
> + * @hdr				TISCI header to provide ACK/NAK flags to the host.
> + * @mode			Low power mode to enter.
> + * @ctx_lo			Low 32-bits of physical pointer to address to use for context save.
> + * @ctx_hi			High 32-bits of physical pointer to address to use for context save.
> + * @debug_flags			Flags that can be set to halt the sequence during suspend or
> + *				resume to allow JTAG connection and debug.
> + *
> + * This message is used as the first step of entering a low power mode. It
> + * allows configurable information, including which state to enter to be
> + * easily shared from the application, as this is a non-secure message and
> + * therefore can be sent by anyone.
> + */
> +struct ti_sci_msg_req_prepare_sleep {
> +	struct ti_sci_msg_hdr	hdr;
> +	u8			mode;
> +	u32			ctx_lo;
> +	u32			ctx_hi;
> +	u32			debug_flags;
> +} __packed;
> +
>   #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
>   
>   /**

