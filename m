Return-Path: <linux-kernel+bounces-333867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95597CF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796B71F23421
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642E1B2EFC;
	Thu, 19 Sep 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSdYkuQG"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D151B2EC7
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726784108; cv=none; b=sKTHxU0X+zeUmHu9a3YVkVkb++1JrSSIM+e+lkEmoqSr3OUMLrOxD3BqXnDpqDh9L5dmFWTWa4qJEQx9H4I/eBbbqCNoUkRtQ1c9w1St2z2z+1erP7oeZXFZtsBG8TOTea6BzDbMGcbPNkS2257uQY7vJTsknHwcXYGXpaUht9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726784108; c=relaxed/simple;
	bh=Cpg6uP65sSmlYbJOEnyqajVaLcBwOWi8z6QmhTdwgFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAXXe8Ai1yk2+Q8AIoiYsQ1gAvLDUCC+aGLR7en4brIPRrJlUnqlnVDuv53dD9RebuWIv3EabQcP0rpvxQQPNss94ehb2Xbci86Gj49QmxOHRhAzTuY5Nylu5gZRyFn1X9EFSEUjqNN1TKshIGjLzhvgt7zQ0mGyEElqSAcaxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSdYkuQG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so1018165b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726784106; x=1727388906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIMPn5aPnofo8VRZmsoymcqO9bEoZ2tG3YNeZ5jOMBI=;
        b=ZSdYkuQGgAO6QJYpVGOTniYxgjkVcgq38EJ1OFR4ej682U9VXrod/cjoC6Yc3hZYe8
         VDTkB/747d9+NNm0vMekABM/xpcdJ4QtSttY9hXct9HSOQ9MiJhETFMSTVgWiQvidX26
         3JfiO9AV6IKiBUmfMyykqodFvHx9/gwoVc/pC120SLqr23PPfjDdvSI9AoDjhJYudaeX
         32ics59hQjZNQiMspV5uZ9ROAUWhvP+CIVq4a4xL//7HckQYjgqiCSte3be3/vKEBuhf
         Ps4lvx/GB2eTncIfor15nnsCPGLqYvmVbz74ZwLWr7+Q/1KbDv9XrkaczA0+rMWm+da3
         EanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726784106; x=1727388906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIMPn5aPnofo8VRZmsoymcqO9bEoZ2tG3YNeZ5jOMBI=;
        b=kVc4XWvnoOwUPPzQY6Upp97mpGLFLWn4fpRDeFcTfVIifwtTofMdEWhh1WMmDucMe3
         yj5Vslyole1wXyv44EjDpk38NCWYyDLH71KJnJaIYhU9Z6LXUUwQwegcworxVGGviy0A
         NI67nplkgLosFnj4lVgXPORSsIPDXnwy+AUBz0dQ6mCAvKi0BxaodthFJ0nNB9AecEPA
         eIlXDgSsT7TBP6Yf7qJqZCpebIwgHPri0TZVmp/akbXHWq78D/U53zgjAFBGPNrzCZEk
         twNZzE8bixtFZvrsHN88J9HMQAOIYZMR4vGKEX5qvXBMBmue5vK4611SlRmWEU7OYOUF
         XsuA==
X-Forwarded-Encrypted: i=1; AJvYcCU4w5jpmqBBZCnIwlR5JCDKETQ+fMFm6vydLRGaUgMFyf/uFRVI0R9ZUzpOxv8S0ZS7Yr2B8FgNd3hCWoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywaQVFyh6SakihIanqdCtZsaLv6Wcn6BujmNLIPT+NxwLypXV8
	FS/VvVqLHXPhvmWv80v3f5rYRbjUdFLj6L1AUEKANb0JuIL7vm/jLilAtTh1qw==
