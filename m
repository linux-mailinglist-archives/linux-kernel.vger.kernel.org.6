Return-Path: <linux-kernel+bounces-325363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD897589B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CF11F22CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644A1AE864;
	Wed, 11 Sep 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxZIycRr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727819AA4E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072609; cv=none; b=GNQTq9W9LGtoD0VFh6fe7DTspinbhZqaQOoG4Dc4KyjHb60xZQGsp0V6TvrPzs23AoLpHKbBiqRZ86TdDjkvUb6pIEstT7IyC3/veTFUdvio2v+oD8XkZ23Py0bb4Q9WcVGUBToi8iKWH1fhPQ+PBx1dCyEnuwijgvH/0KJjDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072609; c=relaxed/simple;
	bh=Y0B40j+6XfhANv86hO/y2jfsZpiCElizXindBwzyRU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bp8SW9ktcZOwB61/Vlr8eDGtDKEgdcZjiAXo0qeQeIlNHTHLALuo+9MZPvY71KjOQqtA8wrbW1TFibOB+TqqV5nFnKzr2V9yxHBEcpKMTiCSATBMgZWw8L+4uAMPQErpiKYLEv47AQe2Ult6ufoLokCvJJTjr+uSylJIpCOd7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxZIycRr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so7483698a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726072606; x=1726677406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGFSZxbGGSwXr4tsYBH87dhImbiPRckhT6s8NPepfIw=;
        b=IxZIycRrq2ZzWUVhM/+tXQvlOQ/5ZLDgy5XEENRpYK2VjqzD+gwMItAf7BoBPYvAH3
         hDsSKlYpK7+0SSQPAoW6Qzi8WeQojFmhd6seFMNRaxSM6Dn5sGHYFdVSssigJaMl3kx+
         Ovov9aEtCnq0JrwJIB9k1swJ8HY/H9qM0gvONM7GaG0sbSGPwEth7EYjjw9PlV9J7nSi
         gWen+aKCMzWsIrpajWyNB57kJrEKkJl4yKnOuYAGoA01RHIKKD8ioxi7InkZo8lAX5BA
         FE/xsuwxiOnLAEVrNG21qpADepsKAO7ZSQD3pwrtBAywWqDjBMOCJXrxXJHsX52reEC8
         DVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726072606; x=1726677406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGFSZxbGGSwXr4tsYBH87dhImbiPRckhT6s8NPepfIw=;
        b=YhtqmvSHR8ZbTNxdM+IfbOIL1F5NJKSBuGJHU82+T+enjhaa/OiLB3yTqvAkm2szA5
         wrtBhG57rg467lz75p1RxddAV5IuR0+WTbE4HhcdxkVWKNz2EX/eY8J4NmfCf/pBgcBx
         bdocDfl/P9kl46tR5Jq6reaciU2zt64IJ5z1fZB+2++Qy8HKLQdubKQp3e0nGC+3L25Q
         1yP1siPYpCfCRMUnrRJ9BKteuXeEXtwt4HsTnbi8QkfCO9erlPB17kQuC0DpEgh4Cd9M
         Bpv1bgztlWIJF0kj6zMA2IaiIkOLrYYcU3dpbAth0CJvnbyrwpBtbZDwSb7TU9OhqZJd
         S2cA==
X-Forwarded-Encrypted: i=1; AJvYcCUKFAZUdHW0Dfo3+SnXUBszUFn7juhtQkC1R9yk+3A2DrRbbXVg4489m31azLHFkW14JMHmF2LU8DARXjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhIVwMPsNaqm9C95YiVydI3r4mH1Ppz2IL/QETTCe/INJNbux
	hMOgk6gZ+MyuyDR4SpJxWZuwbYvu11zGO3U5g8ar70MK+/QmUZSP
