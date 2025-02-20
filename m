Return-Path: <linux-kernel+bounces-523398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AFFA3D645
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60CF17BCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06631F03FA;
	Thu, 20 Feb 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVNMrGyc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCB1E5B6A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046554; cv=none; b=RNNnjA8KVaxJKbBk1rdV3zWVYDsyTOo+66+yLFGk8xjwY9txrqxmd5tljUtF9IKOQDq9jI8I6CSYgm+2h3glIyubI7Fr3dtk1l+ZyTvO9WXi2NHaEl2W+tyAxZ8JikP2CqrssTr6MdYbZpZKbPkLMfmx+GwrvmoTE/MG8OLhkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046554; c=relaxed/simple;
	bh=9NdHty/qXXHevrqZTlhaGK+GjngNvreBPr3m97uQbS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1201A6pXy6uKxJnLJqR0JYB9N4PidEl3e3oZRPlsBXXfW/+A8ApeQt+gkHwi7QZBwjw2C0oOLMKoak3zJrdX62P+XS1SgSeWJ7EnRLj9D0vqGv+qwFqG4zAZ9rWHgjmeRhZAkwbaypca9swHUpnmMNjuLqDwS44irQPpZwx254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVNMrGyc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740046551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0lOieDFJGuf9n9Z9p1RYtcsNxHaDLi5VEtVsV6J0yw=;
	b=WVNMrGyczXomSmi6VAI1U0PDIZiWrvJHeikJYJEdPka+P7bcmeNY2bxgI4CTdfW9kAhpFJ
	qGHSEQMIY0X4uq4qdYEp6FmUAMBHS/yyIHnJpuaOKHze9SgAQr2u0aTeHLRFBghF4Efy+i
	pAfB1REOAtBqntTF02yQbZqB9xHSHOw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-PN0b9r6qOCidMW-yIS5PaA-1; Thu, 20 Feb 2025 05:15:49 -0500
X-MC-Unique: PN0b9r6qOCidMW-yIS5PaA-1
X-Mimecast-MFC-AGG-ID: PN0b9r6qOCidMW-yIS5PaA_1740046549
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abba896add9so148726366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046548; x=1740651348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0lOieDFJGuf9n9Z9p1RYtcsNxHaDLi5VEtVsV6J0yw=;
        b=H3qyW4Aq4VGaZTvMMWXVLaLaiz0ma/LThkZFP01xNICTwVusLoZO1REFbZMSo5L4QR
         Wlel+GsXJ1bV7wLspWkXx6Ae38YNoh0HVSWv2gbPF9ELhGjYkokK/K8HnjDNN5kOWfpf
         dSeLjmKpxUjWiVeCSJtPLBgQcFrAQvK1Q3v/Bl8ZraUCV3nsrYYR6riN3hWQN/4RpRYh
         siEM9I55ZwLuXI52nN9Ms1JX2g/+Q4OMgXZ2i0m1u4+ENUoKSCfCMPw9O73842x4xG4K
         WBbBbqwF+GTNNmSlvnZA916YJpD+oNmPvG/T+eSGRyDr1Gv+YO9T+T7m+cwigUlHVJPb
         HPpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkKQZZopqIWExgZDPKhtSKq9ZDyWBGlfrdm43fH2CaQzRFvyI4Rd4zOJ7C1/4L6rlFD7MeCEOd4/OS6T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KaCKLCnOhtIuccjOSxlmnItRcNy94StMXUEJXQR9TdN1GZMA
	wEPDa9pX652zRxIUUId9fiZzjoPlxOVyqIHqm4ZB4WIfQ01DO/6uxvQ+S4MKFz7wtwooa+fu08v
	sxA7aurtFVKno0NDawkHEDPxCFxGogF5EJLBCfZr3ooDx419Wnh145xl9ztpoRg==
X-Gm-Gg: ASbGncszRPr/Ix6uDVTACEWJKyaY96n+XBduKc2/0zPaqmOFCrzeNFcnxTOB5oUuWFs
	QWQk8WrteOejVj3UmkFC2xFaE5jzMYUq7BQoBJaUmsa7b8k4qyuhDnBJJ/Tocr3HW+wtbyAezjO
	wQsBMUvq87jNnZ/iQHM7PFgVUTMNK2HZk2OdJkn2kUtgEIL3hE7y94k7qC2cBtj7YjJGIHkoMMd
	4cMeRprVf8maZd1Ndz1ncMJ8gr6LQNDOUEiYIN0inUIPJDCbEohpFNTjEEAhUt44dvRXEJCq9zA
	tiLHrMuJu6eZHnD+hotiILNelRrS6Tt4MwFb0aCrnjJ7wk7zgsNcibUY8qQxi8gfWpvzUlZUo99
	ekZEJCtzKdsW5i6vJ7q/NlRY6CbN6evARAk92AcVmmSRnIac+K0we2bs=
