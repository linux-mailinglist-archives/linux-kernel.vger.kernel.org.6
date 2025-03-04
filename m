Return-Path: <linux-kernel+bounces-543639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50793A4D7D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8FE188662B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53F1F5853;
	Tue,  4 Mar 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WDY4XJlj"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541D18FC6B;
	Tue,  4 Mar 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080013; cv=none; b=SI2qwfEpS7r7eSt4zYKtSNKPGUP8qbgUqNJWsOZEo5rtQQEUx7GyYY1g8rUXGIRJ8QyNkJ1jNNSTNrLKti006KMpONp0aAbkqRx6w4y0ghmBrmpX+ypS0poQgVqQXyycG8XlJEEG8TW4OIqqy2khkyA9HnkhqcpsBEgqgCzNotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080013; c=relaxed/simple;
	bh=xOFxo8gsMiynVWd3ZJwDqa4GVx8u3YsAkiZhHyTFQJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YewIApM5rC37iQNmrSfpJycwS+M7CYd8u7Hed4Bx2WU7OuOSxnFeM3W75AtXScocjwPfwEug0J6oPsw5XH3Gslga4fV/g3MtdES32yxO6RjGRDw03pKrEk0x7qhepwcL1tBWCB67StTRIahjQARq/wySaCuQ/xObO4kVfR0Jtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WDY4XJlj; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5245gdSF021938;
	Tue, 4 Mar 2025 03:19:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BZZRwtW2h9tlEFc5ND3Fz0ti//9gALGRUJP7ScdQV1s=; b=
	WDY4XJljQwvTVZJ2TBxOfPmqhhD7tRjjFcYAmekoF856zw0lxLgRcXObWIldlA2h
	HgH6SgkpOSTghfyBCyRs+9dKWmh0jFHj0dw9BrhFamgItUuG4GFZTgqZp6uSW2u8
	P9/8bWxRlFq6udMsPrtt5m9z43gooVwiCXHdLVeLhMjn6dlDQeYNsePHnlebimLk
	xi20X6q3uG7AYdIJ+OcBILkubOm6YVC4dDZNUiORJJ9i0Xr8AeEXomuvte+Rpl7o
	do81pVketS+L4wzZl3o0n7D0+k6hOuet0mgI4AdGhWqrvdCk0AIrhI0oacM8Jxzf
	v9cpIJkVVu0zUys9/HlmAg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyhhmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 03:19:51 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 09:19:49 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 09:19:49 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id F0E3F820248;
	Tue,  4 Mar 2025 09:19:48 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:19:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 13/13] ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_*
 helpers
Message-ID: <Z8bFs5xPjVzbLJoa@opensource.cirrus.com>
References: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
 <20250303171424.444556-14-ckeepax@opensource.cirrus.com>
 <4db99187-63f9-41cc-966b-0c77ba86e390@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4db99187-63f9-41cc-966b-0c77ba86e390@sirena.org.uk>
X-Proofpoint-GUID: 1FAcLbG5eH93_QGHrjEHF1N4dxMlgdaA
X-Proofpoint-ORIG-GUID: 1FAcLbG5eH93_QGHrjEHF1N4dxMlgdaA
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c6c5b7 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=hR2cDPa-ULlpED4iyd0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe

On Mon, Mar 03, 2025 at 06:53:08PM +0000, Mark Brown wrote:
> On Mon, Mar 03, 2025 at 05:14:24PM +0000, Charles Keepax wrote:
> > Re-implement SOC_DOUBLE_VALUE() in terms of SOC_DOUBLE_S_VALUE().
> > SOC_DOUBLE_S_VALUE() already had a minimum value so add this to
> > SOC_DOUBLE_VALUE as well, this allows replacement of several hard coded
> > value entries. Likewise update SOC_SINGLE_VALUE to match, which allows
> > replacement of even more hard coded values.
> 
> This breaks an arm64 defconfig build:
> 
> In file included from /build/stage/linux/sound/soc/codecs/rk3308_codec.c:24:
> /build/stage/linux/include/sound/soc.h:150:49: error: ‘shift_left’ undeclared here (not in a function)
>   150 |         .private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
>       |                                                 ^~~~~~~~~~
> /build/stage/linux/include/sound/soc.h:45:46: note: in definition of macro ‘SOC_DOUBLE_S_VALUE’
>    45 |         {.reg = xreg, .rreg = xreg, .shift = shift_left, \
>       |                                              ^~~~~~~~~~
> /build/stage/linux/include/sound/soc.h:150:26: note: in expansion of macro ‘SOC_DOUBLE_VALUE’
>   150 |         .private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
>       |                          ^~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/codecs/rk3308_codec.c:171:9: note: in expansion of macro ‘SOC_DOUBLE_RANGE_TLV’
>   171 |         SOC_DOUBLE_RANGE_TLV("DAC HPMIX Playback Volume",
>       |         ^~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/include/sound/soc.h:150:61: error: ‘shift_right’ undeclared here (not in a function)
>   150 |         .private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
>       |                                                             ^~~~~~~~~~~
> /build/stage/linux/include/sound/soc.h:46:19: note: in definition of macro ‘SOC_DOUBLE_S_VALUE’
>    46 |         .rshift = shift_right, .min = xmin, .max = xmax, \
>       |                   ^~~~~~~~~~~
> /build/stage/linux/include/sound/soc.h:150:26: note: in expansion of macro ‘SOC_DOUBLE_VALUE’
>   150 |         .private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
>       |                          ^~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/codecs/rk3308_codec.c:171:9: note: in expansion of macro ‘SOC_DOUBLE_RANGE_TLV’
>   171 |         SOC_DOUBLE_RANGE_TLV("DAC HPMIX Playback Volume",
>       |         ^~~~~~~~~~~~~~~~~~~~
> 

Apologies I will check that out and resend.

Thanks,
Charles