X-Google-Smtp-Source: AGHT+IFB8LrmoJ77KXeUcOqmvYDxZrxZCXblK6guiGjjrd9zznVwaL7hH6w33YQENm1mdPtPPoNcbw==
X-Received: by 2002:a05:6402:3092:b0:5c0:8c5a:f4f3 with SMTP id 4fb4d7f45d1cf-5c413e4fb87mr33032a12.26.1726072605230;
        Wed, 11 Sep 2024 09:36:45 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8584:fadb:465e:486a:4871? (p200300c78f2a8584fadb465e486a4871.dip0.t-ipconnect.de. [2003:c7:8f2a:8584:fadb:465e:486a:4871])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd4680esm5565368a12.21.2024.09.11.09.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:36:44 -0700 (PDT)
Message-ID: <93afc2fd-7aa2-41d5-bd08-2afc72540abb@gmail.com>
Date: Wed, 11 Sep 2024 18:36:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8723bs: Fix coding style issues in the
 hal_pwr_seq.h
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20240910121144.635348-1-sayyad.abid16@gmail.com>
 <89893a22-5018-4ae0-b4f9-e473a36f09b6@gmail.com> <ZuCY1Tuog1sFHLBQ@debian>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZuCY1Tuog1sFHLBQ@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 21:07, Sayyad Abid wrote:
> On Tue, Sep 10, 2024 at 08:47:54PM +0200, Philipp Hortmann wrote:
>> On 9/10/24 14:11, abid-sayyad wrote:
>>> Improving the code readability and coding style compliance of the code.
>>> Running checkpatch.pl on the file raised coding style warnings:
>>> -The comment block needs "*" on all lines of the block
>>> from line 8 to 26
>>> -Use tabs for indent
>>> on line 103 and 115
>>>
>>> Applying the patch fixes these coding style issues and makes the code more
>>> readable/developer friendly.
>>>
>>> Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
>>> ---
>>
>> Hi Abid,
>>
>> I cannot apply your patch. Are you using the right git repo?
>>
>> git remote show origin
>> * remote origin
>>    Fetch URL:
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>> ...
>> git branch -a
>> my branch: staging-testing
>>
>>
>> kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ mutt
>> Applying: staging: rtl8723bs: Fix coding style issues in the hal_pwr_seq.h
>> error: patch failed: drivers/staging/rtl8723bs/include/hal_pwr_seq.h:101
>> error: drivers/staging/rtl8723bs/include/hal_pwr_seq.h: patch does not apply
>> Patch failed at 0001 staging: rtl8723bs: Fix coding style issues in the
>> hal_pwr_seq.h
>>
> I found the issue, I have been amending these changes on the mainline repo,
>    $ git remote show origin
> * remote origin
>    Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
>    I need to clone the staging branch.
>> Please also change your Description. Concentrate on why this patch makes
>> sense. Do not describe the patch. What is changed can be seen below. Please
>> also use the correct time.
>>
> I did not understand the correct time here. could you please
> elaborate a little on this please.

Hi Abid,

please visit:

https://kernelnewbies.org/PatchPhilosophy#Patch_description_format_for_checkpatch_fixes

Look for this clause:
"In patch descriptions and in the subject, it is common and preferable 
to use present-tense, imperative language. Write as if you are telling 
git what to do with your patch. For example, instead of:"

This is about the time that should be used in patches.

Bye Philipp

