Return-Path: <linux-kernel+bounces-449349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1349F4D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D447A7B80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F01F7595;
	Tue, 17 Dec 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX2pwXfO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863271F7590
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445412; cv=none; b=Ewon0cWvU5NUFFT2TeRRXIdIDQHubn+F+FhA+AWvTi+NFqSaCxKgkN1L1PV/Ogrl0+kmvyihBysvdlyRz0ENfgkrgZ6VmxtxZqtBvN6MUD0NJJI9nN8qvoILXipI1YHthBnrEM7YwG0uiBFM6erUQxP+JflHBguOo76DhRbyMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445412; c=relaxed/simple;
	bh=GEHzuAOCJgvRm9cIDs5L/dZJjYXM+Gu7fX5nDRW9toY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eT/tcCYSHgGDfcZayupziiuVcZ7WjL3YWCK6M6vIcNwz29p6f5wXTyUSgsB8cB1Al7+vFtPibzqn/+VqUdryQHw271a3Af5tsSZcLPcg1Q1NH3DzOVsFhLkT+8NawKRY+dZFwXHTSJSru5A1eMVVaBuEnZb3UzqJNcdwZ2SVNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YX2pwXfO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734445409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSgN4wlXGgdplGkFID7oReLMbww8771UXwgGNzlG4Pg=;
	b=YX2pwXfOAuSZOjFGy5tb0ZeMPhvY6fxGgigXDZn5lmWd0h8loOZC+Z8/cHVK/BKi3Ng3Hr
	GAkfn3Xax4R1F3ZXWdaUCb5KgJ+M9sKt1YcYFi+OF+UPFCQkJHjYXMpkmrE4ZcA97pI9vE
	Cpw2lEFWSEqhgpAe1XePXmdKpWnE2pU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-BeQ4D6uCPbKdEy6KZA79_A-1; Tue, 17 Dec 2024 09:23:26 -0500
X-MC-Unique: BeQ4D6uCPbKdEy6KZA79_A-1
X-Mimecast-MFC-AGG-ID: BeQ4D6uCPbKdEy6KZA79_A
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa698b61931so65188766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445405; x=1735050205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSgN4wlXGgdplGkFID7oReLMbww8771UXwgGNzlG4Pg=;
        b=sWpFDycaZ4vHLfcqcwJ6AB03vlpR5ojQb41mGd0D9dQXv4GtI2hz2lsb7Uqkne9c3q
         C9hVfrgx+fLopc+JP9oVGOr6Y5llojGzcUdkHAKCQ4SiLrfDzNZDaC811fZoWePwg81i
         IMly0uG2X8MXvXUcXxPsZ4QZGxbpfw+EUWB52iCZrxE08WUmAlwrPqmiwVvs2yrusaNN
         N3Pz9a8r86Gu7M4FXVMLXAMK7S9E69p1WFrN556jNA223HfyPGwvf2D39aQES4gWvimc
         msKTsq+uQh39aMbcVX1Bv098QetZbhR4Rc3Uz4I8OjLBvraZUjSkI6Bf/abIxGBNFI/O
         dGCw==
X-Forwarded-Encrypted: i=1; AJvYcCVGYOBUOLTypcmO6A2CU+8sAEU+ECEsvT3t8X3g9QaFkFixvYFzcLpDGNCVZkaFj1wO8EMfpkX9SD2Awd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweycEGB0FN5K18isvo8ymgpq4ZdXq/S+goYC4+wziAo++1AyRH
	01phYAQt2sYsM7NeF52Uty6uqRbC8FeVnw4WC0Tk+LJKsA5IAEEaMg6W3KpvcnNWTeslnCiNvqz
	hOrX6ZgYzJHz2DLQ18Gz2IerjxYiMFfQg3SfuHZdgdcaFq8jCTiWMY0l7/QEjZg==
X-Gm-Gg: ASbGncs9LTfELwaHLRbJyUEY+ArzVCqP9y4G8sPm286mmNMNlIOcuzOxuZPWqGnCu4Z
	LQSPRsLU44bAyp//zVXqtCmELrMEIw5K5QBpDXAoGFedvj64Tz1dI3GBz5TDEQvjnV7Vd3hxN5o
	Nj5blXt9/hKD6bRqXs4Vva97jvRWbS0dT+ye3ZG5fWzy6XUJWLNS/GMc9VUxTmBypLVi8ykbdFG
	Nwcla2VVnqgMzOTCwM5p2qrX6iV+R1SmeVHMPhHc/ftLsocPEau5/f4uA0=
