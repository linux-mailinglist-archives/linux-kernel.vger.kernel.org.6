Return-Path: <linux-kernel+bounces-247318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A5692CDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49859285512
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52F918F2EF;
	Wed, 10 Jul 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k0mf0D5X"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018B18D4BB;
	Wed, 10 Jul 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602589; cv=none; b=rKIlfg23ng5JU56geifBZqH4lu2XoUM9IZiyrWeDN8G/4n9te0Y4AcYjTmGWgFiNX/OfG/w01ul6j1+dHr8PnLsI8tKlD0Y3qGX85xTHQHht7FCcKruhy/WqLWNK0aUwctbrRhe5kZ+phOL9hL7ix/dv/hLhr8J3Me3gKzcWhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602589; c=relaxed/simple;
	bh=h754w0AZwBqaW9S+IIdF6AkvgEKM2drXdBzIPZttEuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YCBcdFu1x0N4sOh5CY9FwkMSQMPMu1uwQitYT7nHlomEreweqKqxvZH3ZkmMDSH2L69Ki7wmmMKbXOsNqp5TCkOhhuedNODyvuIcaAl1Sz7rpWjMxpxovjaGfbN7zTf9k1wkVJFsqoT0CTO5BhYscfd3UjtpBOxBmmuA6drRChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=k0mf0D5X; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4s4Cs006601;
	Wed, 10 Jul 2024 04:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=x/iSfhnjQc3v89FNYti7Mzilbr8FM6mdZXiL+wsib0c=; b=
	k0mf0D5XERMViEcaVCJPTU+KI1gRbAxVPVn7lo0j2EAcCIq3kIL8ntrhXuN5TwQq
	XVr4YNGcfF4+hGTAN6XEG+anDUBGw2A18W2BG2zoEan/RfcYSKkNhbYSP1G4NS4t
	gE0ovs1MA0xRtUlqYGy0f32QqSR/g2yJiuFvzRQdC0JG+jw0Vkelwsxo2aZshbhY
	0DaB6AYrSdF5HTQezBkPdmZzsLE/FB4BrOx5T5eaiWFCbzIX0i4vlk0CfuvWt2gw
	hV3/mB7to2lxLOG2Y6HSUurHiwwokmobPvHlwODeRsgaZSrOHEuXJUj8CMwChX9z
	OHDuomzwzFwaA371V8r9cQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 409c9a8f44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 04:09:39 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 10:09:38 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 10:09:38 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2F19D820244;
	Wed, 10 Jul 2024 09:09:38 +0000 (UTC)
Message-ID: <afc1a70b-4ed2-4afe-a506-1ca04d080342@opensource.cirrus.com>
Date: Wed, 10 Jul 2024 10:09:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] firmware: cs_dsp: Merge wmfw format log message into
 INFO message
To: Charles Keepax <ckeepax@opensource.cirrus.com>
CC: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>
References: <20240709145156.268074-1-rf@opensource.cirrus.com>
 <20240709145156.268074-4-rf@opensource.cirrus.com>
 <Zo1YZHiE6WK3d8rm@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <Zo1YZHiE6WK3d8rm@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b4iguY7-UgafPlxbRoTRuiiD-9X2YqcV
X-Proofpoint-GUID: b4iguY7-UgafPlxbRoTRuiiD-9X2YqcV
X-Proofpoint-Spam-Reason: safe

On 09/07/2024 16:33, Charles Keepax wrote:
> On Tue, Jul 09, 2024 at 03:51:55PM +0100, Richard Fitzgerald wrote:
>> Log the WMFW file format version with the INFO_TEST message.
>>
>> The behaviour of firmware controls depends on the WMFW format version,
>> so this is useful information to log for debugging. But there's no
>> need to use a separate log line just for this value.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   drivers/firmware/cirrus/cs_dsp.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
>> index 1bc2e0b6d40b..141a6c9d6737 100644
>> --- a/drivers/firmware/cirrus/cs_dsp.c
>> +++ b/drivers/firmware/cirrus/cs_dsp.c
>> @@ -1502,7 +1502,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
>>   		goto out_fw;
>>   	}
>>   
>> -	cs_dsp_info(dsp, "Firmware version: %d\n", header->ver);
>>   	dsp->fw_ver = header->ver;
>>   
>>   	if (header->core != dsp->type) {
>> @@ -1552,7 +1551,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
>>   		case WMFW_INFO_TEXT:
>>   		case WMFW_NAME_TEXT:
>>   			region_name = "Info/Name";
>> -			cs_dsp_info(dsp, "%s: %.*s\n", file,
>> +			cs_dsp_info(dsp, "%s (rev %d): %.*s\n", file, dsp->fw_ver,
>>   				    min(le32_to_cpu(region->len), 100), region->data);
> 
> Are we sure on this one? I don't think a WMFW is required to
> include an INFO/NAME block so it is now possible for this to not
> get printed. Granted I have not seen one that doesn't include
> at least one of these blocks but it isn't required. I think I
> would lean towards keening the separate print personally.
> 
> Thanks,
> Charles

The specification says that the first INFO block is mandatory, but
specifications can change so I don't mind leaving it on its own line.

I've just noticed a typo in the commit description (INFO_TEST should be
INFO_TEXT) so I want to send a V2 chain anyway.

