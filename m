Return-Path: <linux-kernel+bounces-383086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB69B1737
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1188E1C20FBF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727291D278C;
	Sat, 26 Oct 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLndzVnr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB881FC3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940359; cv=none; b=ErQ5j/mN5K/jhDJXY4oPL71h9QdA7VdwJGVVdAn+fGQ+/bBNd/2fnun05k43JfrnBsR8knDqlzfE6kTsmdfda8zPPih37kzOGwbbsVlpPzEjRkb5IMh3+bRh4aMjf/nxLWij4lfFSo7Cpd5X2A4yftantC1nWSmBZOVPzbAlERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940359; c=relaxed/simple;
	bh=zS7mj7hdjCBvOTVAbvWesFfTrKGcV4fUeLW7KN64+9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDlGLsl1XfA9/tIkQ5H+thJ04p88CeO+hR4PtVlXMgpVtlJifoUYoskn8x7lmAgfy38THCgPB8MRp1svZE/o0rILRLvI6d38fZrEUheePlo4d7fauFrrMRKSFE8O76+Ha1JEjsyp5L/o94/hHrZvM6loOrKqp6h2STTbqiFRG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLndzVnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729940355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBSV0C3arTErZVTFPrG+KchoTJoeLyT57cb5GKLGcMM=;
	b=hLndzVnrHodyqlpmQ3Xw8z1j1j0rU10t84E4ZF2d3B1GBpU+n1Ho58otdkkxpeebUZHFug
	IE6KX69ixqYNx1cP+7Nz5tEYffztCe1oYxdT7n5YXZSfjfeLHpCswEyEfJEJWiyd1YR3Zl
	G8wX3Z1lJtOjDJZ0hL0IkohSlGIEsac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-fUbJJxorNHyzFWXqnZ5xcQ-1; Sat, 26 Oct 2024 06:59:14 -0400
X-MC-Unique: fUbJJxorNHyzFWXqnZ5xcQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a22a62e80so203921866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729940353; x=1730545153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBSV0C3arTErZVTFPrG+KchoTJoeLyT57cb5GKLGcMM=;
        b=lQXwoBGqFupu8QTqU0E1y3j/UgBJYupLUJRf9ssGbFw08w/inFOIcKdmveqfCwFSgS
         1/RtrQ4mCr+vcu+61pX5HG+3kbwsU0PHkqxKLElysPPxJr3O48soXBnNN+QU/v2jbsuw
         s9VuXkeejRH5jEipNfB2V9mmk9WO8QC9LknLHSa30Ezzk/c0XOn7XPkBAZBfYdmDZSBS
         xWbs/SYjp7R+AMlu/YRn1w9zUVqKC00VwBVJwbLf1pE/rJ0iyue43m4dxeCm5qjrWHYO
         g18UiDrOuBlSZhB3h5GfS/7EG2KuRIhXDnoostixOV4kcytPnzMrIzRysm5aVNspE00z
         WwVA==
X-Forwarded-Encrypted: i=1; AJvYcCWkI/D2ZVzQGcCB8Pyk1ZAzSlyznhoyqN5uQorvWyG/Tlb9WJWxsBUnvsVxNVpfrX2BLFS5yJrBIMNl9jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQzIZkJI6+LZ+YAhafcE9KPP51JLRP/fcu5ix1x5R+yxOJZx9
	j8TkHfcyX3ggnUB1ya7ypyuVhTdzArpBV0xay6jILhq1qhVIZqPw+pWm0Y2gEYyqOY1gxRSm9yR
	0e/5QOi/TnNSQ0Fx6K43qO7mXt/GR2yVPGg6P0zkcKR+rEL0B+u+WVks/S028Tg==
X-Received: by 2002:a17:906:c112:b0:a99:f71a:4305 with SMTP id a640c23a62f3a-a9de5ce4681mr208608066b.18.1729940352893;
        Sat, 26 Oct 2024 03:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ay4nTZp7eDBsuOki0emQ4am01SGr7qGcwjNI9r5JJ1uCWFVPr1Sne91sB/OYqgWbkxF+nQ==
