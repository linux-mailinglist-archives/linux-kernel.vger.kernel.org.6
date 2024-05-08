Return-Path: <linux-kernel+bounces-172906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7B8BF874
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F28EB2524A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A545BE3;
	Wed,  8 May 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HA7Ydd3f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4252F86;
	Wed,  8 May 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156642; cv=none; b=WGEfKEI3UzTIph+19BGuBWEX5nPbmZOb0I9SIU27TKf2/eY7GmurMWsECB9KqEgcjvUuQ8OH0rnBzEMDmWGsAhJH3+qM1k3sYM2CTaHy5j20ZFyAx8ur9DnrGwMojMIeV2BkpGovGDrTcgJnjlTa9venBQ/yUbHwY3ykJNsJCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156642; c=relaxed/simple;
	bh=mpJMJiFgL29condaFoFct70ooxm4gcroDqJ7evmuU1Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kT383DC/+aTBqKqnGqSVWJdIkOLzsCuF6Fm+wwA1Js28IGkRkXe+BisuaCzBemdt7eIomMfQUlI651yZOJnRTbP7t1BBRkZybBYNa1zC91jj5f3sV98MZ6UxlJhvDnHQ9Lg0vH3St2MeOlc7eu3n7V5P5CKN3Zz973DhetyTsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HA7Ydd3f; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715156640; x=1746692640;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mpJMJiFgL29condaFoFct70ooxm4gcroDqJ7evmuU1Q=;
  b=HA7Ydd3fUHgr/1upXvnvx+2xkOIG9YiTHYOlK2wj/AieGPIhpkIHdG3t
   I7lD14F6IRiebuAe1tEF7YBcVk3KD4UZO+8zoern5dpHyDaAA3JxMz8wo
   FzYDpJgc4mzaFoQJikSF1453q6gB7Wx11mi1eDdZPrRqiT4FkpWfCzBWB
   fXRqvt91EJ9VzMOBx+GwtuxWfn8zDUiBT+1KS5nLnerkgdT19HjmDUgbr
   5AjaCZp+uWmMP2VsHcx8SNeetCCuGf21d9PHQk8HNRXwDWk3aPO3ppRO9
   VxdQzLcfERxXErCu7S9LCfJzbMsKOzN5alKeFW/JmIXBKAEQqY9gbiGAJ
   A==;
X-CSE-ConnectionGUID: 95mBBDA3RYmWRBBoCcE8uQ==
X-CSE-MsgGUID: hHHqQiIfQ4yyC1YLbmX6OQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22154732"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22154732"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:24:00 -0700
X-CSE-ConnectionGUID: IOeDcwVmRcWGeF7CEoDBiQ==
X-CSE-MsgGUID: zU58sGYtTUqlwP90I9IEPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="52021470"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:23:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 May 2024 11:23:51 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: linux-doc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V2 1/3] platform/x86/intel/sdsi: Add ioctl SPDM
 transport
In-Reply-To: <20240507180106.5218-1-david.e.box@linux.intel.com>
Message-ID: <462e6bef-d8fc-16e2-ad8d-7fb18e9a011a@linux.intel.com>
References: <20240507180106.5218-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 May 2024, David E. Box wrote:

