Return-Path: <linux-kernel+bounces-233681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594F91BB74
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F3B21760
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6C15250D;
	Fri, 28 Jun 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aJAkGsH7"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96136405E6;
	Fri, 28 Jun 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566939; cv=none; b=Id9dA+faHtZsFgS6niMlZmSjvTRZ1jMTd10oCF4NOxcLw2MuOUIldYuHFd6zJL4VXE5b4tED/L70YAaz5RvtACkuka4p1NmnIGYMp+bY47ojenvuQBumva2smHkNjpxprYJ2cfe3Ai1f9hd9XKmaKiU2SVlPyrxmRSGySnjJanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566939; c=relaxed/simple;
	bh=wIyaJYie9lVpxkQ/8l/lWX3v3HtKOk0CNys9c4L+H0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sDzU7zJDeLr2u2S9nA4yDGWgBEVySMcqvg2bZwQmtnXh2wpkOfJePc5G5insGRzD3NTd4oPCgTIQ3yqWBxTbabX4ibciqLOmc8CNrY+vz9g5EHJlhQojxz91qDHi9Y/g0/KFFMCP46mRap27Kh3wWF6bVHilvslEh2GZj1fHilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aJAkGsH7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S92jPq022309;
	Fri, 28 Jun 2024 11:28:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tnd/tz0NxbdAR4sAoV616RBI2NC67FmoilBfsV/s0hk=; b=aJAkGsH71lOmL8wt
	qDpZilSPSQJVzIAKjy37LcIu5QHVJ22aISapIWbfmqpmLOF5S0umYjfn3MHiCqFS
	uQ4ZCd7PuPsXoTrzLpTn8RYb4tQCre+eLR7k0HLkSdvD0S+b0DeoIE2+BT00clsi
	//MD5xhy1Bs4RbrWrEFRJ+Pz73mUo+jVyxJHqj5Az6sVfHpWLwxBq+XJHxrjVY27
	9LbxkWU+/O4AHnUDxcapHRG8Uv+wNRjLcrb3tDQxm7duzGfiaYO5TamVjIbAvF3h
	nNccquNnaW9oBxkSZwwGyQja4rx8s1yIi9JOuOniIVwJa9Ebp0uetdqfb9UyngId
	8Zn7Dg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjpn5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 11:28:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E10740045;
	Fri, 28 Jun 2024 11:28:23 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EBA8121BF64;
	Fri, 28 Jun 2024 11:27:43 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 11:27:43 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 11:27:42 +0200
Message-ID: <995c4498-6845-4fbd-997d-0d2e4e0511d5@foss.st.com>
Date: Fri, 28 Jun 2024 11:27:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v2 6/7] usb: typec: ucsi: extract common
 code for command handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikita Travkin <nikita@trvn.ru>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
 <20240621-ucsi-rework-interface-v2-6-a399ff96bf88@linaro.org>
 <160e7af5-29c8-49a6-ae4f-dbfc3dd608c1@foss.st.com>
 <k2q7g6ka34o2vgoy5s64nwixqa6qjaok72fuxgircwseyn2k7z@pm56aurq42n6>
 <3869dcd0-9936-4712-b7ad-3c66cbe4828a@foss.st.com>
 <CAA8EJpqEYRFOZbN55Eh0SisnR1HQ0iseA1L+1n0QxOrspsmLuQ@mail.gmail.com>
 <1ed93216-9445-4b31-85cf-5b7f35ee91c2@foss.st.com>
 <bd7imlksghy5iigc75ob3mghm5zqvn5wrotj5fez3hahq2zv6x@l2bx6mbnijgp>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <bd7imlksghy5iigc75ob3mghm5zqvn5wrotj5fez3hahq2zv6x@l2bx6mbnijgp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01