X-Received: by 2002:a17:906:c112:b0:a99:f71a:4305 with SMTP id a640c23a62f3a-a9de5ce4681mr208606266b.18.1729940352374;
        Sat, 26 Oct 2024 03:59:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298dfcsm162711166b.127.2024.10.26.03.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:59:11 -0700 (PDT)
Message-ID: <5310edec-7f18-48f8-b733-145fec39d0aa@redhat.com>
Date: Sat, 26 Oct 2024 12:59:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: Fix inconsistent use of
 thermal policies
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>, Armin Wolf <W_Armin@gmx.de>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
 srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 Michael@phoronix.com, casey.g.bowman@intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025191514.15032-1-W_Armin@gmx.de>
 <20241025191514.15032-3-W_Armin@gmx.de> <ZxzIMsffFj2lvScb@laptop>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZxzIMsffFj2lvScb@laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Oct-24 12:45 PM, Mohamed Ghanmi wrote:
> On Fri, Oct 25, 2024 at 09:15:14PM +0200, Armin Wolf wrote:
>> When changing the thermal policy using the platform profile API,
>> a Vivobook thermal policy is stored in throttle_thermal_policy_mode.
>>
>> However everywhere else a normal thermal policy is stored inside this
>> variable, potentially confusing the platform profile.
>>
>> Fix this by always storing normal thermal policy values inside
>> throttle_thermal_policy_mode and only do the conversion when writing
>> the thermal policy to hardware.
>>
>> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>  drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
>>  1 file changed, 21 insertions(+), 43 deletions(-)
> 
> the original patch that i submitted did actually have the remapping
> of the different fan profiles in the throttle_thermal_policy_write() methods 
> because it was the cleaner solution [1]. however after having a discussion with luke, 
> he shared that he might be planning to remove the throttle_thermal_policy sysfs interface 
> in favour of platform_profiles [2] because of a refactoring he had been working on.
> 
> currently to control fan profiles through this driver you could use
> either /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
> (redundant and might get removed in the future) or through platform profiles which is the
> better way of doing things.
> 
> for the reasons mentionned above, I decided to keep
> throttle_therma_policy_write() unchanged and to move the remapping logic
> to the asus_wmi_platform_profile_set(). this adopts the approach of
> having a logical mapping stored in asus_wmi struct that has to be
> converted to a physical mapping whenever needed [3].
> 
> so, if luke thinks that this won't cause any merge conflicts with his
> work [4] then i see no problem with this approach even though it might cause an
> order change when calling throttle_thermal_policy_switch_next()

Talking about throttle_thermal_policy_switch_next() we also
have platform_profile_cycle() and since asus-wmi supports
platform-profiles now I'm wondering if it would not be better
to simply completely drop throttle_thermal_policy_switch_next()
and call platform_profile_cycle() instead?

This will also keep the cycle order the same for "normal" vs
vivo even after Armin's patch.

Anyways I'll go and apply patch 1/2 to pdx86/fixes since that one is
obviously correct and fixes th Lunar Lake performance issues.

And we can keep discussing what to do wrt 2/2 and maybe also drop
throttle_thermal_policy_switch_next() if favor of
platform_profile_cycle().

Regards,

Hans






> 
> Best Regards,
> Mohamed G.
> 
> Link: https://lore.kernel.org/platform-driver-x86/20240421194320.48258-2-mohamed.ghanmi@supcom.tn/ # [1]
> Link: https://lore.kernel.org/platform-driver-x86/4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com/ # [2]
> Link: https://lore.kernel.org/platform-driver-x86/ZnlEuiP4Dgqpf51C@laptop/ # [3]
> Link: https://lore.kernel.org/platform-driver-x86/20240930000046.51388-1-luke@ljones.dev/ # [4] 
> 


