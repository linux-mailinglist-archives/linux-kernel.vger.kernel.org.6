Return-Path: <linux-kernel+bounces-358550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F29980B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873C71F24970
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6321EF0A9;
	Thu, 10 Oct 2024 08:36:23 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1B1EF08A;
	Thu, 10 Oct 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549383; cv=none; b=rN7UYCGOfRWh+g65pHBOyRtOy3HErv4biypUZ+AMAtmVado7VOjASNrjbd0kwtLoHfE8h97Nh0SbPfo0FIZSiE8hvcuD7mC5TL9LOJI+JXA0D6aiyM1YARYTUw9kupyBDsSWJfoXZWJbdgmb8q6jw4lqjWICTJo3hW0166BvnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549383; c=relaxed/simple;
	bh=Fbyl8TGWSc7y9LAYWk6wltZ/PWJmVu8/CNcNbupt+nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoWxwBmXNWapuEGKmLgCoX1/2JN/dq7NsNNrB788HXEAc/IlzCS7IlOZpJBylavBRmcGJUDklPfAoJWsKs0vupGefWM1MeMlAN8spfBFgD65XoG2CVzSlmDM+CV7JJevbtzricF2y6pvw3jijxqnMcJcP6d+MeUdrE/1pMgZP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 73B1F2F20268; Thu, 10 Oct 2024 08:36:17 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.103] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 9CD852F2023F;
	Thu, 10 Oct 2024 08:36:16 +0000 (UTC)
Message-ID: <6ef8fef9-c44d-40d6-f7e1-236e68175071@basealt.ru>
Date: Thu, 10 Oct 2024 11:36:15 +0300
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
Cc: Vasiliy Kovalev <kovalev@altlinux.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, bo liu <bo.liu@senarytech.com>
References: <20241009134248.662175-1-kovalev@altlinux.org>
 <87h69ltmgn.wl-tiwai@suse.de>
 <b0ac19a5-1d93-41a5-beaa-279939e8ebde@nvidia.com>
 <87y12wsfin.wl-tiwai@suse.de>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <87y12wsfin.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


10.10.2024 08:17, Takashi Iwai wrote:
> On Thu, 10 Oct 2024 05:32:18 +0200,
> Kai-Heng Feng wrote:
>>
>>
>> On 2024/10/9 9:50 PM, Takashi Iwai wrote:
>>> On Wed, 09 Oct 2024 15:42:48 +0200,
>>> Vasiliy Kovalev wrote:
>>>>
>>>> There is a problem with simultaneous audio output to headphones and
>>>> speakers, and when headphones are turned off, the speakers also turn
>>>> off and do not turn them on.
>>>>
>>>> However, it was found that if you boot linux immediately after windows,
>>>> there are no such problems. When comparing alsa-info, the only difference
>>>> is the different configuration of Node 0x1d:
>>>>
>>>> working conf. (windows): Pin-ctls: 0x80: HP
>>>> not working     (linux): Pin-ctls: 0xc0: OUT HP
>>>>
>>>> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
>>>> described problem.
>>>>
>>>> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
>>>
>>> Thanks, applied now.
>>
>> Though this is already applied, is it possible to see if the issue
>> also happens on S4?
>>
>> Linux doesn't put PCI devices like HDA to D3 during shutdown and
>> reboot while Windows does, that might be the reason boot Linux after
>> Windows can workaround the issue.
>>
>> Linux does put PCI devices to D3 for hibernate (S4), so we can use it
>> as an experiment.
> 
> Right, it should have been the cached version so that the setup is
> reapplied automatically; i.e. replace snd_hda_set_pin_ctl() with
> snd_hda_set_pin_ctl_cached().
> 
> Vasiliy, care to test and submit an incremental fix?

Ok, I compiled the module with the proposed changes and sent it to the 
user for testing on a machine with this codec. After testing, I will 
write about the result.

> 
> thanks,
> 
> Takashi
--
Thanks,
Vasiliy Kovalev

