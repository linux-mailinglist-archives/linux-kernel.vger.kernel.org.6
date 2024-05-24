Return-Path: <linux-kernel+bounces-188339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2C8CE0C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46D01F23543
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7A1272D6;
	Fri, 24 May 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OKyKi+UR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18EE79C2;
	Fri, 24 May 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716529633; cv=none; b=I6z446yJAQNwuOTW2qMuUi9kPUCSjszJYNQ9N5rTY/u/Y9IlB21RfuZIUodqjFN2QS/XFCQHoZ5a8UTP7ZWCoQAtIW7fSf6W+PD5K0erQ26taP5a/kXbI4Xuowem1rGTr07jROcVXSwYZG0vVtGjyP0fQLWRkipgYDr3QxSyg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716529633; c=relaxed/simple;
	bh=g2mxKTs1iTsnN2NcmzKjGELZJRQ+76s/m113jF/Hq40=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQvOsIgOxQmJVEDlwBNtTz+gdyOXrKaL1YAJ9Xqs4pLBc1obz3G0Kt4AdUlmsU3MdWEC0QbVCuy3rNLSGl8yjywmJSUzN18MRhvMITggrg0WANBNr/39+p9MkLOGOGtWUTMD3RLZQ34zUZYtOzP0C947zZRILauGXIhBcDRVUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OKyKi+UR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5kxcG079907;
	Fri, 24 May 2024 00:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716529619;
	bh=0SQWy30rHxC+BBVZjIodk2V3eN35vW/iMzlL072x4y8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OKyKi+URmfTQH+G3w6aFP1bgQsloQtfQa2VQ0wN3CyXIY1sLy6oD82/JhDn3i6E0R
	 6lAwpeHlbRPaRuuUhyYIzHYjjSg2+acFu9WfY2rSQbx8EhCqcgsTuoWhHIQ3XqAA8r
	 vOjpSNYYn/B6EKUnlR12SxBHhOaGLTwSX34XY3ak=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5kxa2012201
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:46:59 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:46:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:46:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5kw8F074059;
	Fri, 24 May 2024 00:46:58 -0500
Date: Fri, 24 May 2024 00:46:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <20240524054658.owaqzqhflle6npvy@herbicide>
References: <20240523080225.1288617-1-msp@baylibre.com>
 <20240523080225.1288617-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523080225.1288617-3-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:02-20240523, Markus Schneider-Pargmann wrote:
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

Would have helped to provide link to relevant documentation here.

> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 135 +++++++++++++++++++++++++++++++++++++-
>  drivers/firmware/ti_sci.h |  31 +++++++++
>  2 files changed, 165 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 160968301b1f..04730c4df2de 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -116,6 +116,9 @@ struct ti_sci_info {
>  	u8 host_id;
>  	/* protected by ti_sci_list_mutex */
>  	int users;
> +
> +	int nr_wakeup_sources;
> +	struct device_node **wakeup_source_nodes;

Documentation please.
>  };
>  
>  #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
> @@ -380,6 +383,28 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
>  	up(&minfo->sem_xfer_count);
>  }
>  
> +/**
> + * ti_sci_do_send() - Do one send, do not expect a response

is ti_sci_send_no_response() a better name?

I have a basic question about an API at kernel level that does'nt
return back.. but I will ask in the context of tisci_enter_partial_io
below.


> + * @info:	Pointer to SCI entity information
> + * @xfer:	Transfer to initiate
> + *
> + * Return: If send error, return corresponding error, else
> + *	   if all goes well, return 0.
> + */
> +static inline int ti_sci_do_send(struct ti_sci_info *info,
> +				 struct ti_sci_xfer *xfer)
> +{
> +	int ret;

should'nt we make sure TI_SCI_FLAG_REQ_ACK_ON_PROCESSED is not set?
> +
> +	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
> +	if (ret < 0)
> +		return ret;
> +
> +	mbox_client_txdone(info->chan_tx, ret);
> +
> +	return 0;
> +}
> +

I am not sure I like two functions sending mbox_send_message. what do
you think of the following?

Use xfer-> hdr.flags and check against TI_SCI_FLAG_REQ_ACK_ON_PROCESSED
 itself to decide if ti_sci_do_xfer should expect a response or not?

>  /**
>   * ti_sci_do_xfer() - Do one transfer
>   * @info:	Pointer to SCI entity information
> @@ -3262,6 +3287,79 @@ static int tisci_reboot_handler(struct sys_off_data *data)
>  	return NOTIFY_BAD;
>  }
>  
> +/* Does not return if successful */

