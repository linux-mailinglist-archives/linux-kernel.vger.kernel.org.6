Return-Path: <linux-kernel+bounces-367567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289EC9A03E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4472B27B30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95F1D2B37;
	Wed, 16 Oct 2024 08:15:02 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867D1D14FC;
	Wed, 16 Oct 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066501; cv=none; b=Cxc3ER65jxZD+u4mc3OkzZLVtAH7FM/xTfZgXuEShZ/g75HtFuGtn8YRM1mkn0SKH7wM0ZOKOGP5MUIk7baU7v3+EKMFL6CDq2+1fXdFCErW6ZMtE1IH4yX0WIrpdhoCkvhRywklTcOhk3tLYQfeH3kieK7KKwc7Tf0pxLJe8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066501; c=relaxed/simple;
	bh=AeeIRsmAculXd0dhod8ePmCmOOk0j8YnvSaah4Mgsxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=la5y4mA+uA8zBdFeQ3Y9cUdgm03cCeDiQycFJ4/dmepRXHAH5qa5b3NMtXIGLJaIXL3EAcfxJV1sO78UZlwkEYdwdJtwz6vO7fZUC0UEKagTT7EYzAM78tK86KVSm2d/l6tr4UMlVNsREck8Pyh9EdyZIoAoIbELwVr7DRiRNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 4B93B2F2024D; Wed, 16 Oct 2024 08:14:57 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.103] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 69E862F20257;
	Wed, 16 Oct 2024 08:14:56 +0000 (UTC)
Message-ID: <f3836285-befc-92af-38ef-e58a84f920fd@basealt.ru>
Date: Wed, 16 Oct 2024 11:14:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ALSA: hda/conexant - Fix audio routing for HP EliteOne
 1000 G2
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 bo liu <bo.liu@senarytech.com>
References: <20241009134248.662175-1-kovalev@altlinux.org>
 <87h69ltmgn.wl-tiwai@suse.de>
 <b0ac19a5-1d93-41a5-beaa-279939e8ebde@nvidia.com>
 <87y12wsfin.wl-tiwai@suse.de>
 <6ef8fef9-c44d-40d6-f7e1-236e68175071@basealt.ru>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <6ef8fef9-c44d-40d6-f7e1-236e68175071@basealt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


10.10.2024 11:36, Vasiliy Kovalev пишет:
> 
> 10.10.2024 08:17, Takashi Iwai wrote:
>> On Thu, 10 Oct 2024 05:32:18 +0200,
>> Kai-Heng Feng wrote:
>>>
>>>
>>> On 2024/10/9 9:50 PM, Takashi Iwai wrote:
>>>> On Wed, 09 Oct 2024 15:42:48 +0200,
>>>> Vasiliy Kovalev wrote:
>>>>>
>>>>> There is a problem with simultaneous audio output to headphones and
>>>>> speakers, and when headphones are turned off, the speakers also turn
>>>>> off and do not turn them on.
>>>>>
>>>>> However, it was found that if you boot linux immediately after 
>>>>> windows,
>>>>> there are no such problems. When comparing alsa-info, the only 
>>>>> difference
>>>>> is the different configuration of Node 0x1d:
>>>>>
>>>>> working conf. (windows): Pin-ctls: 0x80: HP
>>>>> not working     (linux): Pin-ctls: 0xc0: OUT HP
>>>>>
>>>>> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
>>>>> described problem.
>>>
>>> Though this is already applied, is it possible to see if the issue
>>> also happens on S4?
>>>
>>> Linux doesn't put PCI devices like HDA to D3 during shutdown and
>>> reboot while Windows does, that might be the reason boot Linux after
>>> Windows can workaround the issue.
>>>
>>> Linux does put PCI devices to D3 for hibernate (S4), so we can use it
>>> as an experiment.
>>
>> Right, it should have been the cached version so that the setup is
>> reapplied automatically; i.e. replace snd_hda_set_pin_ctl() with
>> snd_hda_set_pin_ctl_cached().
>>
>> Vasiliy, care to test and submit an incremental fix?
> 
> Ok, I compiled the module with the proposed changes and sent it to the 
> user for testing on a machine with this codec. After testing, I will 
> write about the result.

Using the snd_hda_set_pin_ctl_cache() function instead of 
snd_hda_set_pin_ctl() leads to the same positive result, there are no 
problems with sound.  The patch has been sent [1]

[1] https://lore.kernel.org/all/20241016080713.46801-1-kovalev@altlinux.org/

>>
>> thanks,
>>
>> Takashi

--
Thanks,
Vasiliy Kovalev

