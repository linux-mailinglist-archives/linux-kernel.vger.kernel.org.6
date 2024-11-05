Return-Path: <linux-kernel+bounces-396287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96C9BCAD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE5D1F239E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191F1D359C;
	Tue,  5 Nov 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+dvJi0f"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF91D2207;
	Tue,  5 Nov 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803694; cv=none; b=gF1OOa3FE9+P1d5j9h0gS0CpEHQcIz73BEJAdHGOB5VAZvsrTbwuajaWhGwbbly1SEbjoBN8YLwwbQLNt/3hmBpDvWPf81IrD4r/XdFg5yNyJcFUFRnWgyV73GFEVsA/VaHMMIflBOKqtPDp3PdBFXLquAemQyOaDPV7Tdbp/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803694; c=relaxed/simple;
	bh=GPCdYW0811iti/hVHEhQWEKNvTqnktT3cDmuiekcC/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQlwbWRo3gJYMwr4tU1L0DUwSWHOUarODnMdpdqL2AwrGF0q7lYPpbnlvGJDYARIVR3gpMf3uaUhCUY3BJj/OgczddoZDWm9EY/plGZ439ndolH2CdJYyivqNqrgXix+QG2OL+/uq/YVeYH3+d95b7VAotF0tABRQ+Za/46tFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+dvJi0f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb47387ceso50483905ad.1;
        Tue, 05 Nov 2024 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730803692; x=1731408492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vl368IHfugGH7NpIw6LrEHvZJWAHeveihk8swyRU7b8=;
        b=j+dvJi0frQtl9J8gCs3uppds0uN7P5c2W9LED5F7Z4ED7phaFDndC+di2E7hnFKHcP
         H5wjKf2SnTFgxEIIsI63ItuY8gAajNWQTafM+lJuet3R8E+2x5AY5RVtAXcLwtSrPtHq
         qDLNHf8ZYOw6XKIlUdBswoc0xjTIbMXS9vaQl+uAr6DL0XkiTBGYb42A2MwgjkY0ZA34
         9tmKidS9gj4WMyBYHTvejog/rboxRDPCsJG0tA5oAPxyF52z1Gacq8PAC00Y/8Onzy9k
         idnxsCEPiqTQfx+fdQqJmWogPsGvuCQD3s1MKJ/nY/cdqj4NmDNULCUTIkK8cfTHvVDJ
         C+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803692; x=1731408492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vl368IHfugGH7NpIw6LrEHvZJWAHeveihk8swyRU7b8=;
        b=TLm8hv6zwfO5j9vdHUrAWozJdSZSd9wocZiiJ37VU9tX0Z2eVlrMgA2sGeAKwky88h
         PUuZ7HFTJ6ALEFlRsq7zdVCMY4pPfcG1BSseRgAs3Rr/kE47KHykURM1EGPVHqv6+fTA
         Nxx4fIKw2k/fWifoMsQsEJo34wtwGyreggCuhjD0Fiz5wlumWxBK6g3bTrfMOCUnqDCI
         0+Hs0mpMTgdoqGDdwXwixmCanFaGMUA3c8ikDhZLxNrhTDVroZIsaTWrN70TxfrQ16jP
         NLEDwsoe6aAXzq2dTT6alLtiH3w/fl+AsMnw/rjUclR//CUjM7Jjx87JKyJ+aAIlVV3X
         PWig==
X-Forwarded-Encrypted: i=1; AJvYcCUTvGldH/dxcujRcRDPXdfqZFWQtlJSn2OlxUqpAwiZ5D8m+LAYbdA3cq15gXtHlScPIpQmOEnDbAIYlvQ=@vger.kernel.org, AJvYcCWkOr4n59kAfnzP35yaMNMlboIwEqir71pEZDAvKAroBqTcV+isvOQJQPOiAAH20eQvU0hkw7qrK0FR0/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpB49SbGJuWH15hicBLfcm5lBFY6zg1Pgae2ST+tEYM105SdW4
	XmKkOUODrxdtsBlJYx42tojVWo0DmMOdSrcTj22pUOo5XUotEad4
X-Google-Smtp-Source: AGHT+IHqwR3DoR50k/jImXbWZDfRoGpVNx8P/xXzruRUljIAHKNKFHqS5/MSKqaUtejJl+kDNpJv7Q==
X-Received: by 2002:a17:903:2302:b0:20b:9062:7b16 with SMTP id d9443c01a7336-210c6872d94mr503183385ad.9.1730803692019;
        Tue, 05 Nov 2024 02:48:12 -0800 (PST)
Received: from ?IPV6:2409:40c0:1049:499a:fd64:be8:ad93:9d2? ([2409:40c0:1049:499a:fd64:be8:ad93:9d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2be8sm75361685ad.165.2024.11.05.02.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:48:11 -0800 (PST)
Message-ID: <8c792a4a-8a1c-4ccb-b517-eb02bc18b11f@gmail.com>
Date: Tue, 5 Nov 2024 16:18:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: broonie@kernel.org, daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, perex@perex.cz, pierre-louis.bossart@linux.dev,
 ranjani.sridharan@linux.intel.com, sound-open-firmware@alsa-project.org,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <20241103113702.27673-1-surajsonawane0215@gmail.com>
 <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/24 16:22, Péter Ujfalusi wrote:
> 
> 
> On 03/11/2024 13:37, Suraj Sonawane wrote:
>> Fix an issue detected by the Smatch tool:
>>
>> sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
>> error: uninitialized symbol 'be_rate'.
>>
>> This issue occurred because the variable 'be_rate' could remain
>> uninitialized if num_input_formats is zero. In such cases, the
>> loop that assigns a value to 'be_rate' would not execute,
>> potentially leading to undefined behavior when rate->min and
>> rate->max are set with an uninitialized 'be_rate'.
>>
>> To resolve this, an additional check for num_input_formats > 0
>> was added before setting rate->min and rate->max with 'be_rate'.
>> This ensures that 'be_rate' is assigned only when there are valid
>> input formats, preventing any use of uninitialized data.
>>
>> This solution maintains defined behavior for rate->min and rate->max,
>> ensuring they are only assigned when valid be_rate data is available.
>>
>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>> ---
>> V1: Initialize 'be_rate' to 0.
>> V2: Add conditional assignment based on num_input_formats to ensure
>> be_rate is used only when assigned.
>>
>>   sound/soc/sof/ipc4-pcm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
>> index 4df2be3d3..d5d7ffc69 100644
>> --- a/sound/soc/sof/ipc4-pcm.c
>> +++ b/sound/soc/sof/ipc4-pcm.c
>> @@ -633,8 +633,11 @@ static int sof_ipc4_pcm_dai_link_fixup_rate(struct snd_sof_dev *sdev,
>>   			return -EINVAL;
>>   		}
>>   
>> -		rate->min = be_rate;
>> -		rate->max = rate->min;
>> +		/* Set rate only if be_rate was assigned */
>> +		if (num_input_formats > 0) {
> 
> By definition the copier must have at least one input and one output
> format, this check is going to be always true.
> 
>> +			rate->min = be_rate;
>> +			rate->max = rate->min;
>> +		}
>>   	}
>>   
>>   	return 0;
> 
Thank you for the clarification.

