Return-Path: <linux-kernel+bounces-243280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB28E9293F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AEA1C216CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B0137757;
	Sat,  6 Jul 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS32CIJY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519C77104;
	Sat,  6 Jul 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274709; cv=none; b=NU36slbWVqpHBI9Byn++uiYGv01kX+X54mf2C89iDx9uKhHvRncxmOGNNp5m+qsZIAo+KSCFAFQbmDnXgb1TEyCiEz7hSBhDb8wDGz00lyZqNNtMdFqwScJPiTnM6nvwoeftSIFWMQE5TAKZrHfTfe3ZwKTwRQiFlfg6pfkYl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274709; c=relaxed/simple;
	bh=zDA7DjIHng7gBzabRQ4/boNw6+/aaA+4H7gLsS+Vfos=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t3KazlQXzfdv56qEveEqF/aFnTOUT+u79GVc2fGmTBJ6UmHWV6QMl6YKG82lhh7tv6DB0vXO/Yef2mmiRF0W49pZdgkopNa81Cjtk+aqm4DTlrSgTo92MMbtgZC1T0a9ABzGGqHDyIbbobJbkl3thffab36YAWV+aDQvXA/uriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS32CIJY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720274708; x=1751810708;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zDA7DjIHng7gBzabRQ4/boNw6+/aaA+4H7gLsS+Vfos=;
  b=nS32CIJYMvDn5J/N4X7pDccDyXxlgLA/bcj564WoPGkbsI6HHDi7gs/J
   NZq+s5KoNe7TEuBJQE/BIl0b3h9ccBeQ8ld3BPFlEjk6ltVRxDTxdkE2x
   +RqVQnnhmBF5Gv08Ei8H7uyrPQu3V3m26hIR4XIdGfZDBaXtXvBqJ9G6r
   byD2I377jOmEaS3hvNKf57jycMw42crw7LDQcKMJoieZrAO11iwRGBD7W
   oG6bHZmbXLJNuAQHHRk7A8fLpfpXLWk/I/eBM1eJkBEg++4s1VG5VT2HF
   PXeaxnpcVHR8/xgPnyIdT2yGmmRHKHt1bcxHDLKZovPc0+J33QuN+v/yM
   A==;
X-CSE-ConnectionGUID: ryql6drFSLKuFAhNxA5sqQ==
X-CSE-MsgGUID: lQDWxKntQkmApgHIJ8MSEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17664921"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="17664921"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 07:05:07 -0700
X-CSE-ConnectionGUID: CIx505l9Q+ik7gk6M2SA/Q==
X-CSE-MsgGUID: oUvsf7XURJqcpTxGFgQn1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47823537"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.111])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 07:05:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 6 Jul 2024 17:05:01 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: linux-doc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V4 1/3] platform/x86/intel/sdsi: Add ioctl SPDM
 transport
In-Reply-To: <20240608034247.181843-1-david.e.box@linux.intel.com>
Message-ID: <9dff7095-9796-dbf1-3269-d0e480cccaec@linux.intel.com>
References: <20240608034247.181843-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Jun 2024, David E. Box wrote:

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
> V4
>    - In sdsi_spdm_do_command(), change rsp_size from u32 to int to
>      catch error from sdsi_spdm_exchange(). Reported by lkp.
>    - Use SPDM_HEADER_SIZE in sdsi_spdm_do_command()
> V3
>    - Use %zu format for size_t
>    - Simplify return in sdsi_spdm_ioctl()
> 
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
>  drivers/platform/x86/intel/sdsi.c             | 209 +++++++++++++++++-
>  include/uapi/linux/intel_sdsi.h               |  81 +++++++
>  4 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/intel_sdsi.h

> diff --git a/include/uapi/linux/intel_sdsi.h b/include/uapi/linux/intel_sdsi.h
> new file mode 100644
> index 000000000000..8e28764f4a98
> --- /dev/null
> +++ b/include/uapi/linux/intel_sdsi.h

> +/**
> + * struct sdsi_spdm_message - The SPDM message sent and received from the device
> + * @spdm_version:		Supported SPDM version
> + * @request_response_code:	The SPDM message code for requests and responses
> + * @param1:			Parameter 1
> + * @param2:			Parameter 2
> + * @buffer:			SDPM message specific buffer
> + *

Extra newline here.

> + */
> +struct sdsi_spdm_message {
> +	SPDM_HEADER;
> +	__u8 buffer[SZ_4K - SPDM_HEADER_SIZE];
> +};


-- 
 i.


