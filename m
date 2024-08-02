Return-Path: <linux-kernel+bounces-272617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9AF945EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D842F282410
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828251E2873;
	Fri,  2 Aug 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+bUI3Yo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB71C2322
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607117; cv=none; b=p73dGbmPuB2QHFwxP7s9xYU/jEx/KykibwjerQKGRk6CHCXnOmL/fqtPMNoGovB2MUIImCQIwqE0EZnVHwflMq56uHNPeSaGRH+Wh8mir2+PeSKfvHq6/P8cP6XqfMyEeYOXresdhaGY1GTSk7JCOkHKT/jAkk++ZzzqD4a6pGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607117; c=relaxed/simple;
	bh=mj/1clMgFrEPI2KKj2APtQ4WLR9RYvT5ia/+L0lqI14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctc8KyCHRh6esZHISMusWiL17cIP6GOVzQ8IlBILXDD9oj17oNzORLHnbJzK8tsqz0uJj8g5AIUvfnlwqya/LV780MbapaRSqtuFlqtJJbILQfWp0TCuA3YOL4xA8/eXM5dHhtC1iuKpwao0F+ByGzblNepKVNWC6rx87wCTLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+bUI3Yo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722607116; x=1754143116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mj/1clMgFrEPI2KKj2APtQ4WLR9RYvT5ia/+L0lqI14=;
  b=b+bUI3YoQxK7R7U+qM6moQzbDzCHma2Sns/cNlG+NUjqg1+Cg3IimXXo
   t8jVUC1GlHwZiJJwUhed/neGqIM8pfHC2JF/m8OH3TxYRv4ZZ+9ad0v7u
   qdf40AIVKWAZfogca2L3eFgxXYMnC5qFZfbgIBGcbBkFPbfUJXLXbt2Sf
   LpqQw04G5pkjQYCAGY10v/YiwEMzCGTS+UVtnQcYvKXzbyP+sbG3re8Ky
   +HrL9anaLu4Bj4WHcxsMo0bTH2gILBPPDex2xTo5xevDxZE5Zwr87D/tV
   F5iUQoDh5s5Q/RafZusTuw9ZrEponJWoyh/V4B8Fi3Tv+l1HNiS69r6R1
   A==;
X-CSE-ConnectionGUID: N5v8cl4NQe6aiUnpNyea8w==
X-CSE-MsgGUID: PEcVzvuiQAGGMfygujYLSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20800670"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="20800670"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 06:58:35 -0700
X-CSE-ConnectionGUID: dyWcK1jYS8CdclQYZxYZXQ==
X-CSE-MsgGUID: gzTbPkUQSQuuN32SCtMSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="60236926"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Aug 2024 06:58:33 -0700
Message-ID: <a0f5ea6b-2be4-4fac-8c22-34fc21df84b2@linux.intel.com>
Date: Fri, 2 Aug 2024 16:58:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
 <20240724071245.3833404-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240724071245.3833404-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 7/24/24 10:12 AM, Shyam Sundar S K wrote:
> The AMD HCI controller currently only supports PIO mode but exposes DMA
> rings to the OS, which leads to the controller being configured in DMA
> mode. To address this, add a quirk to avoid configuring the controller in
> DMA mode and default to PIO mode.
> 
> Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
> driver to facilitate seamless future quirk additions.
> 
> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/Makefile |  3 ++-
>   drivers/i3c/master/mipi-i3c-hci/core.c   | 15 ++++++++++++++-
>   drivers/i3c/master/mipi-i3c-hci/hci.h    |  3 +++
>   3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
> index a658e7b8262c..1f8cd5c48fde 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/Makefile
> +++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
> @@ -3,4 +3,5 @@
>   obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
>   mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
>   					   cmd_v1.o cmd_v2.o \
> -					   dat_v1.o dct_v1.o
> +					   dat_v1.o dct_v1.o \
> +					   hci_quirks.o

This doesn't build since hci_quirks.c is added by the patch 4/5. One 
idea below.

> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index dbc8c38bd962..8bb422ab1d01 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -33,6 +33,7 @@
>   #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
>   
>   #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
> +#define HCI_VERSION_V1			0x100	/* MIPI HCI Version number V1.0 */
>   
>   #define HC_CONTROL			0x04
>   #define HC_CONTROL_BUS_ENABLE		BIT(31)
> @@ -745,6 +746,14 @@ static int i3c_hci_init(struct i3c_hci *hci)
>   		return -EINVAL;
>   	}
>   
> +	/* Initialize quirks for AMD platforms */
> +	amd_i3c_hci_quirks_init(hci);
> +
> +	regval = reg_read(HCI_VERSION);
> +
> +	if (hci->quirks & HCI_QUIRK_AMD_PIO_MODE)
> +		hci->RHS_regs = NULL;
> +
>   	/* Try activating DMA operations first */
>   	if (hci->RHS_regs) {
>   		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
> @@ -760,7 +769,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
>   	/* If no DMA, try PIO */
>   	if (!hci->io && hci->PIO_regs) {
>   		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
> -		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
> +		/*
> +		 * HC_CONTROL_PIO_MODE bit not present in HC_CONTROL register w.r.t V1.0
> +		 * specification. So skip checking PIO_MODE bit status
> +		 */
> +		if (regval != HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
>   			dev_err(&hci->master.dev, "DMA mode is stuck\n");
>   			ret = -EIO;
>   		} else {

This is true, I see this now from pre-v1.0, v1.0. v1.1 and v1.2 specs 
too, HC_CONTROL_PIO_MODE bit is present only after v1.0. And therefore 
version != HCI_VERSION_V1 check is not fully correct since bit is not 
present in pre-v1.0 HW versions either.

I'd split this patch and do version check alone here (perhaps as a first 
patch) and do quirk stuff later where hci_quirks.c is added.

