Return-Path: <linux-kernel+bounces-383051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789169B169E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BCD1C210ED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8491C6F73;
	Sat, 26 Oct 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACuWCGul"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF7217F3F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729936443; cv=none; b=f3N4dQRpSFTeMEO/HdBnm75LOiPEqhvr+SiavHaiyOdHhrLfpKlBdd/j/xrOea4WewsToxARVWB7DjBMYdPev0PN0x/hviVuMWXXoxeLLejHuAAyuTUacMctwCaxZvP73y3FMas16TvBkyrgVDgbn4JX2AEMwWZ3b/2xFlh9yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729936443; c=relaxed/simple;
	bh=tdykJwDjjUc6RlmYBwAgbKMSsCDo4jhYpFXAs9pnO3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ic3JEdQfetTi0BRHfnPoFco4lx6EovVBrD/6BM5CCxDU+9G3bpg5ZKopmSnui2mSsS0Wbf+K+WqSVofpLdTHhi/FxOaZNFu5jHcpTieqoNp7Us75tfimhe4xmyAaYRFAJNRJL5cf0peCXxZEhos9aUo8gnIjVvhc3UkDXpeBdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACuWCGul; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729936438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnjqp6uY2F6lf7q1X7RSsH54Ybe3GgWi0/vIEHoY1bA=;
	b=ACuWCGulG/j6u4VR4bDJ4JtOh9TErWD7b3D7NoPqTAM334qZKHoQ9yOB+Kr2+e8SaCie9Q
	w39pZ0tKxPys8Zp0ZAVNpOMUBDWTyjd74scR7KvE2J0Ga1bsHqo6BH04EgMVlNuSxhImR2
	Ps0ZozaxIYRUS0qQYe6V++dwCL+jYkA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-YlHU6gibPpm5zMdtdZMm4w-1; Sat, 26 Oct 2024 05:53:57 -0400
X-MC-Unique: YlHU6gibPpm5zMdtdZMm4w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c9452d6321so1944839a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 02:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729936436; x=1730541236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mnjqp6uY2F6lf7q1X7RSsH54Ybe3GgWi0/vIEHoY1bA=;
        b=hnDnZ720vTWW9Kss9msbzmVVG8hhzP5fhWMOuJCxzf7ePhlk7Z180ZRUsLWBk5tFqL
         1n6TJzTGMogfwKPAz4OpOuuroI0XziZD6Y/fQUngtlfskKz09hecZxujeHdF29QsJBjO
         NQ1skukzd8y4jyTVq3cHfxpFu7aBl4A1tjOLQa/rMLlpFJerjcmiBk6oONjHtqoTh9Rd
         nM/0xvQdIZBwDQ71nNGJTn8YG83GgZqNQewXcqUnOLykLrCif24rbn48c9ZsFmpCBjU7
         oqXO+tKFFRzmVuCf9Ey9MV7sZIULEHBqdeHR+XE5nM6zM22dFS9gJJrs7mox+exEoIFi
         v7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6BVFy3M/dBdHcT0JBWdO+V2BTqpZdkddv1tRTNFeF71svjYw4J+Yd3BLnYd4eN63OWi1gKASWObjLJXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZw4skEVcmFENv/vCZ+DZla+xeZRx3iR23f8q/KNHlLCz0POM
	A1vC3UltIlErq2dcWRt8gRSdf3Vtr5AFEoWchi3Cqe2vVYFM0zYBB5VqCJzuiPSqnwOU5+HyNu8
	RHpWNbFcCbBixnRXe3jym3Fsq7pN/9LWNS8yC5bLs2EP0f7fK010VGDWJOy4J1w==
X-Received: by 2002:a17:907:74b:b0:a99:37f5:de59 with SMTP id a640c23a62f3a-a9de619182amr134740766b.53.1729936435660;
        Sat, 26 Oct 2024 02:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQqMOL1ZFWcf453dgqb7oobR+mCmwgih8sbvKP1B1FGHkeWNTgKvWr3jCjIjQi4ZR9SKDWng==
X-Received: by 2002:a17:907:74b:b0:a99:37f5:de59 with SMTP id a640c23a62f3a-a9de619182amr134738566b.53.1729936435185;
        Sat, 26 Oct 2024 02:53:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30c7b5a9sm159784166b.171.2024.10.26.02.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 02:53:54 -0700 (PDT)
Message-ID: <0156ec27-e076-4c6e-9bad-b7d64bb08a59@redhat.com>
Date: Sat, 26 Oct 2024 11:53:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: asus-wmi: Fix thermal profile handling
To: Armin Wolf <W_Armin@gmx.de>, corentin.chary@gmail.com, luke@ljones.dev,
 mohamed.ghanmi@supcom.tn
Cc: srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 Michael@phoronix.com, casey.g.bowman@intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025191514.15032-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025191514.15032-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 25-Oct-24 9:15 PM, Armin Wolf wrote:
> When support for Vivobook fan profiles was added, two mistakes where
> made:
> 
> 1. throttle_thermal_policy_set_default() was not called anymore during
> probe.
> 
> 2. The new thermal profiles where used inconsistently.
> 
> This patch series aims to fix both issues. Compile-tested only.
> 
> Armin Wolf (2):
>   platform/x86: asus-wmi: Fix thermal profile initialization
>   platform/x86: asus-wmi: Fix inconsistent use of thermal policies

Taking another look at the vivobook stuff because of this series this
pre-existing code stands out to me:

static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
{
        struct fan_curve_data *curves;
        u8 buf[FAN_CURVE_BUF_LEN];
        int err, fan_idx;
        u8 mode = 0;

        if (asus->throttle_thermal_policy_dev)
                mode = asus->throttle_thermal_policy_mode;
        /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
        if (mode == 2)
                mode = 1;
        else if (mode == 1)
                mode = 2;


Since the vivobook has silent and overboost swapped I wonder if we should
do this on vivobook to ?

Also note that patch 2/2 of this series impacts this code too. Until
now we were storing the swapped vivobook values in asus->throttle_thermal_policy_dev
and then here we are swapping them a second time, in essence using unswapped
non vivobook values here due to the double swapping.

Where as after Armin's changes from 2/2 we now store unswapped standard
asus laptop values in asus->throttle_thermal_policy_dev and swap them
here, using the same mode values as with normal asus laptops on vivobooks
now ( mode is swapped from non vivo throttle_thermal_policy_dev values).

Does anyone have any insight what we should do here ?

Regards,

Hans




