Return-Path: <linux-kernel+bounces-174405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E008C0E46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457E6B225FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC212EBFA;
	Thu,  9 May 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrGjPV6+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C03107B6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251192; cv=none; b=FkMWcV3yo+98jFW2kM7JtKV7TNF9MuGGyZjaN5i5KhDAmCMmlNbgiSEjtE0Ggq/VWQygcN6ATisG62wTY7hKj4rTikYg3aDEkakbEDC9WQ5wftsz8587sR3vBBvNcYH6UbGPtKGfyanQYBbzXK0bdBff7mjWu93CuQBW4j0pBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251192; c=relaxed/simple;
	bh=XwAe7hsJy7qg8dMMncNStWTJhklGzle31UBgcs6zbqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqP0UcfNoUduJVoj0jCnpFBiItOlrJWfCUO0UNjd1L8NoBpH3H9VQh7EJnB78mHEdknrTa2xgwbwG5hTjO6BTcJGUGOVTDaVnZECFvvjLn3yDy8gNSdgzrJwsMiwNsUUqoo3cBoenjg2aimRU7beIEQSIzUDNtQqaZsIE4bAXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrGjPV6+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715251190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmseUmPhFZwwAtIyCLb6QGTIVFuL3jOx0Fm3gQHch+g=;
	b=HrGjPV6+trPemKKgpDKU7XGX3v1NzIYYe2s+TIBKTChNZjhKB0Zkl0EIiDlPXW1A5mRE+R
	6QwDfVos5+IQg+BuKzZ9EfK6KjDSVUjKRvqBG4LztM3O3lW46PzMjVvj8O9hfOUcrBUOjZ
	uFNVCbQmP2k4MxkrWwIroe2FA7FbzbA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-u-Y21pgwNiOaYLih8Q3ROQ-1; Thu, 09 May 2024 06:39:43 -0400
X-MC-Unique: u-Y21pgwNiOaYLih8Q3ROQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a59e9ac4c74so38484466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251182; x=1715855982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmseUmPhFZwwAtIyCLb6QGTIVFuL3jOx0Fm3gQHch+g=;
        b=nEphpOgFWmGZctn8iX3fs0JkDfjWH9/dWmlr6wjhNvzsoKykEc9g3X99x/SfZtkgNF
         OQ+W8nB8O4z3zNcmrV7yWCjwq+vwq5eBvyGhV0cDmHaL54xTFTwIKqCRVFfr+H9m9ycS
         flA7pFywMvx96qm77kEbZ954VP+YdVLONvrQNs5lfMW2aJemXInA8GOEHsAJ0I2RW89K
         U56ZLaD39z8+YY6MVvTJXOj0rzVml2osgs8E8haojdPbn40UdR5NnrioHgBbPgQuQBwh
         yjk7Be/oa7sVErjN2H0MShUberMXbLY22CKLxjIs/Kx5y1nBoSWAt5v4F4Zjtw33BTUY
         1uyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX52FlfsDzSbcag+N2sdJmvGnNVLLmwcM4mDKykIr2QeHQhGUDuk+8OBlsifpkwP2O/vGQZXJJUaOexLvUsQUI1vq1ZRI5lgUaUI5s+
X-Gm-Message-State: AOJu0YziouOkMISzpPa8W3J1uRNtE1C3X0jiIlHSPRXn+s8USX5rwa0u
	EyeEbD6mTfzYtHmT9B4kZrDmpng0OZnUA3PHM/mpDzd+RNK3JUYG9CCzROHbFGGXEqBvjEOpj+J
	wbwMmP957r1f8iBNZhjzWsvv/AYHrYsZZtYld42m5ko1UUFW6J7DOxtiBXI98kQ==
X-Received: by 2002:a17:907:7286:b0:a59:bacc:b07f with SMTP id a640c23a62f3a-a59fb9d6452mr442079866b.52.1715251182276;
        Thu, 09 May 2024 03:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP9HeudRj+sW+HsFxhFyijpF8DR6PcEjVGvrG6HU+yPQToGKbszMb8r3CLhU3EOGpeZeUUpA==
X-Received: by 2002:a17:907:7286:b0:a59:bacc:b07f with SMTP id a640c23a62f3a-a59fb9d6452mr442077966b.52.1715251181801;
        Thu, 09 May 2024 03:39:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7da8sm59465366b.99.2024.05.09.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 03:39:41 -0700 (PDT)
Message-ID: <5408b3fd-3ca9-47b7-83f1-567bea1387a0@redhat.com>
Date: Thu, 9 May 2024 12:39:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] extcon: Add LC824206XA microUSB switch driver
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
References: <20240406140621.18355-1-hdegoede@redhat.com>
 <CAGTfZH1_-x+Z5+t=GCrJ+uEsuV2DPm9m+sKFYDXXXFprAVXekA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAGTfZH1_-x+Z5+t=GCrJ+uEsuV2DPm9m+sKFYDXXXFprAVXekA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/8/24 5:21 PM, Chanwoo Choi wrote:
