Return-Path: <linux-kernel+bounces-280930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C382394D118
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F8C1C21068
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22567194C65;
	Fri,  9 Aug 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEXIkJTa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E519046B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209682; cv=none; b=ezPvRCwbbnuLvkrpwjDE4QXdI6AqW47dDF62561vwSqkrtDERpsYT458lYHZc3jXMjuYtm4bW7Ay2c/gjRKMN2V1dKmHdiWbculoXouxSFHjARRfbERHRpyt34LxLGurifp5v2htCXhJ2WWjVhFefPYOjnhXyqHtNanjXkZzE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209682; c=relaxed/simple;
	bh=21XDyHoIvdr2kmFYpi3tjvKxqhkqRnTC/2zgaZaZaJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmUBgnCVG4uOFCkyUcpyrfJJG2NnSJFTHKRmD+kit7mpaUKoW4tw1f6fHveKOCC1Ev008OyIezfbHXCfLDlsyoddMiBTNT4kCSUV6KPRfReZUBSR4I0Qeae4s7XWvS6lZCD6jSbh/jo/gdBd4GHbCEYEaNA1whSUdX6s3nQunb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEXIkJTa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723209681; x=1754745681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=21XDyHoIvdr2kmFYpi3tjvKxqhkqRnTC/2zgaZaZaJg=;
  b=IEXIkJTaT89LunDjJgRfh7goBqN5kc8gi6Qe74MghjFXXynquduKjPxu
   S8r8SBWwzCWMJdkQWuLf6TbF87VhJelJoVMiqGMLq8NZRXtli2HyiW2aA
   7uwEuMTLfQ8uPSlia0XTyag1uxtZz94lM2tEosASvm6vat52ocJDos+Nb
   jefocqwkELWjQtYXjukhThD35hj01lZxm6nxQi/r5UBYEc6w1H2/FpIZI
   YOL3RzcNOcMT4QHkZB19OSSpUoEjaVqxreGM/NJrYwvGFlj0W0e4u5Huk
   J8CaNeax5R23UNLY9i3ensv5qelIgN5Tz0JIxah6fZJubdh0dLoo869FJ
   w==;
X-CSE-ConnectionGUID: U2Zm9xqDRgCVokPbJXMKPw==
X-CSE-MsgGUID: PWRSDTUjSluu70T4zu0h/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21534230"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21534230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:21:20 -0700
X-CSE-ConnectionGUID: 2kR6hczSQoKB6JEPPB6kqA==
X-CSE-MsgGUID: EpyfFweMQY6Frlz242WdmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="80799493"
Received: from unknown (HELO [10.237.72.57]) ([10.237.72.57])
  by fmviesa002.fm.intel.com with ESMTP; 09 Aug 2024 06:21:18 -0700
Message-ID: <ce725e2b-378c-46ba-86ad-a877de0e1ef4@linux.intel.com>
Date: Fri, 9 Aug 2024 16:21:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE
 only after i3c hci v1.1
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240807052359.290046-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
> The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
> starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
> on hardware that adheres to older specification revisions (i.e., versions
> earlier than 1.1) is incorrect. To address this, add an additional check
> to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
> status.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 24dd4603d6c6..a16da70bdfe1 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -33,6 +33,7 @@
>   #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
>   
>   #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
> +#define HCI_VERSION_V1			0x100   /* MIPI HCI Version number V1.0 */
>   
>   #define HC_CONTROL			0x04
>   #define HC_CONTROL_BUS_ENABLE		BIT(31)
> @@ -756,7 +757,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
>   	/* Try activating DMA operations first */
>   	if (hci->RHS_regs) {
>   		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
> -		if (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE) {
> +		if (regval > HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
>   			dev_err(&hci->master.dev, "PIO mode is stuck\n");
>   			ret = -EIO;
>   		} else {

Here's typo and logic is reversed.