> Intel On Demand adds attestation and firmware measurement retrieval
> services through use of the protocols defined the Security Protocols and
> Data Measurement (SPDM) specification. SPDM messages exchanges are used to
> authenticate On Demand hardware and to retrieve signed measurements of the
> NVRAM state used to track feature provisioning and the NVRAM state used for
> metering services. These allow software to verify the authenticity of the
> On Demand hardware as well as the integrity of the reported silicon
> configuration.
> 
> Add an ioctl interface for sending SPDM messages through the On Demand
> mailbox. Provides commands to get a list of SPDM enabled devices, get the
> message size limits for SPDM Requesters and Responders, and perform an SPDM
> message exchange.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf [1]
> ---
> V2
>    - Move size < 4 check into sdsi_spdm_exchange() and add comment
>      clarifying return values of that function.
>    - Use SZ_4K and add helpers
>    - Use devm_kasprintf()
>    - Remove unnecessary parens
>    - Use --attest for long option
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   1 +
>  drivers/platform/x86/intel/sdsi.c             | 210 +++++++++++++++++-
>  include/uapi/linux/intel_sdsi.h               |  81 +++++++
>  4 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/intel_sdsi.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index c472423412bf..20dcc2dbcaf6 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -382,6 +382,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:mathieu.desnoyers@efficios.com>
>  0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
>                                                                       <mailto:nchatrad@amd.com>
> +0xFC  all    linux/intel_sdsi.h
>  0xFD  all    linux/dm-ioctl.h
>  0xFE  all    linux/isst_if.h
>  ====  =====  ======================================================= ================================================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 846187625552..060bd3358cec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11165,6 +11165,7 @@ INTEL SDSI DRIVER
>  M:	David E. Box <david.e.box@linux.intel.com>
>  S:	Supported
>  F:	drivers/platform/x86/intel/sdsi.c
> +F:	include/uapi/linux/intel_sdsi.h
>  F:	tools/arch/x86/intel_sdsi/
>  F:	tools/testing/selftests/drivers/sdsi/
>  
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 277e4f4b20ac..686dd9e4e026 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -11,9 +11,12 @@
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/iopoll.h>
> +#include <linux/intel_sdsi.h>
>  #include <linux/kernel.h>
> +#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/pci.h>
> @@ -42,6 +45,7 @@
>  
>  #define SDSI_ENABLED_FEATURES_OFFSET	16
>  #define SDSI_FEATURE_SDSI		BIT(3)
> +#define SDSI_FEATURE_ATTESTATION	BIT(12)
>  #define SDSI_FEATURE_METERING		BIT(26)
>  
>  #define SDSI_SOCKET_ID_OFFSET		64
> @@ -91,6 +95,7 @@ enum sdsi_command {
>  	SDSI_CMD_PROVISION_CAP		= 0x0008,
>  	SDSI_CMD_READ_STATE		= 0x0010,
>  	SDSI_CMD_READ_METER		= 0x0014,
> +	SDSI_CMD_ATTESTATION		= 0x1012,
>  };
>  
>  struct sdsi_mbox_info {
> @@ -109,12 +114,14 @@ struct disc_table {
>  struct sdsi_priv {
>  	struct mutex		mb_lock;	/* Mailbox access lock */
>  	struct device		*dev;
> +	struct miscdevice	miscdev;
>  	void __iomem		*control_addr;
>  	void __iomem		*mbox_addr;
>  	void __iomem		*regs_addr;
>  	int			control_size;
>  	int			maibox_size;
>  	int			registers_size;
> +	int			id;
>  	u32			guid;
>  	u32			features;
>  };
> @@ -582,6 +589,97 @@ static const struct attribute_group sdsi_group = {
>  };
>  __ATTRIBUTE_GROUPS(sdsi);
>  
> +/*
> + * SPDM transport
> + * Returns size of the response message or an error code on failure.
> + */
> +static int sdsi_spdm_exchange(void *private, const void *request,
> +			      size_t request_sz, void *response,
> +			      size_t response_sz)
> +{
> +	struct sdsi_priv *priv = private;
> +	struct sdsi_mbox_info info = {};
> +	size_t spdm_msg_size, size;
> +	int ret;
> +
> +	/*
> +	 * For the attestation command, the mailbox write size is the sum of:
> +	 *     Size of the SPDM request payload, padded for qword alignment
> +	 *     8 bytes for the mailbox command
> +	 *     8 bytes for the actual (non-padded) size of the SPDM request
> +	 */
> +	if (request_sz > SDSI_SIZE_WRITE_MSG - 2 * sizeof(u64))
> +		return -EOVERFLOW;
> +
> +	info.size = round_up(request_sz, sizeof(u64)) + 2 * sizeof(u64);
> +
> +	u64 *payload __free(kfree) = kzalloc(info.size, GFP_KERNEL);
> +	if (!payload)
> +		return -ENOMEM;
> +
> +	memcpy(payload, request, request_sz);
> +
> +	/* The non-padded SPDM payload size is the 2nd-to-last qword */
> +	payload[(info.size / sizeof(u64)) - 2] = request_sz;
> +
> +	/* Attestation mailbox command is the last qword of payload buffer */
> +	payload[(info.size / sizeof(u64)) - 1] = SDSI_CMD_ATTESTATION;
> +
> +	info.payload = payload;
> +	info.buffer = response;
> +
> +	ret = mutex_lock_interruptible(&priv->mb_lock);
> +	if (ret)
> +		return ret;
> +	ret = sdsi_mbox_write(priv, &info, &size);
> +	mutex_unlock(&priv->mb_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The read size is the sum of:
> +	 *     Size of the SPDM response payload, padded for qword alignment
> +	 *     8 bytes for the actual (non-padded) size of the SPDM payload
> +	 */
> +
> +	if (size < sizeof(u64)) {
> +		dev_err(priv->dev,
> +			"Attestation error: Mailbox reply size, %ld, too small\n",
> +			size);

For size_t, %zu is the correct printf format. There are more of these 
below but I won't mark them explicitly.

> +		return -EPROTO;
> +	}
> +
> +	if (!IS_ALIGNED(size, sizeof(u64))) {
> +		dev_err(priv->dev,
> +			"Attestation error: Mailbox reply size, %ld, is not aligned\n",
> +			size);
> +		return -EPROTO;
> +	}
> +
> +	/*
> +	 * Get the SPDM response size from the last QWORD and check it fits
> +	 * with no more than 7 bytes of padding
> +	 */
> +	spdm_msg_size = ((u64 *)info.buffer)[(size - sizeof(u64)) / sizeof(u64)];
> +	if (!in_range(size - spdm_msg_size - sizeof(u64), 0, 8)) {
> +		dev_err(priv->dev,
> +			"Attestation error: Invalid SPDM response size, %ld\n",
> +			spdm_msg_size);
> +		return -EPROTO;
> +	}
> +
> +	if (spdm_msg_size > response_sz || spdm_msg_size < SPDM_HEADER_SIZE) {
> +		dev_err(priv->dev, "Attestation error: Expected response size %ld, got %ld\n",
> +			response_sz, spdm_msg_size);
> +		return -EOVERFLOW;
> +	}
> +
> +	memcpy(response, info.buffer, spdm_msg_size);
> +
> +	return spdm_msg_size;
> +}
> +
>  static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
>  {
>  	switch (table->guid) {
> @@ -649,6 +747,92 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
>  	return 0;
>  }
>  
> +#define SDSI_SPDM_DRIVER_VERSION	1
> +
> +static int sdsi_spdm_get_info(struct sdsi_priv *priv,
> +			      struct sdsi_spdm_info __user *argp)
> +{
> +	struct sdsi_spdm_info info;
> +
> +	info.driver_version = SDSI_SPDM_DRIVER_VERSION;
> +	info.api_version = priv->guid;
> +	info.dev_no = priv->id;
> +	info.max_request_size = SDSI_SIZE_WRITE_MSG - 2 * sizeof(u64);
> +	info.max_response_size = SDSI_SIZE_READ_MSG - sizeof(u64);
> +
> +	if (copy_to_user(argp, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int sdsi_spdm_do_command(struct sdsi_priv *priv,
> +				struct sdsi_spdm_command __user *argp)
> +{
> +	u32 req_size, rsp_size;
> +
> +	if (get_user(req_size, &argp->size))
> +		return -EFAULT;
> +
> +	if (req_size < 4 || req_size > sizeof(struct sdsi_spdm_message))
> +		return -EINVAL;
> +
> +	struct sdsi_spdm_message *request __free(kfree) =
> +		kmalloc(req_size, GFP_KERNEL);
> +	if (!request)
> +		return -ENOMEM;
> +
> +	struct sdsi_spdm_command *response __free(kfree) =
> +		kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(request, &argp->message, req_size))
> +		return -EFAULT;
> +
> +	rsp_size = sdsi_spdm_exchange(priv, request, req_size, response,
> +				      SDSI_SIZE_READ_MSG);
> +	if (rsp_size < 0)
> +		return rsp_size;
> +
> +	if (put_user(rsp_size, &argp->size))
> +		return -EFAULT;
> +
> +	if (copy_to_user(&argp->message, response, rsp_size))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long sdsi_spdm_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct sdsi_priv *priv;
> +	long ret = -ENOTTY;
> +
> +	priv = container_of(file->private_data, struct sdsi_priv, miscdev);
> +
> +	switch (cmd) {
> +	case SDSI_IF_SPDM_INFO:
> +		ret = sdsi_spdm_get_info(priv,
> +				(struct sdsi_spdm_info __user *)arg);
> +		break;
> +	case SDSI_IF_SPDM_COMMAND:
> +		ret = sdsi_spdm_do_command(priv,
> +				(struct sdsi_spdm_command __user *)arg);

You can return directly.

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;

return -ENOTTY;

and remove the ret variable entirely.


-- 
 i.


