Return-Path: <linux-kernel+bounces-301895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0C95F6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B37D1F22BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E0194C61;
	Mon, 26 Aug 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yiu2g/eF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA02F870
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690636; cv=none; b=CXwBb7vjmmKlnTZtz5lFbLx91h7FYhSEWpWTxQqLgfokdknNz4qj6kRb3puC/lQ5YSuji3hojDiopt7782pn60RTwPfVfM3KDo8xTvsvZXtlKLVaWu24/4W47KX3bHPrf6wHR0ptvN7GfHy7J+OXPOin8LtmaUbnAbAp7ccJlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690636; c=relaxed/simple;
	bh=7+AdKPh34E9ZX3q9C/I0R9uuP//7XFQs7hxQHgSWGdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvPru6VIG0pPD6vSwCKZhcy7hRL/06LeDRgTkXMmFYVTCkOPEyAqCDZA//RVdZgDIlFzuplIHYlCJvCBVM92GOCNZ2ycYFzj/KXnO09En48qN0iQ4kZZEV9yV58lcZCrCXDfBF5txZlbchO0A+sHk/Z7/Fb9icmDDZb/P7/6cZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yiu2g/eF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QGhlvh123946;
	Mon, 26 Aug 2024 11:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724690627;
	bh=rrLKagzVebS5ikDTKxZWxRLbfVMW+F9ZvokvLXTaRRY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Yiu2g/eFFOEQLPKziDUNbMCKmgSfTnJzYmQnR651y0E2jr0g05/vKTcbjuzm/oicB
	 S/MRIQhzXs3QQXpde7vz1+JOL9PdFtJzOYq82HaZUSYEwvQkSJtE/4wQMq/i4BgwWG
	 dcHuxiaa7aykqGsGkrEY/WAS7risDkDlWeoM4Mic=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QGhlJp030956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 11:43:47 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 11:43:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 11:43:46 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QGhklx079967;
	Mon, 26 Aug 2024 11:43:46 -0500
