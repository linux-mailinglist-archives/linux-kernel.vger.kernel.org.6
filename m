Return-Path: <linux-kernel+bounces-301866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60F95F6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC59B20AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE51953B9;
	Mon, 26 Aug 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tk5lgmQ5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AE194A64
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690104; cv=none; b=c9CynaaQSRjns1qL/rxIVYRKsITViCNQVRmfFQLa3vSOrwt0WEOgKq1odo5NZ8cfj+P0OgVKVm7Cw+bvtHHV7EpsT0dgGiBcrAmFMLuI1jqXX5yYf4fj6rdxQBeIyaBaDSsSw4L6mTLuf/t7QpgCzJY3HiA+huKdYJJaHrFPGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690104; c=relaxed/simple;
	bh=8abPnt+7ZjmtR3qz5HAYMiYvqcjKHCSDpYMKYJgvPhQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5RbMHGKlsNIg+AsO5G3R5JnBqTIlsSMX/+ky9mq8WuisU00Qlb8Qx8Y3DossRyyTwsf6yJEZWm1DIItvwbue1eWk1yCGIvy1XGvvd4vWy6Z2v5GyxUIKogcF+1mbUHp2gjUdCqmktKw5jvift0HXX4JTaphvx0t4NXlYjxVMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tk5lgmQ5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QGYueK119717;
	Mon, 26 Aug 2024 11:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724690096;
	bh=+tBVzV0riob7xfH4wlOcVf38jJoFf60E+6QObXwL9I0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tk5lgmQ5OTGRtDF63kdHdK1MKwnXDA/timSK06H7fQGGTcUzuHbuLmp0uepDwxChT
	 yTksf6r17R/F7DiBZ7roHGDTun6p2Dx/4NZKgO4CI1uPDV34fsR0x25IhwE0gCxxbo
	 UUYkjpHktFUDWkr8EpxGt6MXlK0P5TQ/bWBsfCgI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QGYu6R044969
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 11:34:56 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 11:34:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 11:34:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QGYtqc071677;
	Mon, 26 Aug 2024 11:34:55 -0500
Date: Mon, 26 Aug 2024 11:34:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v10 2/4] firmware: ti_sci: Add system suspend and resume
 call
Message-ID: <20240826163455.bp3a6lxtimiquzq5@ascertain>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-2-bee4314bbdc8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-2-bee4314bbdc8@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:39-20240814, Kevin Hilman wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
[...]

> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
> +				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
> +{
> +	struct ti_sci_info *info;
> +	struct ti_sci_msg_req_prepare_sleep *req;
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
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
> +	req->mode = mode;
> +	req->ctx_lo = ctx_lo;
> +	req->ctx_hi = ctx_hi;
> +	req->debug_flags = debug_flags;
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

Here and other functions:

I think adding a dev_err for a NAKed message is probably useful for debug.

> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +	return ret;
> +}
> +
>  /**
>   * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
>   * @handle:		Pointer to TI SCI handle
> @@ -1710,6 +1770,58 @@ static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
>  	return ret;
>  }
>  
> +/**
> + * ti_sci_cmd_set_io_isolation() - Enable IO isolation in LPM
> + * @handle:		Pointer to TI SCI handle
> + * @state:		The desired state of the IO isolation
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
> +				       u8 state)

I probably might have preferred to have set_io_isolation as a
different patch, but OK, it is not too hard to see the hookup
commonality.

> +{
> +	struct ti_sci_info *info;
> +	struct ti_sci_msg_req_set_io_isolation *req;
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
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_SET_IO_ISOLATION,
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
> +		return ret;
> +	}
> +	req = (struct ti_sci_msg_req_set_io_isolation *)xfer->xfer_buf;
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

here as well.

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
> @@ -3321,6 +3433,79 @@ static int tisci_reboot_handler(struct sys_off_data *data)
>  	return NOTIFY_BAD;
>  }
>  
> +#ifdef CONFIG_SUSPEND
> +static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
> +{
> +	u8 mode;
> +
> +	/*
> +	 * Map and validate the target Linux suspend state to TISCI LPM.
> +	 * Default is to let Device Manager select the low power mode.
> +	 */
> +	switch (pm_suspend_target_state) {
> +	case PM_SUSPEND_MEM:
> +		if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED)
> +			mode = TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED;
> +		else
> +			/* DM Managed is not supported by the firmware. */

dev_err print is useful for debug?

> +			return -EOPNOTSUPP;
> +		break;
> +	default:
> +		/*
> +		 * Do not fail if we don't have action to take for a
> +		 * specific suspend mode.
> +		 */
> +		return 0;
> +	}
> +
> +	return ti_sci_cmd_prepare_sleep(&info->handle, mode, 0, 0, 0);

Umm.. context address is 0x0?

> +}
> +
> +static int ti_sci_suspend(struct device *dev)
> +{
> +	struct ti_sci_info *info = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = ti_sci_prepare_system_suspend(info);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ti_sci_suspend_noirq(struct device *dev)
> +{
> +	struct ti_sci_info *info = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
> +	if (ret)
> +		return ret;

Does this add any value here?

> +	dev_dbg(dev, "%s: set isolation: %d\n", __func__, ret);
> +
> +	return 0;
> +}
> +
> +static int ti_sci_resume_noirq(struct device *dev)
> +{
> +	struct ti_sci_info *info = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
> +	if (ret)
> +		return ret;

Same..
> +	dev_dbg(dev, "%s: disable isolation: %d\n", __func__, ret);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ti_sci_pm_ops = {
> +	.suspend = ti_sci_suspend,
> +	.suspend_noirq = ti_sci_suspend_noirq,
> +	.resume_noirq = ti_sci_resume_noirq,
> +};
> +#endif  /* CONFIG_SUSPEND */

Mostly, I am seeing usage with CONFIG_PM_SLEEP instead of
CONFIG_SUSPEND. is that a better option? and further,  usage tends to be
as follows:

static int __maybe_unused ti_sci_resume_noirq(struct device *dev)

static const struct dev_pm_ops ti_sci_pm_ops = {
#ifdef CONFIG_PM_SLEEP
	.suspend = ti_sci_suspend,
	.suspend_noirq = ti_sci_suspend_noirq,
	.resume_noirq = ti_sci_resume_noirq,
#endif
};

Keeps the #ifdeffery just localized to one place.

Thoughts?

> +
>  /* Description for K2G */
>  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>  	.default_host_id = 2,
> @@ -3490,6 +3675,9 @@ static struct platform_driver ti_sci_driver = {
>  		   .name = "ti-sci",
>  		   .of_match_table = of_match_ptr(ti_sci_of_match),
>  		   .suppress_bind_attrs = true,
> +#ifdef CONFIG_SUSPEND
> +		   .pm = &ti_sci_pm_ops,
> +#endif
>  	},
>  };
>  module_platform_driver(ti_sci_driver);

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

