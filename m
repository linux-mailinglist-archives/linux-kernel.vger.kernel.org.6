Return-Path: <linux-kernel+bounces-243279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAC9293F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247871F220DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20816135A79;
	Sat,  6 Jul 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/WkLFEL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BE74070;
	Sat,  6 Jul 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274621; cv=none; b=EFFbqLxB6LSPYSJoTtksVVOTtarJXFvdRMpl6hhQ4L0KEY1Y9YXK/cnmje1i80CXne8LA8nkPPS/ctQFCH1+GcmpcB/l/9Yctq/It4s8Kn2AWw2FqMW4Ks6l8/SYOKoSP+mNmZSByZYV7saxFaumPpWFU9bQafB/0+niur2yyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274621; c=relaxed/simple;
	bh=CaJj4a2hkJ8XkHv9OyV8QGNBDNfocv2VKU+HWs5oG/U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ilMYG45eZrV0hkEH7ccmDugxJwN4cVW8wm0OlJn7Y0AA0dta2MQnpfJ/9MlcOqKg07ueLAB0ikpRTL7VW6CzaTM0QkujMq+stO7b1Sm2nvebdGkbi1cAQshyW0Ysdyg8EjgHaWbDkkL9zB2zQmKJKTiiJQX8L21wAiEMFnLqIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/WkLFEL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720274619; x=1751810619;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CaJj4a2hkJ8XkHv9OyV8QGNBDNfocv2VKU+HWs5oG/U=;
  b=D/WkLFELdCjj431+TAm5KZAbn3NOFgAiUOVPfBOvrKXH+MJJdTtAqH3n
   5GnPxEB0yylzVbqZq4XoFWc44/7pi+NIjQBhgtwPIjfkLYHvSNj4xt27g
   6wjmopVWWj2K3FzYkg2ayd/66kfKNP6sl4ykDc79ypNJEiNoCUBUC1NYl
   YhU+cDuHyF4qnG6YzFR/shvEoJOctPuc7+V/zYLZN1J9ZEXd8cixopxmX
   ptHLfvFnUPvB+TJAyTQChG7Brz/rUL/HnDAf/HwJvMPkywKbJeyXpC8ED
   6exLoLrLJxk21/hMlxmFKMca/jcn75C+PYqQk/7HGHbWIWtv5i6wl/eoo
   g==;
X-CSE-ConnectionGUID: i4lU+A05TCOcCCsPPaLt8A==
X-CSE-MsgGUID: lx7wyst8Rh2iIXTGlIyBYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="21303381"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="21303381"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 07:03:38 -0700
X-CSE-ConnectionGUID: GIlTlh5dSdCBt4o/htKkfQ==
X-CSE-MsgGUID: Xyax3z0bSEu0502984e00Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="46857918"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.111])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 07:03:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 6 Jul 2024 17:03:32 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: linux-doc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V4 3/3] tools/arch/x86/intel_sdsi: Add attestation
 support
In-Reply-To: <20240608034247.181843-3-david.e.box@linux.intel.com>
Message-ID: <93ff0003-817c-a424-df05-b05b42eaebff@linux.intel.com>
References: <20240608034247.181843-1-david.e.box@linux.intel.com> <20240608034247.181843-3-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Jun 2024, David E. Box wrote:

> Add support in the intel_sdsi tool to perform SPDM GET_DIGESTS and
> GET_CERTIFICATE commands. Output is sent to stdout.
> 
> Example reading the certificate chain from socket 0:
> 
> intel_sdsi -d 1 -attest get_certificate | openssl x509 -inform DER -nout -text
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - No change
> 
> V3 - No change
> 
> V2 - Remove unnecessary struct packing
>    - Remove newline from perror()
>    - Add message options in --help output
>    - Use new SDSI_SPDM_BUF_SIZE from uapi header
>    - In spdm_get_certificate:
>         - Initialize remainder length to the minimum of the actual size
>           or the maximum buffer size.
>         - Add old_remainder to test that the remaining certificate
>           length is less than the previous length
> 
>  tools/arch/x86/intel_sdsi/Makefile     |  11 +-
>  tools/arch/x86/intel_sdsi/intel_sdsi.c |  72 +++-
>  tools/arch/x86/intel_sdsi/spdm.c       | 476 +++++++++++++++++++++++++
>  tools/arch/x86/intel_sdsi/spdm.h       |  13 +
>  4 files changed, 567 insertions(+), 5 deletions(-)
>  create mode 100644 tools/arch/x86/intel_sdsi/spdm.c
>  create mode 100644 tools/arch/x86/intel_sdsi/spdm.h
> 

> +++ b/tools/arch/x86/intel_sdsi/spdm.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * spdm: Lightweight Security Protocol and Data Model (SPDM) specification
> + * support code for performing attestation commands using the Intel On
> + * Demand driver ioctl interface. Intel On Demand currently supports
> + * SPDM version 1.0
> + *
> + * See the SPDM v1.0 specification at:
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf
> + *
> + * Copyright (C) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#include<linux/bits.h>
> +
> +#include<fcntl.h>
> +#include<stdio.h>
> +#include<stdlib.h>
> +#include<stdint.h>
> +#include<string.h>
> +#include<unistd.h>
> +#include<sys/ioctl.h>

All missing spaces. :-(

> +static int sdsi_process_ioctl(int ioctl_no, void *info, uint8_t dev_no)
> +{
> +	char pathname[14];
> +	int fd, ret;
> +
> +	ret = snprintf(pathname, 14, "%s%d", SDSI_DEV_PATH, dev_no);

sizeof(pathname)

> +	remainder_length = size < SDSI_SPDM_BUF_SIZE ? size : SDSI_SPDM_BUF_SIZE;
> +	old_remainder = remainder_length;
> +
> +	while (remainder_length) {
> +		uint16_t length;
> +
> +		length = remainder_length < SDSI_SPDM_BUF_SIZE ?
> +				remainder_length : SDSI_SPDM_BUF_SIZE;
> +		offset += portion_length;

The way bound check interplay with old_remainder and remainder_length in 
this code is quite convoluted and could contain some problems.

Would it work if old_remainder is set only here and the bound check 
before the loop is replaced with a plain remainder_length = size 
assignment?

> +
> +		ret = get_certificate_portion(dev_no, offset, length,
> +					      &portion_length,
> +					      &remainder_length,
> +					      c->chain);
> +		if (ret < 0)
> +			goto free_cert_chain;
> +
> +		if (!(remainder_length < old_remainder)) {
> +			fprintf(stderr, "Bad GET_CERTIFICATE length\n");
> +			ret = -1;
> +			goto free_cert_chain;
> +		}
> +
> +		old_remainder = remainder_length;
> +	}
> +
> +	c->len = offset + portion_length;
> +	return 0;
> +
> +free_cert_chain:
> +	free(c->chain);
> +	c->chain = NULL;
> +	return ret;
> +}
> diff --git a/tools/arch/x86/intel_sdsi/spdm.h b/tools/arch/x86/intel_sdsi/spdm.h
> new file mode 100644
> index 000000000000..aa7e08ffb872
> --- /dev/null
> +++ b/tools/arch/x86/intel_sdsi/spdm.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdint.h>
> +
> +#define TPM_ALG_SHA_384_SIZE 48
> +
> +struct cert_chain {
> +	void *chain;
> +	size_t len;
> +};
> +
> +int spdm_get_digests(int dev_no, uint8_t digest[TPM_ALG_SHA_384_SIZE]);
> +int spdm_get_certificate(int dev_no, struct cert_chain *c);
> +

Trailing newline.

-- 
 i.


