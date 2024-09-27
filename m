Return-Path: <linux-kernel+bounces-341838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4579886EB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AF81F22201
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE88175B;
	Fri, 27 Sep 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXNutOhw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B024B28
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446800; cv=none; b=XyMk6INtbav969ASiasTtxBfUW7I/F/FLgKnbJdoqEwktZOsusAtSbEhxjjXuEJvKan9bkTp9DB+B74y7wC5Fmy9tHTpS4b12I5V2zj/9aLfTferPFq3ZF63lzCGkt2a56W80F6yc+xkUKgShhImSFOk4LkcaLcsf3Mwdg4/hWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446800; c=relaxed/simple;
	bh=TAumnclaZPJ3JsP6Z6FrwJ5J4BWAABpTn6LrE92M8b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSqTrTAHYAO6T7lE+nKPPChMb16JfdQTt6ar6M86cAVgCzkBwEeFlyOek/3nIDGvKTZ7AT5noW0tMcs6sbC5EtTwgqTU/0mT2PeKlj3D87miZwJ44VK6Ukg9/3DZ1ftHGwtVGtHm7YBWlCCj4oQ72BdWkeCY/9QFD7SQygKUL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXNutOhw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsHStmWEpieZFdjzVIt+lNRUQ+HoOUuzdOx9CgVHRjs=;
	b=XXNutOhwdihTJkCaU/T2Ckar7PcXsPfAvFvPP6zg4fWHd7gDBOLmk/sZ0GLm7W8x18Hcuu
	X6+2BGseqXHMXUAoR1lIEsgVZiBDu1MPi1TNCm0zXNrkedurPSLhmt8oc07Inc5SyS/WBm
	MUC6o55YKAJ/DP25sFFpLvcjuUtzPtA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-g1D-88gTM5yx9kYsHr6n3Q-1; Fri, 27 Sep 2024 10:19:55 -0400
X-MC-Unique: g1D-88gTM5yx9kYsHr6n3Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c86d0ff3a8so1388071a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446794; x=1728051594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsHStmWEpieZFdjzVIt+lNRUQ+HoOUuzdOx9CgVHRjs=;
        b=hqsKHI1u96eCQQ+GH87E1sgn5A/GfEP3IZg0d4/t65CDFdKbD9xyAlEPIogAGIivN7
         vvL46mzsaI+0y0QYIzR6MrFuw8ZZbmNvUMO+S8LQ9eOs3tazAH7N48mmoJbIUWHCx1XN
         E+UEzTB1Q30Sz8zSk4QgXIMA2/zDO9pVUofVP6i3yQ6lBL2uYbWMlpgbBGd4RpxKQ3ow
         sMD1+F0D/nefylotuhEsSVwHc+6E4y8unoDuGgf7tq+Lez1y2hIn3iWRcysh0fOx5C8/
         gpN4LfMcvJiH6RgxXZW1tgpFZ0TGbbkpkwHPF4yNDsXsmyJXfyyv6g1HElCocCTaghNB
         JrHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgA5g89aARFbl2G0nxo8hrvwXaZrrA0/18GYQEksOXgpqPAS8YkGODl2Y9Z5+VH4z0G2b09UEz/2sXEpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCyhc746TQZTJDoDq16IAuYu4TH/X0aT5Nl7azZ2WYoiy7U/S
	2wOtG7tJkuA0m5gEzhc20GCHZN9m1PRjJEjk4lZCz9Iz6WCqV6MjhVsB8/Fe3oDQPxSOJ34xnf3
	yRhByXlXNZd9SA8qriR045fxVwd/gBSAmGbPfXtiXGneg8ogIkwleX4dtoXei8w==
X-Received: by 2002:a05:6402:e9e:b0:5c0:c10c:7c1d with SMTP id 4fb4d7f45d1cf-5c88260359fmr2685257a12.23.1727446793877;
        Fri, 27 Sep 2024 07:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl8zETG/nN7VCsItEgk23DbBOEAqEjpciP00WcQag6SkFOy6fRM48NrEV7cAT7D3Tod8+lxA==
X-Received: by 2002:a05:6402:e9e:b0:5c0:c10c:7c1d with SMTP id 4fb4d7f45d1cf-5c88260359fmr2685231a12.23.1727446793344;
        Fri, 27 Sep 2024 07:19:53 -0700 (PDT)
