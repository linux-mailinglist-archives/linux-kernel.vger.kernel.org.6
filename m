Return-Path: <linux-kernel+bounces-232696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEE91AD32
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8D1B264FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EED7199E9D;
	Thu, 27 Jun 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="s/+/L4Ce"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28887E56A;
	Thu, 27 Jun 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507038; cv=none; b=tNnYKf7RzYk2pPEmtYUFSlYsgGzAj57rUe/X3/SSSWtFUyT9PhjIGLXDihyCORQmjOKi2SFy8diTHML3htyDB5GpmsaSvprOfYuPvV3M8sdM6Z+1OPfis5qazBvNKy2S14rMl8i9clKFWf0xRu1caGaHEkKIRBScQAVrhnTpfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507038; c=relaxed/simple;
	bh=PW2WJsrl1K38wdefvdyTnJBCRROT7XlLQLn33txQrLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HxRl6NR0udq3o2G1qWYqcXHfTO651mtVJSO7iDDii/kK51ZcKzOmqeKUe9JuO8TGeTvXiMdy5YzGRveXTTpdnt+ucnYy7GZaFaqcikWlQTM2tbYJupOnx6b3Pl0xvUv9Sw0193Hv28o8LABksUmMBr+wvkxWv+2dzk9smlzaOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=s/+/L4Ce; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RCt2c0027601;
	Thu, 27 Jun 2024 18:50:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	VP2bD61+z+J6l3jmGgfZzieeOpJ8ufLGwpCo2aUvUKw=; b=s/+/L4Ce7GFaX/iW
	EdvdrcseBtYae6hrx+yjqXPwHnNr0q09mzM99UklISDgPv6Kk/NH/Kh81WJ73wXY
	zfSlG2NBjR1lN6sTFeBXLyzBvxizX4WIdEkSfiMGyxae3nGi0Ibb82qZtJhYqI/p
	/pe7g3kVTalTbmBEwxYEMM1YzQyZIJ2I3nOgKoT2wZQkYSL1zpuZ/I0bzxl0cTsf
	ev09QWZxuRx4PuJZJ+aQyp/NT6Ga02W/cuaEXmzvUPTVNzA6CivysFacAYzV+fBR
	28lFmdhcD3pR9Iunu7LbtJ32omoq9A7WxHGAQcPBf7FGLkdmOkpZ+9SIq74RPuWK
	5pqXTg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywngdp335-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 18:50:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 00EDE4002D;
	Thu, 27 Jun 2024 18:49:47 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1669226FA3;
	Thu, 27 Jun 2024 18:49:03 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 18:49:03 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 18:49:02 +0200
Message-ID: <1ed93216-9445-4b31-85cf-5b7f35ee91c2@foss.st.com>
Date: Thu, 27 Jun 2024 18:49:02 +0200
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
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <CAA8EJpqEYRFOZbN55Eh0SisnR1HQ0iseA1L+1n0QxOrspsmLuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01