On 6/27/24 22:14, Dmitry Baryshkov wrote:
> On Thu, Jun 27, 2024 at 06:49:02PM GMT, Fabrice Gasnier wrote:
>> On 6/27/24 17:58, Dmitry Baryshkov wrote:
>>> On Thu, 27 Jun 2024 at 18:51, Fabrice Gasnier
>>> <fabrice.gasnier@foss.st.com> wrote:
>>>>
>>>> On 6/25/24 18:49, Dmitry Baryshkov wrote:
>>>>> On Tue, Jun 25, 2024 at 05:24:54PM GMT, Fabrice Gasnier wrote:
>>>>>> On 6/21/24 00:55, Dmitry Baryshkov wrote:
>>>>>>> Extract common functions to handle command sending and to handle events
>>>>>>> from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
>>>>>>> the same way.
>>>>>>>
>>>>>>> The CCG driver used DEV_CMD_PENDING both for internal
>>>>>>> firmware-related commands and for UCSI control handling. Leave the
>>>>>>> former use case intact.
>>>>>>>
>>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>> ---
>>>>>>>  drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++++
>>>>>>>  drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
>>>>>>>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 46 ++---------------------------
>>>>>>>  drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
>>>>>>>  drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++---------------------------
>>>>>>>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++--------------------------
>>>>>>>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++-------------------------------
>>>>>>>  7 files changed, 62 insertions(+), 198 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>>>>>>> index 4ba22323dbf9..691ee0c4ef87 100644
>>>>>>> --- a/drivers/usb/typec/ucsi/ucsi.c
>>>>>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>>>>>>> @@ -36,6 +36,48 @@
>>>>>>>   */
>>>>>>>  #define UCSI_SWAP_TIMEOUT_MS       5000
>>>>>>>
>>>>>>> +void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>>>>>>> +{
>>>>>>> +   if (UCSI_CCI_CONNECTOR(cci))
>>>>>>> +           ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>>>>>>> +
>>>>>>> +   if (cci & UCSI_CCI_ACK_COMPLETE &&
>>>>>>> +       test_bit(ACK_PENDING, &ucsi->flags))
>>>>>>> +           complete(&ucsi->complete);
>>>>>>> +
>>>>>>> +   if (cci & UCSI_CCI_COMMAND_COMPLETE &&
>>>>>>> +       test_bit(COMMAND_PENDING, &ucsi->flags))
>>>>>>> +           complete(&ucsi->complete);
>>>>>>
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> I've recently faced some race with ucsi_stm32g0 driver, and have sent a
>>>>>> fix for it [1], as you've noticed in the cover letter.
>>>>>>
>>>>>> To fix that, I've used test_and_clear_bit() in above two cases, instead
>>>>>> of test_bit().
>>>>>
>>>>> Could you possible describe, why do you need test_and_clear_bit()
>>>>> instead of just test_bit()? The bits are cleared at the end of the
>>>>> .sync_write(), also there can be no other command (or ACK_CC) submission
>>>>> before this one is fully processed.
>>>>
>>>> Hi Dmitry,
>>>>
>>>> It took me some time to reproduce this race I observed earlier.
>>>> (I observe this during DR swap.)
>>>>
>>>> Once the ->async_control(UCSI_ACK_CC_CI) call bellow gets completed, and
>>>> before the ACK_PENDING bit gets cleared, e.g. clear_bit(ACK_PENDING), I
>>>> get an asynchronous interrupt.
>>>>
>>>> Basically, Then the above complete() gets called (due to
>>>> UCSI_CCI_ACK_COMPLETE & ACK_PENDING).
>>>>
>>>> Subsequent UCSI_GET_CONNECTOR_STATUS command (from
>>>> ucsi_handle_connector_change) will be unblocked immediately due to
>>>> complete() call has already happen, without UCSI_CCI_COMMAND_COMPLETE
>>>> cci flag, hence returning -EIO.
>>>
>>> But the ACK_CI is being sent as a response to a command. This means
>>> that the ppm_lock should be locked. The UCSI_GET_CONNECTOR_STATUS
>>> command should wait for ppm_lock to be freed and only then it can
>>> proceed with sending the command. Maybe I'm misunderstanding the case
>>> or maybe there is a loophole somewhere.
>>
>> There's probably also some miss-understanding at my end, I don't get how
>> the ppm_lock would protext from non atomic async_control()/clear_bit().
>>
>> Let me share some trace here, I hope it can better show the difference
>> at my end when I get the race.
>> I've added some debug prints around these lines, to trace the set/clear
>> of the COMMAND/ACK_PENDING, main commands and cci flags.
>>
>> normal case is:
>> ---
>> ucsi_send_command_common: UCSI_SET_UOR
>> set:COMMAND_PENDING
>> ucsi_stm32g0_irq_handler
>> ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
>> clr:COMMAND_PENDING
>> ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE UCSI_ACK_CONNECTOR_CHANGE
>> set:ACK_PENDING
>> ucsi_stm32g0_irq_handler
>> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
>> clr:ACK_PENDING
>> ucsi_stm32g0_irq_handler
>> ucsi_notify_common: ucsi_connector_change
>> ucsi_send_command_common: UCSI_GET_CONNECTOR_STATUS
>> set:COMMAND_PENDING
>> ucsi_stm32g0_irq_handler
>> ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
>> clr:COMMAND_PENDING
>> ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE
>> set:ACK_PENDING
>> ucsi_stm32g0_irq_handler
>> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
>> clr:ACK_PENDING
>>
>> racy case:
>> ---
>> ucsi_send_command_common: UCSI_SET_UOR
>> set:COMMAND_PENDING
>> ucsi_stm32g0_irq_handler
>> ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
>> clr:COMMAND_PENDING
>> ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE UCSI_ACK_CONNECTOR_CHANGE
>> set:ACK_PENDING
>> ucsi_stm32g0_irq_handler              <-- up to here nothing supicious
>> ucsi_notify_common: ucsi_connector_change
>> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
>> ucsi_stm32g0_irq_handler              <-- 2nd IRQ before clr:ACK_PENDING
>> ucsi_notify_common: ucsi_connector_change
>> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
>> clr:ACK_PENDING
>> ucsi_send_command_common: UCSI_GET_CONNECTOR_STATUS
>> set:COMMAND_PENDING                   <-- completion already done :-(
>> clr:COMMAND_PENDING
>> ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-5)
>>
>> I notice the two conditions are met above: both ucsi_connector_change()
>> and cci ack completed.
>>
>> This happens before clear_bit(ACK_PENDING), which lead to anticipate
>> completion of the subsequent UCSI_GET_CONNECTOR_STATUS command.
>>
>> So the test_and_clear_bit() would address a robustness case?
> 
> Ah, I see. So the race is for the completion. I fear that your solution
> also doesn't fully solve the problem. The event can arrive after setting
> the bit and before sending the command to the hardware. I thought about
> doing various tricks, like reinit_completion or something close, but the
> issue is that test_and_clear_bit() just makes the race window smaller,
> but doesn't eliminate it completely.

Hi Dmitry,

I've done some tests with reinit_completion(), when entering the
ucsi_sync_control_common() routine:

+	reinit_completion(&ucsi->complete);

	if (ack)
		set_bit(ACK_PENDING, &ucsi->flags);
	else
		set_bit(COMMAND_PENDING, &ucsi->flags);


This indeed avoids the race on the completion at my end.
With that, I longer get the error on the subsequent
UCSI_GET_CONNECTOR_STATUS command.

It looks like a better compromise to me, than test_and_clear_bit() as
you pointed out.

Best Regards,
Fabrice

> 
> It seems the only practical way to handle that is by making sure that
> ucsi_notify_common() can sleep and locks the ppm_lock while
> processing the CCI.
> 
>>
>> Please advise,
>> Best Regards,
>> Fabrice
>>
>>>
>>>> This is where the test_and_clear_bit() atomic operation helps, to avoid
>>>> non atomic operation:
>>>>
>>>> -> async_control(UCSI_ACK_CC_CI)
>>>> new interrupt may occur here
>>>> -> clear_bit(ACK_PENDING)
> 