X-Received: by 2002:a17:907:890d:b0:ab7:b589:4f9e with SMTP id a640c23a62f3a-abbf3cb9821mr204653466b.39.1740046548562;
        Thu, 20 Feb 2025 02:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsci5hMHI8bHshKq0WmvJmdBW2u6ItgvalIOqwsQQPyPAwE35l+KG7VmzL+LgVw3fVRYVE0A==
X-Received: by 2002:a17:907:890d:b0:ab7:b589:4f9e with SMTP id a640c23a62f3a-abbf3cb9821mr204650166b.39.1740046548098;
        Thu, 20 Feb 2025 02:15:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8915db0dsm908550666b.145.2025.02.20.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:15:47 -0800 (PST)
Message-ID: <56f42c2e-94e9-4cb8-8046-2b9ef02995e0@redhat.com>
Date: Thu, 20 Feb 2025 11:15:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: Fix LED_OFF brightness race
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>
References: <26a2690e77671cfe687c5614613fbb6f079f7365.1739959820.git.repk@triplefau.lt>
 <e8ab8707-5ed3-44e6-b52b-a1d6131e7c51@redhat.com> <Z7br2g8Rc9Tkcsle@pilgrim>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z7br2g8Rc9Tkcsle@pilgrim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 20-Feb-25 9:46 AM, Remi Pommarel wrote:
> On Wed, Feb 19, 2025 at 12:52:36PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 19-Feb-25 11:41 AM, Remi Pommarel wrote:
>>> While commit fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
>>> successfully forces led_set_brightness() to be called with LED_OFF at
>>> least once when switching from blinking to LED on state so that
>>> hw-blinking can be disabled, another race remains. Indeed in
>>> led_set_brightness(LED_OFF) followed by led_set_brightness(any)
>>> scenario the following CPU scheduling can happen:
>>>
>>>     CPU0                                     CPU1
>>>     ----                                     ----
>>>  set_brightness_delayed() {
>>>    test_and_clear_bit(BRIGHTNESS_OFF)
>>>                                          led_set_brightness(LED_OFF) {
>>>                                            set_bit(BRIGHTNESS_OFF)
>>> 					   queue_work()
>>>                                          }
>>>                                          led_set_brightness(any) {
>>>                                            set_bit(BRIGHTNESS)
>>> 					   queue_work() //already queued
>>>                                          }
>>>    test_and_clear_bit(BRIGHTNESS)
>>>      /* LED set with brightness any */
>>>  }
>>>
>>>  /* From previous CPU1 queue_work() */
>>>  set_brightness_delayed() {
>>>    test_and_clear_bit(BRIGHTNESS_OFF)
>>>      /* LED turned off */
>>>    test_and_clear_bit(BRIGHTNESS)
>>>      /* Clear from previous run, LED remains off */
>>>
>>> In that case the led_set_brightness(LED_OFF)/led_set_brightness(any)
>>> sequence will be effectively executed in reverse order and LED will
>>> remain off.
>>>
>>> With the introduction of commit 32360bf6a5d4 ("leds: Introduce ordered
>>> workqueue for LEDs events instead of system_wq") the race is easier to
>>> trigger as sysfs brightness configuration does not wait for
>>> set_brightness_delayed() work to finish (flush_work() removal).
>>>
>>> Use delayed_set_value to optionnally re-configure brightness after a
>>> LED_OFF. That way a LED state could be configured more that once but
>>> final state will always be as expected.
>>>
>>> Fixes: fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
>>> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>>
>> Thanks, patch looks good to me:
>>
> 
> Actually two additionnal remarks here. The first one is that now more
> than before, delayed_set_value store should be seen before work_flags
> modification on other CPUs. That means that a smp_mb__before_atomic()
> is needed before the two set_bit().
> 
> The second one is that delayed_set_value can be bigger than a single
> byte, so theoretically store tearing can happen and
> set_brightness_delayed_set_brightness() could be called with an invalid
> value. WRITE_ONCE/READ_ONCE could prevent that but because the
> smp_mb__before_atomic() ensures that the "last" delayed_set_value is
> valid I don't mind having very seldom intermediate invalid values.
> 
> So I think a v2 with smp_mb__before_atomic() is needed here, what do you
> think ?

Doing a v2 with smp_mb__before_atomic() sounds good to me.

Regards,

Hans