Received: from [192.168.1.35] (85-147-213-205.cable.dynamic.v4.ziggo.nl. [85.147.213.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248ac03sm1193820a12.70.2024.09.27.07.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 07:19:52 -0700 (PDT)
Message-ID: <9feac709-fbab-424a-bc5c-dedbcec40dea@redhat.com>
Date: Fri, 27 Sep 2024 16:19:50 +0200
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
 linux-acpi@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240903014317.38858-1-tamim@fusetak.com>
 <c73420b7-c186-4b5d-a074-961b35ed829c@leemhuis.info>
 <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
 <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
 <c1276139-d26f-457a-8a73-7f17538dbd28@redhat.com>
 <7ce7f7cc-870f-4f7f-98c6-95eb784008ff@leemhuis.info>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7ce7f7cc-870f-4f7f-98c6-95eb784008ff@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 26-Sep-24 12:18 PM, Thorsten Leemhuis wrote:
> On 25.09.24 16:31, Hans de Goede wrote:
>>
>> On 25-Sep-24 1:56 PM, Thorsten Leemhuis wrote:
>>> [CCing Hans]
>> Can you next time maybe also add a bit of text explaining why ?
> 
> Sorry, yes, you are right, will keep that in mind.
> 
>>> On 05.09.24 12:45, Thorsten Leemhuis wrote:
>>>> On 05.09.24 11:51, Thorsten Leemhuis wrote:
>>>>> On 03.09.24 03:43, Tamim Khan wrote:
>>>>>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
>>>>>> that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
>>>>>> This override prevents the internal keyboard from working. This patch fixes
>>>>>> this problem by adding this laptop to the table that prevents the kernel from
>>>>>> overriding the IRQ.
>>>>>>
>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
>>>>> Thx for that. FWIW, I by chance noticed another such report about the
>>>>> E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>>>>
>>>> TWIMC, shortly after sending this mail I noticed there is another request
>>>> for a quirk that was send to the list, bug afaics fall through the
>>>> cracks. See here:
>>>> https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>>>>
>>>> It afaics add a X1704VAP:
>> [...]
>>
>> Ok, I wonder did you Cc me so that I can write / submit patches upstream
>> for these ones?
> 
> Not really. Of course it would be nice if you or someone else took care
> of that one and...
> 
>> It seems that there are 3 missing models:
>> - E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>> - X1704VAP https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
>> - B2502CV: https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12
>>
>> Which someone needs to submit upstream, right ?
> 
> ...these as well -- and ideally would even be willing to act as go-to
> person from now on in case more of these quirk entries are needed, which
> I guess will be the case. But given the backstory (see below) I don't
> think you or anyone else is obliged to do this, even if the current
> situation is parlty caused by regressions and recent fixes for them.

I have already done a bunch of these patches. So I would be happy to
submit more of these, but someone needs to bring them to my attention first.

Also maybe Paul Menzel (added to the Cc) and Tamim Khan can help with
adding more quirks, when reports come in ?

Either way I have submitted a set of patches to add quirks for the 3 new
known broken models now.


>>> """
>>>> adding this section to file drivers/acpi/resource.c helped; if someone could do an official patch it would be great :-|
>>>>
>>>>         {
>>>>                 /* Asus ExpertBook B2502CVA */
>>>>                 .matches = {
>>>>                         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
>>>>                 },
>>> """
>>>
>>> This is not a regression, but given how frequently I notice these issues
>>> please as a bystander allow me to ask: is there maybe some way to
>>> improve the situation so that we do not have to add all these and likely
>>> many other Asus Laptops to that file?
>>
>> This has been discussed before and unfortunately there is no other way
>> to deal with this. There has been some discussion about reading back
>> the polarity and edge/level from the hardware for the keyboard IRQ
>> to get the values which the BIOS has setup. But it is uncertain if this
>> will work and no one is working on this.
> 
> A refresher like this was more what I was fishing for. Thx for this.
> 
> Now that you wrote it, it makes me think: given the amount of quirk
> entries we apparently need I wonder if it might be wise to revisit this
> at some point in the not to distant future, as I suspect otherwise
> sooner or later Linus might yell at all of us with something along the
> lines of "the kernel is clearly broken, why did we work around this with
> lots of quirk entries instead of fixing this for real". Something like
> that happened in a somewhat (but not exactly) similar situation a year
> ago, and it iirc was not the first time.

I hear you, but I don't really know anyone who has both the expertise
as well as the bandwidth to deal with this.

> Writing this lead to another thought: does anyone have contacts to Asus
> and could just ask if there is some generic way to detect which of their
> Laptops need a quirk?

I don't have any contacts at Asus.

Regards,

Hans



