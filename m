Return-Path: <linux-kernel+bounces-265598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B093F386
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EB21F220FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B551459E1;
	Mon, 29 Jul 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuzR17EQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88A14532C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251061; cv=none; b=kTJginbtxD9UV1BpuAEnn9sSXlUsOu4bp96Mne16yOoHMAZ9K+KU8m+9CIe1KkeX+BeXQZkDAcRhZzh/Jp255D1KJSI+5NrjKGwaHG3pb2+3PHDiyjTgqdH2zMRfEps49WHJCzcMealg9/YuDgFPU4oGncWkEiJEUHmgyqwzdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251061; c=relaxed/simple;
	bh=zJqgfzerxCxnJG4FqmGJw2xd1wgRmc3UxOf8LYT91sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc8Wa5Ruv2WUqUtchPyoLP5fe2z7Wh+s6Fu1G7lQrilDIeNrfrMphVQcG6AxP5l+OzpSwDkCNUIdHVmUhQuSOoZ7YFJ42osLnU4BdAg0SnWgsv1XXZnRjQiSPMWH5eMm3QnTcYIzAanQxWm7dJr8jj3kuosgOoZQlzEd1nZArkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuzR17EQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722251059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVaVQKI8NcPD9cu89SoPrCy8KmYHM7i6u29K02/jUSg=;
	b=JuzR17EQ1hWiaekUB1GIQVIx2vlNQsB5Du9n5Gw37TTRoaABzHWNvtKuHrsi+Chm1BzVUG
	lomPa4Z6HL3YbU6wqLTwHKHIJ0K6dRcN4vO+77AEbPqjViifRqhiFG7apNqSiOFwwNQQmC
	8rVkw96HlLvNlYy1m8hMzoDg/D50lko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-BDpzXIBgNZO8qi1Ml8T_7g-1; Mon, 29 Jul 2024 07:04:17 -0400
X-MC-Unique: BDpzXIBgNZO8qi1Ml8T_7g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428076fef5dso16414025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251056; x=1722855856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVaVQKI8NcPD9cu89SoPrCy8KmYHM7i6u29K02/jUSg=;
        b=EOK98kJCoQD++gPVwuKPEAXhV881JkQyKZ3Sy5JLdCdTHBIc5r4qJ7DVsGLLJFe11s
         n3wjz34PTR3wwyNveY9IGTHOtjNtXslbwuHcE/hYJ/nsoQoGank380UXBmKu3iso09Lw
         5y5HKvyNrCTZmxbFOPPLFiBLo80LbKIbKEiyDFy7oUUEeNwhOGpFZQ9PDbIEdeomkOBU
         RQqQZfQYgR6PmZ7E1wuqwkng01MyU8zyXEUsFBetwe7v3l+CTDaVvHfgObcBm4W504j+
         r3oslwE3P+2GZzSs6jy2n6QETC1Hi74RCM7XFCOzBfByy2tzkp9B37V3lQM1txW7QCOB
         rEoA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLdlxFWvv/ams7q8xQ0Dzy4L1bEd2ItyXFWTIddPlCjNV7ERPPSZp/AZSpbKSOtoTIhmEoyJmT0/P0BUOgBaMwmKbW4owaCTVzbcg
X-Gm-Message-State: AOJu0Yyg/DbK7cpdWMl9tlYK36TO1f1DAvwXFIJ0jf3ULM3RzYKnYFVl
	yUoiUXoBUfRgM9sE6UEx/Ktiw1VwE221hp+vgAfr90S+6gYgKqkz7c5IKx7wtpfJdRsrwpAdOg2
	IrHsn+8+9MJ4Xa73mdrYccHcxKDI5W1z/yYbuVoCeHjnPqEn7MIy/YTUes256EA==
X-Received: by 2002:a05:600c:6dce:b0:427:985b:178b with SMTP id 5b1f17b1804b1-42811d871a4mr47226325e9.16.1722251056556;
        Mon, 29 Jul 2024 04:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOqoH2AdbLXw65Qsx4bJ6kjZBwBEY63RQDjum9WymwPlvWVzy6NDSUWvcQuN8AVekA6yXu9w==
X-Received: by 2002:a05:600c:6dce:b0:427:985b:178b with SMTP id 5b1f17b1804b1-42811d871a4mr47226075e9.16.1722251056179;
        Mon, 29 Jul 2024 04:04:16 -0700 (PDT)
