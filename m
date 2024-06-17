Return-Path: <linux-kernel+bounces-217787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BF90B6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E46B38D21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1F60B96;
	Mon, 17 Jun 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qUciWrvK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4A5B1E4;
	Mon, 17 Jun 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636371; cv=none; b=kUmZIfVhN4SO/ihQa2fH39sC1ZM4ApGPLmTETw3QFS1onnylVbah25MqHYcCE6jTDVOn559sE93iSmpeyKmi1CS6LXrmyU6yd9/3YUSZZRnWbK7QURyuXWPSOnYzdzaY+yXLrHeWN/umcLutRSdPd2V3mBcEcNvBi1jX73OJsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636371; c=relaxed/simple;
	bh=b1PJGTlv1eUZIrgNlnXwXE+3iK9WQzktLmR8xz3nq0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oRWTdVBcjt0wHd4H4vhmRes+6AILJei8HjHY7qwkfgj4ZOKvGZpk9UL7zkipxwaVgw/ZlUJ/0n0cd6JJJlBGRFlxoQSnrU9DOh7zMagY1fzdH3PhfYebx6kWgIPpGTjhgFMmdKrLqVUIwpoCZelJR/eOcv+tJvpqMoTixIpWRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qUciWrvK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H5Q2nA001972;
	Mon, 17 Jun 2024 09:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=82NKCBlNAyD/uD7R+ED4UFGffGVBQme/etpeP85WnTs=; b=
	qUciWrvKskySBFPVRT64266PzVojuoy4SapsHRj7AuvgrL8LAoAYo7Hthl1gcFqa
	XHsIyf8tuQTEldrmj9cKaD1htmE0Y43LimlHqKb5Zgbly5wAeku/VL9gFPMtLGfo
	WoUeFL6XNr27D2j1sB6gQy0o5wBHvKZRxCLptSGd+1uajrH9XBvwy+cTZYZ0V/i+
	RR//hPyRdEfdMyi73AE3WDX0Ty3IECOSNhKxsZh90V6ObyOp2Wk399zW68xEqrO2
	KhMcvT40jOwmmkou4sOi7H8TJgjDDdTXobsv62E636VXiZvpZzl26LoyxeaM0ZKD
	zMybmYmeCqaiNnItPeQMXQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cjsx39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:34:01 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 15:33:59 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 15:33:59 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6B1B8820248;
	Mon, 17 Jun 2024 14:33:59 +0000 (UTC)
Message-ID: <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
Date: Mon, 17 Jun 2024 15:33:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
To: Mark Brown <broonie@kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: q0Z9tes_w-BZ_luaxhXYn0kLD8UA4f76
X-Proofpoint-ORIG-GUID: q0Z9tes_w-BZ_luaxhXYn0kLD8UA4f76
X-Proofpoint-Spam-Reason: safe

On 17/06/2024 15:04, Mark Brown wrote:
> On Mon, Jun 17, 2024 at 02:53:38PM +0100, Simon Trimmer wrote:
>> IRQ lookup functions such as those in ACPI can return error values when
>> an IRQ is not defined. The i2c core driver converts the error codes to a
>> value of 0 and the SPI bus driver passes them unaltered to client device
>> drivers.
>>
>> The cs35l56 driver should only accept positive non-zero values as IRQ
>> numbers.
> 
> Have all architectures removed 0 as a valid IRQ?

 From discussion threads we can find 0 might still used on x86 for a
legacy device.
But the conversations we can find on this don't seem to exclude passing
a negative error number, just that 0 can normally be assumed invalid.

The kerneldoc for SPI says:

  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.


