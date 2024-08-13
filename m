Return-Path: <linux-kernel+bounces-284645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9F795037F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE5D1F241D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B40198A3B;
	Tue, 13 Aug 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TxU6ZBXs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423ED190470
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548130; cv=none; b=d2Kb1CuLOlee6mHxLu0qJ//AqMngC5to/EtGjpGcDIi2JybmKSHrAqUFJAvXSSSkEU9i8GlJaoVxmzlHszlT3pQBLz+1EOuepP1xy2nX12t8gZDtFph4S0uGRi5xWd98Jk9kC1h8aiacRpPegyWw/49/lujp6KKKd1/po1V6eSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548130; c=relaxed/simple;
	bh=Jcl8XWWmIYk2UQ7A35sueBuINZM/6ftJ7/UAHEP2+wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XYwNPUagXiC+b3+zOoSbWWsQOmCUS1nm+CkZTCF7nFFE6ShTZCEQoc2BqrLqeDB4Pdzk72vS/aheJ+z5C9cctncGtiAN4H9lAsGvvTNO4v49+uwCIZJuW3/DBLxy58h5eFVdwHmeSZ+j9IVa16h/4vOHq3nYLiloNC1G6ogkubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TxU6ZBXs; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DBLswl069776;
	Tue, 13 Aug 2024 06:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723548114;
	bh=nQ2rCZGHfeczLQQvaJbV7V/jhhTH3Xp6v0+tU05YxwA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TxU6ZBXscCojoHjZHmE2F7dpxG3YUEFxKNwPZdB70LCO0D05TQjUAWR7BWgOy3ESV
	 Jkjx9oegiAiPhv0xah6sJLGZO6+WT4EsGYo6jEHCjycCtdiOBHoaDVck5dBVggVTEF
	 biNXf3gyy0RuS1m9rh/cSzqGVa/oG0pqpzC3aI1c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DBLsVA013723
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 06:21:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 06:21:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 06:21:53 -0500
Received: from [172.24.227.249] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DBLoT0116555;
	Tue, 13 Aug 2024 06:21:51 -0500
Message-ID: <5f6093e5-cf67-4516-b5b8-929987b05a2e@ti.com>
Date: Tue, 13 Aug 2024 16:51:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] firmware: ti_sci: Introduce Power Management Ops
To: Dhruva Gole <d-gole@ti.com>, Kevin Hilman <khilman@baylibre.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Georgi Vlaev
	<g-vlaev@ti.com>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-4-msp@baylibre.com>
 <20240812054717.6lzkt3lxclzec3zy@lcpd911> <7hcymdphky.fsf@baylibre.com>
 <20240813034935.wqehblov3e5gur3r@lcpd911>
Content-Language: en-US
From: a0230503 <a-kaur@ti.com>
In-Reply-To: <20240813034935.wqehblov3e5gur3r@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13/08/24 09:19, Dhruva Gole wrote:
> On Aug 12, 2024 at 14:16:45 -0700, Kevin Hilman wrote:
> [...]
>>>> +/**
>>>> + * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
>>>> + *
>>>> + * @hdr:		Generic header.
>>>> + * @wake_source:	The wake up source that woke soc from LPM.
>>>> + * @wake_timestamp:	Timestamp at which soc woke.
>>>> + *
>>>> + * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
>>>> + * used to query the wake up source from low power mode.
>>>> + */
>>>> +struct ti_sci_msg_resp_lpm_wake_reason {
>>>> +	struct ti_sci_msg_hdr hdr;
>>>> +	u32 wake_source;
>>>> +	u64 wake_timestamp;
>>>> +} __packed;
>>>> +
>>>
>>> It looks like we forgot to update the parameters in this API.
>>> See [1]:
>>>
>>> struct tisci_msg_lpm_wake_reason_req
>>>
>>> We're missing here the wake_pin, mode and 2 rsvd fields as well.
>>>
>>> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-lpm-wake-reason
>>>
>>
>> The docs mention how to interpret the pin, but not the mode.  This
>> driver should translate this mode number to some human-readable state
>> for better debug messages.
>>
>> Kevin
> 
> Agreed, we would all benefit from a logic that prints the human-readable
> state. The way to interpret the mode would be just as:
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes
> 
> So for eg. 0x0 = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP
> 

Missing the call to ti_sci_msg_cmd_lpm_wake_reason in resume path.

Regards,
Akashdeep Kaur