It wasn't clear from the commit message the strategy used. You are
triggering system off path here - do we loose the contents of
DDR in this flow? The power state needs to clearly described and the
rationale of using a variant of "off" path documented as well.

Looking further in to the code, I see we are unconditionally registering
the sys_off_handler based on ti,partial-io-wakeup-sources property being
present - how do we differentiate between actual PMIC power off desire
of user Vs just a few IO down power state for the user.

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
> +	ret = ti_sci_do_send(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "Mbox send fail %d\n", ret);
> +		goto fail;
> +	}
> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
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
> +	if (ret)
> +		dev_err(info->dev,
> +			"Failed to enter Partial-IO %pe, halting system\n",
> +			ERR_PTR(ret));

Is there no other diagnostics we can provide here?

> +
> +	/* Halt system/code execution */
> +	while (1)
> +		;
Why halt (1) -> spinning CPU in a while loop is not a power save mode
(at least idle?) :D

Why not fall through and loose power state context and allow the PMIC or
some other shutdown handler to attempt to power off?
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /* Description for K2G */
>  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>  	.default_host_id = 2,
> @@ -3398,6 +3496,35 @@ static int ti_sci_probe(struct platform_device *pdev)
>  		goto out;
>  	}
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
> +						    tisci_sys_off_handler,
> +						    info);
> +		if (ret) {
> +			dev_err(dev, "Failed to register sys_off_handler %pe\n",
> +				ERR_PTR(ret));
> +			goto out;
> +		}
> +	}
> +
>  	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
>  		 info->handle.version.abi_major, info->handle.version.abi_minor,
>  		 info->handle.version.firmware_revision,
> @@ -3407,7 +3534,13 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	list_add_tail(&info->node, &ti_sci_list);
>  	mutex_unlock(&ti_sci_list_mutex);
>  
> -	return of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
> +		goto out;
> +	}
> +	return 0;

Unrelated change - please separate into different patch. Sounds like a
fix?

> +
>  out:
>  	if (!IS_ERR(info->chan_tx))
>  		mbox_free_channel(info->chan_tx);
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index ef3a8214d002..6d8b12341f68 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -35,6 +35,9 @@
>  #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
>  #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
>  
> +/* Low Power Mode Requests */
> +#define TI_SCI_MSG_PREPARE_SLEEP	0x0300

Looking at https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#device-configuration-and-control-apis

Don't you need TISCI_MSG_SET_IO_ISOLATION  support?

Also, reading https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-enter-sleep

"This message is to be sent after TISCI_MSG_PREPARE_SLEEP and actually
triggers entry into the specified low power mode."

our call sequence seems to be just prepare_sleep and expect it to power
off the SoC? does'nt the PMIC need to be powered off?

> +
>  /* Resource Management Requests */
>  #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
>  
> @@ -545,6 +548,34 @@ struct ti_sci_msg_resp_get_clock_freq {
>  	u64 freq_hz;
>  } __packed;
>  
> +#define TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP				0x0
> +#define TISCI_MSG_VALUE_SLEEP_MODE_MCU_ONLY				0x1
> +#define TISCI_MSG_VALUE_SLEEP_MODE_STANDBY				0x2
> +#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x3

Where are these values coming from?
https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-prepare-sleep

Does not seem to have these?

I think we are picking from:
https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes

? The documentation could use a little cleanup there :(

> +
> +/**
> + * struct tisci_msg_prepare_sleep_req - Request for TISCI_MSG_PREPARE_SLEEP.

s/tisci_msg_prepare_sleep_req/ti_sci_msg_req_prepare_sleep ?

> + *
> + * @hdr				TISCI header to provide ACK/NAK flags to the host.
> + * @mode			Low power mode to enter.
> + * @ctx_lo			Low 32-bits of physical pointer to address to use for context save.
> + * @ctx_hi			High 32-bits of physical pointer to address to use for context save.
> + * @debug_flags			Flags that can be set to halt the sequence during suspend or
> + *				resume to allow JTAG connection and debug.

There are no schemes to enable there? Are we going to manually modify
the driver for every step of the debug?

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

Also are we supposed to use this header for other low power sequences?
From the definitions of TISCI_MSG_VALUE_SLEEP_MODE_* it looks like there
are additional usage? Just trying to understand if follow on patches
will not have to refactor things here.

> +
>  #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
>  
>  /**
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

