Return-Path: <linux-kernel+bounces-395055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544499BB7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA0DB21860
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0F1AE018;
	Mon,  4 Nov 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYFePSk+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30BAD2F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730866; cv=none; b=YBM9btiY0ZGX5eIRBDeJ4MJnRdiRLq6A1zmcmSm1RlPv+BzkqDb1T21y2BvZqRS+OMH9g6+ubOOOpqSUt3OerGtxjVtO6U6DX5q7CgLOoQRXI2sKDgfaTHNXyIBKEHJ3J61feyjfOUdh1BfyUwqIKjgE3ivQUpjNOEdMYanyMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730866; c=relaxed/simple;
	bh=iiXH8mVQOPTOV4xvUPLOj4H0pAr4u/wT1KnOxicTZBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJUTF4qBC4tjCX5zpYZmSK784SAAYgfBMba6z0JPL54RusasCiUyOY30Mp0+td9+PAmr5/64V8YOHHr4bd76fc7DxtF9IkxkVXtVN46f7Ww/0NBjQHVZARTjwVzq3sylVnAhgVpMTNs99002fJNTZM1lq+3g62CLQRQ8bn45Uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYFePSk+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730730864; x=1762266864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iiXH8mVQOPTOV4xvUPLOj4H0pAr4u/wT1KnOxicTZBA=;
  b=ZYFePSk+GnFB2lCqVxjMBPeV9k3/WdrtodY5KethV7EIs8ESmp+DGJu8
   xgmC6wIG24bjcf1OELLV5bArq/bm+kJLeNdXzb8KoV1DZ3YowxYLAbnz1
   9OnlYYiV/o9Ct3tl4fldaOrQU98J/Sj0qOhap6K5+KOgvSqJxf+62Pn+L
   HoOS9TdsuicKTrV1xsUJSGPlHI3ZwZOmE2OSgZaIziB3Lnlm6cFzP2vUd
   TH6zWbIQbNIRE7SknDp0Hyb5SCtWM5jKp/u8ikoRHvH8HT6BI+axY0m+L
   EZWhjdujIssppesFhAEHPM4WRbEmUZlRJCMAskqwVpAvYZ8xAn+Vvfw61
   w==;
X-CSE-ConnectionGUID: NQSN9UFzQCiQP2iOdtNRmQ==
X-CSE-MsgGUID: aZwlHQ8LRryOMKQCa6MLag==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="55830601"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="55830601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:34:24 -0800
X-CSE-ConnectionGUID: zOEtbfMsRMeYGNQCerqapg==
X-CSE-MsgGUID: Ys8cFRB+TLydmix+5rO7ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83351296"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2024 06:34:23 -0800
Message-ID: <9eb7c88a-c448-45cc-aeaa-88ab59cdadc5@linux.intel.com>
Date: Mon, 4 Nov 2024 16:34:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] i3c: dw: Use IRQF_SHARED flag for dw-i3c-master
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <20241023055118.1400286-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241023055118.1400286-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 8:51 AM, Shyam Sundar S K wrote:
> On AMD platforms, the IRQ lines are shared between two instances of I3C.
> Add IRQF_SHARED flag during the interrupt registration process.
> 
> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 1a7c300b6d45..fd58a95ae1c3 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1578,7 +1578,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>   	writel(INTR_ALL, master->regs + INTR_STATUS);
>   	irq = platform_get_irq(pdev, 0);
>   	ret = devm_request_irq(&pdev->dev, irq,
> -			       dw_i3c_master_irq_handler, 0,
> +			       dw_i3c_master_irq_handler, IRQF_SHARED,
>   			       dev_name(&pdev->dev), master);

dw_i3c_master_irq_handler() seems to be otherwise ready for shared 
interrupts but reminded me it might have a similar issue than 
drivers/i2c/busses/i2c-designware-master.c had [1] because both are 
runtime PM managed.

To me it looks dw_i3c_master_irq_handler() may incorrectly process 
interrupt from other device if register reads return all bits one when 
device is suspended. Worth to check.

1. Commit cdbd2f169bf1 ("i2c: designware: Do not process interrupt when 
device is suspended")