Received: from [172.18.228.53] (ip-185-104-138-47.ptr.icomera.net. [185.104.138.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9413501sm220322735e9.43.2024.07.29.04.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 04:04:15 -0700 (PDT)
Message-ID: <2eb64562-b530-4b6e-9a7e-09e693265b98@redhat.com>
Date: Mon, 29 Jul 2024 13:04:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on Dell
 Venue 11 Pro 7140
To: Kostadin Stoilov <kmstoilov@gmail.com>
Cc: En-Wei Wu <en-wei.wu@canonical.com>, acelan.kao@canonical.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722083658.54518-1-en-wei.wu@canonical.com>
 <7b7b4d84-c4b0-4a37-ab1d-4b1266851b32@redhat.com>
 <CA++f7SgSv9xr9BGP5Y537bkVduKL1pHgYwZ63Cr4MwW_erhQJw@mail.gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CA++f7SgSv9xr9BGP5Y537bkVduKL1pHgYwZ63Cr4MwW_erhQJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kostadin,

On 7/25/24 8:26 PM, Kostadin Stoilov wrote:
> Hi Hans,
> 
> I tested a kernel built by En-Wei with your patch and I can confirm that it resolves the issue. I tried several connect/disconnect suspend/resume cycles.
> 
> The kernel bug messages are not observed and the system suspend/resumes/powers off successfully.
> 
> The dmesg log from the test run can be found here:
> https://launchpadlibrarian.net/740661223/6.10-maintainer-dmesg.txt <https://launchpadlibrarian.net/740661223/6.10-maintainer-dmesg.txt>

Thank you for testing. I've now done an official submission of this patch upstream:

https://lore.kernel.org/platform-driver-x86/20240729110030.8016-1-hdegoede@redhat.com/

This should be included in a fixes pull-req for 6.11 soon-ish and then get backported to various
stable kernel series.

Regards.

Hans


> On Mon, 22 Jul 2024 at 12:45, Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi En-Wei,
> 
>     On 7/22/24 10:36 AM, En-Wei Wu wrote:
>     > On a Dell Venue 7140 tablet with the keyboard/touchpad/battery dock, when
>     > disconnecting the dock there is a kernel bug:
>     >
>     > BUG: kernel NULL pointer dereference, address: 0000000000000018
>     >
>     > And this causes the following things not to work:
>     > 1. Suspend to idle - the system simply hangs
>     > 2. Poweroff normally (the only way is forcing it via long press the power button)
>     > 3. USB ports: both the USB port on the tablet and also plugging in the keyboard again
>     >
>     > The error message above (plus some crash dump) isn't so useful for debugging, but we
>     > have noticed that there is a debug message shown before the crash dump:
>     >
>     > intel-vbtn INT33D6:00: Registering Intel Virtual Switches input-dev after receiving
>     > a switch event
>     >
>     > The messages above is shown right after the dock is disconnected, and the message implies:
>     >
>     > We failed to set the priv->has_switches to true in the probe function since the
>     > Dell Venue 11 Pro 7140 is not shown in the dmi_switches_allow_list, and this causes a problem
>     > that no input_register_device() on the switch device is called. Afterward, When a user
>     > disconnects the dock, intel-vbtn receives the ACPI event and finally find that there is a
>     > switch out there. So intel-vbtn starts to register the switch device, which may be a dangerous
>     > behavior since there might be some device-related objects/structs that has been freed (due to
>     > the disconnection of the dock).
>     >
>     > To solve this problem from the root cause, simply add the Dell Venue 11 pro 7140 to the
>     > dmi_switches_allow_list.
>     > (The Dell Venue 11 Pro 7140 is a 2-in-1 model that has chassis-type "Portable".)
>     >
>     > BugLink: https://bugs.launchpad.net/bugs/2073001 <https://bugs.launchpad.net/bugs/2073001>
>     >
>     > Fixes: 8169bd3e6e19 ("platform/x86: intel-vbtn: Switch to an allow-list
>     > for SW_TABLET_MODE reporting")
>     > Reported-by: Kostadin Stoilov <kmstoilov@gmail.com <mailto:kmstoilov@gmail.com>>
>     > Tested-by: Kostadin Stoilov <kmstoilov@gmail.com <mailto:kmstoilov@gmail.com>>
>     > Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com <mailto:en-wei.wu@canonical.com>>
> 
>     Thank you for your patch. Looking at the logs from the launchpad bug I noticed that
> 
>     intel-vbtn INT33D6:00: Registering Intel Virtual Switches input-dev after receiving a switch event
> 
>     is reported in the logs twice. Which strongly suggests that the intel-vbtn notify_handler()
>     function is racing with itself.
> 
>     In the past ACPI notify handlers could never run more then once (at the same time)
>     but since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on
>     all CPUs") ACPI notify handlers like the intel-vbtn notify_handler() may
>     run on multiple CPU cores racing with themselves.
> 
>     I believe that this is the real problem here. I have attached a patch which should
>     fix this. Can you build a test-kernel with this patch instead of your patch and
>     ask the reported of: https://bugs.launchpad.net/bugs/2073001 <https://bugs.launchpad.net/bugs/2073001>
> 
>     To test a kernel with the attached patch (and without your patch) to confirm
>     that this fixes it in a more generic manner ?
> 
>     Regards,
> 
>     Hans
> 
> 
> 
> 
> 
>     > ---
>     >  drivers/platform/x86/intel/vbtn.c | 6 ++++++
>     >  1 file changed, 6 insertions(+)
>     >
>     > diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
>     > index 9b7ce03ba085..46d07d3cd34b 100644
>     > --- a/drivers/platform/x86/intel/vbtn.c
>     > +++ b/drivers/platform/x86/intel/vbtn.c
>     > @@ -235,6 +235,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
>     >                       DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>     >               },
>     >       },
>     > +     {
>     > +             .matches = {
>     > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>     > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7140"),
>     > +             },
>     > +     },
>     >       {
>     >               .matches = {
>     >                       DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> 