> On Sat, Apr 6, 2024 at 11:07 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Add a new driver for the ON Semiconductor LC824206XA microUSB switch and
>> accessory detector chip.
>>
>> ON Semiconductor has an "Advance Information" datasheet available
>> (ENA2222-D.PDF), but no full datasheet. So there is no documentation
>> available for the registers.
>>
>> This driver is based on the register info from the extcon-fsa9285.c driver,
>> from the Lollipop Android sources for the Lenovo Yoga Tablet 2 (Pro)
>> 830 / 1050 / 1380 models. Note despite the name this is actually a driver
>> for the LC824206XA not the FSA9285.
>>
>> This has only been tested on a Lenovo Yoga Tablet 2 Pro 1380 and
>> using the driver on other setups may require additional work.
>>
>> So far this driver is only used on x86/ACPI (non devicetree) devs.
>> Therefor there is no devicetree bindings documentation for this driver's
>> "onnn,enable-miclr-for-dcp" property since this is not used in actual
>> devicetree files and the dt bindings maintainers have requested properties
>> with no actual dt users to _not_ be added to the dt bindings.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

<snip>

> Firstly, I'm sorry for late reply.
> 
> When I check the patch with checkpatch script, there are following warnings.
> Could you please fix it?

Weird, I normally always run checkpatch myself before submitting
I must have forgotten that this time.

I'll submit a new version addressing the checkpatch issues.

Regards,

Hans



> 
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 11, in <module>
>     import git
> ModuleNotFoundError: No module named 'git'
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #71:
> new file mode 100644
> 
> ERROR: trailing whitespace
> #241: FILE: drivers/extcon/extcon-lc824206xa.c:166:
> +^I$
> 
> ERROR: code indent should use tabs where possible
> #322: FILE: drivers/extcon/extcon-lc824206xa.c:247:
> +        struct lc824206xa_data *data = container_of(work, struct
> lc824206xa_data, work);$
> 
> WARNING: please, no spaces at the start of a line
> #322: FILE: drivers/extcon/extcon-lc824206xa.c:247:
> +        struct lc824206xa_data *data = container_of(work, struct
> lc824206xa_data, work);$
> 
> ERROR: code indent should use tabs where possible
> #323: FILE: drivers/extcon/extcon-lc824206xa.c:248:
> +        bool vbus_boost_enable = false;$
> 
> WARNING: please, no spaces at the start of a line
> #323: FILE: drivers/extcon/extcon-lc824206xa.c:248:
> +        bool vbus_boost_enable = false;$
> 
> ERROR: code indent should use tabs where possible
> #324: FILE: drivers/extcon/extcon-lc824206xa.c:249:
> +        int status, id;$
> 
> WARNING: please, no spaces at the start of a line
> #324: FILE: drivers/extcon/extcon-lc824206xa.c:249:
> +        int status, id;$
> 
> ERROR: code indent should use tabs where possible
> #326: FILE: drivers/extcon/extcon-lc824206xa.c:251:
> +        status = lc824206xa_read_reg(data, REG_STATUS);$
> 
> WARNING: please, no spaces at the start of a line
> #326: FILE: drivers/extcon/extcon-lc824206xa.c:251:
> +        status = lc824206xa_read_reg(data, REG_STATUS);$
> 
> ERROR: code indent should use tabs where possible
> #327: FILE: drivers/extcon/extcon-lc824206xa.c:252:
> +        if (status < 0)$
> 
> WARNING: please, no spaces at the start of a line
> #327: FILE: drivers/extcon/extcon-lc824206xa.c:252:
> +        if (status < 0)$
> 
> ERROR: code indent should use tabs where possible
> #328: FILE: drivers/extcon/extcon-lc824206xa.c:253:
> +        ^Ireturn;$
> 
> WARNING: please, no space before tabs
> #328: FILE: drivers/extcon/extcon-lc824206xa.c:253:
> +        ^Ireturn;$
> 
> WARNING: please, no spaces at the start of a line
> #328: FILE: drivers/extcon/extcon-lc824206xa.c:253:
> +        ^Ireturn;$
> 
> ERROR: trailing whitespace
> #430: FILE: drivers/extcon/extcon-lc824206xa.c:355:
> +^Ischedule_work(&data->work);^I^I$
> 
> ERROR: trailing whitespace
> #553: FILE: drivers/extcon/extcon-lc824206xa.c:478:
> +^Ischedule_work(&data->work);^I^I$
> 
> total: 9 errors, 8 warnings, 524 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> 
> 


