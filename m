Return-Path: <linux-kernel+bounces-180867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F38C741F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B9A1F23057
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2E314386E;
	Thu, 16 May 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eus0gvMZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6F14293
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853026; cv=none; b=sMHssvOquX7LgqR7NZoJX2OAAypNBYhm3+1usBy9sW/SbUbW2yubVfASxLwpPVPFy5SEOYFWEkUhm5aWy+V0ocR+zihrxzMVBIDvkArX+0P22iufHYE2KCculNagscHViqr5ptzk3pPpHVne3EF7QxsXR6epUpBjvOUn7IgTAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853026; c=relaxed/simple;
	bh=+c9zEl/36759rGYjhFBs08AUR/oGKkHXxRFbeAzSvp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HutB8dsIWKRTGNA8ieo2elK1N23SMZoC4/jV/xhhTIZOz3iYqc01w75Ay8/+uLBfr4wVLFBJvC4f7O+JFOAHyHYhZO7wJbr99rnvw573DaVJI/OhF+Uu+1yYqJfI5pRCvIqqgajno+pEkacT3ZPWxKXvPtmfB12A/1KTozwi1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eus0gvMZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715853023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl6N2tbUpUF77oaAK8NDMvwl17/nKyPOpGl6BqbhhJs=;
	b=eus0gvMZR397ay9jIHBY++jwR7je7e0aeAoQNCDf2jmnPdzxO62zueI30dTaZeC2ASIWmH
	07oUAywnbgfFgiqBNPaknfs6C0LyCJO+6PT1ue+q08RlECKEtc+MOxtkuUrRXWECSqEgG8
	Qrbo/N2UMamP2RnFVVeCCc4dhmmoIDI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-vPOT0onfP92GMxpMmIGz9A-1; Thu, 16 May 2024 05:50:16 -0400
X-MC-Unique: vPOT0onfP92GMxpMmIGz9A-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-47f0c3b04bdso1322858137.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715853016; x=1716457816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rl6N2tbUpUF77oaAK8NDMvwl17/nKyPOpGl6BqbhhJs=;
        b=WH3cojC1QXNIRP8LqFETk4VJ/cPVUjdDeWbCAGgdhI3Tng2dWjpU5IfK/K3r4Gz5S+
         nxkBHHuiIXtr9lC2aGCDVBg9Rt9P7+4vnCt80XlypR9gHcrVN6IHOAzkuzd2UD710z3k
         ihHaTEr4ihrkYxVqLojcRbQYgBeQe1QrQ9g4RTKmr7OwBLcLsENkmIekI8fAIRe22s/i
         /beqSN6G6x0KD19vSLBNzm1Fen4QCFse55Iluo1WiwOwitevmR01vBSSiBS4olOD857p
         ntBsGM0Mh8PmrLJhZKq04VWyOUYb6PYl54ps3hsWggQqhdpe9eM0vZ0CyFvOW9zJbQgZ
         IjTA==
X-Forwarded-Encrypted: i=1; AJvYcCVeUOn/1u+POCP38KjHPeUnH54BChqv8fg0x/JRt14AG43tLPYxaicwUGryf4KPNhAZ1L5buSO+2+/5U95RbmCazEw9cD7wRcR1wbbJ
X-Gm-Message-State: AOJu0Yx8TiyOO41Yln2eRdglGfVqzwsk7VOcpZTJWpZycmGRkd9knTsQ
	IY3heHVFEKTs60hoUmz/FSRNbxjDyn6Ej/l5rYbVFb37DAXk55ixYq/khbaBAKDsPlr3WaXhtLS
	5vJxUzpAtt8Ue5j4iGNJE9SHUfBB1iS/ayBtidFU73/LJsZ+VMViDR/G78eaEysBF+VYO6Q==
X-Received: by 2002:a05:6102:3ec5:b0:47c:3033:5faa with SMTP id ada2fe7eead31-48077e11330mr16512965137.20.1715853016174;
        Thu, 16 May 2024 02:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrupqXLSlZxhBgu7VznMtN7QkxOtPnyduO1KffkCGw4xFFHzWHqltbKZmcWq+K/8y2wqFi7g==
X-Received: by 2002:a05:6102:3ec5:b0:47c:3033:5faa with SMTP id ada2fe7eead31-48077e11330mr16512951137.20.1715853015787;
        Thu, 16 May 2024 02:50:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb3b783sm2089833137.9.2024.05.16.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 02:50:15 -0700 (PDT)
Message-ID: <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
Date: Thu, 16 May 2024 11:50:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
 <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
 <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
> On Thu, May 16, 2024 at 10:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
>>> Hi Everyone,
>>>
>>> This is an update of
>>>
>>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
>>>
>>> which was a follow up for the discussion in:
>>>
>>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
>>>
>>> Patch [1/2] has been updated to avoid possible issues related to
>>> systems with defective platform firmware and patch [2/2] is a resend
>>> with a couple of tags added.
>>
>> Thanks, the series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> for the series.
>>
>> I assume you are going to send this in as a fix for 6.10 ?
> 
> Yes, I am.
> 
>> In that case feel free to merge both patches through the
>> linux-pm tree.
> 
> Thank you!

Hmm, I just realized that this:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=c663b26972eae7d2a614f584c92a266fe9a2d44c

Is part of the main pdx86 pull-request for 6.10 which I'm going to
send to Linus in the next 10 minutes or so. So that is going to
conflict with your 2/2.

Options:

a) You only send 1/2 upstream as a fix and I'll then send a rebased
2/2 upstream as part of the first pdx86 pull-request.

b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-request
I'm about to send to Linus) and rebase on top of that before sending
a pull-request for both to Linus.

Either way works for me.

Regards,

Hans



