Return-Path: <linux-kernel+bounces-269458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09394333D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6B5B2C27C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4151BF32D;
	Wed, 31 Jul 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dbHjhIV5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4F156CF;
	Wed, 31 Jul 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438859; cv=none; b=ANqVk5BTWL5ZqwTtBSaqmFiqdwdi3/nJGOt4T4pSaXCwxRpIyxRhtol4jLPB/K5yTYXvJOrpyb7AL15tZfTfHRFST+ICTaQHCIP+PF38mMGNT98CZigbUb7nPzFdo9MVkxHNUNgm0zRecLfPfs0q3CRhSxbx9gTrrn3AK9VW/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438859; c=relaxed/simple;
	bh=IT7qaBrmCnDsSKunyiq1QCwyk+RV3CZ/5Faw2PCirmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cA4dCzR9xOhanRirskPRBChG9lTZm0aWoBuJAI/EnNmV+NXqi57FxZW9bQuATLDEYNDbcisszqZAQkx68XXwN8isYZeIxluUwBdzl64B9M00AmawR7d4CVXO5LM9HHwOq+mYPh7LBCpuhrwmulVFV3EMJSI61Dw51HXmFoyl6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dbHjhIV5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V9i92U014719;
	Wed, 31 Jul 2024 10:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=cZ8CjJMm680NP34hZKU2i+S7Lf+XwCoidB1hPMaIer0=; b=
	dbHjhIV5VdFxiXkbaYiVqi7cPMW3PEjq2CPMorSRSRHQ6fMlaNGDsUGAxkL+DShr
	pMsWcLW4/DEKC65/l/O/0bkDq2wkkviixfrFGJ1ULYrdhE8hJnCk33g/9R/3kh08
	lnGomDlyrFZEexxePaP3XD2Hz5+LRu5UjWxIElESk6sL70oN6VGQmBAnWfqL68th
	tGgV1Q5pi7t5AAfIrVWwsSIiMD/P7l9PkG2YMmkDKDlDvZ4CetX/Aaeu0f5PiJmV
	h0dietf+oiQ/CQgbbOainjCEVzVpBQWtC69K1Uj/4zLBB+kyxXY8zqBzyyiqKanC
	/oYWgKgJ6orYTY5ZqUjP2w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40qjw98g52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 10:12:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 16:12:06 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 31 Jul 2024 16:12:06 +0100
Received: from [198.90.188.46] (unknown [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AFFAC820244;
	Wed, 31 Jul 2024 15:12:06 +0000 (UTC)
Message-ID: <0e9b9b8f-2df4-442e-9868-caaa91e7dc65@opensource.cirrus.com>
Date: Wed, 31 Jul 2024 16:12:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Stop creating ALSA Controls for
 firmware coefficients
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240730143748.351651-1-sbinding@opensource.cirrus.com>
 <013bdb56-b940-4881-b881-ad12be7321d0@perex.cz> <87zfpxyht3.wl-tiwai@suse.de>
 <551e3be0-f436-4db1-ae5c-1ad5a31f68c3@perex.cz> <87v80lyh6s.wl-tiwai@suse.de>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <87v80lyh6s.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bdrEFC18IN20yGqxuAdP8KUUEI1Eo3Gj
X-Proofpoint-ORIG-GUID: bdrEFC18IN20yGqxuAdP8KUUEI1Eo3Gj
X-Proofpoint-Spam-Reason: safe


On 31/07/2024 11:44, Takashi Iwai wrote:
> On Wed, 31 Jul 2024 12:36:19 +0200,
> Jaroslav Kysela wrote:
>> On 31. 07. 24 12:30, Takashi Iwai wrote:
>>> On Tue, 30 Jul 2024 16:55:19 +0200,
>>> Jaroslav Kysela wrote:
>>>> On 30. 07. 24 16:37, Stefan Binding wrote:
>>>>> Add a kernel parameter to allow coefficients to be exposed as ALSA controls.
>>>>>
>>>>> When the CS35L41 loads its firmware, it has a number of controls to
>>>>> affect its behaviour. Currently, these controls are exposed as ALSA
>>>>> Controls by default.
>>>>>
>>>>> However, nothing in userspace currently uses them, and is unlikely to
>>>>> do so in the future, therefore we don't need to create ASLA controls
>>>>> for them.
>>>>>
>>>>> These controls can be useful for debug, so we can add a kernel
>>>>> parameter to re-enable them if necessary.
>>>>>
>>>>> Disabling these controls would prevent userspace from trying to read
>>>>> these controls when the CS35L41 is hibernating, which ordinarily
>>>>> would result in an error message.
>>>> This is probably not a right argument to add this code. The codec
>>>> should be powered up when those controls are accessed or those
>>>> controls should be cached by the driver.
>>>>
>>>> Although the controls have not been used yet, exposing them in this
>>>> way is not ideal.
>>>>
>>>> Could you fix the driver (no I/O errors)?
>>> While we should fix the potential errors at hibernation, it's not bad
>>> to hide those controls, IMO.  For the normal use cases, it's nothing
>>> but a cause of troubles, after all.
>> I do not think that the situation is so obvious. Different
>> coefficients can be used in various UCM profiles for example.
> If that's the supposed use-case, yes.
> I doubt it, though, but this needs clarification from Cirrus people.
>
>> But for debugging we have debugfs when the developer thinks that the
>> feature is not useful for users. The module parameter solution is not
>> good in my eyes.
> Yeah, I believe we should disable it unconditionally, and provide a
> different way like debugfs in the firmware driver side, too -- again,
> if the exposure is only for debugging.

I'll update the patch to completely remove the creation of these controls.
The tuning files, which are specific for each laptop, that are loaded in conjunction with the firmware files already provide us with the all the control we need over the firmware coefficients, so the ALSA Controls are not needed for anything.
These controls were never intended to be exposed to users, anyway, but the firmware doesn't mark them as hidden, so its best for the driver to just ignore them.
We think there's very little value in providing an different way (i.e. debugfs) to accessing these controls for debug purposes, so we think we should just remove them.

Thanks,

Stefan

>
>
> Takashi

