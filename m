Return-Path: <linux-kernel+bounces-449431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E259F4EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA15C18820ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B981F707C;
	Tue, 17 Dec 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5qLMCar"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378FF1F7089
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448104; cv=none; b=urHqmmDf/TVEEg7ZPDvOJwMYlBk4ZQAottdD/vSjQzutJoaDiXJDCiK0HpXvW1ofXMjqfFEH/EBwdyOJReAsHPMMJbgxGV2ZsX2aTacTEr3/s2aWEacaP/FHi7Lt4pCxmsONMcF9MKs3p+5cKge8l0Wcbovs5Ra2+4flXphy/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448104; c=relaxed/simple;
	bh=EnOLx/nHKpZaAJE5Zlhn7nWmQRH3Q2HYlAAYXXmpiJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY462TPmh2NLjmJGZu4B5aHzWDyq1ChO9g2aDQwup8BbHoBHshb4pylfB5NAxYwW0LlhFpfCbN5eSTsAsxh23gUw3XU5+cxP1EOL7CWkmbdJy5/S/tzzinViL1gQXP6aRelf4K+tmeMG7v3c8+a041u+FNgh3Tm9NLbOeUqt1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5qLMCar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734448099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7ABiOnpBEGx89PJw5n4fgFhL0VnSY3UoS2smPvphwQ=;
	b=S5qLMCaroKOv72Ui+nrTCrRXB60mhldBWu99hVNLarud+aJgpkhGUGD4cW1yI5j7DBY0TO
	BXPgevqoWyepubYSu6DUXF+pQRrMvH92KpX/vHJ7t8dw9fpIL6hZtuC6BCC7zZcAweIRfb
	6xqT1YYic5rg05fVv8liCtunZWyq3pM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-qNSA0vQRMAmyBOsRM_82hA-1; Tue, 17 Dec 2024 10:08:18 -0500
X-MC-Unique: qNSA0vQRMAmyBOsRM_82hA-1
X-Mimecast-MFC-AGG-ID: qNSA0vQRMAmyBOsRM_82hA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6a1595fdaso431235066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448097; x=1735052897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7ABiOnpBEGx89PJw5n4fgFhL0VnSY3UoS2smPvphwQ=;
        b=k0eaC5WB5n9PNCYMV6kdgNPRVlhfIfaxtJLQ63KxhRAJJkHY+6fGY0wq+RYGQ7w5cJ
         7tByyUG1LIbwH5VoctAMmKO8hc1v8dQ0mqinzS5wGrsBOtAxuQXPZKewvzgJWkNDdV+H
         5Cm1Llmi79c7rQwXiI6WpeMLcRbX39941A/MN8y/W2FR6SYCAXBPMKyfyeph8Y++JQop
         LWWE9GBJT/31ct04i+yYg2iKgF2kgVUZFiu+wXtYRjrbHZN7doGbP9qMNsf7AliGitNb
         apwarNEmLaPGEl1gLmbHAkX4uqqo4XL3D56MfaF3/+esE93iuZ3/aeYdl7z7JWAbwX3O
         7rSg==
X-Forwarded-Encrypted: i=1; AJvYcCWg9/BpmGabzYPHLGaBWq45EzXPFKkyhRcKXjj8YENp/TkxrNXKS5hdAHdwcJQUpt+nxJcA7vG4IO8bRtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1vHTFJQ1QYEl8ykpj3+uusK4rKkwDqiUHRbIr32vjGjmx68K
	7rk2ygXhxaQMOIW0KTd5xB28gRz9/nyJgxuM1fnZOigH1w6/NaDkUPqlNjGzlWHr3O1JmNQJ3KS
	ScG6MtqUln63ht95H52tIBsUfD/1Hxjsk60THeEFPsYkgZ43uSKjImpzgp+1KOg==
X-Gm-Gg: ASbGncsqBlHzHaNefgAHgxtGTF9RWUxdGeFsrPs2tsnhTbuqsJq5sYc7amZM3/O/V3o
	9uwvSsmC0o+2ngoTM0MQEHlmRjRbvZmwmRbNAUBLvHRmsEhDrZML30+dEPucnnpKgW7LhK5JksS
	MuB5SUiaeodqGHTFP3ZGCl7p9RyRLVN/O1etzpdu9mcspuihGO9Vbfwi3igZP4buChAHCcXINif
	CitMxhaW6wl504ftrSUvpPmP3Ho8mNpWUP8JXuMIvLYEqSkggGqb/70vEpbXRLS
X-Received: by 2002:a17:907:2d26:b0:aa6:691f:20a9 with SMTP id a640c23a62f3a-aab778d9db3mr1484536266b.4.1734448096629;
        Tue, 17 Dec 2024 07:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDWHkMPveAxZ0xKYxQGkeagwKHAxrWPUWCyDh6esu0iO6udkUJ+rwK5j9MucJziPskb6Bquw==
X-Received: by 2002:a17:907:2d26:b0:aa6:691f:20a9 with SMTP id a640c23a62f3a-aab778d9db3mr1484531766b.4.1734448096173;
        Tue, 17 Dec 2024 07:08:16 -0800 (PST)
Received: from [192.168.162.203] ([109.36.231.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9639363asm452932366b.169.2024.12.17.07.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:08:15 -0800 (PST)
Message-ID: <1aecf86b-6e3b-4755-8f1f-d3dbc8d13644@redhat.com>
Date: Tue, 17 Dec 2024 16:07:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org, jdelvare@suse.com,
 linux@roeck-us.net, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <53c5075b-1967-45d0-937f-463912dd966d@gmx.de>
 <CAMF+KebYQyN+gkHayAdZZHPU7DbghwpmVQaLFaf0TiBb-CVp7A@mail.gmail.com>
 <44cd9966-e24a-4386-a0cb-20b1022adcee@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <44cd9966-e24a-4386-a0cb-20b1022adcee@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Dec-24 2:41 AM, Armin Wolf wrote:

<snip>

>> Regarding the keycode do you mean that this should send something to
>> the input device via the sparse keymap or that the i8042 filter should
>> emit a key event, or? And/or that it could be handled with a hwdb
>> update in systemd so that this key gets mapped to the right event?
> 
> Please send the input event through the input device with the sparse keymap.
> 
>>
>> Regarding the specific keycode I assume that maybe the appropriate one
>> would be KEY_CAMERA_ACCESS_TOGGLE ? (though I have not seen any OSD
>> notification with this keycode but maybe it was only with older
>> versions of userspace tools I was originally testing this with..).
> 
> Depends, that will happen if recording gets disabled?

Since the driver handles the toggling of recording on/off itself
KEY_CAMERA_ACCESS_TOGGLE should not be used. As mentioned in my
reply to the v3 posting:

"It would be good to report the camera state to userspace using
a separate input/evdev device which reports SW_CAMERA_LENS_COVER
as discussed here:

https://lore.kernel.org/linux-media/CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com/

the plan is to make that the canonical API to reported "muted"
cameras."

Regards,

Hans