On 6/27/24 17:58, Dmitry Baryshkov wrote:
> On Thu, 27 Jun 2024 at 18:51, Fabrice Gasnier
> <fabrice.gasnier@foss.st.com> wrote:
>>
>> On 6/25/24 18:49, Dmitry Baryshkov wrote:
>>> On Tue, Jun 25, 2024 at 05:24:54PM GMT, Fabrice Gasnier wrote:
>>>> On 6/21/24 00:55, Dmitry Baryshkov wrote:
>>>>> Extract common functions to handle command sending and to handle events
>>>>> from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
>>>>> the same way.
>>>>>
>>>>> The CCG driver used DEV_CMD_PENDING both for internal
>>>>> firmware-related commands and for UCSI control handling. Leave the
>>>>> former use case intact.
>>>>>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>  drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++++
>>>>>  drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
>>>>>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 46 ++---------------------------
>>>>>  drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
>>>>>  drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++---------------------------
>>>>>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++--------------------------
>>>>>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++-------------------------------
>>>>>  7 files changed, 62 insertions(+), 198 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>>>>> index 4ba22323dbf9..691ee0c4ef87 100644
>>>>> --- a/drivers/usb/typec/ucsi/ucsi.c
>>>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>>>>> @@ -36,6 +36,48 @@
>>>>>   */
>>>>>  #define UCSI_SWAP_TIMEOUT_MS       5000
>>>>>
>>>>> +void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>>>>> +{
>>>>> +   if (UCSI_CCI_CONNECTOR(cci))
>>>>> +           ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>>>>> +
>>>>> +   if (cci & UCSI_CCI_ACK_COMPLETE &&
>>>>> +       test_bit(ACK_PENDING, &ucsi->flags))
>>>>> +           complete(&ucsi->complete);
>>>>> +
>>>>> +   if (cci & UCSI_CCI_COMMAND_COMPLETE &&
>>>>> +       test_bit(COMMAND_PENDING, &ucsi->flags))
>>>>> +           complete(&ucsi->complete);
>>>>
>>>> Hi Dmitry,
>>>>
>>>> I've recently faced some race with ucsi_stm32g0 driver, and have sent a
>>>> fix for it [1], as you've noticed in the cover letter.
>>>>
>>>> To fix that, I've used test_and_clear_bit() in above two cases, instead
>>>> of test_bit().
>>>
>>> Could you possible describe, why do you need test_and_clear_bit()
>>> instead of just test_bit()? The bits are cleared at the end of the
>>> .sync_write(), also there can be no other command (or ACK_CC) submission
>>> before this one is fully processed.
>>
>> Hi Dmitry,
>>
>> It took me some time to reproduce this race I observed earlier.
>> (I observe this during DR swap.)
>>
>> Once the ->async_control(UCSI_ACK_CC_CI) call bellow gets completed, and
>> before the ACK_PENDING bit gets cleared, e.g. clear_bit(ACK_PENDING), I
>> get an asynchronous interrupt.
>>
>> Basically, Then the above complete() gets called (due to
>> UCSI_CCI_ACK_COMPLETE & ACK_PENDING).
>>
>> Subsequent UCSI_GET_CONNECTOR_STATUS command (from
>> ucsi_handle_connector_change) will be unblocked immediately due to
>> complete() call has already happen, without UCSI_CCI_COMMAND_COMPLETE
>> cci flag, hence returning -EIO.
> 
> But the ACK_CI is being sent as a response to a command. This means
> that the ppm_lock should be locked. The UCSI_GET_CONNECTOR_STATUS
> command should wait for ppm_lock to be freed and only then it can
> proceed with sending the command. Maybe I'm misunderstanding the case
> or maybe there is a loophole somewhere.

There's probably also some miss-understanding at my end, I don't get how
the ppm_lock would protext from non atomic async_control()/clear_bit().

Let me share some trace here, I hope it can better show the difference
at my end when I get the race.
I've added some debug prints around these lines, to trace the set/clear
of the COMMAND/ACK_PENDING, main commands and cci flags.

normal case is:
---
ucsi_send_command_common: UCSI_SET_UOR
set:COMMAND_PENDING
ucsi_stm32g0_irq_handler
ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
clr:COMMAND_PENDING
ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE UCSI_ACK_CONNECTOR_CHANGE
set:ACK_PENDING
ucsi_stm32g0_irq_handler
ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
clr:ACK_PENDING
ucsi_stm32g0_irq_handler
ucsi_notify_common: ucsi_connector_change
ucsi_send_command_common: UCSI_GET_CONNECTOR_STATUS
set:COMMAND_PENDING
ucsi_stm32g0_irq_handler
ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
clr:COMMAND_PENDING
ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE
set:ACK_PENDING
ucsi_stm32g0_irq_handler
ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
clr:ACK_PENDING

racy case:
---
ucsi_send_command_common: UCSI_SET_UOR
set:COMMAND_PENDING
ucsi_stm32g0_irq_handler
ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
clr:COMMAND_PENDING
ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE UCSI_ACK_CONNECTOR_CHANGE
set:ACK_PENDING
ucsi_stm32g0_irq_handler              <-- up to here nothing supicious
ucsi_notify_common: ucsi_connector_change
ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
ucsi_stm32g0_irq_handler              <-- 2nd IRQ before clr:ACK_PENDING
ucsi_notify_common: ucsi_connector_change
ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
clr:ACK_PENDING
ucsi_send_command_common: UCSI_GET_CONNECTOR_STATUS
set:COMMAND_PENDING                   <-- completion already done :-(
clr:COMMAND_PENDING
ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-5)

I notice the two conditions are met above: both ucsi_connector_change()
and cci ack completed.

This happens before clear_bit(ACK_PENDING), which lead to anticipate
completion of the subsequent UCSI_GET_CONNECTOR_STATUS command.

So the test_and_clear_bit() would address a robustness case?

Please advise,
Best Regards,
Fabrice

> 
>> This is where the test_and_clear_bit() atomic operation helps, to avoid
>> non atomic operation:
>>
>> -> async_control(UCSI_ACK_CC_CI)
>> new interrupt may occur here
>> -> clear_bit(ACK_PENDING)
>>
>>>
>>>>
>>>> https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
>>>>
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(ucsi_notify_common);
>>>>> +
>>>>> +int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
>>>>> +{
>>>>> +   bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
>>>>> +   int ret;
>>>>> +
>>>>> +   if (ack)
>>>>> +           set_bit(ACK_PENDING, &ucsi->flags);
>>>>> +   else
>>>>> +           set_bit(COMMAND_PENDING, &ucsi->flags);
>>>>> +
>>>>> +   ret = ucsi->ops->async_control(ucsi, command);
>>>>> +   if (ret)
>>>>> +           goto out_clear_bit;
>>>>> +
>>>>> +   if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
>>>>> +           ret = -ETIMEDOUT;
>>>>
>>>> With test_and_clear_bit(), could return 0, in case of success here.
>>>
>>> Oh, I see. So your code returns earlier. I have a feeling that this
>>> approach is less logical and slightly harder to follow.
>>
>> By reading your proposal bellow, I'd agree with you.
>>>
>>> Maybe it's easier if it is implemented as:
>>>
>>> if (wait_for_completion_timeout(...))
>>>       return 0;
>>
>> Yes, sounds good to me.
>>
>>>
>>> if (ack)
>>>       clear_bit(ACK_PENDING)
>>> else
>>>       clear_bit(COMMAND_PENDING)
>>>
>>> return -ETIMEDOUT;
>>>
>>>
>>> OR
>>>
>>> if (!wait_for_completion_timeout(...)) {
>>>       if (ack)
>>>               clear_bit(ACK_PENDING)
>>>       else
>>>               clear_bit(COMMAND_PENDING)
>>>
>>>       return -ETIMEDOUT;
>>> }
>>
>> Both seems fine.
>>
>> Please advise,
>> BR,
>> Fabrice
>>
>>>
>>> return 0;
>>>
>>> But really, unless there is an actual issue with the current code, I'd
>>> prefer to keep it. It makes it clear that the bits are set and then are
>>> cleared properly.
>>>
>>>> I'd suggest to use similar approach here, unless you see some drawback?
>>>>
>>>> Best Regards,
>>>> Fabrice
>>>>
>>>>> +
>>>>> +out_clear_bit:
>>>>> +   if (ack)
>>>>> +           clear_bit(ACK_PENDING, &ucsi->flags);
>>>>> +   else
>>>>> +           clear_bit(COMMAND_PENDING, &ucsi->flags);
>>>>> +
>>>>> +   return ret;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
>>>>> +
>>>>>  static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
>>>>>  {
>>>>>     u64 ctrl;
>>>>> @@ -1883,6 +1925,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
>>>>>     INIT_WORK(&ucsi->resume_work, ucsi_resume_work);
>>>>>     INIT_DELAYED_WORK(&ucsi->work, ucsi_init_work);
>>>>>     mutex_init(&ucsi->ppm_lock);
>>>>> +   init_completion(&ucsi->complete);
>>>>>     ucsi->dev = dev;
>>>>>     ucsi->ops = ops;
>>>>
>>>> [snip]
>>>>
>>>>>     ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
>>>>> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
>>>>> index 14737ca3724c..d948c3f579e1 100644
>>>>> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
>>>>> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
>>>>> @@ -61,11 +61,7 @@ struct ucsi_stm32g0 {
>>>>
>>>> [snip]
>>>>
>>>>> -
>>>>> -   ret = ucsi_stm32g0_async_control(ucsi, command);
>>>>> -   if (ret)
>>>>> -           goto out_clear_bit;
>>>>> -
>>>>> -   if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
>>>>> -           ret = -ETIMEDOUT;
>>>>> -   else
>>>>> -           return 0;
>>>>> -
>>>>> -out_clear_bit:
>>>>> -   if (ack)
>>>>> -           clear_bit(ACK_PENDING, &g0->flags);
>>>>> -   else
>>>>> -           clear_bit(COMMAND_PENDING, &g0->flags);
>>>>> -
>>>>> -   return ret;
>>>>> -}
>>>>> -
>>>>>  static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>>>>>  {
>>>>>     struct ucsi_stm32g0 *g0 = data;
>>>>> @@ -449,13 +416,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>>>>>     if (ret)
>>>>>             return IRQ_NONE;
>>>>>
>>>>> -   if (UCSI_CCI_CONNECTOR(cci))
>>>>> -           ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
>>>>> -
>>>>> -   if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
>>>>> -           complete(&g0->complete);
>>>>> -   if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
>>>>> -           complete(&g0->complete);
>>>>> +   ucsi_notify_common(g0->ucsi, cci);
>>>>
>>>> I can see the fix "test_and_clear_bit()" sent earlier is removed from here.
>>>>
>>>> I'd suggest to use similar approach as here, unless you see some drawback?
>>>>
>>>> Please advise,
>>>> Best Regards,
>>>> Fabrice
>>>
> 
> 
> 

