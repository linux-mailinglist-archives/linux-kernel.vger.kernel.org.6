Return-Path: <linux-kernel+bounces-267470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991689411E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF231C23201
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0819EED3;
	Tue, 30 Jul 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WDw95eZ2"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8A18F2FF;
	Tue, 30 Jul 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342490; cv=none; b=W6WvWdMeBpmYUjcx9EOTddHYj88itVkp3C+RM5MrnNkQrm4IlrtcVQYMnXGVSlhk+CkbzwlA/n23UL1qrj2RHn5awkC04JKxi+7van/cYz5/fi7dk/t3eUV20ppD9LwVSBNxab6XTFQdwDUIfdz5/KuSDBg0QLY8g7etQCeYJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342490; c=relaxed/simple;
	bh=3yMZ5H3LG66tCZWcVqIT98+fTDkfkMun8jW45XXpPLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJnx7kGFhMhD7utY3sEXWH6c7DoD7zVmKhSI9ncU7b0ZzKsWumS5ZP7K1/Dg1FTyHsEE/uHVuHvcyHYxxHhj0d88XMG8cFsPtlWp0ob5ZwBOWwJKmTWYZt5FFl6w0ValP9H8CmMxq6U659SKaTjBsGaG5TqhW2YYUB0G3gcQbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WDw95eZ2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UCS1jk046064;
	Tue, 30 Jul 2024 07:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722342481;
	bh=Mj7vienUobj8v6f3b/FHGW2m18yRGe3qtBMwD7ZsNn8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WDw95eZ22eEChiJ6jRESxhAwzR9obX8dSbFZRTnVNuMT0KnVmeHBwseYBoM/P6Vkf
	 Y7MpfBLeTlbck8qglnFLBkCTtmTljUEeq9m6PWkJDT494wjEYx/d5DjgrYN8EB21sT
	 cqvPlgQkI1Nx8pDxUEoaKo/nlWF2ESHOwYocB0OM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UCS1nJ037975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 07:28:01 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 07:28:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 07:28:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UCS1Wx107344;
	Tue, 30 Jul 2024 07:28:01 -0500
Date: Tue, 30 Jul 2024 07:28:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <20240730122801.jzo5ahkurxaexwcm@ambiance>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729080101.3859701-3-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:00-20240729, Markus Schneider-Pargmann wrote:
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
>   https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 160 +++++++++++++++++++++++++++++++++-----
>  drivers/firmware/ti_sci.h |  34 ++++++++
>  2 files changed, 175 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 160968301b1f..ba2e56da0215 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -99,6 +99,9 @@ struct ti_sci_desc {
>   * @node:	list head
>   * @host_id:	Host ID
>   * @users:	Number of users of this instance
> + * @nr_wakeup_sources: Number of device nodes in wakeup_source_nodes
> + * @wakeup_source_nodes: Array of all device_nodes listed as wakeup sources in
> + *			 the devicetree
>   */
>  struct ti_sci_info {
>  	struct device *dev;
> @@ -116,6 +119,9 @@ struct ti_sci_info {
>  	u8 host_id;
>  	/* protected by ti_sci_list_mutex */
>  	int users;
> +
> +	int nr_wakeup_sources;
> +	struct device_node **wakeup_source_nodes;
>  };
>  
>  #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
> @@ -392,10 +398,13 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
>  static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>  				 struct ti_sci_xfer *xfer)
>  {
> +	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
>  	int ret;
>  	int timeout;
>  	struct device *dev = info->dev;
>  	bool done_state = true;
> +	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
> +						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));

I think a separate patch to introduce a no_response expected patch would
make sense on which we build tisci_sys_off_handler in the next patch?

>  
>  	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
>  	if (ret < 0)
> @@ -403,25 +412,27 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>  
>  	ret = 0;
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

	How about a goto?

if (!response_expected)
	goto no_response;
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
no_response:

>  	/*
>  	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> @@ -3262,6 +3273,82 @@ static int tisci_reboot_handler(struct sys_off_data *data)
>  	return NOTIFY_BAD;
>  }
>  
[...]

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
> +	if (ret) {
> +		dev_err(info->dev,
> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> +			ERR_PTR(ret));
> +		emergency_restart();
> +	}
> +
> +	while (1);

Why not fall through OR go through emergency_restart (since there is
no fall through for shutdown path) if it acks, but actually fails to
enter LPM state after a dt described or a default timeout period?

> +
> +	return NOTIFY_DONE;
> +}
> +
>  /* Description for K2G */
>  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>  	.default_host_id = 2,
> @@ -3398,6 +3485,35 @@ static int ti_sci_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	if (of_property_read_bool(dev->of_node, "ti,partial-io-wakeup-sources")) {

You should probably check on TISCI_MSG_QUERY_FW_CAPS[1] if
Partial IO on low power mode is supported as well? if there is a
mismatch, report so?

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

Curious: Don't we need to maintain reference counting for the devnode
if CONFIG_OF_DYNAMIC?

	[...]

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