Date: Mon, 26 Aug 2024 11:43:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240826164346.e73vfvd4jzezlbc7@cherisher>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:39-20240814, Kevin Hilman wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
[...]
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 808149dcc635..107494406fa5 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1822,6 +1822,179 @@ static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
>  	return ret;
>  }
>  
> +/**
> + * ti_sci_msg_cmd_lpm_wake_reason() - Get the wakeup source from LPM
> + * @handle:		Pointer to TI SCI handle
> + * @source:		The wakeup source that woke the SoC from LPM
> + * @timestamp:		Timestamp of the wakeup event
> + * @pin:		The pin that has triggered wake up
> + * @mode:		The last entered low power mode
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
> +					  u32 *source, u64 *timestamp, u8 *pin, u8 *mode)
> +{
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	struct ti_sci_msg_resp_lpm_wake_reason *resp;
> +	struct device *dev;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +	dev = info->dev;
> +
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_WAKE_REASON,
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(struct ti_sci_msg_hdr),
> +				   sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "Mbox send fail %d\n", ret);
> +		goto fail;
> +	}
> +
> +	resp = (struct ti_sci_msg_resp_lpm_wake_reason *)xfer->xfer_buf;
> +
> +	if (!ti_sci_is_response_ack(resp)) {

A dev_err might be worth here.

> +		ret = -ENODEV;
> +		goto fail;
> +	}
> +
> +	if (source)
> +		*source = resp->wake_source;
> +	if (timestamp)
> +		*timestamp = resp->wake_timestamp;
> +	if (pin)
> +		*pin = resp->wake_pin;
> +	if (mode)
> +		*mode = resp->mode;
> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +	return ret;
> +}
> +
> +/**
> + * ti_sci_cmd_set_device_constraint() - Set LPM constraint on behalf of a device
> + * @handle:	pointer to TI SCI handle
> + * @id:	Device identifier
> + * @state:	The desired state of device constraint: set or clear
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_set_device_constraint(const struct ti_sci_handle *handle,
> +					    u32 id, u8 state)
> +{
> +	struct ti_sci_info *info;
> +	struct ti_sci_msg_req_lpm_set_device_constraint *req;
> +	struct ti_sci_msg_hdr *resp;
> +	struct ti_sci_xfer *xfer;
> +	struct device *dev;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +	dev = info->dev;
> +
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT,
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +	req = (struct ti_sci_msg_req_lpm_set_device_constraint *)xfer->xfer_buf;
> +	req->id = id;
> +	req->state = state;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "Mbox send fail %d\n", ret);
> +		goto fail;
> +	}
> +
> +	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> +
> +	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;

A dev_err might be worth here. - same elsewhere. I see a different style
of if (ret) vs ? 0: -ENODEV usage - might be good to be
consistent through out.

> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +	return ret;
> +}
> +
> +/**
> + * ti_sci_cmd_set_latency_constraint() - Set LPM resume latency constraint
> + * @handle:	pointer to TI SCI handle
> + * @latency:	maximum acceptable latency (in ms) to wake up from LPM
> + * @state:	The desired state of latency constraint: set or clear
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
> +					     u16 latency, u8 state)
> +{
> +	struct ti_sci_info *info;
> +	struct ti_sci_msg_req_lpm_set_latency_constraint *req;
> +	struct ti_sci_msg_hdr *resp;
> +	struct ti_sci_xfer *xfer;
> +	struct device *dev;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +	dev = info->dev;
> +
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT,
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +	req = (struct ti_sci_msg_req_lpm_set_latency_constraint *)xfer->xfer_buf;
> +	req->latency = latency;
> +	req->state = state;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "Mbox send fail %d\n", ret);
> +		goto fail;
> +	}
> +
> +	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> +
> +	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;

Same

> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +	return ret;
> +}
> +
>  static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
>  {
>  	struct ti_sci_info *info;
> @@ -2964,6 +3137,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	struct ti_sci_core_ops *core_ops = &ops->core_ops;
>  	struct ti_sci_dev_ops *dops = &ops->dev_ops;
>  	struct ti_sci_clk_ops *cops = &ops->clk_ops;
> +	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
>  	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
>  	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
>  	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
> @@ -3003,6 +3177,13 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	cops->set_freq = ti_sci_cmd_clk_set_freq;
>  	cops->get_freq = ti_sci_cmd_clk_get_freq;
>  
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> +		pr_debug("detected DM managed LPM in fw_caps\n");
> +		pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
> +		pmops->set_device_constraint = ti_sci_cmd_set_device_constraint;
> +		pmops->set_latency_constraint = ti_sci_cmd_set_latency_constraint;
> +	}
> +
>  	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
>  	rm_core_ops->get_range_from_shost =
>  				ti_sci_cmd_get_resource_range_from_shost;
> @@ -3490,12 +3671,20 @@ static int ti_sci_resume_noirq(struct device *dev)
>  {
>  	struct ti_sci_info *info = dev_get_drvdata(dev);
>  	int ret = 0;
> +	u32 source;
> +	u64 time;
> +	u8 pin;
> +	u8 mode;
>  
>  	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
>  	if (ret)
>  		return ret;
>  	dev_dbg(dev, "%s: disable isolation: %d\n", __func__, ret);
>  
> +	ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);

No handling of error?

> +	dev_info(dev, "ti_sci: wakeup source:0x%x, pin:0x%x, mode:0x%x\n",
> +		 source, pin, mode);
> +
>  	return 0;
>  }
>  
	[...]
>  
>  /**
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 1f1871e23f76..4ba9e520a28f 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -199,6 +199,47 @@ struct ti_sci_clk_ops {
>  #define TISCI_MSG_VALUE_IO_ENABLE			1
>  #define TISCI_MSG_VALUE_IO_DISABLE			0
>  
> +/* TISCI LPM wake up sources */
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81

^^ I assume these are daisy chain sources. - will these remain OR do we
have to consider the wake sources SoC dependent? If so, the
sci_protocol.h will be SoC agnostic..


> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_CAN_IO		0x82
> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_INVALID		0xFF
> +
> +/* TISCI LPM constraint state values */
> +#define TISCI_MSG_CONSTRAINT_SET			1
> +#define TISCI_MSG_CONSTRAINT_CLR			0
> +

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