X-Received: by 2002:a17:907:7707:b0:aa6:87e8:1d12 with SMTP id a640c23a62f3a-aab77e7fb68mr1268001966b.45.1734445404881;
        Tue, 17 Dec 2024 06:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8DGKreIgpjW49AEyXqJ0Ih9IIz3vMgcLPmJgEDXCPmvjEcUOf41BnTnq2KWFedarryER+QQ==
X-Received: by 2002:a17:907:7707:b0:aa6:87e8:1d12 with SMTP id a640c23a62f3a-aab77e7fb68mr1267998666b.45.1734445404457;
        Tue, 17 Dec 2024 06:23:24 -0800 (PST)
Received: from [10.87.1.157] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963598c2sm449222966b.96.2024.12.17.06.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 06:23:24 -0800 (PST)
Message-ID: <66897a27-5f81-46fc-898d-682456d7f37f@redhat.com>
Date: Tue, 17 Dec 2024 15:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Joshua Grisham <josh@joshuagrisham.com>
Cc: ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
 platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241216103855.18457-1-josh@joshuagrisham.com>
 <13184052-baf2-4e7d-b8ef-9ba3f34d475a@t-8ch.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <13184052-baf2-4e7d-b8ef-9ba3f34d475a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 16-Dec-24 5:46 PM, Thomas Weißschuh wrote:
> Hi Joshua!
> 
> (disclaimer: I didn't read all the previous reviews)
> 

Disclaimer: I also did not read all of the previous reviews.

<snip>

>> +Parameters
>> +==========
>> +
>> +The driver includes a list of boolean parameters that allow for manually
>> +enabling or disabling various features:
> 
> Can you explain *why* these are configurable? In general the addition of
> kernel parameters is frowned upon.

Ack, Joshua if posssible just remove the kernel module parameters.

We can always add them back later if there is a good reason for them.
removing them later OTOH can be more tricky.

<snip>


>> +.. _settings-attributes:
>> +
>> +Settings Attributes
>> +===================
>> +
>> +Various hardware settings can be controlled by the following sysfs attributes:
>> +
>> +- ``allow_recording`` (allows or blocks usage of built-in camera and microphone)
>> +- ``start_on_lid_open`` (power on automatically when opening the lid)
>> +- ``usb_charge`` (allows USB ports to provide power even when device is off)
> 
> Non-standard sysfs attributes should be avoided where possible.
> Userspace will need bespoke code to handle them.
> This looks like it could be handled by the standard firmware_attributes
> interface.
> This would standardize discovery and usage.

Ack this really feels like firmware-attributes. I would not be surprised
if there are matching BIOS settings and if changing those also changes
the sysfs files and likewise if the sysfs settings persist over reboot.

<snip>

>> +Keyboard hotkey actions (i8042 filter)
>> +======================================
>> +
>> +Controlled by parameter: ``i8042_filter``
>> +
>> +The i8042 filter will swallow the keyboard events for the Fn+F9 hotkey (Multi-
>> +level keyboard backlight toggle) and Fn+F10 hotkey (Allow/block recording
>> +toggle) and instead execute their actions within the driver itself.
>> +
>> +Fn+F9 will cycle through the brightness levels of the keyboard backlight. A
>> +notification will be sent using ``led_classdev_notify_brightness_hw_changed``
>> +so that the userspace can be aware of the change. This mimics the behavior of
>> +other existing devices where the brightness level is cycled internally by the
>> +embedded controller and then reported via a notification.
>> +
>> +Fn+F10 will toggle the value of the "Allow recording" setting.
> 
> Personally I'm not a big fan to implement policy this way in the kernel.
> But others may disagree.

The keyboard backlight cycling ws already discussed and handling this in
the driver is ok.

The allow-recording setting toggle is new to me. So this is changeable
at runtime, interesting.

Joshua above you write this toggle both the microphone mute and
disables the camera?

It would be good to report the camera state to userspace using
a separate input/evdev device which reports SW_CAMERA_LENS_COVER
as discussed here:

https://lore.kernel.org/linux-media/CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com/

the plan is to make that the canonical API to reported "muted"
cameras.

What happens with the camera when recording is disallowed,
dus it drop of the USB bus or does it only produce black
frames ?

It is a bit unexpected that this one button controls both
microphone and camera mute. But given that unique behavior
I guess that handling this in the kernel is probably best.

The alsamixer should send some events for the mic mute/unmute
I hope and we can use SW_CAMERA_LENS_COVER to report the camera
state.

<snip>

>> +static struct platform_driver galaxybook_platform_driver = {
> 
> Could this be a 'struct acpi_driver'?

The use of acpi_driver is deprecated. AFAIK the plan it to
move the remaining ones to platform-drivers and eventually
remove the whole ACPI bus concept turning ACPI companion
nodes into "normal" fwnodes like the current software and
openfirmware fwnodes.

Regards,

Hans