X-Google-Smtp-Source: AGHT+IHt+jH7u3V1jXMVqc6k9u27o2SZdrpoNrqmhaztQX/nQKUnlOwFEiLXZUwnRwAnscRbBY3jww==
X-Received: by 2002:a05:6a00:b41:b0:718:dd53:70db with SMTP id d2e1a72fcca58-7199cd7ae75mr905408b3a.11.1726784105167;
        Thu, 19 Sep 2024 15:15:05 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:f9c5:155b:ca02:2b70? ([2a00:79e0:2e14:7:f9c5:155b:ca02:2b70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b127sm8694290b3a.125.2024.09.19.15.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 15:15:04 -0700 (PDT)
Message-ID: <724c1598-d41b-4795-b313-4fb73c6a24e0@google.com>
Date: Thu, 19 Sep 2024 15:15:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/2] usb: typec: tcpm: Add support for parsing time dt
 properties
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
 badhri@google.com, kyletso@google.com, rdbabiera@google.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240919075120.328469-1-amitsd@google.com>
 <20240919075120.328469-3-amitsd@google.com>
 <Zuwn1Fn1DrLGvPK9@kuha.fi.intel.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <Zuwn1Fn1DrLGvPK9@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heikki,

On 9/19/24 6:32 AM, Heikki Krogerus wrote:
> On Thu, Sep 19, 2024 at 12:51:14AM -0700, Amit Sunil Dhamne wrote:
>> Add support for DT time properties to allow users to define platform
>> specific timing deadlines of certain timers rather than using hardcoded
>> ones. For values that have not been explicitly defined in DT using this
>> property, default values will be set therefore, making this change
>> backward compatible.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++++++++++++++-------
>>   1 file changed, 65 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index 4b02d6474259..e6c243bc44f7 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -310,6 +310,17 @@ struct pd_data {
>>   	unsigned int operating_snk_mw;
>>   };
>>   
>> +/*
>> + * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
>> + * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
>> + * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
>> + */
>> +struct pd_timings {
>> +	u32 sink_wait_cap_time;
>> +	u32 ps_src_off_time;
>> +	u32 cc_debounce_time;
>> +};
>> +
>>   struct tcpm_port {
>>   	struct device *dev;
>>   
>> @@ -552,6 +563,9 @@ struct tcpm_port {
>>   	 */
>>   	unsigned int message_id_prime;
>>   	unsigned int rx_msgid_prime;
>> +
>> +	/* Timer deadline values configured at runtime */
>> +	struct pd_timings timings;
>>   #ifdef CONFIG_DEBUG_FS
>>   	struct dentry *dentry;
>>   	struct mutex logbuffer_lock;	/* log buffer access lock */
>> @@ -4639,15 +4653,15 @@ static void run_state_machine(struct tcpm_port *port)
>>   	case SRC_ATTACH_WAIT:
>>   		if (tcpm_port_is_debug(port))
>>   			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
>> -				       PD_T_CC_DEBOUNCE);
>> +				       port->timings.cc_debounce_time);
>>   		else if (tcpm_port_is_audio(port))
>>   			tcpm_set_state(port, AUDIO_ACC_ATTACHED,
>> -				       PD_T_CC_DEBOUNCE);
>> +				       port->timings.cc_debounce_time);
>>   		else if (tcpm_port_is_source(port) && port->vbus_vsafe0v)
>>   			tcpm_set_state(port,
>>   				       tcpm_try_snk(port) ? SNK_TRY
>>   							  : SRC_ATTACHED,
>> -				       PD_T_CC_DEBOUNCE);
>> +				       port->timings.cc_debounce_time);
>>   		break;
>>   
>>   	case SNK_TRY:
>> @@ -4698,7 +4712,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		}
>>   		break;
>>   	case SRC_TRYWAIT_DEBOUNCE:
>> -		tcpm_set_state(port, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
>> +		tcpm_set_state(port, SRC_ATTACHED, port->timings.cc_debounce_time);
>>   		break;
>>   	case SRC_TRYWAIT_UNATTACHED:
>>   		tcpm_set_state(port, SNK_UNATTACHED, 0);
>> @@ -4901,7 +4915,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		    (port->cc1 != TYPEC_CC_OPEN &&
>>   		     port->cc2 == TYPEC_CC_OPEN))
>>   			tcpm_set_state(port, SNK_DEBOUNCED,
>> -				       PD_T_CC_DEBOUNCE);
>> +				       port->timings.cc_debounce_time);
>>   		else if (tcpm_port_is_disconnected(port))
>>   			tcpm_set_state(port, SNK_UNATTACHED,
>>   				       PD_T_PD_DEBOUNCE);
>> @@ -4941,7 +4955,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		break;
>>   	case SNK_TRYWAIT:
>>   		tcpm_set_cc(port, TYPEC_CC_RD);
>> -		tcpm_set_state(port, SNK_TRYWAIT_VBUS, PD_T_CC_DEBOUNCE);
>> +		tcpm_set_state(port, SNK_TRYWAIT_VBUS, port->timings.cc_debounce_time);
>>   		break;
>>   	case SNK_TRYWAIT_VBUS:
>>   		/*
>> @@ -5014,7 +5028,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		break;
>>   	case SNK_DISCOVERY_DEBOUNCE:
>>   		tcpm_set_state(port, SNK_DISCOVERY_DEBOUNCE_DONE,
>> -			       PD_T_CC_DEBOUNCE);
>> +			       port->timings.cc_debounce_time);
>>   		break;
>>   	case SNK_DISCOVERY_DEBOUNCE_DONE:
>>   		if (!tcpm_port_is_disconnected(port) &&
>> @@ -5041,10 +5055,10 @@ static void run_state_machine(struct tcpm_port *port)
>>   		if (port->vbus_never_low) {
>>   			port->vbus_never_low = false;
>>   			tcpm_set_state(port, SNK_SOFT_RESET,
>> -				       PD_T_SINK_WAIT_CAP);
>> +				       port->timings.sink_wait_cap_time);
>>   		} else {
>>   			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
>> -				       PD_T_SINK_WAIT_CAP);
>> +				       port->timings.sink_wait_cap_time);
>>   		}
>>   		break;
>>   	case SNK_WAIT_CAPABILITIES_TIMEOUT:
>> @@ -5066,7 +5080,8 @@ static void run_state_machine(struct tcpm_port *port)
>>   		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
>>   			tcpm_set_state_cond(port, hard_reset_state(port), 0);
>>   		else
>> -			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
>> +			tcpm_set_state(port, hard_reset_state(port),
>> +				       port->timings.sink_wait_cap_time);
>>   		break;
>>   	case SNK_NEGOTIATE_CAPABILITIES:
>>   		port->pd_capable = true;
>> @@ -5203,7 +5218,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   			tcpm_set_state(port, ACC_UNATTACHED, 0);
>>   		break;
>>   	case AUDIO_ACC_DEBOUNCE:
>> -		tcpm_set_state(port, ACC_UNATTACHED, PD_T_CC_DEBOUNCE);
>> +		tcpm_set_state(port, ACC_UNATTACHED, port->timings.cc_debounce_time);
>>   		break;
>>   
>>   	/* Hard_Reset states */
>> @@ -5420,7 +5435,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		tcpm_set_state(port, ERROR_RECOVERY, 0);
>>   		break;
>>   	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
>> -		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
>> +		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
>>   		break;
>>   	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
>>   		if (port->vbus_source)
>> @@ -5475,7 +5490,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		tcpm_set_cc(port, TYPEC_CC_RD);
>>   		/* allow CC debounce */
>>   		tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED,
>> -			       PD_T_CC_DEBOUNCE);
>> +			       port->timings.cc_debounce_time);
>>   		break;
>>   	case PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED:
>>   		/*
>> @@ -5510,7 +5525,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   						       port->pps_data.active, 0);
>>   		tcpm_set_charge(port, false);
>>   		tcpm_set_state(port, hard_reset_state(port),
>> -			       PD_T_PS_SOURCE_OFF);
>> +			       port->timings.ps_src_off_time);
>>   		break;
>>   	case PR_SWAP_SNK_SRC_SOURCE_ON:
>>   		tcpm_enable_auto_vbus_discharge(port, true);
>> @@ -5666,7 +5681,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   	case PORT_RESET_WAIT_OFF:
>>   		tcpm_set_state(port,
>>   			       tcpm_default_state(port),
>> -			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
>> +			       port->vbus_present ? port->timings.ps_src_off_time : 0);
>>   		break;
>>   
>>   	/* AMS intermediate state */
>> @@ -6157,7 +6172,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
>>   	case SRC_ATTACH_WAIT:
>>   		if (tcpm_port_is_source(port))
>>   			tcpm_set_state(port, tcpm_try_snk(port) ? SNK_TRY : SRC_ATTACHED,
>> -				       PD_T_CC_DEBOUNCE);
>> +				       port->timings.cc_debounce_time);
>>   		break;
>>   	case SRC_STARTUP:
>>   	case SRC_SEND_CAPABILITIES:
>> @@ -7053,6 +7068,35 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
>>   	return ret;
>>   }
>>   
>> +static int tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fwnode)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (!fwnode)
>> +		return -EINVAL;
>> +
>> +	ret = fwnode_property_read_u32(fwnode, "sink-wait-cap-time-ms", &val);
>> +	if (!ret)
>> +		port->timings.sink_wait_cap_time = val;
>> +	else
>> +		port->timings.sink_wait_cap_time = PD_T_SINK_WAIT_CAP;
>> +
>> +	ret = fwnode_property_read_u32(fwnode, "ps-source-off-time-ms", &val);
>> +	if (!ret)
>> +		port->timings.ps_src_off_time = val;
>> +	else
>> +		port->timings.ps_src_off_time = PD_T_PS_SOURCE_OFF;
>> +
>> +	ret = fwnode_property_read_u32(fwnode, "cc-debounce-time-ms", &val);
>> +	if (!ret)
>> +		port->timings.cc_debounce_time = val;
>> +	else
>> +		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
>> +
>> +	return 0;
>> +}
>> +
>>   static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
>>   {
>>   	struct fwnode_handle *capabilities, *child, *caps = NULL;
>> @@ -7608,9 +7652,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>>   	init_completion(&port->pps_complete);
>>   	tcpm_debugfs_init(port);
>>   
>> +	err = tcpm_fw_get_timings(port, tcpc->fwnode);
>> +	if (err < 0)
>> +		goto out_destroy_wq;
> This is somehow wrong. You are using default values in case of
> failure, so this should not be a reason to fail port registration
> under any circumstance. That function should just return void.
>
> I would also just call it after tcpm_fw_get_caps() (or maybe even from
> tcpm_fw_get_caps()), because tcpm_fw_get_caps() checks fwnode in any
> case.

Thanks for the review! I will update in the next revision with this 
change. Will send the next revision once I get review
from DT maintainers for DT patch.


Regards,

Amit

>>   	err = tcpm_fw_get_caps(port, tcpc->fwnode);
>>   	if (err < 0)
>>   		goto out_destroy_wq;
>> +
>>   	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>>   	if (err < 0)
>>   		goto out_destroy_wq;
> thanks,
>

