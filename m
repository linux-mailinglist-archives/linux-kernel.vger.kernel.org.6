Return-Path: <linux-kernel+bounces-573619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4BA6D9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BF13AA714
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C825E82C;
	Mon, 24 Mar 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Omf8HnuO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30B25E811
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818219; cv=none; b=Bhyu7qfLvdOSzpcbWs6qJOFfh8KrZ0+6x2J7fbt1DOGbihB6i843OkyXF+9VM8FBMbydlZI36ma05oDjFHg1RmJD0gsNC/CAcYumzPEHgBX9yqquwRvmmtnYAiA12aocO2RXbZf+QFGU0vx7epJqNfSHRJk/zH21EmpbGfCmAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818219; c=relaxed/simple;
	bh=sX6WYXci9m5NJKMn7fA1u3SQ8tQ0O96LPbAPnaiXcHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAL1EsjforIKKW69bWpD/zskWkmISmeNfsIdWEWWEKoCt0HQdjXLTBKL259Xlx/BGdqRz34NYfNMvD5Hl530qhJ3/2JVSw8CTZU87vHd6uXWqD8GA/V7oW6v7hEIXS/jouNXXA9RkS+hT3F4F4nTk+FU6cJ9Jk9UkgJi8HeWXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Omf8HnuO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742818215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nqBOVDIhTBnh8jh/rMnl7yfv2kJ/jYX8Kgsibw8Kxc=;
	b=Omf8HnuOyYKGrlyw893QIKJ5+B4lF/WBClM2iS9wZO1ROfbvb+rt2rjM8k0ubUIkEZAplY
	nSkEWI8TQKXyrPCaWxUyQS2fvwvfnCNz7PBxPI2dnq9iGslqR11baa2QkAWTX1SD9Jyx9h
	09LMlEUUNkw4xTOC+/inwZRzF7YKzQ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ZUegp25tPQOozW8ecfbPAw-1; Mon, 24 Mar 2025 08:10:14 -0400
X-MC-Unique: ZUegp25tPQOozW8ecfbPAw-1
X-Mimecast-MFC-AGG-ID: ZUegp25tPQOozW8ecfbPAw_1742818213
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3a9c3a8f7so432799666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818213; x=1743423013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nqBOVDIhTBnh8jh/rMnl7yfv2kJ/jYX8Kgsibw8Kxc=;
        b=B7jNfk4heX+TM37tlLZk1eLZwg7zWdcvjZ14mkjiydHtXcUZ+E8DAgHtiR+qhfvBft
         s1Yv3DNjMzKITP2sri2vJlLeAaX8H0xaaYlTWAGW2uSJKgfzw8UVo39zmpw3X2vtUX3U
         odjh8EOvUIfwXl6SGpELH7UZBuyoSKs8TEOp2uxyHoIlBmtGtip2k06mNPzeEz7ZC2Vz
         fWzb5KkfpNzXH7CZB6Rmkk3qCZKLpRYGwt4p6eGceVrM50il2JIYUlysR7cznNI8c3/K
         Nk+tMpDREIs5qpP4e3Upm6FsSuZ1SuXxrazZ+Q0zIOs6Amc5Ry9UgWn/1X+Nw1lACmz/
         1fPA==
X-Gm-Message-State: AOJu0Yw7gEfTbrmReGJmEvDiZRSBhaSPgP6sTeLePbp1Y8+fg3iwN+cQ
	hzaSidscijGpoifZvOSpiiTvATsqBDw5s9DXTNFwQVCm9tHQ9K4o+v3iA7z53/aSc3Jnre2u5oW
	ZP9PP/lHxQJRNVtq2r3CzYdqaZ1QueKNRU4iOFnH90HOEBUgsVyVgsw11fOXgdA==
X-Gm-Gg: ASbGnctmMWD1LaGCcP+kKZO6o2TUfs8SYgyRELbA0WKNHNnqJWyjj7vja/f3hzf45Gi
	UnMuHT5jXc8pgGucp2CgK/AxVPKtBKaYDJHuwKVJjlj4r21IxjTR1+R4HGJIafgKt2pq11fIK8h
	O5xeq7shbW+EHSvArGLnEi39LwJ3Bq1BTeem2OucWqBldZuNkvAUZyaSFQcR7aXRXEaKCVsi/j2
	hBwB8EIeqSCjJVujuGxg9hb+NrewpFLOgzgFXObaSsDuqn8JhPvOEqgeSLltmrzwCYtw6wdX0a9
	Sd1sZ5GPJ0HdliPJwkQ=