>> You can find accepted examples in the git repo.
>>
> I'll look into the accepted patches right now. Meanwhile I have this question
> , descriptions addressing only the coding style issue fixes are acceptable or
> it needs to be having somethingelse too? (apologies in advance for
> this illy question)
>> Thanks for your support.
>>
>> Bye Philipp
>>
> Thank Youy for your feedbacks
>>
>>
>>> changes since v1:
>>> v2: Fix the email body, amke it more informative
>>> link to v1:
>>> https://lore.kernel.org/all/ca1908f3-74aa-45e7-a389-3995aba2660c@gmail.com/
>>>    .../staging/rtl8723bs/include/hal_pwr_seq.h   | 46 +++++++++----------
>>>    1 file changed, 23 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
>>> index 5e43cc89f535..10fef1b3f393 100644
>>> --- a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
>>> +++ b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
>>> @@ -5,26 +5,26 @@
>>>    #include "HalPwrSeqCmd.h"
>>>
>>>    /*
>>> -	Check document WM-20130815-JackieLau-RTL8723B_Power_Architecture v08.vsd
>>> -	There are 6 HW Power States:
>>> -	0: POFF--Power Off
>>> -	1: PDN--Power Down
>>> -	2: CARDEMU--Card Emulation
>>> -	3: ACT--Active Mode
>>> -	4: LPS--Low Power State
>>> -	5: SUS--Suspend
>>> -
>>> -	The transition from different states are defined below
>>> -	TRANS_CARDEMU_TO_ACT
>>> -	TRANS_ACT_TO_CARDEMU
>>> -	TRANS_CARDEMU_TO_SUS
>>> -	TRANS_SUS_TO_CARDEMU
>>> -	TRANS_CARDEMU_TO_PDN
>>> -	TRANS_ACT_TO_LPS
>>> -	TRANS_LPS_TO_ACT
>>> -
>>> -	TRANS_END
>>> -*/
>>> + *	Check document WM-20130815-JackieLau-RTL8723B_Power_Architecture v08.vsd
>>> + *	There are 6 HW Power States:
>>> + *	0: POFF--Power Off
>>> + *	1: PDN--Power Down
>>> + *	2: CARDEMU--Card Emulation
>>> + *	3: ACT--Active Mode
>>> + *	4: LPS--Low Power State
>>> + *	5: SUS--Suspend
>>> + *
>>> + *	The transition from different states are defined below
>>> + *	TRANS_CARDEMU_TO_ACT
>>> + *	TRANS_ACT_TO_CARDEMU
>>> + *	TRANS_CARDEMU_TO_SUS
>>> + *	TRANS_SUS_TO_CARDEMU
>>> + *	TRANS_CARDEMU_TO_PDN
>>> + *	TRANS_ACT_TO_LPS
>>> + *	TRANS_LPS_TO_ACT
>>> + *
>>> + *	TRANS_END
>>> + */
>>>    #define	RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS	26
>>>    #define	RTL8723B_TRANS_ACT_TO_CARDEMU_STEPS	15
>>>    #define	RTL8723B_TRANS_CARDEMU_TO_SUS_STEPS	15
>>> @@ -101,7 +101,7 @@
>>>    	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x20}, /*0x07 = 0x20 , SOP option to disable BG/MB*/	\
>>>    	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
>>>    	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT2, BIT2}, /*0x04[10] = 1, enable SW LPS*/	\
>>> -        {0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 1}, /*0x48[16] = 1 to enable GPIO9 as EXT WAKEUP*/   \
>>> +	{0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 1}, /*0x48[16] = 1 to enable GPIO9 as EXT WAKEUP*/   \
>>>    	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*0x23[4] = 1b'1 12H LDO enter sleep mode*/   \
>>>    	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
>>>    	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
>>> @@ -112,7 +112,7 @@
>>>    	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3 | BIT7, 0}, /*clear suspend enable and power down enable*/	\
>>>    	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
>>>    	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
>>> -        {0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0}, /*0x48[16] = 0 to disable GPIO9 as EXT WAKEUP*/   \
>>> +	{0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0}, /*0x48[16] = 0 to disable GPIO9 as EXT WAKEUP*/   \
>>>    	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/\
>>>    	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*0x23[4] = 1b'0 12H LDO enter normal mode*/   \
>>>    	{0x0301, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*PCIe DMA start*/
>>> @@ -209,7 +209,7 @@
>>>    #define RTL8723B_TRANS_END															\
>>>    	/* format */																\
>>>    	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
>>> -	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, 0, PWR_CMD_END, 0, 0},
>>> +	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, 0, PWR_CMD_END, 0, 0},
>>>
>>>
>>>    extern struct wlan_pwr_cfg rtl8723B_power_on_flow[RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS+RTL8723B_TRANS_END_STEPS];
>>> --
>>> 2.39.2
>>>
>>


