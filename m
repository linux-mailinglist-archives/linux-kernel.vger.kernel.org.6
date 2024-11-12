Return-Path: <linux-kernel+bounces-405513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE49C524B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35235282519
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6D20E026;
	Tue, 12 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OhC+T+Vc"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6D20DD47
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404651; cv=none; b=Bp1qST0d6cswH9nip2fne1BcCbJx1ZFwYk8mwzokVEOD16B3lhGcAZ6i9YBrv6UOZ8TJ4tc0nh9ty7OVPilxih0LDGsDOH30HmlwXQs8G3xm/hdE9xradyIiCuIkyg2wIQ9RwOgiOU0U/a/RXpWb3TfJ1QEQ8cFGzUfV4p9igYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404651; c=relaxed/simple;
	bh=eInOTRLGOUL3lDYemWw+/oyAtOm8FG1Pbx11r6+6D9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F+awxWbaf3PM5pfmJVgOjGLE76dZaguaqmnyfBYIgpDwLR6tvVTTJNAnOiqXuXTdgwg4ImIJDAtIeT7UKMUWr0L48vgO501WGnCWoUPalkPXZFiLBM0xbtI45iFbyaEcEOSwURyhqHZpGnHeaDzEXeCs5JOwF/F9TreeDvJxm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OhC+T+Vc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC82ftV031759;
	Tue, 12 Nov 2024 10:43:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	7Cfl6mwKTgaiiqEteeXeyTmeKooLQUTHnluak0d1CIg=; b=OhC+T+Vcu/72fiQ5
	MYlsLkqqvCCcEJnNHpbZhNCVoT4PCLKBSTVi9UE25xsoGAYBOuDsM5xOTdlupKbx
	6GO8xDfV4qrhW1CNtZk/bz3e40ZN7KKh6CQvPSdqDwvtB1/HNtUQg2SUifn9tauh
	KBDBx0ilYtuouqcmqMNpxuGF9NX+0zEcuDz3PMJ/AQpKpgDkzIwztEodauBUu0jZ
	n783w2JhWcieWTvQkse7LuAe/MvoNL6FlK3mI4WvYqdc7U8Er6VairG4h8CcdaUX
	UyvoLRsGcBVDmf54hz7UCts1sQHyoXeWuKg/4xIhHd5RHU8T2um7ECp8yOpxPIgu
	Q4peWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42sx1kkh1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:43:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2B9A54008F;
	Tue, 12 Nov 2024 10:42:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF5302912BF;
	Tue, 12 Nov 2024 10:40:50 +0100 (CET)
Received: from [10.48.87.175] (10.48.87.175) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 10:40:50 +0100
Message-ID: <1179b3a6-e430-4d9a-8f86-470e8cbe5738@foss.st.com>
Date: Tue, 12 Nov 2024 10:40:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firewall: remove misplaced semicolon from
 stm32_firewall_get_firewall
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        guanjing
	<guanjing@cmss.chinamobile.com>, <mcoquelin.stm32@gmail.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241109055049.269163-1-guanjing@cmss.chinamobile.com>
 <cfb1caed-9402-4148-831d-57c50bdf6a27@foss.st.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <cfb1caed-9402-4148-831d-57c50bdf6a27@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 11/12/24 10:25, Alexandre TORGUE wrote:
> Hi
> 
> On 11/9/24 06:50, guanjing wrote:
>> Remove misplaced colon in stm32_firewall_get_firewall()
>> which results in a syntax error when the code is compiled
>> without CONFIG_STM32_FIREWALL.
>>
>> Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
>> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
>> ---
>>   include/linux/bus/stm32_firewall_device.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bus/stm32_firewall_device.h 
>> b/include/linux/bus/stm32_firewall_device.h
>> index 18e0a2fc3816..5178b72bc920 100644
>> --- a/include/linux/bus/stm32_firewall_device.h
>> +++ b/include/linux/bus/stm32_firewall_device.h
>> @@ -115,7 +115,7 @@ void stm32_firewall_release_access_by_id(struct 
>> stm32_firewall *firewall, u32 su
>>   #else /* CONFIG_STM32_FIREWALL */
>>   int stm32_firewall_get_firewall(struct device_node *np, struct 
>> stm32_firewall *firewall,
>> -                unsigned int nb_firewall);
>> +                unsigned int nb_firewall)
>>   {
>>       return -ENODEV;
>>   }
> 
> Acked-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> Thanks
> Alex

Hi, please use get_maintainers.pl script next time so that
adequate people are put in To/CC.
Nevertheless, thanks for the patch!

Reviewed-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

