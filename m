Return-Path: <linux-kernel+bounces-339249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E319861AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C4928D07F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE55476B;
	Wed, 25 Sep 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuFM3DHq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D384DA04
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274727; cv=none; b=ka+Tni90K0CdgbFexTg4wgSN1ZLKhBqG6I0OyNZ9K7yJZSVmnn+7fyx8JCgsRLMGnMuUZ6nzRvGoaoVOlpAcaEwIN/la+eHcIIHZblvr6DhSFHfoRvwIwQDwGtBc9wULueiL+T6vv8KiFZflJ9l6gsyT7tmDmMmymxmqUKM91No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274727; c=relaxed/simple;
	bh=Ycyv6MKsqO1LyX/e8/nFuuFSKfnIOklX8bPR3j/NLgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkJbp1GvBQHNxJGmTseQ0Q4YzWcN1hhMGGVzub97+GTeshfTSbZ1pD+0XAa+PRKiDP8/m/SnmyDjigU7yvAKyoaL8LrQw/SgHHJ6IGhXq0FhzHUHmM4ltr29EkjTCFZXgcqPtK4/DHToxVEzBZWAoapJMnx3MSp+0sCOJvs2hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuFM3DHq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727274725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6AByS+RmkHu+3AQ+C2qvWPCQExf7Js+Ff7rswzRzm5g=;
	b=QuFM3DHqchytVnRaIcYYQDv9M83VwJ+sj/8+HEXgIBeiFEL1VPN5a83SEdwOC1syEWz1rB
	/8ETRvUKvfxrGUenyl7mUC/M6ZKzTyW9J0hY0/FEXqvfpjk3BJq1IHDSCzkWKZEA4etbDt
	E83MVMa5nWSDKBicFpgTVmUTx8PUq54=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-RSP6BxeINL23RiZdTJvX1Q-1; Wed, 25 Sep 2024 10:32:03 -0400
X-MC-Unique: RSP6BxeINL23RiZdTJvX1Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8ff95023b6so513500866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274723; x=1727879523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AByS+RmkHu+3AQ+C2qvWPCQExf7Js+Ff7rswzRzm5g=;
        b=VYxFzBiWAHcL88WL7rMgsIZsI2x9bXWaB9bKrXzAeHeLYhkN8AJsLKrchX4TveWdi6
         KmOF6VI0YJ2TlsHiIqKzq/tU9bJ95dXfquMvjYsaEWXqfCmBKOcFDby9FwkjirwfR5Nr
         cvwPRooC9fFd+F9nthVYAYgYajyIASYbIettxlbmOzs3qCDMguy82vO+utyhDzmhGHn5
         O5CZIIOpD9R0qt0yOe0QVNhqZZL6rEEHRyJXDLcnLtfuJUfS6sJAVg642cAuUbysjYUZ
         9eDX7qtIbpUQbtOFufG7mcRLlTnUZoSp7eRE/Khbu7IPbrIcNgU9swjb5tFKEpteL1AM
         7m3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHPVnWyO4YMlY3dZVmtFrmlomaz6R0q2G7bBn3yABN/56Uvmcw+MBcuFjkMTJ0E46z7loKyY8sMV4Xwik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23aQd4lBYVUe3nCkX7hCmzZ5VVV5a/qYatIpmRvM5dMaaOty6
	omEWo5wXRFDOLay/S8o6nKrgcMQ9onrAxQ5hteuy5MKr8AYhgI2jktnUARYWQuW1pjnEDjy2up2
	F1A0d3M8lEtHfx2Yt3e/Fi6pKwJIQBAo589IiMCkQgVtpSqbIRWCNoy26DJapiw==
X-Received: by 2002:a17:906:c141:b0:a91:158a:d975 with SMTP id a640c23a62f3a-a93a06c6233mr238666166b.65.1727274722614;
        Wed, 25 Sep 2024 07:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtjGLCDZONrauQCQdrFv78hCCbIy6/kJpl799zib5nAxT4VZOKFmRcahA3wL4lJEW07sooqQ==
X-Received: by 2002:a17:906:c141:b0:a91:158a:d975 with SMTP id a640c23a62f3a-a93a06c6233mr238663866b.65.1727274722238;
        Wed, 25 Sep 2024 07:32:02 -0700 (PDT)
Received: from [192.168.39.203] ([109.38.139.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f50165sm212150666b.57.2024.09.25.07.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 07:32:01 -0700 (PDT)
Message-ID: <c1276139-d26f-457a-8a73-7f17538dbd28@redhat.com>
Date: Wed, 25 Sep 2024 16:31:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go
 E1404GAB
To: Thorsten Leemhuis <linux@leemhuis.info>, Tamim Khan <tamim@fusetak.com>,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240903014317.38858-1-tamim@fusetak.com>
 <c73420b7-c186-4b5d-a074-961b35ed829c@leemhuis.info>
 <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
 <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 25-Sep-24 1:56 PM, Thorsten Leemhuis wrote:
> [CCing Hans]

Can you next time maybe also add a bit of text explaining why ?

Often the why is trivial, but in this case I wonder what input you want
from me, see below.

> On 05.09.24 12:45, Thorsten Leemhuis wrote:
>> On 05.09.24 11:51, Thorsten Leemhuis wrote:
>>> On 03.09.24 03:43, Tamim Khan wrote:
>>>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
>>>> that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
>>>> This override prevents the internal keyboard from working. This patch fixes
>>>> this problem by adding this laptop to the table that prevents the kernel from
>>>> overriding the IRQ.
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
>>>
>>> Thx for that. FWIW, I by chance noticed another such report about the
>>> E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>>
>> TWIMC, shortly after sending this mail I noticed there is another request
>> for a quirk that was send to the list, bug afaics fall through the
>> cracks. See here:
>> https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>>
>> It afaics add a X1704VAP:
>>
>> 	{
>> 		/* Asus Vivobook X1704V */
>> 		.matches = {
>> 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> 			DMI_MATCH(DMI_BOARD_NAME, "X1704VAP"),
>> 		},
>> 	},
> 
> FWIW, noticed another such report, this time about the B2502CVA:
> https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12

Ok, I wonder did you Cc me so that I can write / submit patches upstream
for these ones?

It seems that there are 3 missing models:
- E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
- X1704VAP https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
- B2502CV: https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12

Which someone needs to submit upstream, right ?

> """
>> adding this section to file drivers/acpi/resource.c helped; if someone could do an official patch it would be great :-|
>>
>>         {
>>                 /* Asus ExpertBook B2502CVA */
>>                 .matches = {
>>                         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
>>                 },
> """
> 
> This is not a regression, but given how frequently I notice these issues
> please as a bystander allow me to ask: is there maybe some way to
> improve the situation so that we do not have to add all these and likely
> many other Asus Laptops to that file?

This has been discussed before and unfortunately there is no other way
to deal with this. There has been some discussion about reading back
the polarity and edge/level from the hardware for the keyboard IRQ
to get the values which the BIOS has setup. But it is uncertain if this
will work and no one is working on this.

Regards,

Hans