X-Received: by 2002:a17:907:9694:b0:ac4:5ff:cef6 with SMTP id a640c23a62f3a-ac405ffd0f5mr717525666b.31.1742818213246;
        Mon, 24 Mar 2025 05:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgz3PLqoJVIqA3YdGTCcfWS8RjV46kIfynQphC2N1ZVOQL/wploYLzgDJQ24oF86+2An1DfQ==
X-Received: by 2002:a17:907:9694:b0:ac4:5ff:cef6 with SMTP id a640c23a62f3a-ac405ffd0f5mr717521266b.31.1742818212663;
        Mon, 24 Mar 2025 05:10:12 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb64911sm675847266b.93.2025.03.24.05.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:10:12 -0700 (PDT)
Message-ID: <dac78c3d-9ba2-4721-9fb2-06dd2589bc72@redhat.com>
Date: Mon, 24 Mar 2025 13:10:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] HID: asus: hid-asus and asus-wmi backlight
 unification, Z13 QOL improvements
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20250319191320.10092-1-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250319191320.10092-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Antheas,

On 19-Mar-25 20:13, Antheas Kapenekakis wrote:
> This is a three part series that does the following: first, it cleans up
> the hid-asus driver initialization, preventing excess renames and dmesg
> errors on ROG devices. Then, it adds support for the Z13 2025 keyboard,
> by fixing its keyboard to not be stuck in BIOS mode and enabling its fan
> key. Finally, the bigger piece of this series is the unification of the
> backlight controls between hid-asus and asus-wmi.

Thank you for your work on this.

> This requires some context. First, some ROG devices expose both WMI and
> HID controls for RGB. In addition, some ROG devices (such as the Z13)
> have two AURA devices where both have backlight controls (lightbar and
> keyboard). Under Windows, Armoury Crate exposes a single brightness control
> for all Aura devices.
> 
> However, currently in the linux kernel this is not the case, with asus-wmi
> and hid-asus relying on a quirk system to figure out which should control
> the backlight. But what about the other one? There might be silent
> regressions such as part of the RGB of the device not responding properly.
> 
> In the Z13, this is the case, with a race condition causing the lightbar
> to control the asus::kbd_backlight device most of the time, with the
> keyboard being renamed to asus::kbd_backlight_1 and not doing anything
> under KDE controls.
> 
> Here, we should note that most backlight handlers are hardcoded to check
> for backlight once, and for one backlight, during boot, so any other
> solution would require a large rewrite of userspace.

Note that work is actually ongoing to add support for multiple kbd
backlights to upower:

https://gitlab.freedesktop.org/upower/upower/-/merge_requests/258

But that is intended for when there are 2 kbds with a controllable backlight,
e.g. a docked laptop with a gaming kbd with RGB backlight connected to the dock.

Where as here we seem to have 2 controls which ideally should be set to
the same value if I understand things correctly ?

> Even when brightness controls are fixed, we still have the problem of the
> backlight key being on/off when controlled by KDE and 0/33/66/100 when
> the device has a WMI keyboard. Ideally, we would like the 0/33/66/100 to
> be done under hid as well, regardless of whether the backlight of the
> device is controlled by WMI or HID.

Hmm, ideally we want this sort of policy to be in userspace, this sounds
more like it is a keycode problem and we maybe need KEY_KBDILLUMCYCLE next
to the existing KEY_KBDILLUMTOGGLE. For the existing toggle doing on/off
obviously is the correct userspace behavior.

Anyways I can see how Asus is special here and on laptops the cycling is
typically handled by the EC and we have chosen to emulate EC behavior in
the kernel before to keep things consistent amongst models.

Still generally speaking we do prefer to just send keypresses when possible
and let userspace set the policy, but I guess we can make an exception here.

> Therefore, this is what the third part of this series does. It sets up
> asus-wmi to expose accepting listeners for the asus::kbd_backlight device
> and being the one that sets it up. Then, it makes hid-asus devices
> register a listener there, so that all of them are controlled by
> asus::kbd_backlight. Finally, it adds an event handler for keyboard keys,
> so that HID led controls are handled by the kernel instead of userspace.
> This way, even when userspace is not active the key works, and we get the
> desired behavior of 0/33/66/100 across all Aura devices (currently, that
> is keyboards, and embedded devices such as lightbars). This results
> removing the quirk system as well, eliminating a point of failure.

I've taken a quick look at the new API between asus-wmi and asus-hid and
this looks good to me, thank you for your work on this.

Regards,

Hans



