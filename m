Return-Path: <linux-kernel+bounces-559204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B0A5F0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B803B9065
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D27265CAB;
	Thu, 13 Mar 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="dCzPTFSC"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551226560F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861723; cv=none; b=tRdOtmh+fCSIGsxQT0WcRKlMEMGm29XjYTyClL1U5kieeRYfrCo/hrzLNjok8WokJ5NbLrf92Ai2Dx0/t0Esc7JVEWPACO7LDmh1MbrFkHaAX842hqvaLtzF6tSv4HHKgko3Wm5zasQN4AXlzyl6r+m/GZL1be6PU1bzXek9IaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861723; c=relaxed/simple;
	bh=wVpYie9sH4ylFdnG9WhvhVA8xQP3Lc5g8a31ToTFzVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2gVA1E8+Mbo4G7ph52SU3CdINBCH3OF/TUFD58UuyQN0m3RO2LTnrrWvwlf7VcnulP5J2ttq4ehZH7mrHiJK2SxjnWvUUMOyK3daFY9AV0JYl4iNZGq+9RXiKDmftb8kAaScfPxClA2k4sGJiBKexrp20wz1hZ6nr+xjAabpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=dCzPTFSC; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250313102836e40237bcb1b611d088
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Mar 2025 11:28:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=x7pn0SmYeby5oYK8B0/TUrJCsIHBByLGAVMLNf5D/aY=;
 b=dCzPTFSCYSJCqomSq9SnYeYbUAQ8ImFBJx63WDgsz1MGnXnICsT14bT/dzw0PnGnKhPlB0
 ITPQsyGEZbjKclIzrnVdgF4eVm2wTAdvMJvPfpgS8T6xu0r6FdB9CWZFu2mZ6YtQ+/1kamFG
 fz97Mb/AX4z6kRtJ2sJHwIg2IncjUviPrzXkQ6UInOrE1IPPV/DTz8fk2C2ZkfM4oz2vz9TZ
 0grTOaUqkm9FSzdW9OKWt6RyS0oWGK/nFcngpHkiQnEvOW+Qcm5Ai164UIjsFozww3HrgQfk
 49Bt/Nr+PEuWGDIvC1ZSOJKudP/KiHyRwvr6Q3cx/E0Gvn0/nmMFM66A==;
Message-ID: <63e69331-bb8f-45f6-adb8-872f594fa02e@siemens.com>
Date: Thu, 13 Mar 2025 10:28:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP
 device list
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 jan.kiszka@siemens.com, benedikt.niedermayr@siemens.com
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
 <20250312-ivo-intel_oc_wdt-v2-2-52d09738cd0b@siemens.com>
 <CAJZ5v0iBcxGcqp88kHN64WddvmC-y6F1XaFeSNHFYuQnayg7dQ@mail.gmail.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <CAJZ5v0iBcxGcqp88kHN64WddvmC-y6F1XaFeSNHFYuQnayg7dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi Rafael,

On 3/12/25 7:31 PM, Rafael J. Wysocki wrote:
> On Wed, Mar 12, 2025 at 4:46 PM Diogo Ivo <diogo.ivo@siemens.com> wrote:
>>
>> With the kernel having an ACPI driver for these watchdog devices add
>> their IDs to the known non-PNP device list. Note that this commit is
>> not a complete list of all the possible watchdog IDs.
>>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> ---
>>   drivers/acpi/acpi_pnp.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
>> index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
>> --- a/drivers/acpi/acpi_pnp.c
>> +++ b/drivers/acpi/acpi_pnp.c
>> @@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
>>    * device represented by it.
>>    */
>>   static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
>> +       {"INT3F0D"},
>>          {"INTC1080"},
>>          {"INTC1081"},
>> +       {"INTC1099"},
>>          {""},
>>   };
>>
>>
>> --
> 
> Is there a particular reason for this patch?

Yes, since the ACPI tables for these watchdogs have both a PNP0C02 CID and
and then an HID (such as INT3F0D or INTC1099) without this patch the driver
in patch 01 will not bind to the device because PNP will bind to it first.
My understanding is that this table was added to solve exactly this problem
so I added these HIDs here, but if this is wrong and I misunderstood
please let me know.

Best regards,
Diogo

