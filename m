Return-Path: <linux-kernel+bounces-513139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB89A3420E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42873188413A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D53214A69;
	Thu, 13 Feb 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bmcgqduO"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475C28137D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456914; cv=none; b=XSPxEr8ozCWO2InyQxPlRSV8qv9lzNAbPq9pDu+2bAQQHjfDdJl4WxACisYinG+iZErNpGRPb57nOVkQprnDu9T4SXu63rdX055gydwKiUQe0cHc9oeLxm/6Bw/GqqAIk6mmzBhtygk6n41Hctrc7Mu9opy25LUcnOfyOqTdf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456914; c=relaxed/simple;
	bh=b0isWpb5YT83qKnli8i3nzCYpYoa2XWShBwoO04S3gM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=muv7VfSFnrPpFvrfyRAO1HEHm0R0TTN9PO1/Gb15fKH3lJXlCiORDXgItLk+Shtu7pgL6W02b1+DKWQJ3HMZQze7iOxHqRjQ5v0cbDIhy0EM9xJe2b+pfdvehTVO8oq8IRUhgOSbIELlUTBpGh+1AfslMXHvKxDtY+PeKaHxPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bmcgqduO; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D6qllr002716;
	Thu, 13 Feb 2025 08:28:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=5WuprqZe1ONTquh7n3BbPTabdVlEFNG3sBmN0HjBPqo=; b=
	bmcgqduOtbQosyTglKwtghFObmSguNvtDDV50XkVb5L6juerKzW7r1xyEiqwk6AL
	UJcqpbEWVPqX/IXaO/18LXwoK3LyjfaqsLys1BUumQb2bmDiCo/uB9o1+Chw7J/C
	PXqmZyJ6IReDwZlTlDjiy43BLIhVDwsvUWC/+2fJ3d60wGwN8C9vPcVeeniH0e39
	GkE5Qozy97vR7e6f5WL/LaBqdx6MyabF6oIklHC2ul+IF+rPUp7YsgzJ2XIwDMn+
	CSiZaMTdeQkO8t3ePbVdopkQdxHp9vvO9StIacdV7HUWlqenMhh62uk/r+uLaqNI
	l9AOin0kyCym/lpZMl7Z1g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44p4jn0mx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 08:28:07 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 14:28:06 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 14:28:06 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3670C82025A;
	Thu, 13 Feb 2025 14:28:06 +0000 (UTC)
Message-ID: <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
Date: Thu, 13 Feb 2025 14:28:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        "Simon Trimmer" <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PNv1+eqC c=1 sm=1 tr=0 ts=67ae0177 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=CEiWSbsPnxP_RA5FPysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lbL3nxLd2MH6BPYp1ejrQAsGyxJSs5RE
X-Proofpoint-ORIG-GUID: lbL3nxLd2MH6BPYp1ejrQAsGyxJSs5RE
X-Proofpoint-Spam-Reason: safe

On 11/02/2025 5:21 pm, Richard Fitzgerald wrote:
> On 11/02/2025 5:03 pm, Thomas Weißschuh wrote:
>> Also drop the bounce buffer in cs_dsp_coeff_write_ctrl_raw().
>>
>> The bounce buffer in cs_dsp_coeff_write_ctrl_raw() could theoretically
>> also be removed. That would be a functional change as the output may be
>> modified in error cases.
>> As I don't know the driver very well I left that part out.
>>
>> Not tested on real hardware.
>> This came up while porting kunit to mips64.
>> Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by

I would say that is a bug in mips64 that should be fixed in mips64.
It is not reasonable to expect generic drivers to have special cases for
platforms that don't handle GFP_DMA.


>> cs_dsp is unnecessary in the first place.
>>
> 
> You're sure that all I2C and SPI bus controllers now handle non-DMA-safe
> buffers correctly?
> 
I just tested this.

The spi kernel doc says this:

  * struct spi_transfer - a read/write buffer pair
  * @tx_buf: data to be written (DMA-safe memory), or NULL
  * @rx_buf: data to be read (DMA-safe memory), or NULL

On x86_64() a spi_write() fails with -EINVAL if I pass it a non-dma-safe
buffer of data. But it works if I pass it a buffer allocated with
GFP_DMA.

So I think it is a bad idea to remove GFP_DMA to workaround mips64.

>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> ---
>> Thomas Weißschuh (2):
>>        firmware: cs_dsp: Remove usage of GFP_DMA
>>        firmware: cs_dsp: Remove bounce buffer in 
>> cs_dsp_coeff_write_ctrl_raw()
>>
>>   drivers/firmware/cirrus/cs_dsp.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>> ---
>> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
>> change-id: 20250211-cs_dsp-gfp_dma-0581bdd09dd5
>>
>> Best regards,
> 


