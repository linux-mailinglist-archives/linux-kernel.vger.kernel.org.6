Return-Path: <linux-kernel+bounces-432846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2A9E50FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362E5282CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E31C3C18;
	Thu,  5 Dec 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcG1+ZfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1D193429;
	Thu,  5 Dec 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390155; cv=none; b=JBtiMbPo58Yxla/lN8EcsnZMYZLd3+2G4HzA8D0njPh6lgtberpnI9cy3ckW8krTQirZCei4NujFuUDyly8lpHJnwXxKRQLrLATGPhVM5CJb0SZMXLYcLGtf8MDWZ/yzlr2q4xR5L2sD7dptqesVLVDT6WATtEJVRbxguTlCQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390155; c=relaxed/simple;
	bh=QxsS1zt4cKu7VPdlxLyUmcsdHRV9xaGmHvKPAtuRewE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IorvAAhtxQp4aJKCyf2xlJtSyeOYBB6f1PYjFGZ9UJn3yQDLG5J4VElD51fD7jd+UosIWno4sFpmZPUSLjINqywaFHh50mYhTHGO/Js9Vj75JyI09jOkWM4BnkboPb4NRSsYNSwN1zp7pzKgHpn8a5rqRaVyCbfXiGvgtZUpnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcG1+ZfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFF6C4CEDE;
	Thu,  5 Dec 2024 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390155;
	bh=QxsS1zt4cKu7VPdlxLyUmcsdHRV9xaGmHvKPAtuRewE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcG1+ZfMM2JuVSoAttk82yF39pLUmtI9CaYcpQTWxHQ2B2HWn3gRgqyO4Jt90j9lW
	 5QAmvD57cTKI8UkZOW/AzPfN99Cp//+jwyeedvZt9c4+2Z/JZ1FWVw9In5KQHqvzvF
	 LNink6QIpfLwPlXngozSNm1p0PR+F1tc4EvAkTVTHMCE1yrbalksb0iJeU/9Rx5Lxv
	 fHgxvay9nfWig2wQUZCT5qVZP9nloU85K1toMzTi+fs7bCx4xUJXBLtkN/v3Pwrty4
	 nkdWbJktWh41loqOgqRjp/Kmo0KFAGrQRTi41kUNorvrSOnvpfE5LZAMuCcty6hDxu
	 LMYlPB/Sqe4nQ==
Date: Thu, 5 Dec 2024 10:15:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, V.Sethi@nxp.com, 
	meenakshi.aggarwal@nxp.com, Franck LENORMAND <franck.lenormand@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH v4 3/4] firmware: imx: Add SC APIs required for secvio
 module
Message-ID: <bdwn6slol2pnpf25xmcyx6rro5jaiadpob5fvl45ngtru3bea3@pucfhsmsxrct>
References: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
 <20241205-secvio-v4-3-5c37cdc39573@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-secvio-v4-3-5c37cdc39573@nxp.com>

On Thu, Dec 05, 2024 at 05:56:34AM +0100, Vabhav Sharma wrote:
> The Security Violation module requires below System Controller
> Security controller API to interact with SNVS block via SCFW
>     - imx_sc_seco_build_info
>     - imx_sc_seco_secvio_enable
>     - imx_sc_seco_secvio_config
>     - imx_sc_seco_secvio_dgo_config
> 
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Horia Geanta<horia.geanta@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  drivers/firmware/imx/Makefile         |   2 +-
>  drivers/firmware/imx/imx-scu.c        |   4 +-
>  drivers/firmware/imx/seco.c           | 216 ++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/ipc.h      |   1 +
>  include/linux/firmware/imx/sci.h      |   4 +
>  include/linux/firmware/imx/svc/seco.h |  69 +++++++++++
>  6 files changed, 294 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8d046c341be8..7aaecf570c56 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
> -obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
>  obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 1dd4362ef9a3..c96dc73689a8 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -242,9 +242,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
>  		 * APIs are defined as void function in SCU firmware, so they
>  		 * should be treated as return success always.
>  		 */
> -		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
> +		if (((saved_svc == IMX_SC_RPC_SVC_MISC) &&
>  			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
>  			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
> +			 || (saved_svc == IMX_SC_RPC_SVC_SECO &&
> +			 saved_func == IMX_SC_SECO_FUNC_BUILD_INFO))
>  			ret = 0;
>  	}
>  
> diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
> new file mode 100644
> index 000000000000..2d6bf301ac87
> --- /dev/null
> +++ b/drivers/firmware/imx/seco.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2020, 2024 NXP
> + *
> + * File containing client-side RPC functions for the SECO service. These
> + * function are ported to clients that communicate to the SC.
> + */
> +
> +#include <linux/firmware/imx/sci.h>
> +
> +struct imx_sc_msg_seco_get_build_id {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 version;
> +	u32 commit;
> +} __packed __aligned(4);
> +
> +int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
> +			   uint32_t *commit)
> +{
> +	struct imx_sc_msg_seco_get_build_id msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_SECO;
> +	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
> +	hdr->size = 1;
> +
> +	ret = imx_scu_call_rpc(ipc, &msg, true);
> +	if (ret)
> +		return ret;
> +
> +	if (version)
> +		*version = msg.version;
> +	if (commit)
> +		*commit = msg.commit;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx_sc_seco_build_info);


NAK for all your exports: no users. Stop adding exports for your
downstream drivers.

Best regards,
Krzysztof


