Return-Path: <linux-kernel+bounces-301700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35195F444
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC7E1F22ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61B188915;
	Mon, 26 Aug 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eI2Dpobv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D9810A12
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683579; cv=none; b=oE1u6c76+uyWCW26CnyeobybyxjNrzMreO7beyG5U2+pB3S6Q5GErWOHOO6mpOmjQJsA7Ih6jWZh0hIN+Nkw4NbqvDURXqcKViXI/eQ83sDf0hVUP686wMcX9X48K2sb9fD8yA6uKhlEQuFMrKBijCId+rnmpy9XSDwZ2ARvOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683579; c=relaxed/simple;
	bh=z/jtllxtsNZCt+TbPEN36qENOU0rG0ZbG8MooqnLb3M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6ytFTZcP+UBMAgzjwY810/ok8JBVFGJ7Bt+bj6utu0TUDnHl6JJsHVwPtKfEXkDA7WpqxM1URE2LF5uOAZ/XZ6f1zqVCjzWeDrXc29r+4HhJjQyxGuwjiiqNM+veV5KfX9+67ZbbpHvMrk6CN4rUBDFtVdNdGWoLkE9IHY0Cto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eI2Dpobv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QEk0rx068367;
	Mon, 26 Aug 2024 09:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724683560;
	bh=pPEGbHnUl6bS+lX9tOFAU103bzjhD10ROCh/EJUSveI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=eI2DpobvE7xfuYnwkiPe1sNHwtRjlE7/W2C8oTLCDC7ROhUhJGZh6MGzBOL4Zu0UI
	 ZlNQys3gXPv2+ZqGLea+U5M+tVaORHfQNjTAMv8JcTv0JhGH51GGT5pSP3tbK8EyFl
	 Sy1+nQdzspBz2eIAqVaIhPKksGNOWTUZoN94P+AM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QEk0qM102196
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 09:46:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 09:46:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 09:46:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QEk0IM073445;
	Mon, 26 Aug 2024 09:46:00 -0500
Date: Mon, 26 Aug 2024 09:46:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v10 1/4] firmware: ti_sci: Add support for querying the
 firmware caps
Message-ID: <20240826144600.phsed6horodp3jlg@unhappy>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-1-bee4314bbdc8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-1-bee4314bbdc8@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:39-20240814, Kevin Hilman wrote:
> From: Georgi Vlaev <g-vlaev@ti.com>
> 

Mostly minor nits below:

> Add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
> the firmware capabilities of the currently running system firmware. The
> message belongs to the TISCI general core message API [1] and is
> available in SysFW version 08.04.03 and above. Currently, the message is
> supported on devices with split architecture of the system firmware (DM
> + TIFS) like AM62x. Old revisions or not yet supported platforms will
> NACK this request.
> 
> We're using this message locally in ti_sci.c to get the low power
> featutes of the FW/SoC. As there's no other kernel consumers yet, this
s/featutes/features/ ?

> is not added to struct ti_sci_core_ops.
> 
> Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
> Device Mgr firmware now manages which low power mode is chosen. Going
> forward, this is the default configuration supported for TI AM62 family
> of devices. The state chosen by the DM can be influenced by sending
> constraints using the new LPM constraint APIs.
> 
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html
> [2] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

While both the links are valid,
      https://software-dl.ti.com/tisci/esd/latest/index.html has been
used in documentation, so we should stay consistent on the domain name
here.

> 
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> [vibhore@ti.com: Support for LPM_DM_MANAGED mode]
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/firmware/ti_sci.h | 22 ++++++++++++++++++++++

[...]

>  
> +/**
> + * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
> + * @handle:		Pointer to TI SCI handle
> + * @fw_caps:		Each bit in fw_caps indicating one FW/SOC capability
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
> +					u64 *fw_caps)
> +{
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	struct ti_sci_msg_resp_query_fw_caps *resp;
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
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_QUERY_FW_CAPS,
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
> +	resp = (struct ti_sci_msg_resp_query_fw_caps *)xfer->xfer_buf;
> +
> +	if (!ti_sci_is_response_ack(resp)) {

Add a dev_err here and indicating failure to detect caps?

> +		ret = -ENODEV;
> +		goto fail;
> +	}
> +
> +	if (fw_caps)
> +		*fw_caps = resp->fw_caps;
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
> @@ -3390,6 +3449,14 @@ static int ti_sci_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Check if the firmware supports any optional low power modes.
> +	 * Old revisions of TIFS (< 08.04) will NACK the request.

Move this comment as part of the function documentation

> +	 */
> +	ret = ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
> +	if (ret || !(info->fw_caps & MSG_FLAG_CAPS_GENERIC))

ret can be set for various reasons including older firmware that may not
support fw_caps - just checking against fw_caps might suffice for the
dev_debug ?

> +		pr_debug("Unable to detect LPM capabilities in fw_caps\n");

Please use dev_dbg

Just 2 cents: adding a dev_dbg with details on what matches we got
might be helpful for products in the field?

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

